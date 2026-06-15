# mips-single-cycle-processor
32-bit Single Cycle MIPS Processor implemented in Verilog HDL with simulation and testbench.

The project is designed to demonstrate the fundamental principles of CPU architecture, control logic, and data path design for the core instruction set.

## Introduction
The single-cycle microarchitecture executes an entire instruction in one cycle : instruction fetch, instruction decode, execute, write back, and program counter update occurs within a single clock cycle.
The CPU implements the core MIPS instruction set, covering R-type, I-type, and J-type instruction formats. 

### Supported Instructions
The implementation supports standard instructions from the MIPS ISA, including:
- R-type (Register): add, sub, and, or, slt, xor, xnor — opcode + rs + rt + rd + shamt + funct
- I-type (Immediate): addi, andi, ori, slti, lw, sw, beq, bne, lui — opcode + rs + rt + immediate
- J-type (Jump): j — opcode + address

## Architecture and Data Path
Referring to the figure below. I have written the RTL Verilog files for all submodules of the MIPS processor (e.g. Program Counter (PC), Instruction Memory, Register File, ALU, Data Memory, and the necessary Control Unit and Sign Extender logic.). Then, implemented the top module.


