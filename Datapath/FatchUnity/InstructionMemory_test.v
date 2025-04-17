`timescale 1ns/1ps

module InstructionMemory_test;
    // Signals for the Device Under Test (DUT)
    reg [31:0] address;
    wire [31:0] instruction;
    reg clk = 0;

    parameter SIMULACAO = 1;
    
    // Instantiate the instruction memory module
    InstructionMemory #(
        .SIMULACAO(SIMULACAO)
    ) DUT (
        .instructionAddress(address),
        .instruction(instruction)
        // Add other connections if your module has them
    );
    
    // Clock generation (if needed)

    always #5 clk = ~clk;
    
    // Test variables
    integer errors = 0;
    
    // Test sequence
    initial begin
        $display("Starting Instruction Memory testbench");
        
        // Test case 1: Read from address 0
        address = 32'h00000000;
        #10;
        if (instruction !== 32'h00000000) begin // Assuming memory is initialized to 0 or a specific value
            $display("ERROR: Address 0x00000000 should return expected instruction");
            errors = errors + 1;
        end else begin
            $display("PASS: Address 0x00000000 returned expected instruction");
        end
        
        // Test case 2: Read from another address
        address = 32'h00000004; // Next instruction (assuming 4-byte alignment)
        #10;
        if (instruction === 32'h00000000) begin // This assertion should be updated based on expected values
            $display("PASS: Address 0x00000004 returned expected instruction");
        end else begin
            $display("ERROR: Address 0x00000004 did not return expected instruction");
            errors = errors + 1;
        end
        
        // Test case 3: Check non-aligned address (if applicable)
        address = 32'h00000002; // Non-aligned address
        #10;
        // Add assertion based on your memory's behavior with non-aligned addresses
        
        // Test case 4: Read from an address at the end of memory
        address = 32'h000000FC; // Assuming memory size is 256 bytes
        #10;
        // Add assertion based on expected value
        
        // Test case 5: Check memory boundary (if applicable)
        address = 32'h00001000; // Address outside expected memory range
        #10;
        // Add assertion based on expected out-of-bounds behavior
        
        // Final report
        if (errors == 0) begin
            $display("TEST PASSED: All instruction memory tests completed successfully!");
        end else begin
            $display("TEST FAILED: %d errors detected during instruction memory testing", errors);
        end
        
        $finish;
    end
    
    // Optional: Dump waveforms
    initial begin
        $dumpfile("instruction_memory_test.vcd");
        $dumpvars(0, InstructionMemory_test);
    end
endmodule
