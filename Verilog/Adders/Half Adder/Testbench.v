module tb;
 reg a, b;
 wire sum, cout;
integer i;
 HA HA0 ( .a(a), .b(b), .sum(sum), .cout(cout));
 initial begin
 a <= 0;
 b <= 0;
 $monitor("Time=%0t a=%0b b=%0b sum=%0b cout=%0b",$time, a, b, sum, cout);
 for ( i = 0; i < 4; i = i + 1) begin
 {a, b} <= i;
 #10;  end
 $finish;
 end
endmodule