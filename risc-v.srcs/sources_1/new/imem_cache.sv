`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 07:53:21 PM
// Design Name: 
// Module Name: imem_cache
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


module imem_cache(
    input clk, rst,
    input [31:0] pc,

    output [31:0] instr,
    output hit
    );

    wire [31:0] mem_instr;

    instr_cache instruction_cache(clk, rst, pc, mem_instr, instr, hit);

    instr_mem instruction_mem(pc, mem_instr);
    
endmodule
