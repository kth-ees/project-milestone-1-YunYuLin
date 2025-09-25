module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic unsigned [BW-1:0] in_a,
  input  logic unsigned [BW-1:0] in_b,
  input  logic             [3:0] opcode,
  output logic unsigned [BW-1:0] out,
  output logic             [2:0] flags // {overflow, negative, zero}
  );

  // Complete your RTL code here


  logic ovf, neg, z;

  logic signed [BW-1:0] a_signed, b_signed, result_signed;

  always_comb begin
    // ??
    out = '0;
    ovf = 1'b0;

    a_signed = $signed(in_a);
    b_signed = $signed(in_b);

    unique case (opcode)
      4'b0000: begin // ADD
        result_signed = a_signed + b_signed;
        out = $unsigned(result_signed);
        ovf = (a_signed[BW-1] == b_signed[BW-1]) &&
              (result_signed[BW-1] != a_signed[BW-1]);
      end
      4'b0001: begin // SUB
        result_signed = a_signed - b_signed;
        out = $unsigned(result_signed);
        ovf = (a_signed[BW-1] != b_signed[BW-1]) &&
              (result_signed[BW-1] != a_signed[BW-1]);
      end
      4'b0010: out = in_a & in_b; // AND
      4'b0011: out = in_a | in_b; // OR
      4'b0100: out = in_a ^ in_b; // XOR
      4'b0101: begin // INC
        result_signed = a_signed + 1;
        out = $unsigned(result_signed);
        ovf = (a_signed == $signed({1'b0, {(BW-1){1'b1}}}));
      end
      4'b0110: out = in_a; // MOVA
      4'b0111: out = in_b; // MOVB
      default: out = '0;
    endcase

    // flags ????? signed ? result?
    result_signed = $signed(out);
    neg = result_signed[BW-1];
    z   = (out == 0);
  end

  assign flags = {ovf, neg, z};


endmodule




