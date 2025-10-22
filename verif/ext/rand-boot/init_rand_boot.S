.global main
.global _start

main:
_start:
random_test_start:
	invtlb	0x0,$r0,$r0
	csrwr	$r0,0x1
	csrwr	$r0,0x6
	csrwr	$r0,0x4
	csrwr	$r0,0x18
	
	# EENTRY
	lu12i.w	$r1,32770
	csrwr	$r1,0xc
	
	# TLBRENTRY
	lu12i.w	$r1,32769
	csrwr	$r1,0x88

    # We keep pgdh and pgdl in C910
	# PGDL
	lu12i.w	$r1,131074
	csrwr	$r1,0x19
	# PGDH
	lu12i.w	$r1,131074
	csrwr	$r1,0x1a

	# PWCL = 0x13E4D52C
	# lu12i.w	$r1,94
	# ori	$r1,$r1,0x56e
	lu12i.w	$r1,81485
	ori	$r1,$r1,0x52c
	csrwr	$r1,0x1c
	
	# PWCH = 0x1000000
	# ori	$r1,$r0,0x2e4
	lu12i.w	$r1,4096
	csrwr	$r1,0x1d
	
	# EUEN
	ori	$r1,$r0,0xf
	csrwr	$r1,0x2
	
	# Jump 8000000
	lu12i.w	$r1,32768
	ori	$r1,$r1,0x64
	lu32i.d	$r1,0
	lu52i.d	$r1,$r1,0
	jirl	$r0,$r1,0
	
	lu12i.w	$r31,32773
	ld.d	$r1,$r31,512
	
	beqz	$r1, init_fpr_end
	ld.d	$r1,$r31,640
	movgr2fcsr	$r0,$r1
	ld.d	$r1,$r31,648
	movgr2cf	$fcc0,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc1,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc2,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc3,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc4,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc5,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc6,$r1
	srli.w	$r1,$r1,0x1
	movgr2cf	$fcc7,$r1
	fld.d	$f0,$r31,256
	fld.d	$f1,$r31,264
	fld.d	$f2,$r31,272
	fld.d	$f3,$r31,280
	fld.d	$f4,$r31,288
	fld.d	$f5,$r31,296
	fld.d	$f6,$r31,304
	fld.d	$f7,$r31,312
	fld.d	$f8,$r31,320
	fld.d	$f9,$r31,328
	fld.d	$f10,$r31,336
	fld.d	$f11,$r31,344
	fld.d	$f12,$r31,352
	fld.d	$f13,$r31,360
	fld.d	$f14,$r31,368
	fld.d	$f15,$r31,376
	fld.d	$f16,$r31,384
	fld.d	$f17,$r31,392
	fld.d	$f18,$r31,400
	fld.d	$f19,$r31,408
	fld.d	$f20,$r31,416
	fld.d	$f21,$r31,424
	fld.d	$f22,$r31,432
	fld.d	$f23,$r31,440
	fld.d	$f24,$r31,448
	fld.d	$f25,$r31,456
	fld.d	$f26,$r31,464
	fld.d	$f27,$r31,472
	fld.d	$f28,$r31,480
	fld.d	$f29,$r31,488
	fld.d	$f30,$r31,496
	fld.d	$f31,$r31,504

init_fpr_end:
	ld.d	$r1,$r31,8
	ld.d	$r2,$r31,16
	ld.d	$r3,$r31,24
	ld.d	$r4,$r31,32
	ld.d	$r5,$r31,40
	ld.d	$r6,$r31,48
	ld.d	$r7,$r31,56
	ld.d	$r8,$r31,64
	ld.d	$r9,$r31,72
	ld.d	$r10,$r31,80
	ld.d	$r11,$r31,88
	ld.d	$r12,$r31,96
	ld.d	$r13,$r31,104
	ld.d	$r14,$r31,112
	ld.d	$r15,$r31,120
	ld.d	$r16,$r31,128
	ld.d	$r17,$r31,136
	ld.d	$r18,$r31,144
	ld.d	$r19,$r31,152
	ld.d	$r20,$r31,160
	ld.d	$r20,$r31,160
	ld.d	$r21,$r31,168
	ld.d	$r22,$r31,176
	ld.d	$r23,$r31,184
	ld.d	$r24,$r31,192
	ld.d	$r25,$r31,200
	ld.d	$r26,$r31,208
	ld.d	$r27,$r31,216
	ld.d	$r28,$r31,224
	ld.d	$r29,$r31,232
	ld.d	$r30,$r31,240
	ld.d	$r31,$r31,248

	csrwr	$r1,0x30
    ori	$r1,$r0,0xb0
    csrwr	$r1,0x0
    csrrd	$r1,0x30
    cacop   0, $r0, 0
    ertn



