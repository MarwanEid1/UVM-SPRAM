
class mem_base_test extends uvm_test;

    `uvm_component_utils(mem_base_test)

    mem_env env_h;

    virtual mem_if vif;

    function new(string name = "mem_base_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_base_test", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_base_test", "build phase", UVM_HIGH)
        env_h = mem_env::type_id::create("env_h", this);
        if(!uvm_config_db # (virtual mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"vif must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual mem_if) :: set(this, "env_h", "vif", vif);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_base_test", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("mem_base_test", "run phase", UVM_HIGH)
    endtask: run_phase

endclass: mem_base_test

class mem_random_test extends mem_base_test;

    `uvm_component_utils(mem_random_test)

    mem_reset_sequence reset_sequence_h;
    mem_random_sequence random_sequence_h;

    function new(string name = "mem_random_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_random_test", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_random_test", "build phase", UVM_HIGH)
        reset_sequence_h = mem_reset_sequence::type_id::create("reset_sequence_h");
        random_sequence_h = mem_random_sequence::type_id::create("random_sequence_h");
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_random_test", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("mem_random_test", "run phase", UVM_HIGH)
        phase.raise_objection(this, "Starting Sequences");
        reset_sequence_h.start(env_h.agent_h.sequencer_h);
        random_sequence_h.start(env_h.agent_h.sequencer_h);
        phase.drop_objection(this, "Finished Sequences");
    endtask: run_phase

endclass: mem_random_test
