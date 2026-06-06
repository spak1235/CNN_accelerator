`timescale 1ns / 1ps

module dmem_cache_tb;

    reg clk;
    reg rst;

    reg [31:0] addr;
    reg [31:0] dataw;
    reg memrw;

    wire [31:0] datar;
    wire hit;

    dmem_cache dut(
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .dataw(dataw),
        .memrw(memrw),
        .datar(datar),
        .hit(hit)
    );

    //-----------------------------------
    // Clock
    //-----------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //-----------------------------------
    // Monitor
    //-----------------------------------

    initial begin

        $display("TIME\tADDR\tHIT\tDATAR");

        forever begin
            @(posedge clk);

            $display("%0t\t%h\t%b\t%h",
                     $time,
                     addr,
                     hit,
                     datar);
        end

    end

    //-----------------------------------
    // Test
    //-----------------------------------

    initial begin

        rst   = 1;
        addr  = 0;
        dataw = 0;
        memrw = 0;

        #20;
        rst = 0;

        //-----------------------------------
        // Read address 0
        //-----------------------------------

        addr = 32'h00000000;

        #20;

        //-----------------------------------
        // Read again
        // should now hit
        //-----------------------------------

        #20;

        //-----------------------------------
        // Store to same address
        //-----------------------------------

        memrw = 1;
        dataw = 32'hDEADBEEF;

        #20;

        memrw = 0;

        //-----------------------------------
        // Read back
        //-----------------------------------

        #20;

        //-----------------------------------
        // Force conflict miss
        //-----------------------------------

        addr = 32'h00000040;

        #20;

        //-----------------------------------
        // Read again
        //-----------------------------------

        #20;

        //-----------------------------------
        // Return to old address
        //-----------------------------------

        addr = 32'h00000000;

        #20;

        $display("\n===== INTERNAL STATE =====");

        $display("Valid[0] = %b",
                 dut.data_cache.valid[0]);

        $display("Dirty[0] = %b",
                 dut.data_cache.dirty[0]);

        $display("Tag[0] = %h",
                 dut.data_cache.cache_tag[0]);

        $display("Cache[0] = %h",
                 dut.data_cache.dmem_cache[0]);

        $display("Rep Addr = %h",
                 dut.data_cache.rep_addr);

        $display("Rep Data = %h",
                 dut.data_cache.rep_data);
        $display("mem_data=%h", dut.mem_data);

        $finish;

    end

endmodule