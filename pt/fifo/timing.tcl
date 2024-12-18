###################################################################### 
## Timing setup for logic synthesis
## The unit for time is ns as defined in the IBM delay-power library
## The unit for wireload is pF as defined in the IBM delay-power library
## MS 2015
###################################################################### 

# Setting variables 
set clk_period 100000        ;# 10 kHz
set fast_clk_period 520      ;# Assumed based on original file
set clk_uncertainty 0.01
set clk_transition 0.010
set typical_input_delay 0.05
set typical_output_delay 0.05
set typical_wire_load 0.005

# Define clocks
create_clock -name "clk" -period $clk_period [get_ports "clk"]
create_clock -name "fast_clk" -period $fast_clk_period [get_ports "fast_clk"]

# Set clock uncertainties
set_clock_uncertainty $clk_uncertainty [all_clocks]

# Set clock transitions
set_clock_transition $clk_transition [all_clocks]

# Driving cell for inputs
set_driving_cell -lib_cell INVX1TS [all_inputs]

# Remove inappropriate input delays on clock ports
remove_input_delay -clock "clk" [get_ports "clk"]
remove_input_delay -clock "fast_clk" [get_ports "fast_clk"]

# Set input delays on data ports
set_input_delay $typical_input_delay [all_inputs] -clock "clk"

# Set output delays
set_output_delay $typical_output_delay [all_outputs] -clock "clk"

# Set loading of outputs
set_load 0.05 [all_outputs]

# Ensure clocks are not incorrectly touched
set_dont_touch_network [get_ports clk]
set_dont_touch_network [get_ports fast_clk]





