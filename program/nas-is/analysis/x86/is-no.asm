    for( i=0; i<NUM_KEYS; i++ ) {
        key_buff1[key_buff2[i]]++;
  400d60:	48 63 83 30 22 60 10 	movslq 0x10602230(%rbx),%rax
  400d67:	83 04 85 f0 21 60 00 	addl   $0x1,0x6021f0(,%rax,4)
  400d6e:	01 
    for( i=0; i<NUM_KEYS; i++ ) {
  400d6f:	48 83 c3 04          	add    $0x4,%rbx
  400d73:	48 81 fb 00 00 00 08 	cmp    $0x8000000,%rbx
  400d7a:	75 e4                	jne    400d60 <rank+0x80>
  400d7c:	48 c7 c0 04 00 80 ff 	mov    $0xffffffffff800004,%rax