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

E.g 4 inverters connected to 4 busses:

```SystemVerilog
module inv(input logic[3:0] a,
            output logic [3:0] y);
    assign y = ~a;
endmodule
```

in the code above, the most significant bit of input is a[3], and the least significant bit is a[0], which follows the $little\ endian\ order$.

`assign out = inp1 op inp2;` is called a $continuous\ assignment\ statement$. They end with a semicolon. **Whenever the input changes the output is recomputed**.

=> continuous assignment statements describes combinational logic.

### 4.2.2 Comments and White Space

Comments in SystemVerilog is like that in C++, with `// comment` for single line and `/* comment */` for multiple lines.

SystemVerilog requires no indentation, but indentation keeps a block of code readable.

### 4.2.3 Reduction Operators

Reduction operators imply a _**multiple-input gate acting on a single bus**_:

```SystemVerilog
module and8(input logic [7:0] a,
            output logic     y);

    assign y = &a;

endmodule
```

### 4.2.4 Conditional Assignment

Conditional assignment operator `? :` behaves exactly the same as in C++, and is often used to describe multiplexers:

```SystemVerilog
module mux4(input logic [3:0] d0,d1,d2,d3,
            input logic [1:0] s,
            output logic [3:0] `y);

    y = s[1] ? (s[0] ? d3 : d2) :
               (s[0] ? d1 : d0);

endmodule
```

### 4.2.5 Internal Variables

We can create internal variables to describe non-input and non-output signals.

Unlike conventional programming language, internal variables in SystemVerilog do not need to be placed in order. In other words, _**the order of the expressions doesn't matter.**_

```SystemVerilog
module fulladder(input logic a,b,cin,
                 output logic s,cout);

    logic p,g;
    assign p = a ^ b;   // a XOR b
    assign g = a & b;   // a AND b
    assign s = p ^ cin;
    assign cout = g | (p & cin);

endmodule
```

=> We can first write `assign s = p ^ cin` and then `assign p = a ^ b`. The order doesn't matter.

### 4.2.6 Precedence

The operator precedence in SystemVerilog is much like those in conventional programming languages.

### 4.2.7 Numbers

**Format:** $N'Bvalue$, in which:

- $N$: the size of bits. If not given, the number is assumed to _**have many bits as the expression in which it is being used**_.
- $B$: the base of the $value$ number, which can be $b(binary)$, $d(decimal)$, $o(octal)$ and $h(hexadecimal)$

> e.g:  
> 3'b101 is stored as 101;  
> 8'hAB is stored as 10101011;

_**Exceptions:**_ '0 and '1 is to _**fill all the bits**_ 0 or 1, respectively.

### 4.2.8 Z's and X's

> HDLs use z to imply floating value, and x to inply invalid logic levels.

- z: no inputs;
- x: contradictory inputs, or simultaneous inputs.

```SystemVerilog
module tristatebuffer(input logic[3:0] a,
                      input logic      en,
                      output tri [3:0]);

    assign y = en ? a : 4'bz;

endmodule
```

=> Notice that y is declared as `tri` rather than `logic`. The difference is that:

- `logic` signals can only have a single driver. In other words, the output have a specified input to drive.
- `tri` is a _**Net type**_ in SystemVerilog. Tristate busses can have multiple drivers, and when working, only **1 driver is active at the same time**, or the output will become z (High Impedance, or _**disconnected**_)
