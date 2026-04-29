module ber_checker_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic        clear_count,
    input  logic        seed_load,
    input  logic        mode_select,   // 0: PRBS7, 1: PRBS15
    input  logic [14:0] seed_in,
    input  logic        serial_in,

    output logic        ref_bit,
    output logic        bit_error,
    output logic [31:0] error_count,
    output logic [31:0] total_count
);

    logic prbs_ref_bit;

    // Reuse the already verified unified generator as reference path
    prbs_gen_top u_prbs_gen_top (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (en),
        .seed_load   (seed_load),
        .mode_select (mode_select),
        .seed_in     (seed_in),
        .prbs_out    (prbs_ref_bit)
    );

    assign ref_bit   = prbs_ref_bit;
    assign bit_error = en && (serial_in != prbs_ref_bit);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            error_count <= 32'd0;
            total_count <= 32'd0;
        end else if (clear_count) begin
            error_count <= 32'd0;
            total_count <= 32'd0;
        end else if (en) begin
            total_count <= total_count + 32'd1;
            if (serial_in != prbs_ref_bit) begin
                error_count <= error_count + 32'd1;
            end
        end
    end

endmodule