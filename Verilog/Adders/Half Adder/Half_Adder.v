module HA ( input a, b,	output reg sum, cout);
	always @ (a or b) begin
		{cout, sum} = a + b;
	end

endmodule 
// Concatenation {cout, sum} receives 2-bit result
// a + b produces: cout (carry) in bit[1], sum in bit[0]