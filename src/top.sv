`include "design.sv"
`include "dma_interface.sv"
`include "dma_pkg.sv"

import uvm_pkg::*;
import dma_pkg::*;

module tb;

  bit clk;
  bit rst_n;

  initial clk = 0;
  always #5 clk = ~clk;
  
  

  dma_interface vif(clk, rst_n);

  dma_design dut(.clk(clk), .rst_n(rst_n), .addr(vif.addr), .wr_en(vif.wr_en), .rd_en(vif.rd_en), .wdata(vif.wdata), .rdata(vif.rdata));

  

  initial begin
    rst_n=0;
    #5 rst_n=1;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
     uvm_config_db#(virtual dma_interface)::set(null, "*", "vif", vif);
    run_test("dma_test");
  end

 

endmodule
