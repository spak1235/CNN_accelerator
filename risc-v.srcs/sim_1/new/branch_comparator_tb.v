`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 11:03:04 AM
// Design Name: 
// Module Name: branch_comparator_tb
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

module branch_comparator_tb;

    reg [31:0] data1;
    reg [31:0] data2;
    reg [2:0] funct3;

    wire taken_branch;

    // DUT
    branch_comparator uut (
        .data1(data1),
        .data2(data2),
        .funct3(funct3),
        .taken_branch(taken_branch)
    );

    initial begin

        // -----------------------------------
        // BEQ TRUE
        // -----------------------------------
        data1 = 32'd10;
        data2 = 32'd10;
        funct3 = 3'b000;

        #10;

        $display("BEQ TRUE  : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BEQ FALSE
        // -----------------------------------
        data1 = 32'd10;
        data2 = 32'd5;
        funct3 = 3'b000;

        #10;

        $display("BEQ FALSE : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BNE TRUE
        // -----------------------------------
        data1 = 32'd20;
        data2 = 32'd15;
        funct3 = 3'b001;

        #10;

        $display("BNE TRUE  : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BLT TRUE (SIGNED)
        // -5 < 3
        // -----------------------------------
        data1 = -32'd5;
        data2 = 32'd3;
        funct3 = 3'b100;

        #10;

        $display("BLT TRUE  : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BGE TRUE (SIGNED)
        // 7 >= -2
        // -----------------------------------
        data1 = 32'd7;
        data2 = -32'd2;
        funct3 = 3'b101;

        #10;

        $display("BGE TRUE  : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BLTU TRUE (UNSIGNED)
        // 5 < 10
        // -----------------------------------
        data1 = 32'd5;
        data2 = 32'd10;
        funct3 = 3'b110;

        #10;

        $display("BLTU TRUE : taken_branch = %b", taken_branch);

        // -----------------------------------
        // BGEU TRUE (UNSIGNED)
        // 15 >= 10
        // -----------------------------------
        data1 = 32'd15;
        data2 = 32'd10;
        funct3 = 3'b111;

        #10;

        $display("BGEU TRUE : taken_branch = %b", taken_branch);

        #10;

        $finish;

    end

endmodule
