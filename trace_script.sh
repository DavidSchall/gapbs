#!/bin/bash


## Use pin to trace GAP benchmarks

# PIN_ROOT=/disk/memphis/data/s2033074/bp-research/pin-3.2-81205-gcc-linux

PIN_ROOT=/disk/memphis/data/s2033074/bp-research/pin-3.13-98189-g60a6ef199-gcc-linux/
# TRACER=/disk/memphis/data/s2033074/bp-research/ChampSim/tracer/obj-intel64/champsim_tracer.so
TRACER=/disk/memphis/data/s2033074/bp-research/bpred-sim/tracer/obj-intel64/bpred-sim_tracer.so



N_SKIP=10
N_TRACE=1001


GAPBS_ROOT=/disk/memphis/data/s2033074/gapbs/

## OMP library
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/disk/memphis/data/s2033074/tools/llvm-project/build/lib/
export LD_LIBRARY_PATH



TRACE_OUT=traces/
GRAPH_DIR="benchmark/graphs/"
RESULT_DIR="benchmark/out/"

################################################################################################################################################

# PRE_FIX="-1B-llvm"
# ## 1 billion to trace
# ## 10 milion for warm up
# ## and 1 million for tail
# N_SKIP=50
# N_TRACE=1101

# RUN="run"
#RUN="trace"
#RUN="trace500"
RUN="trace_10x"


# ./bfs -f benchmark/graphs/snet.sg -n64 > benchmark/out/bfs-snet.out
# ./pr -f benchmark/graphs/snet.sg -i1000 -t1e-4 -n16 > benchmark/out/pr-snet.out
# ./cc -f benchmark/graphs/snet.sg -n16 > benchmark/out/cc-snet.out
# ./bc -f benchmark/graphs/snet.sg -i4 -n16 > benchmark/out/bc-snet.out


# ./bfs -f benchmark/graphs/smedia.sg -n64 > benchmark/out/bfs-smedia.out
# ./cc -f benchmark/graphs/smedia.sg -n16 > benchmark/out/cc-smedia.out
# ./bc -f benchmark/graphs/smedia.sg -i4 -n16 > benchmark/out/bc-smedia.out
# ./pr -f benchmark/graphs/smedia.sg -i1000 -t1e-4 -n16 > benchmark/out/pr-smedia.out
# ./tc -f benchmark/graphs/smediaU.sg -n3 > benchmark/out/tc-smedia.out
# ./sssp -f benchmark/graphs/smedia.wsg -n64 -d2 > benchmark/out/sssp-smedia.out



# ./bfs -f benchmark/graphs/road.sg -n64 > benchmark/out/bfs-road.out
# ./pr -f benchmark/graphs/road.sg -i1000 -t1e-4 -n16 > benchmark/out/pr-road.out
# ./cc -f benchmark/graphs/road.sg -n16 > benchmark/out/cc-road.out
# ./bc -f benchmark/graphs/road.sg -i4 -n16 > benchmark/out/bc-road.out



#### Trace a benchmark in upto 10x 1B instructions
trace_10x_f() 
{
  BM=$1
  GRAPH=$2
  shift; shift;
  CMD=$@

  for i in {0..9}; do
    N_SKIP=$(expr 50 + $i \* 1000)
    N_TRACE=1101
    # TRACE_FILE=${TRACE_OUT}/${BM}_${GRAPH}-${i}-llvm11.champsim
    TRACE_FILE=${TRACE_OUT}/${BM}_${GRAPH}-${i}-llvm11.bpredsim

    echo ${PIN_ROOT}/pin -t ${TRACER} -o ${TRACE_FILE} -s ${N_SKIP}000000 -t ${N_TRACE}000000 -- ${CMD}

    ${PIN_ROOT}/pin -t ${TRACER} -o ${TRACE_FILE} -s ${N_SKIP}000000 -t ${N_TRACE}000000 -- ${CMD}
    pigz ${TRACE_FILE}
  done
}


