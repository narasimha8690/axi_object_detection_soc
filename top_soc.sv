
module top_soc();
  logic         ACLK, ARESETn;
  logic [31:0]  AWADDR, WDATA;
  logic [7:0]   AWLEN;
  logic         AWVALID, AWREADY;
  logic         WVALID, WREADY, WLAST;
  logic [1:0]   BRESP;
  logic         BVALID;

  axi_master_camera master (
    .ACLK, .ARESETn,
    .AWADDR, .AWLEN, .AWVALID, .AWREADY,
    .WDATA, .WVALID, .WREADY, .WLAST,
    .BRESP, .BVALID
  );

  axi_slave_memory slave (
    .ACLK, .ARESETn,
    .AWADDR, .AWVALID, .AWREADY,
    .WDATA, .WVALID, .WREADY, .WLAST,
    .BRESP, .BVALID
  );

  initial begin
    ACLK = 0; forever #5 ACLK = ~ACLK;
  end

  initial begin
    ARESETn = 0;
    #20 ARESETn = 1;
    #200 $finish;
  end
endmodule
