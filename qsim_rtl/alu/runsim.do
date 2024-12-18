##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/alu/alu.v 
vlog +acc -incr test_alu.v 

# Run Simulator 
vsim +acc -t ps -lib work test_alu
do waveformat.do   
run -all
