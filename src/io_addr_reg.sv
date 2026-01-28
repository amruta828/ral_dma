class io_addr_reg extends uvm_reg;
  
  `uvm_object_utils(io_addr_reg)
  rand uvm_reg_field io_addr;
  
  covergroup io_addr_reg_cov;
    coverpoint io_addr.value;
  endgroup

  function new(string name="io_addr_reg");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if(has_coverage(	UVM_CVR_FIELD_VALS))
      io_addr_reg_cov=new();
  endfunction
virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    io_addr_reg_cov.sample();
  endfunction
  
  virtual function void sample_values();
    super.sample_values();
    io_addr_reg_cov.sample();
  endfunction
  
  function  build();
    io_addr = uvm_reg_field::type_id::create("io_addr");
    io_addr.configure(
      .parent(this),
      .size(32),
      .lsb_pos(0),
      .access("RW"),
      .volatile(0),
      .reset(32'b0),
      .has_reset(1),
      .is_rand(1),
      .individually_accessible(1)
    );
  endfunction
endclass
