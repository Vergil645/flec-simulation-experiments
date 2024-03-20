#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "Usage: bash $0 flec_directory (the flec_directory is probably ../flec ?)"
    exit -1
fi

# docker build -t pquic-ns3-dce-base-20.04 -f Dockerfile-base-20.04 .
# docker build -t pquic-ns3-dce -f Dockerfile-20.04 .
# docker build -t flec-matplotlib -f Dockerfile-matplotlib .

# python3 reproduce_experiments.py $1 --verbose

# python3 reproduce_experiments.py $1 --only rwin_limited_loss_05 --verbose
# python3 reproduce_experiments.py $1 --only rwin_limited_loss_2 --verbose

# python3 reproduce_experiments.py $1 --only static_bulk --verbose

python3 reproduce_experiments.py $1 --only static_rwin_limited_loss_05 --verbose
python3 reproduce_experiments.py $1 --only static_rwin_limited_loss_2 --verbose
python3 reproduce_experiments.py $1 --only static_rwin_limited_experimental_design_bursty --verbose
python3 reproduce_experiments.py $1 --only static_rwin_limited_experimental_design --verbose
python3 reproduce_experiments.py $1 --only static_rwin_limited_scatter_150kB --verbose
python3 reproduce_experiments.py $1 --only static_rwin_limited_scatter_6MB --verbose

bash plot_flec_graphs.sh
