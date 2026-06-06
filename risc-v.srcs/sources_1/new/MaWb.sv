`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 04:13:43 PM
// Design Name: 
// Module Name: MaWb
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


module MaWb(
    input clk, rst,
    input [4:0] addrd,
    input [31:0] datar,
    input [31:0] alu_output,
    input [31:0] pc_add,
    input [1:0] wbsel,
    input regwen,
    input MaWb_write,
    
    output reg [4:0] MaWb_addrd,
    output reg [31:0] MaWb_datar,
    output reg [31:0] MaWb_alu_output,
    output reg [31:0] MaWb_pc_add,
    output reg [1:0] MaWb_wbsel,
    output reg MaWb_regwen
    );
    
    always@(posedge clk) begin
        if(rst) begin
            MaWb_addrd <= 5'd0;
            MaWb_datar <= 32'd0;
            MaWb_alu_output <= 32'd0;
            MaWb_pc_add <= 32'd0;
            MaWb_wbsel <= 2'b00;
            MaWb_regwen <= 1'b0;
            
        end
        else begin
            if(MaWb_write) begin
                MaWb_addrd <= addrd;
                MaWb_datar <= datar;
                MaWb_alu_output <= alu_output;
                MaWb_pc_add <= pc_add;
                MaWb_wbsel <= wbsel;
                MaWb_regwen <= regwen;
            end
        end
    end
    
endmodule
