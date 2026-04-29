module prbs_ber_top (
    input  logic        clk,
    input  logic        rst_n,

    // control
    input  logic        en,
    input  logic        clear_count,
    input  logic        seed_load,
    input  logic        mode_select,         // 0: PRBS7, 1: PRBS15
    input  logic [14:0] seed_in,
    input  logic        input_select,        // 0: internal loopback, 1: external input
    input  logic        inject_error_enable,

    // external data input
    input  logic        ext_serial_in,

    // observable outputs
    output logic        prbs_out,            // generator output
    output logic        checker_in,          // selected input before compare
    output logic        checker_in_final,    // after optional error injection
    output logic        ref_bit,             // reference bit used by checker
    output logic        bit_error,
    output logic [31:0] error_count,
    output logic [31:0] total_count
);

    logic gen_bit;
    logic selected_in;
    logic final_in;
    logic ext_serial_in_q;
    logic ref_bit_q;
    logic compare_ref_bit;

    // Unified PRBS generator
    prbs_gen_top u_prbs_gen_top (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (en),
        .seed_load   (seed_load),
        .mode_select (mode_select),
        .seed_in     (seed_in),
        .prbs_out    (gen_bit)
    );

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ext_serial_in_q <= 1'b0;
            ref_bit_q       <= 1'b0;
        end else begin
            ext_serial_in_q <= ext_serial_in;
            ref_bit_q       <= gen_bit;
        end
    end

    // Export generator bit
    assign prbs_out = gen_bit;
    assign ref_bit = gen_bit;


    always_comb begin
        if (input_select == 1'b0)
            compare_ref_bit = gen_bit;
        else
            compare_ref_bit = ref_bit_q;
    end

    // Input select
    always_comb begin
        if (input_select == 1'b0)
            selected_in = gen_bit;
        else
            selected_in = ext_serial_in_q;
    end

    assign checker_in = selected_in;

    // Optional error injection
    always_comb begin
        if (inject_error_enable)
            final_in = ~selected_in;
        else
            final_in = selected_in;
    end

    assign checker_in_final = final_in;

    // Compare
    assign bit_error = en && (final_in != compare_ref_bit);

    // Counters
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            error_count <= 32'd0;
            total_count <= 32'd0;
        end else if (clear_count) begin
            error_count <= 32'd0;
            total_count <= 32'd0;
        end else if (en) begin
            total_count <= total_count + 32'd1;
            if (final_in != compare_ref_bit)
                error_count <= error_count + 32'd1;
        end
    end

endmodule