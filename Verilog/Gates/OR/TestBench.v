module tb;
reg A ,B;
wire C ;
OR_Gate or0 (.A(A),.B(B),.C(C)) ;
initial begin 
 #10 A = 0; B = 0;
 #10 A = 0; B = 1;
 #10 A = 1; B = 0;
 #10 A = 1; B = 1;
 end
endmodule
