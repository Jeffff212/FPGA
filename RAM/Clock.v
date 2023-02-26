module Clock # (
	parameter COUNTERSIZE = 24,
	parameter COUNTERLIMIT = 6000000-1
) (
// INPUTS
	input	clk,
	input	reset,
// Outputs
	output reg Dclk
);
// this is the clock counter that will 
reg [COUNTERSIZE-1:0] cclk;
// clock counter, also counter
always @ (posedge clk) begin
	if (reset) begin
		cclk <= 0;
		Dclk <= 0;
	end else begin
		if (cclk == COUNTERLIMIT) begin
			cclk <= 0;
			Dclk <= ~Dclk;
		end else begin
			cclk <= cclk + 1;
		end
	end
end
endmodule