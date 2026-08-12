`timescale 10ns / 1ns
//##### Testbench for BQS #####*/
module BQS_tb;
wire emptyFlag, fullFlag; 
wire emptyAlarm, fullAlarm; 
wire [6:0] pCountDisplay, waitTimeDisplay_1, waitTimeDisplay_2; 
    reg rstn;
    reg clk;
    reg frontSensorInput;
    reg backSensorInput;
    reg [2:0] tellers;

BQS  #(.counterwidth(3)) BQS_testUnit( 
        .rstn(rstn),
        .clk(clk),
        .frontSensorInput(frontSensorInput),
        .backSensorInput(backSensorInput),.tellers(tellers), 
		.emptyFlag(emptyFlag), .fullFlag(fullFlag), 
		.emptyAlarm(emptyAlarm), .fullAlarm(fullAlarm),
		.pCountDisplay(pCountDisplay), .waitTimeDisplay_1(waitTimeDisplay_1), .waitTimeDisplay_2(waitTimeDisplay_2));
initial begin
    clk <= 0;
end
always #50 clk <= ~clk;
 initial begin
		$display("--------------------------- Test Bench for BQS --------------------------------     ");
		$monitor("Time :%0t | rstn :%0b | frontSensor :%0b | backSensor :%0b | tellers :%0b | emptyFlag :%0b | fullFlag :%0b | emptyAlarm :%0b | fullAlarm :%0b| pCount :%0b", 
                          $time, rstn, frontSensorInput, backSensorInput, tellers,  emptyFlag,  fullFlag,  emptyAlarm, fullAlarm, pCountDisplay);
        rstn <= 0;
        frontSensorInput <= 1;
        backSensorInput  <= 1;
        tellers <= 3'b001;
        #100;              
        rstn <= 1;            
        #100;                
        # 100 frontSensorInput <= 0;
        # 100 frontSensorInput <= 1;		
        $stop;
    end
endmodule


