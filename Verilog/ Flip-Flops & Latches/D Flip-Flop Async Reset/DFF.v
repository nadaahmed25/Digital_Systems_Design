module DFF(
    input d,
    input en,
    input rstn,
    input clk,
    output reg q
);

always @(posedge clk or negedge rstn)
begin
    if (!rstn)
        q <= 0;
    else if (en)
        q <= d;
end

endmodule
