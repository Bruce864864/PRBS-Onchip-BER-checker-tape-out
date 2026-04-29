module prbs_gen_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic        seed_load,
    input  logic        mode_select,   // 0: PRBS7, 1: PRBS15
    input  logic [14:0] seed_in,
    output logic        prbs_out
);

    logic prbs7_out;
    logic prbs15_out;

    prbs_top u_prbs7_top (
        .clk       (clk),
        .rst_n     (rst_n),
        .en        (en && (mode_select == 1'b0)),
        .seed_load (seed_load && (mode_select == 1'b0)),
        .seed_in   (seed_in[6:0]),
        .prbs_out  (prbs7_out)
    );

    prbs15_top u_prbs15_top (
        .clk       (clk),
        .rst_n     (rst_n),
        .en        (en && (mode_select == 1'b1)),
        .seed_load (seed_load && (mode_select == 1'b1)),
        .seed_in   (seed_in),
        .prbs_out  (prbs15_out)
    );

    always_comb begin
        if (mode_select == 1'b0)
            prbs_out = prbs7_out;
        else
            prbs_out = prbs15_out;
    end

endmodule
