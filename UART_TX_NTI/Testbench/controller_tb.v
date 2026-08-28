`timescale 1ns/1ns
module Controller_tb;
parameter N = 8;
reg V_IN, RST,CLK, P_EN;
wire Busy,load ,Serializer_control;
wire [1:0] MUX_SEL;
wire [N-1:0]  Data_Bits_count;

Controller #(.N(N)) dut (.V_IN(V_IN),.RST(RST),.CLK(CLK),
                         .P_EN(P_EN),.Busy(Busy),
                         .MUX_SEL(MUX_SEL),.load(load),
                         .Serializer_control(Serializer_control),
                         .Data_Bits_count(Data_Bits_count));

always #5 CLK = ~CLK;

initial begin
CLK  = 0;
V_IN = 0;
RST  = 0;
P_EN = 0;

#10;
RST = 1;

#10;
V_IN = 1;

#10;
V_IN = 0;
#100;

P_EN = 1;

#10;
V_IN = 1;

#10;
V_IN = 0;
#100;

$finish;
end
endmodule