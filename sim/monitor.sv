/*`include "wrapper.sv"
`include "transaction.sv"*/

class monitor;

 mailbox mon2scb;
 virtual interface ahb_lite.mon mon_inf;
 transaction tr;
 event receive;

 function new(virtual ahb_lite.mon mon_inf, mailbox mon2scb);
  this.mon_inf = mon_inf;
  this.mon2scb = mon2scb;
 endfunction

 task run();
  forever begin
   if(!mon_inf.HRESP && mon_inf.HREADYOUT) begin
   tr = new();
    tr.HADDR     = mon_inf.HADDR;
    tr.HBURST    = mon_inf.HBURST;
    tr.HPROT     = mon_inf.HPROT;
    tr.HSIZE     = mon_inf.HSIZE;
    tr.HTRANS    = mon_inf.HTRANS;
    tr.HWDATA    = mon_inf.HWDATA;
    if(mon_inf.HWRITE)begin
     @(posedge monitor_if.HCLK)
     tr.HWDATA	<= monitor_if.HWDATA;
    end
    mon2scb.tr.put(tr);
    ->receive;
   end
  end
 endtask

endclass