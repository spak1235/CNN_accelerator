`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 07:37:35 PM
// Design Name: 
// Module Name: control_unit_tb
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


`timescale 1ns / 1ps

module control_unit_tb;

    reg [31:0] instr;
    reg taken_branch;

    wire pcsel;
    wire [2:0] immsel;
    wire regwen;
    wire bsel;
    wire [3:0] alusel;
    wire memrw;
    wire [1:0] wbsel;

    // DUT
    control_unit uut (
        .instr(instr),
        .taken_branch(taken_branch),

        .pcsel(pcsel),
        .immsel(immsel),
        .regwen(regwen),
        .bsel(bsel),
        .alusel(alusel),
        .memrw(memrw),
        .wbsel(wbsel)
    );

    initial begin

        // -------------------------------
        // ADD
        // opcode = 0110011
        // funct3 = 000
        // funct7 = 0000000
        // -------------------------------
        instr = 32'b0000000_00010_00001_000_00011_0110011;
        taken_branch = 0;

        #10;

        $display("ADD");
        $display("pcsel   = %b", pcsel);
        $display("regwen  = %b", regwen);
        $display("bsel    = %b", bsel);
        $display("alusel  = %h", alusel);
        $display("memrw   = %b", memrw);
        $display("wbsel   = %b", wbsel);

        // -------------------------------
        // SUB
        // -------------------------------
        instr = 32'b0100000_00010_00001_000_00011_0110011;

        #10;

        $display("SUB");
        $display("alusel = %h", alusel);

        // -------------------------------
        // ADDI
        // opcode = 0010011
        // -------------------------------
        instr = 32'b000000000101_00001_000_00010_0010011;

        #10;

        $display("ADDI");
        $display("immsel = %b", immsel);
        $display("bsel   = %b", bsel);
        $display("alusel = %h", alusel);

        // -------------------------------
        // LW
        // opcode = 0000011
        // -------------------------------
        instr = 32'b000000000100_00001_010_00010_0000011;

        #10;

        $display("LW");
        $display("regwen = %b", regwen);
        $display("wbsel  = %b", wbsel);
        $display("alusel = %h", alusel);

        // -------------------------------
        // SW
        // opcode = 0100011
        // -------------------------------
        instr = 32'b0000000_00010_00001_010_00100_0100011;

        #10;

        $display("SW");
        $display("memrw  = %b", memrw);
        $display("regwen = %b", regwen);

        // -------------------------------
        // BEQ NOT TAKEN
        // opcode = 1100011
        // -------------------------------
        instr = 32'b0000000_00010_00001_000_00100_1100011;
        taken_branch = 0;

        #10;

        $display("BEQ NOT TAKEN");
        $display("pcsel  = %b", pcsel);

        // -------------------------------
        // BEQ TAKEN
        // -------------------------------
        taken_branch = 1;

        #10;

        $display("BEQ TAKEN");
        $display("pcsel  = %b", pcsel);

        // -------------------------------
        // JAL
        // opcode = 1101111
        // -------------------------------
        instr = 32'b0;
        instr[6:0] = 7'b1101111;

        #10;

        $display("JAL");
        $display("pcsel  = %b", pcsel);
        $display("wbsel  = %b", wbsel);

        // -------------------------------
        // LUI
        // opcode = 0110111
        // -------------------------------
        instr = 32'b0;
        instr[6:0] = 7'b0110111;

        #10;

        $display("LUI");
        $display("immsel = %b", immsel);
        $display("alusel = %h", alusel);

        #10;
        $finish;

    end

endmodule
