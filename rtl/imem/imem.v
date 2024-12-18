module IMEM (
    input clk,                       // Clock signal
    input rst,                       // Reset signal
    input shift_enable,              // Shift enable signal
    input [15:0] new_value,          // New value to insert at IMEM[0]
    input [5:0] addr,                // 6-bit address to select a memory location
    output reg [15:0] data_out       // 16-bit data output
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

    // Read Logic
    always @(*) begin
        // Output the value at the specified address
        data_out = memory[addr];
    end

endmodule

