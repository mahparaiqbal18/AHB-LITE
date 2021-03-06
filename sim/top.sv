`include "test.sv"

module top;

 bit clk;
 bit reset;

 initial begin
  forever #10 clk = ~clk;

  #1 reset = 0;
  #5 reset = 1;
 end

 ahb_lite inf(clk, reset);
 wrapper wrapper_if(clk, reset);
 test t0(inf);

endmodule