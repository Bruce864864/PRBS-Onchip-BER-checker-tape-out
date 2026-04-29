module cfg_serial_if (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        cfg_sclk,
    input  logic        cfg_cs_n,
    input  logic        cfg_mosi,
    output logic        cfg_miso,

    output logic        cfg_we,
    output logic        cfg_re,
    output logic [4:0]  cfg_addr,
    output logic [31:0] cfg_wdata,
    input  logic [31:0] cfg_rdata
);

    // Protocol:
    // 40-bit command, MSB first
    // [39]    rw       (1=write, 0=read)
    // [38:34] addr[4:0]
    // [33:2]  wdata[31:0]
    // [1:0]   reserved
    //
    // This interface is interpreted in clk domain.
    // Therefore cfg_sclk must be much slower than clk in bring-up.

    typedef enum logic [2:0] {
        ST_IDLE         = 3'd0,
        ST_RECV_CMD     = 3'd1,
        ST_WAIT_RDATA   = 3'd2,
        ST_SHIFT_OUT    = 3'd3,
        ST_WAIT_CS_HIGH = 3'd4
    } state_t;

    state_t state_q;

    logic cfg_sclk_meta, cfg_sclk_sync, cfg_sclk_sync_d;
    logic cfg_cs_n_meta, cfg_cs_n_sync, cfg_cs_n_sync_d;
    logic cfg_mosi_meta, cfg_mosi_sync;

    logic sclk_rise;
    logic sclk_fall;
    logic cs_fall;
    logic cs_rise;

    logic [39:0] cmd_shift_q;
    logic [39:0] full_cmd;

    logic [5:0]  rx_bit_cnt_q;

    logic [31:0] rd_shift_q;
    logic [5:0]  tx_bit_cnt_q;

    assign full_cmd = {cmd_shift_q[38:0], cfg_mosi_sync};

    // ------------------------------------------------------------
    // Synchronize asynchronous pad inputs into clk domain
    // ------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cfg_sclk_meta   <= 1'b0;
            cfg_sclk_sync   <= 1'b0;
            cfg_sclk_sync_d <= 1'b0;

            cfg_cs_n_meta   <= 1'b1;
            cfg_cs_n_sync   <= 1'b1;
            cfg_cs_n_sync_d <= 1'b1;

            cfg_mosi_meta   <= 1'b0;
            cfg_mosi_sync   <= 1'b0;
        end else begin
            cfg_sclk_meta   <= cfg_sclk;
            cfg_sclk_sync   <= cfg_sclk_meta;
            cfg_sclk_sync_d <= cfg_sclk_sync;

            cfg_cs_n_meta   <= cfg_cs_n;
            cfg_cs_n_sync   <= cfg_cs_n_meta;
            cfg_cs_n_sync_d <= cfg_cs_n_sync;

            cfg_mosi_meta   <= cfg_mosi;
            cfg_mosi_sync   <= cfg_mosi_meta;
        end
    end

    assign sclk_rise = (cfg_sclk_sync_d == 1'b0) && (cfg_sclk_sync == 1'b1);
    assign sclk_fall = (cfg_sclk_sync_d == 1'b1) && (cfg_sclk_sync == 1'b0);
    assign cs_fall   = (cfg_cs_n_sync_d == 1'b1) && (cfg_cs_n_sync == 1'b0);
    assign cs_rise   = (cfg_cs_n_sync_d == 1'b0) && (cfg_cs_n_sync == 1'b1);

    // ------------------------------------------------------------
    // Main FSM in clk domain
    // ------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q      <= ST_IDLE;

            cfg_we       <= 1'b0;
            cfg_re       <= 1'b0;
            cfg_addr     <= 5'd0;
            cfg_wdata    <= 32'd0;

            cmd_shift_q  <= 40'd0;
            rx_bit_cnt_q <= 6'd0;

            rd_shift_q   <= 32'd0;
            tx_bit_cnt_q <= 6'd0;
        end else begin
            cfg_we <= 1'b0;
            cfg_re <= 1'b0;

            case (state_q)
                ST_IDLE: begin
                    rx_bit_cnt_q <= 6'd0;
                    tx_bit_cnt_q <= 6'd0;

                    if (cs_fall) begin
                        cmd_shift_q <= 40'd0;
                        state_q     <= ST_RECV_CMD;
                    end
                end

                ST_RECV_CMD: begin
                    if (cfg_cs_n_sync) begin
                        state_q <= ST_IDLE;
                    end else if (sclk_rise) begin
                        cmd_shift_q <= full_cmd;

                        if (rx_bit_cnt_q == 6'd39) begin
                            cfg_addr  <= full_cmd[38:34];
                            cfg_wdata <= full_cmd[33:2];

                            if (full_cmd[39]) begin
                                // write
                                cfg_we   <= 1'b1;
                                state_q  <= ST_WAIT_CS_HIGH;
                            end else begin
                                // read request, capture data next clk
                                cfg_re   <= 1'b1;
                                state_q  <= ST_WAIT_RDATA;
                            end
                        end

                        if (rx_bit_cnt_q < 6'd40)
                            rx_bit_cnt_q <= rx_bit_cnt_q + 6'd1;
                    end

                    if (cs_rise) begin
                        state_q <= ST_IDLE;
                    end
                end

                ST_WAIT_RDATA: begin
                    // cfg_rdata is generated from cfg_addr/cfg_re path in clk domain
                    rd_shift_q   <= cfg_rdata;
                    tx_bit_cnt_q <= 6'd0;
                    state_q      <= ST_SHIFT_OUT;
                end

                ST_SHIFT_OUT: begin
                    if (cfg_cs_n_sync) begin
                        state_q <= ST_IDLE;
                    end else if (sclk_fall) begin
                        rd_shift_q <= {rd_shift_q[30:0], 1'b0};

                        if (tx_bit_cnt_q < 6'd31)
                            tx_bit_cnt_q <= tx_bit_cnt_q + 6'd1;
                    end

                    if (cs_rise) begin
                        state_q <= ST_IDLE;
                    end
                end

                ST_WAIT_CS_HIGH: begin
                    if (cfg_cs_n_sync) begin
                        state_q <= ST_IDLE;
                    end
                end

                default: begin
                    state_q <= ST_IDLE;
                end
            endcase
        end
    end

    // MISO is valid during ST_SHIFT_OUT while CS is low.
    // Master should sample while cfg_sclk is high.
    assign cfg_miso = (!cfg_cs_n_sync && (state_q == ST_SHIFT_OUT)) ? rd_shift_q[31] : 1'b0;

endmodule