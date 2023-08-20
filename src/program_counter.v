module program_counter(input clk, rst, Epc, output reg[3:0] pc_address);

    //making asynch reset
    always@(posedge clk or posedge rst)
    begin
      if(rst)
        	pc_address <= 4'd0;
      else
	      if(Epc)
          	pc_address <= pc_address + 1'b1;
    end
endmodule