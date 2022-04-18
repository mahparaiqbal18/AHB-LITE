`include "transaction.sv";
`include "generator.sv";
`include "driver.sv";
`include "monitor.sv";
`include "scoreboard.sv";

class environment

 mailbox gen_driv;
 mailbox mon_scb;

 generator gen;
 driver driv;
 monitor mon;
 scoreboard scb;

 virtual interface ahb_lite inf;

 function new(virtual interface ahb_lite inf);
  this.inf = inf;
  this.gen_driv = new();
  this.mon_scb  = new();
  this.gen      = new(gen_driv);
  this.driv     = new(gen_driv, inf);
  this.mon      = new(mon_scb, inf);
  this.scb      = new(mon_scb);
 endfunction

 task before_test();
  driv.reset();
 endtask

 task test();
  fork
   gen.run();
   driv.run();
   mon.run();
   scb.run();
  join_any
 endtask

 task after_test();
  wait(gen.count == 1000);
  wait(scb.tr_count == 1000);
 endtask

 task run();
  before_test();
  test();
  after_test();
 endtask

endclass