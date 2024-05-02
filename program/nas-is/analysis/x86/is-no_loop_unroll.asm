    for( i=0; i<NUM_KEYS; i++ ) {
        key_buff1[key_buff2[i]]++;
  _400fd0: 	
            movslq 0x10602230(%rbp),%rax  // load key_buff2[i] -> rax
         	addl   $0x1,0x6021f0(,%rax,4) // load key_buff1[key_buff2[i]] and add 1

         	movslq 0x10602234(%rbp),%rax
         	addl   $0x1,0x6021f0(,%rax,4)

         	movslq 0x10602238(%rbp),%rax
         	addl   $0x1,0x6021f0(,%rax,4)

         	movslq 0x1060223c(%rbp),%rax
         	addl   $0x1,0x6021f0(,%rax,4)

    for( i=0; i<NUM_KEYS; i++ ) {
            add    $0x10,%rbp
	        cmp    $0x8000000,%rbp
	        jne    400fd0 <rank+0xb0>
	        mov    $0xffffffffff800010,%rax