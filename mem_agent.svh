
class mem_agent extends uvm_agent;

    `uvm_component_utils(mem_agent)

    virtual interface mem_if vif;

    mem_driver driver_h;
    mem_monitor monitor_h;
    mem_sequencer sequencer_h;

    uvm_analysis_port # (mem_sequence_item) mem_analysis_port;

    function new(string name = "mem_agent", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_agent", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_agent", "build phase", UVM_HIGH)
        driver_h = mem_driver::type_id::create("driver_h", this);
        monitor_h = mem_monitor::type_id::create("monitor_h", this);
        sequencer_h = mem_sequencer::type_id::create("sequencer_h", this);
        if(!uvm_config_db # (virtual interface mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual mem_if) :: set(this, "driver_h", "vif", vif);
        uvm_config_db # (virtual mem_if) :: set(this, "monitor_h", "vif", vif);
        mem_analysis_port = new("mem_analysis_port", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_agent", "connect phase", UVM_HIGH)
        driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        monitor_h.mem_analysis_port.connect(mem_analysis_port);
    endfunction: connect_phase

endclass: mem_agent
