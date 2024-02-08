
class mem_sequencer extends uvm_sequencer # (mem_sequence_item);

    `uvm_component_utils(mem_sequencer)

    function new(string name = "mem_sequencer", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_sequencer", "constructor", UVM_HIGH)
    endfunction: new

endclass: mem_sequencer
