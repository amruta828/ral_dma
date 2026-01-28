`include "uvm_macros.svh"

package dma_pkg;
  import uvm_pkg::*;

  `include "dma_seq_item.sv"
  `include "intr_reg.sv"
  `include "cntrl_reg.sv"
  `include "io_addr_reg.sv"
  `include "mem_addr_reg.sv"
  `include "extra_info_reg.sv"
  `include "status_reg.sv"
  `include "transfer_count_reg.sv"
  `include "descriptor_addr_reg.sv"
  `include "error_status_reg.sv"
  `include "config_reg.sv"
  `include "reg_block.sv"
  `include "adapter.sv"
  `include "dma_sequencer.sv"
  `include "dma_driver.sv"
  `include "dma_monitor.sv"
  `include "dma_agent.sv"
  `include "sequence.sv"
  `include "dma_environment.sv"
  `include "dma_test.sv"

endpackage
