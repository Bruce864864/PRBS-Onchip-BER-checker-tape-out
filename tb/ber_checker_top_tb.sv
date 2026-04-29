`timescale 1ps/1ps

module ber_checker_top_tb;

    logic        clk;
    logic        rst_n;
    logic        en;
    logic        clear_count;
    logic        seed_load;
    logic        mode_select;
    logic [14:0] seed_in;

    logic        serial_in;
    logic        ext_prbs_bit;
    logic        inject_error;

    logic        ref_bit;
    logic        bit_error;
    logic [31:0] error_count;
    logic [31:0] total_count;

    int tb_error_count;
    int i;

    // DUT: checker under test
    ber_checker_top dut (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (en),
        .clear_count (clear_count),
        .seed_load   (seed_load),
        .mode_select (mode_select),
        .seed_in     (seed_in),
        .serial_in   (serial_in),
        .ref_bit     (ref_bit),
        .bit_error   (bit_error),
        .error_count (error_count),
        .total_count (total_count)
    );

    // External reference generator to emulate loopback input
    prbs_gen_top u_ext_gen (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (en),
        .seed_load   (seed_load),
        .mode_select (mode_select),
        .seed_in     (seed_in),
        .prbs_out    (ext_prbs_bit)
    );

    // Continuous loopback path with optional single-bit inversion
    assign serial_in = inject_error ? ~ext_prbs_bit : ext_prbs_bit;

    initial begin
        clk = 1'b0;
        forever #2000 clk = ~clk;   // 4ns period = 250MHz
    end

    task automatic expect_counts(
        input string tag,
        input logic [31:0] exp_err,
        input logic [31:0] exp_total
    );
        begin
            if ((error_count !== exp_err) || (total_count !== exp_total)) begin
                $display("[%0t] ERROR (%s): error_count=%0d expected=%0d total_count=%0d expected=%0d",
                         $time, tag, error_count, exp_err, total_count, exp_total);
                tb_error_count = tb_error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): error_count=%0d total_count=%0d",
                         $time, tag, error_count, total_count);
            end
        end
    endtask

    task automatic do_clear_and_check(input string tag);
        begin
            @(negedge clk);
            clear_count = 1'b1;

            @(posedge clk);
            #3000;
            expect_counts(tag, 32'd0, 32'd0);

            @(negedge clk);
            clear_count = 1'b0;
        end
    endtask

    task automatic load_seed(
        input logic        mode_in,
        input logic [14:0] seed_in_val
    );
        begin
            @(negedge clk);
            mode_select = mode_in;
            seed_in     = seed_in_val;
            seed_load   = 1'b1;
            en          = 1'b0;
            inject_error = 1'b0;

            @(posedge clk);
            #3000;

            @(negedge clk);
            seed_load = 1'b0;
        end
    endtask

    task automatic run_bits_exact(
        input int nbits,
        input int err_idx   // -1 means no injected error
    );
        begin
            for (i = 0; i < nbits; i = i + 1) begin
                @(negedge clk);
                if (i == 0)
                    en = 1'b1;
    
                if (i == err_idx)
                    inject_error = 1'b1;
                else
                    inject_error = 1'b0;
    
                @(posedge clk);
                #1000;
            end
    
            @(negedge clk);
            en           = 1'b0;
            inject_error = 1'b0;
        end
    endtask

    initial begin
        rst_n          = 1'b0;
        en             = 1'b0;
        clear_count    = 1'b0;
        seed_load      = 1'b0;
        mode_select    = 1'b0;
        seed_in        = 15'b0;
        inject_error   = 1'b0;
        tb_error_count = 0;

        // Reset sequence
        repeat (5) @(posedge clk);
        #1000;
        @(negedge clk);
        rst_n = 1'b1;
        #1000;
        repeat (3) @(posedge clk);
        #1000;

        // =====================================================
        // Case 1: PRBS7 loopback, 20 bits, no errors
        // =====================================================
        load_seed(1'b0, 15'b000000001010110);
        run_bits_exact(20, -1);

        @(posedge clk);
        #3000;
        expect_counts("prbs7_loopback_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 2: Clear
        // =====================================================
        do_clear_and_check("clear_after_prbs7");

        // =====================================================
        // Case 3: PRBS7 loopback, 20 bits, inject exactly 1 error
        // =====================================================
        load_seed(1'b0, 15'b000000001010110);
        run_bits_exact(20, 9);

        @(posedge clk);
        #3000;
        expect_counts("prbs7_one_error", 32'd1, 32'd20);

        // =====================================================
        // Case 4: Clear
        // =====================================================
        do_clear_and_check("clear_before_prbs15");

        // =====================================================
        // Case 5: PRBS15 loopback, 20 bits, no errors
        // =====================================================
        load_seed(1'b1, 15'b101011001110101);
        run_bits_exact(20, -1);

        @(posedge clk);
        #3000;
        expect_counts("prbs15_loopback_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 6: Clear
        // =====================================================
        do_clear_and_check("clear_after_prbs15");

        // =====================================================
        // Case 7: PRBS15 loopback, 20 bits, inject exactly 1 error
        // =====================================================
        load_seed(1'b1, 15'b101011001110101);
        run_bits_exact(20, 7);

        @(posedge clk);
        #3000;
        expect_counts("prbs15_one_error", 32'd1, 32'd20);

        $display("========================================");
        if (tb_error_count == 0) begin
            $display("TEST PASSED: all BER checker baseline checks succeeded.");
        end else begin
            $display("TEST FAILED: tb_error_count = %0d", tb_error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule