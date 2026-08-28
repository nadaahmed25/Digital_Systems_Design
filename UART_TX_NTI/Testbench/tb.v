`timescale 1ns/1ns
module UART_tb;
parameter N=8;
reg V_IN ,CLK , RST , P_EN , P_Bit;
reg [7:0] P_IN ;
wire busy ,TX_OUT;

UART_TX #(.N(N)) dut (.V_IN(V_IN),.CLK(CLK),.RST(RST),
                      .P_EN(P_EN),.P_Bit(P_Bit),.P_IN(P_IN),
                      .busy(busy),.TX_OUT(TX_OUT));

always #5 CLK = ~CLK;

initial begin

CLK  <= 0;
RST  <= 0;
V_IN <= 0;
P_EN <= 0;
P_Bit <= 0;
P_IN <= 0;

#10;
RST = 1;

#10;
P_IN = 8'b01110110;
P_EN = 0;
P_Bit = 0;
V_IN = 1;

#10;
V_IN = 0;
#100;


P_IN = 8'b01110110;
P_EN = 1;
P_Bit = 0;
V_IN = 1;

#10;
V_IN = 0;
#110;


P_IN = 8'b01110110;
P_EN = 1;
P_Bit =1;
V_IN = 1;

#10;
V_IN = 0;
#110;
$finish;
 end
endmodule