`define HALF_CLOCK_PERIOD 5
`define QSIM_OUT_FN "./qsim.out"
`define MATLAB_OUT_FN "./fir.results"

module testbench();

    // Signal Declarations
    reg clk;
    reg resetn;
    reg [15:0] input_signal; // Single input for simplicity
    reg [15:0] coeff [0:63]; // Coefficients
    wire [15:0] fir_out;

    integer qsim_out_file;
    integer matlab_out_file;
    integer error_count = 0;

    // FIR Filter Instance
    fir_filter fir_inst (
        .clk(clk),
        .resetn(resetn),
        .din(input_signal),
        .dout(fir_out)
    );

    // Clock Generation
    always begin
        #`HALF_CLOCK_PERIOD clk = ~clk;
    end

    // Initialize Inputs and Coefficients
    task initialize_inputs_and_coeffs();
        integer i;
        begin
            input_signal = 0;
            for (i = 0; i < 64; i = i + 1) begin
                coeff[i] = 16'h0001; // Example: all coefficients are 1
            end
        end
    endtask

    // Testbench Procedure
    initial begin
        // Open Files
        qsim_out_file = $fopen(`QSIM_OUT_FN, "w");
        matlab_out_file = $fopen(`MATLAB_OUT_FN, "r");

        if (qsim_out_file == 0 || matlab_out_file == 0) begin
            $display("Error: Unable to open one or more files.");
            $finish;
        end

        // Initialize
        clk = 0;
        resetn = 0;
        initialize_inputs_and_coeffs();
        @(posedge clk);
        resetn = 1;

        // Start Test
        for (integer i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            input_signal = $random % 32768; // Random input signal

            // Compare with Matlab Results
            integer matlab_out;
            integer ret_read = $fscanf(matlab_out_file, "%d", matlab_out);
            if (ret_read != 1) begin
                $display("Error: Failed to read Matlab output.");
                $finish;
            end

            $fwrite(qsim_out_file, "%d\n", fir_out);

            if (fir_out !== matlab_out) begin
                error_count = error_count + 1;
                $display("Mismatch: QSIM = %d, MATLAB = %d", fir_out, matlab_out);
            end
        end

        // Summary
        if (error_count > 0) begin
            $display("Test Failed: %d mismatches detected.", error_count);
        end else begin
            $display("Test Passed: All results match.");
        end

        // Close Files and Finish
        $fclose(qsim_out_file);
        $fclose(matlab_out_file);
        $finish;
    end

endmodule

