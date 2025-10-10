
typedef unsigned long    uint64_t;
typedef unsigned int     uint32_t;
typedef unsigned char    uint8_t;
typedef unsigned long    uintptr_t;

#define UART_BASE 0x11ff00000UL

#define UART_RBR UART_BASE + 0
#define UART_THR UART_BASE + 0
#define UART_INTERRUPT_ENABLE UART_BASE + 4
#define UART_INTERRUPT_IDENT UART_BASE + 8
#define UART_FIFO_CONTROL UART_BASE + 8
#define UART_LINE_CONTROL UART_BASE + 12
#define UART_MODEM_CONTROL UART_BASE + 16
#define UART_LINE_STATUS UART_BASE + 20
#define UART_MODEM_STATUS UART_BASE + 24
#define UART_DLAB_LSB UART_BASE + 0
#define UART_DLAB_MSB UART_BASE + 4


void write_reg_u8(uintptr_t addr, uint8_t value)
{
    volatile uint8_t *loc_addr = (volatile uint8_t *)addr;
    *loc_addr = value;
}

uint8_t read_reg_u8(uintptr_t addr)
{
    return *(volatile uint8_t *)addr;
}

int is_transmit_empty(void)
{
    return read_reg_u8(UART_LINE_STATUS) & 0x20;
}

void write_serial(char a)
{
    while (is_transmit_empty() == 0) {};

    write_reg_u8(UART_THR, a);
}

void init_uart(uint32_t freq, uint32_t baud)
{
    uint32_t divisor = freq / (baud << 4);

    write_reg_u8(UART_INTERRUPT_ENABLE, 0x00); // Disable all interrupts
    write_reg_u8(UART_LINE_CONTROL, 0x80);     // Enable DLAB (set baud rate divisor)
    write_reg_u8(UART_DLAB_LSB, divisor);         // divisor (lo byte)
    write_reg_u8(UART_DLAB_MSB, (divisor >> 8) & 0xFF);  // divisor (hi byte)
    write_reg_u8(UART_LINE_CONTROL, 0x03);     // 8 bits, no parity, one stop bit
    write_reg_u8(UART_FIFO_CONTROL, 0xC7);     // Enable FIFO, clear them, with 14-byte threshold
    write_reg_u8(UART_MODEM_CONTROL, 0x20);    // Autoflow mode
}

void print_uart(const char *str)
{
    const char *cur = &str[0];
    while (*cur != '\0')
    {
        write_serial((uint8_t)*cur);
        ++cur;
    }
}

uint8_t bin_to_hex_table[16] = {
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

void bin_to_hex(uint8_t inp, uint8_t res[2])
{
    res[1] = bin_to_hex_table[inp & 0xf];
    res[0] = bin_to_hex_table[(inp >> 4) & 0xf];
    return;
}

void print_uart_int(uint32_t addr)
{
    int i;
    for (i = 3; i > -1; i--)
    {
        uint8_t cur = (addr >> (i * 8)) & 0xff;
        uint8_t hex[2];
        bin_to_hex(cur, hex);
        write_serial(hex[0]);
        write_serial(hex[1]);
    }
}

void print_uart_addr(uint64_t addr)
{
    int i;
    for (i = 7; i > -1; i--)
    {
        uint8_t cur = (addr >> (i * 8)) & 0xff;
        uint8_t hex[2];
        bin_to_hex(cur, hex);
        write_serial(hex[0]);
        write_serial(hex[1]);
    }
}

void print_uart_byte(uint8_t byte)
{
    uint8_t hex[2];
    bin_to_hex(byte, hex);
    write_serial(hex[0]);
    write_serial(hex[1]);
}

#define UART_BASEADDR   STDOUT_BASEADDR
#define UART_BAUD       115200

void outbyte(char c) {
     write_serial(c);
}

void xil_printf(char *s)
{
  while (*s) {
    write_serial(*s);
    s++;
  }
}

void uart_print(const char *ptr)
{
  while (*ptr != (char)0) {
    outbyte (*ptr);
    ptr++;
  }
}

void putnum(unsigned int num)
{
  char  buf[9];
  int   cnt, val=7;
  int   i;
  char  *ptr;
  unsigned int  digit;
  for(i = 0; i<8; i++) {
     buf[i] = '0';
  }

  buf[8] = '\0';

  ptr = buf;
  for (cnt = 0 ; cnt <= 7 ; cnt++) {
    digit = (num >> ((unsigned int)val * 4U)) & 0x0000000fU;
    if (digit <= 9U) {
        digit += (unsigned int)'0';
        *ptr = ((char) digit);
        ptr += 1;
     } else {
        digit += ((unsigned int)'A' - (unsigned int)10);
        *ptr = ((char)digit);
        ptr += 1;
     }
     val--;
  }
  uart_print (buf);
}


void printnum_64_inner(unsigned long num)
{
  char  buf[17];
  int  cnt, val=15;
  int i;
  char  *ptr;
  unsigned int  digit;
  for(i = 0; i<16; i++) {
     buf[i] = '0';
  }

  buf[16] = '\0';

  ptr = buf;
  for (cnt = 0 ; cnt <= 15 ; cnt++) {
    digit = (num >> ((unsigned int)val * 4U)) & 0x0000000fU;
    if (digit <= 9U) {
        digit += (unsigned int)'0';
        *ptr = ((char) digit);
        ptr += 1;
     } else {
        digit += ((unsigned int)'A' - (unsigned int)10);
        *ptr = ((char)digit);
        ptr += 1;
     }
     val--;
  }
  uart_print (buf);
}

void printnum_64(unsigned long num) {
  uart_print("0x");
  printnum_64_inner(num);
  uart_print("\r\n");
}


void printnum_64(unsigned long num);
void kernel_start_kernel_info(int level) {
  uart_print("[INFO]: Start Linux Kernel Stage:");
  printnum_64(level);
}

void kernel_boot_uart_init(void) {
  // 100M, 115200
  init_uart(100000000, 115200);
}

void kernel_boot_info(void) {
  uart_print("[INFO]: Start Linux Kernel \r\n");
}

void kernel_sim_stop_stub(void) {

  __asm__ (" li.d $r4, 0x1FF80000 \t\n" 
           " li.d $r5, 0xF \t\n"
           " st.d $r5, $r4, 0 \t\n"
           : :);
}


void dbg_log(const char *s)
{
  char c;
  while ((c = *s++) != '\0') {
    outbyte(c);
    if (c == '\n')
      outbyte('\r');
  }
}

void dbg_log_hex64(unsigned long long val)
{
  unsigned char buf[18];
  int i;
  for (i = 15; i >= 0; i--) {
    buf[i] = "0123456789ABCDEF"[val & 0x0F];
    val >>= 4;
  }
  buf[16] = '\0';
  dbg_log(buf);
}


void boot_uart_init(void) {
  // 100M, 115200
  init_uart(100000000, 115200);
  uart_print("\r\nLoongArch!\r\n");
}

