#!/bin/bash


export RISCV="/home/am/Documents/probe/riscv-cva6-build"
export TRACE_FAST=1
export NUM_JOBS=1

if [ -z "$1" ];then 
	echo "Missing C file"
	exit
fi

source verif/sim/setup-env.sh

export DV_SIMULATORS=veri-testharness-pk

cd ./verif/sim

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/am/Documents/probe/riscv-fesvr-build/lib"
export SPIKE_PATH="/home/am/Documents/probe/iss-spike/bin/"

STD="-nostdlib -nostartfiles"
FLAGS="-static -mcmodel=medany -fvisibility=hidden -g"
LIB="-lgcc"
INCLUDE="-I../tests/custom/env -I../tests/custom/common"
GCC_OPTS="$STD $FLAGS $INCLUDE $LIB"

python3 cva6.py \
	--target cv32a60x \
	--iss=$DV_SIMULATORS \
	--iss_yaml=cva6.yaml \
	--c_test $1 \
	--linker=../../config/gen_from_riscv_config/linker/link.ld \
	--gcc_opts="$GCC_OPTS" \
	--log_suffix "gcctest"

cd ../../
