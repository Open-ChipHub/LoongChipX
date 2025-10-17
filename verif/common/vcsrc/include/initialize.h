#pragma once

#include "config.h"
#include "sim_config.h"
#include "ram.h"
#include "rand64.h"

void sim_initialize(Config& config, const SimConfig& sim_cfg, RAM& ram, rand64& random_test);


