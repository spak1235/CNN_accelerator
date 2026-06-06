`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2026 03:54:35 AM
// Design Name: 
// Module Name: topmodule
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


module topmodule(
    input clk, rst,
    
    output [31:0] rout
    );
    
    //information fetch initialisation
    wire [31:0] pc_add;
    wire [31:0] next_pc;
    wire [31:0] alu_output;
    wire [31:0] pc_out;
    wire pcsel;
    wire pc_add_cout;
    wire [31:0] instr;
    wire taken_branch;
    wire flush;
    wire pc_write;
    wire branch_pred;
    wire [31:0] pred_target;
    wire [31:0] btb_out;
    wire [31:0] f_pc;
    wire [31:0] pf_pc;
    wire btb_hit;
    wire icache_hit;

    wire [31:0] predicted_pc;
    wire [31:0] resolved_pc;
    
    //information decode intialisation
    wire [31:0] IfId_pc_out;
    wire [31:0] IfId_pc_add;
    wire [31:0] IfId_instr;
    wire IfId_pred_taken;
    wire [31:0] IfId_pred_target;
    wire IfId_write;
    
    wire [31:0] wb;
    wire [31:0] dataA;
    wire [31:0] dataB;
    wire regwen;
    wire [2:0] immsel;
    wire bsel;
    wire [31:0] imm_instr;
    wire [31:0] bsel_out;
    wire memread;
    //information excecute intialisation
    wire IdEx_write;
    wire [31:0] IdEx_dataA, IdEx_dataB;
    wire [31:0] IdEx_imm_instr;
    wire [31:0] IdEx_pc_out, IdEx_pc_add;
    wire [2:0] IdEx_funct3;
    wire IdEx_pred_taken;
    wire [4:0] IdEx_addrd, IdEx_addra, IdEx_addrb;
    wire IdEx_regwen;
    wire IdEx_asel, IdEx_bsel;
    wire [3:0] IdEx_alusel;
    wire IdEx_memrw;
    wire [1:0] IdEx_wbsel;
    wire IdEx_branch, IdEx_jump;
    wire IdEx_memread;
    wire [31:0] IdEx_pred_target;
    wire asel;
    wire [3:0] alusel;
    wire [2:0] funct3;
    wire [31:0] asel_out;
    wire [31:0] a_selin, b_selin;
    wire branch, jump;
    wire forwardA_ex, forwardA_ma;
    wire forwardB_ex, forwardB_ma;


    wire [1:0] forwardA, forwardB;
    //memory access initialisation
    wire ExMa_write;
    wire [31:0] ExMa_alu_output;
    wire [31:0] ExMa_datab;
    wire ExMa_memrw;
    wire [4:0] ExMa_addrd;
    wire ExMa_regwen;
    wire [31:0] ExMa_pc_add;
    wire [31:0] ExMa_pc_out;
    wire [1:0] ExMa_wbsel;
    wire ExMa_branch;
    wire ExMa_taken_branch;
    wire ExMa_pred_taken;
    wire [31:0] ExMa_pred_target;
    wire ExMa_memread;
    wire dcache_hit;

    wire [31:0] dataR;
    wire memrw;
    //write back initialisation
    wire MaWb_write;
    wire [4:0] MaWb_addrd;
    wire [31:0] MaWb_datar;
    wire [31:0] MaWb_alu_output;
    wire [31:0] MaWb_pc_add;
    wire [1:0] MaWb_wbsel;
    wire MaWb_regwen;
    
    wire cache_stall;
    
    wire [1:0] wbsel;
    
    wire stall;
    
    assign flush = ExMa_branch&&((ExMa_pred_taken != ExMa_taken_branch) || (ExMa_taken_branch && (ExMa_pred_target != ExMa_alu_output)));
    assign forwardA_ex = ExMa_regwen && (ExMa_addrd != 5'd0) && (IdEx_addra==ExMa_addrd) && !ExMa_memread;
    assign forwardB_ex = ExMa_regwen && (ExMa_addrd != 5'd0) && (IdEx_addrb==ExMa_addrd) && !ExMa_memread;
    assign forwardA_ma = MaWb_regwen && (MaWb_addrd != 5'd0) && (IdEx_addra==MaWb_addrd);
    assign forwardB_ma = MaWb_regwen && (MaWb_addrd != 5'd0) && (IdEx_addrb==MaWb_addrd);
    assign forwardA = (forwardA_ex) ? 2'b01 : (forwardA_ma) ? 2'b10 : 2'b00;
    assign forwardB = (forwardB_ex) ? 2'b01 : (forwardB_ma) ? 2'b10 : 2'b00;

    assign cache_stall = !icache_hit || ((!dcache_hit)&&((ExMa_wbsel==2'b01)||(ExMa_memrw==1'b1)));     
    assign stall = (IdEx_memread && ((IdEx_addrd == IfId_instr[19:15]) || (IdEx_addrd == IfId_instr[24:20])) && (IdEx_addrd != 5'd0)); 
    assign pc_write = (!stall)&&(!cache_stall);
    assign IfId_write = (!stall)&&(!cache_stall);
    assign IdEx_write = (!cache_stall);
    assign ExMa_write = (!cache_stall);
    assign MaWb_write = (!cache_stall);
    
    //information fetch

    mux2 pred_pc(pc_add, btb_out, btb_hit && branch_pred, next_pc);

    mux2 correct_pc(IdEx_pc_add, alu_output, pcsel, pf_pc);

    mux2 final_pc(next_pc, pf_pc, flush, f_pc);

    pc program_counter(clk, rst, pc_write, f_pc, pc_out);
    
    adder pc_4(pc_out, 32'd4, 1'b0, pc_add, pc_add_cout);
    
    imem_cache instruction_memory(clk, rst, pc_out, instr, icache_hit);

    bpb branch_predictor(clk, rst, taken_branch, IdEx_pc_out, IdEx_branch, pc_out, branch_pred);
    
    btb branch_target_buffer(clk, rst, ExMa_alu_output, ExMa_pc_out, pc_out, ExMa_branch, btb_out, btb_hit);
    
    assign pred_target = ExMa_alu_output;

    IfId IfId_reg(clk, rst||flush, pc_out, pc_add, instr, btb_hit&&branch_pred, pred_target, IfId_write, IfId_pc_out, IfId_pc_add, IfId_instr, IfId_pred_taken, IfId_pred_target);
    
    //information decode
    
    regfile registers(clk, IfId_instr[19:15], IfId_instr[24:20], MaWb_addrd, wb, MaWb_regwen, dataA, dataB);
    
    immgen immediate_generator(IfId_instr, immsel, imm_instr);
    
    assign funct3 = IfId_instr[14:12];
    assign branch = (IfId_instr[6:0] == 7'b1100011);
    assign jump = (IfId_instr[6:0] == 7'b1101111 || IfId_instr[6:0] == 7'b1100111);
    
    IdEx IdEx_reg(clk, rst||stall||flush, dataA, dataB, imm_instr, IfId_pc_out, IfId_pc_add, funct3, IfId_instr[11:7], IfId_instr[19:15], IfId_instr[24:20], regwen, asel, bsel, alusel, memrw, wbsel, branch, jump, memread, IfId_pred_taken, IfId_pred_target, IdEx_write,
    IdEx_dataA, IdEx_dataB, IdEx_imm_instr, IdEx_pc_out, IdEx_pc_add, IdEx_funct3, IdEx_addrd, IdEx_addra, IdEx_addrb, IdEx_regwen, IdEx_asel, IdEx_bsel, IdEx_alusel, IdEx_memrw, IdEx_wbsel, IdEx_branch, IdEx_jump, IdEx_memread, IdEx_pred_taken, IdEx_pred_target);
    
    //information excecute
    
    branch_comparator branch_comp(a_selin, b_selin, IdEx_funct3, taken_branch);
    mux3 a_forwad(IdEx_dataA, ExMa_alu_output, wb, forwardA, a_selin);
    mux2 a_select(a_selin, IdEx_pc_out, IdEx_asel, asel_out);
    
    mux3 b_forwad(IdEx_dataB, ExMa_alu_output, wb, forwardB, b_selin);
    mux2 b_select(b_selin, IdEx_imm_instr, IdEx_bsel, bsel_out);
    alu ALU(asel_out, bsel_out, IdEx_alusel, alu_output);
    
    assign pcsel = IdEx_jump || (IdEx_branch && taken_branch);
    
    ExMa ExMa_reg(clk, rst, alu_output, b_selin, IdEx_memrw, IdEx_addrd, IdEx_regwen, IdEx_pc_add, IdEx_pc_out, IdEx_wbsel, taken_branch, IdEx_branch, IdEx_memread, IdEx_pred_taken, IdEx_pred_target, ExMa_write,
    ExMa_alu_output, ExMa_datab, ExMa_memrw, ExMa_addrd, ExMa_regwen, ExMa_pc_add, ExMa_pc_out, ExMa_wbsel, ExMa_taken_branch, ExMa_branch, ExMa_memread, ExMa_pred_taken, ExMa_pred_target);
    
    //memory access
    
    dmem_cache data_memory(clk, rst, ExMa_alu_output, ExMa_datab, ExMa_memrw, dataR, dcache_hit);
    
    MaWb MaWb_reg(clk, rst, ExMa_addrd, dataR, ExMa_alu_output, ExMa_pc_add, ExMa_wbsel, ExMa_regwen, MaWb_write,
    MaWb_addrd, MaWb_datar, MaWb_alu_output, MaWb_pc_add, MaWb_wbsel, MaWb_regwen);
    
    //writeback
    
    mux3 writeback(MaWb_alu_output, MaWb_datar, MaWb_pc_add, MaWb_wbsel, wb);
    
    //control_unit
    control_unit control_unit(IfId_instr, immsel, regwen, bsel, asel, alusel, memrw, wbsel, memread);
    
    assign rout = wb;
    
endmodule
