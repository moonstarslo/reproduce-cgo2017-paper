void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 

       	adrp	x8, 50f000
       	ldr	w8, [x8, #2640]                          // row -> w8
       	cmp	w8, #0x1                                 // compare row with 1
       	b.lt	label-0                              // if row <1, go to ret

            last_row = row_ptr[i]; 
        for (int i = 0; i < row; i++)
       	ldr	w16, [x3]                                // row_ptr[i] -> w16, first row so row_ptr[0] -> w16
       	mov	x10, xzr                                 // i->x10, i = 0
       	add	x9, x4, #0x100                           
       	b	label-1

            last_row = row_ptr[i]; 
	        for (int i = 0; i < row; i++)
label-2: cmp x11, x8                                 // compare i+1 and row
       	mov	w16, w12                                 // row_ptr[i] = row_ptr[i+1]
       	mov	x10, x11                                 // i = i+1
       	b.eq	label-0  // b.none                   // if i+1 == row, go to end

            this_row = row_ptr[i+1];
            for (int j = last_row; j < this_row; j++)
label-1: add x11, x10, #0x1                          // i=i+1, i+1->x11
       	ldr	w12, [x3, x11, lsl #2]                   // row_ptr[i+1] -> w12, base addr of row_ptr = x3
       	cmp	w16, w12                                 // compare row_ptr[i] with row_ptr[i+1], first time is compare row_ptr[0] with row_ptr[1]
       	b.ge	label-2  // b.tcont                  // if row_ptr[i]>=row_ptr[i+1], go to next row

                ret[i] += val[j] * vec[col_idx[j]];
	            for (int j = last_row; j < this_row; j++)
       	ldr	d0, [x0, x10, lsl #3]                    // ret[i] -> d0, base address of ret[] = x0
       	sxtw	x13, w12                             // row_ptr[i+1] -> x13
       	sxtw	x14, w16                             // row_ptr[i] -> x14, j-> x14
       	sub	x15, x13, #0x1                           // row_ptr[i+1]-1 -> x15, the end of this inner loop
       	add	x16, x9, w16, sxtw #2                    // addr of col_idx[j] + 256 -> x16, base addr of col_idx[] + 256 = x9
                ret[i] += val[j] * vec[col_idx[j]];

label-3: ldursw	x17, [x16, #-256]                    // col_idx[j] -> x17
       	add	x18, x14, #0x20                          // j+32 -> x18
       	ldr	d1, [x2, x14, lsl #3]                    // val[j] -> d1, base addr of val[]=x2
       	cmp	x18, x13                                 // compare j+32 and row_ptr[i+1]
       	ldr	d2, [x1, x17, lsl #3]                    // vec[col_idx[j]] -> d2, base addr of vec[]=x1
       	csel	x18, x18, x15, lt                    // if j+32 < row_ptr[i+1]-1 then j+32 -> x18, otherwise row_ptr[i+1]-1 -> x18
       	ldrsw	x18, [x4, x18, lsl #2]               // col_idx[pref_j] -> x18, base addr of col_idx[] = x4, demand load of col_idx to generate prefetch for vec[]
            for (int j = last_row; j < this_row; j++)
                ret[i] += val[j] * vec[col_idx[j]];
            for (int j = last_row; j < this_row; j++)
                ret[i] += val[j] * vec[col_idx[j]];
            for (int j = last_row; j < this_row; j++)
      	add	x14, x14, #0x1             // j = j + 1  
       	fmul	d1, d1, d2
       	fadd	d0, d0, d1
       	cmp	x13, x14                                 
       	add	x17, x1, x18, lsl #3       // addr of vec[pref_j]-> x17
       	str	d0, [x0, x10, lsl #3]      // store ret[i]
       	prfm	pldl1keep, [x16]       // prefetch col_idx[j] +256
       	add	x16, x16, #0x4             // to keep up with j increases
       	prfm	pldl1keep, [x17]       // prefetch vec[j+32]
       	b.ne	label-3                // if j != row_ptr[i+1], continue to compute this row
       	b	label-2                    // if j == row_ptr[i+1], jump to next row

label-0: ret