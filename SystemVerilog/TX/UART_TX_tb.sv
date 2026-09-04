`timescale 1ns/1ns

module UART_tb ;
parameter int N = 8;
    logic V_IN;
    logic CLK;
    logic RST;
    logic P_EN;
    logic P_Bit;
    logic [N-1:0] P_IN;

    logic busy;
    logic TX_OUT;

    UART_TX #(.N(N)) dut (
        .V_IN(V_IN),
        .CLK(CLK),
        .RST(RST),
        .P_EN(P_EN),
        .P_Bit(P_Bit),
        .P_IN(P_IN),
        .busy(busy),
        .TX_OUT(TX_OUT)
    );

    always #5 CLK = ~CLK;

    initial begin

        CLK   = 1'b0;
        RST   = 1'b0;
        V_IN  = 1'b0;
        P_EN  = 1'b0;
        P_Bit = 1'b0;
        P_IN  = '0;

        #10;
        RST = 1'b1;

        #10;
        P_IN  = 8'b01110110;
        P_EN  = 1'b0;
        P_Bit = 1'b0;
        V_IN  = 1'b1;

        #10;
        V_IN = 1'b0;

        #100;

        P_IN  = 8'b01110110;
        P_EN  = 1'b1;
        P_Bit = 1'b0;
        V_IN  = 1'b1;

        #10;
        V_IN = 1'b0;

        #110;

        P_IN  = 8'b01110110;
        P_EN  = 1'b1;
        P_Bit = 1'b1;
        V_IN  = 1'b1;

        #10;
        V_IN = 1'b0;

        #110;

        $finish;

    end

endmodule
```

