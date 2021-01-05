#!/bin/bash

#scp ubuntu@192.168.31.132:/home/ubuntu/oss/colorlight/litexOnColorlightLab004/build/colorlight_5a_75b/gateware_icesugar_pro_v1.1/colorlight_5a_75b.bit .

#scp ubuntu@192.168.31.132:/home/ubuntu/oss/colorlight/riscvOnColorlight-5A-75B/build/colorlight_5a_75b/gateware_icesugar_pro_v1.1/colorlight_5a_75b.bit ./litex_with_dram.bit

scp -r ubuntu@192.168.31.132:/home/ubuntu/oss/colorlight/Colorlight-FPGA-Projects/src/i5/hdmi_test_pattern ./
