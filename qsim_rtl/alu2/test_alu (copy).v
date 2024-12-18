`timescale 1ns/1ps
`define SD #0.010
`define HALF_CLOCK_PERIOD #5
`define QSIM_OUT_FN "./alu_qsim.out"
`define MATLAB_OUT_FN "../../matlab/alu/alu.results"

module testbench();

	reg clk;
	reg reset;
	reg [127:0] d;   	// Flattened array: 8 elements, 16 bits each
	reg [127:0] cmem;	// Flattened array: 8 elements, 16 bits each

	wire [31:0] alu_out;
	wire done;

	integer alu_out_matlab;
	integer alu_out_qsim;

	integer i;
	integer ret_write;
	integer ret_read;
	integer qsim_out_file;
	integer matlab_out_file;

	integer error_count = 0;

	// Instantiate the ALU MAC module
	alu_mac uut (
    	.clk(clk),
    	.reset(reset),
    	.d(d),
    	.cmem(cmem),
    	.out(alu_out),
    	.done(done)
	);

	// Clock generation
	always begin
    	`HALF_CLOCK_PERIOD;
    	clk = ~clk;
	end

	initial begin
    	// File IO setup
    	qsim_out_file = $fopen(`QSIM_OUT_FN, "w");
    	if (!qsim_out_file) begin
        	$display("Couldn't create the output file.");
        	$finish;
    	end

    	matlab_out_file = $fopen(`MATLAB_OUT_FN, "r");
    	if (!matlab_out_file) begin
        	$display("Couldn't open the Matlab file.");
        	$finish;
    	end

    	// Initialize signals
    	clk = 0;
    	reset = 1;
    	d = 0;
    	cmem = 0;

    	// Release reset after one clock cycle
    	@(posedge clk);
    	@(negedge clk);
    	reset = 0;

    	// Initialize d and cmem with test values
    	for (i = 0; i < 8; i = i + 1) begin
        	d[(i * 16) +: 16] = i + 1;   	// Example values: 1, 2, ..., 8
        	cmem[(i * 16) +: 16] = 16'h0001; // Coefficients all set to 1
    	end

    	// Wait for completion and compare results
    	@(posedge done); // Wait for the done signal
    	alu_out_qsim = alu_out;

    	ret_read = $fscanf(matlab_out_file, "%d", alu_out_matlab);
    	$fwrite(qsim_out_file, "%0d\n", alu_out_qsim);

    	if (alu_out_qsim != alu_out_matlab) begin
        	error_count = error_count + 1;
    	end

    	// Check if results match
    	if (error_count > 0) begin
        	$display("The results DO NOT match with those from Matlab :( ");
    	end else begin
        	$display("The results DO match with those from Matlab :) ");
    	end

    	// Close files and finish simulation
    	$fclose(qsim_out_file);
    	$fclose(matlab_out_file);
    	$finish;
	end

endmodule // testbench


