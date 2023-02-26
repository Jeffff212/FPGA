`timescale 1ns/10ps
module test();
reg clk = 1;
reg slwclk = 1;
reg reset = 0;

always begin
    #41.667

    clk <= ~clk;
end
always begin
    #416.67

    slwclk <= ~slwclk;
end

initial begin
    #1
    reset <= 1;
    #250
    reset <= 0;
end

initial begin
    $dumpfile("TEST_tb.vcd");
    $dumpvars(0, test);
    #22000

    $display("Finished");
    $finish;
end

always @ (posedge WriteReady or negedge WriteReady) begin
    if (WriteReady) begin
        WriteAddr <= WriteAddr + 1;
        WriteData <= $urandom_range(255,0);
        write <= 1;
    end else begin
        write <= 0;
    end
end
always @ (posedge clk) begin
    if (ready) begin
        read <= 1;
        ReadAddr <= ReadAddr + 1;
        ready <= 0;
    end else if (ReadReady) begin
        Data <= ReadData;
        read <= 0;
    end
end
always @ (posedge slwclk) begin
    ready <= 1;
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
    .ReadData(ReadData),
    .reset(reset)
);
reg [0:0] write = 0;
reg [0:0] read = 0;

reg [7:0] Data;

reg ready;

reg counter = 1'b0;

reg [3:0] WriteAddr = 4'b0000;
reg [3:0] ReadAddr = 4'b0000;
reg [7:0] WriteData = 8'b0000000;
wire [7:0] ReadData;
wire WriteReady;
wire ReadReady;
wire TechReadReady;

endmodule