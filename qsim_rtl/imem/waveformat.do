onerror {resume}
quietly WaveActivateNextPane {} 0

# Clock and Reset Signals
add wave -noupdate /test_imem/clk
add wave -noupdate /test_imem/rst

# Control Signals
add wave -noupdate /test_imem/shift_enable

# Input Signals
add wave -noupdate -radix hex /test_imem/new_value
add wave -noupdate -radix unsigned /test_imem/addr

# Output Signals
add wave -noupdate -radix hex /test_imem/data_out

# Memory Array (if visualization is supported)
add wave -noupdate -radix hex /test_imem/uut/memory

# Configure Waveform Layout
configure wave -namecolwidth 200
configure wave -valuecolwidth 80
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -timelineunits ns
WaveRestoreZoom {0 ns} {500 ns}

update

