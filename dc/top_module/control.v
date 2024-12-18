module control (
    input wire clk,                 // Write clock
    input wire fast_clk,            // Read clock
    input wire reset,               // Reset signal
    input wire fifo_full,           // FIFO full flag
    input wire fifo_empty,          // FIFO empty flag
    input wire mac_done,            // ALU MAC operation done flag

    output reg write_enable,        // FIFO write enable
    output reg read_enable,         // FIFO read enable
    output reg shift_enable,        // IMEM shift enable
    output reg start_mac,           // Start MAC operation
    output reg done                 // Overall operation done flag
);

    // Reset Synchronizer for clk domain
    reg reset_sync1_clk, reset_sync2_clk;
    always @(posedge clk) begin
        reset_sync1_clk <= reset;
        reset_sync2_clk <= reset_sync1_clk;
    end
    wire synced_reset_clk = reset_sync2_clk;

    // Reset Synchronizer for fast_clk domain
    reg reset_sync1_fast, reset_sync2_fast;
    always @(posedge fast_clk) begin
        reset_sync1_fast <= reset;
        reset_sync2_fast <= reset_sync1_fast;
    end
    wire synced_reset_fast = reset_sync2_fast;

    // States for write control (clk domain)
    typedef enum logic [1:0] {
        WRITE_IDLE,   // Idle state for writing
        FIFO_WRITE    // Write data to FIFO
    } write_state_t;

    write_state_t write_state, next_write_state;

    // States for read and MAC control (fast_clk domain)
    typedef enum logic [2:0] {
        READ_IDLE,    // Idle state for reading
        FIFO_READ,    // Read data from FIFO
        IMEM_SHIFT,   // Shift data in IMEM
        START_MAC,    // Start ALU MAC operation
        WAIT_DONE     // Wait for MAC operation to complete
    } read_state_t;

    read_state_t read_state, next_read_state;

    // Write State Machine (clk domain)
    always @(posedge clk or posedge synced_reset_clk) begin
        if (synced_reset_clk) begin
            write_state <= WRITE_IDLE;
        end else begin
            write_state <= next_write_state;
        end
    end

    // Write State Transitions
    always @(*) begin
        case (write_state)
            WRITE_IDLE: begin
                if (!fifo_full)
                    next_write_state = FIFO_WRITE; // Write to FIFO if not full
                else
                    next_write_state = WRITE_IDLE;
            end
            FIFO_WRITE: begin
                if (fifo_full)
                    next_write_state = WRITE_IDLE; // Stop writing when FIFO is full
                else
                    next_write_state = FIFO_WRITE;
            end
            default: next_write_state = WRITE_IDLE;
        endcase
    end

    // Write Enable Output Logic
    always @(posedge clk or posedge synced_reset_clk) begin
        if (synced_reset_clk) begin
            write_enable <= 1'b0;
        end else begin
            write_enable <= (write_state == FIFO_WRITE);
        end
    end

    // Read State Machine (fast_clk domain)
    always @(posedge fast_clk or posedge synced_reset_fast) begin
        if (synced_reset_fast) begin
            read_state <= READ_IDLE;
        end else begin
            read_state <= next_read_state;
        end
    end

    // Read State Transitions
    always @(*) begin
        case (read_state)
            READ_IDLE: begin
                if (!fifo_empty)
                    next_read_state = FIFO_READ; // Read data from FIFO
                else
                    next_read_state = READ_IDLE;
            end
            FIFO_READ: begin
                next_read_state = IMEM_SHIFT;    // Shift to IMEM
            end
            IMEM_SHIFT: begin
                next_read_state = START_MAC;     // Start ALU MAC operation
            end
            START_MAC: begin
                next_read_state = WAIT_DONE;     // Wait for MAC operation to complete
            end
            WAIT_DONE: begin
                if (mac_done)
                    next_read_state = READ_IDLE; // Return to idle after MAC is done
                else
                    next_read_state = WAIT_DONE;
            end
            default: next_read_state = READ_IDLE;
        endcase
    end

    // Output Logic in Fast Clock Domain
    always @(posedge fast_clk or posedge synced_reset_fast) begin
        if (synced_reset_fast) begin
            read_enable <= 1'b0;
            shift_enable <= 1'b0;
            start_mac <= 1'b0;
            done <= 1'b0;
        end else begin
            read_enable <= (read_state == FIFO_READ);
            shift_enable <= (read_state == IMEM_SHIFT);
            start_mac <= (read_state == START_MAC);
            done <= (read_state == WAIT_DONE && mac_done);
        end
    end

endmodule


