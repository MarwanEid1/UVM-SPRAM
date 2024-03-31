
module memory # (
    parameter integer D_WIDTH   = 32,
    parameter integer A_WIDTH   = 4,
    parameter integer MEM_DEPTH = 2 ** A_WIDTH
) (
    input  logic               clk,
    input  logic               rst_n,
    input  logic               wr_en,
    input  logic [A_WIDTH-1:0] address,
    input  logic [D_WIDTH-1:0] data_in,
    output logic [D_WIDTH-1:0] data_out,
    output logic               valid_out
);

    logic [D_WIDTH-1:0] mem_array [0:MEM_DEPTH-1];

    always @ (posedge clk or negedge rst_n) begin
        
        if (!rst_n) begin
            for (int i = 0; i < MEM_DEPTH; i++) begin
                mem_array [i] <= 'b0;
            end
            data_out <= 'b0;
            valid_out <= 1'b0;
        end
        else begin
            if (wr_en) begin
                mem_array [address] <= data_in;
                data_out <= 'b0;
                valid_out <= 1'b0;
            end
            else begin
                data_out <= mem_array [address];
                valid_out <= 1'b1;
            end
        end

    end

endmodule: memory
