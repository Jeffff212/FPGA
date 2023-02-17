`timescale 1ns/10ps
module test();
reg clk = 0;
reg reset = 0;

always begin
    #41.667

    clk = ~clk;
end

initial begin
    reset = 1;
    #250
    reset = 0;
end

initial begin
    $dumpfile("TEST_tb.vcd");
    $dumpvars(0, test);
    #22000

    $display("Finished");
    $finish;
end

// always @ (posedge WriteReady) begin
//
//end
always @ (posedge clk) begin
    write <= 0;
    read <= 0;
    if (counter) begin
        if (WriteReady) begin
            WriteAddr <= WriteAddr + 1;
            WriteData <= $urandom_range(255,0);
            write <= 1;
        end
        if (ReadReady) begin
            ReadAddr <= ReadAddr + 1;
            Data <= ReadData;
            read <= 1;
        end
    end
    counter = counter + 1;
end

RAM RAM(
    .clock(clk),
    .WriteReady(WriteReady),
    .ReadReady(ReadReady),
    .write(write),
    .read(read),
    .WriteAddr(WriteAddr),
    .ReadAddr(ReadAddr),
    .WriteData(WriteData),
    .ReadData(ReadData)
);
reg [0:0] write;
reg [0:0] read;

reg [7:0] Data;

reg counter = 1'b0;

reg [3:0] WriteAddr = 4'b0000;
reg [3:0] ReadAddr = 4'b0000;
reg [7:0] WriteData = 7'b0000000;
wire [7:0] ReadData = 7'b0000000;
wire WriteReady;
wire ReadReady;

endmodule