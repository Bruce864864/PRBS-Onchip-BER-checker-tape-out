module csr_regbank (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        cfg_we,
    input  logic        cfg_re,
    input  logic [4:0]  cfg_addr,
    input  logic [31:0] cfg_wdata,
    output logic [31:0] cfg_rdata,

    input  logic        busy,
    input  logic        done,
    input  logic        overflow,
    input  logic        bit_error,
    input  logic        prbs_out,
    input  logic        checker_in,
    input  logic        checker_in_final,
    input  logic        ref_bit,
    input  logic [31:0] error_count,
    input  logic [31:0] total_count,

    output logic        ctrl_enable,
    output logic        mode_select,
    output logic        input_select,
    output logic        inject_error_enable,
    output logic        continuous_mode,
    output logic [14:0] seed_value,
    output logic [31:0] window_cfg,

    output logic        seed_load_pulse,
    output logic        start_pulse,
    output logic        stop_pulse,
    output logic        manual_clear_pulse
);

    logic [31:0] ctrl_reg;
    logic [31:0] seed_reg;
    logic [31:0] window_reg;

    localparam logic [4:0] ADDR_CTRL   = 5'h00;
    localparam logic [4:0] ADDR_SEED   = 5'h04;
    localparam logic [4:0] ADDR_CMD    = 5'h08;
    localparam logic [4:0] ADDR_WINDOW = 5'h0C;
    localparam logic [4:0] ADDR_STATUS = 5'h10;
    localparam logic [4:0] ADDR_ERRCNT = 5'h14;
    localparam logic [4:0] ADDR_TOTCNT = 5'h18;
    localparam logic [4:0] ADDR_DBG    = 5'h1C;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ctrl_reg           <= 32'd0;
            seed_reg           <= 32'd1;
            window_reg         <= 32'd20;
            seed_load_pulse    <= 1'b0;
            start_pulse        <= 1'b0;
            stop_pulse         <= 1'b0;
            manual_clear_pulse <= 1'b0;
        end else begin
            seed_load_pulse    <= 1'b0;
            start_pulse        <= 1'b0;
            stop_pulse         <= 1'b0;
            manual_clear_pulse <= 1'b0;

            if (cfg_we) begin
                case (cfg_addr)
                    ADDR_CTRL: begin
                        ctrl_reg <= cfg_wdata;
                    end
                    ADDR_SEED: begin
                        seed_reg <= cfg_wdata;
                    end
                    ADDR_WINDOW: begin
                        window_reg <= cfg_wdata;
                    end
                    ADDR_CMD: begin
                        seed_load_pulse    <= cfg_wdata[0];
                        manual_clear_pulse <= cfg_wdata[1];
                        start_pulse        <= cfg_wdata[2];
                        stop_pulse         <= cfg_wdata[3];
                    end
                    default: begin
                    end
                endcase
            end
        end
    end

    always_comb begin
        cfg_rdata = 32'd0;
        if (cfg_re) begin
            case (cfg_addr)
                ADDR_CTRL:   cfg_rdata = ctrl_reg;
                ADDR_SEED:   cfg_rdata = seed_reg;
                ADDR_WINDOW: cfg_rdata = window_reg;
                ADDR_STATUS: cfg_rdata = {
                    24'd0,
                    inject_error_enable,
                    input_select,
                    mode_select,
                    bit_error,
                    overflow,
                    done,
                    busy
                };
                ADDR_ERRCNT: cfg_rdata = error_count;
                ADDR_TOTCNT: cfg_rdata = total_count;
                ADDR_DBG:    cfg_rdata = {
                    27'd0,
                    bit_error,
                    ref_bit,
                    checker_in_final,
                    checker_in,
                    prbs_out
                };
                default:     cfg_rdata = 32'd0;
            endcase
        end
    end

    assign ctrl_enable         = ctrl_reg[0];
    assign mode_select         = ctrl_reg[1];
    assign input_select        = ctrl_reg[2];
    assign inject_error_enable = ctrl_reg[3];
    assign continuous_mode     = ctrl_reg[4];
    assign seed_value          = seed_reg[14:0];
    assign window_cfg          = window_reg;

endmodule