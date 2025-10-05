onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -label {SW[9]:reset} {/DE1_SoC_testbench/SW[9]}
add wave -noupdate -color Gold -itemcolor Gold -label {SW[8]:start} {/DE1_SoC_testbench/SW[8]}
add wave -noupdate -label {KEY[0]} {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate -label Car_in /DE1_SoC_testbench/Car_in
add wave -noupdate -label Car_in_eff /DE1_SoC_testbench/dut/top/datapath/simple/Car_in_eff
add wave -noupdate -label Car_out /DE1_SoC_testbench/Car_out
add wave -noupdate -label Car_out_eff /DE1_SoC_testbench/dut/top/datapath/simple/Car_out_eff
add wave -noupdate -color Orange -itemcolor Orange -label Entrance /DE1_SoC_testbench/dut/top/datapath/Entrance
add wave -noupdate -color Cyan -itemcolor Cyan -label Exit /DE1_SoC_testbench/dut/top/datapath/Exit
add wave -noupdate -color Orange -itemcolor Orange -label full /DE1_SoC_testbench/dut/top/ctrl/full
add wave -noupdate -color Orange -itemcolor Orange -label RH_start /DE1_SoC_testbench/dut/top/ctrl/RH_start
add wave -noupdate -color Orange -itemcolor Orange -label HEX3 -radix hexadecimal /DE1_SoC_testbench/HEX3
add wave -noupdate -color Violet -itemcolor Violet -label HEX2 -radix hexadecimal /DE1_SoC_testbench/HEX2
add wave -noupdate -color Violet -itemcolor Violet -label HEX1 -radix hexadecimal /DE1_SoC_testbench/HEX1
add wave -noupdate -color Violet -itemcolor Violet -label HEX0 -radix hexadecimal /DE1_SoC_testbench/HEX0
add wave -noupdate -label count -radix unsigned /DE1_SoC_testbench/dut/top/datapath/count
add wave -noupdate -label remaining -radix unsigned /DE1_SoC_testbench/dut/top/datapath/parkinglot/remaining
add wave -noupdate -color Cyan -itemcolor Cyan -label empty /DE1_SoC_testbench/dut/top/ctrl/empty
add wave -noupdate -color Cyan -itemcolor Cyan -label RH_end /DE1_SoC_testbench/dut/top/ctrl/RH_end
add wave -noupdate -color Cyan -itemcolor Cyan -label HEX4 -radix hexadecimal /DE1_SoC_testbench/HEX4
add wave -noupdate -color Plum -itemcolor Plum -label wr /DE1_SoC_testbench/dut/top/ctrl/wr
add wave -noupdate -color Gold -itemcolor Gold -label show /DE1_SoC_testbench/dut/top/ctrl/show
add wave -noupdate -label hour_7 /DE1_SoC_testbench/dut/top/datapath/parkinglot/hour_7
add wave -noupdate -label hour_inc /DE1_SoC_testbench/dut/top/ctrl/hour_inc
add wave -noupdate -label HEX5 -radix hexadecimal /DE1_SoC_testbench/HEX5
add wave -noupdate -color Magenta -itemcolor Magenta -label hour -radix unsigned /DE1_SoC_testbench/dut/top/datapath/hour
add wave -noupdate -color Gold -itemcolor Gold -label car_acc -radix unsigned /DE1_SoC_testbench/dut/top/datapath/car_acc
add wave -noupdate -label count_updw -radix unsigned /DE1_SoC_testbench/dut/top/datapath/count_updw
add wave -noupdate -color Gold -itemcolor Gold -label hour_car -radix unsigned /DE1_SoC_testbench/dut/top/datapath/hour_car
add wave -noupdate -label ps /DE1_SoC_testbench/dut/top/ctrl/ps
add wave -noupdate -label {LEDR[4]} {/DE1_SoC_testbench/LEDR[4]}
add wave -noupdate -label {LEDR[3]} {/DE1_SoC_testbench/LEDR[3]}
add wave -noupdate -label {LEDR[2]} {/DE1_SoC_testbench/LEDR[2]}
add wave -noupdate -label {LEDR[1]} {/DE1_SoC_testbench/LEDR[1]}
add wave -noupdate -label {LEDR[0]} {/DE1_SoC_testbench/LEDR[0]}
add wave -noupdate -label V_GPIO /DE1_SoC_testbench/V_GPIO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 102
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {146108 ps}
