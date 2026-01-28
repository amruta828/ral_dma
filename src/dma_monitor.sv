class dma_monitor extends uvm_monitor;
  `uvm_component_utils(dma_monitor )

  uvm_analysis_port#(dma_seq_item) mon_port;

   virtual dma_interface vif;

   function new( string name, uvm_component parent );
      super.new( name, parent );
   endfunction: new

   function void build_phase( uvm_phase phase );
      super.build_phase( phase );
     mon_port = new("mon_port", this);
     if (!uvm_config_db#(virtual dma_interface)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface vif not set")
   endfunction

   task run_phase( uvm_phase phase );
     dma_seq_item tx;
     repeat(1)@(vif.mon_cb);
      forever begin 
        
        tx = dma_seq_item::type_id::create("tx");
        repeat(2)@(vif.mon_cb);
         tx.wr_en = vif.mon_cb.wr_en;
  		 tx.rd_en = vif.mon_cb.rd_en;  
  		 tx.addr = vif.mon_cb.addr;
  		 tx.wdata = vif.mon_cb.wdata;
 		 tx.rdata = vif.mon_cb.rdata;
        `uvm_info(get_type_name(),$sformatf("capturing at %0t wr_en=%0d rd_en=%0d addr=%0h wdata=%h rdata=%h",$time,vif.wr_en,vif.rd_en,vif.addr,vif.wdata,vif.rdata),UVM_LOW);
        repeat(2)@(vif.mon_cb);
        mon_port.write(tx);
        //repeat(2)@(vif.mon_cb);
        
      end
   endtask
endclass
