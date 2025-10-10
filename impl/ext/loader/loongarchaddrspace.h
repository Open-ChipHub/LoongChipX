#ifndef LOONGARCH_ADDRESS_SPACE_H	/* prevent circular inclusions */
#define LOONGARCH_ADDRESS_SPACE_H	/* by using protection macros */


#ifdef __ASSEMBLY__
#define _CONST64_(x)	x
#else
#define _CONST64_(x)	x ## L
#endif

#define LOONGARCH_CSR_CRMD      0x0 /* Current mode info */
#define LOONGARCH_CSR_PRMD		0x1	/* Prev-exception mode info */
#define LOONGARCH_CSR_EUEN		0x2	/* Extended unit enable */

#define DMW_PABITS  48

/* Direct map windows registers */
#define LOONGARCH_CSR_DMWIN0        0x180   /* 64 direct map win0: MEM & IF */
#define LOONGARCH_CSR_DMWIN1        0x181   /* 64 direct map win1: MEM & IF */
#define LOONGARCH_CSR_DMWIN2        0x182   /* 64 direct map win2: MEM */
#define LOONGARCH_CSR_DMWIN3        0x183   /* 64 direct map win3: MEM */

#define LOONGARCH_CSR_EUEN          0x2 /* Extended unit enable */

/* Direct map window 0/1 */
#define CSR_DMW0_PLV0       _CONST64_(1 << 0)
#define CSR_DMW0_VSEG       _CONST64_(0x8000)
#define CSR_DMW0_BASE       (CSR_DMW0_VSEG << DMW_PABITS)
#define CSR_DMW0_INIT       (CSR_DMW0_BASE | CSR_DMW0_PLV0)

#define CSR_DMW1_PLV0       _CONST64_(1 << 0)
#define CSR_DMW1_MAT        _CONST64_(1 << 4)
#define CSR_DMW1_VSEG       _CONST64_(0x9000)
#define CSR_DMW1_BASE       (CSR_DMW1_VSEG << DMW_PABITS)
#define CSR_DMW1_INIT       (CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_PLV0)


#ifndef IO_BASE
#define IO_BASE			CSR_DMW0_BASE
#endif

#ifndef UNCAC_BASE
#define UNCAC_BASE		CSR_DMW0_BASE
#endif

#ifndef CAC_BASE
#define CAC_BASE		CSR_DMW1_BASE
#endif

#define TO_PHYS_MASK	((1ULL << DMW_PABITS) - 1)

#define TO_PHYS(x)		(((x) & TO_PHYS_MASK))
#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))



#endif	/* end of protection macro */