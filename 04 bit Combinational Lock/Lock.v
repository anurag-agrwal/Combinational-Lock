// 4 bit combinational lock

//	1	2	3
//	4	5	6
//	7	8	9
//	*	0	#

// Reaches state : on the condition
// S0 : initial state
// S1 : when 1st input bit
// S2 : input released (h = 000, v = 0000) - No button pressed
// S3 : 2nd input bit
// S4 : input released (h = 000, v = 0000) - No button pressed
// S5 : 3rd input bit
// S6 : input released (h = 000, v = 0000) - No button pressed
// S7 : 4th input bit
// S8 : input released (h = 000, v = 0000) - No button pressed -- output becomes HIGH
// now output remains HIGH for 24 clock pulses 8 to 31
// that's why no. of bits in state are 5.

// Correct input combination : 1105

module Lock (clk, reset, h, v, q, open);
input clk, reset;
input [1:3] h;
input [1:4] v;
output reg [4:0] q;
output reg open;

reg [4:0] nextstate;

always@(posedge clk or negedge reset)
	begin
		if(!reset)
			q <= 5'b0;
		else
			q <= nextstate;
	end


always@(q)
	begin
		casex(q)
			5'b00xxx :  open <= 1'b0;
			5'b01xxx :  open <= 1'b1;
			5'b1xxxx : open <= 1'b1;
		//[8:31] : open = 1'b1;
			default: open <= 1'b0;
		endcase
	end

always@(q, h, v)
	begin
		casex(q)
			0: begin if(h==3'b100 && v==4'b1000) nextstate <= 5'd1; else nextstate <= 5'd0; end	// returns to S0 if 1st is wrong
			1: begin if(h==3'b100 && v==4'b1000) nextstate <= 5'd1; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd2; else nextstate <= 5'd0; end
			2: begin if(h==3'b100 && v==4'b1000) nextstate <= 5'd3; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd2; else nextstate <= 5'd0; end // resturns to S0 if 2nd is wrong
			3: begin if(h==3'b100 && v==4'b1000) nextstate <= 5'd3; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd4; else nextstate <= 5'd0; end
			4: begin if(h==3'b010 && v==4'b0001) nextstate <= 5'd5; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd4; else nextstate <= 5'd0; end // returns to S0 if 3rd input is wrong
			5: begin if(h==3'b010 && v==4'b0001) nextstate <= 5'd5; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd6; else nextstate <= 5'd0; end
			6: begin if(h==3'b010 && v==4'b0100) nextstate <= 5'd7; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd6; else nextstate <= 5'd0; end // returns to S0 if 4th input is wrong
			7: begin if(h==3'b010 && v==4'b0100) nextstate <= 5'd7; else if(h==3'b000 && v==4'b0000) nextstate <= 5'd8; else nextstate <= 5'd0; end
			//[8:30]: nextstate <= q + 5'd1;
			5'b01xxx : nextstate <= q + 5'd1;
			5'b10xxx : nextstate <= q + 5'd1;
			5'b1xx0x : nextstate <= q + 5'd1;
			5'b1xxx0 : nextstate <= q + 5'd1;
			5'b11011 : nextstate <= q + 5'd1;
			31: nextstate <= 5'd0;
			default: nextstate <= 5'd0;
		endcase
	end


endmodule
