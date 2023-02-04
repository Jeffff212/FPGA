module Subtractor(
    input Tick,

    input wire [4:0] In,

    output reg [4:0] Out,

    output reg state
);
always @ (posedge Tick) begin
    if (state) begin
        Out <= In - 1'b1;
        if (Out == 5'b00000) begin
            state = 1'b0;
        end
    end else begin
        if (In == 5'b11111) begin
            state = 1'b1;
            Out <= In;
        end
    end
end
endmodule