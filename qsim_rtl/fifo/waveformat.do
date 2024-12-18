# Clear previous wave configuration
quietly wave clear

# Add the top-level module signals to the waveform
add wave -position insertpoint \
    sim:/test_top_module/clk \
    sim:/test_top_module/fast_clk \
    sim:/test_top_module/reset \
    sim:/test_top_module/start \
    sim:/test_top_module/input_data \
    sim:/test_top_module/cmem_data_in \
    sim:/test_top_module/result \
    sim:/test_top_module/done

# Add signals from the instantiated top module (uut)
add wave -position insertpoint \
    sim:/test_top_module/uut/clk \
    sim:/test_top_module/uut/fast_clk \
    sim:/test_top_module/uut/reset \
    sim:/test_top_module/uut/start \
    sim:/test_top_module/uut/input_data \
    sim:/test_top_module/uut/cmem_data_in \
    sim:/test_top_module/uut/result \
    sim:/test_top_module/uut/done

# Set the time resolution for the waveform
tree time -timeunits ps -timescale 1ps

# Group related signals
group -name "Top-Level Signals" -wave sim:/test_top_module/*
group -name "Internal Signals (uut)" -wave sim:/test_top_module/uut/*

# Zoom to the full simulation timeline
wave zoom full

