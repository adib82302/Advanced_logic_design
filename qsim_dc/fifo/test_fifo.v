`timescale 1ns/1ps

module fifo_tb;

    // Testbench signals
    reg clk;             // Write clock
    reg fast_clk;        // Read clock
    reg write_reset;
    reg read_reset;
    reg write_enable;
    reg read_enable;
    reg [7:0] write_data; // 8-bit data width as defined in netlist
    wire [7:0] read_data; // 8-bit data width as defined in netlist
    wire empty_flag;
    wire full_flag;

    // Loop variable for Verilog
    reg [31:0] i;

    // Instantiate the FIFO
    fifo uut (
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
        // Enable VCD dumping
        $dumpfile("fifo_tb.vcd"); // Specify the VCD file name
        $dumpvars(0, fifo_tb);    // Dump all variables in the current module and below

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
        for (i = 0; i < 14; i = i + 1) begin
            write_data = i;
            @(posedge clk);
        end
        write_enable = 0;

        // Delay before starting read
        #50;

        // Read data from the FIFO
        @(posedge fast_clk);
        read_enable = 1;
        for (i = 0; i < 14; i = i + 1) begin
            @(posedge fast_clk);
            $display("Read data: %d, Empty: %b, Full: %b", read_data, empty_flag, full_flag);
        end
        read_enable = 0;

        // End of simulation
        #50;
        $finish; // End simulation and close the VCD file
    end

endmodule

