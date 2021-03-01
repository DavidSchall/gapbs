# Makefile-based Benchmarking Infrastructure
# Scott Beamer, 2017



# Generate Input Graphs ------------------------------------------------#
#-----------------------------------------------------------------------#

GRAPH_DIR = benchmark/graphs
RAW_GRAPH_DIR = benchmark/graphs/raw

# GRAPHS = twitter web road kron urand

GRAPHS = smedia snet road
ALL_GRAPHS =\
	$(addsuffix .sg, $(GRAPHS)) \
	$(addsuffix .wsg, $(GRAPHS)) \
	$(addsuffix U.sg, $(GRAPHS))
ALL_GRAPHS_WITH_PATHS = $(addprefix $(GRAPH_DIR)/, $(ALL_GRAPHS))

$(RAW_GRAPH_DIR):
	mkdir -p $@

.PHONY: bench-graphs
bench-graphs: $(RAW_GRAPH_DIR) $(ALL_GRAPHS_WITH_PATHS)


# Real-world

# TWITTER_URL = http://an.kaist.ac.kr/~haewoon/release/twitter_social_graph/twitter_rv.tar.gz
# $(RAW_GRAPH_DIR)/twitter_rv.tar.gz:
# 	wget -P $(RAW_GRAPH_DIR) $(TWITTER_URL)

# $(RAW_GRAPH_DIR)/twitter_rv.net: $(RAW_GRAPH_DIR)/twitter_rv.tar.gz
# 	tar -zxvf $< -C $(RAW_GRAPH_DIR)
# 	touch $@

# $(RAW_GRAPH_DIR)/twitter.el: $(RAW_GRAPH_DIR)/twitter_rv.net
# 	rm -f $@
# 	ln -s twitter_rv.net $@

# $(GRAPH_DIR)/twitter.sg: $(RAW_GRAPH_DIR)/twitter.el converter
# 	./converter -f $< -b $@

# $(GRAPH_DIR)/twitter.wsg: $(RAW_GRAPH_DIR)/twitter.el converter
# 	./converter -f $< -wb $@

# $(GRAPH_DIR)/twitterU.sg: $(RAW_GRAPH_DIR)/twitter.el converter
# 	./converter -sf $< -b $@


# ROAD_URL = http://www.dis.uniroma1.it/challenge9/data/USA-road-d/USA-road-d.USA.gr.gz

# $(RAW_GRAPH_DIR)/USA-road-d.USA.gr.gz:
# 	wget -P $(RAW_GRAPH_DIR) $(ROAD_URL)

# $(RAW_GRAPH_DIR)/USA-road-d.USA.gr: $(RAW_GRAPH_DIR)/USA-road-d.USA.gr.gz
# 	cd $(RAW_GRAPH_DIR)
# 	gunzip < $< > $@

# $(GRAPH_DIR)/road.sg: $(RAW_GRAPH_DIR)/USA-road-d.USA.gr converter
# 	./converter -f $< -b $@

# $(GRAPH_DIR)/road.wsg: $(RAW_GRAPH_DIR)/USA-road-d.USA.gr converter
# 	./converter -f $< -wb $@

# $(GRAPH_DIR)/roadU.sg: $(RAW_GRAPH_DIR)/USA-road-d.USA.gr converter
# 	./converter -sf $< -b $@




# WEB_URL = https://sparse.tamu.edu/MM/LAW/sk-2005.tar.gz
# $(RAW_GRAPH_DIR)/sk-2005.tar.gz:
# 	wget -P $(RAW_GRAPH_DIR) $(WEB_URL)

# $(RAW_GRAPH_DIR)/sk-2005/sk-2005.mtx: $(RAW_GRAPH_DIR)/sk-2005.tar.gz
# 	tar -zxvf $< -C $(RAW_GRAPH_DIR)
# 	touch $@

# $(GRAPH_DIR)/web.sg: $(RAW_GRAPH_DIR)/sk-2005/sk-2005.mtx converter
# 	./converter -f $< -b $@

# $(GRAPH_DIR)/web.wsg: $(RAW_GRAPH_DIR)/sk-2005/sk-2005.mtx converter
# 	./converter -f $< -wb $@

# $(GRAPH_DIR)/webU.sg: $(RAW_GRAPH_DIR)/sk-2005/sk-2005.mtx converter
# 	./converter -sf $< -b $@



### Use only California roads:
# ROAD_URL = http://www.dis.uniroma1.it/challenge9/data/USA-road-d/USA-road-d.USA.gr.gz
ROAD_URL = http://users.diag.uniroma1.it/challenge9/data/USA-road-d/USA-road-d.CAL.gr.gz

$(RAW_GRAPH_DIR)/USA-road-d.CAL.gr.gz:
	wget -P $(RAW_GRAPH_DIR) $(ROAD_URL)

$(RAW_GRAPH_DIR)/USA-road-d.CAL.gr: $(RAW_GRAPH_DIR)/USA-road-d.CAL.gr.gz
	cd $(RAW_GRAPH_DIR)
	gunzip < $< > $@

$(GRAPH_DIR)/road.sg: $(RAW_GRAPH_DIR)/USA-road-d.CAL.gr converter
	./converter -f $< -b $@

$(GRAPH_DIR)/road.wsg: $(RAW_GRAPH_DIR)/USA-road-d.CAL.gr converter
	./converter -f $< -wb $@

$(GRAPH_DIR)/roadU.sg: $(RAW_GRAPH_DIR)/USA-road-d.CAL.gr converter
	./converter -sf $< -b $@


