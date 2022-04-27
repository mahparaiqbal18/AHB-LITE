`include "environment.sv";

program test(ahb_lite inf);

 initial begin
  environment env;
  env.run();
 end

 hburst tr_type;
 hsize tr_size;
 int wrap_or_incr_size;
 logic addr;

  environment env;
  localparam tr_no = 1000;
  localparam read_write = 0;

 task random();
  forever begin 
   tr_type = $random;
   tr_size = $random;
   wrap_or_incr_size = $random;
   addr = $random;
   env.gen.create_size(tr_type,tr_size,wrap_or_incr_size,read_write);
	wait(env.gen.tr_count == tr_no);
	$stop;
  end
 endtask

 task idle_transfer_single();
  env.gen.byte_sized_single_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   while(tr.HREADY != 1)
    HTRANS = NONSEQ;
   HTRANS = SEQ;
  end
 endtask

 task idle_transfer_incr();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   while(tr.HREADY != 1)
    HTRANS = NONSEQ;
   HTRANS = SEQ;
  end
 endtask

 task idle_transfer_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   while(tr.HREADY != 1)
    HTRANS = NONSEQ;
   HTRANS = SEQ;
  end
 endtask

 task idle_transfer_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   while(tr.HREADY != 1)
    HTRANS = NONSEQ;
   HTRANS = SEQ;
  end
 endtask

 task idle_transfer_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   while(tr.HREADY != 1)
    HTRANS = NONSEQ;
   HTRANS = SEQ;
  end
 endtask

 task busy_transfer_fixed_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(HTRANS == BUSY) begin
   tr.HTRANS = SEQ;
   while(tr.HREADY != 1)
    tr.HTRANS = SEQ;
   tr.HTRANS = SEQ;
   if(tr.HBURST == SINGLE)
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
 endtask

 task busy_transfer_fixed_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(HTRANS == BUSY) begin
   tr.HTRANS = SEQ;
   while(tr.HREADY != 1)
    tr.HTRANS = SEQ;
   tr.HTRANS = SEQ;
   if(tr.HBURST == SINGLE)
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
endtask

 task busy_transfer_fixed_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(HTRANS == BUSY) begin
   tr.HTRANS = SEQ;
   while(tr.HREADY != 1)
    tr.HTRANS = SEQ;
   tr.HTRANS = SEQ;
   if(tr.HBURST == SINGLE)
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
endtask

 task busy_transfer_undefined();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(HTRANS == BUSY && HBURST == INCR) begin
   HTRANS = $random(IDLE, NONSEQ, SEQ);
   if(HTRANS == IDLE || HTRANS == NONSEQ) begin
    HBURST = INCR4;
    while(tr.HREADY != 1)
     HTRANS = $random(IDLE, NONSEQ);
    HTRANS = SEQ;
   end
   else
    HBURST = INCR;
  end
 endtask

 task address_change_idle_transfer_single();
  env.gen.byte_sized_single_burst_write();
  env.gen.run();
  if(HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(tr.HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(tr.HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(tr.HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(tr.HTRANS == IDLE) begin
   HTRANS = NONSEQ;
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_ERROR_response_single();
  env.gen.byte_sized_single_burst_write();
  env.gen.run();
  while(tr.HRESP == 1 && tr.HREADY == 0) begin
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_ERROR_response_incr();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  while(tr.HRESP == 1 && tr.HREADY == 0) begin
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_ERROR_response_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  while(tr.HRESP == 1 && tr.HREADY == 0) begin
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_ERROR_response_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  while(tr.HRESP == 1 && tr.HREADY == 0) begin
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_ERROR_response_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  while(tr.HRESP == 1 && tr.HREADY == 0) begin
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

endprogram