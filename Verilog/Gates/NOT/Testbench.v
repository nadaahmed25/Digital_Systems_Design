module tb;
reg A;
wire B;
NOT_Gate not0 (.A(A),.B(B));
initial begin
$monitor ("T=%0t A=%0b  B=%0b",$time,A,B);
#10 A=0;
#30 A=1;
#70 A=0;
end
endmodule