# waveformat.do for debugging FIR filter in top_module
onerror {resume}
quietly WaveActivateNextPane {} 0

# Top-level signals
add wave -noupdate /test_top_module/clk
add wave -noupdate /test_top_module/fast_clk
add wave -noupdate /test_top_module/reset
add wave -noupdate /test_top_module/input_data
add wave -noupdate /test_top_module/cmem_data_in
add wave -noupdate /test_top_module/result
add wave -noupdate /test_top_module/done

# Control module signals
add wave -noupdate /test_top_module/uut/control_inst/write_enable
add wave -noupdate /test_top_module/uut/control_inst/read_enable
add wave -noupdate /test_top_module/uut/control_inst/shift_enable
add wave -noupdate /test_top_module/uut/control_inst/start_mac
add wave -noupdate /test_top_module/uut/control_inst/done

# Datapath internal signals
add wave -noupdate /test_top_module/uut/datapath_inst/fifo_empty
add wave -noupdate /test_top_module/uut/datapath_inst/fifo_full
add wave -noupdate /test_top_module/uut/datapath_inst/fifo_inst/read_data
add wave -noupdate /test_top_module/uut/datapath_inst/imem_inst/data_out

# ALU MAC signals
add wave -noupdate /test_top_module/uut/datapath_inst/alu_mac_inst/sum
add wave -noupdate /test_top_module/uut/datapath_inst/alu_mac_inst/product
add wave -noupdate /test_top_module/uut/datapath_inst/alu_mac_inst/tap_index  ;# Include tap index
add wave -noupdate /test_top_module/uut/datapath_inst/alu_mac_inst/out

# Configure waveform display
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps

# Zoom and refresh
TreeUpdate [SetDefaultTree]
update
WaveRestoreZoom {0 ns} {5000 ns}

