# mips-single-cycle-processor
32-bit Single Cycle MIPS Processor implemented in Verilog HDL with simulation and testbench.

The project is designed to demonstrate the fundamental principles of CPU architecture, control logic, and data path design for the core instruction set.

## Introduction
In this project, I have implemented a 32-bit single-cycle microarchitecture MIPS processor based on Harvard Architecture. The single-cycle microarchitecture executes an entire instruction in one cycle : instruction fetch, instruction decode, execute, write back, and program counter update occurs within a single clock cycle.
The CPU implements the core MIPS instruction set, covering R-type, I-type, and J-type instruction formats. 

### Supported Instructions
The implementation supports standard instructions from the MIPS ISA, including:
- R-type (Register): add, sub, and, or, slt, xor, xnor — opcode + rs + rt + rd + shamt + funct

- I-type (Immediate): addi, lw, sw, slt, beq, bne — opcode + rs + rt + immediate

- J-type (Jump): j — opcode + address

## Architecture and Data Path
Referring to the figure below. I have written the RTL Verilog files for all submodules of the MIPS processor (e.g. Program Counter (PC), Instruction Memory, Register File, ALU, Data Memory, and the necessary Control Unit and Sign Extender logic.). Then, implemented the top module.

<img width="1203" height="651" alt="image" src="https://github.com/user-attachments/assets/96d374ec-d1f2-42da-820a-3e6ba3738b8f" />

## Top Module View:
The processor is composed of a datapath and a controller. The controller is internally composed of the main decoder and the ALU decoder. The two figures below show a block diagram of the single-cycle MIPS processor interfaced to external memories 

<img width="864" height="764" alt="image" src="https://github.com/user-attachments/assets/222b2365-2292-43f3-a9c0-2cf71fccc774" />

