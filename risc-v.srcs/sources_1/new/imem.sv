`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 08:35:25 PM
// Design Name: 
// Module Name: imem
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


module imem(
    input [31:0] pc,
    
    output [31:0] instr
    );
    
    reg [31:0] imems [255:0];
    
    initial begin
        $readmemh("instruction_mem.mem", imems);
    end
    
    assign instr = imems[pc>>2][31:0];
endmodule
