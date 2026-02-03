class reg_sequence extends uvm_sequence #(uvm_reg_item);
  `uvm_object_utils(reg_sequence)

  reg_block reg_model;
  uvm_status_e status;
  uvm_reg_data_t data;
  uvm_reg_data_t des;
  uvm_reg_data_t mir;
  uvm_reg_data_t read_d;
  uvm_reg_data_t rst_n;

  function new(string name = "reg_sequence");
    super.new(name);
  endfunction

  task body();

    if (reg_model == null)`uvm_fatal(get_type_name(), "reg_model is null")
$display("==================INTR REG===============");
      reg_model.intr_reg_inst.write(status, 32'hFFFF_FFFF);
    des = reg_model.intr_reg_inst.get();
    mir = reg_model.intr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.intr_reg_inst.read(status, read_d);
    des = reg_model.intr_reg_inst.get();
    mir = reg_model.intr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("INTR FRONTDOOR read des= 0x%0h mir= 0x%0h rdata = 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on interrupt register");
    rst_n=reg_model.intr_reg_inst.get_reset();
    reg_model.intr_reg_inst.reset();     //to reset the register
    des=reg_model.intr_reg_inst.get();
    mir=reg_model.intr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("INTR RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)




    reg_model.intr_reg_inst.write(status,32'hFFFF_0000,UVM_BACKDOOR);

    des=reg_model.intr_reg_inst.get();
    mir=reg_model.intr_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("INTR BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("BACKDOOR read from interrupt register");
    reg_model.intr_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.intr_reg_inst.get();
    mir=reg_model.intr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("INTR BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)

    $display("===========CNTRL REG================");
    reg_model.cntrl_reg_inst.write(status, 32'h0000_0001);
    des = reg_model.cntrl_reg_inst.get();
    mir = reg_model.cntrl_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.cntrl_reg_inst.read(status, read_d);
    des = reg_model.cntrl_reg_inst.get();
    mir = reg_model.cntrl_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CTRL FRONTDOOR read des= 0x%0h mir= 0x%0h rdata 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.cntrl_reg_inst.get_reset();
    reg_model.cntrl_reg_inst.reset();     //to reset the register
    des=reg_model.cntrl_reg_inst.get();
    mir=reg_model.cntrl_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("CNTRL RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)



    reg_model.cntrl_reg_inst.write(status,32'hFFFF_0000,UVM_BACKDOOR);

    des=reg_model.cntrl_reg_inst.get();
    mir=reg_model.cntrl_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("CNTRL BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("BACKDOOR read from control register");
    reg_model.cntrl_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.cntrl_reg_inst.get();
    mir=reg_model.cntrl_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("CNTRL BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)

    $display("============IO_ADDR===============");
    reg_model.io_addr_reg_inst.write(status, 32'hA5A5_A5A5);
    des = reg_model.io_addr_reg_inst.get();
    mir = reg_model.io_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.io_addr_reg_inst.read(status, read_d);
    des = reg_model.io_addr_reg_inst.get();
    mir = reg_model.io_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("IO_ADDR FRONTDOOR read  des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

     $display("RESET check on control register");
    rst_n=reg_model.io_addr_reg_inst.get_reset();
    reg_model.io_addr_reg_inst.reset();     //to reset the register
    des=reg_model.io_addr_reg_inst.get();
    mir=reg_model.io_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("IO_ADDR RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)



    reg_model.io_addr_reg_inst.write(status,32'hF00F_0000,UVM_BACKDOOR);

    des=reg_model.io_addr_reg_inst.get();
    mir=reg_model.io_addr_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("IO_ADDR BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("BACKDOOR read from io_addr register");
    reg_model.io_addr_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.io_addr_reg_inst.get();
    mir=reg_model.io_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("IO_ADDR BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)


    $display("============MEM_ADDR===============");
    reg_model.mem_addr_reg_inst.write(status, 32'h1234_5678);
    des = reg_model.mem_addr_reg_inst.get();
    mir = reg_model.mem_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.mem_addr_reg_inst.read(status, read_d);
    des = reg_model.mem_addr_reg_inst.get();
    mir = reg_model.mem_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("MEM_ADDR FRONTDOOR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.mem_addr_reg_inst.get_reset();
    reg_model.mem_addr_reg_inst.reset();     //to reset the register
    des=reg_model.mem_addr_reg_inst.get();
    mir=reg_model.mem_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("MEM_ADDR RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)


    //$display("BACKDOOR write to mem_addr register");

    reg_model.mem_addr_reg_inst.write(status,32'hF00F_FF00,UVM_BACKDOOR);

    des=reg_model.mem_addr_reg_inst.get();
    mir=reg_model.mem_addr_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("MEM_ADDR BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    reg_model.mem_addr_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.mem_addr_reg_inst.get();
    mir=reg_model.mem_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("MEM_ADDR BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)



  $display("======EXTRA_INFO=====================");

     reg_model.extra_info_reg_inst.write(status, 32'h1234_5678);
    des = reg_model.extra_info_reg_inst.get();
    mir = reg_model.extra_info_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA INFO FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.extra_info_reg_inst.read(status, read_d);
    des = reg_model.extra_info_reg_inst.get();
    mir = reg_model.extra_info_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("EXTRA INFO FRONTDOOR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.extra_info_reg_inst.get_reset();
    reg_model.extra_info_reg_inst.reset();     //to reset the register
    des=reg_model.extra_info_reg_inst.get();
    mir=reg_model.extra_info_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("EXTRA INFO RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)


    $display("BACKDOOR write to extra_info register");

    reg_model.extra_info_reg_inst.write(status,32'hF00F_AB10,UVM_BACKDOOR);

    des=reg_model.extra_info_reg_inst.get();
    mir=reg_model.extra_info_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("EXTRA INFO BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("BACKDOOR read from mem_addr register");
    reg_model.extra_info_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.extra_info_reg_inst.get();
    mir=reg_model.extra_info_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("EXTRA INFO BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)


         $display("========STATUS_REG===================");

     reg_model.status_reg_inst.write(status, 32'h1234_5678);
    des = reg_model.status_reg_inst.get();
    mir = reg_model.status_reg_inst.get_mirrored_value();
     mir=reg_model.status_reg_inst.get_mirrored_value();



    reg_model.status_reg_inst.read(status, read_d);
    des = reg_model.status_reg_inst.get();
    mir = reg_model.status_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("STATUS FRONTDOOR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.status_reg_inst.get_reset();
    reg_model.status_reg_inst.reset();     //to reset the register
    des=reg_model.status_reg_inst.get();
    mir=reg_model.status_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("STATUS RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)


    $display("BACKDOOR write to status register");

    reg_model.status_reg_inst.write(status,32'hF00F_AB10,UVM_BACKDOOR);

    des=reg_model.status_reg_inst.get();
    mir=reg_model.status_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("STATUS BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("BACKDOOR read from status register");
    reg_model.status_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.status_reg_inst.get();
    mir=reg_model.status_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("STATUS BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)



    $display("=========TRANSFER_COUNT==================");

    reg_model.transfer_count_reg_inst.write(status, 32'h1234_5678);
    des = reg_model.transfer_count_reg_inst.get();
    mir = reg_model.transfer_count_reg_inst.get_mirrored_value();
     mir=reg_model.transfer_count_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS1", $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)

    `uvm_info(get_type_name(),$sformatf("TRANSFER COUNT FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.transfer_count_reg_inst.read(status, read_d);
    des = reg_model.transfer_count_reg_inst.get();
    mir = reg_model.transfer_count_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("TRANSFER COUNT FRONTDOOR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.transfer_count_reg_inst.get_reset();
    reg_model.transfer_count_reg_inst.reset();     //to reset the register
    des=reg_model.transfer_count_reg_inst.get();
    mir=reg_model.transfer_count_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("TRANSFER COUNT RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)


   

    reg_model.transfer_count_reg_inst.write(status,32'hF00F_AB10,UVM_BACKDOOR);

    des=reg_model.transfer_count_reg_inst.get();
    mir=reg_model.transfer_count_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("TRNSFER COUNT BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("TRANSFER COUNT read from status register");
    reg_model.transfer_count_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.transfer_count_reg_inst.get();
    mir=reg_model.transfer_count_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("TRANSFER COUNT BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)

      $display("=============DESCRIPTOR_ADDR==============");

    reg_model.descriptor_addr_reg_inst.write(status, 32'h1234_5678);
    des = reg_model.descriptor_addr_reg_inst.get();
    mir = reg_model.descriptor_addr_reg_inst.get_mirrored_value();
     mir=reg_model.descriptor_addr_reg_inst.get_mirrored_value();


    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR ADDR FRONTDOOR write des= 0x%0h mir= 0x%0h", des, mir),UVM_NONE)

    reg_model.descriptor_addr_reg_inst.read(status, read_d);
    des = reg_model.descriptor_addr_reg_inst.get();
    mir = reg_model.descriptor_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("DESCRIPTOR ADDR  FRONTDOOR READ des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)

    $display("RESET check on control register");
    rst_n=reg_model.descriptor_addr_reg_inst.get_reset();
    reg_model.descriptor_addr_reg_inst.reset();     //to reset the register
    des=reg_model.descriptor_addr_reg_inst.get();
    mir=reg_model.descriptor_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("DESCRIPTOR ADDR RESET values Des=%0h |Mir=%0h",des,mir),UVM_NONE)


   
    reg_model.descriptor_addr_reg_inst.write(status,32'hF00F_AB10,UVM_BACKDOOR);

    des=reg_model.descriptor_addr_reg_inst.get();
    mir=reg_model.descriptor_addr_reg_inst.get_mirrored_value();
    `uvm_info("REG_STATUS",
              $sformatf("WRITE status = %s %h", status.name(),des),
  UVM_LOW)
    `uvm_info(get_full_name(),$sformatf("DESCRIPTOR ADDR BACKDOOR WRITE VALUES VIA BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)

    $display("DESCRIPTOR ADDR read from status register");
    reg_model.descriptor_addr_reg_inst.read(status,read_d,UVM_BACKDOOR);
    des=reg_model.descriptor_addr_reg_inst.get();
    mir=reg_model.descriptor_addr_reg_inst.get_mirrored_value();
    `uvm_info(get_full_name(),$sformatf("DESCRIPTOR ADDR BACKDOOR READ VALUES VIA BACKDOOR Des=%0h |Mir=%0h | Rdata=%0h",des,mir,read_d),UVM_NONE)

     $display("========ERROR_STATUS===================");


    reg_model.error_status_reg_inst.write(status, 32'h0000_000F);
    des = reg_model.error_status_reg_inst.get();
    mir = reg_model.error_status_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS FRONTDOOR write des= 0x%0h mir= 0x%0h",des, mir),UVM_NONE)

    reg_model.error_status_reg_inst.poke(status,32'h001F_001F);
         des=reg_model.error_status_reg_inst.get();
         mir=reg_model.error_status_reg_inst.get_mirrored_value();
         `uvm_info(get_full_name(),$sformatf("ERROR_STATUS BACKDOOR WRITE VALUES BACKDOOR Des=%0h |Mir=%0h",des,mir),UVM_NONE)


    reg_model.error_status_reg_inst.read(status, read_d);
    des = reg_model.error_status_reg_inst.get();
    mir = reg_model.error_status_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("ERROR_STATUS FRONTDOOR read  des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)


    $display("=============CONFIG_REG==============");
    reg_model.config_reg_inst.write(status, 32'h0000_01AF);
    des = reg_model.config_reg_inst.get();
    mir = reg_model.config_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIG FRONTDOOR write des= 0x%0h mir= 0x%0h",des, mir),UVM_NONE)

    reg_model.config_reg_inst.read(status, read_d);
    des = reg_model.config_reg_inst.get();
    mir = reg_model.config_reg_inst.get_mirrored_value();
    `uvm_info(get_type_name(),$sformatf("CONFIG FRONTDOOR read des= 0x%0h mir= 0x%0h rdata= 0x%0h",des, mir, read_d),UVM_NONE)



  endtask

endclass
