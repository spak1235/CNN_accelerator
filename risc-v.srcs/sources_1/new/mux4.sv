`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 08:59:41 PM
// Design Name: 
// Module Name: mux4
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


module mux4 #(
    parameter WIDTH = 32  
    )(
    input [WIDTH-1:0] data1,
    input [WIDTH-1:0] data2,
    input [WIDTH-1:0] data3,
    input [WIDTH-1:0] data4,
    input [1:0] control,
    
    output [WIDTH-1:0] op
    );
    
    assign op = (control == 2'b00) ? data1 : (control == 2'b01) ? data2 : (control == 2'b10) ? data3 : data4;
    
endmodule

