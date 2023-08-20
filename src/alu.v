module alu(inputA, inputB, aluOutput, subtract);

    // inputA is data from Accumulator
    // inputB is data fro b register
    // subtract is flag signal to enable subtraction instead of addition
    // aluOutput is output of ALU

    input [7:0] inputA, inputB;
    input subtract;
    output reg[7:0] aluOutput;

    always@(inputA,inputB,subtract)
    begin
        if(subtract)
            aluOutput = inputA - inputB;
        else
            aluOutput = inputA + inputB;
    end
endmodule