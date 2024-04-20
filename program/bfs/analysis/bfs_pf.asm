00000000004004b4 <BFS_kernel>:

void BFS_kernel(int depth)

    while(queue_start_ptr<queue_end_ptr){
    adrp	x8, 491000
    adrp	x10, 490000
    ldrsw	x9, [x8, #2828]
    ldr	w12, [x10, #40]
    cmp	w9, w12
    b.ge	label-0  // b.tcont

    mov	w11, #0x965f                	// #38495
    adrp	x13, aeb2000
    adrp	x14, 3441000
    adrp	x15, 5a67000 
    adrp	x16, 492000
    movk	w11, #0x98, lsl #16
    add	x13, x13, #0x970
    add	x14, x14, #0xb60
    add	x15, x15, #0x568
    add	x16, x16, #0xad0
    mov	w17, #0x1                   	// #1
    b	label-1

                bfs_queue[queue_end_ptr++] = col_idx[i];
                // result[col_idx[i]] = depth;
                vis[col_idx[i]] = true;
            
        queue_start_ptr++;
  label-3: 	add	x9, x9, #0x1
    while(queue_start_ptr<queue_end_ptr){
   	cmp	x9, w12, sxtw
   	b.ge	label-2  // b.tcont

        for (int i = row_ptr[bfs_queue[queue_start_ptr]]; i < row_ptr[bfs_queue[queue_start_ptr] + 1]; i++)
  label-1: 	add	x1, x13, x9, lsl #2
   	ldrsw	x0, [x1]
   	cmp	x9, x11
   	csel	x18, x9, x11, lt  // lt = tstop
   	add	x18, x13, x18, lsl #2
   	add	w3, w0, #0x1
   	ldrsw	x2, [x18, #128]
   	ldrsw	x18, [x14, x0, lsl #2]
   	ldr	w3, [x14, w3, sxtw #2]
   	prfm	pldl1keep, [x1, #256]
   	add	x2, x14, x2, lsl #2
   	prfm	pldl1keep, [x2]
   	cmp	w18, w3
   	prfum	pldl1keep, [x2, #4]
   	b.ge	label-3  // b.tcont

   	add	x1, x15, x18, lsl #2
   	add	x1, x1, #0x100
   	mov	w2, w12
   	b	label-4

  label-5: 	add	x3, x14, w0, sxtw #2
   	ldrsw	x3, [x3, #4]
   	add	x18, x18, #0x1
   	add	x1, x1, #0x4
   	cmp	x18, x3
   	b.ge	label-3  // b.tcont

            if (!vis[col_idx[i]])
  label-4: 	ldur	w3, [x1, #-256]
   	cmp	x18, x11
   	csel	x4, x18, x11, lt  // lt = tstop
   	add	x4, x15, x4, lsl #2
   	ldrsw	x5, [x4, #128]
   	sxtw	x4, w3
   	ldrb	w6, [x16, x4]
   	prfm	pldl1keep, [x1]
   	add	x5, x16, x5
   	prfm	pldl1keep, [x5]
   	cbnz	w6, label-5

                bfs_queue[queue_end_ptr++] = col_idx[i];
   	str	w3, [x13, w2, sxtw #2]
        for (int i = row_ptr[bfs_queue[queue_start_ptr]]; i < row_ptr[bfs_queue[queue_start_ptr] + 1]; i++)
   	ldr	w0, [x13, x9, lsl #2]
                bfs_queue[queue_end_ptr++] = col_idx[i];
   	add	w12, w2, #0x1
   	mov	w2, w12
   	str	w12, [x10, #40]
                vis[col_idx[i]] = true;
   	strb	w17, [x16, x4]
   	b	label-5

        queue_start_ptr++;
  label-2:	str	w9, [x8, #2828]

label-0: 	ret