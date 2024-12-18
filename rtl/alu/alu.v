module multiplier (
	input wire [15:0] a,
	input wire [15:0] b,
	output reg [31:0] product
);
	always @(*) begin
    	product = a * b;  // Perform multiplication
	end
endmodule

module alu_mac (
	input wire clk,
	input wire reset,
	input wire [1023:0] d,    	// Flattened 64-element, 16-bit array
	input wire [1023:0] cmem, 	// Flattened 64-element, 16-bit array
	output reg [31:0] out,    	// Accumulated result
	output reg done           	// Completion flag
);

	reg [5:0] tap_index;      	// Index for processing elements (unsigned 6-bit)
	reg [31:0] sum;           	// Accumulated sum
	wire [31:0] product;      	// Output of multiplier
	wire [15:0] d_element;    	// Current element of d
	wire [15:0] cmem_element; 	// Current element of cmem

	// Extract current elements from flattened arrays
	assign d_element = d[(tap_index * 16) +: 16];
	assign cmem_element = cmem[(tap_index * 16) +: 16];

	// Instantiate the multiplier
	multiplier mult_inst (
    	.a(d_element),
    	.b(cmem_element),
    	.product(product)
	);

	// ALU MAC operation
	always @(posedge clk or posedge reset) begin
    	if (reset) begin
        	sum <= 32'b0;           // Initialize sum
        	tap_index <= 6'b0;     // Initialize index
        	out <= 32'b0;          // Initialize output
        	done <= 1'b0;          // Reset done flag
    	end else begin
        	if (tap_index < 63) begin
            	sum <= sum + product;  // Accumulate product
            	tap_index <= tap_index + 1; // Increment tap index
            	done <= 1'b0;         // Not done yet
        	end else begin
            	sum <= sum + product;  // Accumulate the last product
            	out <= sum;            // Output the accumulated sum
            	tap_index <= 6'b0;     // Reset tap index
            	sum <= 32'b0;          // Reset sum for next operation
            	done <= 1'b1;          // Signal completion
        	end
    	end
	end
endmodule

