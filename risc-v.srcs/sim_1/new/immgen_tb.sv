`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 08:04:16 PM
// Design Name: 
// Module Name: immgen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module immgen_tb;

    reg [31:0] instr;
    reg [2:0] immsel;

    wire [31:0] imm;

    // DUT
    immgen uut (
        .instr(instr),
        .immsel(immsel),
        .imm(imm)
    );

    initial begin

        // -----------------------------------
        // I-TYPE POSITIVE
        // addi x1,x2,5
        // imm = 5
        // -----------------------------------
        instr = 32'b000000000101_00010_000_00001_0010011;
        immsel = 3'b000;

        #10;

        $display("I-TYPE POSITIVE");
        $display("imm = %d", imm);

        // -----------------------------------
        // I-TYPE NEGATIVE
        // imm = -1
        // -----------------------------------
        instr[31:20] = 12'b111111111111;
        immsel = 3'b000;

        #10;

        $display("I-TYPE NEGATIVE");
        $display("imm = %d", $signed(imm));

        // -----------------------------------
        // S-TYPE
        // sw x5,8(x1)
        // imm = 8
        // -----------------------------------
        instr = 32'b0000000_00101_00001_010_01000_0100011;
        immsel = 3'b001;

        #10;

        $display("S-TYPE");
        $display("imm = %d", imm);

        // -----------------------------------
        // B-TYPE
        // branch offset = 16
        // -----------------------------------
        instr = 32'b0000000_00010_00001_000_1000_0_1100011;
        immsel = 3'b010;

        #10;

        $display("B-TYPE");
        $display("imm = %d", imm);

        // -----------------------------------
        // U-TYPE
        // lui x1,0x12345
        // -----------------------------------
        instr = 32'h123450B7;
        immsel = 3'b011;

        #10;

        $display("U-TYPE");
        $display("imm = %h", imm);

        // -----------------------------------
        // J-TYPE
        // jal offset = 32
        // -----------------------------------
        instr = 32'b00000010000000000000_00001_1101111;
        immsel = 3'b100;

        #10;

        $display("J-TYPE");
        $display("imm = %d", imm);

        #10;
        $finish;

    end

endmodule