module image_processing_unit (
  input  logic [31:0] pixel_data,
  output logic        object_detected
);
  parameter THRESHOLD = 32'hABC00008;

  always_comb begin
    object_detected = (pixel_data > THRESHOLD);
  end
endmodule