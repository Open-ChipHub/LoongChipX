/******************************************************************************
* Copyright (C) 2004 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
#include "xparameters.h"
#include "platform_config.h"
#include "xuartns550_l.h"

void init_uart()
{
  #define STDOUT_BASEADDR XPAR_AXI_UART16550_0_BASEADDR
  #define UART_BASEADDR   STDOUT_BASEADDR
  #define UART_BAUD       115200
   
   XUartNs550_SetBaud(STDOUT_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, UART_BAUD);
   XUartNs550_SetLineControlReg(STDOUT_BASEADDR, XUN_LCR_8_DATA_BITS);
}