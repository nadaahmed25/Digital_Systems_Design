`timescale 1ns/1ns

module UART_tb;

    parameter int N = 8;

    logic V_IN;
    logic CLK;
    logic RST;

    logic P_EN;
    logic P_Bit;
    logic [N-1:0] P_IN;

    logic busy;
    logic TX_OUT;

    logic [N-1:0] RX_DATA;
    logic RX_VALID;
    logic RX_BUSY;
    logic RX_PARITY_ERROR;
    logic RX_STOP_ERROR;
    logic RX_START_GLITCH;

    UART #(
        .N(N)
    ) dut (
        .V_IN(V_IN),
        .CLK(CLK),
        .RST(RST),
        .P_EN(P_EN),
        .P_Bit(P_Bit),
        .P_IN(P_IN),

        .busy(busy),
        .TX_OUT(TX_OUT),

        .RX_DATA(RX_DATA),
        .RX_VALID(RX_VALID),
        .RX_BUSY(RX_BUSY),
        .RX_PARITY_ERROR(RX_PARITY_ERROR),
        .RX_STOP_ERROR(RX_STOP_ERROR),
        .RX_START_GLITCH(RX_START_GLITCH)
    );

    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK;
    end

    initial begin

        V_IN = 1'b0;
        RST  = 1'b1;
        P_EN = 1'b0;
        P_Bit = 1'b0;
        P_IN = '0;

        #20;

        RST = 1'b0;

        #20;

        P_IN = 8'b10101010;
        V_IN = 1'b1;

        #10;

        V_IN = 1'b0;

        wait (busy == 1'b0);

        #50;

        P_IN = 8'b11001100;
        V_IN = 1'b1;

        #10;

        V_IN = 1'b0;

        wait (busy == 1'b0);

        #50;

        $stop;

    end

endmodule

