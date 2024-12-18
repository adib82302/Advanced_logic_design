`timescale 1ns / 1ps


module fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 16
) (
    input wire clk,              // Write clock
    input wire write_reset,      
    input wire write_enable,
    input wire [DATA_WIDTH-1:0] write_data,

    input wire fast_clk,         // Read clock
    input wire read_reset,
    input wire read_enable,
    output reg [DATA_WIDTH-1:0] read_data,

    output reg empty_flag,
    output reg full_flag
);

    // Calculating the width for addressing FIFO depth
    localparam POINTER_WIDTH = $clog2(FIFO_DEPTH);

    // FIFO memory
    reg [DATA_WIDTH-1:0] memory[FIFO_DEPTH-1:0];

    // Write domain registers
    reg [POINTER_WIDTH:0] write_pointer;
    reg [POINTER_WIDTH:0] write_pointer_gray;
    reg [POINTER_WIDTH:0] read_pointer_gray_sync_w;

    // Read domain registers
    reg [POINTER_WIDTH:0] read_pointer;
    reg [POINTER_WIDTH:0] read_pointer_gray;
    reg [POINTER_WIDTH:0] write_pointer_gray_sync_r;

    // Reset logic for write domain
    always @(posedge clk or posedge write_reset) begin
        if (write_reset) begin
            write_pointer <= 0;
            write_pointer_gray <= 0;
        end else if (write_enable && !full_flag) begin
            memory[write_pointer[POINTER_WIDTH-1:0]] <= write_data;
            write_pointer <= write_pointer + 1;
            write_pointer_gray <= (write_pointer + 1) ^ ((write_pointer + 1) >> 1); // Convert to gray code
        end
    end

    // Reset logic for read domain
    always @(posedge fast_clk or posedge read_reset) begin
        if (read_reset) begin
            read_pointer <= 0;
            read_pointer_gray <= 0;
        end else if (read_enable && !empty_flag) begin
            read_data <= memory[read_pointer[POINTER_WIDTH-1:0]];
            read_pointer <= read_pointer + 1;
            read_pointer_gray <= (read_pointer + 1) ^ ((read_pointer + 1) >> 1); // Convert to gray code
        end
    end

    // Synchronize pointers across clock domains
    always @(posedge clk) begin
        read_pointer_gray_sync_w <= read_pointer_gray; // Synchronize read pointer into write domain
    end

    always @(posedge fast_clk) begin
        write_pointer_gray_sync_r <= write_pointer_gray; // Synchronize write pointer into read domain
    end

    // Empty and Full flag logic
    always @(*) begin
        empty_flag = (read_pointer_gray == write_pointer_gray_sync_r);
        full_flag = (write_pointer_gray == {~read_pointer_gray_sync_w[POINTER_WIDTH:POINTER_WIDTH-1], read_pointer_gray_sync_w[POINTER_WIDTH-2:0]});
    end
endmodule

