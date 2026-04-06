module fifo_tb;

reg clk = 0;
always #5 clk = ~clk;

reg rst;
reg wr_en, rd_en;
reg [7:0] data_in;
wire [7:0] data_out;
wire full, empty;

fifo uut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

initial begin
    $display("FIFO Simulation Start");

    rst = 1;
    wr_en = 0;
    rd_en = 0;
    #10;

    rst = 0;

    // WRITE 5 values
    repeat (10)begin
        
        @(posedge clk);
        wr_en = 1;
        data_in = $random;
    end
    wr_en = 0;

    // READ 5 values
    repeat (5) begin
        @(posedge clk);
        rd_en = 1;
    end
    rd_en = 0;

    #50;
    $stop;
end
always @(posedge clk)
    if (full && wr_en)
        $display("ERROR: Write when FIFO FULL");

always @(posedge clk)
    if (empty && rd_en)
        $display("ERROR: Read when FIFO EMPTY");

endmodule