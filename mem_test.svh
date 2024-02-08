
class mem_test extends uvm_test;

    `uvm_component_utils(mem_test)

    virtual interface mem_if vif;

    mem_env env_h;
    mem_sequence sequence_h;

    function new(string name = "mem_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_test", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_test", "build phase", UVM_HIGH)
        env_h = mem_env::type_id::create("env_h", this);
        sequence_h = mem_sequence::type_id::create("sequence_h");
        if(!uvm_config_db # (virtual interface mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual mem_if) :: set(this, "env_h", "vif", vif);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("mem_test", "run phase", UVM_HIGH)
        phase.raise_objection(this, "Starting Sequences");
        sequence_h.start(env_h.agent_h.sequencer_h);
        phase.drop_objection(this, "Finished Sequences");
    endtask: run_phase

endclass: mem_test
