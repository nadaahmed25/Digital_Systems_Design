`timescale 10ns / 1ns
/*########## Top module integrates all sub modules in the design ##########*/
module BQS #(parameter counterwidth = 3)
  (input rstn, clk, frontSensorInput, backSensorInput, input [2:0] tellers,
   output emptyFlag, fullFlag, emptyAlarm, fullAlarm, 
   output [6:0] pCountDisplay,output [6:0] waitTimeDisplay_1,output [6:0] waitTimeDisplay_2);

wire leaveSensorEvent, enterSensorEvent , enable, upDown;
wire [counterwidth-1:0] pCount;
wire [4:0] addr; 
wire [1:0] tellersCount; 
wire [7:0] data;

edgeDetector frontSensorEdgeDetect     (.sensorInput(frontSensorInput),.rstn(rstn),.clk(clk),.edgeEvent(leaveSensorEvent));  // front sensor edge detector 
edgeDetector backSensorEdgeDetect      (.sensorInput(backSensorInput),.rstn(rstn),.clk(clk),.edgeEvent(enterSensorEvent));   // back sensor edge detector 
upDownCounter customersCounter         (.rstn(rstn),.clk(clk),.enable(enable),.upDown(upDown),.pCount(pCount));              // customers counter 
controllerFSM controllerBQS            (.rstn(rstn),.clk(clk),.leaveSensorEvent(leaveSensorEvent),.enterSensorEvent(enterSensorEvent),
                                        .pCount(pCount),.enable(enable),.upDown(upDown),
                                        .emptyFlag(emptyFlag),.fullFlag(fullFlag),.emptyAlarm(emptyAlarm),.fullAlarm(fullAlarm)); // fsm controller
waitTime_rom waitTimeRom               (.addr(addr),.data(data)); // waiting time rom 
sevenSegmentsDecoder customersDisplay  (.binaryCode({1'b0,pCount}),.decimalPattern(pCountDisplay) );   // display unit for customers
sevenSegmentsDecoder waitDisplay_1     (.binaryCode(data[3:0]), .decimalPattern(waitTimeDisplay_1));   // display unit for waiting time 
sevenSegmentsDecoder waitDisplay_2     (.binaryCode(data[7:4]), .decimalPattern(waitTimeDisplay_2));   // display unit for waiting time 

assign tellersCount = tellers[2] + tellers[1] + tellers[0];
assign addr = {tellersCount, pCount}; // address combines tellers and customers number

endmodule


