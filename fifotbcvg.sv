module fifo_tb;

logic clk;
logic rst;
logic wr_en, rd_en;
logic [7:0] data_in;
logic [7:0] data_out;
logic full, empty;

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

// Clock
initial clk = 0;
always #5 clk = ~clk;

// ------------------ COVERAGE ------------------
covergroup fifo_cg @(posedge clk);
    option.per_instance = 1;

    wr_en_cp : coverpoint wr_en;
    rd_en_cp : coverpoint rd_en;

    full_cp  : coverpoint full;
    empty_cp : coverpoint empty;

    // Cross coverage (VERY GOOD )
    wr_full_cross : cross wr_en_cp, full_cp;
    rd_empty_cross : cross rd_en_cp, empty_cp;

endgroup

fifo_cg cg = new();

// ------------------ TEST ------------------
initial begin
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    #10;
    rst = 0;

    // WRITE
    repeat (10) begin
        @(posedge clk);
        wr_en = 1;
        data_in = $urandom;
    end
    wr_en = 0;

    // READ
    repeat (10) begin
        @(posedge clk);
        rd_en = 1;
    end
    rd_en = 0;

    #50;
    $display("Coverage = %0.2f %%", cg.get_coverage());
    $stop;
end

// ------------------ ASSERTIONS ------------------
always @(posedge clk)
    if (full && wr_en)
        $error("Overflow detected");

always @(posedge clk)
    if (empty && rd_en)
        $error("Underflow detected");

endmodule
