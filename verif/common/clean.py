#!/bin/python3
import os
import re
import sys

pat = re.compile('(?P<space>(.*_)?)(?P<time>\d+)')

def clean_from_list(log_path, files):
    for file in files:
        to_clear = os.path.join(log_path, file)
        print("clean: " + to_clear)
        os.system(f"rm -r {to_clear}")

def clean_oldest(files, log_path, save_num):
    if len(files) > save_num:
        files = sorted(files)
        files = files[0:-save_num]
    else:
        files = []
    clean_from_list(log_path, [file for time,file in files])

def clean_unexpected(files, log_path):
    remain = []
    token_name = 'clean-unexpected.txt'
    token_file = os.path.join(log_path,token_name)
    if len(files) > 0:
        print('[Warning] logs directory is not in expected format.', file=sys.stderr)
        if os.path.exists(token_file):
            with open(token_file,'r') as f:
                lines = [line.strip() for line in f.readlines()]
            to_clean = []
            for name in files:
                if name == token_name:
                    pass
                elif name in lines:
                    to_clean.append(name)
                else:
                    remain.append(name)
            clean_from_list(log_path, to_clean)
        else:
            remain = files
    if len(remain) > 0:
        with open(token_file,'w') as f:
            for name in files:
                print(name,file=f)
                print('"%s" will be removed during next clean-up' % name,file=sys.stderr)
    elif os.path.exists(token_file):
        clean_from_list(log_path, [token_file])


def clean_log(config) -> None:
    # load config to cfg
    cfg = {}
    current_path = os.path.abspath(os.path.dirname(__file__)) + "/"
    fo = open(current_path + config, "r")
    for line in fo.readlines():
        key = line.split("=")[0].strip()
        value = line.split("=")[-1].strip()
        cfg[key] = value
        
    save_num = int(cfg.get("save_num", "5"))
    log_dir  = cfg.get("log_dir", "logs")

    log_path = os.path.join(current_path, log_dir)
    files = {}
    unexpected_files = []
    for fname in os.listdir(log_path):
        res = pat.match(fname)
        if fname == 'latest':
            pass
        elif res:
            space = res.group('space')
            if space not in files:
                files[space] = []
            files[space].append((res.group('time'), fname))
        else:
            unexpected_files.append(fname)

    # pick stale files (oldest N - save_num) in each space
    for space in files:
        clean_oldest(files[space], log_path, save_num)

    clean_unexpected(unexpected_files, log_path)


    if save_num == 0:
        linked_lastest = os.path.join(log_path,'lastest')
        if os.path.exists(linked_lastest):
            os.remove(linked_lastest)

if __name__ == "__main__":
    if (len(sys.argv) < 2):
        print("args error!")
        exit(-1)
    clean_log(sys.argv[1])
