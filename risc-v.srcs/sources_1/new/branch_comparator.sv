`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2026 10:44:44 AM
// Design Name: 
// Module Name: branch_comparator
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


module branch_comparator(
    input [31:0] data1, data2,
    input [2:0] funct3,
    
    output taken_branch
    );
    
    reg temp_taken_branch;
    
    always@(*) begin
        case(funct3)
            3'b000: temp_taken_branch = data1==data2;
            3'b001: temp_taken_branch = data1!=data2;
            3'b100: temp_taken_branch = $signed(data1)<$signed(data2);
            3'b101: temp_taken_branch = $signed(data1)>=$signed(data2);
            3'b110: temp_taken_branch = data1 < data2;
            3'b111: temp_taken_branch = data1 >= data2;
            default: temp_taken_branch = 1'b0;
        endcase
    end
    
    assign taken_branch = temp_taken_branch;
    
endmodule
