	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			103800 
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Please add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter.v
    vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux.v 
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_CU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity_different_matrix.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_DP.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity_same_matrix.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_top.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
	#vlog 	+acc -incr -source  +define+SIM 	$inc_path/implementation_option.vh
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	