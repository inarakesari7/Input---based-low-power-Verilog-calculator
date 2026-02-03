# Input---based-low-power-Verilog-calculator
Verilog project 

A clock-enabled calculator implemented in Verilog RTL that performs arithmetic operations only when inputs change, reducing unnecessary switching activity.

# Overview
Inputs: operands (A, B), operation select(op), clock, reset
Processing: FSM-controlled arithmetic calculation
Outputs: result and status flags

# Design 
Event-driven (input change) computation using clock enable
Modular RTL design with separate FSM, arithmetic and top level files

# Tools & Technologies
Verilog HDL (RTL design)
Xilinx Vivado (simulation, RTL analysis, synthesis)

# Project Structure
src/ # RTL design files
tb/ # Testbench
