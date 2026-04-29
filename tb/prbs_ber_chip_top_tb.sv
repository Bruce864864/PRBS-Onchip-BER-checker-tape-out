`timescale 1ps/1ps

module prbs_ber_chip_top_tb;

    logic        clk;
    logic        rst_n;
    logic        ext_serial_in;

    logic        cfg_we;
    logic        cfg_re;
    logic [4:0]  cfg_addr;
    logic [31:0] cfg_wdata;
    logic [31:0] cfg_rdata;

    logic        busy;
    logic        done;
    logic        prbs_out;
    logic        bit_error;
    
    logic        ext_ref_en;
    logic        ext_ref_seed_load;
    logic        ext_ref_mode_select;
    logic [14:0] ext_ref_seed_in;
    logic        ext_ref_bit;

    int tb_error_count;

    localparam logic [4:0] ADDR_CTRL   = 5'h00;
    localparam logic [4:0] ADDR_SEED   = 5'h04;
    localparam logic [4:0] ADDR_CMD    = 5'h08;
    localparam logic [4:0] ADDR_WINDOW = 5'h0C;
    localparam logic [4:0] ADDR_STATUS = 5'h10;
    localparam logic [4:0] ADDR_ERRCNT = 5'h14;
    localparam logic [4:0] ADDR_TOTCNT = 5'h18;
    localparam logic [4:0] ADDR_DBG    = 5'h1C;

    // CTRL bits
    localparam int CTRL_ENABLE_BIT         = 0;
    localparam int CTRL_MODE_BIT           = 1;
    localparam int CTRL_INPUT_SELECT_BIT   = 2;
    localparam int CTRL_INJECT_ERROR_BIT   = 3;
    localparam int CTRL_CONTINUOUS_MODEBIT = 4;

    // CMD bits
    localparam int CMD_SEED_LOAD_BIT   = 0;
    localparam int CMD_CLEAR_COUNT_BIT = 1;
    localparam int CMD_START_BIT       = 2;
    localparam int CMD_STOP_BIT        = 3;

    prbs_ber_chip_top dut (
        .clk           (clk),
        .rst_n         (rst_n),
        .ext_serial_in (ext_serial_in),
        .cfg_we        (cfg_we),
        .cfg_re        (cfg_re),
        .cfg_addr      (cfg_addr),
        .cfg_wdata     (cfg_wdata),
        .cfg_rdata     (cfg_rdata),
        .busy          (busy),
        .done          (done),
        .prbs_out      (prbs_out),
        .bit_error     (bit_error)
    );

    prbs_gen_top u_ext_ref_gen (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (ext_ref_en),
        .seed_load   (ext_ref_seed_load),
        .mode_select (ext_ref_mode_select),
        .seed_in     (ext_ref_seed_in),
        .prbs_out    (ext_ref_bit)
    );

    initial begin
        clk = 1'b0;
        forever #2000 clk = ~clk;   // 4ns period
    end

    task automatic cfg_write(input logic [4:0] addr, input logic [31:0] data);
        begin
            @(negedge clk);
            cfg_addr  = addr;
            cfg_wdata = data;
            cfg_we    = 1'b1;

            @(posedge clk);
            #1000;

            @(negedge clk);
            cfg_we    = 1'b0;
            cfg_addr  = '0;
            cfg_wdata = '0;
        end
    endtask

    task automatic cfg_read(input logic [4:0] addr, output logic [31:0] data);
        begin
            @(negedge clk);
            cfg_addr = addr;
            cfg_re   = 1'b1;

            @(posedge clk);
            #1000;
            data = cfg_rdata;

            @(negedge clk);
            cfg_re   = 1'b0;
            cfg_addr = '0;
        end
    endtask

    task automatic expect_eq32(
        input string tag,
        input logic [31:0] got,
        input logic [31:0] exp
    );
        begin
            if (got !== exp) begin
                $display("[%0t] ERROR (%s): got=%0d expected=%0d", $time, tag, got, exp);
                tb_error_count++;
            end else begin
                $display("[%0t] PASS  (%s): got=%0d", $time, tag, got);
            end
        end
    endtask

    task automatic expect_bit(
        input string tag,
        input logic got,
        input logic exp
    );
        begin
            if (got !== exp) begin
                $display("[%0t] ERROR (%s): got=%0b expected=%0b", $time, tag, got, exp);
                tb_error_count++;
            end else begin
                $display("[%0t] PASS  (%s): got=%0b", $time, tag, got);
            end
        end
    endtask

    task automatic wait_done_and_check_basic(
        input string tag,
        input logic [31:0] exp_err,
        input logic [31:0] exp_total
    );
        logic [31:0] rd_data;
        int i;
        begin
            for (i = 0; i < exp_total + 4; i = i + 1) begin
                @(posedge clk);
                #1000;
            end
    
            expect_bit({tag, "_busy_after_done"}, busy, 1'b0);
            expect_bit({tag, "_done_after_done"}, done, 1'b1);
    
            cfg_read(ADDR_TOTCNT, rd_data);
            expect_eq32({tag, "_total_count"}, rd_data, exp_total);
    
            cfg_read(ADDR_ERRCNT, rd_data);
            expect_eq32({tag, "_error_count"}, rd_data, exp_err);
        end
    endtask

    task automatic check_counters_zero(
        input string tag
    );
        logic [31:0] rd_data;
        begin
            cfg_read(ADDR_TOTCNT, rd_data);
            expect_eq32({tag, "_total_count_zero"}, rd_data, 32'd0);
    
            cfg_read(ADDR_ERRCNT, rd_data);
            expect_eq32({tag, "_error_count_zero"}, rd_data, 32'd0);
        end
    endtask

    task automatic program_common(
        input logic [31:0] ctrl_value,
        input logic [31:0] seed_value,
        input logic [31:0] window_value
    );
        begin
            cfg_write(ADDR_CTRL,   ctrl_value);
            cfg_write(ADDR_SEED,   seed_value);
            cfg_write(ADDR_WINDOW, window_value);
        end
    endtask

    task automatic pulse_seed_load();
        begin
            cfg_write(ADDR_CMD, 32'(1 << CMD_SEED_LOAD_BIT));
        end
    endtask

    task automatic pulse_start();
        begin
            cfg_write(ADDR_CMD, 32'(1 << CMD_START_BIT));
        end
    endtask

    task automatic pulse_stop();
        begin
            cfg_write(ADDR_CMD, 32'(1 << CMD_STOP_BIT));
        end
    endtask

    task automatic pulse_clear();
        begin
            cfg_write(ADDR_CMD, 32'(1 << CMD_CLEAR_COUNT_BIT));
            cfg_write(ADDR_CMD, 32'd0);
        end
    endtask

    logic [31:0] rd_data;
    logic [31:0] ctrl_word;

    initial begin
        rst_n          = 1'b0;
        ext_serial_in  = 1'b0;
        cfg_we         = 1'b0;
        cfg_re         = 1'b0;
        cfg_addr       = '0;
        cfg_wdata      = '0;
        ext_ref_en        = 1'b0;
        ext_ref_seed_load = 1'b0;
        ext_ref_mode_select = 1'b0;
        ext_ref_seed_in   = '0;
        tb_error_count = 0;

        // reset
        repeat (5) @(posedge clk);
        #1000;
        @(negedge clk);
        rst_n = 1'b1;
        #1000;
        repeat (2) @(posedge clk);

        // =====================================================
        // Case 1: PRBS7 internal, window mode, no error
        // CTRL = enable=1, mode=0, input_select=0, inject=0, continuous=0
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT] = 1'b1;

        program_common(ctrl_word, 32'h0000_0056, 32'd20);
        pulse_seed_load();
        pulse_start();
        wait_done_and_check_basic("prbs7_internal_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 2: restart after done
        // same config, re-start directly, should cleanly re-run from 0
        // =====================================================
        pulse_seed_load();
        pulse_start();
        wait_done_and_check_basic("restart_after_done", 32'd0, 32'd20);

        // =====================================================
        // Case 3: PRBS7 internal, inject error enabled
        // expect every bit to mismatch in internal loopback path
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT]       = 1'b1;
        ctrl_word[CTRL_INJECT_ERROR_BIT] = 1'b1;

        program_common(ctrl_word, 32'h0000_0056, 32'd20);
        pulse_seed_load();
        pulse_start();
        wait_done_and_check_basic("prbs7_internal_inject_error", 32'd20, 32'd20);

        // =====================================================
        // Case 4: PRBS15 internal, no error
        // mode_select = 1
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT] = 1'b1;
        ctrl_word[CTRL_MODE_BIT]   = 1'b1;

        program_common(ctrl_word, 32'h0000_5675, 32'd20);
        pulse_seed_load();
        pulse_start();
        wait_done_and_check_basic("prbs15_internal_no_error", 32'd0, 32'd20);

        // =====================================================
        // Case 5: continuous mode + stop pulse
        // should not auto-done by window, only stop when commanded
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT]          = 1'b1;
        ctrl_word[CTRL_CONTINUOUS_MODEBIT]  = 1'b1;

        program_common(ctrl_word, 32'h0000_0056, 32'd20);
        pulse_seed_load();
        pulse_start();

        // let it run for a while
        repeat (12) @(posedge clk);
        #1000;

        expect_bit("continuous_mode_busy_before_stop", busy, 1'b1);
        expect_bit("continuous_mode_done_before_stop", done, 1'b0);

        cfg_read(ADDR_TOTCNT, rd_data);
        if (rd_data == 32'd0) begin
            $display("[%0t] ERROR (continuous_mode_total_nonzero_before_stop): total_count is still 0", $time);
            tb_error_count++;
        end else begin
            $display("[%0t] PASS  (continuous_mode_total_nonzero_before_stop): total_count=%0d", $time, rd_data);
        end

        pulse_stop();

        @(posedge clk);
        #1000;

        expect_bit("continuous_mode_busy_after_stop", busy, 1'b0);
        expect_bit("continuous_mode_done_after_stop", done, 1'b1);

        // =====================================================
        // Case 6: external input mode, driven by dedicated TB reference generator
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT]       = 1'b1;
        ctrl_word[CTRL_INPUT_SELECT_BIT] = 1'b1;

        program_common(ctrl_word, 32'h0000_0056, 32'd20);

        // DUT seed pulse
        pulse_seed_load();

        // Align external reference generator load to the same effective load cycle
        ext_ref_mode_select = 1'b0;
        ext_ref_seed_in     = 15'h0056;
        ext_ref_seed_load   = 1'b1;
        ext_ref_en          = 1'b0;

        @(posedge clk);
        #1000;
        @(negedge clk);
        ext_ref_seed_load = 1'b0;

        // Drive external input from TB reference generator
        force ext_serial_in = ext_ref_bit;

        // DUT start pulse
        pulse_start();

        // Wait one cycle for measure_ctrl to consume start_pulse,
        // then enable external generator so first counted bit aligns
        @(posedge clk);
        #1000;
        @(negedge clk);
        ext_ref_en = 1'b1;

        wait_done_and_check_basic("external_input_match_ref", 32'd0, 32'd20);

        @(negedge clk);
        ext_ref_en = 1'b0;
        release ext_serial_in;
        ext_serial_in = 1'b0;
        
        // =====================================================
        // Case 7: manual clear during continuous mode
        // =====================================================
        ctrl_word = 32'd0;
        ctrl_word[CTRL_ENABLE_BIT]         = 1'b1;
        ctrl_word[CTRL_CONTINUOUS_MODEBIT] = 1'b1;

        program_common(ctrl_word, 32'h0000_0056, 32'd20);
        pulse_seed_load();
        pulse_start();

        repeat (8) begin
            @(posedge clk);
            #1000;
        end

        cfg_read(ADDR_TOTCNT, rd_data);
        if (rd_data == 32'd0) begin
            $display("[%0t] ERROR (manual_clear_midrun_total_nonzero_before_clear): total_count is still 0", $time);
            tb_error_count++;
        end else begin
            $display("[%0t] PASS  (manual_clear_midrun_total_nonzero_before_clear): total_count=%0d", $time, rd_data);
        end
        
        pulse_stop();

        @(posedge clk);
        #1000;
        expect_bit("manual_clear_midrun_busy_after_stop_pre_clear", busy, 1'b0);
        expect_bit("manual_clear_midrun_done_after_stop_pre_clear", done, 1'b1);

        pulse_clear();

        @(posedge clk);
        #1000;
        check_counters_zero("manual_clear_midrun");

        expect_bit("manual_clear_midrun_busy_after_stop", busy, 1'b0);
        expect_bit("manual_clear_midrun_done_after_stop", done, 1'b1);

        // =====================================================
        // Final report
        // =====================================================
        $display("========================================");
        if (tb_error_count == 0) begin
            $display("TEST PASSED: prbs_ber_chip_top extended tests passed.");
        end else begin
            $display("TEST FAILED: tb_error_count=%0d", tb_error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule