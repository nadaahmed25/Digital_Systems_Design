`timescale 10ns / 1ns
/*##################### FSM  works as a main controller #####################*/
module controllerFSM #(parameter empty = 2'b00,count = 2'b01,full  = 2'b10,counterwidth = 3)
( input rstn, clk, leaveSensorEvent, enterSensorEvent, input [counterwidth-1:0] pCount, output reg enable,output reg upDown,output emptyFlag, fullFlag, emptyAlarm, fullAlarm);
reg [1:0] state;
     nor(emptyFlag, pCount[2],pCount[1],pCount[0]);   // empty flag , Once customers number equal to zeros
     and(fullFlag,pCount[2],pCount[1],pCount[0]);     // full flag , Once customers number equal to seven
     assign emptyAlarm = (emptyFlag & leaveSensorEvent)? 1'b1: 1'b0;  // empty alarm if the queue is empty and someone tries to leave the queue
     assign fullAlarm = (fullFlag & enterSensorEvent)? 1'b1: 1'b0;    // full alarm if the queue is full and someone tries to enter the queue
always @(posedge clk or negedge rstn) begin
		if (!rstn) begin // the output of counter is zero at negative reset
				state <= empty;
				enable	  <= 1'b0;
				upDown	  <= 1'b0;
			end
		else       begin
				case(state) 		
					empty: begin // empty state where no customers in the queue. 
						case ({enterSensorEvent,leaveSensorEvent })
							2'b00, 2'b11, 2'b01 : begin enable <= 1'b0; upDown <= 1'b0;  end  
							2'b10 :  begin state <= count; enable <= 1'b1; upDown <= 1'b1; end 
						endcase
					end
					count: begin // count up and down state based on enter and leave customers. 		
						case ({enterSensorEvent,leaveSensorEvent })
							2'b00, 2'b11 :  begin enable <= 1'b0; upDown <= 1'b0; end
							2'b10 : begin 	
									if (pCount < 7) begin 
										state <= count; 
										enable <= 1'b1; upDown	<= 1'b1; end
									else  begin 
										state <= full; 
										enable <= 1'b0; upDown	<= 1'b0; end
								end	
							2'b01 : begin
									if (pCount > 0) begin 
										state <= count; 
										enable <= 1'b1; upDown	<= 1'b0; end
									else 
										begin 
										state <= empty; 
										enable <= 1'b0; upDown	<= 1'b0; end
								end		
						endcase
					end		
					full: begin // full state where customers fulfill the queue. 	
						case ({enterSensorEvent,leaveSensorEvent })
							2'b00, 2'b11, 2'b10 : begin enable <= 1'b0; upDown <= 1'b0; end  
							2'b01 :  begin state <= count; enable <= 1'b1; upDown <= 1'b0; end
						endcase
					end
				endcase
			end 
	end
endmodule