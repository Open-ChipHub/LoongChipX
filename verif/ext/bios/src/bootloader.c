/******************************************************************************
* Copyright (C) 2009 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/


/*****************************************************************************/
/*
 *      Simple SREC Bootloader
 *      It is capable of booting an SREC format image file (Mototorola S-record format),
 *      given the location of the image in memory.
 *      In particular, this bootloader is designed for images stored in non-volatile flash
 *      memory that is addressable from the processor.
 *
 *      Please modify the define "FLASH_IMAGE_BASEADDR" in the blconfig.h header file
 *      to point to the memory location from which the bootloader has to pick up the
 *      flash image from.
 *
 *      You can include these sources in your software application project and build
 *      the project for the processor for which you want the bootload to happen.
 *      You can also subsequently modify these sources to adapt the bootloader for any
 *      specific scenario that you might require it for.
 *
 */

// #include <stdio.h>
// #include <stdlib.h>
#include <string.h>

#include "portab.h"
#include "xparameters.h"
#include "xspi.h"

/* Defines */
#define CR       13
#define RECORD_TYPE	2
#define BYTE_COUNT	2
#define RECORD_TERMINATOR	2

/* Comment the following line, if you want a smaller and faster bootloader which will be silent */
// #define VERBOSE

/* Declarations */
static uint8_t load_exec(XSpi *Spi, int *mode, u32 *flbuf);
static uint32_t flash_get_sector_data(XSpi *Spi, int *mode, u32 *flbuf, uint8_t *buf);
int FlashReadID(XSpi *Spi);
void putnum(u32 num);


// platform define
#define DDR4_BASE_OFFSET 0x100000000UL
#define DDR4_KERNEL_BASE 0x102000000UL

// #define DDR4_KERNEL_SIZE 0x1000000U
#define DDR4_KERNEL_SIZE 0x1000000U    // 16MB kernel

#define FLASH_IMAGE_BASEADDR  0x2000000U

#define TRANSFER_BYTE_COUNT 128


/*
 * The following constant defines the slave select signal that is used to
 * to select the Flash device on the SPI bus, this signal is typically
 * connected to the chip select of the device.
 */
#define SPI_SELECT		0x01

/*
 * Number of bytes per page in the flash device.
 */
#define PAGE_SIZE		256

/*
 * Byte Positions.
 */
#define BYTE1				0 /* Byte 1 position */
#define BYTE2				1 /* Byte 2 position */
#define BYTE3				2 /* Byte 3 position */
#define BYTE4				3 /* Byte 4 position */
#define BYTE5				4 /* Byte 5 position */

#define READ_WRITE_EXTRA_BYTES		4 /* Read/Write extra bytes */
#define	READ_WRITE_EXTRA_BYTES_4BYTE_MODE	5 /**< Command extra bytes */

#define RD_ID_SIZE					4

#define ISSI_ID_BYTE0			0x9D
#define MICRON_ID_BYTE0			0x20

#define ENTER_4B_ADDR_MODE		0xb7 /* Enter 4Byte Mode command */
#define EXIT_4B_ADDR_MODE		0xe9 /* Exit 4Byte Mode command */
#define EXIT_4B_ADDR_MODE_ISSI	0x29
#define	WRITE_ENABLE			0x06 /* Write Enable command */

#define ENTER_4B	1
#define EXIT_4B		0

#define	FLASH_16_MB	0x18
#define FLASH_MAKE		0
#define	FLASH_SIZE		2

#define	READ_CMD	0x03

#define SPI_DEVICE_ID		XPAR_SPI_0_DEVICE_ID

/*
 * The instances to support the device drivers are global such that they
 * are initialized to zero each time the program runs. They could be local
 * but should at least be static so they are zeroed.
 */

// XSpi Spi;

// int mode;

u8 WriteBuffer[PAGE_SIZE + READ_WRITE_EXTRA_BYTES];
/*
 * Buffer used during Read transactions.
 */
u8 ReadBuffer[PAGE_SIZE + READ_WRITE_EXTRA_BYTES];

u8 FlashID[3];


#ifdef __cplusplus
extern "C" {
#endif

extern void outbyte(char c);

#ifdef __cplusplus
}
#endif

// u32 flbuf;

void init_uart();

extern u8 __sdata_start;
extern u8 __bss_end;


#define LOADER_LOG 1

