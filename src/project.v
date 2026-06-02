module tt_um_mini_cpu (
    input  wire [7:0] ui_in,
    output reg  [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
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
    if(!rst_n) begin
        R0 <= 0;
        R1 <= 0;
        R2 <= 0;
        R3 <= 0;
        uo_out <= 0;
    end
    else begin
        case(opcode)

        2'b10: begin
            case(rd)
                2'b00: R0 <= imm;
                2'b01: R1 <= imm;
                2'b10: R2 <= imm;
                2'b11: R3 <= imm;
            endcase
        end

        2'b00: begin
            case(rd)
                2'b00: R0 <= R0 + (rs==0 ? R0 :
                                   rs==1 ? R1 :
                                   rs==2 ? R2 : R3);

                2'b01: R1 <= R1 + (rs==0 ? R0 :
                                   rs==1 ? R1 :
                                   rs==2 ? R2 : R3);

                2'b10: R2 <= R2 + (rs==0 ? R0 :
                                   rs==1 ? R1 :
                                   rs==2 ? R2 : R3);

                2'b11: R3 <= R3 + (rs==0 ? R0 :
                                   rs==1 ? R1 :
                                   rs==2 ? R2 : R3);
            endcase
        end

        2'b11: begin
            case(rd)
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
