void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 

        int last_row, this_row;
        //按行分别计算结果向量中的不同分量
        for (int i = 0; i < row; i++)
       	adrp	x8, 50f000
       	ldr	w8, [x8, #2640]
       	cmp	w8, #0x1
       	b.lt	label-0  // b.tstop
            last_row = row_ptr[i]; 
       	ldr	w16, [x3]
       	mov	x10, xzr
        for (int i = 0; i < row; i++)
       	add	x9, x4, #0x100
       	b	label-1
  label-2: 	cmp	x11, x8
            last_row = row_ptr[i]; 
       	mov	w16, w12
       	mov	x10, x11
        for (int i = 0; i < row; i++)
       	b.eq	label-0  // b.none
            this_row = row_ptr[i+1];
  label-1: 	add	x11, x10, #0x1
       	ldr	w12, [x3, x11, lsl #2]
            for (int j = last_row; j < this_row; j++)
       	cmp	w16, w12
       	b.ge	label-2  // b.tcont
                ret[i] += val[j] * vec[col_idx[j]];
       	ldr	d0, [x0, x10, lsl #3]
       	sxtw	x13, w12
            for (int j = last_row; j < this_row; j++)
       	sxtw	x14, w16
       	sub	x15, x13, #0x1
       	add	x16, x9, w16, sxtw #2
                ret[i] += val[j] * vec[col_idx[j]];
  label-3: 	ldursw	x17, [x16, #-256]
       	add	x18, x14, #0x20
       	ldr	d1, [x2, x14, lsl #3]
       	cmp	x18, x13
       	ldr	d2, [x1, x17, lsl #3]
       	csel	x18, x18, x15, lt  // lt = tstop
       	ldrsw	x18, [x4, x18, lsl #2]
            for (int j = last_row; j < this_row; j++)
      	add	x14, x14, #0x1
                ret[i] += val[j] * vec[col_idx[j]];
       	fmul	d1, d1, d2
       	fadd	d0, d0, d1
            for (int j = last_row; j < this_row; j++)
       	cmp	x13, x14
                ret[i] += val[j] * vec[col_idx[j]];
       	add	x17, x1, x18, lsl #3
       	str	d0, [x0, x10, lsl #3]
       	prfm	pldl1keep, [x16]
            for (int j = last_row; j < this_row; j++)
       	add	x16, x16, #0x4
       	prfm	pldl1keep, [x17]
       	b.ne	label-3   // b.any
       	b	label-2 

  label-0: 	ret