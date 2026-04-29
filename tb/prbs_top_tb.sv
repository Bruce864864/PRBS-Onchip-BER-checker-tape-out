`timescale 1ps/1ps

module prbs_top_tb;

    logic       clk;
    logic       rst_n;
    logic       en;
    logic       seed_load;
    logic [6:0] seed_in;
    logic       prbs_out;

    logic [6:0] ref_lfsr;
    logic       expected_prbs_out;
    int         error_count;

    prbs_top dut (
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

    function automatic logic [6:0] next_prbs7(input logic [6:0] cur);
        logic feedback;
        begin
            feedback   = cur[6] ^ cur[5];
            next_prbs7 = {cur[5:0], feedback};
        end
    endfunction

    task automatic check_output(input string tag);
        begin
            expected_prbs_out = ref_lfsr[6];
            if (prbs_out !== expected_prbs_out) begin
                $display("[%0t] ERROR (%s): prbs_out=%0b expected=%0b ref_lfsr=%07b",
                         $time, tag, prbs_out, expected_prbs_out, ref_lfsr);
                error_count = error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): prbs_out=%0b ref_lfsr=%07b",
                         $time, tag, prbs_out, ref_lfsr);
            end
        end
    endtask

    task automatic dump_state(input string tag);
        begin
            $display("[%0t] DEBUG (%s): rst_n=%0b en=%0b seed_load=%0b seed_in=%07b prbs_out=%0b state_out=%07b",
                     $time, tag, rst_n, en, seed_load, seed_in, prbs_out, dut.u_prbs_core.state_out);
        end
    endtask


    initial begin
        rst_n       = 1'b0;
        en          = 1'b0;
        seed_load   = 1'b0;
        seed_in     = 7'b0000001;
        ref_lfsr    = 7'b0000001;
        error_count = 0;
    
        // hold reset active from time 0 for 5 full cycles
        repeat (5) @(posedge clk);
        #1000;
        // release reset away from active edge
        @(negedge clk);
        rst_n = 1'b1;
        #1000;
        // wait 3 full cycles after reset release
        repeat (3) @(posedge clk);
        #1000;
        // -----------------------------
        // Load non-zero seed
        // -----------------------------
        @(negedge clk);
        seed_in   = 7'b1010110;
        seed_load = 1'b1;

        @(posedge clk);
        #8000;
        ref_lfsr = 7'b1010110;
        check_output("seed_load_nonzero");
        
        seed_load = 1'b0;
        
        // wait one extra full cycle before enable
        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        // -----------------------------
        // Run PRBS7
        // -----------------------------
        @(posedge clk);
        ref_lfsr = next_prbs7(ref_lfsr);
        #8000;
        check_output("run_prbs7");
        
        repeat (39) begin
            @(posedge clk);
            ref_lfsr = next_prbs7(ref_lfsr);
            #8000;
            check_output("run_prbs7");
        end

        // -----------------------------
        // Disable and verify hold
        // -----------------------------
        en = 1'b0;

        repeat (5) begin
            @(posedge clk);
            #8000;
            check_output("hold_when_disabled");
        end

        // -----------------------------
        // Load zero seed -> sanitize to default 0000001
        // -----------------------------
        @(negedge clk);
        seed_in   = 7'b0000000;
        seed_load = 1'b1;

        @(posedge clk);
        #8000;
        ref_lfsr = 7'b0000001;
        check_output("seed_load_zero_sanitized");

        seed_load = 1'b0;

        // wait one extra full cycle before enable
        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        // -----------------------------
        // Run again after zero-seed sanitize
        // -----------------------------
        repeat (20) begin
            @(posedge clk);
            ref_lfsr = next_prbs7(ref_lfsr);
            #8000;
            check_output("run_after_zero_seed");
        end

        $display("========================================");
        if (error_count == 0) begin
            $display("TEST PASSED: all PRBS checks succeeded.");
        end else begin
            $display("TEST FAILED: error_count = %0d", error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule