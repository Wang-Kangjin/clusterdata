#!/bin/bash
# Based on trace files in csv/, we will generate 23 trace folders (in parallel) that will be used as input folder for the simulator
for file in csv/openb_pod_list*; do
    echo $file
    # Create trace folders with the name of csv trace file (without .csv)
    filename="${file##*/}"
    OUTDIR="${filename%.*}"
    mkdir -p $OUTDIR
    # Copy node yaml (generated by openb_node_list_gpu_node.csv) to the trace folder
    cp node_yaml/openb_node_list_gpu_node.yaml $OUTDIR/
    # Transform csv file to yaml file and put it under trace folder
    python3 pod_csv_to_yaml.py $file &
done
wait && date