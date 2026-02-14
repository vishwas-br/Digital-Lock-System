module input_handle #(parameter CODE_LEN = 4)
                     ( input wire clk, 
                       input wire rst_n, 
                       input wire digit_valid,
                       input wire submit, 
                       input wire [3:0] digit_in,
                       output reg [CODE_LEN*4 - 1 : 0] entered_code,
                       output reg full, 
                       output reg ready );

 reg [$clog2(CODE_LEN) : 0] count;  

 always @ (posedge clk or negedge rst_n) begin
   if (!rst_n) begin
     entered_code <= {CODE_LEN*4{1'b0}};
     full <= 0; 
     count <= 0;
   end 
   else if (digit_valid) begin
     entered_code <= (entered_code << 4) | digit_in;
     count <= count + 1;
       if (count + 1 == CODE_LEN) begin
         full  <= 1'b1;
         ready <= 1'b1;
       end
       else begin
         full <= 1'b0;
         ready <= 1'b0;
       end
   end
  end
endmodule
