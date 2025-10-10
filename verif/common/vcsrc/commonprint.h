#ifndef _COMMONPRINT_H
#define _COMMONPRINT_H
// <------------------ DEBUG ------------------>
// debug mode on or off
#define __DEBUG

// debug area partition
#define DEBUG_MAIN     0b00000000001
#define DEBUG_SNAPSHOT 0b00000000010
#define DEBUG_FPR      0b00000000100
#define DEBUG_AXI      0b00000001000
#define DEBUG_CORE     0b00000010000
#define DEBUG_RAM      0b00000100000
// debug area bit mask
// #define DEBUG_SCOPE (0 | DEBUG_FPR | DEBUG_MAIN | DEBUG_AXI)
#define DEBUG_SCOPE (0 | DEBUG_FPR | DEBUG_MAIN)

// standard print color
#define PRINT_DEFAULT     "\033[0m"
#define PRINT_BLACK       "\033[30m"             /* Black */
#define PRINT_RED         "\033[31m"             /* Red */
#define PRINT_GREEN       "\033[32m"             /* Green */
#define PRINT_YELLOW      "\033[33m"             /* Yellow */
#define PRINT_BLUE        "\033[34m"             /* Blue */
#define PRINT_MAGENTA     "\033[35m"             /* Magenta */
#define PRINT_CYAN        "\033[36m"             /* Cyan */
#define PRINT_WHITE       "\033[37m"             /* White */
#define PRINT_BOLDBLACK   "\033[1m\033[30m"      /* Bold Black */
#define PRINT_BOLDRED     "\033[1m\033[31m"      /* Bold Red */
#define PRINT_BOLDGREEN   "\033[1m\033[32m"      /* Bold Green */
#define PRINT_BOLDYELLOW  "\033[1m\033[33m"      /* Bold Yellow */
#define PRINT_BOLDBLUE    "\033[1m\033[34m"      /* Bold Blue */
#define PRINT_BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */
#define PRINT_BOLDCYAN    "\033[1m\033[36m"      /* Bold Cyan */
#define PRINT_BOLDWHITE   "\033[1m\033[37m"      /* Bold White */
// default print color in several scenes
#define PRINT_DEBUG   PRINT_CYAN
#define PRINT_WARN    PRINT_YELLOW
#define PRINT_ERROR   PRINT_RED
#define PRINT_SUCCESS PRINT_GREEN

// debug print
#ifdef __DEBUG
#define DEBUG(scope,color,format,...) (scope & DEBUG_SCOPE) && fprintf(stderr, color "FILE:%s ,LINE:%d: " format "\n" PRINT_DEFAULT,__FILE__,__LINE__,##__VA_ARGS__)
#else
#define DEBUG(scope,color,format,...)
#endif

// info output print
#ifndef __QUIET 
#define INFO(color,format,...) printf(color format PRINT_DEFAULT,##__VA_ARGS__)
#else
#define INFO(color,format,...)
#endif

// error print
#ifndef __QUIET
#define ERROR(format,...) printf(PRINT_ERROR "FILE:%s ,LINE:%d: " format "\n" PRINT_DEFAULT,__FILE__,__LINE__,##__VA_ARGS__)
#else
#define ERROR(format,...)
#endif

#endif