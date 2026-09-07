# Simulation with Icarus Verilog. The original flow used ModelSim; this needs
# only open-source tools and checks against the same golden vectors.

TOP       := TB
SOURCES   := $(wildcard trunk/src/hdl/*.v) trunk/sim/tb/tb.v
BUILD     := build
SIMULATOR := $(BUILD)/$(TOP).vvp

.PHONY: all sim check clean

all: sim

$(SIMULATOR): $(SOURCES)
	@mkdir -p $(BUILD)
	iverilog -g2005 -o $@ -s $(TOP) $(SOURCES)

sim: $(SIMULATOR)
	cd trunk/sim && vvp ../../$(SIMULATOR)

check: sim
	@for i in 0 1 2; do \
		git diff --quiet -- trunk/sim/file/output_$$i.txt \
			&& echo "output_$$i.txt matches the golden vectors" \
			|| { echo "output_$$i.txt DIFFERS from the golden vectors"; exit 1; }; \
	done

clean:
	rm -rf $(BUILD) trunk/sim/colparity.vcd
