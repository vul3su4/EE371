onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /parkinglot_datapath_testbench/clock
add wave -noupdate -label reset /parkinglot_datapath_testbench/reset
add wave -noupdate -label hour_inc /parkinglot_datapath_testbench/hour_inc
add wave -noupdate -label hour -radix unsigned -radixshowbase 0 /parkinglot_datapath_testbench/dut/hour
add wave -noupdate -label hour_7 /parkinglot_datapath_testbench/hour_7
add wave -noupdate -label wr /parkinglot_datapath_testbench/wr
add wave -noupdate -label wren /parkinglot_datapath_testbench/dut/wren
add wave -noupdate -label RH_start /parkinglot_datapath_testbench/RH_start
add wave -noupdate -label RH_end /parkinglot_datapath_testbench/RH_end
add wave -noupdate -label RH_flag /parkinglot_datapath_testbench/RH_flag
add wave -noupdate -label rush_hour_flag /parkinglot_datapath_testbench/dut/rush_hour_flag
add wave -noupdate -color Gold -itemcolor Gold -label rush_hour_start -radix unsigned -radixshowbase 0 /parkinglot_datapath_testbench/dut/rush_hour_start
add wave -noupdate -color Gold -itemcolor Gold -label HEX3 /parkinglot_datapath_testbench/HEX3
add wave -noupdate -color Salmon -itemcolor Salmon -label rush_hour_end -radix unsigned -radixshowbase 0 /parkinglot_datapath_testbench/dut/rush_hour_end
add wave -noupdate -color Salmon -itemcolor Salmon -label HEX4 /parkinglot_datapath_testbench/HEX4
add wave -noupdate -label show /parkinglot_datapath_testbench/show
add wave -noupdate -label full /parkinglot_datapath_testbench/full
add wave -noupdate -label empty /parkinglot_datapath_testbench/empty
add wave -noupdate -label HEX5 /parkinglot_datapath_testbench/HEX5
add wave -noupdate -color Violet -itemcolor Plum -label cout_updw -radix unsigned -radixshowbase 0 /parkinglot_datapath_testbench/dut/count_updw
add wave -noupdate -color Violet -itemcolor Violet -label HEX2 /parkinglot_datapath_testbench/HEX2
add wave -noupdate -label HEX1 /parkinglot_datapath_testbench/HEX1
add wave -noupdate -label HEX0 /parkinglot_datapath_testbench/HEX0
add wave -noupdate -label car_acc /parkinglot_datapath_testbench/dut/car_acc
add wave -noupdate -label hour_car /parkinglot_datapath_testbench/dut/hour_car
add wave -noupdate -label remaining /parkinglot_datapath_testbench/dut/remaining
add wave -noupdate -label HEX5_mux /parkinglot_datapath_testbench/dut/HEX5_mux
add wave -noupdate -label HEX4_mux /parkinglot_datapath_testbench/dut/HEX4_mux
add wave -noupdate -label HEX3_mux /parkinglot_datapath_testbench/dut/HEX3_mux
add wave -noupdate -label HEX2_mux /parkinglot_datapath_testbench/dut/HEX2_mux
add wave -noupdate -label HEX1_mux /parkinglot_datapath_testbench/dut/HEX1_mux
add wave -noupdate -label HEX0_mux /parkinglot_datapath_testbench/dut/HEX0_mux
add wave -noupdate -label remaining /parkinglot_datapath_testbench/dut/remaining
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7598 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 125
configure wave -valuecolwidth 53
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
WaveRestoreZoom {6735 ps} {8461 ps}
