
class mem_monitor extends uvm_monitor;

    `uvm_component_utils(mem_monitor)

    virtual interface mem_if vif;

    mem_sequence_item sequence_item_h;

    uvm_analysis_port # (mem_sequence_item) mem_analysis_port;

    function new(string name = "mem_monitor", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_monitor", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_monitor", "build phase", UVM_HIGH)
        sequence_item_h = mem_sequence_item::type_id::create("sequence_item_h");
        if(!uvm_config_db # (virtual interface mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
        mem_analysis_port = new("mem_analysis_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("mem_monitor", "run phase", UVM_HIGH)
        forever begin
            monitor();
            mem_analysis_port.write(sequence_item_h);
            sequence_item_h.display_out("mem_monitor   ");
        end
    endtask: run_phase

    task monitor;
        @ (negedge vif.clk);
        sequence_item_h.rst_n = vif.rst_n;
        sequence_item_h.wr_en = vif.wr_en;
        sequence_item_h.data_in = vif.data_in;
        sequence_item_h.address = vif.address;
        sequence_item_h.data_out = vif.data_out;
        sequence_item_h.valid_out = vif.valid_out;
    endtask: monitor

endclass: mem_monitor
