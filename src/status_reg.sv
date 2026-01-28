class status_reg extends uvm_reg;
  `uvm_object_utils(status_reg)
 
 uvm_reg_field busy;
 uvm_reg_field done;
 uvm_reg_field error;
 uvm_reg_field paused;
 uvm_reg_field current_state;
 uvm_reg_field fifo_level;
 uvm_reg_field reserved;
  
    covergroup status_reg_cov;
    coverpoint busy.value;
      coverpoint done.value;
      coverpoint error.value;
      coverpoint paused.value;
      coverpoint current_state.value;
      coverpoint fifo_level.value;
  endgroup
  
 
function new(string name="extra_info");
super.new(name,32,UVM_CVR_FIELD_VALS);
  if(has_coverage(	UVM_CVR_FIELD_VALS))
      status_reg_cov=new();
endfunction
  
  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    status_reg_cov.sample();
  endfunction
  
  virtual function void sample_values();
    super.sample_values();
    status_reg_cov.sample();
  endfunction
  

 
function  build;
busy=uvm_reg_field::type_id::create("busy");
done=uvm_reg_field::type_id::create("done");
error=uvm_reg_field::type_id::create("error");
paused=uvm_reg_field::type_id::create("paused");
current_state=uvm_reg_field::type_id::create("current_state");
fifo_level=uvm_reg_field::type_id::create("fifo_level");
reserved=uvm_reg_field::type_id::create("reserved");
 
 
busy.configure(.parent(this),
               .size(1),
               .lsb_pos(0),
               .access("RO"),
               .volatile(1),
               .reset(1'b0),
               .has_reset(1),
               .is_rand(0),
               .individually_accessible(1));
 
done.configure(.parent(this),
               .size(1),
               .lsb_pos(1),
               .access("RO"),
               .volatile(1),
               .reset(1'b0),
               .has_reset(1),
               .is_rand(0),
               .individually_accessible(1));
 
error.configure(.parent(this),
                .size(1),
                .lsb_pos(2),
                .access("RO"),
                .volatile(1),
                .reset(1'b0),
                .has_reset(1),
                .is_rand(0),
                .individually_accessible(1));
 
paused.configure(.parent(this),
                 .size(1),
                 .lsb_pos(3),
                 .access("RO"),
                 .volatile(1),
                 .reset(1'b0),
                 .has_reset(1),
                 .is_rand(0),
                 .individually_accessible(1));
 
current_state.configure(.parent(this),
                        .size(4),
                        .lsb_pos(4),
                        .access("RO"),
                        .volatile(1),
                        .reset(4'b0),
                        .has_reset(1),
                        .is_rand(0),
                        .individually_accessible(1));
 
fifo_level.configure(.parent(this),
                     .size(8),
                     .lsb_pos(8),
                     .access("RO"),
                     .volatile(1),
                     .reset(4'b0),
                     .has_reset(1),
                     .is_rand(0),
                     .individually_accessible(1));
 
reserved.configure(.parent(this),
                   .size(16),
                   .lsb_pos(16),
                   .access("RO"),
                   .volatile(1),
                   .reset(1'b0),
                   .has_reset(1),
                   .is_rand(0),
                   .individually_accessible(1));
 
 
endfunction
 
endclass

 
