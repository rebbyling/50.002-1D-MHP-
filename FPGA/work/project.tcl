set projDir "C:/Users/rebec/Documents/alchitry/FPGA/work/vivado"
set projName "FPGA"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/au_top_0.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/seq_plus_varySlow_1.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/sequence_checker_2.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/button_conditioner_3.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/edge_detector_4.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/reset_conditioner_5.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/8_bit_full_adder_6.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/counter_7.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/pipeline_8.v" "C:/Users/rebec/Documents/alchitry/FPGA/work/verilog/full_adder_9.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/rebec/Documents/alchitry/FPGA/work/constraint/alchitry.xdc" "C:/Users/rebec/Documents/alchitry/FPGA/work/constraint/io.xdc" "C:/Program\ Files/Alchitry/Alchitry\ Labs/library/components/au.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
