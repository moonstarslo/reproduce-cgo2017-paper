    1058:	52a0400a 	mov	w10, #0x2000000             	// #33554432    
    for( i=0; i<NUM_KEYS; i++ ) {
        key_buff1[key_buff2[i]]++;
    105c:	b890012b 	ldursw	x11, [x9, #-256]
    1060:	eb18011f 	cmp	x8, x24
    1064:	9a98310c 	csel	x12, x8, x24, cc  // cc = lo, ul, last
    1068:	8b0c0aac 	add	x12, x21, x12, lsl #2
    106c:	d37ef56b 	lsl	x11, x11, #2
    1070:	b86b6a8d 	ldr	w13, [x20, x11]
    1074:	b980818c 	ldrsw	x12, [x12, #128]
    for( i=0; i<NUM_KEYS; i++ ) {
    1078:	91000508 	add	x8, x8, #0x1
    107c:	eb0a011f 	cmp	x8, x10
        key_buff1[key_buff2[i]]++;
    1080:	110005ad 	add	w13, w13, #0x1
    1084:	8b0c0a8c 	add	x12, x20, x12, lsl #2
    1088:	b82b6a8d 	str	w13, [x20, x11]
    108c:	f9800120 	prfm	pldl1keep, [x9]
    for( i=0; i<NUM_KEYS; i++ ) {
    1090:	91001129 	add	x9, x9, #0x4
    1094:	f9800180 	prfm	pldl1keep, [x12]
    1098:	54fffe21 	b.ne	105c <rank+0xb0>  // b.any