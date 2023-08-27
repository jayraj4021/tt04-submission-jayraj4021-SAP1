`timescale 1ns / 1ns
`include "tt_um_jayraj4021_SAP1_cpu.v"

module tt_um_jayraj4021_SAP1_cpu_tb;

    reg clk = 1'b0;
    reg rst = 1'b0;

    always begin
        clk = ~clk;
        #10;
    end

    tt_um_jayraj4021_SAP1_cpu uut(clk,rst);

    initial begin

        $dumpfile("tt_um_jayraj4021_SAP1_cpu_tb.vcd");
        $dumpvars(0,tt_um_jayraj4021_SAP1_cpu_tb);

        #25

        rst = 1'b1;
        #100

        rst = 1'b0;
        #2000

        $display("JD test done");
        $stop;
    end

endmodule
