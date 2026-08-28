module P_C #(parameter N =8)(input P_valid,P_Bit,
                           input [N-1:0] Data_Bits ,
                           output reg parity_out  );
integer i;
reg result;
always @(*) begin
parity_out = 0;
result = 0;
   if (P_valid) begin
       for (i=0 ; i<N ; i=i+1) begin
            result = result^Data_Bits[i];
         end
     case (P_Bit)
        0: begin 
            if (result == 0)
              parity_out = 0;
            else
              parity_out =1;
           end
       1: begin 
            if (result == 0)
              parity_out = 1;
            else
              parity_out =0;
           end
     endcase 
   end
 end
endmodule   
     
