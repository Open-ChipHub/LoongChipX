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

int main (void)
{

//Section 1: Hello World!
  printf("\nHello Friends!\n");
  printf("I am in LoongArch Platform!\n");

//Section 2: Embeded ASM in C 
  int a;
  int b;
  int c;
  a = 1235;
  b = 5321;
  c = 0;

  c = a * b;
  
  printf("\n--------Test--------\n");
  printf("a is 0x%x!\n",a);
  printf("b is 0x%x!\n",b);
  printf("c = (a * b) \n");
  printf("c is %d!\n",c);


  if(c)
    printf("\n!!! PASS !!!\n\n");
  else {
    printf("\n!!! FAIL !!!\n");
    printf("after ASM c is changed to %d!\n",c);
  }
  return 0;
}

// int main (void)
// {
//   long a = 0x1111111111111235;
//   printf("%x!\n",a);
//   return 0;
// }