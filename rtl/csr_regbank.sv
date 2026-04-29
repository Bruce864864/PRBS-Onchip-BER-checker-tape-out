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

    // Existing byte-like addresses are kept unchanged for backward compatibility.
    localparam logic [4:0] ADDR_CTRL          = 5'h00;
    localparam logic [4:0] ADDR_SEED          = 5'h04;
    localparam logic [4:0] ADDR_CMD           = 5'h08;
    localparam logic [4:0] ADDR_WINDOW        = 5'h0C;
    localparam logic [4:0] ADDR_STATUS        = 5'h10;
    localparam logic [4:0] ADDR_ERRCNT        = 5'h14;
    localparam logic [4:0] ADDR_TOTCNT        = 5'h18;
    localparam logic [4:0] ADDR_DBG           = 5'h1C;

    // Added bring-up/debug CSRs.  The serial address field is only 5 bits wide,
    // so these use unused 5-bit addresses instead of 0x20/0x24/... .
    localparam logic [4:0] ADDR_LAST_ERRCNT   = 5'h01;
    localparam logic [4:0] ADDR_LAST_TOTCNT   = 5'h02;
    localparam logic [4:0] ADDR_LAST_STATUS   = 5'h03;
    localparam logic [4:0] ADDR_RUN_COUNT     = 5'h05;
    localparam logic [4:0] ADDR_PASS_COUNT    = 5'h06;
    localparam logic [4:0] ADDR_FAIL_COUNT    = 5'h07;
    localparam logic [4:0] ADDR_FIRST_ERR_IDX = 5'h09;
    localparam logic [4:0] ADDR_STICKY_STATUS = 5'h0A;
    localparam logic [4:0] ADDR_SNAPSHOT0     = 5'h0B;

    logic [31:0] last_errcnt_reg;
    logic [31:0] last_totcnt_reg;
    logic [31:0] last_status_reg;
    logic [31:0] run_count_reg;
    logic [31:0] pass_count_reg;
    logic [31:0] fail_count_reg;
    logic [31:0] first_error_index_reg;
    logic [31:0] snapshot0_reg;

    logic        sticky_done_reg;
    logic        sticky_error_seen_reg;
    logic        sticky_overflow_reg;
    logic        first_error_seen_reg;
    logic        done_d;

    logic        done_rise;
    logic        manual_clear_req;

    assign done_rise        = done && !done_d;
    assign manual_clear_req = cfg_we && (cfg_addr == ADDR_CMD) && cfg_wdata[1];

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ctrl_reg              <= 32'd0;
            seed_reg              <= 32'd1;
            window_reg            <= 32'd20;
            seed_load_pulse       <= 1'b0;
            start_pulse           <= 1'b0;
            stop_pulse            <= 1'b0;
            manual_clear_pulse    <= 1'b0;

            last_errcnt_reg       <= 32'd0;
            last_totcnt_reg       <= 32'd0;
            last_status_reg       <= 32'd0;
            run_count_reg         <= 32'd0;
            pass_count_reg        <= 32'd0;
            fail_count_reg        <= 32'd0;
            first_error_index_reg <= 32'd0;
            snapshot0_reg         <= 32'd0;
            sticky_done_reg       <= 1'b0;
            sticky_error_seen_reg <= 1'b0;
            sticky_overflow_reg   <= 1'b0;
            first_error_seen_reg  <= 1'b0;
            done_d                <= 1'b0;
        end else begin
            done_d             <= done;
            seed_load_pulse    <= 1'b0;
            start_pulse        <= 1'b0;
            stop_pulse         <= 1'b0;
            manual_clear_pulse <= 1'b0;

            if (manual_clear_req) begin
                last_errcnt_reg       <= 32'd0;
                last_totcnt_reg       <= 32'd0;
                last_status_reg       <= 32'd0;
                run_count_reg         <= 32'd0;
                pass_count_reg        <= 32'd0;
                fail_count_reg        <= 32'd0;
                first_error_index_reg <= 32'd0;
                snapshot0_reg         <= 32'd0;
                sticky_done_reg       <= 1'b0;
                sticky_error_seen_reg <= 1'b0;
                sticky_overflow_reg   <= 1'b0;
                first_error_seen_reg  <= 1'b0;
            end

            if (bit_error) begin
                sticky_error_seen_reg <= 1'b1;
                if (!first_error_seen_reg) begin
                    first_error_seen_reg  <= 1'b1;
                    first_error_index_reg <= total_count;
                end
            end

            if (overflow) begin
                sticky_overflow_reg <= 1'b1;
            end

            if (done_rise) begin
                sticky_done_reg <= 1'b1;
                last_errcnt_reg <= error_count;
                last_totcnt_reg <= total_count;
                last_status_reg <= {
                    20'd0,
                    continuous_mode,
                    inject_error_enable,
                    input_select,
                    mode_select,
                    sticky_error_seen_reg | bit_error,
                    overflow,
                    done,
                    busy
                };
                snapshot0_reg <= {
                    24'd0,
                    first_error_seen_reg | bit_error,
                    sticky_overflow_reg | overflow,
                    sticky_error_seen_reg | bit_error,
                    sticky_done_reg | done,
                    ref_bit,
                    checker_in_final,
                    checker_in,
                    prbs_out
                };

                if (error_count == 32'd0) begin
                    pass_count_reg <= pass_count_reg + 32'd1;
                end else begin
                    fail_count_reg <= fail_count_reg + 32'd1;
                end
            end

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

                        if (cfg_wdata[2]) begin
                            run_count_reg         <= run_count_reg + 32'd1;
                            sticky_done_reg       <= 1'b0;
                            sticky_error_seen_reg <= 1'b0;
                            sticky_overflow_reg   <= 1'b0;
                            first_error_seen_reg  <= 1'b0;
                            first_error_index_reg <= 32'd0;
                        end
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
                ADDR_CTRL:          cfg_rdata = ctrl_reg;
                ADDR_SEED:          cfg_rdata = seed_reg;
                ADDR_WINDOW:        cfg_rdata = window_reg;
                ADDR_STATUS:        cfg_rdata = {
                    20'd0,
                    first_error_seen_reg,
                    sticky_overflow_reg,
                    sticky_error_seen_reg,
                    sticky_done_reg,
                    inject_error_enable,
                    input_select,
                    mode_select,
                    bit_error,
                    overflow,
                    done,
                    busy
                };
                ADDR_ERRCNT:        cfg_rdata = error_count;
                ADDR_TOTCNT:        cfg_rdata = total_count;
                ADDR_DBG:           cfg_rdata = {
                    27'd0,
                    bit_error,
                    ref_bit,
                    checker_in_final,
                    checker_in,
                    prbs_out
                };
                ADDR_LAST_ERRCNT:   cfg_rdata = last_errcnt_reg;
                ADDR_LAST_TOTCNT:   cfg_rdata = last_totcnt_reg;
                ADDR_LAST_STATUS:   cfg_rdata = last_status_reg;
                ADDR_RUN_COUNT:     cfg_rdata = run_count_reg;
                ADDR_PASS_COUNT:    cfg_rdata = pass_count_reg;
                ADDR_FAIL_COUNT:    cfg_rdata = fail_count_reg;
                ADDR_FIRST_ERR_IDX: cfg_rdata = first_error_index_reg;
                ADDR_STICKY_STATUS: cfg_rdata = {
                    28'd0,
                    first_error_seen_reg,
                    sticky_overflow_reg,
                    sticky_error_seen_reg,
                    sticky_done_reg
                };
                ADDR_SNAPSHOT0:     cfg_rdata = snapshot0_reg;
                default:            cfg_rdata = 32'd0;
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
