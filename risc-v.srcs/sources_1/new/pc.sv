`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 11:34:45 AM
// Design Name: 
// Module Name: pc
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


module pc(
    input clk, rst,
    input pc_write,
    input [31:0] next_pc,
    
    output reg [31:0] pc
    );
    
    always@(posedge clk) begin
        if(rst) begin
            pc <= 32'd0;
        end
        else begin
            if(pc_write)
            pc <= next_pc;
        end
    end
    
endmodule
