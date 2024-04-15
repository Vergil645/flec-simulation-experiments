#!/usr/bin/env bash

# docker build -t flec-matplotlib -f Dockerfile-matplotlib .

function make_db() {
    local testsuite=${1}
    local testnames=${2}
    local test=${3}

    if [ -f "results_db/${test}.db" ]; then
        rm -f "results_db/${test}.db"
    fi

    echo "parsing ${test} results..."

    if [ -f "results/${test}.json" ]; then
        docker run --rm -v $(pwd):/plots -w /plots flec-matplotlib \
            python3 json_to_db.py \
            --testnames ${testnames} \
            --test-suite-name ${testsuite} \
            -t "results_db/${test}.db" \
            "results/${test}.json"

        echo "done parsing ${test} results"
    else
        echo "no ${test} results"
    fi
}

# ===== Preparing

if ! [ -d "results_db" ]; then
    mkdir -p "results_db"
fi

if ! [ -d "results_plots" ]; then
    mkdir -p "results_plots"
fi

# ================
# ===== FlEC =====
# ================

TESTSUITE="rwin-limited-download"
TESTNAMES="simple_fec_bulk_bbr,simple_fec_ac_rlnc_bbr,bbr"
for test in flec_bulk ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="rwin-limited-download"
TESTNAMES="simple_fec_causal_bbr,bbr"
for test in flec_rwin_limited_loss_05 \
            flec_rwin_limited_loss_2 \
            flec_rwin_limited_scatter_150kB \
            flec_rwin_limited_scatter_6MB \
            flec_rwin_limited_experimental_design \
            flec_rwin_limited_experimental_design_bursty ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="video-with-losses"
TESTNAMES="simple_fec_message_bbr,bbr,simple_fec_message_bbr_without_api"
for test in flec_messages_experimental_design \
            flec_messages_loss_1 ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

# ========================
# ===== ABC with RLC =====
# ========================

TESTSUITE="rwin-limited-download"
TESTNAMES="abc_rlc_bulk_bbr,flec_bulk_bbr,bbr"
for test in abc_rlc_bulk ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="rwin-limited-download"
TESTNAMES="abc_rlc_buffer_limited_bbr,bbr"
for test in abc_rlc_rwin_limited_loss_05 \
            abc_rlc_rwin_limited_loss_2 \
            abc_rlc_rwin_limited_experimental_design_bursty \
            abc_rlc_rwin_limited_experimental_design \
            abc_rlc_rwin_limited_scatter_150kB \
            abc_rlc_rwin_limited_scatter_6MB ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

# =================================
# ===== ABC with Reed-Solomon =====
# =================================

TESTSUITE="rwin-limited-download"
TESTNAMES="abc_rs_bulk_bbr,flec_bulk_bbr,bbr"
for test in abc_rs_bulk ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="rwin-limited-download"
TESTNAMES="abc_rs_buffer_limited_bbr,bbr"
for test in abc_rs_rwin_limited_loss_05 \
            abc_rs_rwin_limited_loss_2 \
            abc_rs_rwin_limited_scatter_150kB \
            abc_rs_rwin_limited_scatter_6MB \
            abc_rs_rwin_limited_experimental_design \
            abc_rs_rwin_limited_experimental_design_bursty ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

# ===== Generating graphs

echo "Generating the graphs from the results..."

docker run --rm -v $(pwd):/plots -w /plots flec-matplotlib \
    bash plots.sh

echo "Done !"