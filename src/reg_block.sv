class reg_block extends uvm_reg_block;
  `uvm_object_utils(reg_block)
  
  rand intr_reg intr_reg_inst;
  rand cntrl_reg cntrl_reg_inst;
  rand io_addr_reg io_addr_reg_inst;
  rand mem_addr_reg mem_addr_reg_inst;
  rand extra_info_reg extra_info_reg_inst;
  rand status_reg status_reg_inst;
  rand transfer_count_reg transfer_count_reg_inst;
  rand descriptor_addr_reg descriptor_addr_reg_inst;
  rand error_status_reg error_status_reg_inst;
  rand config_reg config_reg_inst;
  
  function new(string name="dma_reg_block");
    super.new(name,build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  function void build;
     add_hdl_path("dut","RTL");
    uvm_reg::include_coverage("*",UVM_CVR_ALL);
    
    intr_reg_inst=intr_reg::type_id::create("intr_reg_inst");
    intr_reg_inst.build();
    intr_reg_inst.configure(this);
    intr_reg_inst.add_hdl_path_slice("intr_status",0,16);
    intr_reg_inst.add_hdl_path_slice("intr_mask",16,16);
    intr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    
    cntrl_reg_inst=cntrl_reg::type_id::create("cntrl_reg_inst");
    cntrl_reg_inst.build();
    cntrl_reg_inst.configure(this);
    cntrl_reg_inst.add_hdl_path_slice("ctrl_start_dma",0,1);
    cntrl_reg_inst.add_hdl_path_slice("ctrl_w_count",1,15);
    cntrl_reg_inst.add_hdl_path_slice("ctrl_io_mem",15,1);
    cntrl_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    io_addr_reg_inst=io_addr_reg::type_id::create("io_addr_reg_inst");
    io_addr_reg_inst.build();
    io_addr_reg_inst.configure(this);
    io_addr_reg_inst.add_hdl_path_slice("io_addr",0,32);
    io_addr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    mem_addr_reg_inst=mem_addr_reg::type_id::create("mem_addr_reg_inst");
    mem_addr_reg_inst.build();
    mem_addr_reg_inst.configure(this);
    mem_addr_reg_inst.add_hdl_path_slice("mem_addr",0,32);
    mem_addr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    extra_info_reg_inst=extra_info_reg::type_id::create("extra_info_reg_inst");
    extra_info_reg_inst.build();
    extra_info_reg_inst.configure(this);
    extra_info_reg_inst.add_hdl_path_slice("extra_info",0,32);
    extra_info_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    status_reg_inst=status_reg::type_id::create("status_reg_inst");
    status_reg_inst.build();
    status_reg_inst.configure(this);
    status_reg_inst.add_hdl_path_slice("status_busy",0,1);
    status_reg_inst.add_hdl_path_slice("status_done",1,1);
    status_reg_inst.add_hdl_path_slice("status_error",2,1);
    status_reg_inst.add_hdl_path_slice("status_paused",3,1);
    status_reg_inst.add_hdl_path_slice("status_current_state",4,4);
    status_reg_inst.add_hdl_path_slice("status_fifo_level",8,8);
   
    status_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    transfer_count_reg_inst=transfer_count_reg::type_id::create("transfer_count_reg_inst");
    transfer_count_reg_inst.build();
    transfer_count_reg_inst.configure(this);
    transfer_count_reg_inst.add_hdl_path_slice("transfer_count",0,32);
    transfer_count_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    descriptor_addr_reg_inst=descriptor_addr_reg::type_id::create("descriptor_addr_reg_inst");
    descriptor_addr_reg_inst.build();
    descriptor_addr_reg_inst.configure(this);
    descriptor_addr_reg_inst.add_hdl_path_slice("descriptor_addr",0,32);
    descriptor_addr_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    error_status_reg_inst=error_status_reg::type_id::create("bus_error",);
    error_status_reg_inst.build();
    error_status_reg_inst.configure(this);
    error_status_reg_inst.add_hdl_path_slice("error_bus",          0, 1);
    error_status_reg_inst.add_hdl_path_slice("error_timeout",      1, 1);
    error_status_reg_inst.add_hdl_path_slice("error_alignment",    2, 1);
    error_status_reg_inst.add_hdl_path_slice("error_overflow",     3, 1);
    error_status_reg_inst.add_hdl_path_slice("error_underflow",    4, 1);
    error_status_reg_inst.add_hdl_path_slice("error_code",         8, 8);
    error_status_reg_inst.add_hdl_path_slice("error_addr_offset", 16, 16);
    
    error_status_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    config_reg_inst=config_reg::type_id::create("config_reg_inst");
    config_reg_inst.build();
    config_reg_inst.configure(this);
    config_reg_inst.add_hdl_path_slice("config_priority",         0, 2);
    config_reg_inst.add_hdl_path_slice("config_auto_restart",     2, 1);
    config_reg_inst.add_hdl_path_slice("config_interrupt_enable", 3, 1);
    config_reg_inst.add_hdl_path_slice("config_burst_size",       4, 2);
    config_reg_inst.add_hdl_path_slice("config_data_width",       6, 2);
    config_reg_inst.add_hdl_path_slice("config_descriptor_mode",  8, 1);
    
    config_reg_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    default_map=create_map("default_map",'h0,4,UVM_LITTLE_ENDIAN);
    
    default_map.add_reg(intr_reg_inst,'h400,"RW");
    default_map.add_reg(cntrl_reg_inst,'h404,"RW");
    default_map.add_reg(io_addr_reg_inst,'h408,"RW");
    default_map.add_reg(mem_addr_reg_inst,'h40C,"RW");
    default_map.add_reg(extra_info_reg_inst,'h410,"RW");
    default_map.add_reg(status_reg_inst,'h414,"RO");
    default_map.add_reg(transfer_count_reg_inst,'h418,"RO");
    default_map.add_reg(descriptor_addr_reg_inst,'h41C,"RW");
    default_map.add_reg(error_status_reg_inst,'h420,"RO");
    default_map.add_reg(config_reg_inst,'h424,"RW");
    
    default_map.set_auto_predict(0);
    lock_model();
  endfunction
endclass
    
    
    
    
    
    
    
    
    
    
    
    
  
