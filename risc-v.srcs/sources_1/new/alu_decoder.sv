`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 09:33:42 PM
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output [3:0] alusel
);

    reg [3:0] temp_alusel;

    always @(*) begin
        case (opcode)

            7'b0110011: begin
                case (funct3)
                    3'b000: temp_alusel = (funct7 == 7'b0100000) ? 4'h1 : 4'h0;
                    3'b001: temp_alusel = 4'h5;
                    3'b010: temp_alusel = 4'h8;
                    3'b011: temp_alusel = 4'h9;
                    3'b100: temp_alusel = 4'h2;
                    3'b101: temp_alusel = (funct7 == 7'b0100000) ? 4'h7 : 4'h6;
                    3'b110: temp_alusel = 4'h3;
                    3'b111: temp_alusel = 4'h4;
                    default: temp_alusel = 4'hX;
                endcase
            end

            7'b0010011: begin
                case (funct3)
                    3'b000: temp_alusel = 4'h0;
                    3'b001: temp_alusel = 4'h5;
                    3'b010: temp_alusel = 4'h8;
                    3'b011: temp_alusel = 4'h9;
                    3'b100: temp_alusel = 4'h2;
                    3'b101: temp_alusel = (funct7 == 7'b0100000) ? 4'h7 : 4'h6;
                    3'b110: temp_alusel = 4'h3;
                    3'b111: temp_alusel = 4'h4;
                    default: temp_alusel = 4'hX;
                endcase
            end

            7'b0000011: begin
                case (funct3)
                    3'b000,
                    3'b001,
                    3'b010,
                    3'b100,
                    3'b101: temp_alusel = 4'h0;
                    default: temp_alusel = 4'hX;
                endcase
            end

            7'b0100011: begin 
                case (funct3)
                    3'b000,
                    3'b001,
                    3'b010: temp_alusel = 4'h0;
                    default: temp_alusel = 4'hX;
                endcase
            end

            7'b1100011: temp_alusel = 4'h0;
            7'b1101111: temp_alusel = 4'h0;
            7'b1100111: temp_alusel = 4'h0;
            7'b0110111: temp_alusel = 4'hA;
            7'b0010111: temp_alusel = 4'h0;

            default: temp_alusel = 4'hX;
        endcase
    end

    assign alusel = temp_alusel;

endmodule
