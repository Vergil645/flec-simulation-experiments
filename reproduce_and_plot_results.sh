#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "Usage: bash $0 flec_directory (the flec_directory is probably ../flec ?)"
    exit -1
fi


# ===== DOCKER BUILDING =====

# docker build -t pquic-ns3-dce-base-20.04 -f Dockerfile-base-20.04 .
# docker build -t pquic-ns3-dce -f Dockerfile-20.04 .
# docker build -t flec-matplotlib -f Dockerfile-matplotlib .

# ===== DIRECTORIES PREPARING =====

rm results/*.json

for directory in results_db \
                 results_plots ; do
    if [ -d ${directory} ]; then
        rm ${directory}/*
    fi
done

# ================
# ===== FlEC =====
# ================

# python3 reproduce_experiments.py $1 --verbose --only flec_bulk

# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_loss_05
# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_loss_2
# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_scatter_150kB
# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_scatter_6MB
# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_experimental_design
# python3 reproduce_experiments.py $1 --verbose --only flec_rwin_limited_experimental_design_bursty

# python3 reproduce_experiments.py $1 --verbose --only flec_messages_experimental_design
# python3 reproduce_experiments.py $1 --verbose --only flec_messages_loss_1

# ========================
# ===== ABC with RLC =====
# ========================

# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_bulk

# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_loss_05
# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_loss_2
# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_scatter_150kB
# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_scatter_6MB
# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_experimental_design
# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_rwin_limited_experimental_design_bursty

# python3 reproduce_experiments.py $1 --verbose --only abc_rlc_messages_experimental_design
python3 reproduce_experiments.py $1 --verbose --only abc_rlc_messages_loss_1

# =================================
# ===== ABC with Reed-Solomon =====
# =================================

# python3 reproduce_experiments.py $1 --verbose --only abc_rs_bulk

# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_loss_05
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_loss_2
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_scatter_150kB
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_scatter_6MB
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_experimental_design
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_rwin_limited_experimental_design_bursty

# python3 reproduce_experiments.py $1 --verbose --only abc_rs_messages_experimental_design
# python3 reproduce_experiments.py $1 --verbose --only abc_rs_messages_loss_1

# ===== PLOTTING =====

bash plot_flec_graphs.sh
