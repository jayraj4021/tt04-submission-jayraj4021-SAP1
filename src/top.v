`include "./program_counter.v"
`include "./control_unit.v"
`include "./mar.v"
`include "./memory_16x8_rom.v"
`include "./instruction_register.v"
`include "./accumulator.v"
`include "./b_register.v"
`include "./alu.v"
`include "./output_register.v"

module tt_um_jayraj4021_SAP1_cpu(clk, rst);

    input clk;
    input rst;

    wire Epc, RstPc, Emar, LmPC, LmIRa, readEnableROM, Eir, Eacc, LaccM, LaccA, Eb, subtract, Eo;
    wire [3:0] pcAddressWire;
    wire [3:0] marAddressWire;
    wire [7:0] memoryDataWire;
    wire [7:0] irOutputWire;
    wire [7:0] accOutputWire;
    wire [7:0] bOutputWire;
    wire [7:0] aluOutputWire;
    wire [7:0] orOutputWire;

    control_unit cu(.clk(clk), .rst(rst), .inputInstruction(irOutputWire), .Epc(Epc), .RstPc(RstPc), .Emar(Emar), .LmPC(LmPC), .LmIRa(LmIRa), .readEnableROM(readEnableROM), .Eir(Eir), .Eacc(Eacc), .LaccM(LaccM), .LaccA(LaccA), .Eb(Eb), .subtract(subtract), .Eo(Eo));
    program_counter pc(.clk(clk),.rst(RstPc),.Epc(Epc),.pc_address(pcAddressWire));
    mar mar(.clk(clk),.Emar(Emar),.LmPC(LmPC),.LmIRa(LmIRa),.addressFromPC(pcAddressWire),.addressFromIR(irOutputWire[3:0]),.outputAddress(marAddressWire));
    memory_16x8_rom memoryRom(.clk(clk), .readEnable(readEnableROM), .readAddress(marAddressWire), .dataOut(memoryDataWire));
    instruction_register ir(.clk(clk), .Eir(Eir), .inputInstruction(memoryDataWire), .outputInstruction(irOutputWire));
    accumulator acc(.clk(clk), .Eacc(Eacc), .LaccM(LaccM), .LaccA(LaccA), .inputDataFromMemory(memoryDataWire), .inputDataFromALU(aluOutputWire), .outputDataAcc(accOutputWire));
    b_register breg(.clk(clk), .Eb(Eb), .inputData(memoryDataWire), .outputData(bOutputWire));
    alu alu(.inputA(accOutputWire), .inputB(bOutputWire), .aluOutput(aluOutputWire), .subtract(subtract));
    output_register oreg(.clk(clk), .Eout(Eo), .inputData(accOutputWire), .outputData(orOutputWire));

endmodule
