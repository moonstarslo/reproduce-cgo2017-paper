    for( i=0; i<NUM_KEYS; i++ ) {
        key_buff1[key_buff2[i]]++;
  400f20:	48 81 fd df ff ff 01 	cmp    $0x1ffffdf,%rbp
  400f27:	b9 df ff ff 01       	mov    $0x1ffffdf,%ecx
  400f2c:	48 0f 42 cd          	cmovb  %rbp,%rcx
  400f30:	48 63 14 ad 30 22 60 	movslq 0x10602230(,%rbp,4),%rdx
  400f37:	10 
  400f38:	83 04 95 f0 21 60 00 	addl   $0x1,0x6021f0(,%rdx,4)
  400f3f:	01 
  400f40:	48 63 0c 8d b0 22 60 	movslq 0x106022b0(,%rcx,4),%rcx
  400f47:	10 
  400f48:	48 8d 55 01          	lea    0x1(%rbp),%rdx
  400f4c:	0f 18 0c ad 30 23 60 	prefetcht0 0x10602330(,%rbp,4)
  400f53:	10 
  400f54:	0f 18 0c 8d f0 21 60 	prefetcht0 0x6021f0(,%rcx,4)
  400f5b:	00 
  400f5c:	48 63 0c ad 34 22 60 	movslq 0x10602234(,%rbp,4),%rcx
  400f63:	10 
  400f64:	48 81 fa df ff ff 01 	cmp    $0x1ffffdf,%rdx
  400f6b:	48 0f 43 d0          	cmovae %rax,%rdx
  400f6f:	48 63 14 95 b0 22 60 	movslq 0x106022b0(,%rdx,4),%rdx
  400f76:	10 
  400f77:	83 04 8d f0 21 60 00 	addl   $0x1,0x6021f0(,%rcx,4)
  400f7e:	01 
  400f7f:	0f 18 0c ad 34 23 60 	prefetcht0 0x10602334(,%rbp,4)
  400f86:	10 
  400f87:	0f 18 0c 95 f0 21 60 	prefetcht0 0x6021f0(,%rdx,4)
  400f8e:	00 
    for( i=0; i<NUM_KEYS; i++ ) {
  400f8f:	48 83 c5 02          	add    $0x2,%rbp
  400f93:	48 81 fd 00 00 00 02 	cmp    $0x2000000,%rbp
  400f9a:	75 84                	jne    400f20 <rank+0x100>
  400f9c:	48 c7 c0 10 00 80 ff 	mov    $0xffffffffff800010,%rax