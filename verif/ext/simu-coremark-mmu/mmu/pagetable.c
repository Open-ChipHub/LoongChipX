#include "pagetable.h"
#include "printf.h"

pgd_t pgd_table[PTRS_PER_PGD] __page_aligned_bss;
pud_t pud_table[PTRS_PER_PUD] __page_aligned_bss;
pmd_t pmd_table[PTRS_PER_PMD] __page_aligned_bss;
pte_t pte_table[PTRS_PER_PTE] __page_aligned_bss;

void __create_pgd_mapping() {
	
	/// map 2MB

	long vir_base = 0x1800000000;
	long phy_base = 0x1C000000;

	long phy_pfn = (long) phy_base >> _PFN_SHIFT;

	pgd_t* gptr = pgd_table + pgd_index((long)vir_base);

	*(long*)gptr = (long)pmd_table;
	
	pmd_t* pmdptr = pmd_table + pmd_index((long)vir_base);
	*((long*)pmdptr) = (long)pte_table;
	
	for (int i = 0; i < PTRS_PER_PMD; ++i) {
		pte_t* pteptr = pte_table + i;
		// *(pteptr) = pfn_pte((phy_pfn+i), PAGE_KERNEL);
		*(pteptr) = pfn_pte((phy_pfn+i), PAGE_USER);
	}
}

void log_mapping_success() {
  printf("\nMap Page Table Successfully!\n\n");
  printf("###############################################\n");
  printf("#### System is running on MMU ONLINE mode! ####\n");
  printf("###############################################\n\n");
}
