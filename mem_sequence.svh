
class mem_sequence extends uvm_sequence;

    `uvm_object_utils(mem_sequence)

    mem_sequence_item sequence_item_h;

    int transaction_count = 30;

    function new(string name = "mem_sequence");
        super.new(name);
        `uvm_info("mem_sequence", "constructor", UVM_HIGH)
    endfunction: new

    task pre_body;
        `uvm_info("mem_sequence", "pre_body", UVM_HIGH)
        sequence_item_h = mem_sequence_item::type_id::create("sequence_item_h");
    endtask: pre_body

    task body;
        `uvm_info("mem_sequence", "body", UVM_HIGH)
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $display("\n");
        $display("***************************************************************************************************************************************");
        $display("Starting Reset Transaction:");
        $display("***************************************************************************************************************************************");
        start_item(sequence_item_h);
        sequence_item_h.rst_n = 0;
        sequence_item_h.display_in("mem_sequence  ");
        finish_item(sequence_item_h);
        for (int i = 1; i <= transaction_count; i++) begin
            $display("---------------------------------------------------------------------------------------------------------------------------------------");
            $display("\n");
            $display("***************************************************************************************************************************************");
            $display("Starting Transaction Number %0d:", i);
            $display("***************************************************************************************************************************************");
            start_item(sequence_item_h);
            if(!sequence_item_h.randomize()) begin
                `uvm_fatal("mem_sequence", "Transaction Randomization Failed");
            end
            sequence_item_h.rst_n = 1;
            sequence_item_h.display_in("mem_sequence  ");
            finish_item(sequence_item_h);
        end
    endtask: body

endclass: mem_sequence
