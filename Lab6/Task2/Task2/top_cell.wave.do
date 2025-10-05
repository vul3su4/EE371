onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /top_cell_testbench/CLK
add wave -noupdate -label RST /top_cell_testbench/RST
add wave -noupdate -label Car_in /top_cell_testbench/Car_in
add wave -noupdate -color Violet -itemcolor Violet -label Entrance /top_cell_testbench/Entrance
add wave -noupdate -label Car_out /top_cell_testbench/Car_out
add wave -noupdate -color Gold -itemcolor Gold -label Car_out_eff /top_cell_testbench/dut/K1/Car_out_eff
add wave -noupdate -label Exit /top_cell_testbench/Exit
add wave -noupdate -label Prs -radix binary -radixshowbase 0 /top_cell_testbench/Prs
add wave -noupdate -label Peff -radix binary -radixshowbase 0 /top_cell_testbench/dut/K1/m1/Peff
add wave -noupdate -label B1 /top_cell_testbench/dut/K1/m1/m4/B1
add wave -noupdate -label B2 /top_cell_testbench/dut/K1/m1/m4/B2
add wave -noupdate -label B3 /top_cell_testbench/dut/K1/m1/m4/B3
add wave -noupdate -color Violet -label P1 /top_cell_testbench/dut/K1/m1/m4/P1
add wave -noupdate -color Violet -itemcolor Violet -label P2 /top_cell_testbench/dut/K1/m1/m4/P2
add wave -noupdate -color Violet -itemcolor Violet -label inc /top_cell_testbench/dut/K1/m2/inc
add wave -noupdate -color Gold -itemcolor Gold -label dec /top_cell_testbench/dut/K1/m2/dec
add wave -noupdate -label count -radix unsigned -radixshowbase 0 /top_cell_testbench/dut/count
add wave -noupdate -label HEX5 /top_cell_testbench/HEX5
add wave -noupdate -label HEX4 /top_cell_testbench/HEX4
add wave -noupdate -label HEX3 /top_cell_testbench/HEX3
add wave -noupdate -label HEX2 /top_cell_testbench/HEX2
add wave -noupdate -label HEX1 /top_cell_testbench/HEX1
add wave -noupdate -label HEX0 /top_cell_testbench/HEX0
add wave -noupdate -label ps /top_cell_testbench/dut/K1/m1/m4/ps
add wave -noupdate -label ns /top_cell_testbench/dut/K1/m1/m4/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 106
configure wave -valuecolwidth 44
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
WaveRestoreZoom {0 ns} {2909 ns}
