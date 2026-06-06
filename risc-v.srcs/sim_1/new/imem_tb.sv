`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 10:37:46 PM
// Design Name: 
// Module Name: imem_tb
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

module imem_tb;

    reg [31:0] pc;

    wire [31:0] instr;

    // DUT
    imem uut (
        .pc(pc),
        .instr(instr)
    );

    initial begin

        // ---------------------------------
        // Fetch instruction 0
        // ---------------------------------
        pc = 32'd0;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        // ---------------------------------
        // Fetch instruction 1
        // ---------------------------------
        pc = 32'd4;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        // ---------------------------------
        // Fetch instruction 2
        // ---------------------------------
        pc = 32'd8;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        // ---------------------------------
        // Fetch instruction 3
        // ---------------------------------
        pc = 32'd12;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        // ---------------------------------
        // Fetch instruction 4
        // ---------------------------------
        pc = 32'd16;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        // ---------------------------------
        // Fetch instruction 8
        // ---------------------------------
        pc = 32'd32;

        #10;

        $display("PC = %d, INSTR = %h", pc, instr);

        #10;
        $finish;

    end

endmodule