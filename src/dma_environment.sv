class dma_env extends uvm_env;
  `uvm_component_utils(dma_env)

  dma_agent agt;
  reg_block reg_model;
  dma_adapter adapter;
  uvm_reg_predictor#(dma_seq_item) predictor_inst ;

 
  function new(string name = "dma_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    predictor_inst= uvm_reg_predictor#(dma_seq_item)::type_id::create("predictor_inst",this);
    agt = dma_agent::type_id::create("agt", this);
    agt.is_active = UVM_ACTIVE;

    reg_model = reg_block::type_id::create("reg_model", this);
    reg_model.build();

    adapter = dma_adapter::type_id::create("adapter", this);
 
   uvm_config_db#(reg_block)::set(this,
  "agt.sqr.*", "reg_model", reg_model);

reg_model.set_hdl_path_root("top.DUT");

  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    reg_model.default_map.set_sequencer(agt.sqr, adapter);

    predictor_inst.map     = reg_model.default_map;
    predictor_inst.adapter = adapter;

    agt.mon.mon_port.connect(predictor_inst.bus_in);
    //reg_model.default_map.set_base_addr('h400);
    reg_model.default_map.set_auto_predict(0);
   
	endfunction


endclass
