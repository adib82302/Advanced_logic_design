`timescale 1ns/1ps

module fifo_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 16;

    // Testbench signals
    reg clk;             // Write clock
    reg fast_clk;        // Read clock
    reg write_reset;
    reg read_reset;
    reg write_enable;
    reg read_enable;
    reg [DATA_WIDTH-1:0] write_data;
    wire [DATA_WIDTH-1:0] read_data;
    wire empty_flag;
    wire full_flag;

    // Loop variable
    reg [31:0] i;

    // Instantiate the FIFO
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) uut (
        .clk(clk),
        .write_reset(write_reset),
        .write_enable(write_enable),
        .write_data(write_data),
        .fast_clk(fast_clk),
        .read_reset(read_reset),
        .read_enable(read_enable),
        .read_data(read_data),
        .empty_flag(empty_flag),
        .full_flag(full_flag)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Write clock with 20 ns period
    end

    initial begin
        fast_clk = 0;
        forever #5 fast_clk = ~fast_clk; // Read clock with 10 ns period
    end

    // Test logic
    initial begin
        // Initialize inputs
        write_reset = 1;
        read_reset = 1;
        write_enable = 0;
        read_enable = 0;
        write_data = 0;

        // Apply resets
        #25;
        write_reset = 0;
        read_reset = 0;

        // Write data into the FIFO
        @(posedge clk);
        write_enable = 1;
        for (i = 0; i < FIFO_DEPTH - 2; i = i + 1) begin
            write_data = i;
            @(posedge clk);
        end
        write_enable = 0;

        // Delay before starting read
        #50;

        // Read data from the FIFO
        @(posedge fast_clk);
        read_enable = 1;
        for (i = 0; i < FIFO_DEPTH - 2; i = i + 1) begin
            @(posedge fast_clk);
            $display("Read data: %d, Empty: %b, Full: %b", read_data, empty_flag, full_flag);
        end
        read_enable = 0;

        // End of simulation
        #50;
        $stop;
    end

endmodule

