`include "environment.sv";

program test(ahb_lite inf);

 initial begin
  environment env;
  env.run();
 end

endprogram