void platform_init(){

	init_uart();

	print ("\r\nInitialize all BSS sections.\r\n");
	long* sdata_start = &__sdata_start;
	long* bss_end = &__bss_end;
	while(sdata_start <= bss_end) {
		*sdata_start++ = 0;
	}
	print ("Initialize Successfully!\r\n");
}

int main()
{
	int Status;
	uint8_t ret;

	XSpi Spi;
	int mode;

	u32 flbuf;

	memset(&Spi, 0, sizeof(Spi));

	platform_init();

	mode = READ_WRITE_EXTRA_BYTES;



	print ("\r\nSPI Bootloader!\r\n");
	/*
	 * Initialize the SPI driver so that it's ready to use,
	 * specify the device ID that is generated in xparameters.h.
	 */

	if (LOADER_LOG) {
		print ("SPI Initialize!\r\n");
	}

	Status = XSpi_Initialize(&Spi, SPI_DEVICE_ID);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Set the SPI device as a master and in manual slave select mode such
	 * that the slave select signal does not toggle for every byte of a
	 * transfer, this must be done before the slave select is set.
	 */
	Status = XSpi_SetOptions(&Spi, XSP_MASTER_OPTION |
			     XSP_MANUAL_SSELECT_OPTION);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Select the flash device on the SPI bus, so that it can be
	 * read and written using the SPI bus.
	 */
	Status = XSpi_SetSlaveSelect(&Spi, SPI_SELECT);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the SPI driver so that interrupts and the device are enabled.
	 */
	
	if (LOADER_LOG) {
		print ("SPI Start!\r\n");
	}

	XSpi_Start(&Spi);

	XSpi_IntrGlobalDisable(&Spi);

	Status = FlashReadID(&Spi);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	if (LOADER_LOG) {
		print ("Loading exe Image from Flash... \r\n");
	}

	flbuf = (u32)FLASH_IMAGE_BASEADDR;
	ret = load_exec(&Spi, &mode, &flbuf);

	/* If we reach here, we are in error */

	return ret;
}

/*****************************************************************************/
/**
*
* This function enables writes to the Serial Flash memory.
*
* @param	Spi is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int FlashWriteEnable(XSpi *Spi)
{
	int Status;
	u8 *NULLPtr = NULL;

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = WRITE_ENABLE;

	Status = XSpi_Transfer(Spi, WriteBuffer, NULLPtr, 1);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
 * @brief
 * This API enters the flash device into 4 bytes addressing mode.
 *
 * @param	Spi is a pointer to the instance of the Spi device.
 * @param	Enable is a either 1 or 0 if 1 then enters 4 byte if 0 exits.
 *
 * @return
 *		- XST_SUCCESS if successful.
 *		- XST_FAILURE if it fails.
 *
 *
 ******************************************************************************/
int FlashEnterExit4BAddMode(XSpi *Spi, unsigned int Enable)
{
	int Status;
	u8 *NULLPtr = NULL;

	if((FlashID[FLASH_MAKE] == MICRON_ID_BYTE0) ||
		(FlashID[FLASH_MAKE] == ISSI_ID_BYTE0)) {

		Status = FlashWriteEnable(Spi);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
	}

	if (Enable) {
		WriteBuffer[BYTE1] = ENTER_4B_ADDR_MODE;
	} else {
		if (FlashID[FLASH_MAKE] == ISSI_ID_BYTE0)
			WriteBuffer[BYTE1] = EXIT_4B_ADDR_MODE_ISSI;
		else
			WriteBuffer[BYTE1] = EXIT_4B_ADDR_MODE;
	}

	Status = XSpi_Transfer(Spi, WriteBuffer, NULLPtr, 1);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}
/*****************************************************************************/
/**
*
* This function reads serial FLASH ID connected to the SPI interface.
*
* @param	None.
*
* @return	XST_SUCCESS if read id, otherwise XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
int FlashReadID(XSpi *Spi)
{
	int Status;
	int i;

	/* Read ID in Auto mode.*/
	WriteBuffer[BYTE1] = 0x9f;
	WriteBuffer[BYTE2] = 0xff;		/* 4 dummy bytes */
	WriteBuffer[BYTE3] = 0xff;
	WriteBuffer[BYTE4] = 0xff;
	WriteBuffer[BYTE5] = 0xff;

	Status = XSpi_Transfer(Spi, WriteBuffer, ReadBuffer, 5);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	for(i = 0; i < 3; i++)
		FlashID[i] = ReadBuffer[i + 1];
#ifdef VERBOSE
	xil_printf("FlashID=0x%x 0x%x 0x%x\n\r", ReadBuffer[1], ReadBuffer[2],
			ReadBuffer[3]);
