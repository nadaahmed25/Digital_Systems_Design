`timescale 1ns/1ps

module UART_RX_TB;

    parameter DATA_WIDTH = 8;

    logic in_clock;
    logic in_reset_n;
    logic in_rx_in;

    logic in_parity_enable;
    logic in_parity_odd;

    logic in_sample_enable;
    logic in_sampled_bit;

    logic [DATA_WIDTH-1:0] out_parallel_data;
    logic out_valid;
    logic out_busy;

    logic out_parity_error;
    logic out_stop_error;
    logic out_start_glitch;


    UART_RX #(
        .DATA_WIDTH(DATA_WIDTH)
    ) DUT (
        .in_clock             (in_clock),
        .in_reset_n           (in_reset_n),
        .in_rx_in             (in_rx_in),

        .in_parity_enable     (in_parity_enable),
        .in_parity_odd        (in_parity_odd),

        .in_sample_enable     (in_sample_enable),
        .in_sampled_bit       (in_sampled_bit),

        .out_parallel_data    (out_parallel_data),
        .out_valid             (out_valid),
        .out_busy              (out_busy),

        .out_parity_error     (out_parity_error),
        .out_stop_error       (out_stop_error),
        .out_start_glitch     (out_start_glitch)
    );


    always #5 in_clock = ~in_clock;


    task sample_bit(input logic bit_value);
        begin
            in_sampled_bit  = bit_value;
            in_sample_enable = 1'b1;

            @(posedge in_clock);

            in_sample_enable = 1'b0;

            @(posedge in_clock);
        end
    endtask


    initial begin

        in_clock = 1'b0;
        in_reset_n = 1'b0;

        in_rx_in = 1'b1;

        in_parity_enable = 1'b1;
        in_parity_odd = 1'b0;

        in_sample_enable = 1'b0;
        in_sampled_bit = 1'b1;


        // Reset
        #20;
        in_reset_n = 1'b1;

        #20;


        // START BIT
        in_rx_in = 1'b0;
        sample_bit(1'b0);


        // DATA = 8'b10101010
        sample_bit(1'b0);
        sample_bit(1'b1);
        sample_bit(1'b0);
        sample_bit(1'b1);
        sample_bit(1'b0);
        sample_bit(1'b1);
        sample_bit(1'b0);
        sample_bit(1'b1);


        // EVEN PARITY
        sample_bit(1'b0);


        // STOP BIT
        sample_bit(1'b1);


        #30;

        $display("----------------------------------");
        $display("DATA         = %b", out_parallel_data);
        $display("VALID        = %b", out_valid);
        $display("BUSY         = %b", out_busy);
        $display("PARITY ERROR = %b", out_parity_error);
        $display("STOP ERROR   = %b", out_stop_error);
        $display("START GLITCH = %b", out_start_glitch);
        $display("----------------------------------");

        #20;

        $stop;

    end

endmodule
