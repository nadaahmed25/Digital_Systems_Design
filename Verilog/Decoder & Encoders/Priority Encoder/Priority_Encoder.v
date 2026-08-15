module pr_en ( input [7:0] a,       
               input [7:0] b,        
               input [7:0] c,      
               input [7:0] d,        
               input [1:0] sel,      
               output reg [7:0] out); 

    always @ (a or b or c or d or sel) begin
        if (sel == 2'b00)             // Highest priority: select input 'a'
            out <= a;
        else if (sel == 2'b01)        // Priority 2: select input 'b'
            out <= b;
        else if (sel == 2'b10)        // Priority 3: select input 'c'
            out <= c;
        else                          // Lowest priority: select input 'd'
            out <= d;
    end
endmodule
