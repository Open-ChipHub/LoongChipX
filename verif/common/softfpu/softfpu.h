#ifndef _SIM_SOFTFPU_H
#define _SIM_SOFTFPU_H

// #include "fakecpu.h" 
#include"softfloat.h"
#include<cstdint>

#define SOFTFPU_NUM 4

class SoftfpuPorts{
public:
    uint8_t*  valid;
    uint8_t*  cat;
    uint8_t*  op;
    uint8_t*  rm;
    uint8_t*  size;
    uint64_t* a;
    uint64_t* b;
    uint64_t* c;
    uint64_t* value;
    uint8_t*  vzoui; 
};

class Softfpu{
private:
    class Softfloat *softfloat;

public:
    Softfpu();
    ~Softfpu();
    class SoftfpuPorts fpu[SOFTFPU_NUM];
 
    /** vzoui state for each fpu simulated*/
    uint8_t vzoui[SOFTFPU_NUM];
    /** result state for each fpu simulated*/
    uint64_t result[SOFTFPU_NUM];

    void    fpu_handle();
};

#endif
