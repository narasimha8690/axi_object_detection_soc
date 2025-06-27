module axi_master_reader (
  input  logic        ACLK,
  input  logic        ARESETn,
  output logic [31:0] ARADDR,
  output logic [7:0]  ARLEN,
  output logic        ARVALID,
  input  logic        ARREADY,
  input  logic [31:0] RDATA,
  input  logic        RVALID,
  output logic        RREADY,
  input  logic        RLAST
);
  logic [7:0] read_cnt;
  logic       start_read;

  always_ff @(posedge ACLK or negedge ARESETn) begin
    if (!ARESETn) begin
      ARADDR  <= 32'h00001000;
      ARLEN   <= 8'd15;
      ARVALID <= 1;
      read_cnt <= 0;
      start_read <= 0;
    end else if (ARVALID && ARREADY) begin
      ARVALID <= 0;
      start_read <= 1;
    end
  end

  assign RREADY = 1;

  always_ff @(posedge ACLK) begin
    if (!ARESETn) begin
      read_cnt <= 0;
    end else if (RVALID && start_read) begin
      $display("Read Data: %h", RDATA);
      read_cnt <= read_cnt + 1;
      if (RLAST) start_read <= 0;
    end
  end
endmodule