## 3.1 Introduction

_Definitions:_

- $State\ Variables$: A set of bits that form the state of a sequential logic, which contains all the information about the past necessary to explain the future behavior of the circuit.

# 3.2 Latches and Flip-Flops (Extension)

$bistable\ element$: The fundamental building block of memory, and it has **2 stable states**.

### 3.2.3 D Flip-Flop (Extension)

_**Precise Distinction between Flip-Flop and Latches:**_

- Flip-Flop is _**Edge-Triggered**_, the state depends on the rising or falling edge of the clock;
- Often times, _**bistable elements without an edge-triggered clock**_ are commonly called latches.

### 3.2.4 Register

> An N-bit register is a bank of N flip-flops that share a common CLK input. All bits of the register are updated at the same time.

### 3.2.5 Enabled Flip-Flop

$EN$ can be _**either synchronous or asynchronous**_, depends on the element, the chip, or the whole system.

### 3.2.6 Resettable Flip-Flop

$RESET$ can also be _**either synchronous or asynchronous**_, depends on the element, the chip, or the whole system.

## 3.3 Synchronous Logic Design

### 3.3.1 Some Problematic Circuits

_**Ring Oscillator**_: several inverters connected in serial, and the output of the last gate is connected to the input of the first gate.

> The period of the ring oscillator depends on the propagation delay of the gates.

> Asynchronous circuits are infamous for having $race\ conditions$, which states that the output of the circuit may change depending on the speed of the gates.

### 3.3.2 Synchronous Sequential Circuits

$cyclic\ paths$: outputs are fed directly back to the inputs.

> A flip-flop is the simplest synchronous sequential circuit.

## 3.4 Finite State Machines 

