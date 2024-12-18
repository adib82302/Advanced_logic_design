##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -sv -incr ../../rtl/top_module/top_module.v 
vlog -sv -incr test_top_module.v 
vlog -sv -incr ../../rtl/top_module/alu.v 
vlog -sv -incr ../../rtl/top_module/fifo.v
vlog -sv -incr ../../rtl/top_module/imem.v 
vlog -sv -incr ../../rtl/top_module/cmem.v 
vlog -sv -incr ../../rtl/top_module/converter.v 
vlog -sv -incr ../../rtl/top_module/datapath.v 
vlog -sv -incr ../../rtl/top_module/control.v 


# Run Simulator 
vsim +acc -t ps -lib work test_top_module
do waveformat.do   
run -all
