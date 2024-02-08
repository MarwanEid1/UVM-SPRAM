
`timescale 1ns/1ps

module mem_top;

    import uvm_pkg::*;
    import mem_pkg::*;

    mem_if intf();

    initial begin
        uvm_config_db # (virtual interface mem_if) :: set(null, "uvm_test_top", "vif", intf);
        run_test();
    end

    // clock generation
    always #5 intf.clk = ~intf.clk;

    // dut instantiation
    memory mem_dut (
        .clk        (intf.clk),
        .rst_n      (intf.rst_n),
        .wr_en      (intf.wr_en),
        .data_in    (intf.data_in),
        .address    (intf.address),
        .data_out   (intf.data_out),
        .valid_out  (intf.valid_out)
    );

endmodule: mem_top
