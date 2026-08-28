module Controller #(parameter N=8)(input V_IN ,RST ,CLK ,P_EN ,
                   output reg Busy ,load ,Serializer_control,
                   output reg [N-1:0] Data_Bits_count ,
                   output reg  [1:0] MUX_SEL);

localparam idle   = 0;
localparam start  = 1;
localparam data   = 2;
localparam parity = 3;
localparam stop   = 4;
reg [2:0] state;
reg [2:0] next_state;

always @(posedge CLK or negedge RST) begin 
   if (!RST) begin
      state<=idle;
      Data_Bits_count<=0;
      end
   else begin
      state<=next_state;
         if (state == idle) begin 
           Data_Bits_count <= 0;
          end
         else if (state == data) begin
                if (Data_Bits_count<N-1) 
                   Data_Bits_count <= Data_Bits_count + 1;
          end
    end
end

always @(*) begin
next_state = idle;
Serializer_control = 0;
MUX_SEL =0;
load =0;
   case(state)
       idle: begin
             Serializer_control = 0;
            MUX_SEL =3;
               if(V_IN) begin
                   load=1;
                   next_state = start;
                    end
               else 
                   next_state = idle;
             end
       start: begin
               Serializer_control = 0;
               MUX_SEL =0;
               next_state = data;
             end
       data: begin
             Serializer_control = 1;
             MUX_SEL =1;
               if (Data_Bits_count == N-1) begin
                   if(P_EN)
                       next_state = parity;
                   else
                       next_state = stop;
                 end
               else
                 next_state = data;
             end
       parity: begin
                 Serializer_control = 0;
                 MUX_SEL =2;
                 next_state = stop;
               end
       stop: begin
                MUX_SEL =3;
               Serializer_control = 0;
               next_state = idle ;
             end
   endcase
 end  

always @(*) begin
Busy = 0;
   if(state == idle) 
       Busy = 0;
   else begin
       Busy = 1;
     end
 end
endmodule
