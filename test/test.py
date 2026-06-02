# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    # Start clock
    cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start())

    # Initialize
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Reset
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1

    # MOVI R0,1
    # opcode=10 rd=00 imm=01
    dut.ui_in.value = 0b10000001
    await ClockCycles(dut.clk, 1)

    # MOVI R1,2
    # opcode=10 rd=01 imm=10
    dut.ui_in.value = 0b10010010
    await ClockCycles(dut.clk, 1)

    # ADD R0,R1
    # opcode=00 rd=00 rs=01
    dut.ui_in.value = 0b00000100
    await ClockCycles(dut.clk, 1)

    # OUT R0
    # opcode=11 rd=00
    dut.ui_in.value = 0b11000000
    await ClockCycles(dut.clk, 1)

    # Allow output to update
    await ClockCycles(dut.clk, 1)

    result = dut.uo_out.value.to_unsigned()

    dut._log.info(f"CPU Output = {result}")

    assert result == 3, f"Expected 3, got {result}"
