`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 07:37:47 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input [31:0] pc,

    output [31:0] instr
    );

    reg [31:0] imem [255:0];

    initial begin
        $readmemh("instruction_mem.mem", imem);
    end

    assign instr = imem[pc>>2];

endmodule
