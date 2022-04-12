include "transaction.sv";

class generator;
	
 bit [31:0]addr;
 bit [31:0]data;
 bit wr;

 transaction tr;
 mailbox #(transaction) mbx;

 function new(mailbox #(transaction) mbx);	
  this.mbx = mbx;	
 endfunction
	
 task INCR4_burst(bit wr_data);
		
  bit [2:0] add_size;
  tr = new(); 
  this.tr.HADDR = addr;
  this.tr.HBURST = 3'b011; //INCR4
  this.tr.HTRANS = 3'b010; //NONSEQ
  this.tr.HWDATA = data;
  this.tr.HWRITE = wr_data;  
  mbx.put(tr);

  $display("Address: 0x%0h is sent to the Driver\n",tr.HADDR);

  repeat(3) begin
   tr = new();
   this.tr.HBURST = 3'b011; //INCR4
   this.tr.HWRITE = wr_data; 
   this.tr.HSIZE = 3'b010; //'b010 = bit [31:0]   transfer_size
   this.tr.HTRANS = 3'b011; //SEQ
   
   case(tr.HSIZE)
    3'b000 : add_size = 1;
    3'b001 : add_size = 2;
    3'b010 : add_size = 4;
   endcase

   mbx.put(tr);	
   addr = addr + add_size;
   this.tr.HADDR = addr;
   $display("Address: 0x%0h is sent to the Mailbox",tr.HADDR);
  end
	
  $display("All INC4 has been sent to the driver\n");

 endtask

 task INCR8_burst(bit wr_data);

  bit [2:0] add_size;
  tr = new(); 
  this.tr.HADDR = addr;
  this.tr.HBURST = 3'b101; //INCR8
  this.tr.HTRANS = 3'b010; //NONSEQ
  this.tr.HWDATA = data;
  this.tr.HWRITE = wr_data;
  mbx.put(tr);

  $display("Address: 0x%0h is sent to the Driver\n",tr.HADDR);
	 		
  repeat(5) begin
   tr=new();
   this.tr.HBURST = 3'b101; //INCR8
   this.tr.HWRITE = wr_data; 
   this.tr.HSIZE = 3'b010; //'b010 = bit [31:0]   transfer_size
   this.tr.HTRANS = 3'b011; //SEQ

   case(tr.HSIZE)
     3'b000 : add_size = 1;
     3'b001 : add_size = 2;
     3'b010 : add_size = 4;
   endcase

   mbx.put(tr);	
   addr = addr + add_size;
   this.tr.HADDR = addr;

   $display("Address: 0x%0h is sent to the Mailbox",tr.HADDR);
			
  end
	
  $display("All 8-beats in INCR8 burst sent to driver\n");

 endtask

 task INCR16_burst(bit wr_data);	
	
  bit [2:0] add_size;
  tr=new; 
  this.tr.HADDR = addr;
  this.tr.HBURST = 3'b111; //INCR16
  this.tr.HTRANS = 3'b010; //NONSEQ
  this.tr.HWDATA = data;
  this.tr.HWRITE = wr_data;
  mbx.put(tr);

  $display("Address: 0x%0h is sent to the Driver\n",tr.HADDR);
	 		
  repeat(7) begin
   tr=new();
   this.tr.HBURST = 3'b111; //INCR16
   this.tr.HWRITE = wr_data; 
   this.tr.HSIZE = 3'b010; //'b010 = bit [31:0]   transfer_size
   this.tr.HTRANS = 3'b011; //SEQ
   
   case(tr.HSIZE)
    3'b000 : add_size = 1;
    3'b001 : add_size = 2;
    3'b010 : add_size = 4;
   endcase

   mbx.put(tr);	
   addr = addr + add_size;
   this.tr.HADDR = addr;
   $display("Address: 0x%0h is sent to the mailbox",tr.HADDR);
  end

  $display("All INC16 has been sent to the driver\n");

 endtask

endclass
