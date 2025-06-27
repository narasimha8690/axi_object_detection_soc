module decision_unit (
  input  logic object_detected,
  output logic brake_signal
);
  always_comb begin
    brake_signal = object_detected;
  end
endmodule