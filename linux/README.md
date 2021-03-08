## How-To-Boot-Linux

1. program the bitstream  
`$icesprog ../demo/linux-with-litex.bit`

2. put system files into the rootdir of sdcard (the sdcard should be formatted as fat32 file system before)
`$cp * ${YOUR_USB_DISK}`

3. power on iCESugar-pro, open the serial port to check the linux start up
`$picocom -b 1000000 /dev/ttyACM0`

## Boot Log
```
        __   _ __      _  __
       / /  (_) /____ | |/_/
      / /__/ / __/ -_)>  <
     /____/_/\__/\__/_/|_|
   Build your hardware, easily!

 (c) Copyright 2012-2020 Enjoy-Digital
 (c) Copyright 2007-2015 M-Labs

 BIOS built on Nov 11 2020 09:43:40
 BIOS CRC passed (9f19f473)

 Migen git sha1: cc6e76e
 LiteX git sha1: 275932f5

--=============== SoC ==================--
CPU:            VexRiscv_Linux @ 50MHz
BUS:            WISHBONE 32-bit @ 4GiB
CSR:            8-bit data
ROM:            64KiB
SRAM:           8KiB
L2:             8KiB
SDRAM:          32768KiB 16-bit @ 50MT/s (CL-2 CWL-2)

--========== Initialization ============--
Initializing SDRAM @0x40000000...
Switching SDRAM to software control.
Switching SDRAM to hardware control.
Memtest at 0x40000000 (2MiB)...
  Write: 0x40000000-0x40200000 2MiB
   Read: 0x40000000-0x40200000 2MiB
Memtest OK
Memspeed at 0x40000000 (2MiB)...
  Write speed: 11MiB/s
   Read speed: 10MiB/s

--============== Boot ==================--
Booting from serial...
Press Q or ESC to abort boot completely.
sL5DdSMmkekro
             Timeout
Booting from SDCard in SPI-Mode...
Booting from boot.json...
Copying Image to 0x40000000 (4545524 bytes)...
[########################################]
Copying rootfs.cpio to 0x40800000 (8029184 bytes)...
[########################################]
Copying rv32.dtb to 0x41000000 (1987 bytes)...
[########################################]
Copying emulator.bin to 0x41100000 (9600 bytes)...
[########################################]
Executing booted program at 0x41100000

--============= Liftoff! ===============--
VexRiscv Machine Mode software built Mar 23 2020 16:55:03
--========== Booting Linux =============--
[    0.000000] No DTB passed to the kernel                                          
[    0.000000] Linux version 5.0.13 (florent@lab) (gcc version 8.3.0 (Buildroot 2019.08-rc2-00011-gad9efda578)) #1 Thu Sep 12 14:20:26 CEST 2019
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] Initial ramdisk at: 0x(ptrval) (8388608 bytes)
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x0000000041ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000041ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x0000000041ffffff]
[    0.000000] elf_hwcap is 0x1101
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8128
[    0.000000] Kernel command line: mem=32M@0x40000000 rootwait console=liteuart earlycon=sbi root=/dev/ram0 init=/sbin/init swiotlb=32
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 19812K/32768K available (3415K kernel code, 148K rwdata, 509K rodata, 140K init, 216K bss, 12956K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000422] sched_clock: 64 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.004800] Console: colour dummy device 80x25
[    0.007486] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.009456] pid_max: default: 32768 minimum: 301
[    0.026679] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.028428] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.121644] devtmpfs: initialized
[    0.189497] random: get_random_bytes called from setup_net+0x4c/0x188 with crng_init=0
[    0.200282] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.202998] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.220630] NET: Registered protocol family 16
[    0.579278] clocksource: Switched to clocksource riscv_clocksource
[    1.118845] NET: Registered protocol family 2
[    1.149705] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    1.152735] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.154585] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    1.156926] TCP: Hash tables configured (established 1024 bind 1024)
[    1.164153] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    1.165932] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    1.197310] Unpacking initramfs...
[    5.478529] Initramfs unpacking failed: junk in compressed archive
[    5.518894] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    6.441722] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    6.443061] io scheduler mq-deadline registered
[    6.444868] io scheduler kyber registered
[    9.806243] f0001000.serial: ttyLXU0 at MMIO 0xf0001000 (irq = 0, base_baud = 0) is a liteuart
[    9.809098] printk: console [liteuart0] enabled
[    9.809098] printk: console [liteuart0] enabled
[    9.810562] printk: bootconsole [sbi0] disabled
[    9.810562] printk: bootconsole [sbi0] disabled
[    9.863872] libphy: Fixed MDIO Bus: probed
[    9.874843] i2c /dev entries driver
[    9.993741] NET: Registered protocol family 10
[   10.037459] Segment Routing with IPv6
[   10.042318] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.141414] Freeing unused kernel memory: 140K
[   10.142302] This architecture does not have kernel memory protection.
[   10.144239] Run /init as init process
mount: mounting tmpfs on /dev/shm failed: Invalid argument
mount: mounting tmpfs on /tmp failed: Invalid argument
mount: mounting tmpfs on /run failed: Invalid argument
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator... [   16.221885] random: dd: uninitialized urandom read (512 bytes read)
done.
Starting network: OK
Starting dropbear sshd: [   19.262912] random: dropbear: uninitialized urandom read (32 bytes read)
OK

Welcome to Buildroot
buildroot login: root
                __   _
               / /  (_)__  __ ____ __
              / /__/ / _ \/ // /\ \ /
             /____/_/_//_/\_,_//_\_\
                   / _ \/ _ \
   __   _ __      _\___/_//_/ __             _
  / /  (_) /____ | |/_/__| | / /____ __ ____(_)__ _____  __
 / /__/ / __/ -_)>  </___/ |/ / -_) \ // __/ (_-</ __/ |/ /
/____/_/\__/\__/_/|_|    |___/\__/_\_\/_/ /_/___/\__/|___/

 32-bit VexRiscv CPU with MMU integrated in a LiteX SoC

login[81]: root login on 'console'
root@buildroot:~# uname -a
Linux buildroot 5.0.13 #1 Thu Sep 12 14:20:26 CEST 2019 riscv32 GNU/Linux
root@buildroot:~# cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv32ima
mmu             : sv32
uarch           : spinalhdl,vexriscv

root@buildroot:~# cat /proc/meminfo
MemTotal:          19952 kB
MemFree:            7756 kB
MemAvailable:       7208 kB
Buffers:               0 kB
Cached:             9260 kB
SwapCached:            0 kB
Active:              380 kB
Inactive:              0 kB
Active(anon):        380 kB
Inactive(anon):        0 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:        9260 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           408 kB
Mapped:             2236 kB
Shmem:                 0 kB
KReclaimable:        584 kB
Slab:               2124 kB
SReclaimable:        584 kB
SUnreclaim:         1540 kB
KernelStack:         176 kB
PageTables:           60 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:        9976 kB
Committed_AS:       1672 kB
VmallocTotal:     524287 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
Percpu:               32 kB
root@buildroot:~#
```
## reference 
- linux-on-litex-vexriscv  
[https://github.com/litex-hub/linux-on-litex-vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv)
- linux-on-litex-vexriscv-prebuilt  
[https://github.com/antmicro/linux-on-litex-vexriscv-prebuilt](https://github.com/antmicro/linux-on-litex-vexriscv-prebuilt)
