00000000004004b4 <BFS_kernel>:

void BFS_kernel(int depth)

    adrp	x8, 491000
    adrp	x10, 490000
    ldrsw	x9, [x8, #2828]   // queue_start_ptr -> x9
    ldr	w12, [x10, #40]       // queue_end_ptr -> w12
    cmp	w9, w12               // compare queue_start_ptr with queue_end_ptr
    b.ge	label-0           // if queue_start_ptr >= queue_end_ptr, jump to end

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

  label-3: 	add	x9, x9, #0x1  // queue_start_ptr = queue_start_ptr+1
   	cmp	x9, w12, sxtw // compre queue_start_ptr with queue_end_str
   	b.ge	label-2   // if queue_start_str >=queue_end_str, jump to end 

  label-1: 	
    add	x1, x13, x9, lsl #2  // addr of bfs_queue[queue_start_ptr] -> x1
   	ldrsw	x0, [x1]         // bfs_queue[queue_start_ptr] -> x0
   	cmp	x9, x11              // compare queue_start_ptr with 38495, 38495 is a parameter   
   	csel	x18, x9, x11, lt  // if queue_start_ptr < 38495, pref_start_ptr = queue_start_ptr, pref_start_ptr -> x18
   	add	x18, x13, x18, lsl #2 // addr of bfs_queue[pref_start_ptr] -> x18
   	add	w3, w0, #0x1          // bfs_queue[queue_start_ptr] + 1 -> w3
   	ldrsw	x2, [x18, #128]   // bfs_queue[pref_start_ptr + 32] -> x2, 128 is a parameter
   	ldrsw	x18, [x14, x0, lsl #2] // i-> x18, first time, i = row_ptr[start], start = bfs_queue[queue_start_ptr]
   	ldr	w3, [x14, w3, sxtw #2]     // row_ptr[end_point] -> w3, end_point = bfs_queue[queue_start_ptr]+1
   	prfm	pldl1keep, [x1, #256]  // prefetch bfs_queue[queue_start_ptr+32], 256 is a parameter
   	add	x2, x14, x2, lsl #2   // addr of row_ptr[bfs_queue[pref_start_ptr+32]] -> x2
   	prfm	pldl1keep, [x2]   // prefetch row_ptr[bfs_queue[pref_start_ptr+32]], 32 is lookahead distance for row_ptr
   	cmp	w18, w3               // compare i with row_ptr[end_point]
   	prfum	pldl1keep, [x2, #4] // prefetch row_ptr[bfs_queue[pref_start_ptr+32]+1]
   	b.ge	label-3           // if i >= row_ptr[end_point], go to next vertex

   	add	x1, x15, x18, lsl #2  // addr of col_idx[i] -> x1
   	add	x1, x1, #0x100        // addr of col_idx[i+64] -> x1, 256 is a parameter
   	mov	w2, w12               // queue_end_ptr -> w2  
   	b	label-4

  label-5: 	
    add	x3, x14, w0, sxtw #2  // addr of row_ptr[bfs_queue[queue_start_ptr]] -> x3
   	ldrsw	x3, [x3, #4]      // row_ptr[bfs_queue[queue_start_ptr]+1] -> x3
   	add	x18, x18, #0x1        // i = i + 1
   	add	x1, x1, #0x4          // col_idx[i+64+1]
   	cmp	x18, x3               // compare i with row_ptr[bfs_queue[queue_start_ptr]+1]
   	b.ge	label-3           // if i >= row_ptr[bfs_queue[queue_start_ptr]+1], go to next vertex

  label-4: 	
    ldur	w3, [x1, #-256]   // col_idx[i] -> w3
   	cmp	x18, x11              // compare i with 38495
   	csel	x4, x18, x11, lt  // if i < 38495, pref_i = i, pref_i -> x4
   	add	x4, x15, x4, lsl #2   // addr of col_idx[pref_i] -> x4
   	ldrsw	x5, [x4, #128]    // col_idx[pref_i+128] -> x5
   	sxtw	x4, w3            // col_idx[i] -> x4
   	ldrb	w6, [x16, x4]     // vis[col_idx[i]] -> w6
   	prfm	pldl1keep, [x1]   // prefetch col_idx[i+64]
   	add	x5, x16, x5           // addr of vis[col_idx[pref_i+128]] -> x5
   	prfm	pldl1keep, [x5]   // prefetfh vis[cod_idx[pref_i+128]]
   	cbnz	w6, label-5       // if vis[col_idx[i]] == 1, go to next neigbor of this vertex

   	str	w3, [x13, w2, sxtw #2] // store col_idx[i] -> bfs_queue[queue_end_ptr]
   	ldr	w0, [x13, x9, lsl #2]  // bfs_queue[queue_start_ptr] -> w0
   	add	w12, w2, #0x1          // queue_end_ptr++
   	mov	w2, w12                // queue_end_ptr -> w2
   	str	w12, [x10, #40]        // store queue_end_ptr
   	strb	w17, [x16, x4]     // vis[col_idx[i]] = true
   	b	label-5                // go to next neighbor

label-2:	
    str	w9, [x8, #2828]        // store queue_start_ptr

label-0: 	ret