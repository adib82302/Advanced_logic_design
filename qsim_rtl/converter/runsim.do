##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/converter/converter.v 
vlog +acc -incr test_converter.v 

# Run Simulator 
vsim +acc -t ps -lib work test_converter
do waveformat.do   
run -all
