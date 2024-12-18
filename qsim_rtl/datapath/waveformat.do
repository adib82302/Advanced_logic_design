# waveformat.do for datapath simulation with decimal formatting

onerror {resume}
quietly WaveActivateNextPane {} 0

# Add clocks
add wave -noupdate /test_datapath/clk
add wave -noupdate /test_datapath/fast_clk

# Add control signals
add wave -noupdate /test_datapath/reset
add wave -noupdate /test_datapath/write_enable
add wave -noupdate /test_datapath/read_enable
add wave -noupdate /test_datapath/shift_enable
add wave -noupdate /test_datapath/cen
add wave -noupdate /test_datapath/wen

# Add input and output data signals
add wave -noupdate -radix unsigned /test_datapath/input_data
add wave -noupdate -radix unsigned /test_datapath/cmem_data_in
add wave -noupdate -radix unsigned /test_datapath/result
add wave -noupdate /test_datapath/fifo_empty
add wave -noupdate /test_datapath/fifo_full
add wave -noupdate /test_datapath/done

# Add FIFO signals
add wave -noupdate -radix unsigned /test_datapath/uut/fifo_inst/read_data
add wave -noupdate /test_datapath/uut/fifo_inst/empty_flag
add wave -noupdate /test_datapath/uut/fifo_inst/full_flag

# Add converter signals
add wave -noupdate -radix unsigned /test_datapath/uut/converter_inst/fixed_in
add wave -noupdate -radix unsigned /test_datapath/uut/converter_inst/float_out

# Add IMEM signals
add wave -noupdate -radix unsigned /test_datapath/uut/imem_inst/data_out

# Add ALU MAC signals
add wave -noupdate -radix unsigned /test_datapath/uut/alu_mac_inst/d
add wave -noupdate -radix unsigned /test_datapath/uut/alu_mac_inst/cmem
add wave -noupdate -radix unsigned /test_datapath/uut/alu_mac_inst/tap_index
add wave -noupdate -radix unsigned /test_datapath/uut/alu_mac_inst/sum
add wave -noupdate -radix unsigned /test_datapath/uut/alu_mac_inst/out
add wave -noupdate /test_datapath/uut/alu_mac_inst/done

# Update the waveform
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {50 ns}

