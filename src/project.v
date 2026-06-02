module tt_um_mini_cpu (
    input  wire [7:0] ui_in,
    output reg  [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // 4 general-purpose registers
    reg [7:0] R [0:3];

    wire [1:0] opcode;
    wire [1:0] rd;
    wire [1:0] rs;
    wire [1:0] imm;

    assign opcode = ui_in[7:6];
    assign rd     = ui_in[5:4];
    assign rs     = ui_in[3:2];
    assign imm    = ui_in[1:0];

    integer i;

   always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ...
    end else begin
        case(opcode)

            2'b00:
                R[rd] <= R[rd] + R[rs];

            2'b01:
                R[rd] <= R[rd] - R[rs];

            2'b10:
                R[rd] <= {6'b0, imm};

            2'b11:
                uo_out <= R[rd];

        endcase
    end
end

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
