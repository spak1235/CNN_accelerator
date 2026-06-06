`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 06:51:53 PM
// Design Name: 
// Module Name: mux3
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


module mux3(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [1:0] control,
    
    output [31:0] op
    );
    
    assign op = (control == 2'b00) ? data1 : (control == 2'b01) ? data2 : data3;
    
endmodule
