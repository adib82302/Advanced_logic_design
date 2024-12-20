#########################################
# TCL script for Design Compiler        #
# MS 2015                               #
#########################################

#########################################
# READ Design and Library               #
#########################################
set top_level top_module
source -verbose "../common_script/common.tcl"
read_verilog "../../rtl/$top_level/$top_level.v"
read_verilog "../../rtl/$top_level/control.v"
read_verilog "../../rtl/$top_level/datapath.v"
read_verilog "../../rtl/$top_level/converter.v"
read_verilog "../../rtl/$top_level/alu.v"
read_verilog "../../rtl/$top_level/fifo.v"
read_verilog "../../rtl/$top_level/cmem.v"
read_verilog "../../rtl/$top_level/imem.v"
set set_fix_multiple_port_nets "true"
list_designs

if { [check_error -v] == 1 } { exit 1 }

#########################################
# Design Constraints                    #
#########################################
current_design $top_level
link
check_design
source -verbose "./timing.tcl"
set_max_capacitance 0.005 [all_inputs]
set_max_fanout 4 $top_level
set_max_fanout 4 [all_inputs]
set_max_area 0 
set_fix_multiple_port_nets -all -buffer_constants

#########################################
# Compile                               #
#########################################
check_design
#uniquify
current_design $top_level
link
compile_ultra

#########################################
# Optimize design                       #
# Some pointers for possible optimizatio# 
# Check the DC reference manual         #
#########################################
#set_transform_for_retiming {temp_reg[6] temp_reg[5] temp_reg[4] temp_reg[3] temp_reg[2] temp_reg[1] temp_reg[0]} dont_retime
#optimize_registers -clock clk -edge rise -justification_effort high 
#balance_registers
#source -verbose "../script/timing.1.2ns.tcl"
#pipeline_design -stages 8 -clock_port_name $clk_name -check_design -verbose -print_critical_loop
#set_max_capacitance 1 [all_inputs] 
#compile_ultra -no_autoungroup -no_boundary_optimization
#remove_clock -all
#pipeline_design -stages 8 -clock_port_name $clk_name -async_reset reset -check_design -verbose -minimum_period_only

#########################################
# Write outputs                         #
#########################################
source -verbose "../common_script/namingrules.tcl"
set verilogout_no_tri TRUE
write -hierarchy -format verilog -output "${top_level}.nl.v"
#write_sdf -context verilog "${top_level}.temp.sdf"
write_sdc "${top_level}.syn.sdc" -version 1.7
write_sdf "${top_level}.syn.sdf"
