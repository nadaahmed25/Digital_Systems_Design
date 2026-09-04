module UART_RX #(
    parameter DATA_WIDTH = 8
)(
    input  logic in_clock,
    input  logic in_reset_n,
    input  logic in_rx,
    input  logic in_parity_enable,
    input  logic in_parity_odd,

    output logic [DATA_WIDTH-1:0] out_parallel_data,
    output logic out_valid,
    output logic out_busy,
    output logic out_parity_error,
    output logic out_stop_error,
    output logic out_start_glitch
);

    logic positive_edge;
    logic negative_edge;
    logic edge_detected;

    logic shift_enable;
    logic stop_check_enable;
    logic parity_check_enable;

    logic deserialization_done;
    logic sampled_bit;

    assign sampled_bit = in_rx;

    Edge_Detector u_edge_detector (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_signal(in_rx),
        .out_positive_edge(positive_edge),
        .out_negative_edge(negative_edge),
        .out_edge(edge_detected)
    );

    RX_FSM #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_rx_fsm (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_parity_enable(in_parity_enable),
        .in_start_detected(negative_edge),
        .in_deserialization_done(deserialization_done),

        .out_busy(out_busy),
        .out_valid(out_valid),
        .out_shift_enable(shift_enable),
        .out_stop_check_enable(stop_check_enable),
        .out_parity_check_enable(parity_check_enable)
    );

    Deserializer #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_deserializer (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_shift_enable(shift_enable),
        .in_received_bit(sampled_bit),

        .out_parallel_data(out_parallel_data),
        .out_done(deserialization_done)
    );

    Parity_Check #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_parity_check (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_parallel_data(out_parallel_data),
        .in_parity_odd(in_parity_odd),
        .in_parity_check_enable(parity_check_enable),
        .in_sampled_bit(sampled_bit),

        .out_parity_error(out_parity_error)
    );

    Stop_Check u_stop_check (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_stop_check_enable(stop_check_enable),
        .in_sampled_bit(sampled_bit),

        .out_stop_error(out_stop_error)
    );

    Start_Check u_start_check (
        .in_clock(in_clock),
        .in_reset_n(in_reset_n),
        .in_start_check_enable(negative_edge),
        .in_sampled_bit(sampled_bit),

        .out_start_glitch(out_start_glitch)
    );

endmodule

