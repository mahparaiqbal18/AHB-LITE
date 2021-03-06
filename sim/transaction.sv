package trans;

 typedef enum logic [1:0] {IDLE = 2'b00, BUSY = 2'b01, 
				  NONSEQ = 2'b10, SEQ = 2'b11} htrans;
 typedef enum logic [2:0] {BYTE = 3'b000, HALF_WORD = 3'b001, WORD = 3'b010,
                                  DOUBLE_WORD = 3'b011, FOUR_WORD_LINE = 3'b100,
                                  EIGHT_WORD_LINE = 3'b101} hsize;
 typedef enum logic [2:0] {SINGLE = 3'b000, INCR = 3'b001, WRAP4 = 3'b010, 
                                  INCR4 = 3'b011, WRAP8 = 3'b100, INCR8 = 3'b101, 
                                  WRAP16 = 3'b110, INCR16 = 3'b111} hburst;
 htrans HTRANS;
 hsize HSIZE;
 hburst HBURST;

class transaction;
 rand 	logic 	[7:0] 	HADDR;
	logic 		HWRITE;
	logic 	[3:0] 	HPROT;
 rand	logic 	[31:0] 	HWDATA;
	logic 		HREADYOUT;
	logic 		HRESP;
	logic 	[31:0] 	HRDATA;
        bit             HRESETn;
	bit             HSEL;
        bit             HREADY;

endclass

endpackage