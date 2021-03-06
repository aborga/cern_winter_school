# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {1}  -id {IP_Flow 19-4698}  -string {{WARNING: [IP_Flow 19-4698] Upgrade has added port 'PWM_GREEN'}}  -suppress 
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.cache/wt [current_project]
set_property parent.project_path /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part myir.com:mys-7z010:part0:2.1 [current_project]
set_property ip_repo_paths /opt/Xilinx/Vivado/CERN_projects/ip_repo/PWM_1.0 [current_project]
set_property ip_output_repo /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/hdl/LED_Buzzer_Control_wrapper.vhd
add_files /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/LED_Buzzer_Control.bd
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/ip/LED_Buzzer_Control_processing_system7_0_0/LED_Buzzer_Control_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/ip/LED_Buzzer_Control_rst_ps7_0_100M_0/LED_Buzzer_Control_rst_ps7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/ip/LED_Buzzer_Control_rst_ps7_0_100M_0/LED_Buzzer_Control_rst_ps7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/ip/LED_Buzzer_Control_rst_ps7_0_100M_0/LED_Buzzer_Control_rst_ps7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/ip/LED_Buzzer_Control_auto_pc_0/LED_Buzzer_Control_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/LED_Buzzer_Control_ooc.xdc]
set_property is_locked true [get_files /opt/Xilinx/Vivado/CERN_projects/LED_Buzzer_Control/LED_Buzzer_Control.srcs/sources_1/bd/LED_Buzzer_Control/LED_Buzzer_Control.bd]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /opt/Xilinx/Vivado/2016.3/data/boards/system.xdc
set_property used_in_implementation false [get_files /opt/Xilinx/Vivado/2016.3/data/boards/system.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top LED_Buzzer_Control_wrapper -part xc7z010clg400-1


write_checkpoint -force -noxdef LED_Buzzer_Control_wrapper.dcp

catch { report_utilization -file LED_Buzzer_Control_wrapper_utilization_synth.rpt -pb LED_Buzzer_Control_wrapper_utilization_synth.pb }
