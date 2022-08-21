`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module TOP_MODULE(rdata,
                  empty,
                  full,
                  wclk,
                  winc,
                  w_rst,
                  rclk,
                  rinc,
                  r_rst,
                  wdata);
parameter DATASIZE=8;
parameter ADDRSIZE=4;
output[DATASIZE-1:0] rdata;
output empty,
       full;
input[DATASIZE-1:0] wdata;
input wclk,
      winc,
      w_rst,
      rclk,
      rinc,
      r_rst;
// fifo wire delcaration 
wire[DATASIZE-1:0] fifo_rdata,
                   fifo_wdata;
wire fifo_wclk,
     fifo_w_en;
wire[ADDRSIZE-1:0] fifo_raddr,
                   fifo_waddr;
// wirte domain wire declaration 
wire wd_full,
     wd_w_en,
     wd_wclk,
     wd_winc,
     wd_w_rst;
wire[ADDRSIZE-1:0] wd_waddr;
wire[ADDRSIZE:0] wd_wptr,
                 wd_s_rptr;                   
// Read domain wire declaration 
wire rd_empty,
     rd_rclk,
     rd_rinc,
     rd_r_rst; 
wire[ADDRSIZE-1:0] rd_raddr;
wire[ADDRSIZE:0] rd_rptr,
                 rd_s_wptr;  
// read synchronise wire declaration 
wire rs_clk,
     rs_rst;
wire[ADDRSIZE:0] rs_output,
                 rs_input;  
// read synchronise wire declaration 
wire ws_clk,
     ws_rst;
wire[ADDRSIZE:0] ws_output,
                 ws_input;                                                                                
// fifo instantiation 
FIFO  fifo(.rdata(fifo_rdata),
              .wclk(fifo_wclk),
              .w_en(fifo_w_en),
              .raddr(fifo_raddr),
              .wdata(fifo_wdata),
              .waddr(fifo_waddr));  
assign fifo_wclk=wclk;
assign fifo_w_en=wd_w_en; 
assign fifo_raddr=rd_raddr;
assign fifo_wdata=wdata;
assign fifo_waddr=wd_waddr;


// write domain instantiation 
WDOMAIN wd(.full(wd_full),
               .w_en(wd_w_en),
               .waddr(wd_waddr),
               .wptr(wd_wptr),
               .wclk(wd_wclk),
               .winc(wd_winc),
               .w_rst(wd_w_rst),
               .s_rptr(wd_s_rptr));
assign wd_wclk=wclk;
assign wd_winc=winc;
assign wd_w_rst=w_rst;
assign wd_s_rptr=rs_output;

// Read domain instantiatio 
RDOMAIN rd(.empty(rd_empty),
               .raddr(rd_raddr),
               .rptr(rd_rptr),
               .rclk(rd_rclk),
               .rinc(rd_rinc),
               .r_rst(rd_r_rst),
               .s_wptr(rd_s_wptr)); 
assign rd_rclk=rclk;
assign rd_rinc=rinc;
assign rd_r_rst=r_rst;
assign rd_s_wptr=ws_output;


// read synchronise instantiation 
SYNCHRONIZE rs(.ptr_out(rs_output),
                   .clk(rs_clk),
                   .ptr_in(rs_input),
                   .rst(rs_rst));
assign rs_clk=wclk;
assign rs_rst=w_rst;
assign rs_input=rd_rptr;    

  
// write synchronise instantiation 
SYNCHRONIZE ws(.ptr_out(ws_output),
                   .clk(ws_clk),
                   .ptr_in(ws_input),
                   .rst(ws_rst));
assign ws_clk=rclk;
assign ws_rst=r_rst;
assign ws_input=wd_wptr;                  
// output declaration 
assign rdata=fifo_rdata;
assign empty=rd_empty;
assign full=wd_full;                                                
endmodule
