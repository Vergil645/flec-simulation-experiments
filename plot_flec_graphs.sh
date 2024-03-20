#!/usr/bin/env bash

# docker build -t flec-matplotlib -f Dockerfile-matplotlib .

function make_db() {
    local testsuite=${1}
    local testnames=${2}
    local test=${3}

    rm -f results_db/${test}.db
    echo parsing $test results...
    docker run --rm -v $(pwd):/plots -w /plots flec-matplotlib python3 json_to_db.py --testnames ${testnames} \
        --test-suite-name ${testsuite} -t results_db/${test}.db results/${test}.json
}

mkdir -p results_db
mkdir -p results_plots

# simple_fec

TESTSUITE="rwin-limited-download"
TESTNAMES="simple_fec_bulk_bbr,simple_fec_ac_rlnc_bbr,bbr"
for test in bulk ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="rwin-limited-download"
TESTNAMES="simple_fec_causal_bbr,bbr"
for test in rwin_limited_experimental_design_bursty rwin_limited_loss_05 \
            rwin_limited_scatter_150kB rwin_limited_experimental_design rwin_limited_loss_2 \
            rwin_limited_scatter_6MB ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="video-with-losses"
TESTNAMES="simple_fec_message_bbr,bbr,simple_fec_message_bbr_without_api"
for test in messages_experimental_design messages_loss_1 ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

# static_fec

TESTSUITE="rwin-limited-download"
TESTNAMES="static_fec_bulk_bbr,simple_fec_bulk_bbr,bbr"
for test in static_bulk ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

TESTSUITE="rwin-limited-download"
# TESTNAMES="static_fec_buffer_limited_bbr,simple_fec_buffer_limited_bbr,bbr"
TESTNAMES="static_fec_buffer_limited_bbr,bbr"
for test in static_rwin_limited_loss_05 static_rwin_limited_loss_2 \
            static_rwin_limited_experimental_design_bursty static_rwin_limited_experimental_design \
            static_rwin_limited_scatter_150kB static_rwin_limited_scatter_6MB ; do
    make_db ${TESTSUITE} ${TESTNAMES} ${test}
done

# ===== Generating graphs

echo "Generating the graphs from the results..."

docker run --rm -v $(pwd):/plots -w /plots flec-matplotlib bash plots.sh

echo "Done !"