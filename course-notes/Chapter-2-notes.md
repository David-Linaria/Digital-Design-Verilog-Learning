## 2.1 Introduction

_**Circuits are composed of elements and nodes:**_

- **Element:** is itself a circuit with inputs, outputs, and specifications.
- **Node:** a wire whose voltage conveys a discrete-valued variable.

_**Categories of Digital Circuits:**_

- $Combinational:$ _**outputs only depends on the current input;**_
- $Sequential:$ _**outputs depends on both current and previous values of inputs.**_

### 2.1.1 Combinational Circuit

> we can use a black-box module to indicate a combinational logic. A 'CL' sign on it shows it is a combinational module.

$BUS$: **To simplify drawings, we often use a single line with a forward slash through it and a number next to it. This indicates a $bus$.**

Figure: A typical bus:

$$
------/------|\\
3
$$

This figure indicates a bundle of node, and the number is 3.

> Sometimes, when the number of nodes inside the bus is unimportant, we can draw the bus without the number.

## 2.2 Boolean Equation Extension

### 2.2.1 Terminology

_Definitions:_

- $literal$: the variable or its complementary form. (e.g. $A$ or $\overline{A}$)

- $minterm$: a product involving all of the inputs to the function. (e.g. $A\ \overline{B}\ \overline{C}$)
- $maxterm$: a sum involving all of the inputs to the function. (e.g. $A + \overline{B} + \overline{C}$)

- _**SOP**_: $sum\ of\ products\ canonical\ form$
- _**POS**_: $product\ of\ sum\ canonical\ form$

### 2.3 Boolean Algebra Extension

$prime\ implicant$: an implicant is called a prime implicant if it cannot be combined with any other implicants in the equation to form a new implicant with fewer literals.

## 2.5 Multiple Combinational Logic

### 2.5.2 Bubble Pushing

_Bubble pushing is a helpful way to redraw the circuits so that bubbles cancel out and the function can be more easily determined._

The rule of bubble pushing is as follows:

- _**Begin at the output of the circuit and work toward the inputs.**_
- Push any bubbles on the _**final output**_ back toward the inputs so that you can read an equation in terms of the output (e.g., Y) instead of the complement of the output $\overline{Y}$.
- Working backward, _**draw each gate in a form so that bubbles cancel**_. If the current gate has an input bubble, draw the preceding gate with an output bubble. If the current gate does not have an input bubble, draw the preceding gate without an output bubble.

## 2.6 X's And Z's

### 2.6.1 Illegal Value: X

_**Symbol X indicates that the circuit node has an unknown or illegal value.**_

=> This commonly happens when the circuit is being driven both 0 and 1.

$Contention$: **The situation when the circuit is being driven to both 0 and 1 at the same time.**

### 2.6.2 Floating Value: Z

_**Symbol Z indicates that a node is being driven neither by HIGH nor LOW. This node is said to be $floating$, $high\ impedance$, or $high\ Z$**_.

**In reality, a floating node can be 0, 1, or some voltage between, depending on the system.**

> A common way to produce floating node is to forget to connect a voltage to a circuit input, or to assume that an unconnected input is equivalent to input 0.

## 2.9 Timing

### 2.9.1 Propagation and Contamination Delay

Combinational Logic is characterized by its $propagation\ delay$ and $contamination\ delay$:

- _**Propagation Delay**_ ($t_{pd}$): **The maximum time from when any input changes until the output reaches its final value.**
- _**Contamination Delay**_ ($t_{cd}$): **The minimum time from when any input changes until the output starts to change its value.**

> _**=> The propagation delay of a circuit is the sum of propagation delays through each element on the $critical\ path$.**_

> _**=> The contamination delay of a circuit is the sum of contamination delays through each element on the $shortest\ path$.**_

### 2.9.2 Glitches

To avoid glitches, we can add gates to the implementation. This process can be cast onto the Karnaugh map by **adding another circle that covers the specific prime implicant boundary**.

> What we should know is that glitches is part of life in most circuits, and they cannot be always avoided. However, we should still know why there are glitches.