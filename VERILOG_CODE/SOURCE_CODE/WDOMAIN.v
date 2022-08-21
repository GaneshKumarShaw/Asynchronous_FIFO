`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module WDOMAIN(full,
               w_en,
               waddr,
               wptr,
               wclk,
               winc,
               w_rst,
               s_rptr);
parameter ADDRSIZE=4;
parameter DATASIZE=8;
output reg full;
output     w_en;
output[ADDRSIZE-1:0] waddr;
output reg[ADDRSIZE:0] wptr;
input wclk,
      winc,
      w_rst;
input[ADDRSIZE:0] s_rptr;
reg [ADDRSIZE:0] wbin;
wire[ADDRSIZE:0] wbnext,
                 wgnext;
wire full_val;                 
assign wbnext=wbin+(winc & ~full);
assign wgnext=(wbnext>>1)^ wbnext;
assign full_val= (wgnext== {~s_rptr[ADDRSIZE:ADDRSIZE-1],s_rptr[ADDRSIZE-2:0]}); 
always @(posedge wclk)
 if(w_rst)
  begin
   wbin<= #3 0;
   wptr<= #3 0;
  end
 else
  begin
   wbin<= #3 wbnext;
   wptr<= #3 wgnext;
  end  
  
// output declaration 
assign waddr=wbin[ADDRSIZE-1:0];
always @(posedge wclk)
 begin
  if(w_rst)
   full<= #3 0;
  else
   full<= #3 full_val;
 end 
assign w_en= (winc & ~full);   // CHECK            
endmodule
