`timescale 1ps/1ps

module test_top_module;

    // Testbench signals
    reg clk;                 // Clock signal
    reg reset;               // Reset signal
    reg fast_clk;            // Fast clock signal
    reg [15:0] input_data;   // Input data width aligned with netlist
    reg [1023:0] cmem_data_in; // CMEM data input aligned with netlist
    wire done;               // Output signal indicating completion
    wire [31:0] result;      // Output result, width matched to your design

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .input_data(input_data),
        .cmem_data_in(cmem_data_in),
        .result(result),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ps clock period
    end

    initial begin
        fast_clk = 0;
        forever #2 fast_clk = ~fast_clk; // 4ps clock period
    end

    // Testbench process
    initial begin
        // Initialize inputs
        reset = 1;
        input_data = 16'b0;
        cmem_data_in = 1024'b0;

        // Reset pulse
        #10;
        reset = 0;

        // Apply test stimulus
        #20;
        input_data = 16'hABCD;
        cmem_data_in = 1024'h123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF;

        // Wait for completion
        wait(done);

        // Check result
        #10;
        $display("Simulation completed with result: %h", result);

        // End simulation
        $finish;
    end

endmodule

