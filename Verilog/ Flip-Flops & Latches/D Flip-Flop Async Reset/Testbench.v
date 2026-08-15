module tb;
reg d;
reg en;
reg rstn;
reg clk;
wire q;
integer i;
always #10 clk = ~clk;
DFF dff (.d(d), .en(en),.rstn(rstn),.clk(clk) ,.q(q));
initial begin
$monitor ("Time=%0t  rstn=%0b  EN=%0b  D=%0b  Q=%0b ", $time , rstn , en , d , q );
clk<=0;
d<=0;
rstn<=0;
en<=0;
#10 d<=1;
#10 rstn<=1; d<=0;
for ( i=0 ; i<4 ; i=i+1) begin 
{en,d}=i;
#10;
end
end
endmodule