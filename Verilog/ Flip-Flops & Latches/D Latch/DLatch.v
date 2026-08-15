module D_Latch (input d,en,rstn,output reg q);
always @(d or en or rstn) begin 
if (!rstn) q<= 0 ;
else 
if (en) q<=d;
end
endmodule
