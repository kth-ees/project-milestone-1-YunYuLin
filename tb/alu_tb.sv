module alu_tb;

  parameter BW = 16; // bitwidth

  logic unsigned [BW-1:0] in_a;
  logic unsigned [BW-1:0] in_b;
  logic             [3:0] opcode;
  logic unsigned [BW-1:0] out;
  logic             [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );

  // Generate stimuli to test the ALU
  initial begin
    in_a = '0;
    in_b = '0;
    opcode = '0;
    #10ns;
    // Complete your testbench code here

    // === test ===
    in_a = 16'd32767; in_b = 16'd1; opcode = 4'b0000; #1; check($signed(in_a), $signed(in_b), opcode); // ADD overflow
    in_a = 16'd0;      in_b = 16'd1; opcode = 4'b0001; #1; check($signed(in_a), $signed(in_b), opcode); // SUB negative
    in_a = 16'hAAAA;   in_b = 16'h5555; opcode = 4'b0100; #1; check($signed(in_a), $signed(in_b), opcode); // XOR

    // === random ===
    repeat (100) begin
      in_a = $urandom();
      in_b = $urandom();
      opcode = $urandom_range(0, 7);
      #1;
      check($signed(in_a), $signed(in_b), opcode);
    end

    $display("Test completed.");
    $finish;
  
  end
endmodule
