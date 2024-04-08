CROSS_COMPILE = aarch64-linux-gnu-

AS           = $(CROSS_COMPILE)as 
LD           = $(CROSS_COMPILE)ld
CC           = $(CROSS_COMPILE)gcc
CXX          = $(CROSS_COMPILE)g++
CPP          = $(CROSS_COMPILE)cpp
AR           = $(CROSS_COMPILE)ar
NM           = $(CROSS_COMPILE)nm
STRIP        = $(CROSS_COMPILE)strip
OBJCOPY      = $(CROSS_COMPILE)objcopy
OBJDUMP      = $(CROSS_COMPILE)objdump
CLANG		 = clang-11

GEM5_PATH = /home/yinmingzhuo/research/gem5-fork1
PF_PASS_PATH = /home/yinmingzhuo/research/reproduce-cgo2017-paper/package/plugin-llvm-sw-prefetch-pass/build

M5_CFLAGS       = -I${GEM5_PATH}/include -g -O3
M5_CFLAGS      += -S -emit-llvm --target=aarch64-none-linux-gnu --sysroot=/usr/aarch64-linux-gnu -march=armv8-a+nosimd+nosve
M5_PF_CFLAGS    = $(M5_CFLAGS)
M5_PF_CFLAGS   += -Xclang -load -Xclang ${PF_PASS_PATH}/SwPrefetchPass.so 
M5_LLFLAGS   = --target=aarch64-none-linux-gnu --sysroot=/usr/aarch64-linux-gnu -march=armv8-a+nosimd+nosve -O3
ODFLAGS       = -S 
M5_LDFLAGS		= -g -static -flto -fwhole-program
M5_LDFLAGS     += -L${GEM5_PATH}/util/m5/build/arm64/out -lm5

ALL: bin/bfs_m5_c.asm bin/bfs_m5_c_pf.asm bin_ckt/bfs_c.asm bin_ckt/bfs_c_pf.asm

bin/bfs_m5_c.ll: src/bfs_m5.c 
	$(CLANG) $(M5_CFLAGS) -c -o $@ $<

bin/bfs_m5_c.o: bin/bfs_m5_c.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin/bfs_m5_c.elf: bin/bfs_m5_c.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin/bfs_m5_c.asm: bin/bfs_m5_c.elf
	$(OBJDUMP) $(ODFLAGS) bin/bfs_m5_c.elf > bin/bfs_m5_c.asm

bin/bfs_m5_c_pf.ll: src/bfs_m5.c 
	$(CLANG) $(M5_PF_CFLAGS) -c -o $@ $<

bin/bfs_m5_c_pf.o: bin/bfs_m5_c_pf.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin/bfs_m5_c_pf.elf: bin/bfs_m5_c_pf.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin/bfs_m5_c_pf.asm: bin/bfs_m5_c_pf.elf
	$(OBJDUMP) $(ODFLAGS) bin/bfs_m5_c_pf.elf > bin/bfs_m5_c_pf.asm

bin_ckt/bfs_c.ll: src/bfs.c 
	$(CLANG) $(M5_CFLAGS) -c -o $@ $<

bin_ckt/bfs_c.o: bin_ckt/bfs_c.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin_ckt/bfs_c.elf: bin_ckt/bfs_c.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin_ckt/bfs_c.asm: bin_ckt/bfs_c.elf
	$(OBJDUMP) $(ODFLAGS) bin_ckt/bfs_c.elf > bin_ckt/bfs_c.asm

bin_ckt/bfs_c_pf.ll: src/bfs.c
	$(CLANG) $(M5_PF_CFLAGS) -c -o $@ $<

bin_ckt/bfs_c_pf.o: bin_ckt/bfs_c_pf.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin_ckt/bfs_c_pf.elf: bin_ckt/bfs_c_pf.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin_ckt/bfs_c_pf.asm: bin_ckt/bfs_c_pf.elf
	$(OBJDUMP) $(ODFLAGS) bin_ckt/bfs_c_pf.elf > bin_ckt/bfs_c_pf.asm
	
clean:
	rm -f bin/* bin_ckt/*
