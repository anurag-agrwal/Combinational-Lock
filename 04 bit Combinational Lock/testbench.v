`timescale 1ns/1ps
module testbench();

reg clk, reset;
reg [1:3] h;
reg [1:4] v;
wire [4:0] q;
wire open;

Lock dut_instance (clk, reset, h, v, q, open);

integer i;

initial begin
for(i=0; i<50; i=i+1)
	begin
		clk = 1'b0;
		#5;
		clk = 1'b1;
		#5;
	end
end

initial begin
reset = 1'b0;
#6;
reset = 1'b1;

h = 3'b000;
v = 4'b0000;

#24;
//		1
h = 3'b100;
v = 4'b1000;

#10;

h = 3'b000;
v = 3'b000;

#10;
//		1
h = 3'b100;
v = 4'b1000;

#10;

h = 3'b000;
v = 4'b0000;

#10;
// 	0
h = 3'b010;
v = 4'b0001;

#10;

h = 3'b000;
v = 4'b0000;

#10;
// 6 - wrong
h = 3'b001;
v = 4'b0100;

#10;

h = 3'b000;
v = 4'b0000;

#10;

//		1
h = 3'b100;
v = 4'b1000;

#10;

h = 3'b000;
v = 3'b000;

#10;
//		1
h = 3'b100;
v = 4'b1000;

#10;

h = 3'b000;
v = 4'b0000;

#10;
// 	0
h = 3'b010;
v = 4'b0001;

#10;

h = 3'b000;
v = 4'b0000;

#10;
// 5 - right sequence 
h = 3'b010;
v = 4'b0100;

#10;

h = 3'b000;
v = 4'b0000;

end

endmodule
