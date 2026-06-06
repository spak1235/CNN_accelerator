`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 10:02:50 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] in1, in2,
    input [3:0] sel,
    
    output [31:0] rslt
    );
    
    reg [31:0] t_rslt;
    
    always@(*) begin
        case(sel)
        4'h0: t_rslt = in1 + in2;
        4'h1: t_rslt = in1 - in2;
        4'h2: t_rslt = in1 ^ in2;
        4'h3: t_rslt = in1 | in2;
        4'h4: t_rslt = in1 & in2;
        4'h5: t_rslt = in1 << in2[4:0];
        4'h6: t_rslt = in1 >> in2[4:0];
        4'h7: t_rslt = $signed(in1) >>> in2[4:0];
        4'h8: t_rslt = ($signed(in1) < $signed(in2)) ? 32'd1 : 32'd0;
        4'h9: t_rslt = (in1 < in2) ? 32'd1 : 32'd0;
        4'hA: t_rslt = in2;
        4'hB: t_rslt = 32'hXXXXXXXX;
        default: t_rslt = 32'd0;
        endcase
    end
    
    assign rslt = t_rslt;
endmodule
