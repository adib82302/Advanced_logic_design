

##################################################
# Modelsim do file to run simulation
# Adjusted for updated testbench and module ports
##################################################

# Setup simulation environment
vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /path_to/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog +acc -incr top_module.nl.v
vlog +acc -incr test_top_module.v
vlog -sv -incr /path_to/rtl/alu.v
vlog -sv -incr /path_to/rtl/fifo.v
vlog -sv -incr /path_to/rtl/imem.v
vlog -sv -incr /path_to/rtl/cmem.v
vlog -sv -incr /path_to/rtl/converter.v
vlog -sv -incr /path_to/rtl/datapath.v
vlog -sv -incr /path_to/rtl/control.v

# Run simulator with SDF timing annotation
vsim -voptargs=+acc -t ps -lib work -sdftyp uut=top_module.syn.sdf test_top_module
do waveformat.do
run -all

##################################################
# Wave format file to visualize signals
##################################################

add wave -r /*
add wave /test_top_module/uut/clk
add wave /test_top_module/uut/reset_n
add wave /test_top_module/uut/start
add wave /test_top_module/uut/done
add wave /test_top_module/uut/input_data
add wave /test_top_module/uut/cmem_data_in
add wave /test_top_module/uut/fast_clk
add wave /test_top_module/uut/output_data

# Set the time resolution for the waveform
tree time -timeunits ps -timescale 1ps

# Group related signals
group -name "Top-Level Signals" -wave sim:/test_top_module/*
group -name "Internal Signals (uut)" -wave sim:/test_top_module/uut/*

# Zoom to the full simulation timeline
wave zoom full

