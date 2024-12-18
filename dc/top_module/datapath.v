module datapath (
    input wire clk,                  // Write clock
    input wire fast_clk,             // Read clock
    input wire reset,                // Reset signal
    input wire write_enable,         // FIFO write enable
    input wire read_enable,          // FIFO read enable
    input wire shift_enable,         // IMEM shift enable
    input wire cen,                  // CMEM enable
    input wire wen,                  // CMEM write enable
    input wire [5:0] addr,           // CMEM address
    input wire [15:0] input_data,    // Data input to FIFO
    input wire [1023:0] cmem_data_in, // Entire CMEM input data

    output wire [31:0] result,       // FIR filter result
    output wire fifo_empty,          // FIFO empty flag
    output wire fifo_full,           // FIFO full flag
    output wire done                 // MAC operation done flag
);

    // Internal signals
    wire [15:0] fifo_out;            // Output data from FIFO
    wire [15:0] float_data;          // Floating-point converted data
    wire [1023:0] imem_data;         // Flattened IMEM data for ALU MAC (64 elements)
    wire [1023:0] cmem_flat_data;    // Flattened CMEM data for MAC (64 elements)
    wire [31:0] alu_out;             // Result from ALU MAC
    wire mac_done;                   // MAC operation done flag

    // Instantiate FIFO
    fifo #(
        .DATA_WIDTH(16),
        .FIFO_DEPTH(64)
    ) fifo_inst (
        .clk(clk),
        .write_reset(reset),
        .write_enable(write_enable),
        .write_data(input_data),
        .fast_clk(fast_clk),
        .read_reset(reset),
        .read_enable(read_enable),
        .read_data(fifo_out),
        .empty_flag(fifo_empty),
        .full_flag(fifo_full)
    );

    // Instantiate fixed-to-floating-point converter
    converter converter_inst (
        .fixed_in(fifo_out),       // Fixed-point output from FIFO
        .float_out(float_data)     // Floating-point output to IMEM
    );

    // Instantiate IMEM with shift logic
    imem imem_inst (
        .clk(clk),
        .rst(reset),
        .shift_enable(shift_enable),
        .new_value(float_data),    // Use converted floating-point data
        .data_out(imem_data)
    );

    // CMEM provides full 64-tap data
    assign cmem_flat_data = cmem_data_in;

    // Instantiate ALU MAC
    alu_mac alu_mac_inst (
        .clk(fast_clk),
        .reset(reset),
        .d(imem_data),              // Flattened IMEM data
        .cmem(cmem_flat_data),      // Flattened CMEM data
        .out(alu_out),
        .done(mac_done)
    );

    // Assign outputs
    assign result = alu_out;
    assign done = mac_done;

endmodule



