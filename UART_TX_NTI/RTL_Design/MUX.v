module MUX (input  stop, start, data, parity,
            input [1:0] sel,
            output reg  TX);

 always @(*) begin
    case (sel)
      2'b00: begin
              TX=start;
             end
      2'b01: begin
              TX=data;
             end
      2'b10: begin
              TX=parity;
             end
      2'b11: begin
              TX=stop;
             end
      default: TX =2'b01;
    endcase
 end
endmodule
