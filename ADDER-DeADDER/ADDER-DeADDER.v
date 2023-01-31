module Add_DeADDER (
    input [1:0] pmod,
    input clk,

    output reg [4:0] led
);
wire dclk;

wire [4:0] addout;

wire [4:0] subout;

wire state;

Clock Count (
    .clk(clk),
    .Dclk(dclk)
);

Adder add (
    .In(led[4:0]),
    .Tick(dclk),
    .Out(addout),
    .state(state)
);
Subtractor Sub (
    .In(led[4:0]),
    .Tick(dclk),
    .Out(subout)
);

always @ (posedge dclk) begin
    if (state == 1) begin
        led <= addout;
    end else begin
        led <= subout;
    end
end

endmodule