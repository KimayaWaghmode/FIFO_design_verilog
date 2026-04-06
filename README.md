# Parameterized FIFO Design & Verification
--> Overview

This project implements a synchronous FIFO in Verilog and verifies it using a testbench in QuestaSim.

--> Features

* Configurable depth and width
* Full and empty flag logic
* Pointer and counter-based design
* Assertion checks for overflow and underflow
  
--> Design

* Write pointer → stores data
* Read pointer → reads data
* Counter → tracks elements

Full: count == depth
Empty: count == 0

--> Verification

* Random data written and read
* Verified using waveform in QuestaSim

--> Assertions

* Write when full → overflow
* Read when empty → underflow

--> Tools

* Verilog
* QuestaSim

-->Conclusion

Successfully designed and verified FIFO demonstrating buffering and control logic.
