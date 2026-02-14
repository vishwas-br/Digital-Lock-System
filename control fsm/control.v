module control( input wire clk, 
                input wire rst_n, 
                input wire full,
                input wire match,
                input wire submit, 
                output reg fail_led,
                output reg unlock_led,
                output reg ready_for_input);
  
  parameter IDLE = 3'b000; 
  parameter INPUT = 3'b001; 
  parameter CHECK = 3'b010;
  parameter UNLOCK = 3'b011; 
  parameter FAIL = 3'b100;

  reg [2:0] current_state, next_state;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      current_state <= IDLE;
    else 
      current_state <= next_state;
  end
 
  always @(*) begin 
  next_state = current_state;
   case(current_state)
    IDLE : if (submit == 0) next_state = INPUT;
    INPUT : if(full && submit) next_state = CHECK;
    CHECK : if (match) next_state = UNLOCK;
            else next_state = FAIL;
    UNLOCK : next_state = IDLE;
    FAIL : next_state = IDLE;
   endcase
  end

  always @(*) begin
    unlock_led  = 0;
    fail_led = 0;
    ready_for_input = 0;
    
    case (current_state)
      IDLE : ready_for_input = 1;
      INPUT : ready_for_input = 1;
      CHECK : ; 
      UNLOCK : unlock_led = 1;
      FAIL : fail_led   = 1;
    endcase

  end

endmodule
