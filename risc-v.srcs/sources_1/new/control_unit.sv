`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 09:32:58 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [31:0] instr,
    //input taken_branch,

    //output pcsel,
    output [2:0] immsel,
    output regwen,
    output bsel,
    output asel,
    output [3:0] alusel,
    output memrw,
    output [1:0] wbsel,
    output memread
);

    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];

    alu_decoder aludecoder(opcode, funct3, funct7, alusel);

    //assign pcsel = (opcode == 7'b1101111 || opcode == 7'b1100111) ? 1'b1 : (opcode == 7'b1100011) ? taken_branch : 1'b0;

    assign immsel = (opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b1100111) ? 3'b000 :
    (opcode == 7'b0100011) ? 3'b001 :
    (opcode == 7'b1100011) ? 3'b010 :
    (opcode == 7'b0110111 || opcode == 7'b0010111) ? 3'b011 :
    (opcode == 7'b1101111) ? 3'b100 :
    3'bXXX;

    assign regwen = (opcode == 7'b0100011 || opcode == 7'b1100011) ? 1'b0 : 1'b1;

    assign bsel = (opcode == 7'b0110011) ? 1'b0 : 1'b1;

    assign memrw = (opcode == 7'b0100011) ? 1'b1 : 1'b0;

    assign wbsel = (opcode == 7'b0000011) ? 2'b01 :
    (opcode == 7'b1101111 || opcode == 7'b1100111) ? 2'b10 :
    2'b00;
    
    assign asel = (opcode == 7'b0010111 || opcode == 7'b1100011 || opcode == 7'b1101111) ? 1'b1 : 1'b0;
    
    assign memread = (opcode == 7'b0000011) ? 1'b1 : 1'b0;

endmodule
