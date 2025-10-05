transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/ram8x16.v}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/count_updw.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/counter.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/data7seg.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/parkinglot_ctrl.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/parkinglot_datapath.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/twoDFF.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/userInput.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/simple3D.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/top_datapath.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/top_ctrl_datapath.sv}
vlog -sv -work work +incdir+C:/cychen/work/371/LAB6/Task2 {C:/cychen/work/371/LAB6/Task2/DE1_SoC.sv}

