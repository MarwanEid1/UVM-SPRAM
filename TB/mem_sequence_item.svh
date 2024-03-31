
class mem_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(mem_sequence_item)

    parameter integer D_WIDTH   = 32;
    parameter integer A_WIDTH   = 4;

          logic               rst_n;
         
    rand  logic               wr_en;
    rand  logic [D_WIDTH-1:0] data_in;
    randc logic [A_WIDTH-1:0] address;

          logic [D_WIDTH-1:0] data_out;
          logic               valid_out;

    constraint c_wr_en {
        wr_en dist {1 := 2, 0 := 1};
    }
    
    constraint c_data_in{
        data_in dist {[32'h_0000_0000 : 32'h_0000_00FF] := 2,
                      [32'h_0000_00FF : 32'h_FFFF_FF00] := 1,
                      [32'h_FFFF_FF00 : 32'h_FFFF_FFFF] := 2};
    }

    constraint c_addr{
        address dist {[4'b0000 : 4'b0011] := 2,
                      [4'b0011 : 4'b1100] := 1,
                      [4'b1100 : 4'b1111] := 2};
    }

    function new(string name = "mem_sequence_item");
        super.new(name);
        `uvm_info(name, "constructor", UVM_HIGH)
    endfunction: new

    function void display_in(input string name = " ");
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $info("[%s] - Transaction Data: rst_n = %d, wr_en = %0d, data_in = %h, address = %h",
                 name, rst_n, wr_en, data_in, address);
    endfunction: display_in

    function void display_out(input string name = " ");
        $display("---------------------------------------------------------------------------------------------------------------------------------------");
        $info("[%s] - Transaction Data: rst_n = %d, wr_en = %0d, data_in = %h, address = %h, data_out = %h, valid_out = %0d",
                 name, rst_n, wr_en, data_in, address, data_out, valid_out);
    endfunction: display_out

endclass: mem_sequence_item
