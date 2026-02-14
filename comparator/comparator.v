module comparator #(parameter CODE_LEN = 4)
                   (input wire [CODE_LEN*4 - 1 : 0] entered_code,
                    input wire [CODE_LEN*4 - 1 : 0] stored_code,
                    output reg match
                   );

 always @(*) begin
  if (entered_code == stored_code)
    match = 1'b1;
  else 
    match = 1'b0;
 end
  
endmodule
