##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/datapath/datapath.v 
vlog +acc -incr test_datapath.v 
vlog +acc -incr ../../rtl/datapath/alu.v 
vlog +acc -incr ../../rtl/datapath/fifo.v
vlog +acc -incr ../../rtl/datapath/imem.v 
vlog +acc -incr ../../rtl/datapath/cmem.v 
vlog +acc -incr ../../rtl/datapath/converter.v 


# Run Simulator 
vsim +acc -t ps -lib work test_datapath
do waveformat.do   
run -all
