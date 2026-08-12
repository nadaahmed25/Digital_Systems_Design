`timescale 10ns / 1ns
/*###############################################################################
  UpDownCounter counts the number of customers according to photocell sensors at both ends of the queue. 
##############################################################################*/
module upDownCounter #(parameter counterwidth = 3)(input rstn , clk , enable , upDown , output reg [counterwidth-1:0] pCount);
always @(posedge clk or negedge rstn) begin
		if (!rstn) pCount <= 0;
		else begin
		   if (enable) begin 
                            if (upDown) pCount <= pCount + 1; 
			    else        pCount <= pCount - 1; 
				end
		   else  pCount <= pCount;  
			end
end   
endmodule


 
  

