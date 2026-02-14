`timescale 1ns/1ps

module control_tb;

  reg clk;
  reg rst_n; 
  reg full;
  reg match;
  reg submit; 
  wire fail_led;
  wire unlock_led;
  wire ready_for_input;

  control uut(.clk(clk), .rst_n(rst_n), .full(full), .match(match), .submit(submit), .fail_led(fail_led), .unlock_led(unlock_led), .ready_for_input(ready_for_input));

  initial begin
    clk = 0;
    rst_n = 0;
    full = 0;
    submit = 0;
    match = 0;
 
  #12 rst_n = 1;
  
  @(posedge clk)
    full = 1;
    submit = 1;
    match = 1;
  @(posedge clk)
    full = 0;
    submit = 0;
    match = 0;

  #20;

  @(posedge clk)
    full = 1;
    submit = 1;
    match = 0;
  @(posedge clk)
    full = 0;
    submit = 0;
  #20;
  $finish;
  end

  initial begin
    $monitor("Time=%0t | full=%b submit=%b match=%b | unlock_led=%b fail_led=%b ready=%b", $time, full, submit, match, unlock_led, fail_led, ready_for_input);
  end

endmodule
