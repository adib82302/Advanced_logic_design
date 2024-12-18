###################################################################

# Created by write_sdc on Wed Dec  4 12:27:41 2024

###################################################################
set sdc_version 1.7

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_fanout 4 [current_design]
set_max_area 0
set_driving_cell -lib_cell INVX1TS [get_ports clk]
set_driving_cell -lib_cell INVX1TS [get_ports write_reset]
set_driving_cell -lib_cell INVX1TS [get_ports write_enable]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[7]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[6]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[5]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[4]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[3]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[2]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[1]}]
set_driving_cell -lib_cell INVX1TS [get_ports {write_data[0]}]
set_driving_cell -lib_cell INVX1TS [get_ports fast_clk]
set_driving_cell -lib_cell INVX1TS [get_ports read_reset]
set_driving_cell -lib_cell INVX1TS [get_ports read_enable]
set_load -pin_load 0.05 [get_ports {read_data[7]}]
set_load -pin_load 0.05 [get_ports {read_data[6]}]
set_load -pin_load 0.05 [get_ports {read_data[5]}]
set_load -pin_load 0.05 [get_ports {read_data[4]}]
set_load -pin_load 0.05 [get_ports {read_data[3]}]
set_load -pin_load 0.05 [get_ports {read_data[2]}]
set_load -pin_load 0.05 [get_ports {read_data[1]}]
set_load -pin_load 0.05 [get_ports {read_data[0]}]
set_load -pin_load 0.05 [get_ports empty_flag]
set_load -pin_load 0.05 [get_ports full_flag]
set_max_capacitance 0.005 [get_ports clk]
set_max_capacitance 0.005 [get_ports write_reset]
set_max_capacitance 0.005 [get_ports write_enable]
set_max_capacitance 0.005 [get_ports {write_data[7]}]
set_max_capacitance 0.005 [get_ports {write_data[6]}]
set_max_capacitance 0.005 [get_ports {write_data[5]}]
set_max_capacitance 0.005 [get_ports {write_data[4]}]
set_max_capacitance 0.005 [get_ports {write_data[3]}]
set_max_capacitance 0.005 [get_ports {write_data[2]}]
set_max_capacitance 0.005 [get_ports {write_data[1]}]
set_max_capacitance 0.005 [get_ports {write_data[0]}]
set_max_capacitance 0.005 [get_ports fast_clk]
set_max_capacitance 0.005 [get_ports read_reset]
set_max_capacitance 0.005 [get_ports read_enable]
set_max_fanout 4 [get_ports clk]
set_max_fanout 4 [get_ports write_reset]
set_max_fanout 4 [get_ports write_enable]
set_max_fanout 4 [get_ports {write_data[7]}]
set_max_fanout 4 [get_ports {write_data[6]}]
set_max_fanout 4 [get_ports {write_data[5]}]
set_max_fanout 4 [get_ports {write_data[4]}]
set_max_fanout 4 [get_ports {write_data[3]}]
set_max_fanout 4 [get_ports {write_data[2]}]
set_max_fanout 4 [get_ports {write_data[1]}]
set_max_fanout 4 [get_ports {write_data[0]}]
set_max_fanout 4 [get_ports fast_clk]
set_max_fanout 4 [get_ports read_reset]
set_max_fanout 4 [get_ports read_enable]
create_clock [get_ports clk]  -period 99840  -waveform {0 49920}
set_clock_uncertainty 0.01  [get_clocks clk]
set_clock_transition -max -rise 0.01 [get_clocks clk]
set_clock_transition -max -fall 0.01 [get_clocks clk]
set_clock_transition -min -rise 0.01 [get_clocks clk]
set_clock_transition -min -fall 0.01 [get_clocks clk]
create_clock [get_ports fast_clk]  -period 520  -waveform {0 260}
set_clock_uncertainty 0.01  [get_clocks fast_clk]
set_clock_transition -max -rise 0.01 [get_clocks fast_clk]
set_clock_transition -max -fall 0.01 [get_clocks fast_clk]
set_clock_transition -min -rise 0.01 [get_clocks fast_clk]
set_clock_transition -min -fall 0.01 [get_clocks fast_clk]
set_input_delay -clock clk  0.05  [get_ports clk]
set_input_delay -clock clk  0.05  [get_ports write_reset]
set_input_delay -clock clk  0.05  [get_ports write_enable]
set_input_delay -clock clk  0.05  [get_ports {write_data[7]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[6]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[5]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[4]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[3]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[2]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[1]}]
set_input_delay -clock clk  0.05  [get_ports {write_data[0]}]
set_input_delay -clock clk  0.05  [get_ports read_reset]
set_input_delay -clock clk  0.05  [get_ports read_enable]
set_output_delay -clock clk  0.05  [get_ports {read_data[7]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[6]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[5]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[4]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[3]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[2]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[1]}]
set_output_delay -clock clk  0.05  [get_ports {read_data[0]}]
set_output_delay -clock clk  0.05  [get_ports empty_flag]
set_output_delay -clock clk  0.05  [get_ports full_flag]