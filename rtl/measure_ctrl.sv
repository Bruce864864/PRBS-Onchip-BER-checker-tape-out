module measure_ctrl (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        start_pulse,
    input  logic        stop_pulse,
    input  logic        continuous_mode,
    input  logic [31:0] window_cfg,
    input  logic [31:0] total_count,

    output logic        core_en,
    output logic        clear_count_pulse,
    output logic        busy,
    output logic        done,
    output logic        overflow
);

    logic busy_q, done_q, core_en_q, overflow_q;
    logic skip_window_check_q;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_q            <= 1'b0;
            done_q            <= 1'b0;
            core_en_q         <= 1'b0;
            clear_count_pulse <= 1'b0;
            overflow_q        <= 1'b0;
            skip_window_check_q <= 1'b0;
        end else begin
            clear_count_pulse <= 1'b0;
    
            if (start_pulse) begin
                busy_q            <= 1'b1;
                done_q            <= 1'b0;
                core_en_q         <= 1'b1;
                clear_count_pulse <= 1'b1;
                overflow_q        <= 1'b0;
                skip_window_check_q <= 1'b1;
            end else if (stop_pulse) begin
                busy_q    <= 1'b0;
                done_q    <= 1'b1;
                core_en_q <= 1'b0;
                skip_window_check_q <= 1'b0;
            end else if (busy_q) begin
                if (&total_count) begin
                    overflow_q <= 1'b1;
                end
    
                if (skip_window_check_q) begin
                    skip_window_check_q <= 1'b0;
                end else if (!continuous_mode &&
                             (window_cfg != 32'd0) &&
                             (total_count >= (window_cfg - 32'd1))) begin
                    busy_q    <= 1'b0;
                    done_q    <= 1'b1;
                    core_en_q <= 1'b0;
                end
            end
        end
    end

    assign busy     = busy_q;
    assign done     = done_q;
    assign core_en  = core_en_q;
    assign overflow = overflow_q;

endmodule