######################################################################
## Timing setup for logic synthesis
## The unit for time is ns as defined in the IBM delay-power library
## The unit for wireload is pF as defined in the IBM delay-power library
######################################################################

# Set variables
set clk_period_input 100000   # 10 kHz input clock period (in ns)
set clk_period_fast 10     # 100 MHz fast clock period (in ns)
set clk_uncertainty 0.1       # Clock uncertainty (in ns)
set clk_transition 0.1        # Clock transition time (in ns)
set typical_input_delay 1.0   # Input delay (in ns)
set typical_output_delay 1.0  # Output delay (in ns)
set typical_wire_load 0.005   # Wire load (in pF)

# Create clocks
create_clock -name "clk" -period $clk_period_input [get_ports "clk"]         # 10 kHz clock
create_clock -name "fast_clk" -period $clk_period_fast [get_ports "fast_clk"] # 300 MHz clock

# Set clock uncertainties
set_clock_uncertainty $clk_uncertainty [all_clocks]

# Propagated clock used for gated clocks only
set_clock_transition $clk_transition [all_clocks]

# Set input and output delays
set_input_delay $typical_input_delay [all_inputs] -clock "clk"
set_output_delay $typical_output_delay [all_outputs] -clock "fast_clk"

# Set loading for outputs
set_load 0.05 [all_outputs]

# Set max capacitance and fanout
set_max_capacitance 0.005 [all_inputs]
set_max_fanout 4 [all_inputs]
set_max_fanout 4 [all_outputs]

# Specify driving cells for inputs
set_driving_cell -lib_cell INVX1TS [all_inputs]

# Preserve hierarchy and critical components
set_dont_touch [get_cells -hierarchical datapath_inst/imem_inst/memory_reg*]  # Preserve memory_reg
set_dont_touch [get_cells -hierarchical datapath_inst/imem_inst]              # Preserve imem_inst
set_dont_touch [get_cells -hierarchical datapath_inst]                        # Preserve datapath_inst

# Apply design constraints
set_max_area 0
set_fix_multiple_port_nets -all -buffer_constants

