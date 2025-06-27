
module axi_master_camera (
  input  logic         ACLK,
  input  logic         ARESETn,
  output logic [31:0]  AWADDR,
  output logic [7:0]   AWLEN,
  output logic         AWVALID,
  input  logic         AWREADY,
  output logic [31:0]  WDATA,
  output logic         WVALID,
  input  logic         WREADY,
  output logic         WLAST,
  input  logic [1:0]   BRESP,
  input  logic         BVALID
);

  logic [7:0] burst_cnt;
  logic       write_done;

  always_ff @(posedge ACLK or negedge ARESETn) begin
    if (!ARESETn) begin
      AWADDR  <= 32'h0000_1000;
      AWLEN   <= 8'd15;
      AWVALID <= 1'b1;
      burst_cnt <= 0;
    end else if (AWREADY && AWVALID) begin
      AWVALID <= 0;
    end
  end

  always_ff @(posedge ACLK) begin
    if (!ARESETn) begin
      WVALID <= 0;
      WLAST  <= 0;
    end else if (burst_cnt < 16) begin
      if (WREADY) begin
        WDATA  <= 32'hABC00000 + burst_cnt;
        WVALID <= 1;
        burst_cnt <= burst_cnt + 1;
        if (burst_cnt == 15) WLAST <= 1;
      end
    end else begin
      WVALID <= 0;
      WLAST  <= 0;
    end
  end

endmodule
