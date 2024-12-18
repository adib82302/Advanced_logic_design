module fifo (
    input clk,
    input fast_clk,
    input reset,
    input [15:0] write_data,
    output reg [15:0] read_value
);

    // Memory to store 16-bit values
    reg [15:0] memory [0:15];

    // Write and read pointers
    reg [4:0] write_pointer;
    reg [4:0] read_pointer;

    // Status flags
    reg empty_flag;
    reg full_flag;

    integer i;

    // Write logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1) begin
                memory[i] <= 0;
            end
            write_pointer <= 0;
            read_pointer <= 0;
            empty_flag <= 1;
            full_flag <= 0;
        end else if (!full_flag) begin
            memory[write_pointer] <= write_data;
            write_pointer <= (write_pointer + 1) % 16;
        end
    end

    // Read logic
    always @(posedge fast_clk or posedge reset) begin
        if (reset) begin
            read_pointer <= 0;
            write_pointer <= 0;
            read_value <= 0;
            empty_flag <= 1;
            full_flag <= 0;
        end else if (!empty_flag) begin
            read_value <= memory[read_pointer];
            read_pointer <= (read_pointer + 1) % 16;
        end
    end

    // Status flags
    always @(*) begin
        empty_flag = (write_pointer == read_pointer);
        full_flag = ((write_pointer + 1) % 16 == read_pointer);
    end

endmodule




`timescale 1ns / 1ps

module fifo (
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire read_enable,
    input wire [7:0] write_data,
    output reg [7:0] read_data,
    output reg empty_flag,
    output reg full_flag
);

    // Parameters
    parameter FIFO_DEPTH = 16;
    parameter POINTER_WIDTH = 4; // log2(FIFO_DEPTH)

    // Registers
    reg [7:0] memory[FIFO_DEPTH-1:0];
    reg [POINTER_WIDTH:0] write_pointer; // Extra bit for detecting overflow
    reg [POINTER_WIDTH:0] read_pointer;

    // Reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            write_pointer <= 0;
            read_pointer <= 0;
            empty_flag <= 1;
            full_flag <= 0;
        end else begin
            // Write logic
            if (write_enable && !full_flag) begin
                memory[write_pointer[POINTER_WIDTH-1:0]] <= write_data;
                write_pointer <= write_pointer + 1;
            end

            // Read logic
            if (read_enable && !empty_flag) begin
                read_data <= memory[read_pointer[POINTER_WIDTH-1:0]];
                read_pointer <= read_pointer + 1;
            end

            // Update flags
            empty_flag <= (write_pointer == read_pointer);
            full_flag <= ((write_pointer[POINTER_WIDTH-1:0] == read_pointer[POINTER_WIDTH-1:0]) &&
                          (write_pointer[POINTER_WIDTH] != read_pointer[POINTER_WIDTH]));
        end
    end
endmodule

