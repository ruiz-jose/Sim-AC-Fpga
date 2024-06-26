/* 5-bit program counter */

module pc(
  input clk_i,
  input rst_i,
  input jmp_en_i,
  input [4:0] jmp_addr_i,
  output reg [4:0] addr_o
);

  always @(posedge clk_i) begin
    if (rst_i)          addr_o <= 5'b0;
    else if (jmp_en_i)  addr_o <= jmp_addr_i;
    else                addr_o <= addr_o + 1;
  end

endmodule
