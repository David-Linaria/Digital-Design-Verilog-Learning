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

> HDLs use z to imply floating value, and x to imply invalid logic levels.

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

### 4.2.9 Bit Swizzling

Sometimes we need to operate on the subset of a bus or to concatenate signals from different busses:

```SystemVerilog
assign y = {c[2:1], {3{d[0]}}, c[0], 3'b101}    // y = c2 c1 d0 d0 d0 c0 1 0 1
```

### 4.2.10 Delays

HDL statements can be associated with delays:

```SystemVerilog
'timescale unit/precision
```

in which:

- `timescale` is the keyword of syntax;
- `unit` is the unit for the number in statements;
- `precision` is the precision of simulations.

> If not declared, the default unit and precision are 1ns both.

```SystemVerilog
'timescale 1ns/1ps

module example(input logic a,b,c,
               output logic y);

    logic aa,bb,cc,n1,n2,n3;

    assign #1 {ab, bb, cb} = ~{a, b, c};    // inverters have a delay of 1ns;
    assign #2 n1 = ab & bb & cb;
    assign #2 n2 = a & bb & cb;
    assign #2 n3 = a & bb & c;  // AND gates have a delay of 2ns;
    assign #4 y = n1 | n2 | n3;     // OR gate has a delay of 4ns;

endmodule
```

## 4.3 Structural Modeling

Same as the conventional programming language, we can use $instances$ in SystemVerilog to reduce tedious repetition.

> Example: Building a 4:1 MUX from three 2:1 MUX:

```SystemVerilog
module mux4(input logic [3:0] d0,d1,d2,d3,
            input logic [1:0] s,
            output logic [3:0] y);

    logic [3:0] low, high;

    mux2 lowmux(d0, d1, s[0], low);
    mux2 highmux(d2, d3, s[0], high);
    mux2 finalmux(low, high, s[1], y);

endmodule
```

> Example: Using tristate buffers to build a 2:1 MUX:

```SystemVerilog
module mux2(input logic [3:0] d0, d1,
            input logic s,
            output tri [3:0] y);

    tristate t0(d0, ~s, y);
    tristate t1(d1, s, y);

endmodule
```

=> In general, complex systems are designed $hierarchically$. _**The overall system is described structurally until the pieces are simple enough to be described behaviorally.**_

## 4.4 Sequential Logic

### 4.4.1 Registers

=> The vast majority of modern commercial systems are built with registers using _**positive-edge triggered D flip-flops.**_

In SystemVerilog, `always` statements, signals keep their old value until an event in the $sensitivity\ list$ takes place that explicitly causes them to change.

_**Basic syntax of always statement:**_

```SystemVerilog
always @(sensitivity list)
    statement;  // operandA <= operandB
```

in which:

- `always` can be `always_ff`, `always_latch`, and `always_comb`, which are introduced by SystemVerilog to produce a warning if anything else is implied.
- `<=` is called $nonblocking\ assignment$, it replaces `=` in the `always` statement.

> Example: A 4-bit D flip-flop:

```SystemVerilog
module flop(input logic     clk,
            input logic [3:0] d,
            output logic [3:0] q);

    always_ff @(posedge clk)
        q <= d;

endmodule
```

### 4.4.2 Resettable Registers

Distinguishing synchronous or asynchronous inputs in a schematic can be difficult, but they have big differences in the code.

> Asynchronous RESET Register

```SystemVerilog
module flopar(input logic   clk,
              input logic   reset,
              input logic [3:0] d,
              output logic [3:0] q);

    always_ff @(posedge clk, posedge reset)
        if (reset) q <= 4'b0;
        else       q <= d;

endmodule
```

> Synchronous RESET Register

```SystemVerilog
module flopar(input logic   clk,
              input logic   reset,
              input logic [3:0] d,
              output logic [3:0] q);

    always_ff @(posedge clk)
        if (reset) q <= 4'b0;
        else       q <= d;

endmodule
```

### 4.4.3 Enabled Registers

