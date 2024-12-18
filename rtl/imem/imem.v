// IMEM Module with Shift Logic
module IMEM (
    input wire clk,                       // Clock signal
    input wire rst,                       // Reset signal
    input wire shift_enable,              // Shift enable signal
    input wire [15:0] new_value,          // New value to insert at IMEM[0]
    output wire [1023:0] data_out         // Flattened IMEM data output (64 elements)
);

    // Define memory array: 64 words, each 16 bits wide
    reg [15:0] memory [0:63];
    integer i;

    // Reset and Shift Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all memory values to 0
            for (i = 0; i < 64; i = i + 1) begin
                memory[i] <= 16'b0;
            end
        end else if (shift_enable) begin
            // Shift all memory values down
            for (i = 63; i > 0; i = i - 1) begin
                memory[i] <= memory[i-1];
            end
            // Insert the new value at IMEM[0]
            memory[0] <= new_value;
        end
    end

    // Flatten memory data for output
    genvar j;
    generate
        for (j = 0; j < 64; j = j + 1) begin : flatten_imem
            assign data_out[(j*16) +: 16] = memory[j];
        end
    endgenerate

endmodule

