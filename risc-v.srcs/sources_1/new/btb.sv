`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2026 12:10:42 PM
// Design Name: 
// Module Name: btb
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


module btb(
    input clk, rst,
    input [31:0] alu_output,
    input [31:0] prev_pc,
    input [31:0] pc,
    input ex_branch,

    output [31:0] pc_out,
    output hit
    );

    reg valid [15:0];
    reg [25:0] tag [15:0];
    reg [31:0] btb_table [15:0];

    assign pc_out = (hit) ? btb_table[pc[5:2]] : 32'd0;
    assign hit = valid[pc[5:2]] && (tag[pc[5:2]]==pc[31:6]);

    integer i;

    always@(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 16; i = i + 1'b1) begin
                btb_table[i] <= 32'd0;
                tag[i] <= 26'd0;
                valid[i] <= 1'b0;
            end
        end
        else begin
            if(ex_branch) begin
                btb_table[prev_pc[5:2]] <= alu_output;
                tag[prev_pc[5:2]] <= prev_pc[31:6];
                valid[prev_pc[5:2]] <= 1'b1;
            end
        end
    end

endmodule
