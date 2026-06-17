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

## Implementation Details
The CPU is entirely modeled in Verilog HDL using a modular approach. Each major component is implemented as a separate module for clarity and ease of testing.

Key modules include:
* Control Unit: Decodes the instruction opcode/funct fields and generates all necessary control signals for the data path components.
* Register File: Stores and retrieves the 32 general-purpose registers (R0 through R31).
* ALU (Arithmetic Logic Unit): Performs all arithmetic and logical operations required by the instruction set, controlled by ALU control.
* Sign/Zero Extender: Logic to correctly extend the 16-bit immediate field to 32 bits for I-type instructions.
* PC + Adder/Mux Logic: Calculates the next PC value, handling sequential execution, branches, and jumps.

## Tools and Verification

### Simulation and Module Verification
**Icarus Verilog** was used for the entire simulation process.

- Each core module (ALU, Register File, Control Unit) was individually verified 
  using dedicated testbenches to ensure functional correctness. There are dedicated 
  shell scripts in the testbench/ directory which can be run using:

# Compile and simulate
iverilog -o mips_tb *.v
vvp mips.out

# View waveforms
surfer mips_full.vcd

# Generate synthesized netlist
yosys -p "read_verilog *.v; synth; write_json mips.json"

# Generate RTL schematic
netlistsvg mips.json -o mips.svg

## Requirements

- **Icarus Verilog** — to compile and simulate the RTL code
- **Surfer** — to view simulation waveforms
- **Yosys** — for RTL synthesis and schematic generation
- **netlistsvg** — to render RTL schematics as SVG

## References

1. Harris, D. & Harris, S. — *Digital Design and Computer Architecture* — MIPS ISA Reference
2. MIPS32 Architecture for Programmers, Volume II: The MIPS32 Instruction Set


