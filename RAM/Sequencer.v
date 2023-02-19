module sequencer(
    input clk,
    input [2:0]pmod,

    output reg [1:0]led
);
DeBounce DeBounce (
// INPUTS
    .in(~pmod[0]),
    .clk(clk),
// Outputs
    .out(PWrite)
);
Clock clock (
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
    .WriteAddr(Addr),
    .ReadAddr(Addr),
    .WriteData(WriteData),
// Outputs
    .ReadData(ReadData)
);
reg [1:0] data;

reg [7:0] WriteData;

reg write;
reg read;
reg ADDRSHIFT;

reg [3:0] Addr;

always @ (posedge PWrite) begin
    if (PWrite) begin
        WriteData <= data;
        write <= 1;
    end else begin
        write <= 0;
    end
end
always @ (negedge clk) begin
    if (ADDRSHIFT) begin
        read <= 1;
        ADDRSHIFT <= 0;
    end else begin
        read <= 0;
        data <= ReadData;
    end
end
endmodule