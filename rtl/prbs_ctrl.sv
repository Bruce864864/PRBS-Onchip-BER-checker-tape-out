module prbs_ctrl #(
    parameter int LFSR_W = 7,
    parameter logic [LFSR_W-1:0] DEFAULT_SEED = 7'b0000001
) (
    input  logic              seed_load,
    input  logic [LFSR_W-1:0] seed_in,
    input  logic              en,
    output logic              load_req,
    output logic [LFSR_W-1:0] seed_value,
    output logic              step_en
);

    always_comb begin
        load_req   = seed_load;
        step_en    = en;

        if (seed_in == '0) begin
            seed_value = DEFAULT_SEED;
        end else begin
            seed_value = seed_in;
        end
    end

endmodule