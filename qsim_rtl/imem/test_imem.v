module test_imem;

    // Inputs
    reg clk;
    reg rst;
    reg shift_enable;
    reg [15:0] new_value;
    reg [5:0] addr;

    // Output
    wire [15:0] data_out;

    // Instantiate the IMEM module
    IMEM uut (
        .clk(clk),
        .rst(rst),
        .shift_enable(shift_enable),
        .new_value(new_value),
        .addr(addr),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, test_imem);

        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        rst = 1;
        shift_enable = 0;
        new_value = 16'h0000;
        addr = 6'b000000;

        // Release reset
        #10 rst = 0;

        // Insert new value at IMEM[0]
        #10 shift_enable = 1; new_value = 16'hAAAA;

        // Insert another value at IMEM[0], causing a shift
        #10 new_value = 16'hBBBB;

        // Insert another value at IMEM[0], causing another shift
        #10 new_value = 16'hCCCC;

        // Disable shift and read values from specific addresses
        #10 shift_enable = 0; addr = 6'd0; // Read IMEM[0]
        #10 addr = 6'd1;                   // Read IMEM[1]
        #10 addr = 6'd2;                   // Read IMEM[2]

        // End simulation
        #20 $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time: %t | Addr: %d | Data Out: %h", $time, addr, data_out);
    end

endmodule

