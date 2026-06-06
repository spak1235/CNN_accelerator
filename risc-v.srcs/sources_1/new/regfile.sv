`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 07:10:41 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input [4:0] addrA, addrB, addrD,
    input [31:0] wb,
    input regwen,
    
    output [31:0] dataA, 
    output [31:0] dataB
    );
    
    reg [31:0] regs [31:0];
    
    always@(negedge clk) begin
        if(regwen && addrD != 5'd0) begin
            regs[addrD] <= wb;
        end
    end
    
    assign dataA = (addrA == 5'd0) ? 32'd0 : regs[addrA];
    assign dataB = (addrB == 5'd0) ? 32'd0 : regs[addrB];
endmodule
