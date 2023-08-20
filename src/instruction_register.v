module instruction_register(clk, Eir, inputInstruction, outputInstruction);

    // clk is main input clock
    // Eir is input enable signal for instruction register
    // inputInstruction is input instruction from memory to the instruction register (IR)
    // outputInstruction is stored instruction register

    input clk;
    input Eir;
    input [7:0] inputInstruction;
    output reg[7:0] outputInstruction;

    always@(posedge clk)
    begin
        if(Eir)
            outputInstruction <= inputInstruction;
        else
            outputInstruction <= outputInstruction;
    end
endmodule