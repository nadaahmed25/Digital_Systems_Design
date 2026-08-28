`timescale 1ns / 1ns
module parity_generator_tb;
reg  P_valid,P_Bit;
reg  [7:0] Data_Bits;
wire parity_out;
parameter N=8;
P_C #(.N(N))  dut (.P_valid(P_valid),.P_Bit(P_Bit),
                  .Data_Bits(Data_Bits),.parity_out(parity_out));

initial begin
P_valid =0;
P_Bit=0;
Data_Bits=0;

#10;
P_valid=1;
P_Bit=0;
Data_Bits =$random;

#30;
P_valid=1;
P_Bit=1;
Data_Bits =$random;

#50;
$finish;
end 
endmodule
