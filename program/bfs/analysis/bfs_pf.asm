00000000004004b4 <BFS_kernel>:

void BFS_kernel(int depth)
{
    while(queue_start_ptr<queue_end_ptr){
  4004b4:	b0000488 	adrp	x8, 491000 <__progname>
  4004b8:	9000048a 	adrp	x10, 490000 <_GLOBAL_OFFSET_TABLE_+0xb8>
  4004bc:	b98b0d09 	ldrsw	x9, [x8, #2828]
  4004c0:	b940294c 	ldr	w12, [x10, #40]
  4004c4:	6b0c013f 	cmp	w9, w12
  4004c8:	5400078a 	b.ge	4005b8 <BFS_kernel+0x104>  // b.tcont
  4004cc:	5292cbeb 	mov	w11, #0x965f                	// #38495
  4004d0:	d005558d 	adrp	x13, aeb2000 <cache_flush+0x7ff690>
  4004d4:	b001820e 	adrp	x14, 3441000 <out_degree+0x2624eb0>
  4004d8:	f002b32f 	adrp	x15, 5a67000 <row_ptr+0x26254a0>
  4004dc:	d0000490 	adrp	x16, 492000 <_nl_loaded_domains>
  4004e0:	72a0130b 	movk	w11, #0x98, lsl #16
  4004e4:	9125c1ad 	add	x13, x13, #0x970
  4004e8:	912d81ce 	add	x14, x14, #0xb60
  4004ec:	9115a1ef 	add	x15, x15, #0x568
  4004f0:	912b4210 	add	x16, x16, #0xad0
  4004f4:	52800031 	mov	w17, #0x1                   	// #1
  4004f8:	14000004 	b	400508 <BFS_kernel+0x54>
                bfs_queue[queue_end_ptr++] = col_idx[i];
                // result[col_idx[i]] = depth;
                vis[col_idx[i]] = true;
            }
        }
        queue_start_ptr++;
  4004fc:	91000529 	add	x9, x9, #0x1
    while(queue_start_ptr<queue_end_ptr){
  400500:	eb2cc13f 	cmp	x9, w12, sxtw
  400504:	5400058a 	b.ge	4005b4 <BFS_kernel+0x100>  // b.tcont
        for (int i = row_ptr[bfs_queue[queue_start_ptr]]; i < row_ptr[bfs_queue[queue_start_ptr] + 1]; i++)
  400508:	8b0909a1 	add	x1, x13, x9, lsl #2
  40050c:	b9800020 	ldrsw	x0, [x1]
  400510:	eb0b013f 	cmp	x9, x11
  400514:	9a8bb132 	csel	x18, x9, x11, lt  // lt = tstop
  400518:	8b1209b2 	add	x18, x13, x18, lsl #2
  40051c:	11000403 	add	w3, w0, #0x1
  400520:	b9808242 	ldrsw	x2, [x18, #128]
  400524:	b8a079d2 	ldrsw	x18, [x14, x0, lsl #2]
  400528:	b863d9c3 	ldr	w3, [x14, w3, sxtw #2]
  40052c:	f9808020 	prfm	pldl1keep, [x1, #256]
  400530:	8b0209c2 	add	x2, x14, x2, lsl #2
  400534:	f9800040 	prfm	pldl1keep, [x2]
  400538:	6b03025f 	cmp	w18, w3
  40053c:	f8804040 	prfum	pldl1keep, [x2, #4]
  400540:	54fffdea 	b.ge	4004fc <BFS_kernel+0x48>  // b.tcont
  400544:	8b1209e1 	add	x1, x15, x18, lsl #2
  400548:	91040021 	add	x1, x1, #0x100
  40054c:	2a0c03e2 	mov	w2, w12
  400550:	14000007 	b	40056c <BFS_kernel+0xb8>
  400554:	8b20c9c3 	add	x3, x14, w0, sxtw #2
  400558:	b9800463 	ldrsw	x3, [x3, #4]
  40055c:	91000652 	add	x18, x18, #0x1
  400560:	91001021 	add	x1, x1, #0x4
  400564:	eb03025f 	cmp	x18, x3
  400568:	54fffcaa 	b.ge	4004fc <BFS_kernel+0x48>  // b.tcont
            if (!vis[col_idx[i]])
  40056c:	b8500023 	ldur	w3, [x1, #-256]
  400570:	eb0b025f 	cmp	x18, x11
  400574:	9a8bb244 	csel	x4, x18, x11, lt  // lt = tstop
  400578:	8b0409e4 	add	x4, x15, x4, lsl #2
  40057c:	b9808085 	ldrsw	x5, [x4, #128]
  400580:	93407c64 	sxtw	x4, w3
  400584:	38646a06 	ldrb	w6, [x16, x4]
  400588:	f9800020 	prfm	pldl1keep, [x1]
  40058c:	8b050205 	add	x5, x16, x5
  400590:	f98000a0 	prfm	pldl1keep, [x5]
  400594:	35fffe06 	cbnz	w6, 400554 <BFS_kernel+0xa0>
                bfs_queue[queue_end_ptr++] = col_idx[i];
  400598:	b822d9a3 	str	w3, [x13, w2, sxtw #2]
        for (int i = row_ptr[bfs_queue[queue_start_ptr]]; i < row_ptr[bfs_queue[queue_start_ptr] + 1]; i++)
  40059c:	b86979a0 	ldr	w0, [x13, x9, lsl #2]
                bfs_queue[queue_end_ptr++] = col_idx[i];
  4005a0:	1100044c 	add	w12, w2, #0x1
  4005a4:	2a0c03e2 	mov	w2, w12
  4005a8:	b900294c 	str	w12, [x10, #40]
                vis[col_idx[i]] = true;
  4005ac:	38246a11 	strb	w17, [x16, x4]
  4005b0:	17ffffe9 	b	400554 <BFS_kernel+0xa0>
        queue_start_ptr++;
  4005b4:	b90b0d09 	str	w9, [x8, #2828]
    }
}
  4005b8:	d65f03c0 	ret