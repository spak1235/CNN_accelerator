`timescale 1ns/1ps

module topmodule_tb;

reg clk;
reg rst;

wire [31:0] rout;

topmodule dut(
    .clk(clk),
    .rst(rst),
    .rout(rout)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    // Wait until program finishes and enters loop
    #400;

    $display("\n====================================");
    $display("FINAL REGISTER VALUES");
    $display("====================================");
    $display("x1 = %0d", dut.registers.regs[1]);
    $display("x2 = %0d", dut.registers.regs[2]);
    $display("x3 = %0d", dut.registers.regs[3]);
    $display("x4 = %0d", dut.registers.regs[4]);
    $display("x5 = %0d", dut.registers.regs[5]);
    $display("x6 = %0d", dut.registers.regs[6]);

    $display("\n====================================");
    $display("CACHE STATE");
    $display("====================================");
    $display("Valid[0] = %b",
        dut.data_memory.data_cache.valid[0]);
    $display("Dirty[0] = %b",
        dut.data_memory.data_cache.dirty[0]);
    $display("Tag[0]   = %h",
        dut.data_memory.data_cache.cache_tag[0]);
    $display("Data[0]  = %h",
        dut.data_memory.data_cache.dmem_cache[0]);

    $display("\n====================================");
    $display("MAIN MEMORY");
    $display("====================================");
    $display("MEM[0]   = %h",
        dut.data_memory.data_mem.dmem[0]);

    $display("MEM[16]  = %h",
        dut.data_memory.data_mem.dmem[16]);

    $display("\n====================================");
    $display("WRITEBACK INFO");
    $display("====================================");
    $display("rep_addr  = %h",
        dut.data_memory.data_cache.rep_addr);

    $display("rep_data  = %h",
        dut.data_memory.data_cache.rep_data);

    $display("rep_valid = %b",
        dut.data_memory.data_cache.rep_valid);

    $display("\nTEST COMPLETE\n");

    $finish;
end

initial begin
    $display("=======================================================================");
    $display("TIME\tPC\t\tIC_HIT\tDC_HIT\tX1\tX2\tX3\tX4\tX5\tX6");
    $display("=======================================================================");
end

always @(posedge clk) begin
    if(!rst) begin

        $display("%0t\t%h\t%b\t%b\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d",
            $time,
            dut.pc_out,
            dut.icache_hit,
            dut.dcache_hit,
            dut.registers.regs[1],
            dut.registers.regs[2],
            dut.registers.regs[3],
            dut.registers.regs[4],
            dut.registers.regs[5],
            dut.registers.regs[6]
        );

    end
end

endmodule
