
class mem_env extends uvm_env;

    `uvm_component_utils(mem_env)

    virtual interface mem_if vif;

    mem_agent agent_h;
    mem_subscriber subscriber_h;
    mem_scoreboard scoreboard_h;
    
    function new(string name = "mem_env", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_env", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_env", "build phase", UVM_HIGH)
        agent_h = mem_agent::type_id::create("agent_h", this);
        subscriber_h = mem_subscriber::type_id::create("subscriber_h", this);
        scoreboard_h = mem_scoreboard::type_id::create("scoreboard_h", this);
        if(!uvm_config_db # (virtual interface mem_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
        uvm_config_db # (virtual mem_if) :: set(this, "agent_h", "vif", vif);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_env", "connect phase", UVM_HIGH)
        agent_h.mem_analysis_port.connect(scoreboard_h.mem_analysis_imp);
        agent_h.mem_analysis_port.connect(subscriber_h.analysis_export);
    endfunction: connect_phase

endclass: mem_env
