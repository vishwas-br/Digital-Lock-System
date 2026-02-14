module digital_lock #(parameter CODE_LEN = 4)
   (
    input  wire clk,
    input  wire rst_n,
    input  wire digit_valid,
    input  wire submit,
    input  wire [3:0] digit_in,
    input  wire [CODE_LEN*4-1:0] stored_code,  
    output wire unlock_led,
    output wire fail_led,
    output wire ready_for_input
   );

    wire [CODE_LEN*4-1:0] entered_code;
    wire full;
    wire match;

    // Shift Register Block
    input_handle #(.CODE_LEN(CODE_LEN)) u_shift (
        .clk(clk),
        .rst_n(rst_n),
        .digit_in(digit_in),
        .digit_valid(digit_valid),
        .entered_code(entered_code),
        .full(full),
        .ready(ready),
        .submit(submit)
    );

    // Comparator Block
    comparator #(.CODE_LEN(CODE_LEN)) u_comp (
        .entered_code(entered_code),
        .stored_code(stored_code),
        .match(match)
    );

    // Control FSM Block
    control u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .full(full),
        .submit(submit),
        .match(match),
        .unlock_led(unlock_led),
        .fail_led(fail_led),
        .ready_for_input(ready_for_input)
    );

endmodule
