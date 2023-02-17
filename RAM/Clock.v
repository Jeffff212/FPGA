module Clock (
// INPUTS
	input	clk,
// Outputs
	output reg Dclk
);
// this is the clock counter that will 
reg [22:0] cclk;
// clock counter, also counter
always @ (posedge clk) begin
	if (cclk[22:20] == 3'b101) begin
	cclk = 24'b0;
	Dclk <= 1;
	end else begin
	Dclk <= 0;
    cclk <= cclk + 1;
	end
end
endmodule