`timescale 1ns / 1ns
`include "tt_um_jayraj4021_SAP1_cpu.v"

module tt_um_jayraj4021_SAP1_cpu_tb;

    reg clk = 1'b0;
    reg rst_n = 1'b1;
    wire[7:0] uo_out ;
    wire[7:0] uio_out;
    wire[7:0] uio_oe;


    always begin
        clk = ~clk;
        #10;
    end

  /*  input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset*/

    tt_um_jayraj4021_SAP1_cpu uut(.ui_in(),.uo_out(uo_out),.uio_in(),.uio_out(uio_out),.uio_oe(uio_oe),.clk(clk),.rst_n(rst_n));

    initial begin

        $dumpfile("tt_um_jayraj4021_SAP1_cpu_tb.vcd");
        $dumpvars(0,tt_um_jayraj4021_SAP1_cpu_tb);

        #25

        rst_n = 1'b0;
        #100

        rst_n = 1'b1;
        #2000

        $display("JD test done");
        $stop;
    end

endmodule
