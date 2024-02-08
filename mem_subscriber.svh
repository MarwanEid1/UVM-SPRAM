
class mem_subscriber extends uvm_subscriber # (mem_sequence_item);

    `uvm_component_utils(mem_subscriber)

    mem_sequence_item sequence_item_h;

    covergroup cvr_grp;

        wr_en_cp: coverpoint sequence_item_h.wr_en {
            bins single_write = (0 => 1 => 0);
            bins many_writes = (1 [*2:10]);
        }

        data_in_cp: coverpoint sequence_item_h.data_in {
            bins null_data = {32'h_0000_0000};
            bins ones_data = {32'h_FFFF_FFFF};
        }

        address_cp: coverpoint sequence_item_h.address {
            bins null_address = {4'h_0};
            bins ones_address = {4'h_F};
        }

        data_out_cp: coverpoint sequence_item_h.data_out {
            bins null_data = {32'h_0000_0000};
            bins ones_data = {32'h_FFFF_FFFF};
        }

        valid_out_cp: coverpoint sequence_item_h.valid_out {
            bins single_valid = (0 => 1 => 0);
            bins many_valid = (1 [*2:10]);
            bins single_unvalid = (1 => 0 => 1);
            bins many_unvalid = (0 [*2:10]);
        }

    endgroup: cvr_grp

    function new(string name = "mem_subscriber", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("mem_subscriber", "constructor", UVM_HIGH)
        cvr_grp = new();
    endfunction: new

    function void write(mem_sequence_item t);
        sequence_item_h = t;
        sequence_item_h.display_out("mem_subscriber");
        cvr_grp.sample();
    endfunction: write

endclass: mem_subscriber
