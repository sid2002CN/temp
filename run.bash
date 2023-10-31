#!/bin/bash

# Array of batch sizes to test
batch_sizes=(64 128 256 512)

# Loop through each batch size
for batch in "${batch_sizes[@]}"
do
    echo "Running test for batch size: $batch"

    # Replace 'your_command_here' with the actual command you want to run
    # Use $batch wherever you want to use the current batch size in your command
    (time ncu --profile-from-start off \
    --metrics smsp__sass_thread_inst_executed_op_fadd_pred_on.sum,smsp__sass_thread_inst_executed_op_fmul_pred_on.sum,smsp__sass_thread_inst_executed_op_ffma_pred_on.sum*2,\
l1tex__data_pipe_lsu_wavefronts_mem_lg,l1tex__data_pipe_lsu_wavefronts_mem_lg_cmd_read,l1tex__data_pipe_lsu_wavefronts_mem_lg_cmd_write \
    --target-processes all \
    python main.py -a resnet18 --dummy -b $batch) 2>&1 | tee output_$batch_withtime.txt

    # Optional: add a delay between tests, e.g., sleep for 10 seconds
    # sleep 10
done

