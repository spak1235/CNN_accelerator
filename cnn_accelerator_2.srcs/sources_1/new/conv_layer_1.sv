`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 05:01:03 PM
// Design Name: 
// Module Name: conv_layer_1
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


module conv_layer_1(
    input clk, rst,
    input signed [31:0] image [784:0],
    input signed [31:0] bias [2:0],
    input inp_valid,

    input signed [31:0] weight_0_0 [24:0],
    input signed [31:0] weight_0_1 [24:0],
    input signed [31:0] weight_0_2 [24:0],

    output signed [31:0] rout_0 [575:0],
    output valid_0,

    output signed [31:0] rout_1 [575:0],
    output valid_1,

    output signed [31:0] rout_2 [575:0],
    output valid_2
    );

    conv2d_faster conv_0_0(clk, rst, image, bias[0], inp_valid, weight_0_0, rout_0, valid_0);

    conv2d_faster conv_0_1(clk, rst, image, bias[1], inp_valid, weight_0_1, rout_1, valid_1);

    conv2d_faster conv_0_2(clk, rst, image, bias[2], inp_valid, weight_0_2, rout_2, valid_2);
endmodule
