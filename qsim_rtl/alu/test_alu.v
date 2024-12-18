`timescale 1ns/1ps
`define SD #0.010
`define HALF_CLOCK_PERIOD #5
`define QSIM_OUT_FN "./alu_qsim.out"

module test_alu_mac;

    // Declare signals
    reg clk;
    reg reset;
    reg [15:0] d [0:63];      // IMEM values
    reg [15:0] cmem [0:63];   // CMEM values
    wire [31:0] out;
    wire done;

    // Instantiate the alu_mac module
    alu_mac uut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .cmem(cmem),
        .out(out),
        .done(done)
    );

    integer i;
    integer d_file, cmem_file, out_file;
    reg [15:0] d_temp, cmem_temp;

    // Clock toggle every 5 time units
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize the clock and reset signals
        clk = 0;
        reset = 1;

        // Open input files for reading `d` and `cmem`
       d_file = $fopen(",,/..matlab/alu/input_samples_int.txt", "r");
        cmem_file = $fopen("../../matlab/alu/coeffs.txt", "r");

        // Initialize CMEM from file
        if (cmem_file) begin
            for (i = 0; i < 64; i = i + 1) begin
                $fscanf(cmem_file, "%h\n", cmem_temp);
                cmem[i] = cmem_temp;
            end
        end else begin
            $display("Error opening CMEM input file.");
            $finish;
        end

        $fclose(cmem_file);

        // Initialize IMEM (d) to 0
        for (i = 0; i < 64; i = i + 1) begin
            d[i] = 16'h0000;
        end

        // Release reset
        #15 reset = 0;
    end

    // Open output file for saving results
    initial begin
        out_file = $fopen("/mnt/data/alu_output.txt", "w");
        if (!out_file) begin
            $display("Error opening output file.");
            $finish;
        end
    end

    // Update IMEM (d) values with new data each cycle when done signal is high
    always @(posedge done) begin
        $fwrite(out_file, "Accumulated result at time %0t: %0d\n", $time, out);

        // Re-read a new value for IMEM (d) from the input file
        d_file = $fopen("/mnt/data/d_input.txt", "r");
        if (d_file) begin
            for (i = 0; i < 64; i = i + 1) begin
                if (!$feof(d_file)) begin
                    $fscanf(d_file, "%h\n", d_temp);
                    d[i] = d_temp;
                end
            end
        end else begin
            $display("Error re-opening IMEM input file.");
            $finish;
        end
        $fclose(d_file);
    end

    // Generate the VCD file for waveform viewing
    initial begin
        $dumpfile("/mnt/data/alu_mac_test.vcd");
        $dumpvars(0, test_alu_mac);
    end

    // End the simulation after 550 units
    initial begin
        #550;
        $fclose(out_file);
        $finish;
    end

endmodule




