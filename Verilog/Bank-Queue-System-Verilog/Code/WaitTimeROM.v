`timescale 10ns / 1ns
/*###############################################################################
 waitTime_rom saves the waiting time values.  
//###############################################################################*/
module waitTime_rom (input [4:0] addr,  output [7:0] data);
 reg [7:0] arom [0:31];
  initial begin
  $readmemb("waitTime_rom.txt", arom);
end
  assign data = arom[addr]; 
endmodule

