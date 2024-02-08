
class mem_driver extends uvm_driver # (mem_sequence_item);

    `uvm_component_utils(mem_driver)

    virtual interface mem_if vif;

    mem_sequence_item sequence_item_h;

    function new(string name = "mem_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_driver", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_driver", "build phase", UVM_HIGH)
        if(!uvm_config_db # (virtual interface mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("mem_driver", "run phase", UVM_HIGH)
        forever begin
            seq_item_port.get_next_item(sequence_item_h);
            sequence_item_h.display_in("mem_driver    ");
            drive();
            seq_item_port.item_done();
        end
    endtask: run_phase

    task drive;
        vif.rst_n <= sequence_item_h.rst_n;
        vif.wr_en <= sequence_item_h.wr_en;
        vif.data_in <= sequence_item_h.data_in;
        vif.address <= sequence_item_h.address;
        @ (posedge vif.clk);
        vif.rst_n <= sequence_item_h.rst_n;
        vif.wr_en <= sequence_item_h.wr_en;
        vif.data_in <= sequence_item_h.data_in;
        vif.address <= sequence_item_h.address;
    endtask: drive

endclass: mem_driver
