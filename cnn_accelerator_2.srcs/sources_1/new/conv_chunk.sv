`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 06:43:17 PM
// Design Name: 
// Module Name: conv_chunk
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


module conv_chunk(
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

    output reg signed [31:0] rout_0 [63:0],
    output reg valid_0,
    output reg signed [31:0] rout_1 [63:0],
    output reg valid_1,
    output reg signed [31:0] rout_2 [63:0],
    output reg valid_2
    );

    wire signed [63:0] rout_0_0 [63:0];
    wire signed [63:0] rout_0_1 [63:0];
    wire signed [63:0] rout_0_2 [63:0];
    wire valid_0_0;
    wire valid_0_1;
    wire valid_0_2;

    conv_chunk_base conv_2_0_0(clk, rst, image_0, inp_valid_0, weight_0_0, rout_0_0, valid_0_0);
    conv_chunk_base conv_2_0_1(clk, rst, image_1, inp_valid_1, weight_0_1, rout_0_1, valid_0_1);
    conv_chunk_base conv_2_0_2(clk, rst, image_2, inp_valid_2, weight_0_2, rout_0_2, valid_0_2);

    wire signed [63:0] rout_1_0 [63:0];
    wire signed [63:0] rout_1_1 [63:0];
    wire signed [63:0] rout_1_2 [63:0];
    wire valid_1_0;
    wire valid_1_1;
    wire valid_1_2;

    conv_chunk_base conv_2_1_0(clk, rst, image_0, inp_valid_0, weight_1_0, rout_1_0, valid_1_0);
    conv_chunk_base conv_2_1_1(clk, rst, image_1, inp_valid_1, weight_1_1, rout_1_1, valid_1_1);
    conv_chunk_base conv_2_1_2(clk, rst, image_2, inp_valid_2, weight_1_2, rout_1_2, valid_1_2);

    wire signed [63:0] rout_2_0 [63:0];
    wire signed [63:0] rout_2_1 [63:0];
    wire signed [63:0] rout_2_2 [63:0];
    wire valid_2_0;
    wire valid_2_1;
    wire valid_2_2;

    conv_chunk_base conv_2_2_0(clk, rst, image_0, inp_valid_0, weight_2_0, rout_2_0, valid_2_0);
    conv_chunk_base conv_2_2_1(clk, rst, image_1, inp_valid_1, weight_2_1, rout_2_1, valid_2_1);
    conv_chunk_base conv_2_2_2(clk, rst, image_2, inp_valid_2, weight_2_2, rout_2_2, valid_2_2);

    wire signed [63:0] temp_rout_0 [63:0];
    wire signed [63:0] temp_rout_1 [63:0];
    wire signed [63:0] temp_rout_2 [63:0];

    genvar i;

    generate 

        for(i=0; i<64; i=i+1'b1) begin
            assign temp_rout_0[i] = rout_0_0[i] + rout_0_1[i] + rout_0_2[i];
            assign temp_rout_1[i] = rout_1_0[i] + rout_1_1[i] + rout_1_2[i];
            assign temp_rout_2[i] = rout_2_0[i] + rout_2_1[i] + rout_2_2[i];
        end

    endgenerate

    integer a, b, c;

    always@(posedge clk) begin

        if(valid_0_0 && valid_0_1 && valid_0_2) begin
            for(a=0; a<64; a=a+1'b1) begin
                if((temp_rout_0[a]>>>6) + bias[0] > 64'sd127) rout_0[a] <= 32'sd127;
                else if((temp_rout_0[a]>>>6) + bias[0] < -64'sd128) rout_0[a] <= -32'sd128;
                else rout_0[a] <= (temp_rout_0[a]>>>6) + bias[0];
            end
            valid_0 <= 1'b1;
        end
        else valid_0 <= 1'b0;

        if(valid_1_0 && valid_1_1 && valid_1_2) begin
            for(b=0; b<64; b=b+1'b1)begin
                if((temp_rout_1[b]>>>6) + bias[1] > 64'sd127) rout_1[b] <= 32'sd127;
                else if((temp_rout_1[b]>>>6) + bias[1] < -64'sd128) rout_1[b] <= -32'sd128;
                else rout_1[b] <= (temp_rout_1[b]>>>6) + bias[1];
            end
            valid_1 <= 1'b1;
        end
        else valid_1 <= 1'b0;

        if(valid_2_0 && valid_2_1 && valid_2_2) begin
            for(c=0; c<64; c=c+1'b1) begin
                if((temp_rout_2[c]>>>6) + bias[2] > 64'sd127) rout_2[c] <= 32'sd127;
                else if((temp_rout_2[c]>>>6) + bias[2] < -64'sd128) rout_2[c] <= -32'sd128;
                else rout_2[c] <= (temp_rout_2[c]>>>6) + bias[2];
            end
            valid_2 <= 1'b1;
        end
        else valid_2 <= 1'b0;

    end

endmodule
