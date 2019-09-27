
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Nexysdemo -dir "Z:/comp3601/nexys_demo_simple/planAhead_run_2" -part xc3s400ft256-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "Z:/comp3601/nexys_demo_simple/Nexysdemo.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {Z:/comp3601/nexys_demo_simple} }
set_property target_constrs_file "nexysdemo.ucf" [current_fileset -constrset]
add_files [list {nexysdemo.ucf}] -fileset [get_property constrset [current_run]]
link_design
