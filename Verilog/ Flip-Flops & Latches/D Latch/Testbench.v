module tb;
reg d;
reg en;
reg rstn;
wire q;
integer i;
D_Latch D (.d(d), .en(en),.rstn(rstn) ,.q(q));
initial begin
$monitor ("Time=%0t  rstn=%0b  EN=%0b  D=%0b  Q=%0b ", $time , rstn , en , d , q );
d<=0;
rstn<=0;
en<=0;
#10 rstn<=1;
for ( i=0 ; i<4 ; i=i+1) begin 
{en,d}=i;
#10 ;
end
end
endmodule