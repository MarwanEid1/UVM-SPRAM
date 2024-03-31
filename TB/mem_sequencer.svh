
class mem_sequencer extends uvm_sequencer # (mem_sequence_item);

    `uvm_component_utils(mem_sequencer)

    function new(string name = "mem_sequencer", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_sequencer", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_sequencer", "build phase", UVM_HIGH)
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_sequencer", "connect phase", UVM_HIGH)
    endfunction: connect_phase

endclass: mem_sequencer
