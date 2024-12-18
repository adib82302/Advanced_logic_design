##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/cmem/cmem.v 
vlog +acc -incr test_cmem.v 

# Run Simulator 
vsim +acc -t ps -lib work test_cmem
do waveformat.do   
run -all
