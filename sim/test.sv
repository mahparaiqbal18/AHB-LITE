`include "environment.sv";

program test(ahb_lite inf);

 initial begin
  environment env;
  env.run();
 end

 logic [2:0] tr_type;
 logic [2:0] tr_size;
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
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b10;
   tr.HTRANS = 'b11;
  end
 endtask

 task idle_transfer_incr();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b10;
   tr.HTRANS = 'b11;
  end
 endtask

 task idle_transfer_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b10;
   tr.HTRANS = 'b11;
  end
 endtask

 task idle_transfer_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b10;
   tr.HTRANS = 'b11;
  end
 endtask

 task idle_transfer_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b10;
   tr.HTRANS = 'b11;
  end
 endtask

 task busy_transfer_fixed_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b01) begin //HTRANS = BUSY
   tr.HTRANS = 'b11; //HTRANS = SEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b11; //SEQ
   tr.HTRANS = 'b11;
   if(tr.HBURST == 'b000) //SINGLE
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
 endtask

 task busy_transfer_fixed_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b01) begin //HTRANS = BUSY
   tr.HTRANS = 'b11; //HTRANS = SEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b11; //SEQ
   tr.HTRANS = 'b11;
   if(tr.HBURST == 'b000) //SINGLE
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
endtask

 task busy_transfer_fixed_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b01) begin //HTRANS = BUSY
   tr.HTRANS = 'b11; //HTRANS = SEQ
   while(tr.HREADY != 1)
    tr.HTRANS = 'b11; //SEQ
   tr.HTRANS = 'b11;
   if(tr.HBURST == 'b000) //SINGLE
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end
endtask

 task busy_transfer_undefined();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b01 && tr.HBURST == 'b001) begin //HTRANS = BUSY and HBURST = INCR  
   tr.HTRANS = $random('b00, 'b10, 'b11); //HTRANS = IDLE or NONSEQ or SEQ
   if(tr.HTRANS == 'b00 || tr.HTRANS == 'b10) begin//HTRANS = IDLE or NONSEQ
    tr.HBURST = 'b011;//INCR4
    while(tr.HREADY != 1)
     tr.HTRANS = $random('b00, 'b10); //IDLE or NONSEQ
    tr.HTRANS = 'b11;
   end
   else
    tr.HBURST = 'b001;//INCR (remains same)
  end
 endtask

 task address_change_idle_transfer_single();
  env.gen.byte_sized_single_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr();
  env.gen.byte_sized_incr_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr4();
  env.gen.byte_sized_incr4_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr8();
  env.gen.byte_sized_incr8_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
   tr.HADDR  = addr;
   while(tr.HREADY != 1)
    tr.HADDR = addr;
   tr.HADDR = addr + 1;
  end
 endtask

 task address_change_idle_transfer_incr16();
  env.gen.byte_sized_incr16_burst_write();
  env.gen.run();
  if(tr.HTRANS == 'b00) begin //HTRANS = IDLE
   tr.HTRANS = 'b10; //HTRANS = NONSEQ
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