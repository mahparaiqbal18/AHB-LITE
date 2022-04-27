package mon;

 import trans::*;

class monitor;

 mailbox #(transaction) mon2scb;
 virtual interface ahb_lite.mon mon_inf;
 transaction tr;
 event receive;

 function new(virtual ahb_lite.mon mon_inf, mailbox #(transaction) mon2scb);
  this.mon_inf = mon_inf;
  this.mon2scb = mon2scb;
 endfunction

 task run();
  forever begin
   if(mon_inf.HREADY) begin
   tr = new();
    tr.HADDR     = mon_inf.HADDR;
       HBURST    = mon_inf.HBURST;
    tr.HPROT     = mon_inf.HPROT;
       HSIZE     = mon_inf.HSIZE;
       HTRANS    = mon_inf.HTRANS;
    tr.HWDATA    = mon_inf.HWDATA;
    if(mon_inf.HWRITE)begin
     @(posedge mon_inf.HCLK)
     tr.HWDATA	<= mon_inf.HWDATA;
    end
    mon2scb.put(tr);
    ->receive;
   end
  end
 endtask

endclass

endpackage