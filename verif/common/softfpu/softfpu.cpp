#include "softfpu.h"

Softfpu::Softfpu(){

    this->softfloat = new Softfloat();
}

Softfpu::~Softfpu(){
    ;
}

void Softfpu::fpu_handle(){
    for(int i = 0; i < SOFTFPU_NUM; i++){
        if(*fpu[i].valid){
          softfloat->switch_rm(*fpu[i].rm);
          this->result[i] = \
          softfloat->get_result(*fpu[i].cat,*fpu[i].op,*fpu[i].size,*fpu[i].a,*fpu[i].b,*fpu[i].c);
          *fpu[i].vzoui = this->vzoui[i] = softfloat->get_vziou() & 0x1f;
          *fpu[i].value = result[i];
        }
        else{
          *fpu[i].vzoui = 0;
          *fpu[i].value = 0;
        }
    }
}
