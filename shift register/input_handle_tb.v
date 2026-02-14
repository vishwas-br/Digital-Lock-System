`timescale 1ns/1ps

module input_handle_tb;
   
   parameter CODE_LEN = 4; 
   reg rst_n;
   reg clk; 
   reg digit_valid;
   reg submit; 
   reg [3:0] digit_in;
   wire [15 : 0] entered_code;
   wire full;
   wire ready;

   input_handle #(.CODE_LEN(CODE_LEN)) uut(.clk(clk), .rst_n(rst_n), .submit(submit), .full(full), .ready(ready), .digit_valid(digit_valid), .digit_in(digit_in), .entered_code(entered_code));
   
   always #5 clk = ~clk;
   
   initial begin
   clk = 0; 
   rst_n = 0; 
   digit_valid = 0; 
   digit_in = 0;
     
   #12 
     
   rst_n = 1;
    
   @(posedge clk);
   digit_in = 4'h1;
   digit_valid = 1;
   @(posedge clk); 
   digit_valid = 0;

   @(posedge clk);
   digit_in = 4'h2; 
   digit_valid = 1;
   @(posedge clk); 
   digit_valid = 0;

   @(posedge clk);
   digit_in = 4'h3; 
   digit_valid = 1;
   @(posedge clk); 
   digit_valid = 0;

   @(posedge clk);
   digit_in = 4'h4; 
   digit_valid = 1;
   @(posedge clk); 
   digit_valid = 0;

   #20;
     
   $finish;
   end
  
   initial begin
     $monitor("Time=%0t | digit_in=%h | entered_code=%h | full=%b", $time, digit_in, entered_code, full);
   end
endmodule
