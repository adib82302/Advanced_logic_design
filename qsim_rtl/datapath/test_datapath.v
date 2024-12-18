`timescale 1ns / 1ps

module test_datapath;

    // Testbench parameters
    reg clk;                     // Write clock
    reg fast_clk;                // Read clock
    reg reset;                   // Reset signal
    reg write_enable;            // FIFO write enable
    reg read_enable;             // FIFO read enable
    reg shift_enable;            // IMEM shift enable
    reg cen;                     // CMEM enable
    reg wen;                     // CMEM write enable
    reg [5:0] addr;              // CMEM address
    reg [15:0] input_data;       // Input data to FIFO
    reg [1023:0] cmem_data_in;   // Flattened CMEM data

    wire [31:0] result;          // FIR filter result
    wire fifo_empty;             // FIFO empty flag
    wire fifo_full;              // FIFO full flag
    wire done;                   // MAC operation done flag

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns clock period
    end

    initial begin
        fast_clk = 0;
        forever #2.5 fast_clk = ~fast_clk;  // 5 ns clock period
    end

    // Instantiate the datapath module
    datapath uut (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .shift_enable(shift_enable),
        .cen(cen),
        .wen(wen),
        .addr(addr),
        .input_data(input_data),
        .cmem_data_in(cmem_data_in),
        .result(result),
        .fifo_empty(fifo_empty),
        .fifo_full(fifo_full),
        .done(done)
    );

    // Testbench stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        write_enable = 0;
        read_enable = 0;
        shift_enable = 0;
        cen = 0;
        wen = 0;
        addr = 6'b0;
        input_data = 16'h0;
        cmem_data_in = {64{16'h0002}};  // All CMEM elements initialized to 2

        // Waveform dump
        $dumpfile("datapath_waveform.vcd");
        $dumpvars(0, test_datapath);

        // Release reset
        #20 reset = 0;

        // Write data into FIFO
        write_enable = 1;
        repeat (8) begin
            input_data = $random % 16'hFFFF;  // Random 16-bit values
            #10;  // Wait for one clock cycle
        end
        write_enable = 0;

        // Read data from FIFO and process
        read_enable = 1;
        shift_enable = 1;
        #80;  // Allow multiple clock cycles for shifting

        // Trigger MAC operation
        shift_enable = 0;  // Stop IMEM shifting
        read_enable = 0;
        #200;  // Allow sufficient time for MAC processing

        // Verify output
        if (done) begin
            $display("MAC Operation Complete. Result = %0d", result);
        end else begin
            $display("MAC Operation Not Completed!");
        end

        // Test done
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor(
            "Time: %0t | clk: %b | fast_clk: %b | reset: %b | write_enable: %b | read_enable: %b | input_data: %h | fifo_out: %h | result: %d | done: %b",
            $time, clk, fast_clk, reset, write_enable, read_enable, input_data, uut.fifo_inst.read_data, result, done
        );
    end

endmodule

