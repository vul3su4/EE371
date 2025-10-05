onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /passcode_all__counter_testbench/CLK
add wave -noupdate -label RST /passcode_all__counter_testbench/RST
add wave -noupdate -label Car_in /passcode_all__counter_testbench/Car_in
add wave -noupdate -color Violet -itemcolor Violet -label Entrance /passcode_all__counter_testbench/Entrance
add wave -noupdate -label Car_out /passcode_all__counter_testbench/Car_out
add wave -noupdate -label Car_out_QD /passcode_all__counter_testbench/dut/Car_out_QD
add wave -noupdate -color Gold -itemcolor Gold -label Car_out_eff /passcode_all__counter_testbench/dut/Car_out_eff
add wave -noupdate -color Gold -itemcolor Gold -label Exit /passcode_all__counter_testbench/Exit
add wave -noupdate -label Prs -radix binary -radixshowbase 0 /passcode_all__counter_testbench/Prs
add wave -noupdate -label Peff -radix binary -radixshowbase 0 /passcode_all__counter_testbench/dut/m1/Peff
add wave -noupdate -label B1 /passcode_all__counter_testbench/dut/m1/m4/B1
add wave -noupdate -label B2 /passcode_all__counter_testbench/dut/m1/m4/B2
add wave -noupdate -label B3 /passcode_all__counter_testbench/dut/m1/m4/B3
add wave -noupdate -color Violet -itemcolor Violet -label P1 /passcode_all__counter_testbench/dut/m1/m4/P1
add wave -noupdate -color Violet -itemcolor Violet -label P2 /passcode_all__counter_testbench/dut/m1/m4/P2
add wave -noupdate -label inc /passcode_all__counter_testbench/dut/m2/inc
add wave -noupdate -label dec /passcode_all__counter_testbench/dut/m2/dec
add wave -noupdate -label count -radix unsigned -radixshowbase 0 /passcode_all__counter_testbench/count
add wave -noupdate -label ps /passcode_all__counter_testbench/dut/m1/m4/ps
add wave -noupdate -label ns /passcode_all__counter_testbench/dut/m1/m4/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {209 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 115
configure wave -valuecolwidth 42
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
WaveRestoreZoom {0 ns} {3392 ns}
