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
#include <stdio.h>

// #define LACORE_LOG_ADDR  ((int *)0x1FF10000)
#define LACORE_LOG_ADDR  ((int *)0x800000001FF10000)

int fputc(int ch, FILE *stream)
{
  volatile int* addr_ptr;
  addr_ptr = LACORE_LOG_ADDR;
  *(addr_ptr) = ch;

  // asm volatile(
  //       "li.d  $r21, 0x1FF10000 \n\t"
  //       "st.w %0, $r21, 0 \n\t"
  //       : : "r" (ch) 
  //       : "memory" 
  //   );
}

