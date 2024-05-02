    1054:	52a04008 	mov	w8, #0x2000000             	// #33554432
    for( i=0; i<NUM_KEYS; i++ ) 
        key_buff1[key_buff2[i]]++;
    1058:	ldrsw	x9, [x21], #4    // load key_buff2[i]
    for( i=0; i<NUM_KEYS; i++ ) 
    105c:	subs	x8, x8, #0x1
        key_buff1[key_buff2[i]]++;
    1060: 	lsl	x9, x9, #2
    1064: 	ldr	w10, [x20, x9]      // load key_buff1[key_buff2[i]]
    1068: 	add	w10, w10, #0x1      // key_buff1[]++
    106c: 	str	w10, [x20, x9]      // store key_buff1[]
    for( i=0; i<NUM_KEYS; i++ )
    1070:	b.ne	1058 <rank+0x9c>  // b.any