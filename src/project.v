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
            for(i = 0; i < 4; i = i + 1)
                R[i] <= 8'd0;

            uo_out <= 8'd0;
        end
        else begin
            case(opcode)

                // 00 = ADD
                2'b00:
                    R[rd] <= R[rd] + R[rs];

                // 01 = SUB
                2'b01:
                    R[rd] <= R[rd] - R[rs];

                // 10 = MOVI
                2'b10:
                    R[rd] <= {6'b000000, imm};

                // 11 = OUT
                2'b11:
                    uo_out <= R[rd];

            endcase
        end
    end

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
