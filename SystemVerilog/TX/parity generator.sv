module P_C #(parameter int N = 8)(
    input  logic P_valid,
    input  logic P_Bit,
    input  logic [N-1:0] Data_Bits,
    output logic parity_out
);

    int i;
    logic result;

    always_comb begin
        parity_out = 1'b0;
        result = 1'b0;

        if (P_valid) begin
            for (i = 0; i < N; i++) begin
                result = result ^ Data_Bits[i];
            end

            case (P_Bit)
                1'b0: begin
                    if (result == 1'b0)
                        parity_out = 1'b0;
                    else
                        parity_out = 1'b1;
                end

                1'b1: begin
                    if (result == 1'b0)
                        parity_out = 1'b1;
                    else
                        parity_out = 1'b0;
                end

                default:
                    parity_out = 1'b0;
            endcase
        end
    end

endmodule
