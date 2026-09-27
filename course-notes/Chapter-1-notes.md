## 1.1 Levels of Abstraction For an Electronic Computing System

$$
Physics \rightarrow Devices \rightarrow Analog Circuits \rightarrow Digital Circuits \rightarrow Logic \rightarrow Micro-architecture \rightarrow Architecture \rightarrow Operating Systems \rightarrow Software
$$

Here are some examples on these levels:

$$
Electrons \rightarrow Transistors \rightarrow Amplifiers \rightarrow Logic-gates \rightarrow Adders/Memories \rightarrow Controllers \rightarrow Registers \rightarrow Device/Drivers \rightarrow Applications
$$

_**Analog circuits input and output a continuous range of voltages, while Digital circuits restrict the voltages to discrete ranges.**_

## 1.2 Manage Complexity

_**Abstraction + Discipline + three '-Y's**_

1. Hierarchy: dividing a system into modules, and further subdividing modules;
2. Modularity: modules are well-defined, so no side effect come when connecting;
3. Regularity: uniformity among modules, reducing distinct modules designed.

## 1.3 Bytes, Nibbles, and all that Jazz

Nibble: A group of 4 bits, or half a byte, is called a Nibble.
=> Microprocessors handle data in chuncks called _words_.

$$
1 TB\ (terabyte) = 1024 GB\ (gigabyte) = 2^{20} MB\ (megabyte) = 2^{30} KB\ (kilobyte) = 2^{40} B\ (byte)
$$

- _**Memory capacity is usually measured in bytes (power of 2)**_
- _**Communication speed is usually measured in 10 bits (power of 10)**_

> For example, 32GB RAM is actually 34,359,738,368 bytes, while 32GB on Hard Drive is 32,000,000,000 bytes.

## 1.4 Signed Binary Numbers

### 1.4.1 Sign/Magnitude Representation of Binary Numbers

**Definition**: An N bit sign/magnitude number uses the msb as the sign and the remaining N - 1 bit as the magnitude (absolute value). A sign bit of 0 indicates positive, while 1 indicates negative.

> E.g +5 = 1101; +0 = 00 = -0 = 10

CONS: ordinary binary addition does not work for sign/magnitude numbers.

### 1.4.2 Two's Complement Numbers:

_Two's complement numbers are identical to unsigned binary numbers except that the most significant position has a weight of -2^(N-1) instead of 2^(N-1)_

_**To reverse the sign: inverting the bits, and adding 1**_

### Range of N-bit Numbers

_All N-bit numbers, whether unsigned or signed, can represent 2^N possibilities._

- Unsigned: [0, 2^N - 1]
- Sign/Magnitude: [-2^(N-1) + 1, 2^(N-1) -1] (_There are 2 kinds of '0', so the total is still 2^N_)
- Two's Complement: [-2^(N-1), 2^(N-1) - 1]

## 1.5 Logic Gates (Expansion)

### 1.5.1 Buffer

_A buffer simply copies the input to the output, like a NOT-NOT gate._
=> The symbol is the same as the NOT gate except that there is no bubble.

_Though it may seem no more like a wire, it still holds great magnitude as it might have desirable characteristics, such as the ability to deliver large amounts of current to a motor or the ability to quickly send its output to many gates._

## 1.6 Beneath the Digital Abstraction

### 1.6.1 Noise Margins

Suppose the scenario that two logic gates are connected to define logic levels:

$wire - Driver - Receiver$ (See on P21)

If the output of the driver can be correctly interpreted by the receiver, then there should be:

- Logic HIGH output range is greater than logic HIGH input range; ($V_OH > V_IH$)
- Logic LOW output range is smaller than logic LOW input range. ($V_OL < V_IL$)

**=> The Noise Margin ($NM$) is the amount of noise that could be added to a worst-case output such that the signal can still be interpreted as a valid input.**

- $NM_L = V_IL - V_OL$
- $NM_H = V_OH - V_IH$

### 1.6.2 The Static Discipline

=> Nearly all digital logic gates are conformed to the static discipline.

_**Definition: Static Discipline requires that, given logically valid inputs, every circuit element will produce logically valid outputs.**_

Gates are grouped into _**logic families**_ such that all gates in the same logic family obey the same static discipline, so that they can communicate without error.

_Here are some logic families:_

