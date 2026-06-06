`timescale 1s / 1ps

module mux2(
    input [31:0] data1,
    input [31:0] data2,
    input control,
    
    output [31:0] op
    );
    
    assign op = (control == 0) ? data1 : data2;
    
endmodule 