include "transaction.sv";

class driver;

 transaction tr;
 mailbox #(transaction) mbx;

 function new(mailbox #(transaction) mbx);
  this.mbx=mbx;	
 endfunction

  task get_INCR4_burst();

   for (int i = 0; i < 4; i++) begin
    tr = new();
    mbx.get(tr);
    $display("Address: 0x%0h is recieved",tr.HADDR);
   end

  endtask
	
  task get_INCR8_burst();

   for (int i = 0; i < 6; i++) begin
    tr = new();
    mbx.get(tr);
    $display("Address: 0x%0h is recieved",tr.HADDR);
   end

  endtask

  task get_INCR16_burst();

   for (int i = 0; i < 16; i++) begin
    tr = new();
    mbx.get(tr);
    $display("Address: 0x%0h is recieved",tr.HADDR);
   end

  endtask

endclass
