# EE371 Digital Systems Laboratory

This repository contains all lab assignments and projects completed for EE371 Design of Digital Circuits and Systems Laboratory course.

## Lab Overview

### Lab 1 - Basic Digital Logic and Counters
- **Files**: `Lab1/src/`
- **Description**: Implementation of basic digital logic circuits including BCD to 7-segment decoders, counters, and passcode systems
- **Key Components**:
  - `bcd7seg.sv` - BCD to 7-segment display decoder
  - `counter.sv` - Basic counter implementation
  - `passcode.sv` - Passcode verification system
  - `userInput.sv` - User input handling

### Lab 2 - Memory and FIFO Systems
- **Files**: `Lab2/src/`
- **Description**: Memory management and FIFO (First In, First Out) queue implementation
- **Key Components**:
  - `FIFO.sv` - FIFO queue implementation
  - `FIFO_Control.sv` - FIFO control logic
  - `brian_ram32x4.sv` - 32x4 RAM implementation
  - `address7seg.sv` - Address display for 7-segment
  - `data7seg.sv` - Data display for 7-segment

### Lab 3 - VGA Graphics and Line Drawing
- **Files**: `Lab3/src/`
- **Description**: VGA framebuffer implementation and line drawing algorithms
- **Key Components**:
  - `VGA_framebuffer.sv` - VGA framebuffer controller
  - `line_drawer.sv` - Line drawing algorithm implementation
  - `clock_divider.sv` - Clock division for VGA timing

### Lab 4 - Binary Search and Data Processing
- **Files**: `Lab4/src/`
- **Description**: Binary search algorithm implementation and data processing
- **Key Components**:
  - `binsearch_datapath.sv` - Binary search datapath
  - `binsearch_top.sv` - Top-level binary search module
  - `bitcounting.sv` - Bit counting implementation
  - `shift.sv` - Shift register implementation

### Lab 5 - Audio Processing
- **Files**: `Lab5/`
- **Description**: Audio codec integration and audio processing
- **Tasks**:
  - **Task 1**: Basic audio codec setup
  - **Task 2 & 3**: Audio processing and synthesis
- **Key Components**:
  - `audio_codec.v` - Audio codec interface
  - `part1.v`, `part2.v` - Main processing modules
  - `note_data.mif` - Musical note data

### Lab 6 - Advanced Digital Systems
- **Files**: `Lab6/`
- **Description**: Advanced digital system implementations
- **Tasks**:
  - **Task 1**: Advanced digital logic
  - **Task 2**: Complex system integration

## File Structure

```
EE371/
├── Lab1/
│   ├── Lab1_report_Brian.pdf
│   └── src/
│       ├── bcd7seg.sv
│       ├── counter.sv
│       ├── passcode.sv
│       └── ...
├── Lab2/
│   ├── report.pdf
│   └── src/
│       ├── FIFO.sv
│       ├── FIFO_Control.sv
│       └── ...
├── Lab3/
│   ├── report.pdf
│   └── src/
│       ├── VGA_framebuffer.sv
│       ├── line_drawer.sv
│       └── ...
├── Lab4/
│   ├── report.pdf
│   └── src/
│       ├── binsearch_datapath.sv
│       ├── binsearch_top.sv
│       └── ...
├── Lab5/
│   ├── Lab5_report_Brian.pdf
│   ├── Task1/
│   ├── Task2and3_Files/
│   └── Task3_Files/
├── Lab6/
│   ├── Lab6_report_Brian.pdf
│   ├── Task1/
│   └── Task2/
└── README.md
```



## Development Environment

- **FPGA Tool**: Intel Quartus Prime
- **Simulation**: ModelSim
- **Language**: SystemVerilog 
- **Target Device**: Cyclone V 5CSEMA5F31C6



## Author

**Brian** - EE371 Digital Systems Laboratory

## Course Information

- **Course**: EE371 Design of Digital Circuits and Systems
- **Institution**: University of Washington
- **Semester**: 25 Winter

---

*This repository contains all lab assignments completed as part of the EE371 Digital Systems Laboratory course. Each lab builds upon previous concepts and introduces new digital system design techniques.*
