module sequencer(
    input clk,
    input [3:0]pmod,

    output reg [1:0]led
);
DeBounce DeBounce (
// INPUTS
    .reset(reset),
    .in(~pmod[0]),
    .clk(clk),
// Outputs
    .out(PWrite)
);
Clock #(
    .COUNTERSIZE(24),
    .COUNTERLIMIT(6000000-1)
) clock  (
// INPUTS
    .clk(clk),
    .reset(reset),
// Outputs
    .Dclk(Dclk)
);
RAM RAM (
// INPUTS
    .reset(reset),
    .clock(clk),
    .read(read),
    .write(write),
    .WriteAddr(WriteAddr),
    .ReadAddr(ReadAddr),
    .WriteData(WriteData),
// Outputs
    .ReadData(ReadData),
    .ReadReady(ReadReady)
);

reg [7:0] WriteData;

wire [7:0] ReadData;

assign reset = ~pmod[3:3];

assign button = ~pmod[2:1];

wire [1:0] button;

reg write = 0;
reg read = 0;
reg ADDRSHIFT = 0;
reg EnWrite = 0;

reg [1:0] WriteAddr;
reg [1:0] ReadAddr;


// make a write semaphor
always @ (posedge reset) begin
    ReadAddr <= -1;
    WriteAddr <= -1;
end
always @ (posedge PWrite) begin
    EnWrite <= 1;
    led <= button;
end
always @ (posedge Dclk) begin
    ADDRSHIFT <= 1;
    ReadAddr <= ReadAddr + 1;
    WriteAddr <= WriteAddr + 1;
end
always @ (posedge clk & ~reset) begin
    if (EnWrite & ~write) begin
        WriteData[1:0] <= button;
        write <= 1;
    end else begin
        write <= 0;
        EnWrite <= 0;
    end
    if (read & ReadReady) begin
        read <= 0;
        led <= ReadData;
    end
end
always @ (posedge ADDRSHIFT) begin
    if (~read) begin
        read <= 1;
        ADDRSHIFT <= 0;
    end
end
endmodule