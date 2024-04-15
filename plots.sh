# to run in the parent dir

# ================
# ===== FlEC =====
# ================


# ===== bulk experimental design

if [ -f "results_db/flec_bulk.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_bulk_bbr --namesecondtest bbr -f results_db/flec_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/flec_bulk.pdf --log
fi


if [ -f "results_db/flec_bulk.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_ac_rlnc_bbr --namesecondtest bbr -f results_db/flec_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/flec_bulk_vs_ac_rlnc.pdf --log
fi


# ===== buffer-limited


# # using bbr instead of ideal cwin
if [ -f "results_db/flec_rwin_limited_experimental_design.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/flec_rwin_limited_experimental_design.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{FlEC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.25,4 --xticks=0.25,0.5,0.75,1,1.33,2,4 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $loss \in [0.1, 3]\%$'  -t results_plots/flec_rwin_limited_experimental_design.pdf
fi


if [ -f "results_db/flec_rwin_limited_loss_05.db" ]; then
	python3 boxplot_results.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/flec_rwin_limited_loss_05.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/flec_rwin_limited_loss_05.pdf
fi

if [ -f "results_db/flec_rwin_limited_loss_2.db" ]; then
	python3 boxplot_results.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/flec_rwin_limited_loss_2.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 2\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/flec_rwin_limited_loss_2.pdf
fi


# ===== bbr experimental design bursts

if [ -f "results_db/flec_rwin_limited_experimental_design_bursty.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/flec_rwin_limited_experimental_design_bursty.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{FlEC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.5,2 --xticks 0.5,0.75,1,1.33,2 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $G_{\hat{p}} \in [0.1, 1.5]\%$' -t results_plots/flec_rwin_limited_experimental_design_bursty.pdf
fi


# BYTES TIME TRADEOFF
if [ -f "results_db/flec_rwin_limited_scatter_150kB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr -f results_db/flec_rwin_limited_scatter_150kB.db --metric time --uni-x-metric server_bytes_sent_simple_fec_causal_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 2\%, rwin=150kB" --rwin-size 150000 --labelfirsttest FlEC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/flec_rwin_limited_scatter_150kB.pdf
fi

if [ -f "results_db/flec_rwin_limited_scatter_6MB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest simple_fec_causal_bbr --namesecondtest bbr -f results_db/flec_rwin_limited_scatter_6MB.db --metric time --uni-x-metric server_bytes_sent_simple_fec_causal_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%, rwin=6MB" --rwin-size 6000000 --labelfirsttest FlEC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/flec_rwin_limited_scatter_6MB.pdf --ylim 7000,8200 --yticks 7000,7500,8000
fi



# ===== messages

# bbr bytes sent
if [ -f "results_db/flec_messages_loss_1.db" ] && [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr,simple_fec_message_bbr_without_api --namesecondtest bbr,bbr -f results_db/flec_messages_loss_1.db,results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric server_bytes_sent --labelfirsttest "FlEC" --labelsecondtest QUIC --transform ratio --xlabel "one-way delay (ms)" --ylabel 'byte sent $\frac{FlEC}{QUIC}$' --ylim 0.33,3 --ylog --yticks "0.33,0.5,0.9,1,1.1,2,3=0.33,0.5,0.9,,1.1,2,3" --xticks 5,25,50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" --legends '$FlEC_{API}$,$FlEC_{NO-API}$' -t results_plots/flec_messages_loss_1_bytes_sent_with_and_without_api.pdf
fi

# bbr 95pct
if [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr --namesecondtest bbr -f results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric message_95_pct_delivery_delay --labelfirsttest "FlEC" --labelsecondtest QUIC --transform none --xlabel "one-way delay (ms)" --ylabel 'delivery time $95^{th} percentile$' --ylim 0,1000000 --yticks 50000,150000,250000,500000=50,150,250,500 --xticks 50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" -t results_plots/flec_messages_loss_1_95_pct.pdf
fi

# bbr 97pct
if [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr --namesecondtest bbr -f results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric message_97_pct_delivery_delay --labelfirsttest "FlEC" --labelsecondtest QUIC --transform none --xlabel "one-way delay (ms)" --ylabel 'delivery time $97^{th} percentile$' --ylim 0,1000000 --yticks 50000,150000,250000,500000=50,150,250,500 --xticks 50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" -t results_plots/flec_messages_loss_1_97_pct.pdf
fi

# bbr 98pct
if [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr --namesecondtest bbr -f results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric message_98_pct_delivery_delay --labelfirsttest "FlEC" --labelsecondtest QUIC --transform none --xlabel "one-way delay (ms)" --ylabel 'delivery time $98^{th} percentile$' --ylim 0,1000000 --yticks 50000,150000,250000,500000=50,150,250,500 --xticks 50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" -t results_plots/flec_messages_loss_1_98_pct.pdf
fi

# bbr 99pct
if [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr --namesecondtest bbr -f results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric message_99_pct_delivery_delay --labelfirsttest "FlEC" --labelsecondtest QUIC --transform none --xlabel "one-way delay (ms)" --ylabel 'delivery time $99^{th} percentile$' --ylim 0,1000000 --yticks 50000,150000,250000,500000=50,150,250,500 --xticks 50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" -t results_plots/flec_messages_loss_1_99_pct.pdf
fi

# bbr long deliveries pct
if [ -f "results_db/flec_messages_loss_1.db" ] && [ -f "results_db/flec_messages_loss_1.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr,simple_fec_message_bbr_without_api --namesecondtest bbr,bbr -f results_db/flec_messages_loss_1.db,results_db/flec_messages_loss_1.db --filesize 5000000 -m uni --metric message_long_deliveries_pct --labelfirsttest "FlEC" --labelsecondtest QUIC --transform ratio --xlabel "one-way delay (ms)" --ylabel '$\frac{\#msg_{FlEC}}{\#msg_{QUIC}}$' --ylim 0.9,1.1 --ylog --yticks "0.9,1,1.1=0.9,,1.1" --xticks 5,25,50,75,100,125,150,175,200 --title '$bw$ = 8Mbps, $loss$ = 1\%, $deadline$ = 250ms' --labelfirsttest "FlEC" --labelsecondtest "QUIC" --legends '$FlEC_{API}$,$FlEC_{NO-API}$' -t results_plots/flec_messages_loss_1_long_deliveries_pct_with_and_without_api.pdf
fi



# bbr experimental design
if [ -f "results_db/flec_messages_experimental_design.db" ]; then
	python3 plot_results.py --namefirsttest simple_fec_message_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/flec_messages_experimental_design.db --metric message_long_deliveries_pct,server_bytes_sent --filesize 5000000,0,0,0 --xlabel "ratio" --labelfirsttest "FlEC" --labelsecondtest "QUIC" --ylabel "CDF" --xlim 0.5,2 --ylim 0,1 --xticks "0.5,0.75,1,1.33,2=0.5,0.75,1,1.33,2" --log --title '$RTT \in [10, 400]ms$, $bw \in [0.8, 30]Mbps$, $loss \in [0.1, 3]\%$' -t results_plots/flec_messages_experimental_design.pdf --legends '$\frac{\#msg_{FlEC}}{\#msg_{QUIC}}$,$\frac{bytes_{FlEC}}{bytes_{QUIC}}$'
fi


# ========================
# ===== ABC with RLC =====
# ========================

# ===== bulk experimental design

# # TIME: abc_rlc_fec_bulk_bbr vs QUIC
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_bulk_bbr --namesecondtest bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rlc_bulk_bbr.pdf --log
fi

# # TIME: flec_bulk_bbr vs QUIC
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest flec_bulk_bbr --namesecondtest bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rlc_flec_bulk_bbr.pdf --log
fi

# # TIME: abc_rlc_bulk_bbr vs flec_bulk_bbr
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_bulk_bbr --namesecondtest flec_bulk_bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{ABC}}{DCT_{FlEC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rlc_vs_flec_bulk_bbr.pdf --log
fi

# # BYTES SENT: abc_rlc_bulk_bbr vs QUIC
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_bulk_bbr --namesecondtest bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{ABC}}{BS_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rlc_bulk_bbr.pdf --log
fi

# # BYTES SENT: flec_bulk_bbr vs QUIC
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest flec_bulk_bbr --namesecondtest bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{FlEC}}{BS_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rlc_flec_bulk_bbr.pdf --log
fi

# # BYTES SENT: abc_rlc_bulk_bbr vs flec_bulk_bbr
if [ -f "results_db/abc_rlc_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_bulk_bbr --namesecondtest flec_bulk_bbr -f results_db/abc_rlc_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{ABC}}{BS_{FlEC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rlc_vs_flec_bulk_bbr.pdf --log
fi


# ===== buffer-limited

# # TIME, loss=0.5: abc_rlc_buffer_limited_bbr vs QUIC
if [ -f "results_db/abc_rlc_rwin_limited_loss_05.db" ]; then
	python3 boxplot_results.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/abc_rlc_rwin_limited_loss_05.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/abc_rlc_rwin_limited_loss_05.pdf
fi


# # TIME, loss=2: abc_rlc_buffer_limited_bbr vs QUIC
if [ -f "results_db/abc_rlc_rwin_limited_loss_2.db" ]; then
	python3 boxplot_results.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/abc_rlc_rwin_limited_loss_2.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 2\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/abc_rlc_rwin_limited_loss_2.pdf
fi


# # experimental design bursts: abc_rlc_buffer_limited_bbr
if [ -f "results_db/abc_rlc_rwin_limited_experimental_design_bursty.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/abc_rlc_rwin_limited_experimental_design_bursty.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{ABC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.5,2 --xticks 0.5,0.75,1,1.33,2 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $G_{\hat{p}} \in [0.1, 1.5]\%$' -t results_plots/abc_rlc_rwin_limited_experimental_design_bursty.pdf
fi


# # experimental design: abc_rlc_buffer_limited_bbr
if [ -f "results_db/abc_rlc_rwin_limited_experimental_design.db" ]; then
	python3 plot_results.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/abc_rlc_rwin_limited_experimental_design.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{ABC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.25,4 --xticks=0.25,0.5,0.75,1,1.33,2,4 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $loss \in [0.1, 3]\%$'  -t results_plots/abc_rlc_rwin_limited_experimental_design.pdf
fi


# BYTES TIME TRADEOFF 150kB: abc_rlc_buffer_limited_bbr
if [ -f "results_db/abc_rlc_rwin_limited_scatter_150kB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr -f results_db/abc_rlc_rwin_limited_scatter_150kB.db --metric time --uni-x-metric server_bytes_sent_abc_rlc_buffer_limited_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 2\%, rwin=150kB" --rwin-size 150000 --labelfirsttest ABC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/abc_rlc_rwin_limited_scatter_150kB.pdf
fi


# BYTES TIME TRADEOFF 6MB: abc_rlc_buffer_limited_bbr
if [ -f "results_db/abc_rlc_rwin_limited_scatter_6MB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest abc_rlc_buffer_limited_bbr --namesecondtest bbr -f results_db/abc_rlc_rwin_limited_scatter_6MB.db --metric time --uni-x-metric server_bytes_sent_abc_rlc_buffer_limited_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%, rwin=6MB" --rwin-size 6000000 --labelfirsttest ABC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/abc_rlc_rwin_limited_scatter_6MB.pdf --ylim 7000,8200 --yticks 7000,7500,8000
fi


# =================================
# ===== ABC with Reed-Solomon =====
# =================================

# ===== bulk experimental design

# # TIME: abc_rs_bulk_bbr vs QUIC
if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_bulk_bbr --namesecondtest bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rs_bulk_bbr.pdf --log
fi

# # TIME: flec_bulk_bbr vs QUIC
if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest flec_bulk_bbr --namesecondtest bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{FlEC}}{DCT_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rs_flec_bulk_bbr.pdf --log
fi

# # TIME: abc_rs_bulk_bbr vs flec_bulk_bbr

if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_bulk_bbr --namesecondtest flec_bulk_bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric time --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{DCT_{ABC}}{DCT_{FlEC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/abc_rs_vs_flec_bulk_bbr.pdf --log
fi

# # BYTES SENT: abc_rs_bulk_bbr vs QUIC
if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_bulk_bbr --namesecondtest bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{ABC}}{BS_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rs_bulk_bbr.pdf --log
fi

# # BYTES SENT: flec_bulk_bbr vs QUIC
if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest flec_bulk_bbr --namesecondtest bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{FlEC}}{BS_{QUIC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rs_flec_bulk_bbr.pdf --log
fi

# # BYTES SENT: abc_rs_bulk_bbr vs flec_bulk_bbr
if [ -f "results_db/abc_rs_bulk.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_bulk_bbr --namesecondtest flec_bulk_bbr -f results_db/abc_rs_bulk.db --filesize 10000,40000,100000,1000000,10000000 -m CDF --metric server_bytes_sent --labelfirsttest "QUIC FEC" --labelsecondtest QUIC --transform ratio --xlabel '$\frac{BS_{ABC}}{BS_{FlEC}}$' --ylabel 'CDF' --ylim 0,1.005 --yticks 0,1 --xlim 0.25,4 --xticks 0.25,0.5,0.75,1,1.33,2,4 --title '$bw \in [1, 30]Mbps$, $loss \in [0.1, 8]\%$, $RTT \in [10, 200]ms$' --labelfirsttest "QUIC-FEC" --labelsecondtest "QUIC" -t results_plots/bytes_abc_rs_vs_flec_bulk_bbr.pdf --log
fi

# ===== buffer-limited

# # TIME, loss=0.5: abc_rs_buffer_limited_bbr vs QUIC
if [ -f "results_db/abc_rs_rwin_limited_loss_05.db" ]; then
	python3 boxplot_results.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/abc_rs_rwin_limited_loss_05.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/abc_rs_rwin_limited_loss_05.pdf
fi


# # TIME, loss=2: abc_rs_buffer_limited_bbr vs QUIC
if [ -f "results_db/abc_rs_rwin_limited_loss_2.db" ]; then
	python3 boxplot_results.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr --transform ratio -m boxplot -f results_db/abc_rs_rwin_limited_loss_2.db --metric time --uni-x-metric stream_receive_window_size --filesize 5000000 --xlabel "receive window size (MB)" --no-legend --ylog --ylabel '$\frac{DCT_{ABC}}{DCT_{QUIC}}$'  --title "RTT = 400ms, BW = 8Mbps, loss = 2\%"  --ylim 0.6,1.67 --yticks "0.75,0.9,1,1.11,1.33=0.75,0.9,,1.11,1.33" --xticks "70000,150000,250000,400000,1000000,3000000=0.07,0.15,0.25,0.4,1,3" -t results_plots/abc_rs_rwin_limited_loss_2.pdf
fi


# # experimental design bursts: abc_rs_buffer_limited_bbr
if [ -f "results_db/abc_rs_rwin_limited_experimental_design_bursty.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/abc_rs_rwin_limited_experimental_design_bursty.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{ABC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.5,2 --xticks 0.5,0.75,1,1.33,2 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $G_{\hat{p}} \in [0.1, 1.5]\%$' -t results_plots/abc_rs_rwin_limited_experimental_design_bursty.pdf
fi


# # experimental design: abc_rs_buffer_limited_bbr
if [ -f "results_db/abc_rs_rwin_limited_experimental_design.db" ]; then
	python3 plot_results.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr --transform ratio -m CDF -f results_db/abc_rs_rwin_limited_experimental_design.db --metric time --filesize 5000000 --xlabel "$\frac{DCT_{ABC}}{DCT_{QUIC}}$" --ylabel "CDF" --xlim 0.25,4 --xticks=0.25,0.5,0.75,1,1.33,2,4 --cdf-multiplex-metric stream_receive_window_size --cdf-multiplex-metric-in-bytes --log --title '$RTT \in [10, 400]ms$, $bw \in [1, 30]Mbps$, $loss \in [0.1, 3]\%$'  -t results_plots/abc_rs_rwin_limited_experimental_design.pdf
fi


# BYTES TIME TRADEOFF 150kB: abc_rs_buffer_limited_bbr
if [ -f "results_db/abc_rs_rwin_limited_scatter_150kB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr -f results_db/abc_rs_rwin_limited_scatter_150kB.db --metric time --uni-x-metric server_bytes_sent_abc_rs_buffer_limited_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 2\%, rwin=150kB" --rwin-size 150000 --labelfirsttest ABC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/abc_rs_rwin_limited_scatter_150kB.pdf
fi


# BYTES TIME TRADEOFF 6MB: abc_rs_buffer_limited_bbr
if [ -f "results_db/abc_rs_rwin_limited_scatter_6MB.db" ]; then
	python3 plot_results_bytes_time_tradeoff.py --namefirsttest abc_rs_buffer_limited_bbr --namesecondtest bbr -f results_db/abc_rs_rwin_limited_scatter_6MB.db --metric time --uni-x-metric server_bytes_sent_abc_rs_buffer_limited_bbr,server_bytes_sent_bbr --filesize 5000000 --xlabel "bytes overhead" --ylabel "DCT (ms)" --title "RTT = 400ms, BW = 8Mbps, loss = 0.5\%, rwin=6MB" --rwin-size 6000000 --labelfirsttest ABC --labelsecondtest QUIC --normalize-bytes-sent -t results_plots/abc_rs_rwin_limited_scatter_6MB.pdf --ylim 7000,8200 --yticks 7000,7500,8000
fi
