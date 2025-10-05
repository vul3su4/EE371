onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /parkinglot_ctrl_testbench/clock
add wave -noupdate -label reset /parkinglot_ctrl_testbench/reset
add wave -noupdate -label start /parkinglot_ctrl_testbench/start
add wave -noupdate -label KEY0 /parkinglot_ctrl_testbench/KEY0
add wave -noupdate -color Gold -itemcolor Gold -label full /parkinglot_ctrl_testbench/full
add wave -noupdate -color Violet -itemcolor Violet -label empty /parkinglot_ctrl_testbench/empty
add wave -noupdate -label hour_7 /parkinglot_ctrl_testbench/hour_7
add wave -noupdate -label hour_inc /parkinglot_ctrl_testbench/hour_inc
add wave -noupdate -label wr /parkinglot_ctrl_testbench/wr
add wave -noupdate -color Gold -itemcolor Gold -label RH_start /parkinglot_ctrl_testbench/RH_start
add wave -noupdate -color Violet -itemcolor Violet -label RH_end /parkinglot_ctrl_testbench/RH_end
add wave -noupdate -color Cyan -itemcolor Cyan -label show /parkinglot_ctrl_testbench/show
add wave -noupdate -label ps /parkinglot_ctrl_testbench/dut/ps
add wave -noupdate -label ns /parkinglot_ctrl_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {366 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 92
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {2392 ps}
