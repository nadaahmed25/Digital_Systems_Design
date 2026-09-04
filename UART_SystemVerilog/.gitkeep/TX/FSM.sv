module Controller #(parameter int N = 8)(
    input  logic V_IN,
    input  logic RST,
    input  logic CLK,
    input  logic P_EN,
    output logic Busy,
    output logic load,
    output logic Serializer_control,
    output logic [N-1:0] Data_Bits_count,
    output logic [1:0] MUX_SEL
);

    typedef enum logic [2:0] {
        idle   = 3'd0,
        start  = 3'd1,
        data   = 3'd2,
        parity = 3'd3,
        stop   = 3'd4
    } state_t;

    state_t state, next_state;

    always_ff @(posedge CLK or negedge RST) begin
        if (!RST) begin
            state <= idle;
            Data_Bits_count <= '0;
        end
        else begin
            state <= next_state;

            if (state == idle) begin
                Data_Bits_count <= '0;
            end
            else if (state == data) begin
                if (Data_Bits_count < N-1)
                    Data_Bits_count <= Data_Bits_count + 1'b1;
            end
        end
    end

    always_comb begin
        next_state = idle;
        Serializer_control = 1'b0;
        MUX_SEL = 2'd0;
        load = 1'b0;

        case (state)

            idle: begin
                Serializer_control = 1'b0;
                MUX_SEL = 2'd3;

                if (V_IN) begin
                    load = 1'b1;
                    next_state = start;
                end
                else begin
                    next_state = idle;
                end
            end

            start: begin
                Serializer_control = 1'b0;
                MUX_SEL = 2'd0;
                next_state = data;
            end

            data: begin
                Serializer_control = 1'b1;
                MUX_SEL = 2'd1;

                if (Data_Bits_count == N-1) begin
                    if (P_EN)
                        next_state = parity;
                    else
                        next_state = stop;
                end
                else begin
                    next_state = data;
                end
            end

            parity: begin
                Serializer_control = 1'b0;
                MUX_SEL = 2'd2;
                next_state = stop;
            end

            stop: begin
                MUX_SEL = 2'd3;
                Serializer_control = 1'b0;
                next_state = idle;
            end

            default: begin
                next_state = idle;
            end

        endcase
    end

    always_comb begin
        if (state == idle)
            Busy = 1'b0;
        else
            Busy = 1'b1;
    end

endmodule
