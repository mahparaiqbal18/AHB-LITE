package gen;

import trans::*;

class generator;

 mailbox #(transaction) gen2driv;
 rand transaction tr;
int tr_count;
 event send;

 function new(mailbox #(transaction) gen2driv);	
  this.gen2driv = gen2driv;	
 endfunction

 task create_size(hburst tr_type, hsize tr_size, int wrap_or_incr_size, bit read_write);
  int addr;
  if(tr_type == WRAP4 || WRAP8 || WRAP16) begin 
   for(int i = 0; i < wrap_or_incr_size; i++) begin
    tr = new;
    if(i == 0) begin
     addr = tr.HADDR;
     HTRANS = NONSEQ;
    end
    else begin
     tr.HADDR <= addr + 4;
     HTRANS <= SEQ;
    end
    tr.HWRITE <= read_write;
    HBURST <= tr_type;
    HSIZE <= tr_size;
    tr.HPROT <= 4'b0011;
    gen2driv.put(tr);
    tr_count++;
   end
  end
  else begin
   int wrap = 0;
   int start_addr;
   for(int i = 0; i < 40; i++) begin
    tr = new;
    if(wrap < wrap_or_incr_size) begin
     if(i == 0) begin
      addr <= tr.HADDR;
      start_addr <= tr.HADDR;
      HTRANS <= NONSEQ;
      wrap++;
     end
     else begin
      tr.HADDR <= addr + 4;
      HTRANS <= SEQ;
      wrap++;
     end
    end
    else begin
     addr <= start_addr;
     wrap = 0;
    end
    HSIZE <= tr_size;
    HBURST <= tr_type;
    tr.HWRITE <= read_write;
    tr.HPROT <= 4'b0011;
    gen2driv.put(tr);
    tr_count++;
   end
  end
 endtask

 task byte_sized_single_burst_write();
  create_size(SINGLE, BYTE, 0, 1);
 endtask
 task byte_sized_single_burst_read();
  create_size(SINGLE, BYTE, 0, 0);
 endtask

 task byte_sized_incr_burst_write();
  create_size(INCR, BYTE, 100, 1);
 endtask

 task byte_sized_incr_burst_read();
  create_size(INCR, BYTE, 100, 0);
 endtask

 task byte_sized_incr4_burst_write();
  create_size(INCR4, BYTE, 4, 1);
 endtask

 task byte_sized_incr4_burst_read();
  create_size(INCR4, BYTE, 4, 0);
 endtask

 task byte_sized_incr8_burst_write();
  create_size(INCR8, BYTE, 8, 1);
 endtask

 task byte_sized_incr8_burst_read();
  create_size(INCR8, BYTE, 8, 0);
 endtask

 task byte_sized_incr16_burst_write();
  create_size(INCR16, BYTE, 16, 1);
 endtask

 task byte_sized_incr16_burst_read();
  create_size(INCR16, BYTE, 16, 0);
 endtask

 task halfword_sized_single_burst_write();
  create_size(SINGLE, HALF_WORD, 0, 1);
 endtask

 task halfword_sized_single_burst_read();
  create_size(SINGLE, HALF_WORD, 0, 0);
 endtask

 task halfword_sized_incr_burst_write();
  create_size(INCR, HALF_WORD, 100, 1);
 endtask

 task halfword_sized_incr_burst_read();
  create_size(INCR, HALF_WORD, 100, 0);
 endtask

 task halfword_sized_incr4_burst_write();
  create_size(INCR4, HALF_WORD, 4, 1);
 endtask

 task halfword_sized_incr4_burst_read();
  create_size(INCR4, HALF_WORD, 4, 0);
 endtask

 task halfword_sized_incr8_burst_write();
  create_size(INCR8, HALF_WORD, 8, 1);
 endtask

 task halfword_sized_incr8_burst_read();
  create_size(INCR8, HALF_WORD, 8, 0);
 endtask

 task halfword_sized_incr16_burst_write();
  create_size(INCR16, HALF_WORD, 16, 1);
 endtask

 task halfword_sized_incr16_burst_read();
  create_size(INCR16, HALF_WORD, 16, 0);
 endtask

 task word_sized_single_burst_write();
  create_size(SINGLE, WORD, 0, 1);
 endtask

 task word_sized_single_burst_read();
  create_size(SINGLE, WORD, 0, 0);
 endtask

 task word_sized_incr_burst_write();
  create_size(INCR, WORD, 100, 1);
 endtask

 task word_sized_incr_burst_read();
  create_size(INCR, WORD, 100, 0);
 endtask

 task word_sized_incr4_burst_write();
  create_size(INCR4, WORD, 4, 1);
 endtask

 task word_sized_incr4_burst_read();
  create_size(INCR4, WORD, 4, 0);
 endtask

 task word_sized_incr8_burst_write();
  create_size(INCR8, WORD, 8, 1);
 endtask

 task word_sized_incr8_burst_read();
  create_size(INCR8, WORD, 8, 0);
 endtask

 task word_sized_incr16_burst_write();
  create_size(INCR16, WORD, 16, 1);
 endtask

 task word_sized_incr16_burst_read();
  create_size(INCR16, WORD, 16, 0);
 endtask

 task run();
  byte_sized_single_burst_write();
  byte_sized_incr_burst_write();
  byte_sized_incr4_burst_write();
  byte_sized_incr8_burst_write();
  byte_sized_incr16_burst_write();

  byte_sized_single_burst_read();
  byte_sized_incr_burst_read();
  byte_sized_incr4_burst_read();
  byte_sized_incr8_burst_read();
  byte_sized_incr16_burst_read();

  halfword_sized_single_burst_write();
  halfword_sized_incr_burst_write();
  halfword_sized_incr4_burst_write();
  halfword_sized_incr8_burst_write();
  halfword_sized_incr16_burst_write();

  halfword_sized_single_burst_read();
  halfword_sized_incr_burst_read();
  halfword_sized_incr4_burst_read();
  halfword_sized_incr8_burst_read();
  halfword_sized_incr16_burst_read();

  word_sized_single_burst_write();
  word_sized_incr_burst_write();
  word_sized_incr4_burst_write();
  word_sized_incr8_burst_write();
  word_sized_incr16_burst_write();

  word_sized_single_burst_read();
  word_sized_incr_burst_read();
  word_sized_incr4_burst_read();
  word_sized_incr8_burst_read();
  word_sized_incr16_burst_read();
 endtask

endclass

endpackage