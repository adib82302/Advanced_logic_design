onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_tb/clk
add wave -noupdate /fifo_tb/fast_clk
add wave -noupdate /fifo_tb/write_reset
add wave -noupdate /fifo_tb/read_reset
add wave -noupdate -radix hex /fifo_tb/write_data
add wave -noupdate -radix hex /fifo_tb/read_data
add wave -noupdate /fifo_tb/write_enable
add wave -noupdate /fifo_tb/read_enable
add wave -noupdate -radix hex /fifo_tb/fifo_out
add wave -noupdate /fifo_tb/full_flag
add wave -noupdate /fifo_tb/empty_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ns} {12 ns}


