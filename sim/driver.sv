package driv;

 import trans::*;

class driver;

 virtual ahb_lite.master driver_if;
 mailbox gen2driv;
 event complete;

 function new(virtual ahb_lite.master driver_if, mailbox gen2driv);
  this.driver_if = driver_if;
  this.gen2driv= gen2driv;
 endfunction

 task reset();
 wait(driver_if.HRESETn);
  driver_if.HADDR  <= 0;
  driver_if.HBURST <= 0;
  driver_if.HPROT  <= 0;
  driver_if.HSIZE  <= 0;
  driver_if.HTRANS <= 0;
  driver_if.HWDATA <= 0;
  driver_if.HWRITE <= 0;
  driver_if.HRESP  <= 0;
  driver_if.HREADY <= 0;
 endtask

 task drive();
  transaction tr;
  gen2driv.get(tr);
  if(driver_if.HREADY)begin
   driver_if.HADDR  <= tr.HADDR;
   driver_if.HBURST <=    HBURST;
   driver_if.HPROT  <= tr.HPROT;
   driver_if.HSIZE  <=    HSIZE;
   driver_if.HTRANS <=    HTRANS;
   driver_if.HWRITE <= tr.HWRITE; 
   driver_if.HREADY <= 1;
   driver_if.HSEL   <= 1;
   @(posedge driver_if.HCLK)
    driver_if.HWDATA <= tr.HWDATA;
    -> complete;
  end
 endtask

 task run;
  forever begin
   drive();
  end
 endtask

endclass

endpackage