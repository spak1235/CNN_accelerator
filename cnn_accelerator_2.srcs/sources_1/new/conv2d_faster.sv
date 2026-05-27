`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2026 05:13:59 PM
// Design Name: 
// Module Name: conv2d_faster
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


module conv2d_faster(
    input clk, rst,
    input signed [31:0] image [783:0],
    input signed [31:0] bias,
    input inp_valid,

    input signed [31:0] weight [24:0],

    output reg signed [31:0] rout [575:0],
    output reg valid
    );

    localparam IDLE = 3'b000;
    localparam CALC = 3'b001;
    localparam FINALIZE = 3'b110;
    localparam SHIFT = 3'b010;
    localparam RESET = 3'b011;
    localparam WAIT_RST = 3'b101;
    localparam CLEAR = 3'b100;
    
    reg [2:0] state;
    
    wire [31:0] ip_counter;
    wire [31:0] ip_row_counter;
    
    wire [31:0] kernel_counter;
    reg [31:0] kernel_row_counter;
    
    wire [31:0] op_counter;
    reg [31:0] op_row_counter;
    reg [31:0] op_col_counter;

    reg kernel_rst;
    reg signed [63:0] temp_rout [4:0];
    wire signed [63:0] acc [4:0];

    integer j;

    assign ip_counter = (ip_row_counter * 32'd28);
    assign kernel_counter = (kernel_row_counter * 32'd5);
    assign op_counter = (op_row_counter * 32'd24) + op_col_counter;
    assign ip_row_counter = op_row_counter + kernel_row_counter;

    genvar i;

    generate
        for(i=0; i<5; i=i+1) begin
            mac mac_unit(clk, rst||kernel_rst, image[ip_counter+op_col_counter+i], weight[kernel_counter+i], acc[i], temp_rout[i]);
            assign acc[i] = temp_rout[i];
        end
    endgenerate

    wire signed [63:0] scaled;

    assign scaled = ((temp_rout[0] + temp_rout[1] + temp_rout[2] + temp_rout[3] + temp_rout[4])>>>6) + bias;


    always@(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            kernel_row_counter <= 32'd0;
            op_row_counter <= 32'd0;
            op_col_counter <= 32'd0;
            valid <= 1'b0;
            kernel_rst <= 1'b0;
        end
        else begin
            case(state)
                IDLE: begin
                    kernel_rst <= 1'b0;
                    valid <= 1'b0;
                    
                    kernel_row_counter <= 32'd0;
                    op_row_counter <= 32'd0;
                    op_col_counter <= 32'd0;
                    
                    if(inp_valid)
                        state <= CALC;
                end
                CALC: begin
                    kernel_rst <= 1'b0;
                    if(kernel_row_counter < 32'd4) begin
                        kernel_row_counter <= kernel_row_counter + 1'b1;
                    end
                    else begin
                        state <= FINALIZE;
                    end
                    
//debugging                    
//                    if(op_counter == 32'd0)
//                        $display("kernel=%0d img=%0d wt=%0d temp=%0d", kernel_counter, image[ip_counter], weight[kernel_counter], temp_rout);

                end
                FINALIZE: begin
                    state <= SHIFT;
                end
                SHIFT: begin
                    if(scaled > 64'sd127) rout[op_counter] <= 32'sd127;
                    else if(scaled < -64'sd128) rout[op_counter] <= -32'sd128;
                    else rout[op_counter] <= scaled[31:0];
                    state <= RESET;
                end
                RESET: begin
                    kernel_rst <= 1'b1;
                    state <= WAIT_RST;
                end
                WAIT_RST: begin
                    kernel_row_counter <= 32'd0;
                    
                    if(op_counter < 32'd575) begin
                        if(op_col_counter < 32'd23) begin
                            op_col_counter <= op_col_counter + 1'b1;
                        end
                        else begin
                            op_row_counter <= op_row_counter + 1'b1;
                            op_col_counter <= 32'd0;
                        end
                        state <= CALC;
                    end
                    else begin
                        state <= CLEAR;
                    end
                end
                CLEAR: begin
                    kernel_rst <= 1'b1;
                    valid <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
