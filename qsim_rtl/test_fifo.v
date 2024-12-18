`timescale 1ns / 1ps

module FIFO_tb;

    // Inputs
    reg clk_in;  // Input sampling clock
    reg clk_out; // Core clock
    reg reset;
    reg [15:0] write_data;

    // Outputs
    wire [15:0] read_value;

    // Instantiate the FIFO module
    FIFO uut (
        .clk_in(clk_in),
        .clk_out(clk_out),
        .reset(reset),
        .write_data(write_data),
        .read_value(read_value)
    );

    // Clock generation
    initial begin
        // clk_in: 10 Hz -> Period = 100 ns
        clk_in = 0;
        forever #10 clk_in = ~clk_in; // Toggle every 5 ns
    end

    initial begin
        // clk_out: 20 Hz -> Period = 50 ns
        clk_out = 0;
        forever #100 clk_out = ~clk_out; // Toggle every 2.5 ns
    end 

    // Test logic
    initial begin
        // Initialize inputs
        reset = 1;
        write_data = 0;

        // Include waveform dumping
        $dumpfile("dump.vcd"); // Output file for waveforms
        $dumpvars(0, FIFO_tb); // Dump all signals in this testbench

        // Reset the FIFO
        #8 reset = 0; // Hold reset for 10 ns

        // 2. Write to FIFO until full
      repeat (18) begin
            @(posedge clk_in);
            write_data = $random % 65536;
        end


      /*  // 4. Read all data from FIFO
        $display("Reading from FIFO until empty...");
      repeat (5) begin
            @(posedge clk_out);
            $display("Read: %d", read_value);
        end
      */


        // End simulation
        #60 $finish;
    end

endmodule






















