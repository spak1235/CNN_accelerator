`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 08:15:50 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk, rst,
    input [7:0] image [783:0],
    input inp_valid,
    
    output signed [31:0] rout [9:0],
    output [2:0] digit,
    output valid
    );
    
    wire signed [31:0] image_ext [783:0];
    reg signed [7:0] weight0_mem [24:0];
    reg signed [7:0] weight1_mem [24:0];
    reg signed [7:0] weight2_mem [24:0];

    reg signed [31:0] weight_0_0 [24:0];
    reg signed [31:0] weight_0_1 [24:0];
    reg signed [31:0] weight_0_2 [24:0];


    reg signed [7:0] weight2_0_0_mem [24:0];
    reg signed [7:0] weight2_0_1_mem [24:0];
    reg signed [7:0] weight2_0_2_mem [24:0];
    reg signed [7:0] weight2_1_0_mem [24:0];
    reg signed [7:0] weight2_1_1_mem [24:0];
    reg signed [7:0] weight2_1_2_mem [24:0];
    reg signed [7:0] weight2_2_0_mem [24:0];
    reg signed [7:0] weight2_2_1_mem [24:0];
    reg signed [7:0] weight2_2_2_mem [24:0];

    reg signed [31:0] weight2_0_0 [24:0];
    reg signed [31:0] weight2_0_1 [24:0];
    reg signed [31:0] weight2_0_2 [24:0];
    reg signed [31:0] weight2_1_0 [24:0];
    reg signed [31:0] weight2_1_1 [24:0];
    reg signed [31:0] weight2_1_2 [24:0];
    reg signed [31:0] weight2_2_0 [24:0];
    reg signed [31:0] weight2_2_1 [24:0];
    reg signed [31:0] weight2_2_2 [24:0];

    reg signed [7:0] bias1_mem [2:0];
    reg signed [7:0] bias2_mem [2:0];

    reg signed [31:0] bias1 [2:0];
    reg signed [31:0] bias2 [2:0];

    integer i;

    genvar k;

    generate
        for(k=0; k<784; k=k+1) begin
            assign image_ext[k] = {24'd0, image[k]};
        end
    endgenerate

    initial begin
        $readmemh("weight_1_0.mem", weight0_mem);
        $readmemh("weight_1_1.mem", weight1_mem);
        $readmemh("weight_1_2.mem", weight2_mem);

        $readmemh("weight_2_0_0.mem", weight2_0_0_mem);
        $readmemh("weight_2_0_1.mem", weight2_0_1_mem);
        $readmemh("weight_2_0_2.mem", weight2_0_2_mem);

        $readmemh("weight_2_1_0.mem", weight2_1_0_mem);
        $readmemh("weight_2_1_1.mem", weight2_1_1_mem);
        $readmemh("weight_2_1_2.mem", weight2_1_2_mem);

        $readmemh("weight_2_2_0.mem", weight2_2_0_mem);
        $readmemh("weight_2_2_1.mem", weight2_2_1_mem);
        $readmemh("weight_2_2_2.mem", weight2_2_2_mem);

        $readmemh("bias_1.mem", bias1_mem);
        $readmemh("bias_2.mem", bias2_mem);

        for(i=0; i<25; i=i+1) begin

            weight_0_0[i] = {{24{weight0_mem[i][7]}}, weight0_mem[i]};
            weight_0_1[i] = {{24{weight1_mem[i][7]}}, weight1_mem[i]};
            weight_0_2[i] = {{24{weight2_mem[i][7]}}, weight2_mem[i]};

            weight2_0_0[i] = {{24{weight2_0_0_mem[i][7]}}, weight2_0_0_mem[i]};
            weight2_0_1[i] = {{24{weight2_0_1_mem[i][7]}}, weight2_0_1_mem[i]};
            weight2_0_2[i] = {{24{weight2_0_2_mem[i][7]}}, weight2_0_2_mem[i]};

            weight2_1_0[i] = {{24{weight2_1_0_mem[i][7]}}, weight2_1_0_mem[i]};
            weight2_1_1[i] = {{24{weight2_1_1_mem[i][7]}}, weight2_1_1_mem[i]};
            weight2_1_2[i] = {{24{weight2_1_2_mem[i][7]}}, weight2_1_2_mem[i]};

            weight2_2_0[i] = {{24{weight2_2_0_mem[i][7]}}, weight2_2_0_mem[i]};
            weight2_2_1[i] = {{24{weight2_2_1_mem[i][7]}}, weight2_2_1_mem[i]};
            weight2_2_2[i] = {{24{weight2_2_2_mem[i][7]}}, weight2_2_2_mem[i]};

        end

        for(i=0; i<3; i=i+1) begin
            bias1[i] = {{24{bias1_mem[i][7]}}, bias1_mem[i]};
            bias2[i] = {{24{bias2_mem[i][7]}}, bias2_mem[i]};
        end

    end

    wire signed [31:0] block1_out_0 [143:0];
    wire signed [31:0] block1_out_1 [143:0];
    wire signed [31:0] block1_out_2 [143:0];
    wire block1_valid_0;
    wire block1_valid_1;
    wire block1_valid_2;

    block_1 block_1(clk, rst, image_ext, bias1, inp_valid, weight_0_0, weight_0_1, weight_0_2,
        block1_out_0, block1_valid_0,
        block1_out_1, block1_valid_1,
        block1_out_2, block1_valid_2);

    wire signed [31:0] block2_out_0 [15:0];
    wire signed [31:0] block2_out_1 [15:0];
    wire signed [31:0] block2_out_2 [15:0];
    wire block2_valid_0;
    wire block2_valid_1;
    wire block2_valid_2;

    block_2 block_2(clk, rst, block1_out_0, block1_out_1, block1_out_2, bias2, block1_valid_0, block1_valid_1, block1_valid_2,
        weight2_0_0,
        weight2_0_1,
        weight2_0_2,
        weight2_1_0,
        weight2_1_1,
        weight2_1_2,
        weight2_2_0,
        weight2_2_1,
        weight2_2_2,
        block2_out_0, block2_valid_0, block2_out_1, block2_valid_1, block2_out_2, block2_valid_2);
    
    genvar g;
    
    wire signed [31:0] fc_input [47:0];
    wire fc_valid;

    assign fc_valid = block2_valid_0 && block2_valid_1 && block2_valid_2;

    generate
        for(g = 0; g < 32'd16; g = g + 1'b1) begin
            assign fc_input[g] = block2_out_0[g];
            assign fc_input[g + 32'd16] = block2_out_1[g];
            assign fc_input[g + (2*32'd16)] = block2_out_2[g];
        end
    endgenerate 

    full_nn full_nn(clk, rst, fc_input, fc_valid, rout, valid);

    reg signed [31:0] max_val;
    reg [2:0] pred_digit;

    integer d;

    always @(*) begin

        max_val = rout[0];
        pred_digit = 3'd0;

        for(d = 1; d < 10; d = d + 1) begin
            if(rout[d] > max_val) begin
                max_val = rout[d];
                pred_digit = d[2:0];
            end
        end

    end

    assign digit = pred_digit;

endmodule
