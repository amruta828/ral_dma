class dma_test extends uvm_test;
  `uvm_component_utils(dma_test)
  
  dma_env env;
  reg_sequence seq;
  
  function new(string name = "dma_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_env::type_id::create("env", this);
    
  endfunction
  
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      seq = reg_sequence::type_id::create("seq");
      seq.reg_model = env.reg_model;
      seq.start(env.agt.sqr);
      phase.drop_objection(this);
  endtask
endclass
