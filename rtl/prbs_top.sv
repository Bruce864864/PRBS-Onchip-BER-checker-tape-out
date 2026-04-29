module prbs_top (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       en,
    input  logic       seed_load,
    input  logic [6:0] seed_in,
    output logic       prbs_out
);

    logic       load_req;
    logic [6:0] seed_value;
    logic       step_en;
    logic [6:0] prbs_state;

    prbs_ctrl #(
        .LFSR_W(7),
        .DEFAULT_SEED(7'b0000001)
    ) u_prbs_ctrl (
        .seed_load  (seed_load),
        .seed_in    (seed_in),
        .en         (en),
        .load_req   (load_req),
        .seed_value (seed_value),
        .step_en    (step_en)
    );

    prbs_core #(
        .LFSR_W(7),
        .DEFAULT_SEED(7'b0000001)
    ) u_prbs_core (
        .clk        (clk),
        .rst_n      (rst_n),
        .load_req   (load_req),
        .seed_value (seed_value),
        .step_en    (step_en),
        .prbs_out   (prbs_out),
        .state_out  (prbs_state)
    );

endmodule