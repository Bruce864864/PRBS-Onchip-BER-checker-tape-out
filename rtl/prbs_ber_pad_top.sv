module prbs_ber_pad_top (
    input  logic clk,
    input  logic rst_n,

    input  logic ext_serial_in,

    input  logic cfg_sclk,
    input  logic cfg_cs_n,
    input  logic cfg_mosi,
    output logic cfg_miso,

    output logic busy,
    output logic done,
    output logic prbs_out,
    output logic bit_error
);

    logic        cfg_we;
    logic        cfg_re;
    logic [4:0]  cfg_addr;
    logic [31:0] cfg_wdata;
    logic [31:0] cfg_rdata;

    cfg_serial_if u_cfg_serial_if (
        .clk       (clk),
        .rst_n     (rst_n),
        .cfg_sclk  (cfg_sclk),
        .cfg_cs_n  (cfg_cs_n),
        .cfg_mosi  (cfg_mosi),
        .cfg_miso  (cfg_miso),
        .cfg_we    (cfg_we),
        .cfg_re    (cfg_re),
        .cfg_addr  (cfg_addr),
        .cfg_wdata (cfg_wdata),
        .cfg_rdata (cfg_rdata)
    );

    prbs_ber_chip_top u_prbs_ber_chip_top (
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

endmodule