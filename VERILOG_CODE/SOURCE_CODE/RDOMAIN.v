`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module RDOMAIN(empty,
               raddr,
               rptr,
               rclk,
               rinc,
               r_rst,
               s_wptr); 
parameter DATASIZE=8;
parameter ADDRSIZE=4;
output reg empty;
output[ADDRSIZE-1:0] raddr;
output reg[ADDRSIZE:0] rptr; 
input rclk,
      rinc,
      r_rst;
input[ADDRSIZE:0] s_wptr;
wire[ADDRSIZE:0] rbnext,
                 rgnext;
wire empty_val;                 
reg[ADDRSIZE:0] rbin;                 
assign rbnext=rbin+(rinc & ~empty);
always @(posedge rclk)
begin
 if(r_rst)
  begin
   rbin<= #3 0;
   rptr<= #3 0;
  end
 else
  begin
   rbin<= #3 rbnext;
   rptr<= #3 rgnext;
  end
end 

assign empty_val=(rgnext == s_wptr);    /// rst problem 
assign rgnext=(rbnext>>1)^rbnext;       
// output declaration  
assign raddr=rbin[ADDRSIZE-1:0];

always @(posedge rclk)
if(r_rst)
 empty<= #3 1'b1;
else
 empty<= #3 empty_val;
      
endmodule
