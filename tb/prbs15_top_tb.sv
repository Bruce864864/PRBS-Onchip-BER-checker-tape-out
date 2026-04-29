`timescale 1ps/1ps

module prbs15_top_tb;

    logic        clk;
    logic        rst_n;
    logic        en;
    logic        seed_load;
    logic [14:0] seed_in;
    logic        prbs_out;

    logic [14:0] ref_lfsr;
    logic        expected_prbs_out;
    int          error_count;

    prbs15_top dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .en        (en),
        .seed_load (seed_load),
        .seed_in   (seed_in),
        .prbs_out  (prbs_out)
    );

    initial begin
        clk = 1'b0;
        forever #5000 clk = ~clk;   // 10ns period
    end

    function automatic logic [14:0] next_prbs15(input logic [14:0] cur);
        logic feedback;
        begin
            feedback    = cur[14] ^ cur[13];
            next_prbs15 = {cur[13:0], feedback};
        end
    endfunction

    task automatic check_output(input string tag);
        begin
            expected_prbs_out = ref_lfsr[14];
            if (prbs_out !== expected_prbs_out) begin
                $display("[%0t] ERROR (%s): prbs_out=%0b expected=%0b ref_lfsr=%015b",
                         $time, tag, prbs_out, expected_prbs_out, ref_lfsr);
                error_count = error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): prbs_out=%0b ref_lfsr=%015b",
                         $time, tag, prbs_out, ref_lfsr);
            end
        end
    endtask

    initial begin
        rst_n       = 1'b0;
        en          = 1'b0;
        seed_load   = 1'b0;
        seed_in     = 15'b000000000000001;
        ref_lfsr    = 15'b000000000000001;
        error_count = 0;

        repeat (5) @(posedge clk);

        @(negedge clk);
        rst_n = 1'b1;

        repeat (3) @(posedge clk);

        @(negedge clk);
        seed_in   = 15'b101011001110101;
        seed_load = 1'b1;

        @(posedge clk);
        #8000;
        ref_lfsr = 15'b101011001110101;
        check_output("seed_load_nonzero");

        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (40) begin
            @(posedge clk);
            ref_lfsr = next_prbs15(ref_lfsr);
            #8000;
            check_output("run_prbs15");
        end

        en = 1'b0;

        repeat (5) begin
            @(posedge clk);
            #8000;
            check_output("hold_when_disabled");
        end

        @(negedge clk);
        seed_in   = 15'b000000000000000;
        seed_load = 1'b1;

        @(posedge clk);
        #8000;
        ref_lfsr = 15'b000000000000001;
        check_output("seed_load_zero_sanitized");

        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (20) begin
            @(posedge clk);
            ref_lfsr = next_prbs15(ref_lfsr);
            #8000;
            check_output("run_after_zero_seed");
        end

        $display("========================================");
        if (error_count == 0) begin
            $display("TEST PASSED: all PRBS15 checks succeeded.");
        end else begin
            $display("TEST FAILED: error_count = %0d", error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule