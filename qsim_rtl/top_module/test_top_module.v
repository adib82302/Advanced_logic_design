`timescale 1ns / 1ps

module test_top_module;

    // Testbench signals
    reg clk, fast_clk, reset;
    reg [15:0] input_data;
    reg [1023:0] cmem_data_in;
    wire [31:0] result;
    wire done;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns period
    end

    initial begin
        fast_clk = 0;
        forever #2 fast_clk = ~fast_clk;  // 4 ns period (faster clock)
    end

    // Instantiate the top-level module
    top_module uut (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .input_data(input_data),
        .cmem_data_in(cmem_data_in),
        .result(result),
        .done(done)
    );

    // Testbench stimulus
    initial begin
        // Initialize signals
        reset = 1;
        input_data = 0;
        cmem_data_in = {64{16'h4000}}; // CMEM initialized with value 2

        #10 reset = 0;  // Deassert reset

        // Write some data into the FIFO
        @(posedge clk) input_data = 16'h0001;
        @(posedge clk) input_data = 16'h0002;
        @(posedge clk) input_data = 16'h0003;
        @(posedge clk) input_data = 16'h0004;

        // Wait for the MAC operation to complete
        wait(done);

        // Display result
        $display("Result = %0d", result);
        $display("Done = %b", done);

	#5000;

        // Finish simulation
        $finish;
    end

    // Monitor output
    always @(posedge clk) begin
        $monitor("Time: %0t | Input Data: %h | Result: %0d | Done: %b", $time, input_data, result, done);
    end

    // Dump waveform
    initial begin
        $dumpfile("top_module_waveform.vcd");
        $dumpvars(0, test_top_module);
    end

endmodule

