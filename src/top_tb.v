`timescale 1ns / 1ns
`include "top.v"

module top_tb;

    reg clk = 1'b0;
    reg rst = 1'b0;

    always begin
        clk = ~clk;
        #10;
    end

    top uut(clk,rst);

    initial begin

        $dumpfile("top_tb.vcd");
        $dumpvars(0,top_tb);

        #25

        rst = 1'b1;
        #100

        rst = 1'b0;
        #2000

        $display("JD test done");
        $stop;
    end

endmodule