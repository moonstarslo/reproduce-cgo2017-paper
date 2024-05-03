  400728: 	ldr	w8, [x24, #2640]
  40072c: 	cmp	w8, #0x1
  400730: 	b.lt	label-0                  // b.tstop

  400734: 	mov	w9, #0x90000000            	// #-1879048192
  400738: 	ldr	w16, [x9]
  40073c: 	mov	x10, xzr
  400740: 	mov	w9, #0xb0000000            	// #-1342177280
  400744: 	b	label-1

        for (int i = 0; i < row; i++) {
  label-2: 	cmp	x11, x8
            last_row = row_ptr[i]; 
  40074c: 	mov	w16, w12
  400750: 	mov	x10, x11
        for (int i = 0; i < row; i++) {
  400754: 	b.eq	label-0               // b.none

  label-1: 	
            add	x11, x10, #0x1
  40075c: 	ldr	w12, [x22, x11, lsl #2]
  400760: 	cmp	w16, w12
  400764: 	b.ge	label-2               // b.tcont

  400768: 	ldr	d0, [x9, x10, lsl #3]
  40076c: 	sxtw	x13, w12
  400770: 	sxtw	x14, w16
  400774: 	add	x16, x23, w16, sxtw #2
  400778: 	sub	x15, x13, #0x1
  40077c: 	add	x16, x16, #0x100

  label-3: 	
            ldursw	x17, [x16, #-256]
  400784: 	add	x18, x14, #0x20
  400788: 	ldr	d1, [x20, x14, lsl #3]
  40078c: 	cmp	x18, x13
  400790: 	ldr	d2, [x21, x17, lsl #3]
  400794: 	csel	x18, x18, x15, lt  // lt = tstop
  400798: 	ldrsw	x18, [x23, x18, lsl #2]
  40079c: 	add	x14, x14, #0x1
  4007a0: 	fmul	d1, d1, d2
  4007a4: 	fadd	d0, d0, d1
  4007a8: 	cmp	x13, x14
  4007ac: 	add	x17, x21, x18, lsl #3
  4007b0: 	str	d0, [x9, x10, lsl #3]
  4007b4: 	prfm	pldl1keep, [x16]
  4007b8: 	add	x16, x16, #0x4
  4007bc: 	prfm	pldl1keep, [x17]
  4007c0: 	b.ne	label-3  // b.any
  4007c4: 	b	label-2