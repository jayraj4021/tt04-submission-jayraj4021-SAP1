module accumulator(clk, Eacc, LaccM, LaccA, inputDataFromMemory, inputDataFromALU, outputDataAcc);

    // clk is main input clock
    // Eacc is input enable signal for accumulator
    // LaccM is input enable to load data from ROM
    // LaccA is input enable to load data from ALU
    // inputDataFromMemory is data to be loaded from ROM
    // inputDataFromALU is data to be loaded from ALU
    // outputDataAcc is output data of Accululator

    input clk;
    input Eacc;
    input LaccM;
    input LaccA;
    input [7:0] inputDataFromMemory;
    input [7:0] inputDataFromALU;
    output reg[7:0] outputDataAcc;

    always@(posedge clk)
    begin
        if(Eacc)
            if(LaccM)
                outputDataAcc <= inputDataFromMemory;
            else if(LaccA)
                outputDataAcc <= inputDataFromALU;
            else
                outputDataAcc <= outputDataAcc;
        else
            outputDataAcc <= outputDataAcc;
    end
endmodule