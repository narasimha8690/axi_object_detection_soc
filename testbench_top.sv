
`timescale 1ns / 1ps

module testbench_top;

  // Clock and reset signals
  logic ACLK;
  logic ARESETn;

  // AXI signals
  logic [31:0]  AWADDR;
  logic [7:0]   AWLEN;
  logic         AWVALID;
  logic         AWREADY;
  logic [31:0]  WDATA;
  logic         WVALID;
  logic         WREADY;
  logic         WLAST;
  logic [1:0]   BRESP;
  logic         BVALID;

  // Instantiate DUT
  axi_master_camera master (
    .ACLK(ACLK),
    .ARESETn(ARESETn),
    .AWADDR(AWADDR),
    .AWLEN(AWLEN),
    .AWVALID(AWVALID),
    .AWREADY(AWREADY),
    .WDATA(WDATA),
    .WVALID(WVALID),
    .WREADY(WREADY),
    .WLAST(WLAST),
    .BRESP(BRESP),
    .BVALID(BVALID)
  );

  axi_slave_memory slave (
    .ACLK(ACLK),
    .ARESETn(ARESETn),
    .AWADDR(AWADDR),
    .AWVALID(AWVALID),
    .AWREADY(AWREADY),
    .WDATA(WDATA),
    .WVALID(WVALID),
    .WREADY(WREADY),
    .WLAST(WLAST),
    .BRESP(BRESP),
    .BVALID(BVALID)
  );

  // Clock generator
  initial ACLK = 0;
  always #5 ACLK = ~ACLK; // 100MHz clock

  // Reset sequence
  initial begin
    ARESETn = 0;
    #20;
    ARESETn = 1;
  end

  // Simulation time control
  initial begin
    $dumpfile("waveform.vcd"); // optional: GTKWave
    $dumpvars(0, testbench_top);
    #500;
    $finish;
  end

endmodule
