module DeBounce (
// INPUTS
	input clk,
	input in,
	input reset,
// Outputs
	output reg out
);

reg [2:0] Dclk;

reg [5:0] DB;

reg Dout;

reg state;

always @ (reset) begin
	Dclk <= 0;
	DB <= 0;
	out <= 0;
	state <= 0;
end

always @ (posedge clk & ~reset) begin
	if (Dclk[2:1] == 2'b11) begin
		Dclk[2:1] <= 2'b00;
		Dout = 1;
	end else begin
	Dclk <= Dclk + 1'b1;
	Dout = 0;
	end
end

always @ (posedge Dout & ~reset) begin
	if (state) begin
		if (in == 0) begin
			if (DB[5:4] == 2'b11) begin
				state = 0;
				DB[5:4] <= 2'b00;
				out = 0;
			end else begin
				DB <= DB + 1;
			end
		end
	end else begin
		if (in == 1) begin
			if (DB[5:4] == 2'b11) begin
				state = 1;
				DB[5:4] <= 2'b00;
				out = 1;
			end else begin
				DB <= DB + 1;
			end
		end
	end
end
endmodule