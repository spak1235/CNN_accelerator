`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 04:41:26 PM
// Design Name: 
// Module Name: relu
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


module relu(
    input clk, rst,
    input signed [31:0] image [143:0],
    input inp_valid,

    output reg signed [31:0] rout [143:0],
    output reg valid
    );

    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam CLEAR = 2'b10;
    
    reg [1:0] state;
    reg [31:0] counter;
    
    always@(posedge clk) begin
        if(rst) begin
            valid <= 1'b0;
            state <= IDLE;
            counter <= 32'd0;
        end
        else begin
            case(state)
                IDLE: begin
                    counter <= 32'd0;
                    valid <= 1'b0;
                    if(inp_valid)
                        state <= CALC;
                end
                CALC: begin
                    if(counter < 32'd144) begin
                        counter <= counter + 1'b1;
                        if(image[counter] >= 0)
                            rout[counter] <= image[counter];
                        else 
                            rout[counter] <= 32'sd0;
                    end
                    else 
                        state <= CLEAR;
                end
                CLEAR: begin
                    valid <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
