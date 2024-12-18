module top_module (
    input wire clk,                // Write clock
    input wire fast_clk,           // Read clock
    input wire reset,              // Reset signal
    input wire [15:0] input_data,  // Input data to FIFO
    input wire [1023:0] cmem_data_in, // CMEM data input

    output wire [31:0] result,     // Final FIR filter result
    output wire done               // Overall operation done flag
);

    // Internal control signals
    wire write_enable;      // FIFO write enable
    wire read_enable;       // FIFO read enable
    wire shift_enable;      // IMEM shift enable
    wire fifo_empty;        // FIFO empty flag
    wire fifo_full;         // FIFO full flag
    wire mac_done;          // ALU MAC operation done

    // Instantiate the control module
    control control_inst (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .mac_done(mac_done),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .shift_enable(shift_enable),
        .done(done)
    );

    // Instantiate the datapath module
    datapath datapath_inst (
        .clk(clk),
        .fast_clk(fast_clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .shift_enable(shift_enable),
        .input_data(input_data),
        .cmem_data_in(cmem_data_in),
        .result(result),
        .fifo_empty(fifo_empty),
        .fifo_full(fifo_full),
        .done(mac_done)
    );

endmodule

