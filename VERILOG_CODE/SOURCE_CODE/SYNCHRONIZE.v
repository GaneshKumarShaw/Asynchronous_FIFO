`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module SYNCHRONIZE(ptr_out,
                   clk,
                   ptr_in,
                   rst);
parameter ADDRSIZE=4;
output reg[ADDRSIZE:0] ptr_out;
input clk,
      rst;
input[ADDRSIZE:0] ptr_in;
reg[ADDRSIZE:0] Q;
always @(posedge clk)
 if(rst)
  {ptr_out,Q}<= #3 0;
 else
  {ptr_out,Q}<= #3 {Q,ptr_in}; 
                   
endmodule
