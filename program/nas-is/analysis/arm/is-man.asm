    1064:	52a0400b 	mov	w11, #0x2000000             	// #33554432
    1068:	14000005 	b	107c <rank+0xc0>
    for( i=0; i<NUM_KEYS; i++ ) {
    106c:	91000508 	add	x8, x8, #0x1
    1070:	eb0b011f 	cmp	x8, x11
    1074:	91001129 	add	x9, x9, #0x4
    1078:	540001a0 	b.eq	10ac <rank+0xf0>  // b.none
        key_buff1[key_buff2[i]]++;
    107c:	b898012c 	ldursw	x12, [x9, #-128]
    #ifdef STRIDE    
         __builtin_prefetch(&key_buff2[(i+FETCHDIST)]);
    #endif     
         if(i+(FETCHDIST>>1)<NUM_KEYS)__builtin_prefetch(&key_buff1[key_buff2[(i+(FETCHDIST>>1))]]);
    1080:	eb0a011f 	cmp	x8, x10
        key_buff1[key_buff2[i]]++;
    1084:	d37ef58c 	lsl	x12, x12, #2
    1088:	b86c6a8d 	ldr	w13, [x20, x12]
    108c:	110005ad 	add	w13, w13, #0x1
    1090:	b82c6a8d 	str	w13, [x20, x12]
         __builtin_prefetch(&key_buff2[(i+FETCHDIST)]);
    1094:	f9804120 	prfm	pldl1keep, [x9, #128]
         if(i+(FETCHDIST>>1)<NUM_KEYS)__builtin_prefetch(&key_buff1[key_buff2[(i+(FETCHDIST>>1))]]);
    1098:	54fffea8 	b.hi	106c <rank+0xb0>  // b.pmore
    109c:	b980012c 	ldrsw	x12, [x9]
    10a0:	8b0c0a8c 	add	x12, x20, x12, lsl #2
    10a4:	f9800180 	prfm	pldl1keep, [x12]
    10a8:	17fffff1 	b	106c <rank+0xb0>