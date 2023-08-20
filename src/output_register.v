module output_register(clk, Eout, inputData, outputData);

    // clk is main input clock
    // Eout is input enable signal for output register
    // inputData is input data for output register
    // outputData is output data for output register

    input clk;
    input Eout;
    input [7:0] inputData;
    output reg[7:0] outputData;

    always@(posedge clk)
    begin
        if(Eout)
            outputData <= inputData;
        else
            outputData <= outputData;
    end
endmodule