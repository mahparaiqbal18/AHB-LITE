interface ahb_lite(input bit HCLK, HRESETn);

 logic [31:0]HADDR;
 logic [2:0]HBURST; // 'b000 = SINGLE
                        // 'b001 = INCR
                        // 'b010 = WRAP4
                        // 'b011 = INCR4
                        // 'b100 = WRAP8
                        // 'b101 = INCR8
                        // 'b110 = WRAP16
                        // 'b111 = INCR16
 logic HMASTLOCK;
 logic [3:0]HPROT;
 logic [2:0]HSIZE;  // 'b000 = bit [7:0]    transfer_size
                        // 'b001 = bit [15:0]   transfer_size
                        // 'b010 = bit [31:0]   transfer_size
                        // 'b011 = bit [63:0]   transfer_size
                        // 'b100 = bit [127:0]  transfer_size
                        // 'b101 = bit [255:0]  transfer_size
                        // 'b110 = bit [511:0]  transfer_size
                        // 'b111 = bit [1023:0] transfer_size
 logic [1:0]HTRANS; // 'b00 = IDLE
                        // 'b01 = BUSY
                        // 'b10 = NONSEQ
                        // 'b11 = SEQ
 logic[31:0]HWDATA;
 logic HWRITE;
 logic [31:0]HRDATA;
 logic HREADYOUT;
 logic HRESP;
 logic HSEL;
 logic HREADY;

 modport slave(input HADDR, HBURST, HMASTLOCK, HPROT, HSIZE, 
 HTRANS, HWDATA, HWRITE, HSEL, output HRDATA, HREADYOUT, HRESP);

 modport master(input HCLK, HRESETn, HRDATA, HREADY, HRESP, output HADDR, 
 HBURST, HMASTLOCK, HPROT, HSIZE, HTRANS, HWDATA, HWRITE, HSEL);

 modport mon(input HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE, 
 HTRANS, HWDATA, HSEL, HRDATA, HREADYOUT, HRESP);


endinterface

interface wrapper(input bit HCLK, HRESETn);

 logic [31:0]HADDR;
 logic [2:0]HBURST;
 logic HMASTLOCK;
 logic [3:0]HPROT;
 logic [2:0]HSIZE;
 logic [1:0]HTRANS;
 logic [31:0]HWDATA;
 logic HWRITE;
 logic [31:0]HRDATA;
 logic HREADYOUT;
 logic HRESP;
 logic HSEL;
 logic HREADY;
 
endinterface

module wrap(a0, wrapper_if0);

 ahb_lite a0;
 wrapper wrapper_if0;

 assign wrapper_if0.HCLK = a0.HCLK;
 assign wrapper_if0.HRESETn = a0.HRESETn;
 assign wrapper_if0.HADDR = a0.HADDR;
 assign wrapper_if0.HBURST = a0.HBURST;
 assign wrapper_if0.HMASTLOCK = a0.HMASTLOCK;
 assign wrapper_if0.HPROT = a0.HPROT;
 assign wrapper_if0.HSIZE = a0.HSIZE;
 assign wrapper_if0.HTRANS = a0.HTRANS;
 assign wrapper_if0.HWDATA = a0.HWDATA;
 assign wrapper_if0.HWRITE = a0.HWRITE;
 assign wrapper_if0.HRDATA = a0.HRDATA;
 assign wrapper_if0.HREADYOUT = a0.HREADYOUT;
 assign wrapper_if0.HRESP = a0.HRESP;
 assign wrapper_if0.HSEL = a0.HSEL;
 assign wrapper_if0.HREADY = a0.HREADY;

endmodule