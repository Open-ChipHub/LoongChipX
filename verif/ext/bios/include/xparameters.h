#ifndef XPARAMETERS_H   /* prevent circular inclusions */
#define XPARAMETERS_H   /* by using protection macros */

/* Definitions for bus frequencies */
#define XPAR_CPU_M_AXI_DP_FREQ_HZ 100000000
/******************************************************************/

/* Canonical definitions for bus frequencies */
/******************************************************************/

#define XPAR_CPU_CORE_CLOCK_FREQ_HZ 100000000
#define XPAR_MICROBLAZE_CORE_CLOCK_FREQ_HZ 100000000

/******************************************************************/

#define STDIN_BASEADDRESS 0x1FF00000
#define STDOUT_BASEADDRESS 0x1FF00000

/******************************************************************/

/* Definitions for peripheral DDR4_0 */
#define XPAR_DDR4_0_C0_DDR4_MEMORY_MAP_BASEADDR 0x100000000U
#define XPAR_DDR4_0_C0_DDR4_MEMORY_MAP_HIGHADDR 0x1FFFFFFFFU


/******************************************************************/

/* Canonical definitions for peripheral DDR4_0 */
#define XPAR_MIG_0_C0_DDR4_MEMORY_MAP_BASEADDR 0x100000000U
#define XPAR_MIG_0_C0_DDR4_MEMORY_MAP_HIGHADDR 0x1FFFFFFFFU


/******************************************************************/

/* Definitions for driver SPI */
#define XPAR_XSPI_NUM_INSTANCES 1U

/* Definitions for peripheral AXI_QUAD_SPI_0 */
#define XPAR_AXI_QUAD_SPI_0_DEVICE_ID 0U
#define XPAR_AXI_QUAD_SPI_0_BASEADDR 0x80000000U
#define XPAR_AXI_QUAD_SPI_0_HIGHADDR 0x8000FFFFU
#define XPAR_AXI_QUAD_SPI_0_FIFO_EXIST 1U
#define XPAR_AXI_QUAD_SPI_0_FIFO_DEPTH 256U
#define XPAR_AXI_QUAD_SPI_0_SPI_SLAVE_ONLY 0U
#define XPAR_AXI_QUAD_SPI_0_NUM_SS_BITS 2U
#define XPAR_AXI_QUAD_SPI_0_NUM_TRANSFER_BITS 8U
#define XPAR_AXI_QUAD_SPI_0_SPI_MODE 2U
#define XPAR_AXI_QUAD_SPI_0_TYPE_OF_AXI4_INTERFACE 1U
#define XPAR_AXI_QUAD_SPI_0_AXI4_BASEADDR 0x80000000U
#define XPAR_AXI_QUAD_SPI_0_AXI4_HIGHADDR 0x8000FFFFU
#define XPAR_AXI_QUAD_SPI_0_XIP_MODE 0U

/* Canonical definitions for peripheral AXI_QUAD_SPI_0 */
#define XPAR_SPI_0_DEVICE_ID 0U
#define XPAR_SPI_0_BASEADDR 0x80000000U
#define XPAR_SPI_0_HIGHADDR 0x8000FFFFU
#define XPAR_SPI_0_FIFO_EXIST 1U
#define XPAR_SPI_0_FIFO_DEPTH 256U
#define XPAR_SPI_0_SPI_SLAVE_ONLY 0U
#define XPAR_SPI_0_NUM_SS_BITS 2U
#define XPAR_SPI_0_NUM_TRANSFER_BITS 8U
#define XPAR_SPI_0_SPI_MODE 2U
#define XPAR_SPI_0_TYPE_OF_AXI4_INTERFACE 1U
#define XPAR_SPI_0_AXI4_BASEADDR 0x80000000U
#define XPAR_SPI_0_AXI4_HIGHADDR 0x8000FFFFU
#define XPAR_SPI_0_XIP_MODE 0U
#define XPAR_SPI_0_USE_STARTUP 1U


/******************************************************************/

/* Definitions for driver UARTNS550 */
#define XPAR_XUARTNS550_NUM_INSTANCES 1U
#define XPAR_XUARTNS550_CLOCK_HZ 100000000U

/* Definitions for peripheral AXI_UART16550_0 */
#define XPAR_AXI_UART16550_0_DEVICE_ID 0U
#define XPAR_AXI_UART16550_0_BASEADDR 0x1FF00000U
#define XPAR_AXI_UART16550_0_HIGHADDR 0x1FF0FFFFU
#define XPAR_AXI_UART16550_0_CLOCK_FREQ_HZ 100000000U


/******************************************************************/

/* Canonical definitions for peripheral AXI_UART16550_0 */
#define XPAR_UARTNS550_0_DEVICE_ID 0U
#define XPAR_UARTNS550_0_BASEADDR 0x1FF00000U
#define XPAR_UARTNS550_0_HIGHADDR 0x1FF0FFFFU
#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_AXI_UART16550_0_CLOCK_FREQ_HZ


/******************************************************************/

#endif  /* end of protection macro */
