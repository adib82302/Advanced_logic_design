`timescale 1ns/1ps

module test_imem;

    // Testbench Signals
    reg clk;
    reg rst;
    reg shift_enable;
    reg [15:0] new_value;
    wire [1023:0] data_out;

    // Instantiate the IMEM module
    IMEM uut (
        .clk(clk),
        .rst(rst),
        .shift_enable(shift_enable),
        .new_value(new_value),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        clk = 0;
        rst = 1;
        shift_enable = 0;
        new_value = 16'h0000;

        // Reset
        #10 rst = 0;

        // Insert values
        repeat (4) begin
            @(posedge clk);
            shift_enable = 1;
            new_value = $random;
            @(posedge clk);
            shift_enable = 0;
        end

        // Monitor final data_out
        #50;
        $display("Final Flattened Memory: %h", data_out);

        $finish;
    end

    // Debugging: Display memory and data_out
    always @(posedge clk) begin
        $display("Time: %0t | Memory[0]: %h | Memory[1]: %h | data_out[0:15]: %h",
                 $time, uut.memory[0], uut.memory[1], data_out[15:0]);
    end

endmodule

