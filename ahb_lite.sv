module ahb_lite#
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
 input bit HCLK,
 input HRESETn,
 input bit [HADDR_SIZE - 1:0]HADDR,
 input bit [2:0]HBURST, // 'b000 = SINGLE
                        // 'b001 = INCR
                        // 'b010 = WRAP4
                        // 'b011 = INCR4
                        // 'b100 = WRAP8
                        // 'b101 = INCR8
                        // 'b110 = WRAP16
                        // 'b111 = INCR16
 input HMASTLOCK,
 input [3:0]HPROT,
 input bit [2:0]HSIZE,  // 'b000 = bit [7:0]    transfer_size
                        // 'b001 = bit [15:0]   transfer_size
                        // 'b010 = bit [31:0]   transfer_size
                        // 'b011 = bit [63:0]   transfer_size
                        // 'b100 = bit [127:0]  transfer_size
                        // 'b101 = bit [255:0]  transfer_size
                        // 'b110 = bit [511:0]  transfer_size
                        // 'b111 = bit [1023:0] transfer_size
 input bit [1:0]HTRANS, // 'b00 = IDLE
                        // 'b01 = BUSY
                        // 'b10 = NONSEQ
                        // 'b11 = SEQ
 input [HDATA_SIZE - 1:0]HWDATA,
 input HWRITE,
 output reg [HDATA_SIZE - 1:0]HRDATA,
 output reg HREADYOUT,
 output HRESP,
 input HSEL,
 input HREADY
);

 always #10 HCLK = ~HCLK;

 initial begin

  HADDR = 8'h24;

  //Change in transfer type in case of IDLE transfer
  if(HTRANS == 'b00) begin //HTRANS = IDLE
   HTRANS = 'b10; //HTRANS = NONSEQ
   while(HREADY != 1)
    HTRANS = 'b10;
   HTRANS = 'b11;
  end

  //Change in transfer type in case of BUSY transfer, fixed length burst
  if(HTRANS == 'b01) begin //HTRANS = BUSY
   HTRANS = 'b11; //HTRANS = SEQ
   while(HREADY != 1)
    HTRANS = 'b11; //SEQ
   HTRANS = 'b11;
   if(HBURST == 'b000) //SINGLE
    $error("BUSY transfers must only be inserted between successive beats of a burst, this does not apply to SINGLE bursts");
  end

  //Change in transfer type in case of BUSY transfer, undefined length burst
  if(HTRANS == 'b01 && HBURST == 'b001) begin //HTRANS = BUSY and HBURST = INCR  
   HTRANS = 'b00 | HTRANS = 'b10 | HTRANS = 'b11; //HTRANS = IDLE or NONSEQ or SEQ
   if(HTRANS == 'b00 || HTRANS == 'b10) begin//HTRANS = IDLE or NONSEQ
    HBURST = 'b011;//INCR4
    while(HREADY != 1)
     HTRANS = 'b00 | HTRANS = 'b10; //IDLE or NONSEQ
   HTRANS = 'b11;
   end
   else
    HBURST = 'b001;//INCR (remains same)
  end

 end

endmodule
