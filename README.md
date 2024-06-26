iCESugar-pro
-----------
* [iCESugar-pro](#iCESugar-pro) 
* [Hardware](#hardware)
	* [ECP5](#ecp5)
	* [SDRAM](#sdram)
	* [SPI-Flash](#spi-flash)
	* [Clock](#clock)
	* [Peripheral](#peripheral)
	* [JTAG](#jtag)
	* [iCELink](#icelink)
* [Virtual machine image](#virtual-machine-image)
* [How to setup](#how-to-setup-env)
* [How to buy](#how-to-buy)
* [Copyright Statement](#copyright-statement)
* [Reference](#reference)

# iCESugar-pro
iCESugar-pro is a FPGA development board based on Lattice LFE5U-25F-6BG256C, which is fully supported by the open source toolchain (yosys & nextpnr), the board is designed in DDR2 SODIMM form factor with 106 usable IOs, with on-board 32MB SDRAM, it can run RISC-V Linux. The on-board iCELink debugger (base on ARM Mbed DAPLink) supports drag-and-drop programming, you can just drag the FPGA bitstream into the virtual disk to program, and with a additional USB CDC serial port direct connect to FPGA, so you can only use one Type C cable to develop and test.  
<div align=center>
<img src="https://github.com/wuxx/icesugar-pro/blob/master/doc/iCESugar-pro-1.jpg" width = "700" alt="" align=center />    
<img src="https://github.com/wuxx/icesugar-pro/blob/master/doc/iCESugar-pro-2.jpg" width = "700" alt="" align=center />    
<img src="https://github.com/wuxx/icesugar-pro/blob/master/doc/iCESugar-pro-3.jpg" width = "700" alt="" align=center />    
</div>

# Hardware
### ECP5
LFE5U-25F-6BG256C (BGA256 0.8mm pitch)
1. LUTs: 24K
2. sysMEM Blocks: 18Kb x 56
3. Embedded Memory: 1008Kb
4. Distributed RAM bits: 194Kb
5. 18 x 18 Multipliers: 28
6. PLL x 1

### SDRAM
 SDRAM uses IS42S16160B (32MB)

### SPI-Flash
 SPI Flash uses W25Q256JV (32MB)

### Clock
A 25MHz crystal is connect to P6

### Peripheral
2. a RGB LED is connected to {A11, A12, B11}
3. a SDCARD slot, support SPI/SDIO
4. 106 usable IOs out with SODIMM-DDR2-200P, broken out with the ext-board.

### JTAG
The native JTAG of ECP5 is connect to the on-board iCELink, you can flash bitstream with this JTAG interface (called JTAG1).
There is also another JTAG interface (actually, just some GPIOs of ECP5) connected to the iCELink too (called JTAG2),
if you design a SoC with a JTAG interface support, then you can use the JTAG2 to debug your SoC. Only one JTAG works at once.
So use the icesprog tool with command `icesprog -j 1 or 2` to switch between these two JTAG interface.
```
$icesprog -j 1
JTAG --> [JTAG-1]
         [JTAG-1]
         TCK:  iCELink-PB6  -- ECP5-JTAG-TCK (25F-BG256-T10)
         TMS:  iCELink-PB4  -- ECP5-JTAG-TMS (25F-BG256-T11)
         TDI:  iCELink-PB5  -- ECP5-JTAG-TDI (25F-BG256-R11)
         TDO:  iCELink-PB3  -- ECP5-JTAG-TDO (25F-BG256-M10)

         [JTAG-2]
         TCK:  iCELink-PA14 -- ECP5-IO-PL8D  (25F-BG256-F5)
         TMS:  iCELink-PA13 -- ECP5-IO-PL17A (25F-BG256-H5)
         TDI:  iCELink-PA0  -- ECP5-IO-PL38A (25F-BG256-N4)
         TDO:  iCELink-PA1  -- ECP5-IO-PL17D (25F-BG256-J5)

done
```

### iCELink
iCESugar-pro has a on-board debugger named iCELink (base on APM32F1)，only needing one USB wire to program the FPGA and debug it:   
1. Drag and drop programming, just drop the bitstream into the virtual USB drive named iCELink then wait a few seconds while the iCELink firmware programs it for you.
2. USB CDC serial port, it can use to communicate with FPGA
3. 2 JTAG interfaces for flashing the ECP5 or debugging your SoC on ECP5
4. use the command tool `icesprog` to flash or do more config, here is the help info
```
$icesprog -h
usage: /home/pi/oss/icesugar/tools/icesprog.arm [OPTION] [FILE]
             -w | --write                   write spi-flash or gpio
             -r | --read                    read  spi-flash or gpio
             -e | --erase                   erase spi-flash
             -p | --probe                   probe spi-flash
             -o | --offset                  spi-flash offset
             -l | --len                     len of write/read
             -g | --gpio                    icelink gpio write/read
             -m | --mode                    icelink gpio mode
             -j | --jtag-sel                jtag interface select (1 or 2)
             -c | --clk-sel                 clk source select (1 to 4)
             -h | --help                    display help info

             -- version 1.1a --

```
#### Tips
cause the iCELink connect some GPIOs to the ECP5, you can control this GPIOs with `icesprog` to do some self defined behavior, 
for example, to control the iCELink-PA14 -- ECP5-F5 line out low, type these command.
```
$icesprog -g PA14 -m out
$icesprog -g PA14 -w 0
```

#### How To Program
There are multiple ways to program the bitstream.
1. Drag and drop programming, this is the fastest and simplest way to flash.  
2. Using the command `icesprog xxx.bit`, this can provide more configable parameters.  
3. Using the command `dapprog xxx.bit (program to flash) or dapprog xxx.svf (program to SRAM)`  
the `icesprog` binary and source code is in [icesugar](https://github.com/wuxx/icesugar/tree/master/tools) repo, and the `dapprog` is a bash wrapper of openocd command, click [here](https://github.com/wuxx/icesugar-pro/tree/master/tools) to check how to setup.

# Virtual machine image
link：https://pan.baidu.com/s/1vV2ckFpOuyd600Y47Tl1sw  
verify code：i3en  
`user: ubuntu`  
`passwd: ubuntu`

The env include yosys, nextpnr, icestorm, gcc, sbt.

# How to setup enviroment
## Linux
It is reccomended that you use the virtual machine image, it simple and convenient.\
Alternatively, you can download the toolchain for programming the FPGA unit by following the instructions in the "Installing Toolkits" section below and the RISC-V compiler for running your code has a tutorial linked in the "Other tools" section.

## Windows
If you don't want to use the virtual machine image you need to use the Windows Subsystem For Linux 2 (WSL2) as not all components of the toolchain has native windows versions.\
Install WSL using [this tutorial.](https://learn.microsoft.com/en-us/windows/wsl/install) By default it uses ubuntu, which this section is written for. Once WSL is installed and configured you can open it by searching for 'WSL' from the start menu.\
Once in the WSL desktop you will need to preform the following commands to install the needed toolkits.

## Installing Toolkits (Windows and Linux)
The easiest way to get all needed tools is using the [YosysHQ oss-cad-suite](https://github.com/YosysHQ/oss-cad-suite-build). All you need to do is download and extract the repository to a location on your machine such as the home folder. After you extract it you'll need to update your PATH variable so your terminal can use the programs.\
Do this by editing your `.bashrc` file on your home folder using `sudo nano .bashrc` from there. Scrolll to the end of the file and in a new line add `export PATH="$PATH:/home/YOUR_ACCOUNT_NAME_HERE/oss-cad-suite/bin"`

### Other tools
Dapprog is included in the tools folder and can be executed from there. ecpprog is included in the install for nextpnr and the RISC-V gcc toolchain used for code compilation can be installed using [this tutorial](https://github.com/riscv-collab/riscv-gnu-toolchain)


## Building demo files
If you want to use the demo files as is you just need to program the bitstream provided in the [`demo`](./demo) folder. 
<!-- The relative location allows this link to work both online and locally-->
If you want to change how the demos behave you will need to rebuild them. For the blink, hdmi and uart tests you just need to run `make` in the same folder to update them with your changes. For the litex_linux demo you will need to have the [litex repository](https://github.com/litex-hub/linux-on-litex-vexriscv) downloaded locally and will need to modify the `top.ys` file where it lists `INSTALL_DIR` with the location you put the repo.

# How to buy
You can buy iCESugar-pro and PMOD peripherals from our offcial aliexpress shop [Muse Lab Factory Store](https://miusecn-muselab-tech.aliexpress.com/) or search `iCESugar-Pro FPGA` on [aliexpress.com](https://miusecntech-muselab.aliexpress.com/)

# Copyright Statement
The HDMI test verilog source code is from [github.com/DoctorWkt/ULX3S-Blinky](https://github.com/DoctorWkt/ULX3S-Blinky)  
The Litex on Linux project is from [github.com/litex-hub/linux-on-litex-vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv)  
For hobby and personal usage, you are free to use the iCESugar-pro, you can also make the board yourself using the documentation & firmware in this repo.  
For the commercial usage, if you get iCESugar-pro Board from our official shop and use in other commercial product, that's no problem, otherwise, please contact us in advance.  

# Reference
### Colorlight-FPGA-Projects
https://github.com/wuxx/Colorlight-FPGA-Projects
### icestorm toolchain
http://www.clifford.at/icestorm/
### riscv gcc toolchain
https://xpack.github.io/riscv-none-embed-gcc/install/
https://www.sifive.com/software
### iCESugar
https://github.com/wuxx/icesugar
### iCESugar-nano
https://github.com/wuxx/icesugar-nano
### Examples
https://github.com/damdoy/ice40_ultraplus_examples  
https://github.com/icebreaker-fpga/icebreaker-examples
### SpinalHDL
https://spinalhdl.github.io/SpinalDoc-RTD/SpinalHDL/Getting%20Started/index.html
