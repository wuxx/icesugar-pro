## How-To-Boot-Linux

1. program the bitstream  
`$icesprog ../demo/linux-with-litex.bit`

2. put system files into the sdcard
`$cp * ${YOUR_USB_DISK}`

3. power on iCESugar-pro, open the serial port to check the linux start up
`$picocom -b 1000000 /dev/ttyACM0`

## reference 
- linux-on-litex-vexriscv  
[https://github.com/litex-hub/linux-on-litex-vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv)
- linux-on-litex-vexriscv-prebuilt  
[https://github.com/antmicro/linux-on-litex-vexriscv-prebuilt](https://github.com/antmicro/linux-on-litex-vexriscv-prebuilt)
