
module PC (
    input wire clk,
    input wire rst,
    input wire [63:0] nextPC,
    output wire [63:0] PC
);

    reg [63:0] ouputPC;

    assign PC = ouputPC;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ouputPC <= 64'b0;
        end else if (clk) begin
            ouputPC <= nextPC;
        end
    end



endmodule