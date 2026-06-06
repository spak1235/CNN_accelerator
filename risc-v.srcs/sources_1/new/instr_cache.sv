`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 07:37:01 PM
// Design Name: 
// Module Name: instr_cache
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


module instr_cache(
    input clk,
    input rst,
    input [31:0] addr,
    input [31:0] instr_mem,
    
    output [31:0] instr,
    output hit
    );

    reg [31:0] imem_cache [15:0];
    reg [25:0] cache_tag [15:0];
    reg [0:0] valid [15:0];

    assign hit = (cache_tag[addr[5:2]] == (addr>>6)) && valid[addr[5:2]];

    assign instr = (hit) ? imem_cache[addr[5:2]] : 32'h00000013;

    integer i;

    always@(posedge clk) begin
        if(rst) begin
            for(i=0; i<16; i=i+1) begin
                valid[i] <= 1'b0;
            end
        end
        else begin
            if(!hit) begin
                imem_cache[addr[5:2]] <= instr_mem;
                valid[addr[5:2]] <= 1'b1;
                cache_tag[addr[5:2]] <= addr>>6; 
            end
        end
    end
endmodule
