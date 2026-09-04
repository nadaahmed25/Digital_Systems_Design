module Stop_Check (
    input  logic in_clock,
    input  logic in_reset_n,
    input  logic in_stop_check_enable,
    input  logic in_sampled_bit,
    output logic out_stop_error
);

always_ff @(posedge in_clock or negedge in_reset_n) begin
    if (!in_reset_n) begin
        out_stop_error <= 1'b0;
    end
    else if (in_stop_check_enable) begin
        out_stop_error <= (in_sampled_bit != 1'b1);
    end
    else begin
        out_stop_error <= 1'b0;
    end
end

endmodule
