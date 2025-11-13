#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <dlfcn.h>
#include "emuproxy.h"

extern char* chiplab_home;
extern char* difftest_ref_so;

EmuProxy::EmuProxy(int coreid) {
    if (difftest_ref_so == NULL) {
        printf("--diff is not given, "
                "try to use la_emu_ref.so by "
                "default\n");
        const char* so = "/home/airxs/user/cpu/system/soc-lab164-emu-diff/build/la_emu_ref.so";
        char* buf = (char*)malloc(strlen(so) + 1);
        // strcpy(buf, chiplab_home);
        strcpy(buf, so);
        if (access(buf, F_OK)) {
            printf("no such file or directory : %s\n", buf);
            exit(1);
        }
        difftest_ref_so = buf;
    }
    printf("Using %s for difftest\n", difftest_ref_so);

#ifdef __linux__
    handle = dlmopen(LM_ID_NEWLM, difftest_ref_so, RTLD_LAZY | RTLD_DEEPBIND);
    if (!handle) {
        printf("%s\n", dlerror());
        assert(0);
    }
    this->memcpy = (void (*)(paddr_t, void*, size_t, bool))dlsym( handle, "loong64_difftest_memcpy");
    check_and_assert(this->memcpy);

    regcpy = (void (*)(void*, bool, int))dlsym(handle, "loong64_difftest_gprcpy");
    check_and_assert(regcpy);

    csrcpy = (void (*)(void*, bool))dlsym(handle, "loong64_difftest_csrcpy");
    check_and_assert(csrcpy);

    exec = (void (*)(uint64_t, bool))dlsym(handle, "loong64_difftest_exec");
    check_and_assert(exec);

    check_end = (int(*)(void))dlsym(handle, "loong64_difftest_cosim_end");
    check_and_assert(check_end);

    store_commit = (int (*)(uint64_t, uint64_t))dlsym(handle, "loong64_difftest_store_commit");
    check_and_assert(store_commit);

    raise_trap = (void (*)(int, uint64_t, uint64_t))dlsym(handle, "loong64_difftest_raise_trap");
    check_and_assert(raise_trap);

    isa_reg_display = (void (*)(void))dlsym(handle, "loong64_isa_reg_display");
    check_and_assert(isa_reg_display);

    timercpy = (void (*)(void*, bool))dlsym(handle, "loong64_difftest_timercpy");
    check_and_assert(timercpy);

    estat_sync = (void (*)(uint64_t, uint64_t))dlsym(handle, "loong64_difftest_estat_sync");
    check_and_assert(estat_sync);

    init = (void (*)(uint8_t*))dlsym(handle, "loong64_difftest_init");
    check_and_assert(init);

    get_inst = (uint32_t (*)(uint64_t))dlsym(handle, "loong64_difftest_get_inst_by_pc");
    check_and_assert(get_inst);

    get_cur_pc = (uint64_t (*)(void))dlsym(handle, "loong64_difftest_get_cur_pc");
    check_and_assert(get_cur_pc);

    get_prev_pc = (uint64_t (*)(void))dlsym(handle, "loong64_difftest_get_prev_pc");
    check_and_assert(get_prev_pc);

    csrcpy_idx = (void (*)(int, uint64_t*, uint64_t, bool))dlsym(handle, "loong64_difftest_csrcpy_idx");
    check_and_assert(csrcpy_idx);

#else
    printf("The current platform is not supported.\n");
    exit(1);
#endif
}

EmuProxy::~EmuProxy() {
    if (handle != NULL) {
        dlclose(handle);
    }
}

