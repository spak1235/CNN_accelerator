`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2026 08:02:11 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input clk, rst,
    input [31:0] addr,
    input rep_valid,
    input [31:0] rep_addr,
    input [31:0] rep_data,

    output [31:0] datar
    );

    reg [31:0] dmem [255:0];

    initial begin
        $readmemh("data_mem.mem", dmem);
    end

    always@(posedge clk) begin
        if(rst) begin
            
        end
        else begin
            if(rep_valid) begin
                dmem[rep_addr>>2] <= rep_data;
            end
        end
    end

    assign datar = dmem[addr>>2];

endmodule
