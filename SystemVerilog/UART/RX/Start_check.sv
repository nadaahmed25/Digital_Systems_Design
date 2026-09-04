module Start_Check (
    input  logic in_clock,
    input  logic in_reset_n,
    input  logic in_start_check_enable,
    input  logic in_sampled_bit,
    output logic out_start_glitch
);

always_ff @(posedge in_clock or negedge in_reset_n) begin
    if (!in_reset_n) begin
        out_start_glitch <= 1'b0;
    end
    else if (in_start_check_enable) begin
        out_start_glitch <= (in_sampled_bit != 1'b0);
    end
    else begin
        out_start_glitch <= 1'b0;
    end
end

endmodule