# waveformat.do for test_converter

onerror {resume}
quietly WaveActivateNextPane {} 0

# Add signals to the waveform
add wave -noupdate /test_converter/fixed_in
add wave -noupdate /test_converter/float_out

# Expand the `convertor` instance signals
add wave -noupdate /test_converter/uut/sign
add wave -noupdate /test_converter/uut/exponent
add wave -noupdate /test_converter/uut/mantissa
add wave -noupdate /test_converter/uut/magnitude
add wave -noupdate /test_converter/uut.leading_one

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
WaveRestoreZoom {0 ns} {50 ns}

