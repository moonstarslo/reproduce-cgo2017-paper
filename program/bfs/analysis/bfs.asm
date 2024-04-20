void BFS_kernel(int depth)

  adrp	x8, 492000 
  adrp	x10, 491000
  ldrsw	x9, [x8, #2828]  // queue_start_ptr -> x9
  ldr	w13, [x10, #40]    // queue_end_ptr -> w13
  cmp	w9, w13            // compare queue_start_ptr with queue_end_ptr
  b.ge	label-0          // if queue_start_ptr >= queue_end_ptr, jump to end

  adrp	x11, aeb3000
  adrp	x12, 3442000
  adrp	x14, 5a68000 
  adrp	x15, 493000
  add	x11, x11, #0x970
  add	x12, x12, #0xb60
  add	x14, x14, #0x568
  add	x15, x15, #0xad0
  mov	w16, #0x1                   	// #1
  b	label-1

label-4: 	
 add	x9, x9, #0x1      // queue_start_ptr = queue_start_ptr+1
 cmp	x9, w13, sxtw     // compare queue_start_ptr with queue_end_ptr
 b.ge	label-2           // if queue_start_ptr>=queue_end_ptr, jump to end
  
label-1: 	
  ldrsw	x18, [x11, x9, lsl #2]  // bfs_queue[queue_start_ptr] -> x18, base addr of bfs_queue[] = x11
  add	w0, w18, #0x1             // bfs_queue[queue_start_ptr]+1 -> w0
  ldrsw	x17, [x12, x18, lsl #2] // i -> x17, base addr of row_ptr[] = x12
                                // first time, i = row_ptr[bfs_queue[queue_start_ptr]]
  ldr	w0, [x12, w0, sxtw #2]  // row_ptr[bfs_queue[queue_start_ptr]+1] -> w0
  cmp	w17, w0                 // compare row_ptr[bfs_queue[queue_start_ptr]] with row_ptr[bfs_queue[queue_start_ptr]+1]
  mov	w0, w13                 // queue_end_ptr -> w0
  b.lt	label-3   // if row_ptr[bfs_queue[queue_start_ptr]] < row_ptr[bfs_queue[queue_start_ptr]+1], search neighbors for this vertex

  b	    label-4   // if row_ptr[bfs_queue[queue_start_ptr]] > row_ptr[bfs_queue[queue_start_ptr]+1], go to next vertex          

label-5:
  add	x1, x12, w18, sxtw #2  //addr of row_ptr[bfs_queue[queue_start_ptr]] -> x1
  ldrsw	x1, [x1, #4]         // load row_ptr[bfs_queue[queue_start_ptr]+1]
  add	x17, x17, #0x1         // i = i + 1
  cmp	x17, x1                // compare i and row_ptr[bfs_queue[queue_start_ptr]+1]
  b.ge	label-4  // b.tcont  if i >= row[bfs_queue[queue_start_ptr]+1], go to next vertex

label-3: 	
  ldr	w2, [x14, x17, lsl #2]  // col_idx[i] -> w2, base addr of col_idx[] = x14
  sxtw	x1, w2                // col_idx[i] -> x1
  ldrb	w3, [x15, x1]         // vis[col_idx[i]] -> w3, base addr of vis[] = x15
  cbnz	w3, label-5           // if vis[col_idx[i]] == 1, go to next neighbor of this vertex

  str	w2, [x11, w0, sxtw #2]  // store col_idx[i] -> bfs_queue[queue_end_ptr]
  ldr	w18, [x11, x9, lsl #2] // bfs_queue[queue_start_ptr] -> w18
  add	w13, w0, #0x1          // queue_end_ptr++
  mov	w0, w13                // queue_end_ptr -> w0
  str	w13, [x10, #40]        // store queue_end_ptr
  strb	w16, [x15, x1]       // vis[col_idx[i]] = true
  b	    label-5              // go to next neighor

label-2: 	
    str	w9, [x8, #2828]      // store queue_start_ptr,if queue_start_ptr>=queue_end_ptr, just end without store.
 
label-0: 	ret