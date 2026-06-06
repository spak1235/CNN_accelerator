`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2026 08:01:52 PM
// Design Name: 
// Module Name: data_cache
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


module data_cache(
    input clk, rst,
    input [31:0] addr,
    input [31:0] dataw,
    input [31:0] data_mem,
    input memrw,

    output [31:0] datar,
    output hit,
    output reg [31:0] rep_addr,
    output reg [31:0] rep_data,
    output reg rep_valid
    );

    reg [31:0] dmem_cache [15:0];
    reg [25:0] cache_tag [15:0];
    reg [0:0] valid [15:0];
    reg [0:0] dirty [15:0];

    assign hit =  valid[addr[5:2]] && (cache_tag[addr[5:2]] == (addr>>6));

    assign datar = (hit) ? dmem_cache[addr[5:2]] : 32'hXXXXXXXX;

    integer i;

    always@(posedge clk) begin
        if(rst) begin
            for(i=0; i<16; i=i+1) begin
                valid[i] <= 1'b0;
                cache_tag[i] <= 32'd0;
                dirty[i] <= 1'b0;
            end
            rep_valid <= 1'b0;
            rep_addr <= 32'd0;
            rep_data <= 32'd0;
        end
        else begin
            rep_valid <= dirty[addr[5:2]];
            if(!hit) begin
                dmem_cache[addr[5:2]] <= data_mem;
                valid[addr[5:2]] <= 1'b1;
                cache_tag[addr[5:2]] <= addr>>6;
                dirty[addr[5:2]] <= 1'b0;
                if(valid[addr[5:2]]&&dirty[addr[5:2]]) begin
                    rep_addr <= {cache_tag[addr[5:2]], addr[5:2], 2'b00};
                    rep_data <= dmem_cache[addr[5:2]];
                end
            end
            else begin
                if(memrw) begin
                    dmem_cache[addr[5:2]] <= dataw;
                    dirty[addr[5:2]] <= 1'b1;
                end
            end
        end
    end
endmodule
