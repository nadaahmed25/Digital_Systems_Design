`timescale 1ns / 1ns
module serializer_tb;
reg CLK ,RST ,Serializer_control,load;
reg [7:0] P_IN;
wire out;
parameter N=8;

serializer  #(.N(N)) dut (.P_IN(P_IN),.CLK(CLK) ,.RST(RST) ,
               .Serializer_control(Serializer_control),
               .load(load),.out(out));

always #5 CLK = ~CLK;

initial begin
CLK  = 0;
RST  = 0;
P_IN = 0;
load = 0;
Serializer_control = 0;

#10;
RST =1;

#10;
P_IN = $random;
load =1;

#10;
load =0;
Serializer_control = 1;

#80;
Serializer_control = 0;

#10;
$finish;
end
endmodule
