include "transaction.sv";

class generator;
	
 bit [31:0]addr;
 bit [31:0]data;
 bit ready;
 bit resp;

 transaction tr;
 mailbox #(transaction) mbx;

 function new(mailbox #(transaction) mbx);	
  this.mbx = mbx;	
 endfunction

//Change in transfer type in case of IDLE transfer
 task IDLE_Transfer_Type();
  tr = new();
  this.tr.HADDR = addr;
  this.tr.HWDATA = data;
  this.tr.HTRANS = 'b00; //IDLE
  this.tr.HBURST = 'b000; //SINGLE
  this.tr.HREADY = ready;
  mbx.put(tr);
 endtask

//Change in transfer type in case of BUSY transfer, fixed length burst
 task BUSY_Transfer_Fixed();
  tr = new();
  this.tr.HADDR = addr;
  this.tr.HWDATA = data;
  this.tr.HTRANS = 'b01; //BUSY
  this.tr.HBURST = 'b011; //INCR4
  this.tr.HREADY = ready;
  mbx.put(tr);
 endtask

//Change in transfer type in case of BUSY transfer, undefined length burst
 task BUSY_Transfer_Undefined();
  tr = new();
  this.tr.HADDR = addr;
  this.tr.HWDATA = data;
  this.tr.HTRANS = $random('b00, 'b10, 'b11);
  this.tr.HBURST = 'b001; //INCR
  this.tr.HREADY = ready;
  mbx.put(tr);
 endtask

//Change in address in case of IDLE transfer
 task IDLE_Transfer_Address();
  tr = new();
  this.tr.HADDR = addr;
  this.tr.HWDATA = data;
  this.tr.HTRANS = 'b00; //IDLE
  this.tr.HBURST = 'b000; //SINGLE
  this.tr.HREADY = ready;
  mbx.put(tr);
 endtask

//Change in address in case of an ERROR Response
 task ERROR_Response_Transfer();
  tr = new();
  this.tr.HADDR = addr;
  this.tr.HWDATA = data;
  this.tr.HTRANS = 'b00; //IDLE
  this.tr.HBURST = 'b000; //SINGLE
  this.tr.HRESP = resp;
  this.tr.HREADY = ready;
  mbx.put(tr);
 endtask

 task run;
  IDLE_Transfer_Type();
  BUSY_Transfer_Fixed();
  BUSY_Transfer_Undefined();
  IDLE_Transfer_Address();
  ERROR_Response_Transfer();
 endtask

endclass