
interface mem_if # (
    parameter integer D_WIDTH = 32,
    parameter integer A_WIDTH = 4
);

    logic               clk;
    logic               rst_n;
    logic               wr_en;
    logic [A_WIDTH-1:0] address;
    logic [D_WIDTH-1:0] data_in;
    logic [D_WIDTH-1:0] data_out;
    logic               valid_out;

endinterface: mem_if
