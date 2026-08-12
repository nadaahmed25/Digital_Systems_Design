`timescale 10ns / 1ns
/*###############################################################################
  EdgeDetector detects entry or exit accurately and generates a single pulse on the rising or falling edge of the photocell signal. 
  ############################################################################### */
module edgeDetector ( input sensorInput, rstn, clk, output edgeEvent);
wire delayInput;
D_FF delayUnit (.d(sensorInput), .rstn(rstn), .clk(clk), .q(delayInput));
assign edgeEvent = delayInput & ~sensorInput; 
endmodule


