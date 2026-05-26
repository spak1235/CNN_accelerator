`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2026 07:57:20 PM
// Design Name: 
// Module Name: full_nn
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


module full_nn(
    input clk, rst,
    input signed [31:0] image [47:0],
    input inp_valid,
    
    output reg signed [31:0] rout [9:0],
    output reg valid
    );

    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam CLEAR = 2'b10;
    
    reg [1:0] state;
    
    reg signed [7:0] bias_mem [9:0];
    reg signed [31:0] bias [9:0];
    
    genvar i;
    
    reg signed [7:0] weight_mem [479:0];
    reg signed [31:0] weight [479:0];
    reg [31:0] counter;
    reg mac_rst;
    reg signed [63:0] temp_rout [9:0];

    integer k;
    
    initial begin
        $readmemh("full_nn_weight.mem", weight_mem);
        $readmemh("bias_3.mem", bias_mem);

        for(k=0; k<480; k=k+1) weight[k] = {{24{weight_mem[k][7]}}, weight_mem[k]};

        for(k=0; k<10; k=k+1) bias[k] = {{24{bias_mem[k][7]}}, bias_mem[k]};

    end
    
    generate
        for(i = 0; i < 10; i = i+1'b1) begin: mac_block
            mac mac_unit(
                clk,
                rst||mac_rst,
                image[counter],
                weight[(i*32'd48)+counter],
                temp_rout[i],
                temp_rout[i]
            );
        end
    endgenerate
    
    integer j;
    
    always@(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            counter <= 32'd0;
            valid <= 1'b0;
            mac_rst <= 1'b1;
        end
        else begin
            case(state)
                IDLE: begin
                    counter <= 32'd0;
                    mac_rst <= 1'b1;
                    valid <= 1'b0;
                    if(inp_valid) begin
                        mac_rst <= 1'b0;
                        state <= CALC;
                    end
                end
                CALC: begin
                    if(counter < 47) 
                        counter <= counter + 1'b1;
                    else 
                        state <= CLEAR;
                end
                CLEAR: begin
                    for(j = 0; j < 10; j = j + 1) begin
                        rout[j] <= temp_rout[j]+bias[j];
                        //if((temp_rout[j]>>>12) + bias[j] > 64'sd127) rout[j] <= 32'sd127;
                        //else if((temp_rout[j]>>>12) + bias[j] < -64'sd128) rout[j] <= -32'sd128;
                        //else rout[j] <= (temp_rout[j]>>>12) + bias[j];
                    end
                    valid <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
