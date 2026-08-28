module serializer #(parameter N=8)(input [N-1:0] P_IN ,
                                 input CLK ,RST ,Serializer_control,load,
                                 output reg out);
reg [N-1:0] shift_register;
reg [3:0] count;

always @(posedge CLK or negedge RST) begin
   if (!RST) begin
         shift_register <= 0;
         count <= 0;
         out <= 0;
         end
   else if (load) begin
         shift_register <= P_IN;
         count <= 0;
         out <= 0;
         end
    else if (Serializer_control) begin
         out <= shift_register[0];
         shift_register <= shift_register >> 1;
           if (count == N-1) begin
                 count <= 0;
              end
           else  begin 
                 count <= count + 1;
              end
         end
  end
endmodule         