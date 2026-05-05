module prbs_ber_chip_top (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        ext_serial_in,

    input  logic        cfg_we,
    input  logic        cfg_re,
    input  logic [4:0]  cfg_addr,
    input  logic [31:0] cfg_wdata,
    output logic [31:0] cfg_rdata,

    output logic        busy,
    output logic        done,
    output logic        prbs_out,
    output logic        bit_error,

    // Bring-up / debug outputs
    output logic        ref_bit,
    output logic        checker_in,
    output logic        checker_in_final,
    output logic        core_en,
    output logic        cfg_we_dbg,
    output logic        cfg_re_dbg,
    output logic        mode_select_dbg,
    output logic        input_select_dbg,
    output logic        inject_error_enable_dbg
);

    logic        ctrl_enable;
    logic        mode_select;
    logic        input_select;
    logic        inject_error_enable;
    logic        continuous_mode;
    logic [14:0] seed_value;
    logic [31:0] window_cfg;

    logic        seed_load_pulse;
    logic        start_pulse;
    logic        stop_pulse;
    logic        manual_clear_pulse;

    logic        clear_count_pulse;
    logic        overflow;

    logic [31:0] error_count;
    logic [31:0] total_count;

    // ------------------------------------------------------------
    // CSR register bank
    // ------------------------------------------------------------
    csr_regbank u_csr_regbank (
        .clk                 (clk),
        .rst_n               (rst_n),

        .cfg_we              (cfg_we),
        .cfg_re              (cfg_re),
        .cfg_addr            (cfg_addr),
        .cfg_wdata           (cfg_wdata),
        .cfg_rdata           (cfg_rdata),

        .busy                (busy),
        .done                (done),
        .overflow            (overflow),
        .bit_error           (bit_error),
        .prbs_out            (prbs_out),
        .checker_in          (checker_in),
        .checker_in_final    (checker_in_final),
        .ref_bit             (ref_bit),
        .error_count         (error_count),
        .total_count         (total_count),

        .ctrl_enable         (ctrl_enable),
        .mode_select         (mode_select),
        .input_select        (input_select),
        .inject_error_enable (inject_error_enable),
        .continuous_mode     (continuous_mode),
        .seed_value          (seed_value),
        .window_cfg          (window_cfg),

        .seed_load_pulse     (seed_load_pulse),
        .start_pulse         (start_pulse),
        .stop_pulse          (stop_pulse),
        .manual_clear_pulse  (manual_clear_pulse)
    );

    // ------------------------------------------------------------
    // Measurement controller
    // ------------------------------------------------------------
    measure_ctrl u_measure_ctrl (
        .clk               (clk),
        .rst_n             (rst_n),

        .start_pulse       (start_pulse),
        .stop_pulse        (stop_pulse),
        .continuous_mode   (continuous_mode),
        .window_cfg        (window_cfg),
        .total_count       (total_count),

        .core_en           (core_en),
        .clear_count_pulse (clear_count_pulse),
        .busy              (busy),
        .done              (done),
        .overflow          (overflow)
    );

    // ------------------------------------------------------------
    // PRBS generator + BER checker core
    // ------------------------------------------------------------
    prbs_ber_top u_prbs_ber_top (
        .clk                 (clk),
        .rst_n               (rst_n),

        .en                  (core_en & ctrl_enable),
        .clear_count         (clear_count_pulse | manual_clear_pulse),
        .seed_load           (seed_load_pulse),
        .mode_select         (mode_select),
        .seed_in             (seed_value),
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

    // ------------------------------------------------------------
    // Bring-up / debug output assignments
    // ------------------------------------------------------------
    assign cfg_we_dbg                 = cfg_we;
    assign cfg_re_dbg                 = cfg_re;
    assign mode_select_dbg            = mode_select;
    assign input_select_dbg           = input_select;
    assign inject_error_enable_dbg    = inject_error_enable;

endmodule