`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 04:13:13 PM
// Design Name: 
// Module Name: ExMa
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


module ExMa(
    input clk, rst,
    input [31:0] alu_output,
    input [31:0] datab,
    input memrw,
    input [4:0] addrd,
    input regwen,
    input [31:0] pc_add,
    input [31:0] pc_out,
    input [1:0] wbsel,
    input taken_branch,
    input branch,
    input memread,
    input pred_taken,
    input [31:0] pred_target,
    input ExMa_write,
    
    output reg [31:0] ExMa_alu_output,
    output reg [31:0] ExMa_datab,
    output reg ExMa_memrw,
    output reg [4:0] ExMa_addrd,
    output reg ExMa_regwen,
    output reg [31:0] ExMa_pc_add,
    output reg [31:0] ExMa_pc_out,
    output reg [1:0] ExMa_wbsel,
    output reg ExMa_taken_branch,
    output reg ExMa_branch,
    output reg ExMa_memread,
    output reg ExMa_pred_taken,
    output reg [31:0] ExMa_pred_target
    );
    
    always@(posedge clk) begin
        if(rst) begin
            ExMa_alu_output <= 32'd0;
            ExMa_datab <= 32'd0;
            ExMa_memrw <= 1'b0;
            ExMa_addrd <= 5'd0;
            ExMa_regwen <= 1'b0;
            ExMa_pc_add <= 32'd0;
            ExMa_pc_out <= 32'd0;
            ExMa_wbsel <= 2'b00;
            ExMa_taken_branch <= 1'b0;
            ExMa_branch <= 1'b0;
            ExMa_memread <= 1'b0;
            ExMa_pred_taken <= 1'b0;
            ExMa_pred_target <= 32'd0;
        end
        else begin
            if(ExMa_write) begin
                ExMa_alu_output <= alu_output;
                ExMa_datab <= datab;
                ExMa_memrw <= memrw;
                ExMa_addrd <= addrd;
                ExMa_regwen <= regwen;
                ExMa_pc_add <= pc_add;
                ExMa_pc_out <= pc_out;
                ExMa_wbsel <= wbsel;
                ExMa_taken_branch <= taken_branch;
                ExMa_branch <= branch;
                ExMa_memread <= memread;
                ExMa_pred_taken <= pred_taken;
                ExMa_pred_target <= pred_target;
            end
        end
    end
endmodule
