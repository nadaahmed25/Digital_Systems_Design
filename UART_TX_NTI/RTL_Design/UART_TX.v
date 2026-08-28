module UART_TX #(parameter N=8)(input V_IN ,CLK , RST , P_EN , P_Bit , 
                input [N-1:0] P_IN ,
                output  busy , TX_OUT );

wire [1:0] MUX_SEL;
wire Serializer_control;
wire [N-1:0] Data_Bits_count;
wire out;
wire parity_out;
wire load;
wire stop =1;
wire start =0;

Controller #(.N(N)) u1 (.V_IN(V_IN) ,.RST(RST) ,.CLK(CLK) ,
                        .P_EN(P_EN) ,.Busy(busy),.MUX_SEL(MUX_SEL),
                        .load(load) ,.Serializer_control(Serializer_control),
                        .Data_Bits_count(Data_Bits_count));

serializer #(.N(N)) u2 (.P_IN(P_IN),.CLK(CLK) ,.RST(RST),
                        .Serializer_control(Serializer_control),
                        .load(load),.out(out));

P_C #(.N(N)) u3 (.P_valid(P_EN),.P_Bit(P_Bit),
                 .Data_Bits(P_IN),.parity_out(parity_out));

MUX  u4 (.start(start),.data(out),.parity(parity_out),.stop(stop),
            .sel(MUX_SEL),.TX(TX_OUT));

endmodule