### Run the benchmark ######
do_bm()
{
  BM=$1
  GRAPH=$2
  shift; shift;
  CMD=$@

  if [ $RUN == "run" ]; then
  echo ${CMD}
  fi

  # if [ $RUN == "trace" ]; then
  # ${PIN_ROOT}/pin -t ${TRACER} -o ${TRACE_FILE} -s ${N_SKIP}000000 -t ${N_TRACE}000000 -- ${CMD}
  # pigz ${TRACE_FILE}
  # fi

  if [ $RUN == "trace_10x" ]; then
    # echo ${BM} ${GRAPH} ${CMD}
    trace_10x_f ${BM} ${GRAPH} ${CMD}
  fi

}



### 
do_all_bms()
{
  GRAPH=$1

  # ## 1 ############
  # BM=bfs
  # # ./bfs -f benchmark/graphs/smedia.sg -n64 > benchmark/out/bfs-smedia.out
  # APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.sg -n64 > ${RESULT_DIR}${BM}-${GRAPH}.out"
  # do_bm ${BM} ${GRAPH} ${APP_CMD}


  # ## 2 ############
  # BM=cc
  # # ./cc -f benchmark/graphs/smedia.sg -n16 > benchmark/out/cc-smedia.out
  # APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.sg -n16 > ${RESULT_DIR}${BM}-${GRAPH}.out"
  # do_bm ${BM} ${GRAPH} ${APP_CMD}


  ## 3 ############
  BM=bc
  # ./bc -f benchmark/graphs/smedia.sg -i4 -n16 > benchmark/out/bc-smedia.out
  APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.sg -i4 -n16 > ${RESULT_DIR}${BM}-${GRAPH}.out"
  do_bm ${BM} ${GRAPH} ${APP_CMD}


  # ## 4 ############
  # BM=pr
  # # ./pr -f benchmark/graphs/smedia.sg -i1000 -t1e-4 -n16 > benchmark/out/pr-smedia.out
  # APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.sg -i1000 -t1e-4 -n16 > ${RESULT_DIR}${BM}-${GRAPH}.out"
  # do_bm ${BM} ${GRAPH} ${APP_CMD}


  # ## 5 ############
  # BM=tc
  # # ./tc -f benchmark/graphs/smediaU.sg -n3 > benchmark/out/tc-smedia.out
  # APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}U.sg -n3 > ${RESULT_DIR}${BM}-${GRAPH}.out"
  # do_bm ${BM} ${GRAPH} ${APP_CMD}


  # ## 6 ############
  # BM=sssp
  # # ./sssp -f benchmark/graphs/smedia.wsg -n64 -d2 > benchmark/out/sssp-smedia.out
  # APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.wsg -n64 -d2 > ${RESULT_DIR}${GRAPH}.out"
  # do_bm ${BM} ${GRAPH} ${APP_CMD}
}








# ###### Social Media: LiveJournal ####################
# GRAPH="smedia"
# do_all_bms ${GRAPH}

# ###### Social Net: Orkut ####################
# GRAPH="snet"
# do_all_bms ${GRAPH}

###### Street network: RoadCA ####################
GRAPH="road"
do_all_bms ${GRAPH}


# ## 3 ############
# BM=pr
# #################
# # ./bc -f benchmark/graphs/smedia.sg -i4 -n16 > benchmark/out/bc-smedia.out
# # ./pr -f benchmark/graphs/smedia.sg -i1000 -t1e-4 -n16 > benchmark/out/pr-smedia.out
# # ./tc -f benchmark/graphs/smediaU.sg -n3 > benchmark/out/tc-smedia.out
# # ./sssp -f benchmark/graphs/smedia.wsg -n64 -d2 > benchmark/out/sssp-smedia.out

# APP_CMD="./${BM} -f ${GRAPH_DIR}${GRAPH}.sg -i1000 -t1e-4 -n16 > ${RESULT_DIR}${GRAPH}.out"

# if [ $RUN == "run" ]
# then
# echo ${APP_CMD}
# fi

# if [ $RUN == "trace" ]
# then
# ${PIN_ROOT}/pin -t ${TRACER} -o ${TRACE_FILE} -s ${N_SKIP}000000 -t ${N_TRACE}000000 -- ${APP_CMD}
# pigz ${TRACE_FILE}
# fi

# if [ $RUN == "trace_10x" ]; then
#   trace_10x_f ${BM} ${APP_CMD}
# fi



# bfs
# sssp
# pr
# cc
# bc
# tc
