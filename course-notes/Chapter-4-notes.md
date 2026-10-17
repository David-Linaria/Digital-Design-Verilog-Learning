## 4.1 Introduction

### 4.1.1 Modules

Two general styles of describing module functionality:

- Behavioral: describes _**what the module does**_;
- Structural: describes _**how a module is built**_ from smaller pieces;

> **E.g of SystemVerilog Language:**

```SystemVerilog
module sillyfunction(input logic a, b, c,\
output logic y);\
assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c\
endmodule
```

A SystemVerilog module begins with the module name and a listing of the inputs and outputs. The assign statement describes combinational logic. ~ indicates NOT, & indicates AND, and | indicates OR.

### 4.1.3 Simulation and Synthesis

=> The two major purposes of HDLs are logic simulation and synthesis:

- $Simulation$: inputs are applied to a module to check that the module works correctly;
- $Synthesis$: textural description of a module is transformed into logic gates.

Specifically, we divide HDL code into $synthesizable$ modules and a $testbench$.

> One of the most common mistakes is to think HDL as a computer program rather than as a shorthand for describing digital hardware.

## 4.2 Combinational Logic

### 4.2.1 Bitwise Operators

_**Bitwise Operators**_ act on single-bit signals or on multibit busses:
