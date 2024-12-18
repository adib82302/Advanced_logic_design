##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -sv -incr ../../rtl/control/control.v 
vlog -sv -incr test_control.v 
vlog -sv -incr ../../rtl/control/alu.v 
vlog -sv -incr ../../rtl/control/fifo.v
vlog -sv -incr ../../rtl/control/imem.v 
vlog -sv -incr ../../rtl/control/cmem.v 
vlog -sv -incr ../../rtl/control/converter.v 


# Run Simulator 
vsim +acc -t ps -lib work test_control
do waveformat.do   
run -all
