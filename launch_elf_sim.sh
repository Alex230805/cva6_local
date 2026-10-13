#!/bin/bash


export RISCV="/home/am/Documents/probe/riscv-cva6-build"
export TRACE_FAST=1
export NUM_JOBS=1

if [ -z "$1" ];then 
	echo "Missing elf file"
	exit
fi

source verif/sim/setup-env.sh

export DV_SIMULATORS=veri-testharness
export SPIKE_PATH="/home/am/Documents/probe/iss-spike/bin/"


cd ./verif/sim


python3 cva6.py \
	--target cv32a60x \
	--iss=$DV_SIMULATORS \
	--iss_yaml=cva6.yaml \
	--elf_test $1 \
	--log_suffix "elftest"
cd ../../
