# Pipelined-Processor



This project is a VHDL-based implementation of an 8-bit pipelined MIPS processor designed to simulate parallel instruction execution using a five-stage architecture (IF, ID, EX, MEM, WB). It supports basic RISC instructions like lw, sw, add, sub, or, beq, and j, with built-in hazard management through a forwarding unit and hazard detection logic that handles data and control hazards by forwarding values or stalling the pipeline when needed. The design includes modular components such as the control unit, ALU control, register file, instruction/data memory, and pipeline registers, offering a clear and scalable approach to processor design in structural VHDL.
