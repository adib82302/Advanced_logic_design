onerror {resume}
quietly WaveActivateNextPane {} 0

# Clock and Reset
add wave -noupdate /test_cmem/clk
add wave -noupdate /test_cmem/rst

# Control Signals
add wave -noupdate /test_cmem/cen
add wave -noupdate /test_cmem/wen

# Address and Data Signals
add wave -noupdate -radix unsigned /test_cmem/addr
add wave -noupdate -radix hex /test_cmem/data_in
add wave -noupdate -radix hex /test_cmem/data_out

# Expected Data
add wave -noupdate -radix hex /test_cmem/expected_data

# Waveform Settings
configure wave -namecolwidth 200
configure wave -valuecolwidth 80
configure wave -justifyvalue left
WaveRestoreZoom {0 ns} {2000 ns}
update

