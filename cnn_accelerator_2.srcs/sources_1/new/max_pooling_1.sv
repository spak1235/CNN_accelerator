`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 07:39:12 PM
// Design Name: 
// Module Name: max_pooling_1
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


module max_pooling_1(
    input clk, rst,
    input signed [31:0] image [63:0],
    input inp_valid,

    output reg signed [31:0] rout [15:0],
    output reg valid
    );

    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam CLEAR = 2'b10;
    
    reg [1:0] state;
    reg [31:0] op_row_counter;
    reg [31:0] op_col_counter;
    wire [31:0] op_counter;
    
    wire [31:0] ip_0;
    wire [31:0] ip_1;
    wire [31:0] ip_2;
    wire [31:0] ip_3;
    
    wire comp_0_1;
    wire comp_0_2;
    wire comp_0_3;
    wire comp_1_2;
    wire comp_1_3;
    wire comp_2_3;
    
    wire [5:0] comp;
    
    assign op_counter = (op_row_counter * 32'd4) + op_col_counter;
    
    assign ip_0 = ((op_row_counter*32'd2) * 32'd8) + (op_col_counter*32'd2);
    assign ip_1 = ((op_row_counter*32'd2) * 32'd8) + ((op_col_counter*32'd2) + 1'b1);
    assign ip_2 = (((op_row_counter*32'd2) + 1'b1) * 32'd8) + (op_col_counter*32'd2);
    assign ip_3 = (((op_row_counter*32'd2) + 1'b1) * 32'd8) + ((op_col_counter*32'd2) + 1'b1);
    
    assign comp_0_1 = (image[ip_0] >= image[ip_1]);
    assign comp_0_2 = (image[ip_0] >= image[ip_2]);
    assign comp_0_3 = (image[ip_0] >= image[ip_3]);
    assign comp_1_2 = (image[ip_1] >= image[ip_2]);
    assign comp_1_3 = (image[ip_1] >= image[ip_3]);
    assign comp_2_3 = (image[ip_2] >= image[ip_3]);
    
    assign comp = {comp_0_1, comp_0_2, comp_0_3, comp_1_2, comp_1_3, comp_2_3}; 

    always@(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            op_row_counter <= 32'd0;
            op_col_counter <= 32'd0;
            valid <= 1'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    valid <= 1'b0;
                    op_row_counter <= 32'd0;
                    op_col_counter <= 32'd0;
                    if(inp_valid)
                        state <= CALC;
                end
                CALC: begin
                    if(op_counter < 32'd64) begin
                        if(op_col_counter < 32'd7)
                            op_col_counter <= op_col_counter + 1'b1;
                        else begin
                            op_row_counter <= op_row_counter + 1'b1;
                            op_col_counter <= 32'd0;
                        end
                        
                        if(comp[5:3] == 3'b111)
                            rout[op_counter] <= image[ip_0];
                        else if({comp[5], comp[2:1]} == 3'b011)
                            rout[op_counter] <= image[ip_1];
                        else if({comp[5], comp[2], comp[0]} == 3'b001)
                            rout[op_counter] <= image[ip_2];
                        else
                            rout[op_counter] <= image[ip_3];
                    end
                    else begin
                        state <= CLEAR;
                    end
                end
                CLEAR: begin
                    valid <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
