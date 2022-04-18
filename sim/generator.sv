//`include "transaction.sv"

class generator;

 mailbox gen2driv;
 rand transaction tr;
 int count;

 function new(mailbox gen2driv, int count);	
  this.gen2driv = gen2driv;	
  this.count = count;
 endfunction

 bit BYTE ='b000;
 bit HALF_WORD ='b001;
 bit WORD = 'b010;

 task byte_sized_single_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b000, BYTE, 1);  
  gen2drive.put(tr);
  count++;
 endtask

 task byte_sized_incr_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b001, BYTE, 100);  
  gen2drive.put(tr);
  count++;
 endtask

 task byte_sized_incr4_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b011, BYTE, 4);  
  gen2drive.put(tr);
  count++;
 endtask

 task byte_sized_incr8_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b101, BYTE, 8);  
  gen2drive.put(tr);
  count++;
 endtask

 task byte_sized_incr16_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b111, BYTE, 16);  
  gen2drive.put(tr);
  count++;
 endtask

 task half_word_sized_single_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b000, HALF_WORD, 1);  
  gen2drive.put(tr);
  count++;
 endtask

 task half_word_sized_incr_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b001, HALF_WORD, 100);  
  gen2drive.put(tr);
  count++;
 endtask

 task half_word_sized_incr4_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b011, HALF_WORD, 4);  
  gen2drive.put(tr);
  count++;
 endtask

 task half_word_sized_incr8_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b101, HALF_WORD, 8);  
  gen2drive.put(tr);
  count++;
 endtask

 task half_word_sized_incr16_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b111, HALF_WORD, 16);  
  gen2drive.put(tr);
  count++;
 endtask

 task word_sized_single_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b000, WORD, 1);  
  gen2drive.put(tr);
  count++;
 endtask

 task word_sized_incr_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b001, WORD, 100);  
  gen2drive.put(tr);
  count++;
 endtask

 task word_sized_incr4_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b011, WORD, 4);  
  gen2drive.put(tr);
  count++;
 endtask

 task word_sized_incr8_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b101, WORD, 8);  
  gen2drive.put(tr);
  count++;
 endtask

 task word_sized_incr16_burst();
  tr = new;
  tr.randomize();
  tr.create_size(3'b111, WORD, 16);  
  gen2drive.put(tr);
  count++;
 endtask

 task run();
  byte_sized_single_burst();
  byte_sized_incr_burst();
  byte_sized_incr4_burst();
  byte_sized_incr8_burst();
  byte_sized_incr16_burst();

  half_word_sized_single_burst();
  half_word_sized_incr_burst();
  half_word_sized_incr4_burst();
  half_word_sized_incr8_burst();
  half_word_sized_incr16_burst();

  word_sized_single_burst();
  word_sized_incr_burst();
  word_sized_incr4_burst();
  word_sized_incr8_burst();
  word_sized_incr16_burst();
 endtask

endclass