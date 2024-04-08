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
CLANG		 = clang++-10

GEM5_PATH = ../../../gem5_bfs
PF_PASS_PATH = ../../package/plugin-llvm-sw-prefetch-pass/build

M5_CFLAGS       = -I${GEM5_PATH}/include -g -O2
M5_CFLAGS      += -S -emit-llvm --target=aarch64-linux-gnu  -march=armv8-a+nosimd+nosve
M5_CFLAGS      += -I /usr/aarch64-linux-gnu/include/c++/7/aarch64-linux-gnu/ -I /usr/aarch64-linux-gnu/include/
M5_PF_CFLAGS    = $(M5_CFLAGS)
M5_PF_CFLAGS   += -Xclang -load -Xclang ${PF_PASS_PATH}/SwPrefetchPass.so 
M5_LLFLAGS   = --target=aarch64-linux-gnu -march=armv8-a+nosimd+nosve -O2
ODFLAGS       = -S 
M5_LDFLAGS		= -g -static
M5_LDFLAGS     += -L${GEM5_PATH}/util/m5/build/arm64/out -lm5

ALL: bin/spmv_csr.asm bin/spmv_csr_pf.asm bin_ckt/spmv_c.asm bin_ckt/spmv_c_pf.asm

bin/spmv_csr.ll: src/spmv_csr.cpp 
	$(CLANG) $(M5_CFLAGS) -c -o $@ $<

bin/spmv_csr.o: bin/spmv_csr.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin/spmv_csr.elf: bin/spmv_csr.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin/spmv_csr.asm: bin/spmv_csr.elf
	$(OBJDUMP) $(ODFLAGS) bin/spmv_csr.elf > bin/spmv_csr.asm

bin/spmv_csr_pf.ll: src/spmv_csr.cpp 
	$(CLANG) $(M5_PF_CFLAGS) -c -o $@ $<

bin/spmv_csr_pf.o: bin/spmv_csr_pf.ll
	$(CLANG) $(M5_LLFLAGS) -c -o $@ $<

bin/spmv_csr_pf.elf: bin/spmv_csr_pf.o
	$(CC) -o $@ $< $(M5_LDFLAGS)

bin/spmv_csr_pf.asm: bin/spmv_csr_pf.elf
	$(OBJDUMP) $(ODFLAGS) bin/spmv_csr_pf.elf > bin/spmv_csr_pf.asm
	
clean:
	rm -f bin/*
