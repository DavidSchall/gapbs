
# Define a the source files
SRCS="bc bfs cc cc_sv pr sssp tc"
# SRCS="bfs cc cc_sv pr sssp tc"
# SRCS="bc "

CLANG=/disk/memphis/data/s2033074/tools/llvm-project/build/bin/clang++
FLAGS="-std=c++11 -O3 -Wall"



# Iterate the sources and build with LLVM for branch analysis
for val in $SRCS; do
  echo $val
  
  # echo "Build IR 1.stage..."
  # ${CLANG} ${FLAGS} -emit-llvm -c -g ${val}.cc -o ${val}.bc

  # echo "Build IR 2.stage..."
  # ${CLANG} -flto -fuse-ld=lld -Wl,-save-temps -z muldefs  -O3 ${val}.bc   -L/disk/memphis/data/s2033074/tools/llvm-project/build/lib   -o ${val}

  # echo "Build final step again..."
  # ${CLANG} -z muldefs  -O3 ${val}.0.5.precodegen.bc  -L/disk/memphis/data/s2033074/tools/llvm-project/build/lib    -o ${val}

  # echo "Done"
  # cp ${val} ../${val}

  ### copy the BA results to the parent folder
  echo "Done"
  cp ${val}.a.out ../${val}
done
