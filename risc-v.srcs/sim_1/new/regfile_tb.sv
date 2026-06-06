`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 07:27:08 PM
// Design Name: 
// Module Name: regfile_tb
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

module regfile_tb;

    reg clk;
    reg regwen;

    reg [4:0] addrA;
    reg [4:0] addrB;
    reg [4:0] addrD;

    reg [31:0] wb;

    wire [31:0] dataA;
    wire [31:0] dataB;

    // DUT
    regfile uut (
        .clk(clk),
        .addrA(addrA),
        .addrB(addrB),
        .addrD(addrD),
        .wb(wb),
        .regwen(regwen),
        .dataA(dataA),
        .dataB(dataB)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial values
        regwen = 0;
        addrA = 0;
        addrB = 0;
        addrD = 0;
        wb = 0;

        #10;

        // ---------------------------------
        // Write 5 into x1
        // ---------------------------------
        regwen = 1;
        addrD = 5'd1;
        wb = 32'd5;

        #10;

        // ---------------------------------
        // Write 10 into x2
        // ---------------------------------
        addrD = 5'd2;
        wb = 32'd10;

        #10;

        // Stop writing
        regwen = 0;

        // ---------------------------------
        // Read x1 and x2
        // ---------------------------------
        addrA = 5'd1;
        addrB = 5'd2;

        #5;

        $display("x1 = %d", dataA);
        $display("x2 = %d", dataB);

        // ---------------------------------
        // Attempt write to x0
        // ---------------------------------
        regwen = 1;
        addrD = 5'd0;
        wb = 32'd999;

        #10;

        regwen = 0;

        // Read x0
        addrA = 5'd0;

        #5;

        $display("x0 = %d (should be 0)", dataA);

        // ---------------------------------
        // Read same register on both ports
        // ---------------------------------
        addrA = 5'd2;
        addrB = 5'd2;

        #5;

        $display("x2 from A = %d", dataA);
        $display("x2 from B = %d", dataB);

        // Finish simulation
        #10;
        $finish;

    end

endmodule