#endif
	return XST_SUCCESS;
}


static uint8_t load_exec(XSpi *Spi, int *mode, u32 *flbuf)
{
	uint8_t ret;
	void (*laddr)();
	int8_t done = 0;
	int Status;

	int percent = 0;
	int i = 0;
	
	uint8_t * loader_kernel = (uint8_t *) DDR4_KERNEL_BASE; 
	uint32_t kernel_size = DDR4_KERNEL_SIZE;

	laddr = (void (*)())loader_kernel;

	int per_percent = (DDR4_KERNEL_SIZE / TRANSFER_BYTE_COUNT)/ 100;

	if(FlashID[FLASH_SIZE] > FLASH_16_MB) {
		Status = FlashEnterExit4BAddMode(Spi, ENTER_4B);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
		*mode = READ_WRITE_EXTRA_BYTES_4BYTE_MODE;
	}

	// Transfer data from Flash
	while (!done) {
		if ((ret = flash_get_sector_data(Spi, mode, flbuf, loader_kernel)) != TRANSFER_BYTE_COUNT) {
			print("flash transfer error! \r\n");
			return ret;
		}

		percent++;

		if (percent >= per_percent ) {
			i++;
			percent = 0;
			if (LOADER_LOG) {
				outbyte (CR);
				print("Bootloader: Processed [0x64->100%] : (0x) ");
				putnum (i);
			}
		}

		loader_kernel += TRANSFER_BYTE_COUNT;
		kernel_size -= TRANSFER_BYTE_COUNT;

		if (kernel_size <= 0) {
			done = 1;
		}
	}

	if(FlashID[FLASH_SIZE] > FLASH_16_MB) {
		Status = FlashEnterExit4BAddMode(Spi, EXIT_4B);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
		*mode = READ_WRITE_EXTRA_BYTES;
	}
	if (LOADER_LOG) {
		print ("\r\nExecuting program starting on DDR4 ...\r\n");
	}
	

	//////////////////////////////////////////////////////////////
	if (LOADER_LOG) {
		print ("Vaule in DDR4:\r\n");
	}
	uint32_t* paddr = (uint32_t*)DDR4_KERNEL_BASE;
	for (int ii = 0; ii < 32; ++ii){
		putnum(*paddr);
		print ("\r\n");
		paddr++;
	}

	if (LOADER_LOG) {
		print ("Vaule in DDR4 Main:\r\n");
	}
	
	paddr = (uint32_t*)(DDR4_KERNEL_BASE+(60*4));
	for (int ii = 0; ii < 32; ++ii){
		putnum(*paddr);
		print ("\r\n");
		paddr++;
	}
	//////////////////////////////////////////////////////////////
	laddr = (void (*)())DDR4_KERNEL_BASE;	
	laddr();

	/* We will be dead at this point */
	return 0;
}



// 128 bytes
static uint32_t flash_get_sector_data(XSpi *Spi, int *mode, u32 *flbuf, uint8_t *buf) 
{
	int Status;
	int i;
	int len;
	u8 ReadCmd = READ_CMD;

	/*
	 * Read 1st 4bytes of a record. Its contains the information about
	 * the type of the record and number of bytes that follow in the
	 * rest of the record (address + data + checksum).
	 */
	if(*mode == READ_WRITE_EXTRA_BYTES) {
		WriteBuffer[BYTE1] = ReadCmd;
		WriteBuffer[BYTE2] = (u8) (*flbuf >> 16);
		WriteBuffer[BYTE3] = (u8) (*flbuf >> 8);
		WriteBuffer[BYTE4] = (u8) *flbuf;
	} else {
		WriteBuffer[BYTE1] = ReadCmd;
		WriteBuffer[BYTE2] = (u8) (*flbuf >> 24);
		WriteBuffer[BYTE3] = (u8) (*flbuf >> 16);
		WriteBuffer[BYTE4] = (u8) (*flbuf >> 8);
		WriteBuffer[BYTE5] = (u8) *flbuf;
	}

	Status = XSpi_Transfer(Spi, WriteBuffer, ReadBuffer,
				(TRANSFER_BYTE_COUNT + *mode));
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	*flbuf += TRANSFER_BYTE_COUNT;

	for(i = 0; i < (TRANSFER_BYTE_COUNT); i++)
		*buf++ = ReadBuffer[*mode + i];

	return TRANSFER_BYTE_COUNT;
}


