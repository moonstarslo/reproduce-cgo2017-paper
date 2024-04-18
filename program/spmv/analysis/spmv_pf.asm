00000000004003fc <_Z3mulPdS_S_PiS0_>:

void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 
{
        int last_row, this_row;
        //按行分别计算结果向量中的不同分量
        for (int i = 0; i < row; i++) {
  4003fc:	f0000868 	adrp	x8, 50f000 <cache_flush+0x7f5b0>
  400400:	b94a5108 	ldr	w8, [x8, #2640]
  400404:	7100051f 	cmp	w8, #0x1
  400408:	5400048b 	b.lt	400498 <_Z3mulPdS_S_PiS0_+0x9c>  // b.tstop
            last_row = row_ptr[i]; 
  40040c:	b9400070 	ldr	w16, [x3]
  400410:	aa1f03ea 	mov	x10, xzr
        for (int i = 0; i < row; i++) {
  400414:	91040089 	add	x9, x4, #0x100
  400418:	14000005 	b	40042c <_Z3mulPdS_S_PiS0_+0x30>
  40041c:	eb08017f 	cmp	x11, x8
            last_row = row_ptr[i]; 
  400420:	2a0c03f0 	mov	w16, w12
  400424:	aa0b03ea 	mov	x10, x11
        for (int i = 0; i < row; i++) {
  400428:	54000380 	b.eq	400498 <_Z3mulPdS_S_PiS0_+0x9c>  // b.none
            this_row = row_ptr[i+1];
  40042c:	9100054b 	add	x11, x10, #0x1
  400430:	b86b786c 	ldr	w12, [x3, x11, lsl #2]
            for (int j = last_row; j < this_row; j++) {
  400434:	6b0c021f 	cmp	w16, w12
  400438:	54ffff2a 	b.ge	40041c <_Z3mulPdS_S_PiS0_+0x20>  // b.tcont
                ret[i] += val[j] * vec[col_idx[j]];
  40043c:	fc6a7800 	ldr	d0, [x0, x10, lsl #3]
  400440:	93407d8d 	sxtw	x13, w12
            for (int j = last_row; j < this_row; j++) {
  400444:	93407e0e 	sxtw	x14, w16
  400448:	d10005af 	sub	x15, x13, #0x1
  40044c:	8b30c930 	add	x16, x9, w16, sxtw #2
                ret[i] += val[j] * vec[col_idx[j]];
  400450:	b8900211 	ldursw	x17, [x16, #-256]
  400454:	910081d2 	add	x18, x14, #0x20
  400458:	fc6e7841 	ldr	d1, [x2, x14, lsl #3]
  40045c:	eb0d025f 	cmp	x18, x13
  400460:	fc717822 	ldr	d2, [x1, x17, lsl #3]
  400464:	9a8fb252 	csel	x18, x18, x15, lt  // lt = tstop
  400468:	b8b27892 	ldrsw	x18, [x4, x18, lsl #2]
            for (int j = last_row; j < this_row; j++) {
  40046c:	910005ce 	add	x14, x14, #0x1
                ret[i] += val[j] * vec[col_idx[j]];
  400470:	1e620821 	fmul	d1, d1, d2
  400474:	1e612800 	fadd	d0, d0, d1
            for (int j = last_row; j < this_row; j++) {
  400478:	eb0e01bf 	cmp	x13, x14
                ret[i] += val[j] * vec[col_idx[j]];
  40047c:	8b120c31 	add	x17, x1, x18, lsl #3
  400480:	fc2a7800 	str	d0, [x0, x10, lsl #3]
  400484:	f9800200 	prfm	pldl1keep, [x16]
            for (int j = last_row; j < this_row; j++) {
  400488:	91001210 	add	x16, x16, #0x4
  40048c:	f9800220 	prfm	pldl1keep, [x17]
  400490:	54fffe01 	b.ne	400450 <_Z3mulPdS_S_PiS0_+0x54>  // b.any
  400494:	17ffffe2 	b	40041c <_Z3mulPdS_S_PiS0_+0x20>
                // printf("ret[i](%f\n)=ret[i]+(%f)*(%f)\n",ret[i],val[j],vec[col_idx[j]]);
            }
        }
}
  400498:	d65f03c0 	ret