class transaction;
	logic	[1:0]	HTRANS;
 	logic	[2:0]  	HSIZE;
 	logic	[2:0] 	HBURST;
 rand 	logic 	[7:0] 	HADDR;
	logic 		HWRITE;
	logic 	[3:0] 	HPROT;
 rand	logic 	[31:0] 	HWDATA;
	logic 		HREADYOUT;
	logic 		HRESP;
	logic 	[31:0] 	HRDATA;
        bit             HRESETn;
	bit             HSEL;

 task create_size(input [2:0] burst_type, input [2:0] burst_size, int incr_size);
  int addr;
  addr = HADDR;
  if(burst_type == 3'b000 || 3'b001 || 3'b011 || 3'b101 || 3'b111) begin
   for(int i = 0; i < incr_size; i++) begin
    if(i > 0) 
     HADDR <= HADDR + 1;
    if(i == 0)
     HTRANS <= 2'b10;  //NONSEQ
    else 	
     HTRANS <= 2'b11;  //SEQ
    
    HPROT <= 4'b0011;
    HSIZE <= burst_size;
    HBURST <= burst_type;
   end
  end

 endtask 

endclass