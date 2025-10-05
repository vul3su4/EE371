transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/bcd7seg.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/counter.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/passcode.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/passcode_all.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/passcode_all_counter.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/signal_extender.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/twoDFF.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/userInput.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/top_cell.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task1 {C:/cychen/work/371/LAB6/Task1/DE1_SoC.sv}

