`timescale 1ns / 1ps

module test_control;

    // Signals for DUT (Device Under Test)
    reg clk;
    reg fast_clk;
    reg reset;
    reg fifo_full;
    reg fifo_empty;
    reg mac_done;

    wire write_enable;
    wire read_enable;
    wire shift_enable;
    wire start_mac;
    wire done;

    // Instantiate the DUT (control module)
    control uut (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .mac_done(mac_done),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .shift_enable(shift_enable),
        .start_mac(start_mac),
        .done(done)
    );

    // Clock generation for write clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Clock generation for fast read clock
    initial begin
        fast_clk = 0;
        forever #3 fast_clk = ~fast_clk; // 6ns clock period
    end

    // Testbench stimulus
    initial begin
        // Monitor key signals
        $monitor("Time: %0t | reset: %b | fifo_full: %b | fifo_empty: %b | mac_done: %b | write_enable: %b | read_enable: %b | shift_enable: %b | start_mac: %b | done: %b", 
                 $time, reset, fifo_full, fifo_empty, mac_done, write_enable, read_enable, shift_enable, start_mac, done);

        // Waveform Dump for Simulation
        $dumpfile("test_control_waveform.vcd");
        $dumpvars(0, test_control);

        // Step 1: Apply Reset
        reset = 1;
        fifo_full = 0;
        fifo_empty = 1;
        mac_done = 0;
        #20 reset = 0;

        // Step 2: FIFO Write Enable - Simulate Non-Full FIFO
        fifo_full = 0; fifo_empty = 1;
        #100;

        // Step 3: FIFO Full - Write should stop
        fifo_full = 1;
        #50;

        // Step 4: FIFO Read Enable - Simulate Reading Data
        fifo_full = 0; fifo_empty = 0;
        mac_done = 0;
        #100;

        // Step 5: IMEM Shift and Start MAC Operation
        #20;
        mac_done = 0;  // MAC still processing
        #100;

        // Step 6: MAC Done
        mac_done = 1;
        #50;

        // Step 7: FIFO Empty Again - Return to Idle
        fifo_empty = 1;
        mac_done = 0;
        #100;

        // End Simulation
        $display("Testbench complete.");
        $finish;
    end
endmodule

