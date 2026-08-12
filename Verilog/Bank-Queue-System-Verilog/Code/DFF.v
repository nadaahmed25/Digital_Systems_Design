`timescale 10ns / 1ns
/*#### Asynchronous Negative Edge Reset D-flipflop #### */
module D_FF ( input d, rstn, clk, output reg q ) ;
always @ (posedge clk or negedge rstn)
	begin
		if (!rstn)   q <= 0;
		else         q <= d;
	end
endmodule


