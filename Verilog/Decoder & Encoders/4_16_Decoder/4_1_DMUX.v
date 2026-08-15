module demux_1x4 (input f, input [1:0]	sel, output reg	a, b, c, d);
 always @ ( f or sel) begin
        // Output a: active when sel=00
 a = f & ~sel[1] & ~sel[0];
 	// Output b: active when sel=10
 b = f & sel[1] & ~sel[0];
 	// Output c: active when sel=01
 c = f & ~sel[1] & sel[0];
 	// Output d: active when sel=11
 d = f & sel[1] & sel[0];
 end

endmodule
