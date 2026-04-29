`timescale 1ps/1ps

module prbs_gen_top_tb;

    logic        clk;
    logic        rst_n;
    logic        en;
    logic        seed_load;
    logic        mode_select;   // 0: PRBS7, 1: PRBS15
    logic [14:0] seed_in;
    logic        prbs_out;

    logic [6:0]  ref_lfsr7;
    logic [14:0] ref_lfsr15;
    logic        expected_prbs_out;
    int          error_count;

    prbs_gen_top dut (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (en),
        .seed_load   (seed_load),
        .mode_select (mode_select),
        .seed_in     (seed_in),
        .prbs_out    (prbs_out)
    );

    initial begin
        clk = 1'b0;
        forever #2000 clk = ~clk;   // 4ns period
    end

    function automatic logic [6:0] next_prbs7(input logic [6:0] cur);
        logic feedback;
        begin
            feedback   = cur[6] ^ cur[5];
            next_prbs7 = {cur[5:0], feedback};
        end
    endfunction

    function automatic logic [14:0] next_prbs15(input logic [14:0] cur);
        logic feedback;
        begin
            feedback    = cur[14] ^ cur[13];
            next_prbs15 = {cur[13:0], feedback};
        end
    endfunction

    task automatic check_output_prbs7(input string tag);
        begin
            expected_prbs_out = ref_lfsr7[6];
            if (prbs_out !== expected_prbs_out) begin
                $display("[%0t] ERROR (%s): prbs_out=%0b expected=%0b ref_lfsr7=%07b",
                         $time, tag, prbs_out, expected_prbs_out, ref_lfsr7);
                error_count = error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): prbs_out=%0b ref_lfsr7=%07b",
                         $time, tag, prbs_out, ref_lfsr7);
            end
        end
    endtask

    task automatic check_output_prbs15(input string tag);
        begin
            expected_prbs_out = ref_lfsr15[14];
            if (prbs_out !== expected_prbs_out) begin
                $display("[%0t] ERROR (%s): prbs_out=%0b expected=%0b ref_lfsr15=%015b",
                         $time, tag, prbs_out, expected_prbs_out, ref_lfsr15);
                error_count = error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): prbs_out=%0b ref_lfsr15=%015b",
                         $time, tag, prbs_out, ref_lfsr15);
            end
        end
    endtask

    initial begin
        rst_n        = 1'b0;
        en           = 1'b0;
        seed_load    = 1'b0;
        mode_select  = 1'b0;
        seed_in      = 15'b0;
        ref_lfsr7    = 7'b0000001;
        ref_lfsr15   = 15'b000000000000001;
        error_count  = 0;

        repeat (5) @(posedge clk);
        #1000;
        @(negedge clk);
        rst_n = 1'b1;
        #1000;
        repeat (3) @(posedge clk);
        #1000;

        // -----------------------------
        // PRBS7 mode
        // -----------------------------
        @(negedge clk);
        mode_select = 1'b0;
        seed_in     = 15'b000000001010110;   // low 7 bits = 1010110
        seed_load   = 1'b1;

        @(posedge clk);
        #3000;
        ref_lfsr7 = 7'b1010110;
        check_output_prbs7("prbs7_seed_load_nonzero");

        @(negedge clk);
        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (40) begin
            @(posedge clk);
            ref_lfsr7 = next_prbs7(ref_lfsr7);
            #3000;
            check_output_prbs7("prbs7_run");
        end

        en = 1'b0;

        repeat (5) begin
            @(posedge clk);
            #3000;
            check_output_prbs7("prbs7_hold_when_disabled");
        end

        @(negedge clk);
        seed_in   = 15'b0;
        seed_load = 1'b1;

        @(posedge clk);
        #3000;
        ref_lfsr7 = 7'b0000001;
        check_output_prbs7("prbs7_zero_seed_sanitized");

        @(negedge clk);
        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (20) begin
            @(posedge clk);
            ref_lfsr7 = next_prbs7(ref_lfsr7);
            #3000;
            check_output_prbs7("prbs7_run_after_zero_seed");
        end

        en = 1'b0;
        repeat (3) @(posedge clk);

        // -----------------------------
        // PRBS15 mode
        // -----------------------------
        @(negedge clk);
        mode_select = 1'b1;
        seed_in     = 15'b101011001110101;
        seed_load   = 1'b1;

        @(posedge clk);
        #3000;
        ref_lfsr15 = 15'b101011001110101;
        check_output_prbs15("prbs15_seed_load_nonzero");

        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (40) begin
            @(posedge clk);
            ref_lfsr15 = next_prbs15(ref_lfsr15);
            #3000;
            check_output_prbs15("prbs15_run");
        end

        en = 1'b0;

        repeat (5) begin
            @(posedge clk);
            #3000;
            check_output_prbs15("prbs15_hold_when_disabled");
        end

        @(negedge clk);
        seed_in   = 15'b0;
        seed_load = 1'b1;

        @(posedge clk);
        #3000;
        ref_lfsr15 = 15'b000000000000001;
        check_output_prbs15("prbs15_zero_seed_sanitized");

        seed_load = 1'b0;

        @(posedge clk);
        @(negedge clk);
        en = 1'b1;

        repeat (20) begin
            @(posedge clk);
            ref_lfsr15 = next_prbs15(ref_lfsr15);
            #3000;
            check_output_prbs15("prbs15_run_after_zero_seed");
        end

        $display("========================================");
        if (error_count == 0) begin
            $display("TEST PASSED: all unified PRBS generator checks succeeded.");
        end else begin
            $display("TEST FAILED: error_count = %0d", error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule
