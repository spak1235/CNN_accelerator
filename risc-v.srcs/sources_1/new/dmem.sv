`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 10:46:44 PM
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,
    input [31:0] addr,
    input [31:0] dataw,
    input memrw,
    
    output [31:0] datar
    );
    
    reg [31:0] datamemorys [255:0];
    
    initial begin
        $readmemh("data_mem.mem", datamemorys);
    end
    
    always@(posedge clk) begin
        if(memrw == 1'b1) begin
            datamemorys[addr>>2] <= dataw;
        end
    end
    
    assign datar = datamemorys[addr>>2];
endmodule
