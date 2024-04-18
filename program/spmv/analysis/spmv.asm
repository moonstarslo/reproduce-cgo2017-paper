void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 

        int last_row, this_row;
        //按行分别计算结果向量中的不同分量
        for (int i = 0; i < row; i++)
  4003fc: 	adrp	x8, 50f000
  400400: 	ldr	w8, [x8, #2640]      // row -> w8
  400404: 	cmp	w8, #0x1             // if row < 1 go to return 
  400408: 	b.lt	label-0               

            last_row = row_ptr[i];     
  40040c: 	ldr	w14, [x3]            // row_ptr[0] -> w14, this is the first row
  400410: 	mov	x9, xzr              // x9->0, i = 0
  400414: 	b	label-1

        for (int i = 0; i < row; i++)
  label-2: 	cmp	x10, x8              // compare i+1 with row
            last_row = row_ptr[i]; 
  40041c: 	mov	w14, w11             // row_ptr[i+1] -> w14
  400420: 	mov	x9, x10              // i = i+1
        for (int i = 0; i < row; i++)
  400424: 	b.eq	label-0               // if i+1 = row, go to return

            this_row = row_ptr[i+1];
  label-1: 	add	x10, x9, #0x1          // i+1 -> x10  
  40042c: 	ldr	w11, [x3, x10, lsl #2] // row_ptr[i+1] -> w11 
            for (int j = last_row; j < this_row; j++)
  400430: 	cmp	w14, w11               // if row_ptr[i] >= row_ptr[i+1], go to next row
  400434: 	b.ge	label-2 

                ret[i] += val[j] * vec[col_idx[j]];
  400438: 	ldr	d0, [x0, x9, lsl #3]   // ret[i] -> d0
  40043c: 	sxtw	x12, w11
            for (int j = last_row; j < this_row; j++)
  400440: 	sub	x12, x12, w14, sxtw   // this row - last row = x12
  400444: 	add	x13, x4, w14, sxtw #2 // j->x13
  400448: 	add	x14, x2, w14, sxtw #3
                ret[i] += val[j] * vec[col_idx[j]];
  label-3: 	ldr	d1, [x14], #8          // val[j] -> d1
  400450: 	ldrsw	x15, [x13], #4         // col_idx[j] -> x15
            for (int j = last_row; j < this_row; j++)
  400454: 	subs	x12, x12, #0x1         // (this_row - last_row)-1
                ret[i] += val[j] * vec[col_idx[j]];
  400458: 	ldr	d2, [x1, x15, lsl #3] // vec[col_idx[j]] -> d2
  40045c: 	fmul	d1, d1, d2            
  400460: 	fadd	d0, d0, d1
  400464: 	str	d0, [x0, x9, lsl #3]  // store val*vec to ret[i]  
            for (int j = last_row; j < this_row; j++)
  400468: 	b.ne	label-3                // if(this_row-last_row)-1 >0, continue to compute this row
  40046c: 	b	label-2                // if(this_row-last_row)-1 = 0, go to compute next row

  label-0:  ret