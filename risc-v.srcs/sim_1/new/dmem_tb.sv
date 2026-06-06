`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 10:57:01 PM
// Design Name: 
// Module Name: dmem_tb
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

module dmem_tb;

    reg clk;
    reg memrw;

    reg [31:0] addr;
    reg [31:0] dataw;

    wire [31:0] datar;

    // DUT
       dmem uut (
        .clk(clk),
        .addr(addr),
        .dataw(dataw),
        .memrw(memrw),
        .datar(datar)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // -----------------------------
        // INITIAL VALUES
        // -----------------------------
        memrw = 0;
        addr = 0;
        dataw = 0;

        #10;

        // -----------------------------
        // READ address 0
        // should read 5
        // -----------------------------
        addr = 32'd0;

        #10;

        $display("ADDR = %d DATA = %d", addr, datar);

        // -----------------------------
        // READ address 4
        // should read 10
        // -----------------------------
        addr = 32'd4;

        #10;

        $display("ADDR = %d DATA = %d", addr, datar);

        // -----------------------------
        // READ address 8
        // should read 15
        // -----------------------------
        addr = 32'd8;

        #10;

        $display("ADDR = %d DATA = %d", addr, datar);

        // -----------------------------
        // WRITE 100 to address 8
        // -----------------------------
        memrw = 1;
        addr = 32'd8;
        dataw = 32'd100;

        #10;

        // Stop writing
        memrw = 0;

        // -----------------------------
        // READ address 8 again
        // should now read 100
        // -----------------------------
        #10;

        $display("ADDR = %d DATA = %d", addr, datar);

        // -----------------------------
        // WRITE 55 to address 0
        // -----------------------------
        memrw = 1;
        addr = 32'd0;
        dataw = 32'd55;

        #10;

        memrw = 0;

        // -----------------------------
        // READ address 0 again
        // should read 55
        // -----------------------------
        #10;

        $display("ADDR = %d DATA = %d", addr, datar);

        #10;
        $finish;

    end

endmodule