> Input logic $EN$ is similar to $RESET$ above, but most ofte times $EN$ is not in the sensitivity list.

### 4.4.4 Multiple Registers

In SystemVerilog, a single `always` statement can be used to describe multiple registers connected to the same clock.

> Example: two cascaded registers using the same clock:

```SystemVerilog
module sync(input logic clk,
            input logic d,
            output logic q);

    logic n1;

    always_ff @(posedge clk)
        begin
            n1 <= d;
            q <= n1;
        end

endmodule
```

_**NOTICE: non-blocking assignment `<=` here is extremely important. Regular assignment `=` will perform like the ones in programming language, causing q to sample the new n1 instead of the n1 in the last clock period.**_

### 4.4.5 Latches

The latch becomes opaque when the clock is LOW, retaining its old state.

=> However, not all synthesis tools support latches well. Thus, better use edge-triggered flip-flops instead of latches.

> Example: D latch

```SystemVerilog
module latch(input logic clk,
             input logic d,
             output logic q);

    always_latch    // no sensitivity list because it is auto created in latches.
        if (clk) q <= d;

endmodule
```

## 4.5 More Combinational Logic

In SystemVerilog, `always` can also be used to describe combinational logic. The basic syntax is `always_comb`, which is _**equivalent to**_ `always @(*)`, which:

_**whenever any signals on the right-hand side of `<=` or `=` in the `always` statement change, all the statements will be reevaluated.**_

> Example: a bank of four inverters:

```SystemVerilog
module inv(input logic [3:0] a,
           output logic [3:0] y);

    always_comb begin
        y = ~a;
    end

endmodule
```

> `always_comb` is a specified syntax in SystemVerilog, which can throw a warning when the code inside is not combinational logic.

=> then why bother writing more lines to describe a combinational logic? This is because a much more variety of statements can be used inside the `always` block, for example the `case` statement.

_**!!! KINDS OF ASSIGNMENTS IN SYSTEMVERILOG !!!**_

1. $continuous\ assignment$ `=`: used outside `always` blocks, which **only describes the hardware, and can be disordered.**
2. $blocking\ assignment$ `=`: used inside `always` blocks, and is equivalent to the `=` in programming language, which is **evaluated in order and together.**
3. $non\ blocking\ assignment$ `<=`: used in side `always` blocks, and is **evaluated with the last value** on the right-hand side of the statement.

**=> Obviously, it is better to use blocking assignments for combinational logic, and non-blocking assignments for sequential logic.**

### 4.5.1 Case Statements

In SystemVerilog, `case` statements must appear inside `always` statements. It offers a higher level of abstraction.

> Example: a seven-segment display decoder

```SystemVerilog
module sevenseg (
    input  logic [3:0] data,
    output logic [6:0] segments
);
    always_comb
        case (data)
            // abc_defg
            0: segments = 7'b111_1110;
            1: segments = 7'b011_0000;
            2: segments = 7'b110_1101;
            3: segments = 7'b111_1001;
            4: segments = 7'b011_0011;
            5: segments = 7'b101_1011;
            6: segments = 7'b101_1111;
            7: segments = 7'b111_0000;
            8: segments = 7'b111_1111;
            9: segments = 7'b111_0011;
            default: segments = 7'b000_0000;
        endcase
endmodule
```

### 4.5.2 If Statements

In SystemVerilog, `if` statements must appear inside `always` statements. It offers a higher level of abstraction.

> Example: priority circuit

```SystemVerilog
module priorityckt (
    input  logic [3:0] a,
    output logic [3:0] y
);
    always_comb
        if (a[3]) y = 4'b1000;
        else if (a[2]) y = 4'b0100;
        else if (a[1]) y = 4'b0010;
        else if (a[0]) y = 4'b0001;
        else y = 4'b0000;
endmodule
```

**NOTICE:** only when _**all possible inputs have corresponding outputs**_ can a `if` statement be combinational. Otherwise it is sequential.
