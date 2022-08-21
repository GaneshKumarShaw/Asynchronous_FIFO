`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module FIFO   (rdata,
              wclk,
              w_en,
              raddr,
              wdata,
              waddr);
parameter DATASIZE=8;
parameter ADDRSIZE=4;              
output[DATASIZE-1:0] rdata;
input wclk,
      w_en;
input[ADDRSIZE-1:0] waddr,
                    raddr;
input[DATASIZE-1:0] wdata;            

//MEMORY mem(
//  .a(waddr),
//  .d(rdata),
//  .dpra(raddr),
//  .clk(wclk),
//  .we(w_en),
//  .dpo(rdata)
//);


localparam DEPTH=1<<ADDRSIZE;
reg[DATASIZE-1:0] mem[0:DEPTH-1];          

always @(posedge wclk)
if(w_en)
 mem[waddr]<= #3 wdata;
 
assign rdata=mem[raddr]; 

endmodule
