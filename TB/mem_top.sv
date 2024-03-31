
`timescale 1ns/1ps

module mem_top;

    import uvm_pkg::*;
    import mem_pkg::*;

    mem_if intf();

    initial begin
        intf.clk = 1'b0;
        uvm_config_db#(virtual mem_if)::set(null, "uvm_test_top", "vif", intf);
        run_test();
    end

    always #5 intf.clk = ~intf.clk;

    memory mem_dut (
        .clk        (intf.clk),
        .rst_n      (intf.rst_n),
        .wr_en      (intf.wr_en),
        .address    (intf.address),
        .data_in    (intf.data_in),
        .data_out   (intf.data_out),
        .valid_out  (intf.valid_out)
    );

endmodule: mem_top
