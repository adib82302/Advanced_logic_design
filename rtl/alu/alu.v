module alu_mac (
    input wire clk,
    input wire reset,
    input wire [15:0] d [0:63],     // 64 inputs, 16-bit fixed-point
    input wire [15:0] cmem [0:63],  // 64 coefficients, 16-bit fixed-point
    output reg [15:0] dout_fp, // Output in 16-bit floating-point
    output reg valid_out       // Output valid signal
);

    reg signed [15:0] x, b;    // Temporary registers for input and coefficient
    reg signed [31:0] acc;     // Accumulator
    reg [5:0] tap_index;       // Current tap index

    // FX2FP Converter
    function [15:0] fx_to_fp;
        input signed [31:0] fixed_value;
        reg [15:0] exponent;
        reg [15:0] mantissa;
        begin
            if (fixed_value == 0) begin
                fx_to_fp = 16'h0000; // FP representation of 0
            end else begin
                exponent = 15 + $clog2(fixed_value);
                mantissa = fixed_value >> (exponent - 15);
                fx_to_fp = {1'b0, exponent[4:0], mantissa[9:0]}; // FP16 format
            end
        end
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc <= 0;
            tap_index <= 0;
            valid_out <= 0;
        end else begin
            if (tap_index < 64) begin
                // Extract current input and coefficient
                x <= d[(tap_index * 16) +: 16]; // Current input
                b <= cmem[(tap_index * 16) +: 16]; // Current coefficient
                
                // Multiply and accumulate
                acc <= acc + (x * b);
                tap_index <= tap_index + 1;
                valid_out <= 0;
            end else begin
                // Output the result
                dout_fp <= fx_to_fp(acc); // Convert to FP16
                valid_out <= 1; // Signal computation is complete
                tap_index <= 0; // Reset tap index
                acc <= 0; // Reset accumulator
            end
        end
    end
endmodule

