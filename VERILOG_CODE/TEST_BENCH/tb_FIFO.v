`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_FIFO;
parameter DATASIZE=8;
parameter ADDRSIZE=4;
wire[DATASIZE-1:0] tb_rdata;
reg[DATASIZE-1:0] tb_wdata;
reg[ADDRSIZE-1:0] tb_waddr,tb_raddr;
reg tb_w_en,
    tb_wclk;
FIFO  fifo   (.rdata(tb_rdata),
              .wclk(tb_wclk),
              .w_en(tb_w_en),
              .raddr(tb_raddr),
              .wdata(tb_wdata),
              .waddr(tb_waddr));
initial tb_wclk=1'b0;
always #5 tb_wclk=~tb_wclk;  

initial 
begin
$monitor($time,"tb_rdata=%b",tb_rdata);
tb_w_en=1'b1;tb_wdata=8'd5;tb_waddr=4'd0;tb_raddr=4'b0;
# 10 tb_w_en=1'b1;tb_wdata=8'd10;tb_waddr=4'd1;tb_raddr=4'd0;
# 10 tb_w_en=1'b1;tb_wdata=8'd15;tb_waddr=4'd2;tb_raddr=4'd0;
# 10 tb_w_en=1'b1;tb_wdata=8'd20;tb_waddr=4'd3;tb_raddr=4'd2;
# 10 tb_w_en=1'b1;tb_wdata=8'd25;tb_waddr=4'd4;tb_raddr=4'd2;
#10 $finish;
 
end            
endmodule


