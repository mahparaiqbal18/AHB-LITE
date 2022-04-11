module ahblite#
(
  parameter MEM_SIZE          = 0,   //Memory in Bytes
  parameter MEM_DEPTH         = 256, //Memory depth
  parameter HADDR_SIZE        = 8,
  parameter HDATA_SIZE        = 32,
  parameter TECHNOLOGY        = "GENERIC",
  parameter REGISTERED_OUTPUT = "NO",
  parameter INIT_FILE         = ""
 )
(
 input HCLK;
 input HRESETn;
 input HADDR[HADDR_SIZE - 1:0];
 input HBURST[2:0];
 input HMASTLOCK;
 input HPROT[3:0];
 input HSIZE[2:0];
 input HTRANS[1:0];
 input HWDATA[HDATA_SIZE - 1:0];
 input HWRITE;
 output reg HRDATA[HDATA_SIZE - 1:0];
 output reg HREADYOUT;
 output HRESP;
 input HSEL;
 input HREADY;
);

 initial begin

  byte htrans;

  case(HTRANS)
   'b00: htrans = 'IDLE';
   'b01: htrans = 'BUSY';
   'b10: htrans = 'NONSEQ';
   'b11: htrans = 'SEQ';
  endcase

  case(HSIZE)
   'b000: bit[7:0] hsize; //Byte
   'b001: bit[15:0] hsize; //Halfword
   'b010: bit[31:0] hsize; //Word
   'b011: bit[63:0] hsize; //Doubleword
   'b100: bit[127:0] hsize; //4-word line
   'b101: bit[255:0] hsize; //8-word line
   'b110: bit[511:0] hsize;
   'b111: bit[1023:0] hsize;
  endcase

  byte hburst;

  case(HBURST)
   'b000: hburst = 'SINGLE';
   'b001: hburst = 'INCR';
   'b010: hburst = 'WRAP4';
   'b011: hburst = 'INCR4';
   'b100: hburst = 'WRAP8';
   'b101: hburst = 'INCR8';
   'b110: hburst = 'WRAP16';
   'b111: hburst = 'INCR16';
  endcase

  always # 10 HCLK = ~HCLK;

  HADDR = 0x24;
  always (@posedge clk) HADDR += 0x4

 end

endmodule