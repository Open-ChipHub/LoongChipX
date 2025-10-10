#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

enum IF_TYPE{
  IF_TYPE_NONE,
  IF_TYPE_REDUCE,
  IF_TYPE_UNREDUCE,
};

enum TRACE_ITEM_TYPE{
  TRACE_ITEM_COMMIT,
  TRACE_ITEM_EX, // pc as epc, inst as badv, res as ecode
};

typedef struct {
    uint64_t commit_id; // instruction count, increase 1 every commit instruction
    uint64_t pc; // instruction pc
    uint64_t inst; // instruction raw bits
    uint64_t res;    // logic register write content
    uint64_t id; // debug id
    uint8_t wen;    // writen enable
    uint8_t laddr;  // logic register addr
    uint8_t package_head; // first committed instruction in commit package
    uint8_t excu; // execution unit
    uint8_t f_or_x;  // float or fixed
    uint8_t fusion_type;  // instruction fusion type @IF_TYPE
} commit_info;

typedef struct {
    uint64_t exception_id; // exception count, increase 1 every exception
    uint64_t ecode;
    uint64_t badv;
    uint64_t epc;
    uint64_t line; //for random test only, line of epc, pc.res
} exception_info;

typedef struct {
    uint64_t type; // trace yype @TRACE_ITEM_TYPE
    union {
        commit_info commit;
        exception_info exception;
    };
} trace_item;

void dump_random_test(const char* trace_filename, const char* random_test_dir) {
    FILE* sim_trace_file = fopen(trace_filename, "rb");
    if (! sim_trace_file) {
        perror(trace_filename);
        abort();
    }

    char result_filename[1024];
    sprintf(result_filename, "%s/%s", random_test_dir, "/result.txt");
    FILE* result_txt_file = fopen(result_filename, "w");
    if (! result_txt_file) {
        perror(result_filename);
        abort();
    }
    sprintf(result_filename, "%s/%s", random_test_dir, "/result.epc.txt");
    FILE* result_epc_file = fopen(result_filename, "w");
    if (! result_epc_file) {
        perror(result_filename);
        abort();
    }
    sprintf(result_filename, "%s/%s", random_test_dir, "/result.ecode.txt");
    //TODO, ecode should be translated
    FILE* result_ecode_file = fopen(result_filename, "w");
    if (! result_ecode_file) {
        perror(result_filename);
        abort();
    }

    trace_item t;
    int r;
    while (fread(&t, sizeof(t), 1, sim_trace_file) == 1) {
        if (t.type == TRACE_ITEM_COMMIT) {
            if (t.commit.pc < 0x1c000000) {
                fprintf(result_txt_file, "%c %d %2d %016lx %05lx %1x\n", (t.commit.package_head ? '#' : '@'), t.commit.wen, t.commit.laddr, t.commit.wen ? t.commit.res : 0, t.commit.id, t.commit.excu);
            }
        } else if (t.type == TRACE_ITEM_EX) {
                fprintf(result_epc_file, "%lx\n",t.exception.line);
                fprintf(result_ecode_file, "%lx\n", t.exception.ecode);
        } else {
            abort();
        }
    };
    fclose(sim_trace_file);
    fclose(result_txt_file);
    fclose(result_epc_file);
    fclose(result_ecode_file);
}

int main(int argc, char** argv) {
    assert(argc == 3);
    dump_random_test(argv[1], argv[2]);
    return 0;
}