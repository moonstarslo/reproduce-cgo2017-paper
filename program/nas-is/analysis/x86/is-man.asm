    for( i=0; i<NUM_KEYS; i++ ) {
  400fd0:	
            add    $0x1,%rbp
        	cmp    $0x2000000,%rbp
        	je     401010 <rank+0xf0>
        key_buff1[key_buff2[i]]++;
        	movslq 0x10602230(,%rbp,4),%rax   // load key_buff2[i] -> rax

        	addl   $0x1,0x6021f0(,%rax,4)     // key_buff1[key_buff2[i]] + 1 and store

    #ifdef STRIDE    
         __builtin_prefetch(&key_buff2[(i+FETCHDIST)]);
        	prefetcht0 0x10602330(,%rbp,4)    // prefetch key_buff2[i+64]
        
    #endif     
         if(i+(FETCHDIST>>1)<NUM_KEYS)__builtin_prefetch(&key_buff1[key_buff2[(i+(FETCHDIST>>1))]]);
        	cmp    $0x1ffffdf,%rbp
        	ja     400fd0 <rank+0xb0>
        	movslq 0x106022b0(,%rbp,4),%rax   // load key_buff2[i+32] -> rax
        	prefetcht0 0x6021f0(,%rax,4)      // prefetch key_buff1[key_buff2[i+32]]
        	jmp    400fd0 <rank+0xb0>
  401010:
        	mov    $0xffffffffff800010,%rax