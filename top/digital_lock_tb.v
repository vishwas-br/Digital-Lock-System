`timescale 1ns/1ps

module digital_lock_tb;

    parameter CODE_LEN = 4;

    reg clk;
    reg rst_n;
    reg digit_valid;
    reg submit;
    reg [3:0] digit_in;
    reg [CODE_LEN*4-1:0] stored_code;
    wire unlock_led;
    wire fail_led;
    wire ready_for_input;
  
    digital_lock #(.CODE_LEN(CODE_LEN)) uut (
        .clk(clk),
        .rst_n(rst_n),
        .digit_valid(digit_valid),
        .submit(submit),
        .digit_in(digit_in),
        .stored_code(stored_code),
        .unlock_led(unlock_led),
        .fail_led(fail_led),
        .ready_for_input(ready_for_input)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        digit_valid = 0;
        submit = 0;
        digit_in = 0;
        stored_code = 16'h1234; // correct passcode

        #12 rst_n = 1;

        // Scenario 1: Correct passcode (1234)
        @(posedge clk); digit_in = 4'h1; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h2; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h3; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h4; digit_valid = 1;
        @(posedge clk); digit_valid = 0;

        // Submit
        @(posedge clk); submit = 1;
        @(posedge clk); submit = 0;

        #20;

        // Scenario 2: Wrong passcode (5678)
        @(posedge clk); digit_in = 4'h5; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h6; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h7; digit_valid = 1;
        @(posedge clk); digit_valid = 0;
        @(posedge clk); digit_in = 4'h8; digit_valid = 1;
        @(posedge clk); digit_valid = 0;

        // Submit
        @(posedge clk); submit = 1;
        @(posedge clk); submit = 0;

        #20;

        $finish;
    end

    initial begin
      $monitor("Time=%0t | digit_in=%h | unlock_led=%b | fail_led=%b | ready=%b", $time, digit_in, unlock_led, fail_led, ready_for_input);
    end

endmodule
