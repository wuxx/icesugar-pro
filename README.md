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
* [virtual-machine-image](#virtual-machine-image)
* [How-to-setup](#how-to-setup-env)
* [How-to-buy](#how-to-buy)
* [Reference](#reference)

# iCESugar-pro
iCESugar-pro is a FPGA board base on Lattice LFE5U-25F-6BG256C, which is fully supported by the open source toolchain (yosys & nextpnr), the board is designed in DDR SODIMM form with 106 usable IOs, with on-board 32MB SDRAM, it can run the risc-v linux. the on board debugger iCELink (base on ARM Mbed DAPLink) support drag-and-drop program, you can just drag the FPGA bitstream into the virtual disk to program, and with a additional USB CDC serial port direct connect to FPGA, so you can only use one TYPE-C cable to develop and test.  
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
 SDRAM use IS42S16160B (32MB)

### SPI-Flash
 SPI Flash use W25Q256JV (32MB)

### Clock
a 25MHz crystal is connect to P6

### Peripheral
2. a RGB LED is connected to {A11, A12, B11}
3. a SDCARD slot, support SPI/SDIO
4. 106 usable IOs out with DDR SODIMM, can use with ext-board.

### JTAG
the native JTAG of ECP5 is connect to the on-board iCELink, you can flash bistream with this JTAG interface (called JTAG1).
and there is also another JTAG interface (actually just some GPIOs of ECP5) connect to the iCELink too (called JTAG2),
if you design a SoC with a JTAG interface support, then you can use the JTAG2 to debug your SoC. only one JTAG work a one moment.
so use the icesprog tool with command `icesprog -j 1 or 2` to switch between these two JTAG interface.
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
iCESugar-pro has a on board debugger named iCELink (base on APM32F1)，you can only use one USB wire to program the FPGA and debug, here is detail:   
1. drag-and-drop program, just drop the bitstream into the virtual USB DISK iCELink, then wait a few second, the iCELink firmware will do the total program work
2. USB CDC serial port, it can use to communicate with FPGA
3. 2 JTAG interfaces for flash the ECP5 or debug the SoC on ECP5
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
$icespgor -g PA14 -m out
$icespgor -g PA14 -w 0
```

#### How-To-Program
there are multiple ways to program the bitstream.
1. drag-and-drop program, this may be the fastest and simplest way to flash.
2. use the command `icesprog xxx.bit`, this can provide more configable parameters.
3. use the command `dapprog xxx.bit (program to flash) or dapprog xxx.svf (program to SRAM)`

# virtual-machine-image
link：https://pan.baidu.com/s/1qVSdwM7DnFbaS0xdqsPNrA  
verify code：6gn3  
`user: ubuntu`  
`passwd: ubuntu`  
or
https://mega.nz/file/uvJTWKrK#1bBgBkJPZrszwHQSTHHL-RLjxGIru0Qv0qUgmULZZVs

the env include yosys, nextpnr, icestorm, gcc, sbt.

# How-to-setup-env
## Linux
recommend use the virtual machine, it simple and convenient  
FPGA toolchain reference [icestorm](http://www.clifford.at/icestorm/)  
gcc toolchain reference [riscv-gnu-toolchain](https://pingu98.wordpress.com/2019/04/08/how-to-build-your-own-cpu-from-scratch-inside-an-fpga/)  
Alternatively, you can download the pre-built toolchain provided by xPack or SiFive
+ https://xpack.github.io/riscv-none-embed-gcc/install/
+ https://www.sifive.com/software
`icesprog` is command tool for iCESugar program，it depend libusb and hidapi  
`$sudo apt-get install libhidapi-dev`  
`$sudo apt-get install libusb-1.0-0-dev`  

## Windows
now you can use the msys2 environment to setup the open source toolchain easily, download msys2 install executable [here](https://www.msys2.org/), install it, then open the msys2 mingw terminal (search `msys2` in windows start menu)  
```
#pacman -Syu
#pacman -S mingw-w64-x86_64-eda
```
select the yosys, nextpnr, icestorm, icesprog and install, after installed, everything is same as in linux!

# How-to-buy
you can buy iCESugar-pro and PMOD peripherals from our offcial aliexpress shop [Muse Lab Factory Store](https://muselab-tech.aliexpress.com/)

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
