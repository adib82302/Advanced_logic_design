##################################################
# Modelsim do file to run simulation
##################################################

# Setup
vlib work
vmap work work

# Include Netlist and Testbench
vlog +acc=rn +cover +incr /courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog +acc=rn +cover +incr ../../dc/top_module/top_module.nl.v
vlog +acc=rn +cover +incr test_top_module.v

# Include RTL Sources
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/alu.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/fifo.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/imem.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/cmem.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/converter.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/datapath.v
vlog -sv +acc=rn +cover +incr ../../rtl/top_module/control.v

# Run Simulator with SDF Annotation
vsim -voptargs="+acc" -t ps -lib work -sdftyp uut=../../dc/top_module/top_module.syn.sdf test_top_module

# VCD File Setup
vcd file simulation.vcd
vcd add -r /*

# Add Waveforms (Optional)
do waveformat.do

# Run Simulation
run -all

