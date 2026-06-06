`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2026 08:02:31 PM
// Design Name: 
// Module Name: dmem_cache
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


module dmem_cache(
    input clk, rst,
    input [31:0] addr,
    input [31:0] dataw,
    input memrw,
    
    output [31:0] datar,
    output hit
    );

    wire [31:0] rep_addr, rep_data;
    wire [31:0] mem_data;
    wire rep_valid;

    data_cache data_cache(clk, rst, addr, dataw, mem_data, memrw, datar, hit, rep_addr, rep_data, rep_valid);

    data_mem data_mem(clk, rst, addr, rep_valid, rep_addr, rep_data, mem_data);
endmodule
