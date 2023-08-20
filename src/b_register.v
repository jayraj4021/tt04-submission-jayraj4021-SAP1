module b_register(clk, Eb, inputData, outputData);

    // clk is main input clock
    // Eb is input enable signal for b register
    // inputData is input data for b register
    // outputData is output data for b register

    input clk;
    input Eb;
    input [7:0] inputData;
    output reg[7:0] outputData;

    always@(posedge clk)
    begin
        if(Eb)
            outputData <= inputData;
        else
            outputData <= outputData;
    end
endmodule