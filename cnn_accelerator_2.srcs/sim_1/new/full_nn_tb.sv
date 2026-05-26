`timescale 1ns / 1ps

module full_nn_tb;

    // =====================================================
    // CLOCK + RESET
    // =====================================================

    reg clk;
    reg rst;
    reg inp_valid;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // =====================================================
    // INPUT FEATURES
    // =====================================================

    reg signed [31:0] image [47:0];

    // =====================================================
    // OUTPUTS
    // =====================================================

    wire signed [7:0] rout [9:0];
    wire valid;

    // =====================================================
    // DUT
    // =====================================================

    full_nn dut(
        .clk(clk),
        .rst(rst),
        .image(image),
        .inp_valid(inp_valid),
        .rout(rout),
        .valid(valid)
    );

    integer i;

    // =====================================================
    // TEST
    // =====================================================

    initial begin

        // ---------------------------------------------
        // RESET
        // ---------------------------------------------

        rst = 1'b1;
        inp_valid = 1'b0;

        #20;

        rst = 1'b0;

        // ---------------------------------------------
        // DEFINE INPUT FEATURES
        // ---------------------------------------------

        // Simple increasing pattern

        for(i=0; i<48; i=i+1) begin
            image[i] = i + 1;
        end

        // ---------------------------------------------
        // START
        // ---------------------------------------------

        #20;

        inp_valid = 1'b1;

        #10;

        inp_valid = 1'b0;

    end

    // =====================================================
    // DEBUG ACCUMULATION
    // =====================================================

    always @(posedge clk) begin

        if(dut.state == 2'b01) begin

            $display("=================================");
            $display("COUNTER = %0d", dut.counter);
            $display("=================================");

            for(i=0; i<10; i=i+1) begin

                $display(
                    "CLASS=%0d INPUT=%0d WEIGHT=%0d ACC=%0d",
                    i,
                    dut.image[dut.counter],
                    dut.weight[(i*48)+dut.counter],
                    dut.temp_rout[i]
                );

            end

        end

    end

    // =====================================================
    // FINAL OUTPUT
    // =====================================================

    always @(posedge valid) begin

        $display("=================================");
        $display("FINAL OUTPUT");
        $display("=================================");

        for(i=0; i<10; i=i+1) begin
            $display("CLASS %0d = %0d", i, rout[i]);
        end

        $display("=================================");

        #20;
        $finish;

    end

endmodule