class dma_adapter extends uvm_reg_adapter;
  `uvm_object_utils(dma_adapter)
  
  function new(string name="dma_adapter");
    super.new();
     provides_responses = 0;
  endfunction
  
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    dma_seq_item tr;
    tr=dma_seq_item::type_id::create("tr");
    tr.wr_en=(rw.kind==UVM_WRITE)?1:0;
    tr.rd_en=(rw.kind==UVM_WRITE)?0:1;
    tr.addr=rw.addr;
    if(tr.wr_en==1)tr.wdata=rw.data;
    else 
      tr.rdata=rw.data;
 //   `uvm_info("ADAPTER REG2BUS", $sformatf("reg2bus: kind=%s addr=%0h data=%0h",rw.kind.name(), rw.addr, rw.data), UVM_MEDIUM)
    return tr;
  endfunction
  
  function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
    dma_seq_item tr;
    assert($cast(tr,bus_item));
    
    rw.kind = tr.wr_en?UVM_WRITE:UVM_READ;
    rw.addr = tr.addr;
    if(rw.kind==UVM_WRITE)
    rw.data = tr.wdata;
	else
      rw.data=tr.rdata;
    rw.status = UVM_IS_OK;
   // `uvm_info("ADAPTER BUS2REG", $sformatf("bus2reg: kind=%s addr=%0h data=%0h status=%s",rw.kind.name(), rw.addr, rw.data,rw.status.name()), UVM_LOW)
  endfunction

  
endclass
