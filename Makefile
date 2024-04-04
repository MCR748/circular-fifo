MODULE=CircularFifo

.PHONY:sim
sim: waves

.PHONY:verilate
verilate: .stamp.verilate

.PHONY:build
build: obj_dir/Valu

.PHONY:waves
waves: waveform.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave waveform.vcd

waveform.vcd: ./obj_dir/V$(MODULE)
	@echo
	@echo "### SIMULATING ###"
	@./obj_dir/V$(MODULE) +verilator+rand+reset+2

./obj_dir/V$(MODULE): .stamp.verilate
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)

.stamp.verilate: .stamp.sbtrun generated/$(MODULE).v tb_$(MODULE).cpp 
	@echo
	@echo "### VERILATING ###"
	verilator -Wall --trace --x-assign unique --x-initial unique -cc generated/$(MODULE).v --exe tb_$(MODULE).cpp
	@touch .stamp.verilate

.stamp.sbtrun: src/main/scala/$(MODULE).scala
	@echo
	@echo "### Generting Hardware code with sbt ###"
	sbt run
	@touch .stamp.sbtrun

.PHONY:lint
lint: $(MODULE).v
	verilator --lint-only $(MODULE).v

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir

