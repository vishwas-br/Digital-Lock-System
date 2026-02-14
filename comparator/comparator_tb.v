`timescale 1ns/1ps

module comparator_tb;
  reg [15 : 0] entered_code;
  reg [15 : 0] stored_code;
  wire match;
  
  comparator uut(.entered_code(entered_code), .stored_code(stored_code), .match(match));

  initial begin
     entered_code = 16'h2458; stored_code  = 16'h1234; #50;
     $display("Match = %0b", match);
     entered_code = 16'h1234; stored_code  = 16'h1234; #50;
     $display("Match = %0b", match);
     entered_code = 16'h4587; stored_code  = 16'h1234; #50;
     $display("Match = %0b", match);
     entered_code = 16'h2458; stored_code  = 16'h2458; #50;
     $display("Match = %0b", match);
     entered_code = 16'h1578; stored_code  = 16'h1234; #50;
     $display("Match = %0b", match);
     entered_code = 16'h2458; stored_code  = 16'h1576; #50;
     $display("Match = %0b", match);
     entered_code = 16'h9596; stored_code  = 16'h1875; #50;
     $display("Match = %0b", match);
     entered_code = 16'h0007; stored_code  = 16'h0007; #50;
     $display("Match = %0b", match);
     
     $finish;
   end
 
endmodule
