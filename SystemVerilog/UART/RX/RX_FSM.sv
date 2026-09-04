module RX_FSM #(
    parameter DATA_WIDTH = 8
)(
    input  logic in_clock,
    input  logic in_reset_n,
    input  logic in_parity_enable,
    input  logic in_start_detected,
    input  logic in_deserialization_done,

    output logic out_busy,
    output logic out_valid,
    output logic out_shift_enable,
    output logic out_stop_check_enable,
    output logic out_parity_check_enable
);

typedef enum logic [2:0] {
    IDLE,
    DATA,
    PARITY,
    STOP,
    VALID
} state_e;

state_e current_state, next_state;

always_ff @(posedge in_clock or negedge in_reset_n) begin
    if (!in_reset_n)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

always_comb begin
    next_state = current_state;

    out_busy = 1'b1;
    out_valid = 1'b0;
    out_shift_enable = 1'b0;
    out_stop_check_enable = 1'b0;
    out_parity_check_enable = 1'b0;

    case (current_state)

        IDLE: begin
            out_busy = 1'b0;

            if (in_start_detected)
                next_state = DATA;
        end

        DATA: begin
            out_shift_enable = 1'b1;

            if (in_deserialization_done) begin
                if (in_parity_enable)
                    next_state = PARITY;
                else
                    next_state = STOP;
            end
        end

        PARITY: begin
            out_parity_check_enable = 1'b1;
            next_state = STOP;
        end

        STOP: begin
            out_stop_check_enable = 1'b1;
            next_state = VALID;
        end

        VALID: begin
            out_valid = 1'b1;
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE;
        end

    endcase
end

endmodule
