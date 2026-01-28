class dma_driver extends uvm_driver #(dma_seq_item);
  `uvm_component_utils(dma_driver)

  virtual dma_interface vif;
  dma_seq_item req;

  function new(string name = "dma_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dma_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not set");
  endfunction

  virtual task run_phase(uvm_phase phase);
 //   repeat(1)@(vif.drv_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();  
    end
  endtask

  task drive(dma_seq_item tx);
    @(vif.drv_cb);
    vif.drv_cb.wr_en <= tx.wr_en;
    vif.drv_cb.rd_en <= tx.rd_en;
    vif.drv_cb.addr  <= tx.addr;
    if(tx.wr_en)
      vif.wdata <= tx.wdata;
    
    repeat(1) @(vif.drv_cb);
     if(tx.rd_en) 
     tx.rdata = vif.rdata;
     `uvm_info(get_type_name(),$sformatf("driving at %0t wr_en=%0d rd_en=%0d addr=%0h wdata=%h rdata=%h",$time,vif.wr_en,vif.rd_en,vif.addr,vif.wdata,vif.rdata),UVM_LOW);
   // `uvm_info(get_type_name(),$sformatf("driving at %0t wr_en=%0d rd_en=%0d addr=%0h wdata=%h rdata=%h",$time,vif.wr_en,vif.rd_en,vif.addr,vif.wdata,vif.rdata),UVM_LOW);
    
    repeat(3)@( vif.drv_cb);
  

    

   
  endtask

endclass
