onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clok /top_datapath_testbench/clock
add wave -noupdate -label reset /top_datapath_testbench/reset
add wave -noupdate -label Prs -radix binary -radixshowbase 0 /top_datapath_testbench/Prs
add wave -noupdate -label Car_in /top_datapath_testbench/Car_in
add wave -noupdate -label Car_out /top_datapath_testbench/Car_out
add wave -noupdate -label hour_inc /top_datapath_testbench/hour_inc
add wave -noupdate -label wr /top_datapath_testbench/wr
add wave -noupdate -label RH_start /top_datapath_testbench/RH_start
add wave -noupdate -label HEX3 -radix hexadecimal /top_datapath_testbench/HEX3
add wave -noupdate -label RH_end /top_datapath_testbench/RH_end
add wave -noupdate -label HEX4 -radix hexadecimal /top_datapath_testbench/HEX4
add wave -noupdate -label RH_flag /top_datapath_testbench/RH_flag
add wave -noupdate -label show /top_datapath_testbench/show
add wave -noupdate -label Entrance /top_datapath_testbench/Entrance
add wave -noupdate -label Exit /top_datapath_testbench/Exit
add wave -noupdate -label count -radix unsigned /top_datapath_testbench/dut/count
add wave -noupdate -label remaining -radix unsigned /top_datapath_testbench/dut/parkinglot/remaining
add wave -noupdate -label HEX0 -radix hexadecimal /top_datapath_testbench/HEX0
add wave -noupdate -label full /top_datapath_testbench/full
add wave -noupdate -label empty /top_datapath_testbench/empty
add wave -noupdate -label hour_7 /top_datapath_testbench/hour_7
add wave -noupdate -color Gold -itemcolor Gold -label hour -radix unsigned /top_datapath_testbench/dut/parkinglot/hour
add wave -noupdate -label HEX5 -radix hexadecimal /top_datapath_testbench/HEX5
add wave -noupdate -label car_acc -radix unsigned -radixshowbase 0 /top_datapath_testbench/dut/car_acc
add wave -noupdate -color Gold -itemcolor Gold -label count_updw -radix unsigned /top_datapath_testbench/dut/c1/count_updw
add wave -noupdate -label HEX2 -radix hexadecimal /top_datapath_testbench/HEX2
add wave -noupdate -label hour_car -radix unsigned /top_datapath_testbench/dut/m1/q
add wave -noupdate -label HEX1 -radix hexadecimal /top_datapath_testbench/HEX1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6823 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 113
configure wave -valuecolwidth 41
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 10
configure wave -gridperiod 20
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5550 ps}
