module assertions(ahb_lite intf);

 assert property(@(posedge intf.HCLK) !intf.HRESP && intf.HREADY |-> intf.HTRANS == 'b11);

 assert property(@(posedge intf.HCLK) !intf.HRESP && !intf.HREADY |-> intf.HTRANS == 'b10);

 assert property(@(posedge intf.HCLK) intf.HRESP && !intf.HREADY |-> ##1 !intf.HREADY ##2 intf.HRESP == 'b00);

endmodule