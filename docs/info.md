<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a simple 8-bit RISC-inspired processor with four 8-bit registers (R0-R3). The processor executes instructions received through the 8-bit input bus (`ui_in`) on each clock cycle.

Supported instructions:

- ADD: Adds two registers
- SUB: Subtracts one register from another
- MOVI: Loads a 2-bit immediate value into a register
- OUT: Sends a register value to the output bus

Instruction format:

[7:6] Opcode  
[5:4] Destination Register (Rd)  
[3:2] Source Register (Rs)  
[1:0] Immediate Value (Imm)

Example program:

MOVI R0,1  
MOVI R1,2  
ADD R0,R1  
OUT R0

Output: 3

## How to test

1. Apply reset by setting `rst_n = 0`.
2. Release reset by setting `rst_n = 1`.
3. Apply instructions through `ui_in`.
4. Provide a clock pulse after each instruction.
5. Observe the result on `uo_out`.

Example instruction sequence:

MOVI R0,1 → 10000001  
MOVI R1,2 → 10010010  
ADD R0,R1 → 00000100  
OUT R0 → 11000000

Expected output:

00000011 (decimal 3)

## External hardware

No external hardware is required.

Optional:
- LEDs connected to `uo_out`
- Logic analyzer for observing outputs
