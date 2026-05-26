`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 05:08:38 PM
// Design Name: 
// Module Name: block_1
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


module block_1(
    input clk, rst,
    input signed [31:0] image [784:0],
    input signed [31:0] bias [2:0],
    input inp_valid,

    input signed [31:0] weight_0_0 [24:0],
    input signed [31:0] weight_0_1 [24:0],
    input signed [31:0] weight_0_2 [24:0],

    output signed [31:0] rout_0 [143:0],
    output valid_0,

    output signed [31:0] rout_1 [143:0],
    output valid_1,

    output signed [31:0] rout_2 [143:0],
    output valid_2
    );

    wire signed [31:0] conv_0 [575:0];
    wire signed [31:0] conv_1 [575:0];
    wire signed [31:0] conv_2 [575:0];
    wire conv_0_valid;
    wire conv_1_valid;
    wire conv_2_valid;

    conv_layer_1 conv_layer(clk, rst, image, bias, inp_valid, weight_0_0, weight_0_1, weight_0_2, conv_0, conv_0_valid, conv_1, conv_1_valid, conv_2, conv_2_valid);

    wire signed [31:0] pool_0 [143:0];
    wire signed [31:0] pool_1 [143:0];
    wire signed [31:0] pool_2 [143:0];
    wire pool_0_valid;
    wire pool_1_valid;
    wire pool_2_valid;

    max_pooling max_pool_0(clk, rst, conv_0, conv_0_valid, pool_0, pool_0_valid);
    max_pooling max_pool_1(clk, rst, conv_1, conv_1_valid, pool_1, pool_1_valid);
    max_pooling max_pool_2(clk, rst, conv_2, conv_2_valid, pool_2, pool_2_valid);

    relu relu_0(clk, rst, pool_0, pool_0_valid, rout_0, valid_0);
    relu relu_1(clk, rst, pool_1, pool_1_valid, rout_1, valid_1);
    relu relu_2(clk, rst, pool_2, pool_2_valid, rout_2, valid_2);
endmodule
