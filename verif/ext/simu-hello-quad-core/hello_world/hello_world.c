/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
#include "printf.h"

int test_lbuf(int res, int m, int n);

int main_hardid_0 (void)
{

  printf("\nI'm Running Core 0 ...\n");
  printf("\nHello Friends!\n");
  printf("I am in LoongArch Platform!\n");

#define TEST_INT 0  
#define TEST_FPU 1  

#if TEST_INT
  int a;
  int b;
  int c;
  int res;
  a = 1235;
  b = 5321;
  c = 0;
  res = 0;

  c = a * b;

  res = test_lbuf(res, 1000, 2);

  printf("res : %d", res);

  printf("\n--------Test INT--------\n");
  
  printf("c  is %lx!\n", c);

  if(c)
    printf("\n!!! PASS !!!\n\n");
  else {
    printf("!!! FAIL !!!");
    printf("after ASM c is changed to %d!\n",c);
  }

#endif


#if TEST_FPU

  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double d5;
  double d6;
  double fres;

  d = 1000.1;

  d1 = d * 1.0 + 1.0;
  d2 = d * 2.0 + 1.0;
  d3 = d * 3.0 + 1.0;
  d4 = d * 4.0 + 1.0;
  d5 = d * 5.0 + 1.0;

  d6 = d4 * d5;
  
  printf("\n--------Test FPU--------\n");

  fres = 0.0;
  printf("d1 is %f!\n", d1);
  printf("d2 is %f!\n", d2);
  printf("d3 is %f!\n", d3);
  printf("d4 is %f!\n", d4);
  printf("d5 is %f!\n", d5);

  printf("d6 (d4*d5) is %f!\n",d6);

  if (fres < 0.0) {
    printf("FPU error!\n");
  }


#endif  

  printf("Main Over!\n");
  return 0;
}

#include <larchintrin.h>

#define BIT(nr)     (1UL << (nr))
#define BIT_ULL(nr)   (1ULL << (nr))


/* PerCore CSR, only accessible by local cores */
#define LOONGARCH_IOCSR_IPI_STATUS  0x1000
#define LOONGARCH_IOCSR_IPI_EN    0x1004
#define LOONGARCH_IOCSR_IPI_SET   0x1008
#define LOONGARCH_IOCSR_IPI_CLEAR 0x100c
#define LOONGARCH_IOCSR_MBUF0   0x1020
#define LOONGARCH_IOCSR_MBUF1   0x1028
#define LOONGARCH_IOCSR_MBUF2   0x1030
#define LOONGARCH_IOCSR_MBUF3   0x1038

#define LOONGARCH_IOCSR_IPI_SEND  0x1040
#define  IOCSR_IPI_SEND_IP_SHIFT  0
#define  IOCSR_IPI_SEND_CPU_SHIFT 16
#define  IOCSR_IPI_SEND_BLOCKING  BIT(31)

#define LOONGARCH_IOCSR_MBUF_SEND 0x1048
#define  IOCSR_MBUF_SEND_BLOCKING BIT_ULL(31)
#define  IOCSR_MBUF_SEND_BOX_SHIFT  2
#define  IOCSR_MBUF_SEND_BOX_LO(box)  (box << 1)
#define  IOCSR_MBUF_SEND_BOX_HI(box)  ((box << 1) + 1)
#define  IOCSR_MBUF_SEND_CPU_SHIFT  16
#define  IOCSR_MBUF_SEND_BUF_SHIFT  32
#define  IOCSR_MBUF_SEND_H32_MASK 0xFFFFFFFF00000000ULL

#define ACTION_BOOT_CPU 0
#define ACTION_RESCHEDULE 1
#define ACTION_CALL_FUNCTION  2
#define ACTION_IRQ_WORK   3

#define iocsr_write32(val, reg) __iocsrwr_w(val, reg)
#define iocsr_write64(val, reg) __iocsrwr_d(val, reg)

