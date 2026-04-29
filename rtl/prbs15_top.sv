module prbs15_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic        seed_load,
    input  logic [14:0] seed_in,
    output logic        prbs_out
);

    logic        load_req;
    logic [14:0] seed_value;
    logic        step_en;
    logic [14:0] prbs_state;

    prbs15_ctrl #(
        .LFSR_W(15),
        .DEFAULT_SEED(15'b000000000000001)
    ) u_prbs15_ctrl (
        .seed_load  (seed_load),
        .seed_in    (seed_in),
        .en         (en),
        .load_req   (load_req),
        .seed_value (seed_value),
        .step_en    (step_en)
    );

    prbs15_core #(
        .LFSR_W(15),
        .DEFAULT_SEED(15'b000000000000001)
    ) u_prbs15_core (
        .clk        (clk),
        .rst_n      (rst_n),
        .load_req   (load_req),
        .seed_value (seed_value),
        .step_en    (step_en),
        .prbs_out   (prbs_out),
        .state_out  (prbs_state)
    );

endmodule