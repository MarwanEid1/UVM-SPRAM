
interface mem_if # (
    parameter integer D_WIDTH = 32,
    parameter integer A_WIDTH = 4
);

    bit               clk;
    bit               rst_n;
    bit               wr_en;
    bit [D_WIDTH-1:0] data_in;
    bit [A_WIDTH-1:0] address;
    bit [D_WIDTH-1:0] data_out;
    bit               valid_out;

endinterface: mem_if
