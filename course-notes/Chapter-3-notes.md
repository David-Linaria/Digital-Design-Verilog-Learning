## 3.1 Introduction

_Definitions:_

- $State\ Variables$: A set of bits that form the state of a sequential logic, which contains all the information about the past necessary to explain the future behavior of the circuit.

## 3.2 Latches and Flip-Flops (Extension)

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

## 3.4 Finite State Machines (FSMs)

**=> An FSM consists of 2 blocks of combinational logic:**

1. Next State logic;
2. Output logic (and a register that stores the state).

Categories of FSMs:

- $Moore\ machines$: the output only depends on the current input;
- $Mealy\ machines$: the output depends on both the current state and the input.

### 3.4.2 State Encoding

_**One important decision in state encoding is the choice between binary encoding and one-hot encoding.**_

- Binary encoding of $K$ states only requires $\log_2 K$ bits, while One-hot encoding requires $K$ states;
- Thus, though one-hot encoding require more flip-flops, the output logic is often simpler, so fewer gates are needed.

> In real-world problem-solving process, the best choice will depend on the FSMs.

## 3.5 Timing of Sequential Logic

> $Sampling$: describes the process when a flip-flop copies the input D to its output Q. This is called sampling D on the clock edge.

_**The aperture of a sequential element is defined by a $setup\ time$ and a $hold\ time$, before and after the clock edge, respectively. Thus:**_

$$
Aperture\ time = Setup\ time + Hold\ time
$$

$Metastability$: a phenomenon where the flip-flop captures a value partway between 0 and 1.

_Dynamic Discipline: the inputs of a sequential logic must remain stable during the setup and hold aperture time around the clock edge._

### 3.5.2 System Timing

_**Setup Time Constraint & Hold Time Constraint:**_

consider a synchronous sequential logic consisted of:

$$
CLK1\ (R1)\ --Q1--\ Combinational Logic\ --D2--\ CLK2\ (R2)
$$

1. To Satisfy the setup time of R2:

$$
T_c \ge t_{pcq} + t_{pd} + t_{setup}\\
=> t_{pd} \le T_c - (t_{pcq} + t_{setup}) \\
sequencing\ overhead = t_{pcq} + t_{setup}
$$

2. To satisfy the hold time of R2:

$$
t_{ccq} + t_{cd} \ge t_{hold}\\
=> t_{cd} \ge t_{hold} - t_{ccq}
$$

_**=> A reliable flip-flop must have a hold time $shorter$ than its contamination delay.**_

> Often times the flip-flops are designed with $t_{hold} = 0$ so it's always shorter than the contamination delay.

### 3.5.3 Clock Skew

In reality, the clock signal does not always reach all the registers at the same time, thus causing variation in clock edges.

$clock\ skew$: the variation stated above.

> Clock skew effectively increases both the setup time and the hold time. It adds to the sequencing overhead, reducing the time available for useful work in the combinational logic.

### 3.5.4 Metastability

$Metastable\ State$: when a flip-flop samples a changing input during its aperture time, the output Q might remain in the forbidden zone for a period of time.

> The resolution time, $t_{res}$, required to resolve the flip-flop to a stable state, is a _**random variable, and the probability decreases exponentially by time:**_

$$
P(t_{res}>t) = \frac{T_0}{T_c}\mathrm{e}^{-\frac{t}{τ}}
$$

_where $T_c$ is clock period, $T_0$ and $τ$ are characteristic of the flip-flop._

### 3.5.5 Synchronizers, MTBF

> To guarantee good logic levels, all asynchronous inputs should go through synchronizers.

$Synchronizer$: A synchronizer is a device that receives an asynchronous input $D$ and clock $CLK$, and produces an output $Q$ within a bounded amount of time, and _**the output has a valid logic level with extremely high probability.**_

> This means, even though the input $D$ might be changing in the aperture time of the synchronizer, the output $Q$ is still 0 or 1, but not random voltage (in metastability).

=> We say that a synchronizer _**fails**_, if the output is metastable.

_**MTBF (Mean Time Between Failures)**_ is the average amount of time between failures of the system.

=> For a synchronizer, **MTBF explodes exponentially with more waiting time**. For most systems, a synchronizer waits for one clock cycle to ensure a safe MTBF.

## 3.6 Parallelism

_Definitions:_

1. $token$: _**a group of**_ inputs that are processed to produce _**a group of**_ outputs.
2. $latency$: the time required for one $token$ to pass through _**the system**_ from start to end.
3. $thoughput$: the number of tokens that can be produced per unit time.

> => The throughput can be improved by processing several tokens at the same time. This introduces $parallelism$, which comes in 2 forms:

- $spatial\ parallelism$: _**multiple copies of the hardware are provided**_ so that multiple tasks can be done at the same time.
- $temporal\ parallelism$ (or $pipelining$): a _**task is broken into stages**_, like an assembly line. Multiple tasks can be spread across the stages.

> Pipelining is like water flux. In a system that is divided into separate stages, pipelining measures the token processing speed within, while latency view the system as a whole.

Thus, in a pipelined system:

- $Latency$ is the time a token travels from the start to the end;
- $Throughput$ is _**the reciprocal of the largest latency**_ of all the stages within.

> Pipelining is particularly attractive because it speeds up a circuit without duplicating the hardware.

_The bane of parallelism is $dependencies$. If a current task is dependent on the result of a prior task, rather than just prior steps in the current task, the task cannot start until the prior task has completed._

## 3.7 Summary

- A group of flip-flops connected to the same clock is called a $register$.
