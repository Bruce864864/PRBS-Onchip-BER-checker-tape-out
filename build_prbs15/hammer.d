HAMMER_EXEC ?= /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_run
HAMMER_DEPENDENCIES ?= /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_core.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_top.sv


####################################################################################
## Global steps
####################################################################################
.PHONY: pcb
pcb: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/pcb-rundir/pcb-output-full.json

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/pcb-rundir/pcb-output-full.json: $(HAMMER_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 pcb


####################################################################################
## Steps for prbs15_top
####################################################################################
.PHONY: sim-rtl syn syn-to-sim sim-syn syn-to-par par par-to-sim sim-par sim-par-to-power par-to-power power-par par-to-drc drc par-to-lvs lvs syn-to-formal formal-syn par-to-formal formal-par syn-to-timing timing-syn par-to-timing timing-par

#sim-rtl          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-rtl-rundir/sim-output-full.json
syn              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json

syn-to-sim       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json
#sim-syn          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-rundir/sim-output-full.json

syn-to-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json
par              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json

par-to-sim       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json
#sim-par          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir/sim-output-full.json

#sim-par-to-power : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json
par-to-power     : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json
power-par        : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-rundir/power-output-full.json

par-to-drc       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json
drc              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-rundir/drc-output-full.json

par-to-lvs       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json
lvs              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-rundir/lvs-output-full.json

syn-to-formal    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json
formal-syn       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-rundir/formal-output-full.json

par-to-formal    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json
formal-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-rundir/formal-output-full.json

syn-to-timing    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json
timing-syn       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-rundir/timing-output-full.json

par-to-timing    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json
timing-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-rundir/timing-output-full.json



/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-rtl-rundir/sim-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SIM_RTL_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-rtl-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-rundir/sim-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json $(HAMMER_SIM_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-par

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json $(HAMMER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir/sim-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json $(HAMMER_SIM_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir/sim-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim-to-power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-rundir/power-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json $(HAMMER_POWER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-drc

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-rundir/drc-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json $(HAMMER_DRC_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 drc

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-lvs

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-rundir/lvs-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json $(HAMMER_LVS_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 lvs

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-rundir/formal-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json $(HAMMER_FORMAL_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-rundir/formal-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json $(HAMMER_FORMAL_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-rundir/timing-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json $(HAMMER_TIMING_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-rundir/timing-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json $(HAMMER_TIMING_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 timing

# Redo steps
# These intentionally break the dependency graph, but allow the flexibility to rerun a step after changing a config.
# Hammer doesn't know what settings impact synthesis only, e.g., so these are for power-users who "know better."
# The HAMMER_EXTRA_ARGS variable allows patching in of new configurations with -p or using --to_step or --from_step, for example.
.PHONY: redo-sim-rtl redo-syn redo-syn-to-sim redo-sim-syn redo-syn-to-par redo-par redo-par-to-sim redo-sim-par redo-sim-par-to-power redo-par-to-power redo-power-par redo-par-to-drc redo-drc redo-par-to-lvs redo-lvs redo-syn-to-formal redo-formal-syn redo-par-to-formal redo-formal-par redo-syn-to-timing redo-timing-syn redo-par-to-timing redo-timing-par

#redo-sim-rtl:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-rtl-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

redo-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs15_top.yml $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn

redo-syn-to-sim:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-sim

#redo-sim-syn:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

redo-syn-to-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-par

redo-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par

redo-par-to-sim:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-sim

#redo-sim-par:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim

#redo-sim-par-to-power:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 sim-to-power

redo-par-to-power:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-power

redo-power-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-sim-par-input.json -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/power-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 power

redo-par-to-drc:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-drc

redo-drc:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 drc

redo-par-to-lvs:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-lvs

redo-lvs:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 lvs

redo-syn-to-formal:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-formal

redo-formal-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 formal

redo-par-to-formal:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-formal

redo-formal-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/formal-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 formal

redo-syn-to-timing:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 syn-to-timing

redo-timing-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 timing

redo-par-to-timing:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 par-to-timing

redo-timing-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15/timing-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs15 timing

