proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7z010clg400-1
  set_property board_part myir.com:mys-7z010:part0:2.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.cache/wt [current_project]
  set_property parent.project_path /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.xpr [current_project]
  set_property ip_repo_paths /opt/Xilinx/Vivado/CERN_projects/ip_repo [current_project]
  set_property ip_output_repo /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.runs/synth_1/Peripherals_wrapper.dcp
  read_xdc -ref Peripherals_processing_system7_0_0 -cells inst /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_processing_system7_0_0/Peripherals_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_processing_system7_0_0/Peripherals_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref Peripherals_rst_ps7_0_100M_0 -cells U0 /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_rst_ps7_0_100M_0/Peripherals_rst_ps7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_rst_ps7_0_100M_0/Peripherals_rst_ps7_0_100M_0_board.xdc]
  read_xdc -ref Peripherals_rst_ps7_0_100M_0 -cells U0 /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_rst_ps7_0_100M_0/Peripherals_rst_ps7_0_100M_0.xdc
  set_property processing_order EARLY [get_files /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/sources_1/bd/Peripherals/ip/Peripherals_rst_ps7_0_100M_0/Peripherals_rst_ps7_0_100M_0.xdc]
  read_xdc /opt/Xilinx/Vivado/CERN_projects/Peripherals/Peripherals.srcs/constrs_1/new/constraints.xdc
  link_design -top Peripherals_wrapper -part xc7z010clg400-1
  write_hwdef -file Peripherals_wrapper.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Peripherals_wrapper_opt.dcp
  report_drc -file Peripherals_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force Peripherals_wrapper_placed.dcp
  report_io -file Peripherals_wrapper_io_placed.rpt
  report_utilization -file Peripherals_wrapper_utilization_placed.rpt -pb Peripherals_wrapper_utilization_placed.pb
  report_control_sets -verbose -file Peripherals_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Peripherals_wrapper_routed.dcp
  report_drc -file Peripherals_wrapper_drc_routed.rpt -pb Peripherals_wrapper_drc_routed.pb -rpx Peripherals_wrapper_drc_routed.rpx
  report_methodology -file Peripherals_wrapper_methodology_drc_routed.rpt -rpx Peripherals_wrapper_methodology_drc_routed.rpx
  report_timing_summary -warn_on_violation -max_paths 10 -file Peripherals_wrapper_timing_summary_routed.rpt -rpx Peripherals_wrapper_timing_summary_routed.rpx
  report_power -file Peripherals_wrapper_power_routed.rpt -pb Peripherals_wrapper_power_summary_routed.pb -rpx Peripherals_wrapper_power_routed.rpx
  report_route_status -file Peripherals_wrapper_route_status.rpt -pb Peripherals_wrapper_route_status.pb
  report_clock_utilization -file Peripherals_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force Peripherals_wrapper_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

