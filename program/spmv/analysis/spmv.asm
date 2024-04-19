void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 

            adrp	x8, 50f000
            ldr	w8, [x8, #2640]        // row -> w8
            cmp	w8, #0x1               // if row < 1 go to return 
            b.lt	label-0               
   
            ldr	w14, [x3]              // row_ptr[0] -> w14, this is the first row
            mov	x9, xzr                // x9->0, i = 0
            b	label-1
        
  label-2:  cmp	x10, x8                // compare i+1 with row
            mov	w14, w11               // row_ptr[i+1] -> w14
            mov	x9, x10                // i = i+1
            b.eq	label-0                // if i+1 = row, go to return

  label-1:  add	x10, x9, #0x1          // i+1 -> x10  
       	  ldr	w11, [x3, x10, lsl #2] // row_ptr[i+1] -> w11 
       	  cmp	w14, w11               // if row_ptr[i] >= row_ptr[i+1], go to next row
       	  b.ge	label-2 

            ldr	d0, [x0, x9, lsl #3]   // ret[i] -> d0
            sxtw	x12, w11
            sub	x12, x12, w14, sxtw    // this row - last row = x12, w14 = row_ptr[i]/start j
            add	x13, x4, w14, sxtw #2  // addr of col_idx[j] -> x13, base address of col_idx[] = x4
            add	x14, x2, w14, sxtw #3  // addr of val[j]     -> x14, base address of val[] = x2
  label-3:  ldr	d1, [x14], #8          // val[j] -> d1 , then x14 = x14 + 8, next time load val[j+1]
       	  ldrsw	x15, [x13], #4         // col_idx[j] -> x15, then x13 = x13 + 4, next time load col_idx[j+1]
       	  subs	x12, x12, #0x1         // (this_row - last_row)-1 -> x12
       	  ldr	d2, [x1, x15, lsl #3]  // vec[col_idx[j]] -> d2
       	  fmul	d1, d1, d2            
       	  fadd	d0, d0, d1
       	  str	d0, [x0, x9, lsl #3]   // store val*vec to ret[i]  
       	  b.ne	label-3                // if(this_row-last_row)-1 > 0, continue to compute this row
       	  b	     label-2                // if(this_row-last_row)-1 = 0, go to compute next row

  label-0:  ret