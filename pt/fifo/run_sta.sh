#pt_shell -file fifo.tcl > fifo.log &
pt_shell -file fifo.tcl | tee fifo.log
