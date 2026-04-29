HAMMER_EXEC ?= /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_run
HAMMER_DEPENDENCIES ?= /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_core.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_core.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_ctrl.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs15_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_gen_top.sv /w/home.09/home/liyuyao864/ee209/prbs_project/rtl/prbs_ber_top.sv


####################################################################################
## Global steps
####################################################################################
.PHONY: pcb
pcb: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/pcb-rundir/pcb-output-full.json

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/pcb-rundir/pcb-output-full.json: $(HAMMER_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber pcb


####################################################################################
## Steps for prbs_ber_top
####################################################################################
.PHONY: sim-rtl syn syn-to-sim sim-syn syn-to-par par par-to-sim sim-par sim-par-to-power par-to-power power-par par-to-drc drc par-to-lvs lvs syn-to-formal formal-syn par-to-formal formal-par syn-to-timing timing-syn par-to-timing timing-par

#sim-rtl          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-rtl-rundir/sim-output-full.json
syn              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json

syn-to-sim       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json
#sim-syn          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-rundir/sim-output-full.json

syn-to-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json
par              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json

par-to-sim       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json
#sim-par          : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir/sim-output-full.json

#sim-par-to-power : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json
par-to-power     : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json
power-par        : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-rundir/power-output-full.json

par-to-drc       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json
drc              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-rundir/drc-output-full.json

par-to-lvs       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json
lvs              : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-rundir/lvs-output-full.json

syn-to-formal    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json
formal-syn       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-rundir/formal-output-full.json

par-to-formal    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json
formal-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-rundir/formal-output-full.json

syn-to-timing    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json
timing-syn       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-rundir/timing-output-full.json

par-to-timing    : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json
timing-par       : /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-rundir/timing-output-full.json



/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-rtl-rundir/sim-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SIM_RTL_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-rtl-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-rundir/sim-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json $(HAMMER_SIM_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-par

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json $(HAMMER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir/sim-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json $(HAMMER_SIM_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir/sim-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim-to-power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-rundir/power-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json $(HAMMER_POWER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber power

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-drc

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-rundir/drc-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json $(HAMMER_DRC_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber drc

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-lvs

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-rundir/lvs-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json $(HAMMER_LVS_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber lvs

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-rundir/formal-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json $(HAMMER_FORMAL_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-rundir/formal-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json $(HAMMER_FORMAL_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber formal

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-rundir/timing-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json $(HAMMER_TIMING_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-timing

/w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-rundir/timing-output-full.json: /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json $(HAMMER_TIMING_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber timing

# Redo steps
# These intentionally break the dependency graph, but allow the flexibility to rerun a step after changing a config.
# Hammer doesn't know what settings impact synthesis only, e.g., so these are for power-users who "know better."
# The HAMMER_EXTRA_ARGS variable allows patching in of new configurations with -p or using --to_step or --from_step, for example.
.PHONY: redo-sim-rtl redo-syn redo-syn-to-sim redo-sim-syn redo-syn-to-par redo-par redo-par-to-sim redo-sim-par redo-sim-par-to-power redo-par-to-power redo-power-par redo-par-to-drc redo-drc redo-par-to-lvs redo-lvs redo-syn-to-formal redo-formal-syn redo-par-to-formal redo-formal-par redo-syn-to-timing redo-timing-syn redo-par-to-timing redo-timing-par

#redo-sim-rtl:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-rtl-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

redo-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/paths.yml -p /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_cfg_top.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/cfg/prbs_ber_top.yml $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn

redo-syn-to-sim:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-sim

#redo-sim-syn:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

redo-syn-to-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-par

redo-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par

redo-par-to-sim:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-sim

#redo-sim-par:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-input.json $(SIM_EXTRA_ARGS) $(HAMMER_EXTRA_ARGS) --sim_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim

#redo-sim-par-to-power:
#	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber sim-to-power

redo-par-to-power:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-power

redo-power-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-sim-par-input.json -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/power-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber power

redo-par-to-drc:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-drc

redo-drc:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber drc

redo-par-to-lvs:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-lvs

redo-lvs:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber lvs

redo-syn-to-formal:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-formal

redo-formal-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber formal

redo-par-to-formal:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-formal

redo-formal-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/formal-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber formal

redo-syn-to-timing:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber syn-to-timing

redo-timing-syn:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-syn-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber timing

redo-par-to-timing:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber par-to-timing

redo-timing-par:
	$(HAMMER_EXEC) -e /w/home.09/home/liyuyao864/ee209/ee209-hammer-internal/hammer_env_UCLA.yml -p /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber/timing-par-rundir --obj_dir /w/home.09/home/liyuyao864/ee209/prbs_project/build_prbs_ber timing

