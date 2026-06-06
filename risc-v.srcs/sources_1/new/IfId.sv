`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 04:12:34 PM
// Design Name: 
// Module Name: IfId
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


module IfId(
    input clk, rst,
    input [31:0] pc_out,
    input [31:0] pc_add,
    input [31:0] instr,
    input pred_taken,
    input [31:0] pred_target,
    input IfId_write,
    
    output reg [31:0] IfId_pc_out,
    output reg [31:0] IfId_pc_add,
    output reg [31:0] IfId_instr,
    output reg IfId_pred_taken,
    output reg [31:0] IfId_pred_target
    );
    
    always@(posedge clk) begin
        if(rst) begin
            IfId_pc_out <= 32'd0;
            IfId_pc_add <= 32'd0;
            IfId_instr <= 32'h00000013;
            IfId_pred_taken <= 1'b0;
            IfId_pred_target <= 32'd0;
        end
        else begin
            if(IfId_write) begin
                IfId_pc_out <= pc_out;
                IfId_pc_add <= pc_add;
                IfId_instr <= instr;
                IfId_pred_taken <= pred_taken;
                IfId_pred_target <= pred_target;
            end
        end
    end
    
endmodule
