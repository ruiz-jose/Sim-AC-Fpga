`include "src/branch.v"

module branch_tb;

  reg [2:0] op = 4'b000;
  reg flag_z = 1'b0;
  reg flag_c = 1'b0;
  reg ctrl_jmp = 1'b0;

  wire branch = 1'b0;

  integer test_idx = 0;

  branch UUT(
    .op_i(op), .flag_z_i(flag_z), .flag_c_i(flag_c),
    .ctrl_jmp_i(ctrl_jmp), .branch_o(branch)
  );

  initial begin
    $dumpfile("bin/branch.vcd");
    $dumpvars(0, branch_tb);

    // should branch; unconditional jump
    op = 3'b100;  // JMP
    flag_z = 1'b0;
    flag_c = 1'b0;
    ctrl_jmp = 1'b1;
    #25; test_idx++;

    // should not branch; non-branching opcode
    op = 3'b010;  // LDA
    flag_z = 1'b0;
    flag_c = 1'b1;
    ctrl_jmp = 1'b1;
    #25; test_idx++;

    // should not branch; no control line not set
    op = 3'b101;  // JZ
    flag_z = 1'b1;
    flag_c = 1'b0;
    ctrl_jmp = 1'b0;
    #25; test_idx++;

    // should not branch; Z flag set not set for BRZ
    op = 3'b101;  // BRZ
    flag_z = 1'b0;
    flag_c = 1'b0;
    ctrl_jmp = 1'b1;
    #25; test_idx++;

    // should branch; BRC and C flag set
    op = 3'b101;  // JZ
    flag_z = 1'b1;
    flag_c = 1'b0;
    ctrl_jmp = 1'b1;
    #25; test_idx++;


    // should not branch; C flag set not set for JC
    op = 3'b110;  // JC
    flag_z = 1'b0;
    flag_c = 1'b0;
    ctrl_jmp = 1'b1;
    #25; test_idx++;

    // should branch; JC and C flag set
    op = 3'b110;  // JC
    flag_z = 1'b0;
    flag_c = 1'b1;
    ctrl_jmp = 1'b1;
    #25; test_idx++;


    $finish;
    $display("Testbench completed");
  end

endmodule
