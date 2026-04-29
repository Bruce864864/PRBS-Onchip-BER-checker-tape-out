module prbs15_core #(
    parameter int LFSR_W = 15,
    parameter logic [LFSR_W-1:0] DEFAULT_SEED = 15'b000000000000001
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              load_req,
    input  logic [LFSR_W-1:0] seed_value,
    input  logic              step_en,
    output logic              prbs_out,
    output logic [LFSR_W-1:0] state_out
);

    logic [LFSR_W-1:0] lfsr_q;
    logic              feedback;

    // PRBS15 polynomial: x^15 + x^14 + 1
    assign feedback = lfsr_q[14] ^ lfsr_q[13];

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            lfsr_q <= DEFAULT_SEED;
        end else if (load_req) begin
            lfsr_q <= seed_value;
        end else if (step_en) begin
            lfsr_q <= {lfsr_q[LFSR_W-2:0], feedback};
        end
    end

    assign prbs_out  = lfsr_q[LFSR_W-1];
    assign state_out = lfsr_q;

endmodule
