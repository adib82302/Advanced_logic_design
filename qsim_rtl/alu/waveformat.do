# waveformat.do for alu_mac
onerror {resume}
quietly WaveActivateNextPane {} 0

# Add top-level signals
add wave -noupdate /test_alu/clk
add wave -noupdate /test_alu/reset
add wave -noupdate /test_alu/d
add wave -noupdate /test_alu/cmem
add wave -noupdate /test_alu/out
add wave -noupdate /test_alu/done

# Expand signals within the uut (Unit Under Test)
add wave -noupdate /test_alu/uut/tap_index
add wave -noupdate /test_alu/uut/sum
add wave -noupdate /test_alu/uut/product
add wave -noupdate /test_alu/uut/d_element
add wave -noupdate /test_alu/uut/cmem_element

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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {500 ns}

