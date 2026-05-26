`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 07:31:22 PM
// Design Name: 
// Module Name: block_2
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


module block_2(
    input clk, rst,
    input signed [31:0] image_0 [143:0],
    input signed [31:0] image_1 [143:0],
    input signed [31:0] image_2 [143:0],
    input signed [31:0] bias [2:0],
    input inp_valid_0,
    input inp_valid_1,
    input inp_valid_2,

    input signed [31:0] weight_0_0 [24:0],
    input signed [31:0] weight_0_1 [24:0],
    input signed [31:0] weight_0_2 [24:0],
    input signed [31:0] weight_1_0 [24:0],
    input signed [31:0] weight_1_1 [24:0],
    input signed [31:0] weight_1_2 [24:0],
    input signed [31:0] weight_2_0 [24:0],
    input signed [31:0] weight_2_1 [24:0],
    input signed [31:0] weight_2_2 [24:0],

    output reg signed [31:0] rout_0 [15:0],
    output reg valid_0,
    output reg signed [31:0] rout_1 [15:0],
    output reg valid_1,
    output reg signed [31:0] rout_2 [15:0],
    output reg valid_2
    );

    wire signed [31:0] conv_0 [63:0];
    wire signed [31:0] conv_1 [63:0];
    wire signed [31:0] conv_2 [63:0];
    wire conv_0_valid;
    wire conv_1_valid;
    wire conv_2_valid;

    conv_chunk conv_comp(clk, rst, image_0, image_1, image_2, bias, inp_valid_0, inp_valid_1, inp_valid_2,
        weight_0_0,
        weight_0_1,
        weight_0_2,
        weight_1_0,
        weight_1_1,
        weight_1_2,
        weight_2_0,
        weight_2_1,
        weight_2_2,
        conv_0, conv_0_valid, conv_1, conv_1_valid, conv_2, conv_2_valid);

    wire signed [31:0] pool_0 [15:0];
    wire signed [31:0] pool_1 [15:0];
    wire signed [31:0] pool_2 [15:0];
    wire pool_0_valid;
    wire pool_1_valid;
    wire pool_2_valid;

    max_pooling_1 max_pool_0(clk, rst, conv_0, conv_0_valid, pool_0, pool_0_valid);
    max_pooling_1 max_pool_1(clk, rst, conv_1, conv_1_valid, pool_1, pool_1_valid);
    max_pooling_1 max_pool_2(clk, rst, conv_2, conv_2_valid, pool_2, pool_2_valid);

    relu_1 relu_0(clk, rst, pool_0, pool_0_valid, rout_0, valid_0);
    relu_1 relu_1(clk, rst, pool_1, pool_1_valid, rout_1, valid_1);
    relu_1 relu_2(clk, rst, pool_2, pool_2_valid, rout_2, valid_2);

endmodule
