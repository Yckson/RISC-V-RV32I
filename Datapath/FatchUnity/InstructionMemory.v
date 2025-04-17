
module InstructionMemory #(
    parameter SIMULACAO = 0
)(
    input wire [31:0] instructionAddress,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];
    reg [31:0] selectedInstruction;


    assign instruction = selectedInstruction;

    always @(*) begin
        selectedInstruction <= memory[instructionAddress[9:2]];
    end

    // For simulation

    generate
        if (SIMULACAO) begin : initialize_memory
            reg [31:0] sVar;

            initial begin
                for (sVar = 0; sVar < 256; sVar = sVar + 1) begin
                    memory[sVar] <= 32'b0;
                end
            end
        end
    endgenerate
    

endmodule