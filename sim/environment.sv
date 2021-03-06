import trans::*;
import gen::generator;
import driv::driver;
import mon::monitor;
import scb::scoreboard;

class environment;

 mailbox #(transaction) gen_driv;
 mailbox #(transaction) mon_scb;

 generator gen;
 driver driv;
 monitor mon;
 scoreboard scb;

 virtual interface ahb_lite inf;

 function new(virtual interface ahb_lite inf);
  this.inf = inf;
  gen_driv = new();
  mon_scb  = new();
  gen      = new(gen_driv);
  driv     = new(inf, gen_driv);
  mon      = new(inf, mon_scb);
  scb      = new(mon_scb);
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
  wait(gen.tr_count == 1000);
  wait(scb.tr_count == 1000);
 endtask

 task run();
  before_test();
  test();
  after_test();
 endtask

endclass