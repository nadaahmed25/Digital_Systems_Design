module tb_jk;
   reg j;
   reg k;
   reg clk;
   wire q;

   always #5 clk = ~clk;

   jk_ff    jk0 ( .j(j),
                  .k(k),
                  .clk(clk),
                  .q(q));

   initial begin
      {clk ,j , k} <= 0;
     $monitor ("j=%0d k=%0d q=%0d", j, k, q);
      #5 j <= 0;
         k <= 1;
      #20 j <= 1;
          k <= 0;
      #20 j <= 1;
          k <= 1;
      #20 $finish;
   end
 
endmodule
