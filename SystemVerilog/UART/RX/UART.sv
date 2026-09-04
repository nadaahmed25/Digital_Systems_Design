module UART #(
    parameter int N = 8
)(
    input  logic V_IN,
    input  logic CLK,
    input  logic RST,

    input  logic P_EN,
    input  logic P_Bit,
    input  logic [N-1:0] P_IN,

    output logic busy,
    output logic TX_OUT,

    output logic [N-1:0] RX_DATA,
    output logic RX_VALID,
    output logic RX_BUSY,
    output logic RX_PARITY_ERROR,
    output logic RX_STOP_ERROR,
    output logic RX_START_GLITCH
);

    UART_TX #(
        .N(N)
    ) u_tx (
        .V_IN(V_IN),
        .CLK(CLK),
        .RST(RST),
        .P_EN(P_EN),
        .P_Bit(P_Bit),
        .P_IN(P_IN),
        .busy(busy),
        .TX_OUT(TX_OUT)
    );

    UART_RX #(
        .DATA_WIDTH(N)
    ) u_rx (
        .in_clock(CLK),
        .in_reset_n(~RST),
        .in_rx(TX_OUT),
        .in_parity_enable(P_EN),
        .in_parity_odd(P_Bit),

        .out_parallel_data(RX_DATA),
        .out_valid(RX_VALID),
        .out_busy(RX_BUSY),
        .out_parity_error(RX_PARITY_ERROR),
        .out_stop_error(RX_STOP_ERROR),
        .out_start_glitch(RX_START_GLITCH)
    );

endmodule


