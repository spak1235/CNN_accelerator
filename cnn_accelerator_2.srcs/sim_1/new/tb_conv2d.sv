`timescale 1ns / 1ps

module tb_conv2d;

    reg clk;
    reg rst;
    reg inp_valid;

    reg [7:0] image_mem [0:783];

    reg signed [31:0] image [0:783];

    reg signed [7:0] weight_mem [0:24];

    reg signed [31:0] weight [0:24];

    reg signed [7:0] bias_mem [0:2];

    reg signed [31:0] bias;

    wire signed [31:0] rout [0:575];

    wire valid;

    integer i;

    // =========================================
    // DUT
    // =========================================

    conv2d dut(
        .clk(clk),
        .rst(rst),
        .image(image),
        .bias(bias),
        .inp_valid(inp_valid),
        .weight(weight),
        .rout(rout),
        .valid(valid)
    );

    // =========================================
    // CLOCK
    // =========================================

    always #5 clk = ~clk;

    // =========================================
    // INITIAL
    // =========================================

    initial begin

        clk = 0;
        rst = 1;
        inp_valid = 0;

        // =====================================
        // LOAD MEM FILES
        // =====================================

        $readmemh("mnist_image.mem", image_mem);

        $readmemh("weight_1_1.mem", weight_mem);

        $readmemh("bias_1.mem", bias_mem);

        // =====================================
        // IMAGE ZERO EXTENSION
        // =====================================

        for(i = 0; i < 784; i = i + 1) begin

            image[i] = {24'd0, image_mem[i]};

        end

        // =====================================
        // WEIGHT SIGN EXTENSION
        // =====================================

        for(i = 0; i < 25; i = i + 1) begin

            weight[i] = {{24{weight_mem[i][7]}}, weight_mem[i]};

        end

        // =====================================
        // BIAS[0] SIGN EXTENSION
        // =====================================

        bias = {{24{bias_mem[0][7]}}, bias_mem[1]};

        // =====================================
        // RESET
        // =====================================

        #20;

        rst = 0;

        // =====================================
        // START
        // =====================================

        #10;

        inp_valid = 1;

        #10;

        inp_valid = 0;

        // =====================================
        // WAIT
        // =====================================

        wait(valid);

        $display("=================================");
        $display("CONV OUTPUTS (24x24)");
        $display("=================================");

        for(i = 0; i < 576; i = i + 1) begin

            $write("%0d ", rout[i]);

            if((i + 1) % 24 == 0)
                $write("\n");

        end

        $display("=================================");

        #100;

        $finish;

    end

endmodule