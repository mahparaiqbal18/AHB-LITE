class transaction;
 
 rand bit[31:0]HADDR;
 rand bit[2:0] HBURST;
 rand logic[3:0]HPROT;
 rand bit[2:0]HSIZE;	  
 rand logic[1:0]HTRANS;
 rand bit[31:0]HWDATA;   
 rand bit HWRITE;  
 logic [31:0]HRDATA;   
 bit HRESP; 
 bit HREADY;

endclass