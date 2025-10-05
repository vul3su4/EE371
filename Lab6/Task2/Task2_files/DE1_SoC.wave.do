onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -label {RST: SW[9]} {/DE1_SoC_testbench/SW[9]}
add wave -noupdate -label Arrival /DE1_SoC_testbench/arrival
add wave -noupdate -label Car_in /DE1_SoC_testbench/dut/top/Car_in
add wave -noupdate -label KEY -radix binary -radixshowbase 0 /DE1_SoC_testbench/KEY
add wave -noupdate -label Prs -radix binary -radixshowbase 0 /DE1_SoC_testbench/dut/top/Prs
add wave -noupdate -label Peff -radix binary -radixshowbase 0 /DE1_SoC_testbench/dut/top/K1/m1/Peff
add wave -noupdate -label B1 /DE1_SoC_testbench/dut/top/K1/m1/m4/B1
add wave -noupdate -label B2 /DE1_SoC_testbench/dut/top/K1/m1/m4/B2
add wave -noupdate -label B3 /DE1_SoC_testbench/dut/top/K1/m1/m4/B3
add wave -noupdate -color Violet -itemcolor Violet -label P1 /DE1_SoC_testbench/dut/top/K1/P1
add wave -noupdate -color Violet -itemcolor Violet -label P2 /DE1_SoC_testbench/dut/top/K1/P2
add wave -noupdate -color Violet -itemcolor Violet -label Entrance /DE1_SoC_testbench/dut/top/Entrance
add wave -noupdate -color Violet -itemcolor Violet -label inc /DE1_SoC_testbench/dut/top/K1/m2/inc
add wave -noupdate -label Departure /DE1_SoC_testbench/departure
add wave -noupdate -label Exit /DE1_SoC_testbench/dut/top/Exit
add wave -noupdate -label Car_out /DE1_SoC_testbench/dut/top/Car_out
add wave -noupdate -color Gold -itemcolor Gold -label Car_out_eff -radix binary -radixshowbase 0 /DE1_SoC_testbench/dut/top/K1/Car_out_eff
add wave -noupdate -color Gold -itemcolor Gold -label dec /DE1_SoC_testbench/dut/top/K1/m2/dec
add wave -noupdate -label count -radix unsigned -radixshowbase 0 /DE1_SoC_testbench/dut/top/count
add wave -noupdate -label HEX5 /DE1_SoC_testbench/HEX5
add wave -noupdate -label HEX4 /DE1_SoC_testbench/HEX4
add wave -noupdate -label HEX3 /DE1_SoC_testbench/HEX3
add wave -noupdate -label HEX2 /DE1_SoC_testbench/HEX2
add wave -noupdate -label HEX1 /DE1_SoC_testbench/HEX1
add wave -noupdate -label HEX0 /DE1_SoC_testbench/HEX0
add wave -noupdate -label V_GPIO /DE1_SoC_testbench/V_GPIO
add wave -noupdate -label ps /DE1_SoC_testbench/dut/top/K1/m1/m4/ps
add wave -noupdate -label ns /DE1_SoC_testbench/dut/top/K1/m1/m4/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 109
configure wave -valuecolwidth 48
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
WaveRestoreZoom {0 ns} {3096 ns}
