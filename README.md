# AXI Object Detection SoC 🚗

This project simulates a simplified AXI-based SoC that models the data flow from a camera sensor to memory — a common pattern in object detection pipelines for autonomous vehicles.

## 📂 Project Structure

- `rtl/`
  - `axi_master_camera.sv` – AXI master simulating camera sending burst image data
  - `axi_slave_memory.sv` – AXI slave simulating memory receiving data
  - `top_soc.sv` – Connects master and slave in a testable system
- `tb/`
  - `testbench_top.sv` – Testbench for simulating AXI transactions

## ✅ Features

- Implements burst write using AXI Lite/Stream-style simulation
- RTL in SystemVerilog
- Can be extended with UVM or CNN-style accelerator block

## 🛠️ How to Run (example with Icarus Verilog)

```sh
iverilog -o axi_test rtl/*.sv tb/testbench_top.sv
vvp axi_test
