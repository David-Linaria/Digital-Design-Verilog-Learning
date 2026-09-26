## 1.1 Levels of Abstraction For an Electronic Computing System

Physics -> Devices -> Analog Circuits -> Digital Circuits -> Logic -> Micro-architecture -> Architecture -> Operating Systems -> Software

Here are some examples on these levels:
Electrons -> Transistors -> Amplifiers -> Logic-gates -> Adders/Memories -> Controllers -> Registers -> Device/Drivers -> Applications

_**Analog circuits input and output a continuous range of voltages, while Digital circuits restrict the voltages to discrete ranges.**_

## 1.2 Manage Complexity

_**Abstraction + Discipline + three '-Y's**_

1. Hierarchy: dividing a system into modules, and further subdividing modules;
2. Modularity: modules are well-defined, so no side effect come when connecting;
3. Regularity: uniformity among modules, reducing distinct modules designed.

## 1.3 Bytes, Nibbles, and all that Jazz

Nibble: A group of 4 bits, or half a byte, is called a Nibble.
=> Microprocessors handle data in chuncks called _words_.

$1 TB\ (terabyte) = 1024 GB\ (gigabyte) = 2^{20} MB\ (megabyte) = 2^{30} KB\ (kilobyte) = 2^{40} B\ (byte)$

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
