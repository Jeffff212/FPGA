module RAM # (
    parameter INIT = "MEMINIT.txt"
) (
// INPUTS
input wire reset,
input wire clock,
input wire read,
input wire write,
input wire [3:0] WriteAddr,
input wire [3:0] ReadAddr,
input wire [7:0] WriteData,
// Outputs
output reg [7:0] ReadData,
output reg ReadReady,
output reg WriteReady
);

reg [7:0] mem [0:15];

always @ (posedge clock or posedge reset) begin
    if (reset) begin
        WriteReady = 0;
        $readmemh(INIT, mem);
    end else begin
        if (write) begin
            mem[WriteAddr] <= WriteData;
            WriteReady = 0;
        end else begin
            WriteReady = 1;
        end
        if (read) begin
            ReadData <= mem[ReadAddr];
            ReadReady = 0;
        end else begin
            ReadReady = 1;
        end
    end
end
endmodule