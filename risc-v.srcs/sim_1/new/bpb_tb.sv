`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 07:47:35 PM
// Design Name: 
// Module Name: bpb_tb
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


module bpb_tb;

    reg clk;
    reg rst;

    reg branch_taken;

    reg [31:0] prev_pc;

    reg [31:0] instr;
    reg [31:0] ex_instr;

    reg [31:0] pc_out;

    wire branch_pred;

    // -------------------------------------------------
    // DUT
    // -------------------------------------------------

    bpb uut(
        .clk(clk),
        .rst(rst),
        .branch_taken(branch_taken),
        .prev_pc(prev_pc),
        .instr(instr),
        .ex_instr(ex_instr),
        .pc_out(pc_out),
        .branch_pred(branch_pred)
    );

    // -------------------------------------------------
    // CLOCK
    // -------------------------------------------------

    initial begin

        clk = 0;

        forever #5 clk = ~clk;

    end

    // -------------------------------------------------
    // TEST
    // -------------------------------------------------

    initial begin

        $display("========================================================================================");
        $display("TIME\tPC\tINSTR\t\tEX_INSTR\tBR_TAKEN\tPREDICTION");
        $display("========================================================================================");

        $monitor("%0t\t%h\t%h\t%h\t%b\t\t%b",
                 $time,
                 pc_out,
                 instr,
                 ex_instr,
                 branch_taken,
                 branch_pred);

        // -------------------------------------------------
        // RESET
        // -------------------------------------------------

        rst = 1'b1;

        branch_taken = 1'b0;

        prev_pc = 32'd0;

        instr = 32'd0;
        ex_instr = 32'd0;

        pc_out = 32'd0;

        #20;

        rst = 1'b0;

        // -------------------------------------------------
        // FIRST TIME BRANCH
        // Predictor should initially predict NOT TAKEN
        // -------------------------------------------------

        pc_out = 32'h00000020;

        // beq x1,x2,8
        instr = 32'h00208463;

        #10;

        // -------------------------------------------------
        // Branch resolves TAKEN in EX stage
        // Predictor should learn TAKEN
        // -------------------------------------------------

        ex_instr = 32'h00208463;

        prev_pc = 32'h00000020;

        branch_taken = 1'b1;

        #10;

        // -------------------------------------------------
        // Fetch SAME branch again
        // Predictor should now predict TAKEN
        // -------------------------------------------------

        ex_instr = 32'd0;
        branch_taken = 1'b0;

        pc_out = 32'h00000020;
        instr = 32'h00208463;

        #10;

        // -------------------------------------------------
        // Now branch resolves NOT TAKEN
        // Predictor should learn NOT TAKEN
        // -------------------------------------------------

        ex_instr = 32'h00208463;

        prev_pc = 32'h00000020;

        branch_taken = 1'b0;

        #10;

        // -------------------------------------------------
        // Fetch SAME branch again
        // Predictor should now predict NOT TAKEN
        // -------------------------------------------------

        ex_instr = 32'd0;

        pc_out = 32'h00000020;
        instr = 32'h00208463;

        #10;

        // -------------------------------------------------
        // Non-branch instruction
        // Predictor output should be 0
        // -------------------------------------------------

        instr = 32'h00500093; // addi

        #10;

        $finish;

    end

endmodule
