module mar(clk, Emar, LmPC, LmIRa, addressFromPC, addressFromIR, outputAddress);

    input clk;
    input Emar;
    input LmPC;
    input LmIRa;
    input [3:0] addressFromPC;
    input [3:0] addressFromIR;
    output reg[3:0] outputAddress;

    // clk is main input clock
    // Emar is synchronous enable signal for MAR
    // LmPC stands for load MAR with address from PC, this active high signal enables loading of MAR with PC address
    // LmIRa stans for load MAR with address from IR's lower nibble 
    // rest of the names are self explainatory

    always@(posedge clk)
    begin
        if(Emar)
            if(LmPC)
                outputAddress <= addressFromPC;
            else if(LmIRa)
                outputAddress <= addressFromIR;
            else
                outputAddress <= outputAddress;
        else
            outputAddress <= outputAddress;
    end

endmodule