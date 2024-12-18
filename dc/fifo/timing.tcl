###################################################################### 
## Timing setup for logic synthesis
## The unit for time is ns as defined in the IBM delay-power library
## The unit for wireload is pF as defined in the IBM delay-power library
## MS 2015
###################################################################### 

# Setting variables 
set clk_period 520
set clk_uncertainty 0.01
set clk_transition 0.010
set typical_input_delay 0.05
set typical_output_delay 0.05
set typical_wire_load 0.005

create_clock -name "clk" -period 99840 [get_ports "clk"]
set_drive 0 [get_clocks "clk"]
create_clock -name "fast_clk" -period 520 [get_ports "fast_clk"]
set_drive 0 [get_clocks "fast_clk"]

# Create real clocks if clock ports are found
#if {[sizeof_collection [get_ports clk]] > 0} {
#    set clk_name "clk"
#    set clk_port "clk"
#    create_clock -name $clk_name -period $clk_period [get_ports $clk_port]
#   set_drive 0 [get_clocks $clk_name]
#}

#if {[sizeof_collection [get_ports fast_clk]] > 0} {
#    set fast_clk_name "fast_clk"
#    set fast_clk_port "fast_clk"
#    create_clock -name $fast_clk_name -period $fast_clk_period [get_ports $fast_clk_port]
#    set_drive 0 [get_clocks $fast_clk_name]
#}

# Set clock uncertainties
set_clock_uncertainty $clk_uncertainty [all_clocks]


# Propagated clock used for gated clocks only
set_clock_transition $clk_transition [all_clocks]


# Configure the clock network
#set_fix_hold [all_clocks]
#set_dont_touch_network $clk_port
#set_ideal_network $clk_port
#set_dont_touch_network $fast_clk_port
#set_ideal_network $fast_clk_port

# Set input and output delays
set_driving_cell -lib_cell INVX1TS [all_inputs]
set_input_delay $typical_input_delay [all_inputs] -clock "clk"
remove_input_delay -clock "clk" [find port "fast_clk"]
remove_input_delay -clock "fast_clk" [find port "clk"]
set_output_delay $typical_output_delay [all_outputs] -clock "clk"


# Set loading of outputs
set_load 0.05 [all_outputs]




