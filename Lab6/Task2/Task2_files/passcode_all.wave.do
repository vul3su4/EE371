onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /passcode_all_testbench/CLK
add wave -noupdate -label RST /passcode_all_testbench/RST
add wave -noupdate -label Prs -radix binary -radixshowbase 0 /passcode_all_testbench/Prs
add wave -noupdate -label QD -radix binary -radixshowbase 0 /passcode_all_testbench/dut/QD
add wave -noupdate -label Peff -radix binary -radixshowbase 0 /passcode_all_testbench/dut/Peff
add wave -noupdate -label B1 /passcode_all_testbench/dut/m4/B1
add wave -noupdate -label B2 /passcode_all_testbench/dut/m4/B2
add wave -noupdate -label B3 /passcode_all_testbench/dut/m4/B3
add wave -noupdate -color Violet -itemcolor Violet -label P1 /passcode_all_testbench/dut/m4/P1
add wave -noupdate -color Violet -itemcolor Violet -label P2 /passcode_all_testbench/dut/m4/P2
add wave -noupdate -label ps /passcode_all_testbench/dut/m4/ps
add wave -noupdate -label ns /passcode_all_testbench/dut/m4/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 89
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
WaveRestoreZoom {0 ns} {1460 ns}
