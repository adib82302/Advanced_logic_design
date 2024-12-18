add wave -noupdate /test_imem/clk
add wave -noupdate /test_imem/rst
add wave -noupdate /test_imem/shift_enable
add wave -noupdate -radix hex /test_imem/new_value
add wave -noupdate -radix hex /test_imem/data_out
add wave -noupdate -radix hex /test_imem/uut/memory[0]
add wave -noupdate -radix hex /test_imem/uut/memory[1]
add wave -noupdate -radix hex /test_imem/uut/memory[2]
add wave -noupdate -radix hex /test_imem/uut/memory[3]
TreeUpdate [SetDefaultTree]

