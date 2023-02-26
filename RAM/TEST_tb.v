`timescale 1ns/10ps
module test();
reg clk = 0;
reg reset = 0;

always begin
    #41.667

    clk = ~clk;
end

initial begin
    #1
    pmod[3:3] = 0;
    #250
    pmod[3:3] = 1;
end

initial begin
    $dumpfile("TEST_tb.vcd");
    $dumpvars(0, test);
    #22000

    $display("Finished");
    $finish;
end
sequencer sequencer(
    .clk(clk),
    .pmod(pmod),

    .led(led)
);
reg [3:0] pmod = 4'b1111;

always begin
    #300
    pmod[1:0] <= $urandom_range(3,0);
end

always begin
    #($urandom_range(400,600));
    pmod[2:2] <= $urandom_range(0,1);
end

endmodule