- Transistor-Transistor Logic (TTL)
- Complementary Metal-Oxide-Semiconductor Logic (CMOS, pronounced sea-moss)
- Low Voltage TTL Logic (LVTTL)
- Low Voltage CMOS Logic (LVCMOS).

## 1.7 CMOS Transistors

There are two main types of transistors, _**bipolar junction transistors**_ and _**metal-oxide-semiconductor field effect transistors**_ ($MOSFETS$ or $MOS-transistors$)

### 1.7.1 Semiconductors

**Mixing _Poor Conductor_ with different _dopants_ can create different semiconductors.**

- $Silicon(Si)$ + $Arsenic(As)$ => $n-type\ dopant$
- $Silicon(Si)$ + $Boron(B)$ => $p-type\ dopant$

### 1.7.2 Diodes

**Definition:** The junction between p-type and n-type silicon is called a _**diode**_. In which the p-type region is called _**anode**_ and the n-type region is called _**cathode**_.

- $Forward\ Biased$ : The voltage on the anode is above the voltage on the cathode;
- $Reverse\ Biased$ : The voltage on the anode is bellow the voltage on the cathode;

### 1.7.3 nMOS and pMOS Transistors

MOSFET manufacturing process: _**Wafer \rightarrow Chips/Dice \rightarrow Package**_

> A MOSFET behaves as a voltage-controlled switch in which the gate voltage creates an electric field that turns ON or OFF a connection between the source and drain. The term _**field effect transistor**_ comes from this principle of operation.

=> Most often times, there is no current through the $gate$ ($I_G = 0$), and the magnitude of $V_{GS}$ controls the current through the $drain$, and the process is like:

$$
V_{GS} \rightarrow Electric\ field \rightarrow Change\ resistor \rightarrow Control\ I_D
$$

=> For convenience, we can view the $gate$ as a capacitor.

MOSFETs are not perfect switches:

- _**nMOS transistors pass 0's well but pass 1's poorly;**_
- _**pMOS transistors pass 0's poorly but pass 1's well.**_

> _**Expansion**_: nMOS transistors need a p-type substrate, and pMOS transistors need an n-type substrate. To build both flavors of transistors on the same chip, manufacturing processes typically start with a p-type wafer, then implant n-type regions called wells where the pMOS transistors should go. These processes that provide both flavors of transistors are called Complementary MOS or CMOS. CMOS processes are used to build the vast majority of all transistors fabricated today.

### 1.7.4 Other CMOS Logic Gates

_General form of an inverting logic gate:_

$$
V_{DD}\\
\downarrow\\
pMOS\ pull-up\ network\\
\downarrow\\
inputs \rightarrow \rightarrow outputs\\
\downarrow\\
nMOS\ pull-down\ network\\
\downarrow\\
GND
$$

So there will appear two kinds of problems:

1. _**Short Circuit:**_ both pull-up and pull-down networks are ON;
2. _**Output Floats:**_ both pull-up and pull-down networks are OFF.

> => To properly function the logic gates, one of the networks should be ON and the other OFF at any given time. We guarantee this by using the rule of _**conduction-complements**_.

_**Conduction-Complements: When nMOS transistors are in series, pMOS transistors must be in parallel, and vice-versa.**_

### 1.7.5 Transmission Gates

_**Transmission Gate / Pass Gate:**_ parallel of pMOS and nMOS transistor, to perform a perfect switch that can pass both 0 and 1 well.

**Switch Structure (Note that this gate is bidirectional):**

$$
EN\\
|\\
A\ -\ Parallel Structure\ -\ B\\
|\\
\overline{EN}
$$

_=> When $EN=1$ and $\overline{EN}=0$, the transmission gate is ON or Enabled, and any logic value can float between A and B._

## 1.8 Power Consumption

_**Digital Systems draw both static and dynamic power.**_
(Dynamic power is the power used to charge capacitance.)

How to calculate two kinds of power consumption:

- **Static Power Consumption:** $P_{static} = I_{DD} V_{DD}$
- **Dynamic Power Consumption:** $P_{dynamic} = \alpha CV_{DD}^2f$.

$\alpha$ is called _**activity factor**_, and is represented by the fraction of transitions and clock cycles:

$$
\alpha = \frac{0\rightarrow1\ transitions}{clock\ cycles}
$$
