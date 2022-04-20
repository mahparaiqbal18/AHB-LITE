`ifndef include_n
`include "transaction.sv"
`endif

class scoreboard;

 mailbox #(transaction) mon2scb;
 transaction tr;
 logic [31:0]memory[int];
 int tr_count;
 int error_count;

 task run();
  forever begin
   mon2scb.get(tr);
   if(tr.HWRITE)begin
    memory[tr.HADDR] = tr.HWDATA;
    tr_count++;
   end
   else if(memory[tr.HADDR] == tr.HWDATA)begin
    $display("Data matched on this specific address");
    tr_count++;
   end
   else begin
    $display("Data does not match on this specific address");
    error_count++;
   end
  end
 endtask

endclass
