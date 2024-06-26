
class mem_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(mem_scoreboard)

    parameter integer D_WIDTH   = 32;
    parameter integer A_WIDTH   = 4;
    parameter integer MEM_DEPTH = 2 ** A_WIDTH;

    mem_sequence_item sequence_item_h;

    uvm_analysis_imp # (mem_sequence_item, mem_scoreboard) mem_analysis_imp;

    bit [D_WIDTH-1:0] mem_array [0:MEM_DEPTH-1];

    bit previous_wr_en;
    bit [D_WIDTH-1:0] previous_data_in;
    bit [A_WIDTH-1:0] previous_address;

    int rd_op_cnt;
    int suc_rd_op_cnt;

    function new(string name = "mem_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_scoreboard", "constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("mem_scoreboard", "build phase", UVM_HIGH)
        sequence_item_h = mem_sequence_item::type_id::create("sequence_item_h");
        mem_analysis_imp = new("mem_analysis_imp", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("mem_scoreboard", "connect phase", UVM_HIGH)
    endfunction: connect_phase

    function void write(mem_sequence_item t);
        sequence_item_h = t;
        sequence_item_h.display_out("mem_scoreboard");
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $display("");
        $display("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        if (previous_wr_en) begin
            mem_array [previous_address] = previous_data_in;
            $display("[Scoreboard] - Write Operation");
        end
        else begin
            rd_op_cnt++;
            if (mem_array [previous_address] == sequence_item_h.data_out) begin
                $display("[Scoreboard] - Read Operation from address = '%h' PASSED", previous_address);
                suc_rd_op_cnt++;
            end
            else begin
                $display("[Scoreboard] - Read Operation from address = '%h' FAILED", previous_address);
            end
            $display("Actual Data:   data_out = %h", sequence_item_h.data_out);
            $display("Expected Data: data_out = %h", mem_array [previous_address]);
        end
        previous_wr_en = sequence_item_h.wr_en;
        previous_data_in = sequence_item_h.data_in;
        previous_address = sequence_item_h.address;
        $display("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
        $display("");
        if (suc_rd_op_cnt == rd_op_cnt) begin
            $display("Scoreboard Summary: All Read Operations PASSED");
        end
        else begin
            $display("Scoreboard Summary: One or More Read Operations FAILED");
        end
        $display("Number of Performed Read Operations: %0d --- Number of Successfull Read Operations: %0d",
                 rd_op_cnt, suc_rd_op_cnt);
        $display("");
    endfunction: write

endclass: mem_scoreboard
