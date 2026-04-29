`timescale 1ps/1ps

module prbs_ber_pad_top_tb;

    logic clk;
    logic rst_n;

    logic ext_serial_in;

    logic cfg_sclk;
    logic cfg_cs_n;
    logic cfg_mosi;
    logic cfg_miso;

    logic busy;
    logic done;
    logic prbs_out;
    logic bit_error;
    logic        ext_use_gen;
    logic        ext_invert;
    logic        ext_prbs_bit;
    logic [14:0] ext_seed_in;
    logic        ext_mode_select;

    int tb_error_count;
    int i;

    localparam logic [4:0] ADDR_CTRL   = 5'h00;
    localparam logic [4:0] ADDR_SEED   = 5'h04;
    localparam logic [4:0] ADDR_CMD    = 5'h08;
    localparam logic [4:0] ADDR_WINDOW = 5'h0C;
    localparam logic [4:0] ADDR_STATUS = 5'h10;
    localparam logic [4:0] ADDR_ERRCNT = 5'h14;
    localparam logic [4:0] ADDR_TOTCNT = 5'h18;
    localparam logic [4:0] ADDR_DBG           = 5'h1C;
    localparam logic [4:0] ADDR_LAST_ERRCNT   = 5'h01;
    localparam logic [4:0] ADDR_LAST_TOTCNT   = 5'h02;
    localparam logic [4:0] ADDR_LAST_STATUS   = 5'h03;
    localparam logic [4:0] ADDR_RUN_COUNT     = 5'h05;
    localparam logic [4:0] ADDR_PASS_COUNT    = 5'h06;
    localparam logic [4:0] ADDR_FAIL_COUNT    = 5'h07;
    localparam logic [4:0] ADDR_FIRST_ERR_IDX = 5'h09;
    localparam logic [4:0] ADDR_STICKY_STATUS = 5'h0A;
    localparam logic [4:0] ADDR_SNAPSHOT0     = 5'h0B;

    // CTRL bits from csr_regbank
    // bit0 ctrl_enable
    // bit1 mode_select
    // bit2 input_select
    // bit3 inject_error_enable
    // bit4 continuous_mode

    // CMD bits from csr_regbank
    // bit0 seed_load_pulse
    // bit1 manual_clear_pulse
    // bit2 start_pulse
    // bit3 stop_pulse

    prbs_ber_pad_top dut (
        .clk           (clk),
        .rst_n         (rst_n),
        .ext_serial_in (ext_serial_in),
        .cfg_sclk      (cfg_sclk),
        .cfg_cs_n      (cfg_cs_n),
        .cfg_mosi      (cfg_mosi),
        .cfg_miso      (cfg_miso),
        .busy          (busy),
        .done          (done),
        .prbs_out      (prbs_out),
        .bit_error     (bit_error)
    );

    prbs_gen_top u_ext_gen (
        .clk         (clk),
        .rst_n       (rst_n),
        .en          (dut.u_prbs_ber_chip_top.u_measure_ctrl.core_en),
        .seed_load   (dut.u_prbs_ber_chip_top.u_csr_regbank.seed_load_pulse),
        .mode_select (ext_mode_select),
        .seed_in     (ext_seed_in),
        .prbs_out    (ext_prbs_bit)
    );
    
    always_comb begin
        if (ext_use_gen) begin
            ext_serial_in = ext_invert ? ~ext_prbs_bit : ext_prbs_bit;
        end else begin
            ext_serial_in = 1'b0;
        end
    end

    // 250MHz system clock
    initial begin
        clk = 1'b0;
        forever #2000 clk = ~clk;   // 4ns period
    end

    task automatic wait_clk_cycles(input int n);
        begin
            repeat (n) @(posedge clk);
        end
    endtask

    // ------------------------------------------------------------
    // Serial protocol helpers
    // [39]    rw       (1=write, 0=read)
    // [38:34] addr
    // [33:2]  wdata
    // [1:0]   reserved
    // ------------------------------------------------------------
    task automatic serial_send_bit(input logic b);
        begin
            // Change MOSI only on negedge clk so it is stable before the next posedge.
            @(negedge clk);
            cfg_mosi = b;
            cfg_sclk = 1'b0;
    
            // Hold stable for two full clk cycles before cfg_sclk rises.
            repeat (2) @(posedge clk);
    
            // Raise cfg_sclk on negedge clk, far from the sampling posedge of clk-domain flops.
            @(negedge clk);
            cfg_sclk = 1'b1;
    
            // Hold high for two full clk cycles.
            repeat (2) @(posedge clk);
    
            // Drop cfg_sclk on negedge clk.
            @(negedge clk);
            cfg_sclk = 1'b0;
    
            // Leave one extra cycle for synchronizer settling.
            repeat (1) @(posedge clk);
        end
    endtask

    task automatic serial_write(
        input logic [4:0]  addr,
        input logic [31:0] data
    );
        logic [39:0] cmd;
        begin
            cmd = {1'b1, addr, data, 2'b00};

            @(negedge clk);
            cfg_cs_n = 1'b0;
            cfg_sclk = 1'b0;
            cfg_mosi = 1'b0;
            
            // Give synchronizers time to settle.
            repeat (2) @(posedge clk);
            
            for (i = 39; i >= 0; i = i - 1) begin
                serial_send_bit(cmd[i]);
            end
            
            @(negedge clk);
            cfg_cs_n = 1'b1;
            cfg_sclk = 1'b0;
            cfg_mosi = 1'b0;
            
            wait_clk_cycles(4);
        end
    endtask

    task automatic serial_read(
        input  logic [4:0]  addr,
        output logic [31:0] data
    );
        logic [39:0] cmd;
        begin
            cmd  = {1'b0, addr, 32'd0, 2'b00};
            data = 32'd0;

            @(negedge clk);
            cfg_cs_n = 1'b0;
            cfg_sclk = 1'b0;
            cfg_mosi = 1'b0;
            
            // Give synchronizers time to settle.
            repeat (2) @(posedge clk);
            
            // send 40-bit read command
            for (i = 39; i >= 0; i = i - 1) begin
                serial_send_bit(cmd[i]);
            end

            for (i = 31; i >= 0; i = i - 1) begin
                // launch read clock high on negedge clk
                @(negedge clk);
                cfg_sclk = 1'b1;
            
                // wait for clk-domain logic to settle through synchronizer / shifter
                repeat (2) @(posedge clk);
            
                // sample in the middle of the stable high phase
                data[i] = cfg_miso;
            
                @(negedge clk);
                cfg_sclk = 1'b0;
            
                repeat (1) @(posedge clk);
            end
            
            @(negedge clk);
            cfg_cs_n = 1'b1;
            cfg_sclk = 1'b0;
            cfg_mosi = 1'b0;
            
            wait_clk_cycles(4);
        end
    endtask

    task automatic expect_equal32(
        input string tag,
        input logic [31:0] got,
        input logic [31:0] exp
    );
        begin
            if (got !== exp) begin
                $display("[%0t] ERROR (%s): got=0x%08x expected=0x%08x",
                         $time, tag, got, exp);
                tb_error_count = tb_error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): value=0x%08x",
                         $time, tag, got);
            end
        end
    endtask

    task automatic expect_status_bits(
        input string tag,
        input logic exp_busy,
        input logic exp_done
    );
        logic [31:0] status_rd;
        begin
            serial_read(ADDR_STATUS, status_rd);

            if ((status_rd[0] !== exp_busy) || (status_rd[1] !== exp_done)) begin
                $display("[%0t] ERROR (%s): STATUS=0x%08x busy=%0b/%0b done=%0b/%0b",
                         $time, tag, status_rd, status_rd[0], exp_busy, status_rd[1], exp_done);
                tb_error_count = tb_error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): STATUS=0x%08x",
                         $time, tag, status_rd);
            end
        end
    endtask

    task automatic expect_nonzero32(
        input string tag,
        input logic [31:0] got
    );
        begin
            if (got == 32'd0) begin
                $display("[%0t] ERROR (%s): got zero", $time, tag);
                tb_error_count = tb_error_count + 1;
            end else begin
                $display("[%0t] PASS  (%s): value=%0d", $time, tag, got);
            end
        end
    endtask

    task automatic write_and_readback(
        input string       tag,
        input logic [4:0]  addr,
        input logic [31:0] data
    );
        logic [31:0] rd;
        begin
            serial_write(addr, data);
            serial_read(addr, rd);
            expect_equal32(tag, rd, data);
        end
    endtask


    task automatic expect_debug_counters(
        input string       tag,
        input logic [31:0] exp_last_err,
        input logic [31:0] exp_last_total,
        input logic [31:0] exp_run,
        input logic [31:0] exp_pass,
        input logic [31:0] exp_fail,
        input logic [31:0] exp_sticky
    );
        logic [31:0] rd;
        begin
            serial_read(ADDR_LAST_ERRCNT, rd);
            expect_equal32({tag, "_last_errcnt"}, rd, exp_last_err);
            serial_read(ADDR_LAST_TOTCNT, rd);
            expect_equal32({tag, "_last_totcnt"}, rd, exp_last_total);
            serial_read(ADDR_RUN_COUNT, rd);
            expect_equal32({tag, "_run_count"}, rd, exp_run);
            serial_read(ADDR_PASS_COUNT, rd);
            expect_equal32({tag, "_pass_count"}, rd, exp_pass);
            serial_read(ADDR_FAIL_COUNT, rd);
            expect_equal32({tag, "_fail_count"}, rd, exp_fail);
            serial_read(ADDR_STICKY_STATUS, rd);
            expect_equal32({tag, "_sticky_status"}, rd, exp_sticky);
        end
    endtask

    initial begin
        rst_n           = 1'b0;
        ext_use_gen     = 1'b0;
        ext_invert      = 1'b0;
        ext_seed_in     = 15'd0;
        ext_mode_select = 1'b0;
        cfg_sclk        = 1'b0;
        cfg_cs_n        = 1'b1;
        cfg_mosi        = 1'b0;
        tb_error_count  = 0;

        wait_clk_cycles(5);
        @(negedge clk);
        rst_n = 1'b1;
        wait_clk_cycles(5);

        // --------------------------------------------------------
        // Case 1: reset defaults
        // --------------------------------------------------------
        begin
            logic [31:0] rd;
            serial_read(ADDR_SEED, rd);
            expect_equal32("default_seed_reg", rd, 32'd1);

            serial_read(ADDR_WINDOW, rd);
            expect_equal32("default_window_reg", rd, 32'd20);

            serial_read(ADDR_STICKY_STATUS, rd);
            expect_equal32("default_sticky_status", rd, 32'd0);
        end

        // --------------------------------------------------------
        // Case 2: PRBS7 internal no error
        // CTRL = 0x1 : enable
        // --------------------------------------------------------
        write_and_readback("ctrl_case2_readback",   ADDR_CTRL,   32'h0000_0001);
        write_and_readback("seed_case2_readback",   ADDR_SEED,   32'h0000_0056);
        write_and_readback("window_case2_readback", ADDR_WINDOW, 32'd20);

        serial_write(ADDR_CMD, 32'h0000_0001);  // seed_load
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);  // start
        wait (done == 1'b1);
        wait_clk_cycles(4);

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("prbs7_internal_no_error_errcnt", rd, 32'd0);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("prbs7_internal_no_error_totcnt", rd, 32'd20);
        end

        expect_status_bits("status_after_prbs7_internal", 1'b0, 1'b1);
        expect_debug_counters("dbg_after_prbs7_pass", 32'd0, 32'd20, 32'd1, 32'd1, 32'd0, 32'h0000_0001);

        // --------------------------------------------------------
        // Case 3: manual clear
        // --------------------------------------------------------
        serial_write(ADDR_CMD, 32'h0000_0002);
        wait_clk_cycles(4);

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("manual_clear_errcnt", rd, 32'd0);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("manual_clear_totcnt", rd, 32'd0);
        end

        expect_debug_counters("dbg_after_manual_clear", 32'd0, 32'd0, 32'd0, 32'd0, 32'd0, 32'h0000_0000);

        // --------------------------------------------------------
        // Case 4: PRBS7 internal inject error
        // CTRL = enable + inject_error_enable = 0x9
        // --------------------------------------------------------
        write_and_readback("ctrl_case4_readback", ADDR_CTRL, 32'h0000_0009);
        write_and_readback("seed_case4_readback", ADDR_SEED, 32'h0000_0056);

        serial_write(ADDR_CMD, 32'h0000_0001);
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);
        wait (done == 1'b1);
        wait_clk_cycles(4);

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("prbs7_internal_inject_error_errcnt", rd, 32'd20);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("prbs7_internal_inject_error_totcnt", rd, 32'd20);

            serial_read(ADDR_FIRST_ERR_IDX, rd);
            expect_equal32("prbs7_internal_inject_first_err_idx", rd, 32'd0);
        end

        expect_debug_counters("dbg_after_prbs7_fail", 32'd20, 32'd20, 32'd1, 32'd0, 32'd1, 32'h0000_000B);

        // --------------------------------------------------------
        // Case 5: clear before PRBS15
        // --------------------------------------------------------
        serial_write(ADDR_CMD, 32'h0000_0002);
        wait_clk_cycles(4);

        // --------------------------------------------------------
        // Case 6: PRBS15 internal no error
        // CTRL = enable + mode_select = 0x3
        // --------------------------------------------------------
        write_and_readback("ctrl_case6_readback",   ADDR_CTRL,   32'h0000_0003);
        write_and_readback("seed_case6_readback",   ADDR_SEED,   32'h0000_55D5);
        write_and_readback("window_case6_readback", ADDR_WINDOW, 32'd20);

        serial_write(ADDR_CMD, 32'h0000_0001);
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);
        wait (done == 1'b1);
        wait_clk_cycles(4);

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("prbs15_internal_no_error_errcnt", rd, 32'd0);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("prbs15_internal_no_error_totcnt", rd, 32'd20);
        end

        expect_debug_counters("dbg_after_prbs15_pass", 32'd0, 32'd20, 32'd1, 32'd1, 32'd0, 32'h0000_0001);

        // --------------------------------------------------------
        // Case 7: clear before PRBS15 inject
        // --------------------------------------------------------
        serial_write(ADDR_CMD, 32'h0000_0002);
        wait_clk_cycles(4);

        // --------------------------------------------------------
        // Case 8: PRBS15 internal inject error
        // CTRL = enable + mode_select + inject_error_enable = 0xB
        // --------------------------------------------------------
        write_and_readback("ctrl_case8_readback", ADDR_CTRL, 32'h0000_000B);
        write_and_readback("seed_case8_readback", ADDR_SEED, 32'h0000_55D5);

        serial_write(ADDR_CMD, 32'h0000_0001);
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);
        wait (done == 1'b1);
        wait_clk_cycles(4);

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("prbs15_internal_inject_error_errcnt", rd, 32'd20);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("prbs15_internal_inject_error_totcnt", rd, 32'd20);
        end

        expect_debug_counters("dbg_after_prbs15_fail", 32'd20, 32'd20, 32'd1, 32'd0, 32'd1, 32'h0000_000B);

        // --------------------------------------------------------
        // Case 9: clear before external no-error case
        // --------------------------------------------------------
        serial_write(ADDR_CMD, 32'h0000_0002);
        wait_clk_cycles(4);

        // --------------------------------------------------------
        // Case 10: external mode, matched external PRBS source
        // CTRL = enable + input_select = 0x5
        // Expect 0 errors over 20 bits
        // --------------------------------------------------------
        write_and_readback("ctrl_case10_readback",   ADDR_CTRL,   32'h0000_0005);
        write_and_readback("seed_case10_readback",   ADDR_SEED,   32'h0000_0056);
        write_and_readback("window_case10_readback", ADDR_WINDOW, 32'd20);

        ext_mode_select = 1'b0;
        ext_seed_in     = 15'h0056;
        ext_invert      = 1'b0;
        ext_use_gen     = 1'b1;

        serial_write(ADDR_CMD, 32'h0000_0001);  // seed_load
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);  // start
        wait (done == 1'b1);
        wait_clk_cycles(4);

        ext_use_gen = 1'b0;

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("external_match_errcnt", rd, 32'd0);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("external_match_totcnt", rd, 32'd20);
        end

        expect_debug_counters("dbg_after_external_match", 32'd0, 32'd20, 32'd1, 32'd1, 32'd0, 32'h0000_0001);

        // --------------------------------------------------------
        // Case 11: clear before external inverted-source case
        // --------------------------------------------------------
        serial_write(ADDR_CMD, 32'h0000_0002);
        wait_clk_cycles(4);

        // --------------------------------------------------------
        // Case 12: external mode, inverted external PRBS source
        // CTRL = enable + input_select = 0x5
        // Expect all 20 bits wrong
        // --------------------------------------------------------
        write_and_readback("ctrl_case12_readback",   ADDR_CTRL,   32'h0000_0005);
        write_and_readback("seed_case12_readback",   ADDR_SEED,   32'h0000_0056);
        write_and_readback("window_case12_readback", ADDR_WINDOW, 32'd20);

        ext_mode_select = 1'b0;
        ext_seed_in     = 15'h0056;
        ext_invert      = 1'b1;
        ext_use_gen     = 1'b1;

        serial_write(ADDR_CMD, 32'h0000_0001);  // seed_load
        wait_clk_cycles(4);

        serial_write(ADDR_CMD, 32'h0000_0004);  // start
        wait (done == 1'b1);
        wait_clk_cycles(4);

        ext_use_gen = 1'b0;
        ext_invert  = 1'b0;

        begin
            logic [31:0] rd;
            serial_read(ADDR_ERRCNT, rd);
            expect_equal32("external_invert_errcnt", rd, 32'd20);

            serial_read(ADDR_TOTCNT, rd);
            expect_equal32("external_invert_totcnt", rd, 32'd20);
        end

        expect_debug_counters("dbg_after_external_invert", 32'd20, 32'd20, 32'd1, 32'd0, 32'd1, 32'h0000_000B);

        $display("========================================");
        if (tb_error_count == 0) begin
            $display("TEST PASSED: prbs_ber_pad_top checks succeeded.");
        end else begin
            $display("TEST FAILED: tb_error_count = %0d", tb_error_count);
            $fatal(1);
        end
        $display("========================================");

        $finish;
    end

endmodule