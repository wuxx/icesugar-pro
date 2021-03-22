# Get Start

## Install openocd
```
$git clone https://github.com/ntfreak/openocd.git
$cd openocd
$git submodule init
$git submodule update
$./bootstrap
$./configure --enable-cmsis-dap
$make -j
$sudo make install
```

## Setup
after openocd installed, a shell script `dapprog` is written for convenient, export the path of dapprog, then we can use it everywhere, because the openocd can only support svf file, so the bit file will be converted to svf file with a little modified urjtag. in addition, the svf file is program to sram and the bit file is program to the flash.
`$cd icesugar-pro/tools`
`$source env.sh`
`$dapprog xxx.svf or xxx.bit`

