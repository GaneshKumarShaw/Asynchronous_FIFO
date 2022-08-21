`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_TOP_MODULE;
parameter ADDRSIZE=4;
parameter DATASIZE=8;
wire[DATASIZE-1:0] tb_rdata;
wire tb_empty,
     tb_full;
reg[DATASIZE-1:0] tb_wdata;
reg tb_wclk,
    tb_winc,
    tb_w_rst,
    tb_rclk,
    tb_rinc,
    tb_r_rst; 
integer i;    
TOP_MODULE dut(.rdata(tb_rdata),
                  .empty(tb_empty),
                  .full(tb_full),
                  .wclk(tb_wclk),
                  .winc(tb_winc),
                  .w_rst(tb_w_rst),
                  .rclk(tb_rclk),
                  .rinc(tb_rinc),
                  .r_rst(tb_r_rst),
                  .wdata(tb_wdata));
initial 
begin
tb_wclk=1'b0;
tb_rclk=1'b0;
end   

always #10 tb_wclk=~tb_wclk;
always #5 tb_rclk=~tb_rclk;

initial 
begin
 $monitor($time,"tb_rdata=%b",tb_rdata);
 tb_w_rst=1'b1; tb_r_rst=1'b1; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b1; tb_r_rst=1'b1; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 #8 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd10;
 #12 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd15;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd20;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd25;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd30;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd35;
 #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b0; tb_wdata=8'd40;
  #10 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b0; tb_rinc=1'b0; tb_wdata=8'd0;
 for(i=1;i<=50;i=i+1) 
 begin
 #20 tb_w_rst=1'b0; tb_r_rst=1'b0; tb_winc=1'b1; tb_rinc=1'b1; tb_wdata=($random)%64;
 end
 #100 $finish;
end               
endmodule