### Orkut data set (social network)
SOCIALNET_URL = https://suitesparse-collection-website.herokuapp.com/MM/SNAP/com-Orkut.tar.gz
$(RAW_GRAPH_DIR)/com-Orkut.tar.gz:
	wget -P $(RAW_GRAPH_DIR) $(SOCIALNET_URL)

$(RAW_GRAPH_DIR)/com-Orkut/com-Orkut.mtx: $(RAW_GRAPH_DIR)/com-Orkut.tar.gz
	tar -zxvf $< -C $(RAW_GRAPH_DIR)
	touch $@

$(GRAPH_DIR)/snet.sg: $(RAW_GRAPH_DIR)/com-Orkut/com-Orkut.mtx converter
	./converter -f $< -b $@

$(GRAPH_DIR)/snet.wsg: $(RAW_GRAPH_DIR)/com-Orkut/com-Orkut.mtx converter
	./converter -f $< -wb $@

$(GRAPH_DIR)/snetU.sg: $(RAW_GRAPH_DIR)/com-Orkut/com-Orkut.mtx converter
	./converter -sf $< -b $@


### LiveJournal (social media)
SOCIALMEDIA_URL = https://suitesparse-collection-website.herokuapp.com/MM/SNAP/soc-LiveJournal1.tar.gz

$(RAW_GRAPH_DIR)/soc-LiveJournal1.tar.gz:
	wget -P $(RAW_GRAPH_DIR) $(SOCIALMEDIA_URL)

$(RAW_GRAPH_DIR)/soc-LiveJournal1/soc-LiveJournal1.mtx: $(RAW_GRAPH_DIR)/soc-LiveJournal1.tar.gz
	tar -zxvf $< -C $(RAW_GRAPH_DIR)
	touch $@

$(GRAPH_DIR)/smedia.sg: $(RAW_GRAPH_DIR)/soc-LiveJournal1/soc-LiveJournal1.mtx converter
	./converter -f $< -b $@

$(GRAPH_DIR)/smedia.wsg: $(RAW_GRAPH_DIR)/soc-LiveJournal1/soc-LiveJournal1.mtx converter
	./converter -f $< -wb $@

$(GRAPH_DIR)/smediaU.sg: $(RAW_GRAPH_DIR)/soc-LiveJournal1/soc-LiveJournal1.mtx converter
	./converter -sf $< -b $@




# Synthetic

# KRON_ARGS = -g27 -k16
# $(GRAPH_DIR)/kron.sg: converter
# 	./converter $(KRON_ARGS) -b $@

# $(GRAPH_DIR)/kron.wsg: converter
# 	./converter $(KRON_ARGS) -wb $@

# $(GRAPH_DIR)/kronU.sg: $(GRAPH_DIR)/kron.sg converter
# 	rm -f $@
# 	ln -s kron.sg $@

# URAND_ARGS = -u27 -k16
# $(GRAPH_DIR)/urand.sg: converter
# 	./converter $(URAND_ARGS) -b $@

# $(GRAPH_DIR)/urand.wsg: converter
# 	./converter $(URAND_ARGS) -wb $@

# $(GRAPH_DIR)/urandU.sg: $(GRAPH_DIR)/urand.sg converter
# 	rm -f $@
# 	ln -s urand.sg $@



# Benchmark Execution --------------------------------------------------#
#-----------------------------------------------------------------------#

OUTPUT_DIR = benchmark/out

$(OUTPUT_DIR):
	mkdir -p $@

# Ordered to reuse input graphs to increase OS file cache hit probability
BENCH_ORDER = \
	bfs-snet pr-snet cc-snet bc-snet \
	bfs-smedia pr-smedia cc-smedia bc-smedia \
	bfs-road pr-road cc-road bc-road \
	sssp-smedia sssp-snet sssp-road \
	tc-smedia tc-snet tc-road

OUTPUT_FILES = $(addsuffix .out, $(addprefix $(OUTPUT_DIR)/, $(BENCH_ORDER)))

.PHONY: bench-run
bench-run: $(OUTPUT_DIR) $(OUTPUT_FILES)

$(OUTPUT_DIR)/bfs-%.out : $(GRAPH_DIR)/%.sg bfs
	./bfs -f $< -n64 > $@

SSSP_ARGS = -n64
$(OUTPUT_DIR)/sssp-smedia.out: $(GRAPH_DIR)/smedia.wsg sssp
	./sssp -f $< $(SSSP_ARGS) -d2 > $@

$(OUTPUT_DIR)/sssp-snet.out: $(GRAPH_DIR)/snet.wsg sssp
	./sssp -f $< $(SSSP_ARGS) -d2 > $@

$(OUTPUT_DIR)/sssp-road.out: $(GRAPH_DIR)/road.wsg sssp
	./sssp -f $< $(SSSP_ARGS) -d50000 > $@

# $(OUTPUT_DIR)/sssp-kron.out: $(GRAPH_DIR)/kron.wsg sssp
# 	./sssp -f $< $(SSSP_ARGS) -d2 > $@

# $(OUTPUT_DIR)/sssp-urand.out: $(GRAPH_DIR)/urand.wsg sssp
# 	./sssp -f $< $(SSSP_ARGS) -d2 > $@

$(OUTPUT_DIR)/pr-%.out: $(GRAPH_DIR)/%.sg pr
	./pr -f $< -i1000 -t1e-4 -n16 > $@

$(OUTPUT_DIR)/cc-%.out: $(GRAPH_DIR)/%.sg cc
	./cc -f $< -n16 > $@

$(OUTPUT_DIR)/bc-%.out: $(GRAPH_DIR)/%.sg bc
	./bc -f $< -i4 -n16 > $@

$(OUTPUT_DIR)/tc-%.out: $(GRAPH_DIR)/%U.sg tc
	./tc -f $< -n3 > $@
