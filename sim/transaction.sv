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
endclass