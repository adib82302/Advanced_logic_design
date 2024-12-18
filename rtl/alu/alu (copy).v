// Multiplier module
module multiplier (
	input wire [15:0] a,
	input wire [15:0] b,
	output reg [31:0] product
);
	always @(*) begin
    	product = a * b;
	end
endmodule

// Adder module
module adder (
	input wire [31:0] sum_in,
	input wire [31:0] addend,
	output reg [31:0] sum_out
);
	always @(*) begin
    	sum_out = sum_in + addend;
	end
endmodule

// dff Module
module dff (
	input wire clk,
	input wire reset,
	input wire [1023:0] d,   	// Flattened 64-element, 16-bit array
	input wire [1023:0] cmem,	// Flattened 64-element, 16-bit array
	output reg [31:0] out
);
	reg [5:0] tap_index;     	// Index for processing elements
	reg [31:0] sum;          	// Accumulated sum
	wire [15:0] d_element;   	// Current element of d
	wire [15:0] cmem_element;	// Current element of cmem

	assign d_element = d[(tap_index * 16) +: 16];
	assign cmem_element = cmem[(tap_index * 16) +: 16];

	always @(posedge clk or posedge reset) begin
    	if (reset) begin
        	tap_index <= 0;
        	sum <= 0;
        	out <= 0;
    	end else begin
        	if (tap_index < 64) begin
            	sum <= sum + (d_element * cmem_element);
            	tap_index <= tap_index + 1;
        	end else begin
            	out <= sum;
            	tap_index <= 0;
            	sum <= 0;
        	end
    	end
	end
endmodule

// ALU MAC Module
module alu_mac (
	input wire clk,
	input wire reset,
	input wire [127:0] d,   	// Flattened 8-element, 16-bit array
	input wire [127:0] cmem,	// Flattened 8-element, 16-bit array
	output reg [31:0] out,  	// Accumulated result
	output reg done         	// Completion flag
);
	reg [5:0] tap_index;     	// Index for processing elements
	reg [31:0] sum;          	// Accumulated sum
	wire [31:0] product;     	// Output of multiplier
	wire [15:0] d_element;   	// Current element of d
	wire [15:0] cmem_element;	// Current element of cmem

	assign d_element = d[(tap_index * 16) +: 16];
	assign cmem_element = cmem[(tap_index * 16) +: 16];

	multiplier mult_inst (
    	.a(d_element),
    	.b(cmem_element),
    	.product(product)
	);

	always @(posedge clk or posedge reset) begin
    	if (reset) begin
        	sum <= 0;
        	tap_index <= 0;
        	out <= 0;
        	done <= 0;
    	end else begin
        	if (tap_index < 8) begin
            	sum <= sum + product;
            	tap_index <= tap_index + 1;
            	done <= 0;
        	end else begin
            	out <= sum;
            	tap_index <= 0;
            	sum <= 0;
            	done <= 1;
        	end
    	end
	end
endmodule


