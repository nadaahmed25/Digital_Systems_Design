module serializer #(parameter int N = 8)(
    input  logic [N-1:0] P_IN,
    input  logic CLK,
    input  logic RST,
    input  logic Serializer_control,
    input  logic load,
    output logic out
);

    logic [N-1:0] shift_register;
    logic [N-1:0] count;

    always_ff @(posedge CLK or negedge RST) begin
        if (!RST) begin
            shift_register <= '0;
            count <= '0;
            out <= 1'b0;
        end
        else if (load) begin
            shift_register <= P_IN;
            count <= '0;
            out <= 1'b0;
        end
        else if (Serializer_control) begin
            out <= shift_register[0];
            shift_register <= shift_register >> 1;

            if (count == N-1)
                count <= '0;
            else
                count <= count + 1'b1;
        end
    end

endmodule
