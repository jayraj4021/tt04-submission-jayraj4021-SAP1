module control_unit(clk, rst, inputInstruction, Epc, RstPc, Emar, LmPC, LmIRa, readEnableROM, Eir, Eacc, LaccM, LaccA, Eb, subtract,Eo);

    input clk, rst;
    input [7:0] inputInstruction;
    output Epc, RstPc, Emar, LmPC, LmIRa, readEnableROM, Eir, Eacc, LaccM, LaccA, Eb, subtract,Eo;

    parameter IDLE = 8'b00000001;
    parameter T1   = 8'b00000010;
    parameter T2   = 8'b00000100;
    parameter T3   = 8'b00001000;
    parameter T4   = 8'b00010000;
    parameter T5   = 8'b00100000;
    parameter T6   = 8'b01000000;
    parameter T7   = 8'b10000000;

    reg [7:0] present, next;

    always@(negedge clk)  // present state logic
    begin
        if(rst)
            present <= IDLE;
        else
            present <= next;
    end

    always@(present,inputInstruction) // next state logic
    begin
        next = IDLE; // Default state
        case(present)
            IDLE: begin next = T1; end
            T1: begin next = T2; end
            T2: begin next = T3; end
            T3: begin next = T4; end
            T4: begin next = T5; end
            T5: begin next = T6; end
            T6: begin next = T7; end
            T7: begin next = T1; end
        endcase
    end

    assign RstPc            = (present == IDLE) ? 1:0;
    assign Emar             = (present == T1 || (present == T4 && (inputInstruction[7:4] == 4'b0000 || inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010))) ? 1:0;
    assign LmPC             = (present == T1) ? 1:0;
    assign Epc              = (present == T2) ? 1:0;
    assign readEnableROM    = (present == T2 || (present == T5 && (inputInstruction[7:4] == 4'b0000 || inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010))) ? 1:0;
    assign Eir              = (present == T3) ? 1:0;
    assign LmIRa            = (present == T4 && (inputInstruction[7:4] == 4'b0000 || inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010)) ? 1:0;
    assign Eacc             = ((present == T6 && inputInstruction[7:4] == 4'b0000) || (present == T7 && (inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010))) ? 1:0;
    assign LaccM            = (present == T6 && inputInstruction[7:4] == 4'b0000) ? 1:0;
    assign LaccA            = (present == T7 && (inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010)) ? 1:0;
    assign Eb               = (present == T6 && (inputInstruction[7:4] == 4'b0001 || inputInstruction[7:4] == 4'b0010)) ? 1:0;
    assign subtract         = ((present == T6 || present == T7 ) && inputInstruction[7:4] == 4'b0010) ? 1:0;
    assign Eo               = (present == T4 && inputInstruction[7:4] == 4'b1110);

endmodule