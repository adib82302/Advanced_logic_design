`timescale 1ns/1ps

module test_cmem;

    // Testbench signals
    reg clk;                   // Clock signal
    reg rst;                   // Reset signal
    reg cen;                   // Chip enable (active low)
    reg wen;                   // Write enable (active low)
    reg [5:0] addr;            // 6-bit address
    reg [15:0] data_in;        // 16-bit data input
    wire [15:0] data_out;      // 16-bit data output

    // Internal test signals
    reg [15:0] expected_data [0:63];  // Expected memory content
    integer i;

    // Instantiate the SRAM module
    cmem uut (
        .Q(data_out),    // SRAM output
        .CLK(clk),       // Clock
        .CEN(cen),       // Chip enable
        .WEN(wen),       // Write enable
        .A(addr),        // Address
        .D(data_in)      // SRAM input
    );

    // Clock generation: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    // Task: Reset SRAM
    task reset_sram;
        begin
            rst = 1;
            cen = 1;
            wen = 1;
            addr = 6'b0;
            data_in = 16'b0;
            #20;                // Hold reset for a few cycles
            rst = 0;
            $display("SRAM Reset Completed.");
        end
    endtask

    // Task: Write to SRAM with timing stabilization
    task write_to_sram;
        input [5:0] write_addr;
        input [15:0] write_data;
        begin
            #2;                // Add delay to stabilize signals
            cen = 0;           // Chip enable active
            wen = 0;           // Write enable active
            addr = write_addr; // Address input
            data_in = write_data; // Data input
            #10;               // Hold for one clock cycle
            cen = 1;           // Disable chip
            wen = 1;           // Disable write
            #2;                // Add delay to stabilize after write
        end
    endtask

    // Task: Read from SRAM with timing stabilization
    task read_from_sram;
        input [5:0] read_addr;
        begin
            #2;                // Add delay to stabilize signals
            cen = 0;           // Chip enable active
            wen = 1;           // Write enable inactive (read mode)
            addr = read_addr;  // Address input
            #10;               // Hold for one clock cycle
            cen = 1;           // Disable chip
            #2;                // Add delay to stabilize after read
        end
    endtask

    // Main Testbench Procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        cen = 1;
        wen = 1;
        addr = 6'b0;
        data_in = 16'b0;

        // Apply reset
        reset_sram();

        // Initialize expected data
        for (i = 0; i < 64; i = i + 1) begin
            expected_data[i] = i; // Test data: 0x0000 to 0x003F
        end

        // Write test data into SRAM
        $display("Writing data to SRAM...");
        for (i = 0; i < 64; i = i + 1) begin
            write_to_sram(i[5:0], expected_data[i]);
        end

        // Read back and verify data
        $display("Reading data back from SRAM...");
        for (i = 0; i < 64; i = i + 1) begin
            read_from_sram(i[5:0]);
            #1; // Small delay to ensure data capture
            if (data_out !== expected_data[i]) begin
                $display("ERROR: Address %0d, Expected: %h, Received: %h", i, expected_data[i], data_out);
            end else begin
                $display("PASS: Address %0d, Data: %h", i, data_out);
            end
        end

        // End simulation
        $display("SRAM Test Completed.");
        $finish;
    end

endmodule

