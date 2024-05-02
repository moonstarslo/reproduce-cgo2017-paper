    for( i=0; i<NUM_KEYS; i++ ) {
        key_buff1[key_buff2[i]]++;
  _400f80: 	
            cmp    $0x1ffffdf,%rbp
        	mov    $0x1ffffdf,%eax
        	cmovb  %rbp,%rax
        	movslq 0x10602230(,%rbp,4),%rcx // load key_buff2[i] -> rcx

        	addl   $0x1,0x6021f0(,%rcx,4)   // load key_buff1[[key_buff2[i]]] and add 1

        	movslq 0x106022b0(,%rax,4),%rax  // load key_buff2[i+32]

        	prefetcht0 0x10602330(,%rbp,4) // prefetch key_buff2[i+64]

        	prefetcht0 0x6021f0(,%rax,4)  // prefetch key_buff1[key_buff2[i+32]]

        	movslq 0x10602234(,%rbp,4),%rax // load key_buff2[i+1] -> rax

        	cmp    $0x1ffffde,%rbp
        	mov    $0x1ffffde,%ecx
        	cmovb  %rbp,%rcx
        	movslq 0x106022b4(,%rcx,4),%rcx // load key_buff2[i+33]

        	addl   $0x1,0x6021f0(,%rax,4)   // load key_buff1[key_buff2[i+1]] and add 1

        	prefetcht0 0x10602334(,%rbp,4)  // prefetch key_buff2[i+65]

    for( i=0; i<NUM_KEYS; i++ ) {
        	add    $0x2,%rbp
        	prefetcht0 0x6021f0(,%rcx,4)   // prefetch key_buff1[key_buff2[i+33]]

        	cmp    $0x2000000,%rbp
        	jne    400f80 <rank+0xb0>
        	mov    $0xffffffffff800010,%rax