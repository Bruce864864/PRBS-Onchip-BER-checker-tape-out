`timescale 1ps/1ps

module prbs_ber_top_tb;

    logic        clk;
    logic        rst_n;

    logic        en;
    logic        clear_count;
    logic        seed_load;
    logic        mode_select;
    logic [14:0] seed_in;
    logic        input_select;
    logic        inject_error_enable;
    logic        ext_serial_in;

    logic        prbs_out;
    logic        checker_in;
    logic        checker_in_final;
    logic        ref_bit;
    logic        bit_error;
    logic [31:0] error_count;
    logic [31:0] total_count;

    int tb_error_count;
    int i;

    prbs_ber_top dut (
        .clk                 (clk),
        .rst_n               (rst_n),
        .en                  (en),
        .clear_count         (clear_count),
        .seed_load           (seed_load),
        .mode_select         (mode_select),
        .seed_in             (seed_in),
        .input_select        (input_select),
        .inject_error_enable (inject_error_enable),
        .ext_serial_in       (ext_serial_in),
        .prbs_out            (prbs_out),
        .checker_in          (checker_in),
        .checker_in_final    (checker_in_final),
        .ref_bit             (ref_bit),
        .bit_error           (bit_error),
        .error_count         (error_count),
        .total_count         (total_count)
    );

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
            #1000;
            expect_counts(tag, 32'd0, 32'd0);

            @(negedge clk);
            clear_count = 1'b0;
        end
    endtask

    task automatic load_seed_and_config(
        input logic        mode_in,
        input logic [14:0] seed_in_val,
        input logic        input_sel_in,
        input logic        inject_in
    );
        begin
            @(negedge clk);
            mode_select         = mode_in;
            seed_in             = seed_in_val;
            input_select        = input_sel_in;
            inject_error_enable = inject_in;
            seed_load           = 1'b1;
            en                  = 1'b0;

            @(posedge clk);
            #1000;

            @(negedge clk);
            seed_load = 1'b0;
        end
    endtask

    task automatic run_bits_exact(input int nbits);
        begin
            @(negedge clk);
            en = 1'b1;

            for (i = 0; i < nbits; i = i + 1) begin
                @(posedge clk);
                #1000;
            end

            @(negedge clk);
            en = 1'b0;
        end
    endtask

    initial begin
        rst_n               = 1'b0;
        en                  = 1'b0;
        clear_count         = 1'b0;
        seed_load           = 1'b0;
        mode_select         = 1'b0;
        seed_in             = 15'b0;
        input_select        = 1'b0;
        inject_error_enable = 1'b0;
        ext_serial_in       = 1'b0;
        tb_error_count      = 0;

        // Reset
        repeat (5) @(posedge clk);
        #1000;
        @(negedge clk);
        rst_n = 1'b1;
        #1000;
        repeat (3) @(posedge clk);
        #1000;

        // =====================================================
        // Case 1: PRBS7 internal loopback, no error
        // =====================================================
        load_seed_and_config(1'b0, 15'b000000001010110, 1'b0, 1'b0);
        run_bits_exact(20);

        @(posedge clk);
        #1000;
        expect_counts("prbs7_internal_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 2: Clear
        // =====================================================
        do_clear_and_check("clear_after_prbs7_internal");

        // =====================================================
        // Case 3: PRBS7 internal loopback, injection enabled
        // =====================================================
        load_seed_and_config(1'b0, 15'b000000001010110, 1'b0, 1'b1);
        run_bits_exact(20);

        @(posedge clk);
        #1000;
        expect_counts("prbs7_internal_inject_error", 32'd20, 32'd20);

        // =====================================================
        // Case 4: Clear
        // =====================================================
        do_clear_and_check("clear_before_prbs15");

        // =====================================================
        // Case 5: PRBS15 internal loopback, no error
        // =====================================================
        load_seed_and_config(1'b1, 15'b101011001110101, 1'b0, 1'b0);
        run_bits_exact(20);

        @(posedge clk);
        #1000;
        expect_counts("prbs15_internal_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 6: Clear
        // =====================================================
        do_clear_and_check("clear_after_prbs15_internal");

        // =====================================================
        // Case 7: PRBS15 internal loopback, injection enabled
        // =====================================================
        load_seed_and_config(1'b1, 15'b101011001110101, 1'b0, 1'b1);
        run_bits_exact(20);

        @(posedge clk);
        #1000;
        expect_counts("prbs15_internal_inject_error", 32'd20, 32'd20);

        // =====================================================
        // Case 8: External input mode, ext input matches ref_bit
        // Here we simply mirror current ref_bit in TB to test mux path
        // =====================================================
        do_clear_and_check("clear_before_external_mode");

        load_seed_and_config(1'b0, 15'b000000001010110, 1'b1, 1'b0);

        // preload external input before enabling count
        @(negedge clk);
        ext_serial_in = ref_bit;
        en = 1'b1;

        repeat (20) begin
            @(posedge clk);
            #1000;

            @(negedge clk);
            ext_serial_in = ref_bit;
        end

        // loop exits at negedge already, so disable immediately here
        en = 1'b0;

        @(posedge clk);
        #1000;
        expect_counts("external_input_match_ref", 32'd0, 32'd20);

        $display("========================================");
        if (tb_error_count == 0) begin
            $display("TEST PASSED: all PRBS+BER top checks succeeded.");
        end else begin
            $display("TEST FAILED: tb_error_count = %0d", tb_error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule