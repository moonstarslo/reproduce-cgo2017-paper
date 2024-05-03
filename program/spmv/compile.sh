# clang++-10 -O3 -g src/spmv_x86.cpp -o bin/spmv_x86
# clang++-10 -Xclang -load -Xclang ../../package/plugin-llvm-sw-prefetch-pass/build/SwPrefetchPass.so -O3 -g src/spmv_x86.cpp -o bin/spmv_x86_pf

# clang++-10 -Xclang -load -Xclang ../../package/plugin-llvm-sw-prefetch-pass/build/SwPrefetchPass.so -O3 -g src/spmv_x86.cpp -o bin/spmv_x86_pf.o
aarch64-linux-gnu-gcc -g -static -c bin/spmv_x86_pf.o -o bin/spmv_arm_pf.elf