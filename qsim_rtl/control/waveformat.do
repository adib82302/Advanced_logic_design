# waveformat.do for test_control
onerror {resume}
quietly WaveActivateNextPane {} 0

# Add DUT and top-level signals
add wave -noupdate /test_control/clk
add wave -noupdate /test_control/fast_clk
add wave -noupdate /test_control/reset
add wave -noupdate /test_control/fifo_full
add wave -noupdate /test_control/fifo_empty
add wave -noupdate /test_control/mac_done

# Add outputs
add wave -noupdate /test_control/write_enable
add wave -noupdate /test_control/read_enable
add wave -noupdate /test_control/shift_enable
add wave -noupdate /test_control/start_mac
add wave -noupdate /test_control/done

# Update waveform view
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
update
WaveRestoreZoom {0 ns} {500 ns}

