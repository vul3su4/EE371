onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /top_ctrl_datapath_testbench/clock
add wave -noupdate -label reset /top_ctrl_datapath_testbench/reset
add wave -noupdate -color Gold -itemcolor Gold -label start /top_ctrl_datapath_testbench/start
add wave -noupdate -label KEY0 /top_ctrl_datapath_testbench/KEY0
add wave -noupdate -label Car_in /top_ctrl_datapath_testbench/Car_in
add wave -noupdate -label Car_out /top_ctrl_datapath_testbench/Car_out
add wave -noupdate -label Car_out_eff /top_ctrl_datapath_testbench/dut/datapath/passcode/Car_out_eff
add wave -noupdate -color Orange -itemcolor Orange -label Entrance /top_ctrl_datapath_testbench/Entrance
add wave -noupdate -color Cyan -itemcolor Cyan -label Exit /top_ctrl_datapath_testbench/Exit
add wave -noupdate -color Orange -itemcolor Orange -label full /top_ctrl_datapath_testbench/dut/full
add wave -noupdate -color Orange -itemcolor Orange -label RH_start /top_ctrl_datapath_testbench/dut/RH_start
add wave -noupdate -color Orange -itemcolor Orange -label HEX3 -radix hexadecimal /top_ctrl_datapath_testbench/HEX3
add wave -noupdate -color Violet -itemcolor Violet -label HEX2 -radix hexadecimal /top_ctrl_datapath_testbench/HEX2
add wave -noupdate -color Violet -itemcolor Violet -label HEX1 -radix hexadecimal /top_ctrl_datapath_testbench/HEX1
add wave -noupdate -color Violet -itemcolor Violet -label HEX0 -radix hexadecimal /top_ctrl_datapath_testbench/HEX0
add wave -noupdate -label count -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/count
add wave -noupdate -label remaining -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/parkinglot/remaining
add wave -noupdate -color Cyan -itemcolor Cyan -label empty /top_ctrl_datapath_testbench/dut/empty
add wave -noupdate -color Cyan -itemcolor Cyan -label RH_end /top_ctrl_datapath_testbench/dut/RH_end
add wave -noupdate -color Cyan -itemcolor Cyan -label HEX4 -radix hexadecimal /top_ctrl_datapath_testbench/HEX4
add wave -noupdate -color Pink -itemcolor Pink -label wr /top_ctrl_datapath_testbench/dut/wr
add wave -noupdate -color Gold -itemcolor Gold -label show /top_ctrl_datapath_testbench/dut/show
add wave -noupdate -label hour_7 /top_ctrl_datapath_testbench/dut/hour_7
add wave -noupdate -label hour_inc /top_ctrl_datapath_testbench/dut/hour_inc
add wave -noupdate -label HEX5 -radix hexadecimal /top_ctrl_datapath_testbench/HEX5
add wave -noupdate -color Magenta -itemcolor Magenta -label hour -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/hour
add wave -noupdate -color Gold -itemcolor Gold -label car_acc -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/car_acc
add wave -noupdate -label count_updw -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/count_updw
add wave -noupdate -color Gold -itemcolor Gold -label hour_car -radix unsigned /top_ctrl_datapath_testbench/dut/datapath/hour_car
add wave -noupdate -label ps /top_ctrl_datapath_testbench/dut/ctrl/ps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {810 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 110
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {18264 ps}
