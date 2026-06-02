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

    reg [7:0] R0;
    reg [7:0] R1;
    reg [7:0] R2;
    reg [7:0] R3;

    wire [1:0] opcode;
    wire [1:0] rd;
    wire [1:0] rs;
    wire [1:0] imm;

    assign opcode = ui_in[7:6];
    assign rd     = ui_in[5:4];
    assign rs     = ui_in[3:2];
    assign imm    = ui_in[1:0];

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            R0 <= 8'd0;
            R1 <= 8'd0;
            R2 <= 8'd0;
            R3 <= 8'd0;
            uo_out <= 8'd0;
        end
        else if (ena) begin

            case (opcode)

                // ADD
                2'b00: begin
                    case (rd)
                        2'b00: R0 <= R0 + ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b01: R1 <= R1 + ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b10: R2 <= R2 + ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b11: R3 <= R3 + ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                    endcase
                end

                // SUB
                2'b01: begin
                    case (rd)
                        2'b00: R0 <= R0 - ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b01: R1 <= R1 - ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b10: R2 <= R2 - ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                        2'b11: R3 <= R3 - ((rs==2'b00)?R0:(rs==2'b01)?R1:(rs==2'b10)?R2:R3);
                    endcase
                end

                // MOVI
                2'b10: begin
                    case (rd)
                        2'b00: R0 <= {6'b0, imm};
                        2'b01: R1 <= {6'b0, imm};
                        2'b10: R2 <= {6'b0, imm};
                        2'b11: R3 <= {6'b0, imm};
                    endcase
                end

                // OUT
                2'b11: begin
                    case (rd)
                        2'b00: uo_out <= R0;
                        2'b01: uo_out <= R1;
                        2'b10: uo_out <= R2;
                        2'b11: uo_out <= R3;
                    endcase
                end

            endcase
        end
    end

endmodule
