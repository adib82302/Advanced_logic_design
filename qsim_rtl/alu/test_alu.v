`timescale 1ns / 1ps

module test_alu;

    // Inputs
    reg clk;
    reg reset;
    reg [1023:0] d;     // Flattened 64-element, 16-bit array
    reg [1023:0] cmem;  // Flattened 64-element, 16-bit array

    // Outputs
    wire [31:0] out;    // Accumulated result
    wire done;          // Completion flag

    // Instantiate the DUT (Device Under Test)
    alu_mac uut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .cmem(cmem),
        .out(out),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Testbench stimulus
    initial begin
        // Monitor outputs
        $monitor("Time: %0d | Out: %d | Done: %b", $time, out, done);

        // Initialize waveform dump
        $dumpfile("alu_mac_waveform.vcd");
        $dumpvars(0, test_alu);

        // Reset
        reset = 1;
        d = 0;
        cmem = 0;
        #10 reset = 0;

        // Test case 1: Multiply all ones
        d = {64{16'h0001}};       // All elements in `d` are 1
        cmem = {64{16'h0002}};    // All elements in `cmem` are 2
        wait(done);               // Wait for processing to complete
        $display("Test Case 1: Accumulated Sum = %0d", out);

        // Test case 2: Mixed values
        reset = 1;
        #10 reset = 0;
        d = {16'h0001, 16'h0002, 16'h0003, 16'h0004, 16'h0005, {59{16'h0000}}};
        cmem = {16'h0001, 16'h0002, 16'h0003, 16'h0004, 16'h0005, {59{16'h0000}}};
        wait(done);               // Wait for processing to complete
        $display("Test Case 2: Accumulated Sum = %0d", out);

        // Test case 3: Zeros in inputs
        reset = 1;
        #10 reset = 0;
        d = {64{16'h0000}};       // All elements in `d` are 0
        cmem = {64{16'h0000}};    // All elements in `cmem` are 0
        wait(done);               // Wait for processing to complete
        $display("Test Case 3: Accumulated Sum = %0d", out);

        // Test case 4: Large inputs
        reset = 1;
        #10 reset = 0;
        d = {64{16'hFFFF}};       // All elements in `d` are -1 (two's complement)
        cmem = {64{16'h0001}};    // All elements in `cmem` are 1
        wait(done);               // Wait for processing to complete
        $display("Test Case 4: Accumulated Sum = %0d", out);

        // End simulation
        $finish;
    end

endmodule

