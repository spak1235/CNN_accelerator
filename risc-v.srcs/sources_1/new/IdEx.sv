`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 04:12:52 PM
// Design Name: 
// Module Name: IdEx
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


module IdEx(
    input clk, rst,
    input [31:0] dataA, dataB,
    input [31:0] imm_instr,
    input [31:0] pc_out, pc_add,
    input [2:0] funct3,
    input [4:0] addrd, addra, addrb,
    input regwen,
    input asel, bsel,
    input [3:0] alusel,
    input memrw,
    input [1:0] wbsel,
    input branch, jump,
    input memread,
    input pred_taken,
    input [31:0] pred_target,
    input IdEx_write,
    
    output reg [31:0] IdEx_dataA, IdEx_dataB,
    output reg [31:0] IdEx_imm_instr,
    output reg [31:0] IdEx_pc_out, IdEx_pc_add,
    output reg [2:0] IdEx_funct3,
    output reg [4:0] IdEx_addrd, IdEx_addra, IdEx_addrb,
    output reg IdEx_regwen,
    output reg IdEx_asel, IdEx_bsel,
    output reg [3:0] IdEx_alusel,
    output reg IdEx_memrw,
    output reg [1:0] IdEx_wbsel,
    output reg IdEx_branch, IdEx_jump,
    output reg IdEx_memread,
    output reg IdEx_pred_taken,
    output reg [31:0] IdEx_pred_target
    );
    
    always@(posedge clk) begin
        if(rst) begin
            IdEx_dataA <= 32'd0;
            IdEx_dataB <= 32'd0;
            IdEx_imm_instr <= 32'd0;
            IdEx_pc_out <= 32'd0;
            IdEx_pc_add <= 32'd0;
            IdEx_funct3 <= 3'b000;
            IdEx_addrd <= 5'b00000;
            IdEx_addra <= 5'b00000;
            IdEx_addrb <= 5'b00000;
            IdEx_regwen <= 1'b0;
            IdEx_asel <= 1'b0;
            IdEx_bsel <= 1'b0;
            IdEx_alusel <= 4'd0;
            IdEx_memrw <= 1'b0;
            IdEx_wbsel <= 2'b00;
            IdEx_branch <= 1'b0;
            IdEx_jump <= 1'b0;
            IdEx_memread <= 1'b0;
            IdEx_pred_taken <= 1'b0;
            IdEx_pred_target <= 32'd0;
        end
        else begin
            if(IdEx_write) begin
                IdEx_dataA <= dataA;
                IdEx_dataB <= dataB;
                IdEx_imm_instr <= imm_instr;
                IdEx_pc_out <= pc_out;
                IdEx_pc_add <= pc_add;
                IdEx_funct3 <= funct3;
                IdEx_addrd <= addrd;
                IdEx_addra <= addra;
                IdEx_addrb <= addrb;
                IdEx_regwen <= regwen;
                IdEx_asel <= asel;
                IdEx_bsel <= bsel;
                IdEx_alusel <= alusel;
                IdEx_memrw <= memrw;
                IdEx_wbsel <= wbsel;
                IdEx_branch <= branch;
                IdEx_jump <= jump;
                IdEx_memread <= memread;
                IdEx_pred_taken <= pred_taken;
                IdEx_pred_target <= pred_target;
            end
        end
    end

endmodule
