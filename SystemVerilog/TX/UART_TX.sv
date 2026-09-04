module UART_TX #(parameter int N = 8)(
    input  logic V_IN,
    input  logic CLK,
    input  logic RST,
    input  logic P_EN,
    input  logic P_Bit,
    input  logic [N-1:0] P_IN,

    output logic busy,
    output logic TX_OUT
);

    logic [1:0] MUX_SEL;
    logic Serializer_control;
    logic [N-1:0] Data_Bits_count;
    logic out;
    logic parity_out;
    logic load;

    logic stop;
    logic start;

    assign stop  = 1'b1;
    assign start = 1'b0;

    Controller #(.N(N)) u1 (
        .V_IN(V_IN),
        .RST(RST),
        .CLK(CLK),
        .P_EN(P_EN),
        .Busy(busy),
        .MUX_SEL(MUX_SEL),
        .load(load),
        .Serializer_control(Serializer_control),
        .Data_Bits_count(Data_Bits_count)
    );

    serializer #(.N(N)) u2 (
        .P_IN(P_IN),
        .CLK(CLK),
        .RST(RST),
        .Serializer_control(Serializer_control),
        .load(load),
        .out(out)
    );

    P_C #(.N(N)) u3 (
        .P_valid(P_EN),
        .P_Bit(P_Bit),
        .Data_Bits(P_IN),
        .parity_out(parity_out)
    );

    MUX u4 (
        .start(start),
        .data(out),
        .parity(parity_out),
        .stop(stop),
        .sel(MUX_SEL),
        .TX(TX_OUT)
    );

endmodule
