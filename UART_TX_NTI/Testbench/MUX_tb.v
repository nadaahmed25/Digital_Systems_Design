`timescale 1ns/1ns
module MUX_tb;
reg a,b,c,d;
reg [1:0]sel;
wire f;

MUX u0 (.idle(a),.start(b),.data(c),.parity(d),.sel(sel),.TX(f));

initial begin
a <= 0;
b <= 1;
c <= 0;
d <= 1;
sel = 2'b00;
 
#10;
sel = 2'b01;

#10;
sel = 2'b10;

#10;
sel = 2'b11;

#10;
a <= 0;
b <= 1;
c <= 1;
d <= 1;
sel = 2'b00;
 
#10;
sel = 2'b01;

#10;
sel = 2'b10;

#10;
sel = 2'b11;

#10;
$finish;
end
endmodule

