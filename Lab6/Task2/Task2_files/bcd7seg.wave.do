onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bcd7seg_testbench/count
add wave -noupdate /bcd7seg_testbench/HEX5
add wave -noupdate /bcd7seg_testbench/HEX4
add wave -noupdate /bcd7seg_testbench/HEX3
add wave -noupdate /bcd7seg_testbench/HEX2
add wave -noupdate /bcd7seg_testbench/HEX1
add wave -noupdate /bcd7seg_testbench/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
configure wave -valuecolwidth 45
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
WaveRestoreZoom {0 ns} {43 ns}
