module converter (
    input wire [15:0] fixed_in,    // 16-bit fixed-point input
    output reg [15:0] float_out    // 16-bit FP16 output
);
    // Internal signals
    reg sign;                      // Sign bit
    reg [4:0] exponent;            // Exponent (5 bits)
    reg [10:0] mantissa;           // Mantissa (10 bits)
    reg [15:0] magnitude;          // Absolute value of fixed_in
    reg [4:0] leading_one;         // Position of leading one

    always @(*) begin
        // Step 1: Determine the sign and magnitude
        sign = fixed_in[15];                       // Extract sign bit
        magnitude = sign ? (~fixed_in + 1) : fixed_in; // Absolute value

        // Step 2: Find the position of the leading 1 (leading_one)
        casez (magnitude)
            16'b1???????????????: leading_one = 5'd15;
            16'b01??????????????: leading_one = 5'd14;
            16'b001?????????????: leading_one = 5'd13;
            16'b0001????????????: leading_one = 5'd12;
            16'b00001???????????: leading_one = 5'd11;
            16'b000001??????????: leading_one = 5'd10;
            16'b0000001?????????: leading_one = 5'd9;
            16'b00000001????????: leading_one = 5'd8;
            16'b000000001???????: leading_one = 5'd7;
            16'b0000000001??????: leading_one = 5'd6;
            16'b00000000001?????: leading_one = 5'd5;
            16'b000000000001????: leading_one = 5'd4;
            16'b0000000000001???: leading_one = 5'd3;
            16'b00000000000001??: leading_one = 5'd2;
            16'b000000000000001?: leading_one = 5'd1;
            16'b0000000000000001: leading_one = 5'd0;
            default: leading_one = 5'd0;
        endcase

        // Step 3: Calculate the exponent (bias = 15)
        if (magnitude == 16'b0) begin
            exponent = 5'd0;    // Zero case
            mantissa = 10'd0;
        end else begin
            exponent = 5'd15 + leading_one; // Adjust for bias
            // Normalize the magnitude and extract the mantissa
            mantissa = (magnitude << (15 - leading_one)) >> 5; 
        end

        // Step 4: Assemble the FP16 output
        float_out = {sign, exponent, mantissa[9:0]};
    end
endmodule



