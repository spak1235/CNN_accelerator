`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 06:47:13 PM
// Design Name: 
// Module Name: conv_chunk_base
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


module conv_chunk_base(
    input clk, rst,
    input signed [31:0] image [143:0],
    input inp_valid,

    input signed [31:0] weight [24:0],

    output reg signed [63:0] rout [63:0],
    output reg valid
    );

    localparam IDLE = 3'b000;
    localparam CALC = 3'b001;
    localparam SHIFT = 3'b010;
    localparam RESET = 3'b011;
    localparam CLEAR = 3'b100;
    
    reg [2:0] state;
    
    wire [31:0] ip_counter;
    wire [31:0] ip_row_counter;
    wire [31:0] ip_col_counter;
    
    wire [31:0] kernel_counter;
    reg [31:0] kernel_row_counter;
    reg [31:0] kernel_col_counter;
    
    wire [31:0] op_counter;
    reg [31:0] op_row_counter;
    reg [31:0] op_col_counter;

    reg kernel_rst;
    reg signed [63:0] temp_rout;

    assign ip_counter = (ip_row_counter * 32'd12) + ip_col_counter;
    assign kernel_counter = (kernel_row_counter * 32'd5) + kernel_col_counter;
    assign op_counter = (op_row_counter * 32'd8) + op_col_counter;
    assign ip_row_counter = op_row_counter + kernel_row_counter;
    assign ip_col_counter = op_col_counter + kernel_col_counter;

    mac mac_unit(clk, rst||kernel_rst, image[ip_counter], weight[kernel_counter], temp_rout, temp_rout);

    always@(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            kernel_row_counter <= 32'd0;
            kernel_col_counter <= 32'd0;
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
                    kernel_col_counter <= 32'd0;
                    op_row_counter <= 32'd0;
                    op_col_counter <= 32'd0;
                    
                    if(inp_valid)
                        state <= CALC;
                end
                CALC: begin
                    kernel_rst <= 1'b0;
                    if(kernel_counter < 32'd24) begin
                        if(kernel_col_counter < 32'd4) begin
                            kernel_col_counter <= kernel_col_counter + 1'b1;
                        end
                        else begin
                            kernel_col_counter <= 32'd0;
                            kernel_row_counter <= kernel_row_counter + 1'b1;
                        end
                    end
                    else begin
                        state <= SHIFT;
                    end
                    
//debugging                    
//                    if(op_counter == 32'd0)
//                        $display("kernel=%0d img=%0d wt=%0d temp=%0d", kernel_counter, image[ip_counter], weight[kernel_counter], temp_rout);

                end
                SHIFT: begin

                    rout[op_counter] <= temp_rout;
                    
                    $display("op=%0d temp=%0d final=%0d",
                      op_counter,
                      temp_rout,
                      temp_rout);
                    
                    state <= RESET;
                end
                
                RESET: begin
                    kernel_rst <= 1'b1;
                    kernel_row_counter <= 32'd0;
                    kernel_col_counter <= 32'd0;
                    
                    if(op_counter < 32'd63) begin
                        if(op_col_counter < 32'd7) begin
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
