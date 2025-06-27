module control_unit (
  input  logic brake_signal
);
  always_ff @(brake_signal) begin
    if (brake_signal) $display("Control Unit: Brake Activated!");
    else $display("Control Unit: Keep Driving");
  end
endmodule