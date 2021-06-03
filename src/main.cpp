#include <stdio.h>
#include "loguru.hpp"

int main(int argc, char *argv[])
{
    // Initialize LOGURU
    loguru::init(argc, argv);
    loguru::g_flush_interval_ms = 100;  // flush every 100 ms


    LOG_F(INFO,"Hello World\n");
}