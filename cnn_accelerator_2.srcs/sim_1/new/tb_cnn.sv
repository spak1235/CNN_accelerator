`timescale 1ns / 1ps

module tb_cnn;

    reg clk;
    reg rst;

    // =====================================================
    // IMAGE
    // =====================================================

    reg [7:0] image_mem [0:783];
    reg signed [31:0] image [0:783];

    // =====================================================
    // BLOCK 1 WEIGHTS
    // =====================================================

    reg signed [7:0] weight0_mem [0:24];
    reg signed [7:0] weight1_mem [0:24];
    reg signed [7:0] weight2_mem [0:24];

    reg signed [31:0] weight_0_0 [0:24];
    reg signed [31:0] weight_0_1 [0:24];
    reg signed [31:0] weight_0_2 [0:24];

    // =====================================================
    // BLOCK 2 WEIGHTS
    // =====================================================

    reg signed [7:0] weight2_0_0_mem [0:24];
    reg signed [7:0] weight2_0_1_mem [0:24];
    reg signed [7:0] weight2_0_2_mem [0:24];

    reg signed [7:0] weight2_1_0_mem [0:24];
    reg signed [7:0] weight2_1_1_mem [0:24];
    reg signed [7:0] weight2_1_2_mem [0:24];

    reg signed [7:0] weight2_2_0_mem [0:24];
    reg signed [7:0] weight2_2_1_mem [0:24];
    reg signed [7:0] weight2_2_2_mem [0:24];

    reg signed [31:0] weight2_0_0 [0:24];
    reg signed [31:0] weight2_0_1 [0:24];
    reg signed [31:0] weight2_0_2 [0:24];

    reg signed [31:0] weight2_1_0 [0:24];
    reg signed [31:0] weight2_1_1 [0:24];
    reg signed [31:0] weight2_1_2 [0:24];

    reg signed [31:0] weight2_2_0 [0:24];
    reg signed [31:0] weight2_2_1 [0:24];
    reg signed [31:0] weight2_2_2 [0:24];

    // =====================================================
    // BIASES
    // =====================================================

    reg signed [7:0] bias1_mem [0:2];
    reg signed [7:0] bias2_mem [0:2];

    reg signed [31:0] bias1 [0:2];
    reg signed [31:0] bias2 [0:2];

    // =====================================================
    // BLOCK 1 OUTPUTS
    // =====================================================

    wire signed [31:0] block1_out_0 [0:143];
    wire signed [31:0] block1_out_1 [0:143];
    wire signed [31:0] block1_out_2 [0:143];

    wire valid1_0;
    wire valid1_1;
    wire valid1_2;

    // =====================================================
    // BLOCK 2 OUTPUTS
    // =====================================================

    wire signed [31:0] block2_out_0 [0:15];
    wire signed [31:0] block2_out_1 [0:15];
    wire signed [31:0] block2_out_2 [0:15];

    wire valid2_0;
    wire valid2_1;
    wire valid2_2;

    // =====================================================
    // CLOCK
    // =====================================================

    always #5 clk = ~clk;

    // =====================================================
    // DUT 1
    // =====================================================

    block_1 dut1(
        clk,
        rst,
        image,
        bias1,
        1'b1,

        weight_0_0,
        weight_0_1,
        weight_0_2,

        block1_out_0,
        valid1_0,

        block1_out_1,
        valid1_1,

        block1_out_2,
        valid1_2
    );

    // =====================================================
    // DUT 2
    // =====================================================

    block_2 dut2(
        clk,
        rst,

        block1_out_0,
        block1_out_1,
        block1_out_2,

        bias2,

        valid1_0,
        valid1_1,
        valid1_2,

        weight2_0_0,
        weight2_0_1,
        weight2_0_2,

        weight2_1_0,
        weight2_1_1,
        weight2_1_2,

        weight2_2_0,
        weight2_2_1,
        weight2_2_2,

        block2_out_0,
        valid2_0,

        block2_out_1,
        valid2_1,

        block2_out_2,
        valid2_2
    );

    integer i;

    initial begin

        clk = 0;
        rst = 1;

        // =====================================================
        // LOAD MEM FILES
        // =====================================================

        $readmemh("mnist_image.mem", image_mem);

        $readmemh("weight_1_0.mem", weight0_mem);
        $readmemh("weight_1_1.mem", weight1_mem);
        $readmemh("weight_1_2.mem", weight2_mem);

        $readmemh("weight_2_0_0.mem", weight2_0_0_mem);
        $readmemh("weight_2_0_1.mem", weight2_0_1_mem);
        $readmemh("weight_2_0_2.mem", weight2_0_2_mem);

        $readmemh("weight_2_1_0.mem", weight2_1_0_mem);
        $readmemh("weight_2_1_1.mem", weight2_1_1_mem);
        $readmemh("weight_2_1_2.mem", weight2_1_2_mem);

        $readmemh("weight_2_2_0.mem", weight2_2_0_mem);
        $readmemh("weight_2_2_1.mem", weight2_2_1_mem);
        $readmemh("weight_2_2_2.mem", weight2_2_2_mem);

        $readmemh("bias_1.mem", bias1_mem);
        $readmemh("bias_2.mem", bias2_mem);

        // =====================================================
        // EXTEND DATA
        // =====================================================

        for(i=0; i<784; i=i+1)
            image[i] = {24'd0, image_mem[i]};

        for(i=0; i<25; i=i+1) begin

            weight_0_0[i] = {{24{weight0_mem[i][7]}}, weight0_mem[i]};
            weight_0_1[i] = {{24{weight1_mem[i][7]}}, weight1_mem[i]};
            weight_0_2[i] = {{24{weight2_mem[i][7]}}, weight2_mem[i]};

            weight2_0_0[i] = {{24{weight2_0_0_mem[i][7]}}, weight2_0_0_mem[i]};
            weight2_0_1[i] = {{24{weight2_0_1_mem[i][7]}}, weight2_0_1_mem[i]};
            weight2_0_2[i] = {{24{weight2_0_2_mem[i][7]}}, weight2_0_2_mem[i]};

            weight2_1_0[i] = {{24{weight2_1_0_mem[i][7]}}, weight2_1_0_mem[i]};
            weight2_1_1[i] = {{24{weight2_1_1_mem[i][7]}}, weight2_1_1_mem[i]};
            weight2_1_2[i] = {{24{weight2_1_2_mem[i][7]}}, weight2_1_2_mem[i]};

            weight2_2_0[i] = {{24{weight2_2_0_mem[i][7]}}, weight2_2_0_mem[i]};
            weight2_2_1[i] = {{24{weight2_2_1_mem[i][7]}}, weight2_2_1_mem[i]};
            weight2_2_2[i] = {{24{weight2_2_2_mem[i][7]}}, weight2_2_2_mem[i]};

        end

        for(i=0; i<3; i=i+1) begin
            bias1[i] = {{24{bias1_mem[i][7]}}, bias1_mem[i]};
            bias2[i] = {{24{bias2_mem[i][7]}}, bias2_mem[i]};
        end

        #20;
        rst = 0;

        // =====================================================
        // WAIT FOR BLOCK 2
        // =====================================================

        wait(valid2_0 && valid2_1 && valid2_2);

        // =====================================================
        // PRINT BLOCK 1 OUTPUTS
        // =====================================================

        $display("=================================");
        $display("BLOCK 1 FILTER 0");
        $display("=================================");

        for(i=0; i<144; i=i+1) begin
            $write("%0d ", block1_out_0[i]);
            if((i+1)%12 == 0) $write("\n");
        end

        $display("=================================");
        $display("BLOCK 1 FILTER 1");
        $display("=================================");

        for(i=0; i<144; i=i+1) begin
            $write("%0d ", block1_out_1[i]);
            if((i+1)%12 == 0) $write("\n");
        end

        $display("=================================");
        $display("BLOCK 1 FILTER 2");
        $display("=================================");

        for(i=0; i<144; i=i+1) begin
            $write("%0d ", block1_out_2[i]);
            if((i+1)%12 == 0) $write("\n");
        end

        // =====================================================
        // PRINT BLOCK 2 OUTPUTS
        // =====================================================

        $display("=================================");
        $display("BLOCK 2 FILTER 0");
        $display("=================================");

        for(i=0; i<16; i=i+1) begin
            $write("%0d ", block2_out_0[i]);
            if((i+1)%4 == 0) $write("\n");
        end

        $display("=================================");
        $display("BLOCK 2 FILTER 1");
        $display("=================================");

        for(i=0; i<16; i=i+1) begin
            $write("%0d ", block2_out_1[i]);
            if((i+1)%4 == 0) $write("\n");
        end

        $display("=================================");
        $display("BLOCK 2 FILTER 2");
        $display("=================================");

        for(i=0; i<16; i=i+1) begin
            $write("%0d ", block2_out_2[i]);
            if((i+1)%4 == 0) $write("\n");
        end

        #100;
        $finish;

    end

endmodule