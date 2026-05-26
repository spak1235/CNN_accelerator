`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 01:37:04 PM
// Design Name: 
// Module Name: mac
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


module mac(
    input clk, rst,
    input signed [31:0] a, b,
    input signed [63:0] c,

    output reg signed [63:0] rout
    );

    wire signed [63:0] mul;

    assign mul = a*b;

    always@(posedge clk) begin
        if(rst) rout <= 64'sd0;

        else begin
            rout <= mul + c;
        end
    end
endmodule
