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

int main (void)
{

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
