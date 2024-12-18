##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/imem/imem.v 
vlog +acc -incr test_imem.v 

# Run Simulator 
vsim +acc -t ps -lib work test_imem
do waveformat.do   
run -all
