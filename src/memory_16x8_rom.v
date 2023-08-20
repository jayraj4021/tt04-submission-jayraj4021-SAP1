module memory_16x8_rom(clk, readEnable, readAddress, dataOut);

    parameter ROM_WIDTH = 8;
    parameter ROM_DEPTH = 16;
    parameter ADDRESS_SIZE = 4;

    input clk;
    input readEnable;
    input [ADDRESS_SIZE-1:0] readAddress;
    output reg [ROM_WIDTH-1:0] dataOut;

    /* Following is ISA opcodes for SAP-1
        Mnemonics   | Opcode
        ------------------
        LDA         | 0000
        ADD         | 0001
        SUB         | 0010
        OUT         | 1110
        HLT         | 1111

        Based on above mapping, loading memory with following code.
        LDA 0x9 = 0000 1001
        ADD 0xA = 0001 1010
        ADD 0xB = 0001 1011
        SUB 0xC = 0010 1100
        OUT     = 1110 XXXX
        HLT     = 1111 XXXX

    */


    reg [ROM_WIDTH-1:0] mem [ROM_DEPTH-1:0];
    
    //Initializing the memory , not sure if this is correct and synthesizable, will see
    //integer i;
    //initial begin
    //    for(i=0; i<ROM_DEPTH; i=i+1)
    //        mem[i] = i+3;
    //end
    //Initialized the memory as per above code 
    initial begin
        mem[0]  = 8'b00001001;
        mem[1]  = 8'b00011010;
        mem[2]  = 8'b00011011;
        mem[3]  = 8'b00101100;
        mem[4]  = 8'b11101111;
        mem[5]  = 8'b00001001;
        mem[6]  = 8'b00011100;
        mem[7]  = 8'b11101111;
        mem[8]  = 8'b11111111;
        mem[9]  = 8'b00000001;
        mem[10] = 8'b00000010;
        mem[11] = 8'b00000011;
        mem[12] = 8'b00000100;
        mem[13] = 8'b11111111;
        mem[14] = 8'b11111111;
        mem[15] = 8'b11111111;
    end
    

    always@(posedge clk)
    begin
        if (readEnable)
            dataOut <= mem[readAddress];
        else
            dataOut <= dataOut;
    end

endmodule