static void csr_mail_send(unsigned long data, int cpu, int mailbox)
{
  unsigned long val;

  /* Send high 32 bits */
  val = IOCSR_MBUF_SEND_BLOCKING;
  val |= (IOCSR_MBUF_SEND_BOX_HI(mailbox) << IOCSR_MBUF_SEND_BOX_SHIFT);
  val |= (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
  val |= (data & IOCSR_MBUF_SEND_H32_MASK);
  iocsr_write64(val, LOONGARCH_IOCSR_MBUF_SEND);

  /* Send low 32 bits */
  val = IOCSR_MBUF_SEND_BLOCKING;
  val |= (IOCSR_MBUF_SEND_BOX_LO(mailbox) << IOCSR_MBUF_SEND_BOX_SHIFT);
  val |= (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
  val |= (data << IOCSR_MBUF_SEND_BUF_SHIFT);
  iocsr_write64(val, LOONGARCH_IOCSR_MBUF_SEND);
};

static void ipi_write_action(int cpu, unsigned int action)
{
  unsigned int val;

  val = IOCSR_IPI_SEND_BLOCKING | action;
  val |= (cpu << IOCSR_IPI_SEND_CPU_SHIFT);
  iocsr_write32(val, LOONGARCH_IOCSR_IPI_SEND);
}

static void loongson_send_ipi_single(int cpu, unsigned int action)
{
  ipi_write_action(cpu, (unsigned int)action);
}

unsigned long boot_secondary_addr;

void switch_second() {
  csr_mail_send(boot_secondary_addr, 1, 0);
  loongson_send_ipi_single(1, ACTION_BOOT_CPU);
}

void info_second_core() {
  printf("\n\033[1m\033[32mSwitch to Core 1 ...\033[0m\n");
}

int main_hardid_1 (void)
{

  printf("\n\033[1m\033[32mI'm Running Core 1 ...\n");
  printf("\nHello Friends!\n");
  printf("I am in LoongArch Platform!\n");

#define TEST_INT 0  
#define TEST_FPU 1  

#if TEST_INT
  int a;
  int b;
  int c;
  int res;
  a = 1235;
  b = 5321;
  c = 0;
  res = 0;

  c = a * b;

  res = test_lbuf(res, 1000, 2);

  printf("res : %d", res);

  printf("\n--------Test INT--------\n");
  
  printf("c  is %lx!\n", c);

  if(c)
    printf("\n!!! PASS !!!\n\n");
  else {
    printf("!!! FAIL !!!");
    printf("after ASM c is changed to %d!\n",c);
  }

#endif


#if TEST_FPU

  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double d5;
  double d6;
  double fres;

  d = 1000.1;

  d1 = d * 1.0 + 1.0;
  d2 = d * 2.0 + 1.0;
  d3 = d * 3.0 + 1.0;
  d4 = d * 4.0 + 1.0;
  d5 = d * 5.0 + 1.0;

  d6 = d4 * d5;
  
  printf("\n--------Test FPU--------\n");

  fres = 0.0;
  printf("d1 is %f!\n", d1);
  printf("d2 is %f!\n", d2);
  printf("d3 is %f!\n", d3);
  printf("d4 is %f!\n", d4);
  printf("d5 is %f!\n", d5);

  printf("d6 (d4*d5) is %f!\n",d6);

  if (fres < 0.0) {
    printf("FPU error!\n");
  }


#endif  

  printf("Main Over!\n");
  return 0;
}


unsigned long boot_third_addr;

void switch_third() {
  csr_mail_send(boot_third_addr, 2, 0);
  loongson_send_ipi_single(2, ACTION_BOOT_CPU);
}

void info_third_core() {
  printf("\n\033[1m\033[33mSwitch to Core 2 ...\033[0m\n");
}

int main_hardid_2 (void)
{

  printf("\n\033[1m\033[33mI'm Running Core 2 ...\n");
  printf("\nHello Friends!\n");
  printf("I am in LoongArch Platform!\n");

#define TEST_INT 0  
#define TEST_FPU 1  

#if TEST_INT
  int a;
  int b;
  int c;
  int res;
  a = 1235;
  b = 5321;
  c = 0;
  res = 0;

  c = a * b;

  res = test_lbuf(res, 1000, 2);

  printf("res : %d", res);

  printf("\n--------Test INT--------\n");
  
  printf("c  is %lx!\n", c);

  if(c)
    printf("\n!!! PASS !!!\n\n");
  else {
    printf("!!! FAIL !!!");
    printf("after ASM c is changed to %d!\n",c);
  }

#endif


#if TEST_FPU

  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double d5;
  double d6;
  double fres;

  d = 1000.1;

  d1 = d * 1.0 + 1.0;
  d2 = d * 2.0 + 1.0;
  d3 = d * 3.0 + 1.0;
  d4 = d * 4.0 + 1.0;
  d5 = d * 5.0 + 1.0;

  d6 = d4 * d5;
  
  printf("\n--------Test FPU--------\n");

  fres = 0.0;
  printf("d1 is %f!\n", d1);
  printf("d2 is %f!\n", d2);
  printf("d3 is %f!\n", d3);
  printf("d4 is %f!\n", d4);
  printf("d5 is %f!\n", d5);

  printf("d6 (d4*d5) is %f!\n",d6);

  if (fres < 0.0) {
    printf("FPU error!\n");
  }


#endif  

  printf("Main Over!\n");
  return 0;
}


unsigned long boot_fourth_addr;

void switch_fourth() {
  csr_mail_send(boot_fourth_addr, 3, 0);
  loongson_send_ipi_single(3, ACTION_BOOT_CPU);
}

void info_fourth_core() {
  printf("\n\033[1m\033[34mSwitch to Core 3 ...\033[0m\n");
}

int main_hardid_3 (void)
{

  printf("\n\033[1m\033[34mI'm Running Core 3 ...\n");
  printf("\nHello Friends!\n");
  printf("I am in LoongArch Platform!\n");

#define TEST_INT 0  
#define TEST_FPU 1  

#if TEST_INT
  int a;
  int b;
  int c;
  int res;
  a = 1235;
  b = 5321;
  c = 0;
  res = 0;

  c = a * b;

  res = test_lbuf(res, 1000, 2);

  printf("res : %d", res);

  printf("\n--------Test INT--------\n");
  
  printf("c  is %lx!\n", c);

  if(c)
    printf("\n!!! PASS !!!\n\n");
  else {
    printf("!!! FAIL !!!");
    printf("after ASM c is changed to %d!\n",c);
  }

#endif


#if TEST_FPU

  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double d5;
  double d6;
  double fres;

  d = 1000.1;

  d1 = d * 1.0 + 1.0;
  d2 = d * 2.0 + 1.0;
  d3 = d * 3.0 + 1.0;
  d4 = d * 4.0 + 1.0;
  d5 = d * 5.0 + 1.0;

  d6 = d4 * d5;
  
  printf("\n--------Test FPU--------\n");

  fres = 0.0;
  printf("d1 is %f!\n", d1);
  printf("d2 is %f!\n", d2);
  printf("d3 is %f!\n", d3);
  printf("d4 is %f!\n", d4);
  printf("d5 is %f!\n", d5);

  printf("d6 (d4*d5) is %f!\n",d6);

  if (fres < 0.0) {
    printf("FPU error!\n");
  }


#endif  

  printf("Main Over!\n");
  return 0;
}

