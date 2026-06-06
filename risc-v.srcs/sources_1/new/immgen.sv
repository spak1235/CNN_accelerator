`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 07:47:09 PM
// Design Name: 
// Module Name: immgen
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


module immgen(
    input [31:0] instr,
    input [2:0] immsel,
    
    output [31:0] imm
    );
    
    assign imm = (immsel == 3'b000) ? (instr[31] == 1'b1) ? {20'hFFFFF, instr[31:20]} : {20'd0, instr[31:20]}:
    (immsel == 3'b001) ? (instr[31] == 1'b1) ? {20'hFFFFF, instr[31:25], instr[11:7]} : {20'd0, instr[31:25], instr[11:7]}:
    (immsel == 3'b010) ? (instr[31] == 1'b1) ? {19'h7FFFF, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0} : {19'd0, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}:
    (immsel == 3'b011) ? {instr[31:12], 12'b0}:
    (immsel == 3'b100) ? (instr[31] == 1'b1) ? {11'h7FF, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0} : {11'd0, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}:
    32'bX;
    
endmodule
