`timescale 1ns / 1ps

module top_module_tb;

    // =====================================================
    // CLOCK + RESET
    // =====================================================

    reg clk;
    reg rst;
    reg inp_valid;
    reg [2:0] digit;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // =====================================================
    // IMAGE
    // =====================================================

    reg signed [7:0] image [783:0];

    // =====================================================
    // OUTPUTS
    // =====================================================

    wire signed [31:0] rout [9:0];
    wire valid;

    // =====================================================
    // DUT
    // =====================================================

    top_module dut(
        .clk(clk),
        .rst(rst),
        .image(image),
        .inp_valid(inp_valid),
        .rout(rout),
        .valid(valid),
        .digit(digit)
    );

    // =====================================================
    // LOAD IMAGE
    // =====================================================

    integer i;
    integer row;
    integer col;

    reg [7:0] image_mem [783:0];

    initial begin

        // ---------------------------------------------
        // LOAD IMAGE MEM
        // ---------------------------------------------

        $readmemh("mnist_image.mem", image_mem);

        for(i=0; i<784; i=i+1) begin
            image[i] = image_mem[i];
        end

        // ---------------------------------------------
        // RESET
        // ---------------------------------------------

        rst = 1'b1;
        inp_valid = 1'b0;

        #20;

        rst = 1'b0;

        #20;

        inp_valid = 1'b1;

        #10;

        inp_valid = 1'b0;

    end

    // =====================================================
    // PRINT BLOCK 1 OUTPUTS
    // =====================================================

    always @(posedge dut.block1_valid_0) begin

        $display("=================================");
        $display("BLOCK 1 FILTER 0");
        $display("=================================");

        for(row=0; row<12; row=row+1) begin
            for(col=0; col<12; col=col+1) begin
                $write("%0d ", dut.block1_out_0[(row*12)+col]);
            end
            $write("\n");
        end

        $display("=================================");
        $display("BLOCK 1 FILTER 1");
        $display("=================================");

        for(row=0; row<12; row=row+1) begin
            for(col=0; col<12; col=col+1) begin
                $write("%0d ", dut.block1_out_1[(row*12)+col]);
            end
            $write("\n");
        end

        $display("=================================");
        $display("BLOCK 1 FILTER 2");
        $display("=================================");

        for(row=0; row<12; row=row+1) begin
            for(col=0; col<12; col=col+1) begin
                $write("%0d ", dut.block1_out_2[(row*12)+col]);
            end
            $write("\n");
        end

    end

    // =====================================================
    // PRINT BLOCK 2 OUTPUTS
    // =====================================================

    always @(posedge dut.block2_valid_0) begin

        $display("=================================");
        $display("BLOCK 2 FILTER 0");
        $display("=================================");

        for(row=0; row<4; row=row+1) begin
            for(col=0; col<4; col=col+1) begin
                $write("%0d ", dut.block2_out_0[(row*4)+col]);
            end
            $write("\n");
        end

        $display("=================================");
        $display("BLOCK 2 FILTER 1");
        $display("=================================");

        for(row=0; row<4; row=row+1) begin
            for(col=0; col<4; col=col+1) begin
                $write("%0d ", dut.block2_out_1[(row*4)+col]);
            end
            $write("\n");
        end

        $display("=================================");
        $display("BLOCK 2 FILTER 2");
        $display("=================================");

        for(row=0; row<4; row=row+1) begin
            for(col=0; col<4; col=col+1) begin
                $write("%0d ", dut.block2_out_2[(row*4)+col]);
            end
            $write("\n");
        end

    end

    // =====================================================
    // PRINT FINAL OUTPUT
    // =====================================================

    always @(posedge valid) begin

        $display("=================================");
        $display("FINAL FC OUTPUT");
        $display("=================================");

        for(i=0; i<10; i=i+1) begin
            $display("CLASS %0d = %0d", i, rout[i]);
        end

        $display("=================================");

    end

endmodule