`timescale 1ns/1ps

module test_converter;

    reg [15:0] fixed_in;
    wire [15:0] float_out;

    // Instantiate the convertor module
    converter uut (
        .fixed_in(fixed_in),
        .float_out(float_out)
    );

    initial begin
        $dumpfile("converter.vcd");
        $dumpvars(0, test_converter);

        // Test cases
        fixed_in = 16'h4000;  // Example positive number
        #10;
        $display("Fixed: %h, Float: %h", fixed_in, float_out);

        fixed_in = 16'hC000;  // Example negative number
        #10;
        $display("Fixed: %h, Float: %h", fixed_in, float_out);

        fixed_in = 16'h0001;  // Small positive number
        #10;
        $display("Fixed: %h, Float: %h", fixed_in, float_out);

        fixed_in = 16'h0000;  // Zero
        #10;
        $display("Fixed: %h, Float: %h", fixed_in, float_out);

        fixed_in = 16'hFFFF;  // Maximum negative number
        #10;
        $display("Fixed: %h, Float: %h", fixed_in, float_out);

        $finish;
    end

endmodule

