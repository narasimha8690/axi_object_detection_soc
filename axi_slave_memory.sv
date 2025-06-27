
module axi_slave_memory (
  input  logic        ACLK,
  input  logic        ARESETn,
  input  logic [31:0] AWADDR,
  input  logic        AWVALID,
  output logic        AWREADY,
  input  logic [31:0] WDATA,
  input  logic        WVALID,
  output logic        WREADY,
  input  logic        WLAST,
  output logic        BVALID,
  output logic [1:0]  BRESP
);

  logic [31:0] mem [0:255];

  assign AWREADY = 1;
  assign WREADY  = 1;
  assign BRESP   = 2'b00;

  always_ff @(posedge ACLK) begin
    if (!ARESETn) begin
      BVALID <= 0;
    end else if (WVALID && WREADY) begin
      mem[AWADDR[7:0]] <= WDATA;
      if (WLAST) BVALID <= 1;
    end else begin
      BVALID <= 0;
    end
  end
endmodule
