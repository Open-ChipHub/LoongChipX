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
/*
 * timer.h -- The interface functions and Mcros for SMART
 *
 */
#include "config.h"

#ifndef __CSKY_DEMO_TIMER_H
#define __CSKY_DEMO_TIMER_H

#define TIMER_PERIOD 0xffffffff

extern int Loop_Num;

typedef struct CKS_TIMER
{
    volatile unsigned int    LoadCount;		/* The value to be loaded into Timer */
    volatile unsigned int    CurrentValue;	/* Timer Current Value */
    volatile unsigned int    Control;		/* Timer Control Register */
    volatile unsigned int    EOI;		/* Timer Clears the interrupt status */
    volatile unsigned int    IntStatus;		/* Timer Contains the interrupt status */
}CKStruct_TIMER,* CKPStruct_TIMER;

#define SMART_TIMER_BASE          0x10011000

///* Contains the interrupt status of all timers in the component. */
//#define SMART_TIMER_INTSTATUS     0x10011028
//
///* Returns all zeroes (0) and clears all active interrupts */
//#define SMART_TIMER_EOI           0x1001102c
//
///* Contains the unmasked interrupt status of all timers in the component */
//#define SMART_TIMER_RAW_INTSTATUS (volatile unsigned int *)0x10011030

/*
 * Start timer.
 */
static int start_timer()
{
#if CONFIG_SYS_SPARK
    return 0;
#endif
  CKPStruct_TIMER pTimer = (CKPStruct_TIMER)(SMART_TIMER_BASE);
  pTimer->LoadCount = TIMER_PERIOD;
  asm("":::"memory");
  pTimer->Control = 0x00000003;
  return  pTimer->CurrentValue;
}


static int start_set_timer(int a)
{
#if CONFIG_SYS_SPARK
    return 0;
#endif
  CKPStruct_TIMER pTimer = (CKPStruct_TIMER)(SMART_TIMER_BASE);
  pTimer->LoadCount = a;
  asm("":::"memory");
  pTimer->Control = 0x00000003;
  return  pTimer->CurrentValue;
}

/*
 * Get timer value
 */
static int get_timer()
{
#if CONFIG_SYS_SPARK
    return 0;
#endif
  CKPStruct_TIMER pTimer = (CKPStruct_TIMER)(SMART_TIMER_BASE);
  return pTimer->CurrentValue;
}


/*
 * Stop timer
 */
static int stop_timer()
{
#if CONFIG_SYS_SPARK
    return 0;
#endif
  int temp;
  CKPStruct_TIMER pTimer = (CKPStruct_TIMER)(SMART_TIMER_BASE);
  temp = pTimer->CurrentValue;
  pTimer->Control = 0x00000002;
  return temp;
}

#endif /* __CSKY_DEMO_TIMER_H */


