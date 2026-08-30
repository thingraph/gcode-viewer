; HEADER_BLOCK_START
; BambuStudio 02.08.02.60
; model printing time: 15m 59s; total estimated time: 21m 8s
; total layer number: 166
; total filament length [mm] : 1057.90
; total filament volume [cm^3] : 2544.55
; total filament weight [g] : 3.21
; filament_density: 1.26,1.26,1.26
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 20.00
; filament: 1
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0,0
; additional_cooling_fan_speed = 70,70,70
; additional_fan_full_speed_layer = 0,0,0
; alternate_extra_wall = 0
; ams_filament_load_time_ams = 0
; ams_filament_load_time_ams_lite = 0
; ams_filament_load_time_n3f_s = 0
; ams_filament_unload_time_ams = 0
; ams_filament_unload_time_ams_lite = 0
; ams_filament_unload_time_n3f_s = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_heat_soak_area = 
; bed_temperature_formula = by_highest_temp
; before_layer_change_gcode = 
; best_object_pos = 0.3,0.5
; bottom_color_penetration_layers = 5
; bottom_shell_layers = 5
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1.5
; bridge_no_support = 0
; bridge_speed = 25,25
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0,0,0
; change_filament_gcode = ======== X2D filament_change gcode ==========\n;===== 2026/07/01 =====\n\nM620 S[next_filament_id]A B H[next_hotend]\n;M204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_filament_id] == 0 || z_hop_types[current_filament_id] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\n\n;nozzle_change_gcode\n\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\n\n{if toolchange_count == 2}\n; get travel path for change filament\n;M620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\n;M620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\n;M620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\n\n{if ((filament_type[current_filament_id] == \"PLA\") || (filament_type[current_filament_id] == \"PLA-CF\") || (filament_type[current_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\nM620.10 A0 F74.8347 L[flush_length] H{nozzle_diameter_at_nozzle_id[current_nozzle_id]} T{flush_temperatures[current_filament_id]} P[old_filament_temp] S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[current_filament_id]/2.4053*60} L[flush_length] H{nozzle_diameter_at_nozzle_id[current_nozzle_id]} T{flush_temperatures[current_filament_id]} P[old_filament_temp] S1\n{endif}\n\n{if ((filament_type[next_filament_id] == \"PLA\") || (filament_type[next_filament_id] == \"PLA-CF\") || (filament_type[next_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[next_nozzle_id] == 0.2)}\nM620.10 A1 F74.8347 L[flush_length] H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} T{flush_temperatures[next_filament_id]} P[new_filament_temp] S1\n{else}\nM620.10 A1 F{flush_volumetric_speeds[next_filament_id]/2.4053*60} L[flush_length] H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} T{flush_temperatures[next_filament_id]} P[new_filament_temp] S1\n{endif}\n\nM620.15 C{new_filament_temp - filament_cooling_before_tower[next_filament_id]}\n\n{if long_retraction_when_cut}\nM620.11 P1 L0 I[current_filament_id] B[current_hotend] E-{retraction_distance_when_cut} F{max((flush_volumetric_speeds[current_filament_id]/2.4053*60), 200)}\n{else}\nM620.11 P0 L0 I[current_filament_id] B[current_hotend] E0\n{endif}\n\n{if long_retraction_when_ec}\nM620.11 K1 I[current_filament_id] B[current_hotend] R{retraction_distance_when_ec} F{max((flush_volumetric_speeds[current_filament_id]/2.4053*60), 200)}\n{else}\nM620.11 K0 I[current_filament_id] B[current_hotend] R0\n{endif}\n\nM620.22 I[next_filament_id] P1    ; enable remote extruder runout auto purge.\n\nT[next_filament_id] H[next_hotend]\n\n;deretract\n{if filament_type[next_filament_id] == \"TPU\"}\n{else}\n{if filament_type[next_filament_id] == \"PA\"}\n;VG1 E1 F{max(new_filament_e_feedrate, 200)}\n;VG1 E1 F{max(new_filament_e_feedrate/2, 100)}\n{else}\n;VG1 E4 F{max(new_filament_e_feedrate, 200)}\n;VG1 E4 F{max(new_filament_e_feedrate/2, 100)}\n{endif}\n{endif}\n\n; VFLUSH_START\n{if flush_length>41.5}\n;VG1 E41.5 F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n;VG1 E{flush_length-41.5} F{new_filament_e_feedrate}\n{else}\n;VG1 E{flush_length} F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n{endif}\nSYNC T{ceil(flush_length / 125) * 5}\n; VFLUSH_END\n\nM1002 set_filament_type:{filament_type[next_filament_id]}\n\nM400\nM83\n{if next_filament_id < 255}\nM620.10 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\nM628 S0\n;VM109 S[new_filament_temp]\nM629\nM400\n\n;prime_tower_interface\n{if is_prime_tower_interface && filament_tower_interface_purge_volume !=0}\nG150.1\nM620.13 W0 L{filament_tower_interface_purge_volume} T{filament_tower_interface_print_temp} R0.0\n{endif}\n;prime_tower_interface\n\nM983.3 F{filament_max_volumetric_speed[next_filament_id]/2.4} A0.4 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\n\nM400\n\nG1 Z{max_layer_z + 3.0} F3000\n\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\n\n\nM621 S[next_filament_id]A B\n\nM622.1 S0 ;for prev version, default skip\nM1002 judge_flag powerloss_resume_flag\nM622 J1\nM983.3 F{filament_max_volumetric_speed[next_filament_id]/2.4} A0.4 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\nM400\nG1 Z{max_layer_z + 3.0} F3000\nM1002 set_flag powerloss_resume_flag=0\nM623\n\nM620.6 I[next_filament_id] H[next_hotend] W1 ;enable ams air printing detect\n\n{if (filament_type[next_filament_id] == \"TPU\")}\nM1015.3 S1 H{nozzle_diameter_at_nozzle_id[next_nozzle_id]};enable tpu clog detect\n{else}\nM1015.3 S0;disable tpu clog detect\n{endif}\n\n{if (filament_type[next_filament_id] == \"PLA\") ||  (filament_type[next_filament_id] == \"PETG\")\n ||  (filament_type[next_filament_id] == \"PLA-CF\")  ||  (filament_type[next_filament_id] == \"PETG-CF\")}\nM1015.4 S1 K1 H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} ;enable E air printing detect\n{else}\nM1015.4 S0 K0 H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} ;disable E air printing detect\n{endif}\n\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[travel_acceleration]\n{endif}\n\nG1 Y256 F18000\n\n\n{if (overall_chamber_temperature < 40)}\n{if (layer_num + 1 <= close_additional_fan_first_x_layers[next_filament_id])}\n    M106 P2 S{first_x_layer_fan_speed[next_filament_id]*255.0/100.0 };set first x_layer fan\n	M106 P10 S{first_x_layer_fan_speed[next_filament_id]*255.0/100.0 };set first x_layer fan\n{elsif (layer_num + 1 < additional_fan_full_speed_layer[next_filament_id] && additional_fan_full_speed_layer[next_filament_id] > close_additional_fan_first_x_layers[next_filament_id])}\n    M106 P2 S{(first_x_layer_fan_speed[next_filament_id] + (additional_cooling_fan_speed[next_filament_id] - first_x_layer_fan_speed[next_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[next_filament_id]) / max(additional_fan_full_speed_layer[next_filament_id] - close_additional_fan_first_x_layers[next_filament_id], 1)) * 255.0/100.0}\n	M106 P10 S{(first_x_layer_fan_speed[next_filament_id] + (additional_cooling_fan_speed[next_filament_id] - first_x_layer_fan_speed[next_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[next_filament_id]) / max(additional_fan_full_speed_layer[next_filament_id] - close_additional_fan_first_x_layers[next_filament_id], 1)) * 255.0/100.0}\n{else}\n    {if (min_vitrification_temperature <= 50)}\n        {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.2 chamber autocooling\n        {else}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.4 chamber autocooling\n        {endif}\n    {else}\n        {if (!is_all_bbl_filament)}\n            M142 P1 R40 S45 U{max_additional_fan/100.0} V0.5 O50; set third-party PETG chamber \n        {else}\n            {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n                M142 P1 R45 S50 U{max_additional_fan/100.0} V0.5 O50; set PETG ND0.2 chamber autocooling\n            {else}\n                M142 P1 R50 S55 U{max_additional_fan/100.0} V0.5 O55; set PETG ND0.4 chamber autocooling\n            {endif}\n        {endif}\n    {endif}\n{endif}\n{endif}\n;not set fan changing filament
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200,200
; close_additional_fan_first_x_layers = 1,1,1
; close_fan_the_first_x_layers = 1,1,1
; complete_print_exhaust_fan_speed = 70,70,70
; cool_plate_temp = 35,35,35
; cool_plate_temp_initial_layer = 35,35,35
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10,10,10
; cooling_slowdown_logic = uniform_cooling,uniform_cooling,uniform_cooling
; counter_coef_1 = 0,0,0
; counter_coef_2 = 0.0025,0.0025,0.0025
; counter_coef_3 = 0.014,0.014,0.014
; counter_limit_max = 0.076,0.076,0.076
; counter_limit_min = 0.014,0.014,0.014
; counterbore_hole_bridging = none
; curr_bed_type = Engineering Plate
; default_acceleration = 4000,1000
; default_ams_type = -1
; default_filament_colour = ;;
; default_filament_profile = "Bambu PLA Basic @BBL X2D 0.4 nozzle"
; default_jerk = 0
; default_nozzle_volume_type = Standard,Standard
; default_print_profile = 0.20mm Standard @BBL X2D
; deretraction_speed = 30,20
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50,50
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0,0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1,1,1
; enable_overhang_speed = 1,1
; enable_pre_heating = 1
; enable_pressure_advance = 0,0,0
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 1
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 55,55,55
; eng_plate_temp_initial_layer = 55,55,55
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 133
; extruder_clearance_height_to_rod = 32.8
; extruder_clearance_max_radius = 60
; extruder_colour = #018001;#018001
; extruder_max_nozzle_count = 1,1
; extruder_nozzle_stats = Standard#1;Standard#1
; extruder_nozzle_stats_new = 
; extruder_offset = 0x0,0x0
; extruder_printable_area = 0x0,256x0,256x256,0x256#20.5x0,256x0,256x256,20.5x256
; extruder_printable_height = 261,256
; extruder_type = Direct Drive,Bowden
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow,Direct Drive E3D High Flow";"Bowden Standard,Bowden High Flow,Bowden E3D High Flow"
; fan_cooling_layer_time = 100,100,100
; fan_direction = both
; fan_max_speed = 100,100,100
; fan_min_speed = 100,100,100
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0,0,0
; filament_adhesiveness_category = 100,100,100
; filament_bridge_speed = 25,25,25
; filament_change_length = 5,5,5
; filament_change_length_nc = 10,10,10
; filament_colour = #00AE42;#FFFF00;#FF0000
; filament_colour_type = 1;1;1
; filament_cooling_before_tower = 10,10,10
; filament_cost = 19.99,19.99,19.99
; filament_density = 1.26,1.26,1.26
; filament_dev_ams_drying_ams_limitations = 1;0;1;0;1;0
; filament_dev_ams_drying_heat_distortion_temperature = 45,45,45
; filament_dev_ams_drying_temperature = 45,45,45,45,45,45,45,45,45,45,45,45
; filament_dev_ams_drying_time = 12,12,12,12,12,12,12,12,12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 70,70,70
; filament_dev_chamber_drying_time = 12,12,12
; filament_dev_drying_cooling_temperature = 45,45,45
; filament_dev_drying_softening_temperature = 50,50,50
; filament_diameter = 1.75,1.75,1.75
; filament_enable_overhang_speed = 1,1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_compatibility = 0,0,0
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98,0.98,0.98
; filament_flush_temp = 0,0,0
; filament_flush_temp_fast = 0,0,0
; filament_flush_volumetric_speed = 0,0,0
; filament_ids = GFA00;GFA00;GFA00
; filament_is_mixed = 0,0,0
; filament_is_support = 0,0,0
; filament_map = 1,1,1
; filament_map_2 = 0,0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 21,21,21
; filament_metal_stickiness = None,None,None
; filament_minimal_purge_on_wipe_tower = 15,15,15
; filament_mixed_components = ;;
; filament_mixed_gradient = 0,0,0
; filament_mixed_gradient_curve = ;;
; filament_mixed_gradient_per_part = 0,0,0
; filament_mixed_gradient_range = ;;
; filament_mixed_sublayer_ratios = ;;
; filament_multi_colour = #00AE42;#FFFF00;#FF0000
; filament_notes = 
; filament_nozzle_map = 0,0,0
; filament_overhang_1_4_speed = 0,0,0
; filament_overhang_2_4_speed = 50,50,50
; filament_overhang_3_4_speed = 30,30,30
; filament_overhang_4_4_speed = 10,10,10
; filament_overhang_totally_speed = 10,10,10
; filament_pre_cooling_temperature = 0,0,0
; filament_pre_cooling_temperature_nc = 0,0,0
; filament_preheat_temperature_delta = 10,10,10
; filament_prime_volume = 30,30,30
; filament_prime_volume_nc = 60,60,60
; filament_printable = 3,3,3
; filament_ramming_travel_time = 0,0,0
; filament_ramming_travel_time_nc = 0,0,0
; filament_ramming_volumetric_speed = -1,-1,-1
; filament_ramming_volumetric_speed_nc = -1,-1,-1
; filament_retract_length_nc = 14,14,14
; filament_retraction_distances_when_cut = 10,10,10
; filament_scarf_gap = 0%,0%,0%
; filament_scarf_height = 10%,10%,10%
; filament_scarf_length = 10,10,10
; filament_scarf_seam_type = none,none,none
; filament_self_index = 1,2,3
; filament_settings_id = "Bambu PLA Basic @BBL X2D 0.4 nozzle";"Bambu PLA Basic @BBL X2D 0.4 nozzle";"Bambu PLA Basic @BBL X2D 0.4 nozzle"
; filament_shrink = 100%,100%,100%
; filament_soluble = 0,0,0
; filament_start_gcode = "; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n"
; filament_tower_interface_pre_extrusion_dist = 10,10,10
; filament_tower_interface_pre_extrusion_length = 0,0,0
; filament_tower_interface_print_temp = 220,220,220
; filament_tower_interface_purge_volume = 20,20,20
; filament_tower_ironing_area = 4,4,4
; filament_type = PLA;PLA;PLA
; filament_velocity_adaptation_factor = 1,1,1
; filament_vendor = "Bambu Lab";"Bambu Lab";"Bambu Lab"
; filament_volume_map = 0,0,0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 40,40,40
; first_x_layer_part_fan_speed = 0,0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1,1
; flush_multiplier_fast = 1.2,1.2
; flush_volumes_matrix = 0,270,303,120,0,348,454,632,0,0,270,303,120,0,348,454,632,0
; flush_volumes_vector = 140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250,250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0,0
; group_algo_with_time = 1
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0,0,0
; hole_coef_2 = -0.0028,-0.0028,-0.0028
; hole_coef_3 = 0.12,0.12,0.12
; hole_limit_max = 0.12,0.12,0.12
; hole_limit_min = 0.05,0.05,0.05
; host_type = octoprint
; hot_plate_temp = 55,55,55
; hot_plate_temp_initial_layer = 55,55,55
; hotend_cooling_rate = 2,2
; hotend_heating_rate = 1.5,1.5
; impact_strength_z = 13.8,13.8,13.8
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500,500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105,100
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50,50
; initial_layer_travel_acceleration = 6000,6000
; inner_wall_acceleration = 0,0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 150,100
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 180,100
; ironing_direction = 45
; ironing_fan_speed = -1,-1,-1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ;======== X2D layer_change gcode ==========\n;===== 2026/07/01 =====\n\n{if (layer_num + 1 == 1)}\n{if (overall_chamber_temperature >= 40)}\n    ;not reset filter fan in first layer\n    ;not reset fan\n{endif}\n{endif}\n\n{if (layer_num + 1 <= close_additional_fan_first_x_layers[current_filament_id])}\n{if (overall_chamber_temperature < 40)}\n    M106 P2 S{first_x_layer_fan_speed[current_filament_id]*255.0/100.0}\n	M106 P10 S{first_x_layer_fan_speed[current_filament_id]*255.0/100.0}\n{endif}\n;not reset fan\n{elsif (layer_num + 1 < additional_fan_full_speed_layer[current_filament_id] && additional_fan_full_speed_layer[current_filament_id] > close_additional_fan_first_x_layers[current_filament_id])}\n{if (overall_chamber_temperature < 40)}\n    M106 P2 S{(first_x_layer_fan_speed[current_filament_id] + (additional_cooling_fan_speed[current_filament_id] - first_x_layer_fan_speed[current_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[current_filament_id]) / max(additional_fan_full_speed_layer[current_filament_id] - close_additional_fan_first_x_layers[current_filament_id], 1)) * 255.0/100.0}\n	M106 P10 S{(first_x_layer_fan_speed[current_filament_id] + (additional_cooling_fan_speed[current_filament_id] - first_x_layer_fan_speed[current_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[current_filament_id]) / max(additional_fan_full_speed_layer[current_filament_id] - close_additional_fan_first_x_layers[current_filament_id], 1)) * 255.0/100.0}\n{endif}\n;not reset fan\n{elsif (layer_num + 1 == max(close_additional_fan_first_x_layers[current_filament_id] + 1, additional_fan_full_speed_layer[current_filament_id]))}\n{if (overall_chamber_temperature < 40)}\n    ;updata chamber autocooling in Xth layer\n    {if (min_vitrification_temperature <= 50)}\n        {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.2 chamber autocooling\n        {else}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.4 chamber autocooling\n        {endif}\n    {else}\n        {if (!is_all_bbl_filament)}\n            M142 P1 R40 S45 U{max_additional_fan/100.0} V0.5 O50; set third-party PETG chamber \n        {else}\n            {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n                M142 P1 R45 S50 U{max_additional_fan/100.0} V0.5 O50; set PETG ND0.2 chamber autocooling\n            {else}\n                M142 P1 R50 S55 U{max_additional_fan/100.0} V0.5 O55; set PETG ND0.4 chamber autocooling\n            {endif}\n        {endif}\n    {endif}\n{else}\n        ;not reset filter fan in Xth layer\n{endif}\n;not reset fan\n{endif}\n\n\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change\n
; layer_height = 0.12
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0,0
; long_retractions_when_ec = 1,1,1
; machine_bed_mass_Y = 0
; machine_end_gcode = ;======== X2D end gcode ==========\n;===== 2026/05/18 =====\n\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nM211 Z1\n\nG90\nG1 Z{max_layer_z + 0.4} F900 ; lower z a little\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    G150.3\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S5 ;wait for last picture to be taken\nM623  ;end of \"timelapse_record_flag\"\n\nG90\nG1 Z{max_layer_z + 10} F900 ; lower z a little\n\nM140 S0 ; turn off bed\nM141 S0 ; turn off chamber heating\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\nM106 P10 S0 ; turn off remote part1 cooling fan\n\n; pull back filament to AMS\nM620 S65279 B\n; M620.11 P1 L0 I65279 E-3\nT65279\nG150.1 F8000\nM621 S65279 B\n\nM620 S65535 B\n; M620.11 P1 L0 I65535 E-4\nT65535\nG150.1 F8000\nM621 S65535 B\n\nG150.3\n\nM104 S0 T0; turn off hotend\nM104 S0 T1; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (80.0 - max_layer_z/2) > 0}\n    {if (max_layer_z + 80.0 - max_layer_z/2) < 256}\n        G1 Z{max_layer_z + 80.0 - max_layer_z/2} F600\n        G1 Z{max_layer_z + 78.0 - max_layer_z/2}\n    {else}\n        G1 Z256 F600\n        G1 Z256\n    {endif}\n{else}\n    {if (max_layer_z + 4.0) < 256}\n        G1 Z{max_layer_z + 4.0} F600\n        G1 Z{max_layer_z + 2.0}\n    {else}\n        G1 Z256 F600\n        G1 Z256\n    {endif}\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2 R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM1015.3 S0 ;disable clog detect\nM1015.4 S0 K0 ;disable air printing detect\n\n;=====printer finish air purification=========\nM622.1 S0\nM1002 judge_flag print_finish_air_filt_flag\n\nM622 J1\nM1002 gcode_claim_action : 66\nM145 P1\nM106 P10 S255\nM400 S180\nM106 P10 S0\nM623\n\nM622 J2\nM1002 gcode_claim_action : 66\nM145 P0\nM106 P3 S255\nM400 S180\nM106 P3 S0\nM623\n;=====printer finish air purification=========\n\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 \nM1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 \nM1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A48 B10 L50 C48 D10 M50 E48 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A60 B10 L50 C60 D10 M50 E60 F10 N50 \nM1006 W\n;=====printer finish  sound=========\nM400\nM18\n\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 30000,5000,5000,5000
; machine_max_acceleration_extruding = 20000,20000,20000,20000
; machine_max_acceleration_retracting = 30000,5000,30000,5000
; machine_max_acceleration_travel = 9000,9000,9000,9000
; machine_max_acceleration_x = 20000,20000,20000,20000
; machine_max_acceleration_y = 20000,20000,20000,20000
; machine_max_acceleration_z = 500,500,500,500
; machine_max_force_Y = 0
; machine_max_jerk_e = 2.5,2.5,2.5,2.5
; machine_max_jerk_x = 9,9,9,9
; machine_max_jerk_y = 9,9,9,9
; machine_max_jerk_z = 3,3,3,3
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30,120,120
; machine_max_speed_x = 1000,1000,1000,1000
; machine_max_speed_y = 1000,1000,1000,1000
; machine_max_speed_z = 20,20,20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;M1002 set_flag extrude_cali_flag=1\n;M1002 set_flag g29_before_print_flag=1\n;M1002 set_flag auto_cali_toolhead_offset_flag=1\n;M1002 set_flag build_plate_detect_flag=1\n\n;======== X2D start gcode==========\n;===== 2026/06/05 =====\n\n  M140 S[bed_temperature_initial_layer_single] ; heat heatbed first\n  M993 A0 B0 C0 ; nozzle cam detection not allowed.\n  M400\n  ;M73 P99\n\n;=====printer start sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A53 B9 L50 C53 D9 M50 E53 F9 N50\nM1006 A56 B9 L50 C56 D9 M50 E56 F9 N50\nM1006 A61 B9 L50 C61 D9 M50 E61 F9 N50\nM1006 A53 B9 L50 C53 D9 M50 E53 F9 N50\nM1006 A56 B9 L50 C56 D9 M50 E56 F9 N50\nM1006 A61 B18 L50 C61 D18 M50 E61 F18 N50\nM1006 W\n;=====printer start sound ===================\n\n  M1012.1 T1100\n  M620 M ;enable remap\n  M622.1 S0\n  G383.4\n\n;===== avoid end stop =================\n  G91\n  G380 S2 Z22 F1200\n  G380 S2 Z-12 F1200\n  G90\n;===== avoid end stop =================\n\n;===== reset machine status =================\n  M204 S10000\n  M630 S0 P1\n  G90\n  M17 D ; reset motor current to default\n  M960 S5 P1 ; turn on logo lamp\n  M220 S100 ;Reset Feedrate\n  M1002 set_gcode_claim_speed_level: 5\n  M221 S100 ;Reset Flowrate\n  M73.2   R1.0 ;Reset left time magnitude\n  G29.1 Z{+0.0} ; clear z-trim value first\n  M983.1 M1\n  M982.2 S1 ; turn on cog noise reduction\n;===== reset machine status =================\n\n;==== set airduct mode ====\n{if (overall_chamber_temperature >= 40)}\nM145 P1 ; set airduct mode to heating mode for heating\nM106 P2 S0 ; turn off auxiliary fan\nM106 P10 S255 ; turn on filter fan\n{else}\nM145 P0 ; set airduct mode to cooling mode for cooling\nM106 P2 S255 ; turn on auxiliary fan for cooling\nM106 P10 S255 ; turn on auxiliary fan for cooling\nM106 P3 S127 ; turn on chamber fan for cooling\n;M140 S0 ; stop heatbed from heating\nM1002 gcode_claim_action : 29\nM191 S0 ; wait for chamber temp\nM106 P2 S102 ; turn on auxiliary fan\nM106 P10 S102 ; turn on chamber fan\nM142 P6 R30 S40 U0.6 V0.8 ; set PLA/TPU/PETG exhaust chamber autocooling\n{endif}\n;==== set airduct mode ====\n\n;===== start to heat heatbed & hotend==========\n  M1002 gcode_claim_action : 2\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n\n  ;===== set chamber temperature ==========\n  {if (overall_chamber_temperature >= 40)}\n    M145 P1 ; set airduct mode to heating mode\n    M141 S[overall_chamber_temperature] ; Let Chamber begin to heat\n  {endif}\n;===== set chamber temperature ==========\n\n  G29.2 S0 ; avoid invalid abl data\n\n;===== first homing start =====\n  M1002 gcode_claim_action : 13\n  G28 X T300 R\n  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed\n  G150.3\n  M972 S24 P0\n  M1002 gcode_claim_action : 74 ; Heatbed surface foreign object detection\n  M972 S26 P0 C0\n  G90\n  M83\n  G1 Y128 F30000\n  G1 X128\n  G28 Z P0 T400\n  M400\n;===== first homign end =====\n\n;===== detection start =====\n  M1002 gcode_claim_action : 11\n\n      M104 S0 T0\n      M104 S0 T1\n      M562 P1 E0 B1\n      M562 P2 E0 B1\n      M18 E\n      M400 P200\n      M1028 S1\n      M972 S19 P0   ;heatbed detection\n      M972 S31 P0   ;toolhead camera dirt detection\n      M1002 gcode_claim_action : 73 ; Build plate alignment detection\n      M972 S34 P0   ;print plate deviation detection\n      M1028 S0\n      M562 P1 E1 B1\n      M562 P2 E1 B1\n      M17 D\n\n  ;M400\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]} T{filament_map[initial_no_support_filament_id] % 2} ; rise temp in advance\n\n  {if max_print_z >= 145}\n    G151 P{filament_map[initial_no_support_filament_id] % 2} M ; plug the heat nozzle\n    M1002 gcode_claim_action : 75 ;  Detect obstacles at the botton of the heated bed\n    G3811 Z{max_print_z}  ; Detect obstacles at the bottom of the heated bed\n  {endif}\n;===== detection end =====\n\n;===== prepare print temperature and material ==========\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]-40} A ; rise temp in advance\n  M400\n  M211 X0 Y0 Z0 ;turn off soft endstop\n  M975 S1 ; turn on input shaping\n\n  G29.2 S0 ; avoid invalid abl data\n  G150.3\n{if ((filament_type[initial_no_support_filament_id] == \"PLA\") || (filament_type[initial_no_support_filament_id] == \"PLA-CF\") || (filament_type[initial_no_support_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[initial_nozzle_id] == 0.2)}\nM620.10 A0 F74.8347 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\nM620.10 A1 F74.8347 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[initial_no_support_filament_id]/2.4053*60} H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\nM620.10 A1 F{flush_volumetric_speeds[initial_no_support_filament_id]/2.4053*60} H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\n{endif}\n\n M620.11 P0 L0 I[initial_no_support_filament_id] B[initial_no_support_hotend] E0\n M620.11 K0 I[initial_no_support_filament_id] B[initial_no_support_hotend] R0\n\n  M620 S[initial_no_support_filament_id]A H[initial_no_support_hotend] B   ; switch material if AMS exist\n  M620.22 I[initial_no_support_filament_id] P1    ; enable remote extruder runout auto purge.\n  M1002 gcode_claim_action : 4\n  M1002 set_filament_type:UNKNOWN\n  M400\n  T[initial_no_support_filament_id] H[initial_no_support_hotend]\n  M400\n  M628 S0\n  M629\n  M400\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n  M621 S[initial_no_support_filament_id]A B\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  M400\n  M106 P1 S0\n  M400\n  G29.2 S1\n;===== prepare print temperature and material ==========\n\n;===== auto extrude cali start =========================\n  M975 S1\n  M1002 judge_flag extrude_cali_flag\n  M622 J0\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n  M623\n\n  M622 J1\n    M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n    M1002 gcode_claim_action : 8\n    M109 S{nozzle_temperature[initial_no_support_filament_id]}\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\n  M623\n\n  M622 J2\n    M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n    M1002 gcode_claim_action : 8\n    M109 S{nozzle_temperature[initial_no_support_filament_id]}\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\n  M623\n;===== auto extrude cali end =========================\n\n  {if hold_chamber_temp_for_flat_print}\n    G150.3\n    M1002 gcode_claim_action : 58\n    M104 S{first_layer_temperature[initial_no_support_filament_id]}\n    {if bed_temperature_initial_layer_single > 89}\n        {if overall_chamber_temperature < 40}\n            M1030 S1200\n            SYNC R0 T1200\n        {else}\n            M1030 S600\n            SYNC R0 T600\n        {endif}\n    {else}\n        M1030 S300\n        SYNC R0 T300\n    {endif}\n    M1030 C\n  {endif}\n\n  {if filament_type[initial_filament_id] == \"TPU\" || filament_type[initial_filament_id] == \"PVA\"}\n  {else}\n    M83\n    G1 E-3 F1800\n    M400 P500\n  {endif}\n  G150.2\n  G150.1 F8000\n  G150.2\n  G150.1 F8000\n\n  G91\n  G1 Y-16 F12000 ; move away from the trash bin\n  G90\n  M400\n\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]-80} A\n\n;===== wipe right nozzle start =====\n  M1002 gcode_claim_action : 14\n  G150 T{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  M400\n;===== wipe left nozzle end =====\n\n{if filament_type[initial_filament_id] == \"PC\"}\n  M109 S170 A\n{else}\n  M109 S140 A\n{endif}\n  M106 S0 ; turn off fan , too noisy\n  G91\n  G1 Z5 F1200\n  G90\n  M400\n  G150.1\n\n{if (overall_chamber_temperature >= 40)}\nM1002 gcode_claim_action : 49\nM191 S[overall_chamber_temperature] ; wait for chamber temp\n{endif}\n\n;===== z ofst cali start =====\n  M190 S[bed_temperature_initial_layer_single]; ensure bed temp\n  G383 O0 M1 T140\n  M400\n;===== z ofst cali end =====\nG90\nM83\nG0 Y200 F18000\n\n;===== bed leveling ==================================\n  M1002 gcode_claim_action : 54\n  M190 S[bed_temperature_initial_layer_single]; ensure bed temp\n  M109 S140 A\n  M106 S0 ; turn off fan , too noisy\n  M1002 judge_flag g29_before_print_flag\n  M622 J1\n    M1002 gcode_claim_action : 1\n    {if hold_chamber_temp_for_flat_print}\n      G29 H R\n    {else}\n      G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]} R\n    {endif}\n    M400\n  M623\n\n  M622 J2\n    M1002 gcode_claim_action : 1\n    {if hold_chamber_temp_for_flat_print}\n      G29 H R\n    {else}\n      G29 A2 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]} R\n    {endif}\n    M400\n  M623\n\n  M622 J0\n    G28 R\n  M623\n  G29.2 S1\n;===== bed leveling end ================================\n\n; cali eddy z pos\n;G383.13 T1 C1\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]} A\n;===== mech mode sweep start =====\n  M1002 gcode_claim_action : 3\n  G90\n  G1 X128 Y128 F20000\n  G1 Z5 F1200\n  M400 P200\n  M970.3 Q1 A5 K0 O1\n  M974 Q1 S2 P0\n  M970.3 Q0 A7 K0 O1\n  M970.2 Q0 W73 K1 Z0.01\n  M974 Q0 S2 P0\n  M975 S1\n  M400\n;===== mech mode sweep end =====\n\nM104 S{nozzle_temperature_initial_layer[initial_filament_id]} A\nG150.3\n\n;===== xy ofst cali start =====\nM1002 judge_flag auto_cali_toolhead_offset_flag\n\nM622 J0\n    M1012.5 N1 R1\nM623\n\nM622 J1\n    M1002 gcode_claim_action : 39\n    M141 S0\n    M620.17 T0 S{nozzle_temperature_initial_layer[(first_non_support_filaments[0] != -1 ? first_non_support_filaments[0] : (first_filaments[0] != -1 ? first_filaments[0] : 0))]} L{(first_non_support_filaments[0] != -1 ? first_non_support_filaments[0] : (first_filaments[0] != -1 ? first_filaments[0] : 0))}\n    M620.17 T1 S{nozzle_temperature_initial_layer[(first_non_support_filaments[1] != -1 ? first_non_support_filaments[1] : (first_filaments[1] != -1 ? first_filaments[1] : 0))]} L{(first_non_support_filaments[1] != -1 ? first_non_support_filaments[1] : (first_filaments[1] != -1 ? first_filaments[1] : 0))}\n    M620 D[initial_no_support_hotend]\n    G383 O1 T{nozzle_temperature_initial_layer[initial_no_support_filament_id]} L{initial_no_support_filament_id}\n    M141 S[overall_chamber_temperature]\nM623\n\nM622 J2\n    M1002 gcode_claim_action : 39\n    M141 S0\n    M620.17 T0 S{nozzle_temperature_initial_layer[(first_non_support_filaments[0] != -1 ? first_non_support_filaments[0] : (first_filaments[0] != -1 ? first_filaments[0] : 0))]} L{(first_non_support_filaments[0] != -1 ? first_non_support_filaments[0] : (first_filaments[0] != -1 ? first_filaments[0] : 0))}\n    M620.17 T1 S{nozzle_temperature_initial_layer[(first_non_support_filaments[1] != -1 ? first_non_support_filaments[1] : (first_filaments[1] != -1 ? first_filaments[1] : 0))]} L{(first_non_support_filaments[1] != -1 ? first_non_support_filaments[1] : (first_filaments[1] != -1 ? first_filaments[1] : 0))}\n    M620 D[initial_no_support_hotend]\n    G383.3 T{nozzle_temperature_initial_layer[initial_no_support_filament_id]} L{initial_no_support_filament_id}\n    M141 S[overall_chamber_temperature]\nM623\n;===== xy ofst cali end =====\n\n  M104 S{nozzle_temperature_initial_layer[initial_filament_id]} A\n\n G150.3 ; move to garbage can to wait for temp\n\n;===== wait temperature reaching the reference value =======\n  M140 S[bed_temperature_initial_layer_single]\n  M190 S[bed_temperature_initial_layer_single]\n\n  ;========turn off light and fans =============\n  M960 S1 P0 ; turn off laser\n  M960 S2 P0 ; turn off laser\n  M106 S0 ; turn off cooling fan\n\n;===== wait temperature reaching the reference value =======\n\n  M1002 gcode_claim_action : 255\n  M400\n  M975 S1 ; turn on mech mode supression\n  M983.4 S0 ; turn off deformation compensation\n\n;============switch again==================\n  M211 X0 Y0 Z0 ;turn off soft endstop\n  G91\n  G1 Z6 F1200\n  G90\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n  M620 S[initial_no_support_filament_id]A H[initial_no_support_hotend] B\n  M620.22 I[initial_no_support_filament_id] P1    ; enable remote extruder runout auto purge.\n  M400\n  T[initial_no_support_filament_id] H[initial_no_support_hotend]\n  M400\n  M628 S0\n  M629\n  M400\n  M621 S[initial_no_support_filament_id]A B\n;============switch again==================\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n  {if bed_temperature_initial_layer_single > 70}\n    {if curr_bed_type==\"Textured PEI Plate\"}\n      G29.1 Z{-0.003} ; for Textured PEI Plate\n    {else}\n      G29.1 Z{0.017}\n    {endif}\n  {else}\n    {if curr_bed_type==\"Textured PEI Plate\"}\n      G29.1 Z{0.002} ; for Textured PEI Plate\n    {else}\n      G29.1 Z{0.022}\n    {endif}\n  {endif}\n\n;===== nozzle load line ===============================\nM1002 gcode_claim_action : 51\n  G29.2 S1 ; ensure z comp turn on\n  G90\n  M83\n  M400 P50\n  M500 D1\n  M400 S3\n  M109 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  G0 X100 Y0 F24000\n  M400\n  ;G130 O0 X100 Y-0.4 Z0.6 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2/2.4053} L40 E20 D5\n  G130 O0 X100 Y-0.2 Z0.6 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2/2.4053} L40 E12 D4\nG90\n  G90\n  M83\n  G1 Z1\n  M400\n;===== noozle load line end ===========================\nM1002 gcode_claim_action : 0\n  G29.99\n\n;M993 A1 B1 C1 ; nozzle cam detection allowed.\n\nM620.6 I[initial_no_support_filament_id] H[initial_no_support_hotend] W1 ;enable ams air printing detect\n\n\n{if (filament_type[initial_no_support_filament_id] == \"TPU\")}\nM1015.3 S1 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]};enable tpu clog detect\n{else}\nM1015.3 S0;disable tpu clog detect\n{endif}\n\n{if (filament_type[initial_no_support_filament_id] == \"PLA\") ||  (filament_type[initial_no_support_filament_id] == \"PETG\")\n ||  (filament_type[initial_no_support_filament_id] == \"PLA-CF\")  ||  (filament_type[initial_no_support_filament_id] == \"PETG-CF\")}\nM1015.4 S1 K1 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} ;enable E air printing detect\n{else}\nM1015.4 S0 K0 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} ;disable E air printing detect\n{endif}\n\n
; machine_switch_extruder_time = 5
; machine_unload_filament_time = 29
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28,0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08,0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 45%
; no_slow_down_for_cooling_on_outwalls = 0,0,0
; nozzle_diameter = 0.4,0.4
; nozzle_flush_dataset = 1,1
; nozzle_height = 4
; nozzle_temperature = 220,220,220
; nozzle_temperature_initial_layer = 220,220,220
; nozzle_temperature_range_high = 240,240,240
; nozzle_temperature_range_low = 190,190,190
; nozzle_type = hardened_steel,hardened_steel
; nozzle_volume = 92,92
; nozzle_volume_type = Standard,Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 2000,1000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 60,50
; overhang_1_4_speed = 0,0
; overhang_2_4_speed = 40,40
; overhang_3_4_speed = 30,30
; overhang_4_4_speed = 20,20
; overhang_fan_speed = 100,100,100
; overhang_fan_threshold = 50%,50%,50%
; overhang_threshold_participating_cooling = 95%,95%,95%
; overhang_totally_speed = 10,10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0,0,0
; physical_extruder_map = 1,0
; post_process = 
; pre_start_fan_time = 0,0,0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02,0.02
; prime_tower_brim_width = -1
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 1
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 60
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X2D 0.4 nozzle"
; print_extruder_id = 1,2
; print_extruder_variant = "Direct Drive Standard";"Bowden Standard"
; print_flow_ratio = 1
; print_in_clockwise = 1
; print_sequence = by layer
; print_settings_id = 0.12mm High Quality @BBL X2D
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 261
; printer_extruder_id = 1,2
; printer_extruder_variant = "Direct Drive Standard";"Bowden Standard"
; printer_model = Bambu Lab X2D
; printer_notes = 
; printer_settings_id = Bambu Lab X2D 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1,1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3,3,3
; resolution = 0.012
; retract_before_wipe = 0%,0%
; retract_length_toolchange = 2,2
; retract_lift_above = 0,0
; retract_lift_below = 254,254
; retract_restart_extra = 0,0
; retract_restart_extra_toolchange = 0,0
; retract_when_changing_layer = 1,1
; retraction_distances_when_cut = 18,18
; retraction_distances_when_ec = 3,3,3
; retraction_length = 0.8,2
; retraction_minimum_travel = 1,1
; retraction_speed = 30,20
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1
; slow_down_layer_time = 4,4,4
; slow_down_min_speed = 20,20,20
; slowdown_end_acc = 100000,100000
; slowdown_end_height = 400,400
; slowdown_end_speed = 1000,1000
; slowdown_start_acc = 100000,100000
; slowdown_start_height = 0,0
; slowdown_start_speed = 1000,1000
; small_perimeter_speed = 50%,50%
; small_perimeter_threshold = 0,0
; smooth_coefficient = 4
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%,100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 150,100
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 40,40,40
; supertack_plate_temp_initial_layer = 40,40,40
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.12
; support_chamber_temp_control = 1
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80,80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150,150
; support_style = default
; support_threshold_angle = 20
; support_top_z_distance = 0.12
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,45,45
; template_custom_gcode = 
; textured_plate_temp = 55,55,55
; textured_plate_temp_initial_layer = 55,55,55
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;======== X2D timelapse gcode ========\n;======== 2026/06/03 ========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firware, default turned on\n\nM1002 judge_flag timelapse_record_flag\n\nM622 J1\n    {if !spiral_mode && !(has_timelapse_safe_pos) }\n        {if most_used_physical_extruder_id!= curr_physical_extruder_id || timelapse_type == 1}\n            M83\n            G1 Z{max_layer_z + 0.4} F1200\n            M400\n        {endif}\n    {endif}\n\n    {if timelapse_inline_photo}\n        M971 S11 C10 O0\n        M1004 S5 P1  ; external shutter\n    {elsif has_timelapse_safe_pos && !spiral_mode}\n        M9711 M{timelapse_type} E{most_used_physical_extruder_id} U{timelapse_pos_x} V{timelapse_pos_y} Z{layer_z + (farthest_point_timelapse_enabled ? 0.0 : 0.4)} S11 C10 O0 T3000\n    {else}\n        {if spiral_mode}\n            M971 S11 C10 O0\n            M1004 S5 P1  ; external shutter\n        {else}\n            M9711 M{timelapse_type} E{most_used_physical_extruder_id} Z{layer_z + (farthest_point_timelapse_enabled ? 0.0 : 0.4)} S11 C10 O0 T3000\n        {endif}\n    {endif}\n\n    {if !spiral_mode && !(has_timelapse_safe_pos) }\n        {if most_used_physical_extruder_id!= curr_physical_extruder_id || timelapse_type == 1}\n            G90\n            G1 Z{max_layer_z + 3.0} F1200\n            G91\n            G0 Y-20 F18000\n            G90\n            M83\n        {endif}\n    {endif}\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 7
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 0.6
; top_solid_infill_flow_ratio = 1,1
; top_surface_acceleration = 2000,2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 150,100
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000,10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250,250
; travel_speed = 1000,1000
; travel_speed_z = 0,0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab A1 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%,80%
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1,1
; wipe_distance = 2,2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 202.929
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 1
; z_hop = 0.4,0.4
; z_hop_types = Auto Lift,Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R21
M201 X20000 Y20000 Z500 E30000
M203 X1000 Y1000 Z20 E30
M204 P20000 R30000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;M1002 set_flag extrude_cali_flag=1
;M1002 set_flag g29_before_print_flag=1
;M1002 set_flag auto_cali_toolhead_offset_flag=1
;M1002 set_flag build_plate_detect_flag=1

;======== X2D start gcode==========
;===== 2026/06/05 =====

  M140 S55 ; heat heatbed first
  M993 A0 B0 C0 ; nozzle cam detection not allowed.
  M400
  ;M73 P99

;=====printer start sound ===================
M17
M400 S1
M1006 S1
M1006 A53 B9 L50 C53 D9 M50 E53 F9 N50
M1006 A56 B9 L50 C56 D9 M50 E56 F9 N50
M1006 A61 B9 L50 C61 D9 M50 E61 F9 N50
M1006 A53 B9 L50 C53 D9 M50 E53 F9 N50
M1006 A56 B9 L50 C56 D9 M50 E56 F9 N50
M1006 A61 B18 L50 C61 D18 M50 E61 F18 N50
M1006 W
;=====printer start sound ===================

  M1012.1 T1100
  M620 M ;enable remap
  M622.1 S0
  G383.4

;===== avoid end stop =================
  G91
  G380 S2 Z22 F1200
  G380 S2 Z-12 F1200
  G90
;===== avoid end stop =================

;===== reset machine status =================
  M204 S10000
  M630 S0 P1
  G90
  M17 D ; reset motor current to default
  M960 S5 P1 ; turn on logo lamp
  M220 S100 ;Reset Feedrate
  M1002 set_gcode_claim_speed_level: 5
  M221 S100 ;Reset Flowrate
  M73.2   R1.0 ;Reset left time magnitude
  G29.1 Z0 ; clear z-trim value first
  M983.1 M1
  M982.2 S1 ; turn on cog noise reduction
;===== reset machine status =================

;==== set airduct mode ====

M145 P0 ; set airduct mode to cooling mode for cooling
M106 P2 S255 ; turn on auxiliary fan for cooling
M106 P10 S255 ; turn on auxiliary fan for cooling
M106 P3 S127 ; turn on chamber fan for cooling
;M140 S0 ; stop heatbed from heating
M1002 gcode_claim_action : 29
M191 S0 ; wait for chamber temp
M106 P2 S102 ; turn on auxiliary fan
M106 P10 S102 ; turn on chamber fan
M142 P6 R30 S40 U0.6 V0.8 ; set PLA/TPU/PETG exhaust chamber autocooling

;==== set airduct mode ====

;===== start to heat heatbed & hotend==========
  M1002 gcode_claim_action : 2
  M1002 set_filament_type:PLA

  ;===== set chamber temperature ==========
  
;===== set chamber temperature ==========

  G29.2 S0 ; avoid invalid abl data

;===== first homing start =====
  M1002 gcode_claim_action : 13
  G28 X T300 R
  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed
  G150.3
  M972 S24 P0
  M1002 gcode_claim_action : 74 ; Heatbed surface foreign object detection
  M972 S26 P0 C0
  G90
  M83
  G1 Y128 F30000
  G1 X128
  G28 Z P0 T400
  M400
;===== first homign end =====

;===== detection start =====
  M1002 gcode_claim_action : 11

      M104 S0 T0
      M104 S0 T1
      M562 P1 E0 B1
      M562 P2 E0 B1
      M18 E
      M400 P200
      M1028 S1
      M972 S19 P0   ;heatbed detection
      M972 S31 P0   ;toolhead camera dirt detection
      M1002 gcode_claim_action : 73 ; Build plate alignment detection
      M972 S34 P0   ;print plate deviation detection
      M1028 S0
      M562 P1 E1 B1
      M562 P2 E1 B1
      M17 D

  ;M400
  M104 S220 T1 ; rise temp in advance

  
;===== detection end =====

;===== prepare print temperature and material ==========
  M104 S180 A ; rise temp in advance
  M400
  M211 X0 Y0 Z0 ;turn off soft endstop
  M975 S1 ; turn on input shaping

  G29.2 S0 ; avoid invalid abl data
  G150.3

M620.10 A0 F523.843 H0.4 T240 P220 S1
M620.10 A1 F523.843 H0.4 T240 P220 S1


 M620.11 P0 L0 I0 B-1 E0
 M620.11 K0 I0 B-1 R0

  M620 S0A H-1 B   ; switch material if AMS exist
  M620.22 I0 P1    ; enable remote extruder runout auto purge.
  M1002 gcode_claim_action : 4
  M1002 set_filament_type:UNKNOWN
  M400
  T0 H-1
  M400
  M628 S0
  M629
  M400
  M1002 set_filament_type:PLA
  M621 S0A B
  M104 S220
  M400
  M106 P1 S0
  M400
  G29.2 S1
;===== prepare print temperature and material ==========

;===== auto extrude cali start =========================
  M975 S1
  M1002 judge_flag extrude_cali_flag
  M622 J0
    M983.3 F8.75 A0.4 ; cali dynamic extrusion compensation
  M623

  M622 J1
    M1002 set_filament_type:PLA
    M1002 gcode_claim_action : 8
    M109 S220
    G90
    M83
    M983.3 F8.75 A0.4 ; cali dynamic extrusion compensation
    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
  M623

  M622 J2
    M1002 set_filament_type:PLA
    M1002 gcode_claim_action : 8
    M109 S220
    G90
    M83
    M983.3 F8.75 A0.4 ; cali dynamic extrusion compensation
    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
  M623
;===== auto extrude cali end =========================

  

  
    M83
    G1 E-3 F1800
    M400 P500
  
  G150.2
  G150.1 F8000
  G150.2
  G150.1 F8000

  G91
  G1 Y-16 F12000 ; move away from the trash bin
  G90
  M400

  M104 S140 A

;===== wipe right nozzle start =====
  M1002 gcode_claim_action : 14
  G150 T220
  M400
;===== wipe left nozzle end =====


  M109 S140 A

  M106 S0 ; turn off fan , too noisy
  G91
M73 P2 R20
  G1 Z5 F1200
  G90
  M400
  G150.1



;===== z ofst cali start =====
  M190 S55; ensure bed temp
  G383 O0 M1 T140
  M400
;===== z ofst cali end =====
G90
M83
G0 Y200 F18000

;===== bed leveling ==================================
  M1002 gcode_claim_action : 54
  M190 S55; ensure bed temp
  M109 S140 A
  M106 S0 ; turn off fan , too noisy
  M1002 judge_flag g29_before_print_flag
  M622 J1
    M1002 gcode_claim_action : 1
    
      G29 A1 X109 Y120.5 I38 J15 R
    
    M400
  M623

  M622 J2
    M1002 gcode_claim_action : 1
    
      G29 A2 X109 Y120.5 I38 J15 R
    
    M400
  M623

  M622 J0
    G28 R
  M623
  G29.2 S1
;===== bed leveling end ================================

; cali eddy z pos
;G383.13 T1 C1

M104 S220 A
;===== mech mode sweep start =====
  M1002 gcode_claim_action : 3
  G90
M73 P3 R20
  G1 X128 Y128 F20000
M73 P23 R16
  G1 Z5 F1200
  M400 P200
  M970.3 Q1 A5 K0 O1
  M974 Q1 S2 P0
  M970.3 Q0 A7 K0 O1
  M970.2 Q0 W73 K1 Z0.01
  M974 Q0 S2 P0
  M975 S1
  M400
;===== mech mode sweep end =====

M104 S220 A
G150.3

;===== xy ofst cali start =====
M1002 judge_flag auto_cali_toolhead_offset_flag

M622 J0
    M1012.5 N1 R1
M623

M622 J1
    M1002 gcode_claim_action : 39
    M141 S0
    M620.17 T0 S220 L0
    M620.17 T1 S220 L0
    M620 D-1
    G383 O1 T220 L0
    M141 S0
M623

M622 J2
    M1002 gcode_claim_action : 39
    M141 S0
    M620.17 T0 S220 L0
    M620.17 T1 S220 L0
    M620 D-1
    G383.3 T220 L0
    M141 S0
M623
;===== xy ofst cali end =====

  M104 S220 A

 G150.3 ; move to garbage can to wait for temp

;===== wait temperature reaching the reference value =======
  M140 S55
  M190 S55

  ;========turn off light and fans =============
  M960 S1 P0 ; turn off laser
  M960 S2 P0 ; turn off laser
  M106 S0 ; turn off cooling fan

;===== wait temperature reaching the reference value =======

  M1002 gcode_claim_action : 255
  M400
  M975 S1 ; turn on mech mode supression
  M983.4 S0 ; turn off deformation compensation

;============switch again==================
  M211 X0 Y0 Z0 ;turn off soft endstop
  G91
  G1 Z6 F1200
  G90
  M1002 set_filament_type:PLA
  M620 S0A H-1 B
  M620.22 I0 P1    ; enable remote extruder runout auto purge.
  M400
  T0 H-1
  M400
  M628 S0
  M629
  M400
  M621 S0A B
;============switch again==================

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
  
    
      G29.1 Z0.022
    
  

;===== nozzle load line ===============================
M1002 gcode_claim_action : 51
  G29.2 S1 ; ensure z comp turn on
  G90
  M83
  M400 P50
  M500 D1
  M400 S3
  M109 S220
  G0 X100 Y0 F24000
  M400
  ;G130 O0 X100 Y-0.4 Z0.6 F4.36536 L40 E20 D5
  G130 O0 X100 Y-0.2 Z0.6 F4.36536 L40 E12 D4
G90
  G90
  M83
  G1 Z1
  M400
;===== noozle load line end ===========================
M1002 gcode_claim_action : 0
  G29.99

;M993 A1 B1 C1 ; nozzle cam detection allowed.

M620.6 I0 H-1 W1 ;enable ams air printing detect



M1015.3 S0;disable tpu clog detect



M1015.4 S1 K1 H0.4 ;enable E air printing detect


; MACHINE_START_GCODE_END
; filament start gcode
;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====







    M106 P2 S102
	M106 P10 S102

;not reset fan



; update layer progress
M73 L1
M991 S0 P0 ;notify layer change

M106 S0
; OBJECT_ID: 258
G1 X132.213 Y134.643 F60000
M204 S6000
G1 Z.4
M73 P24 R16
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X132.213 Y121.357 E.49485
G1 X123.787 Y121.357 E.31383
G1 X123.787 Y134.643 E.49485
G1 X132.153 Y134.643 E.3116
M204 S6000
G1 X132.67 Y135.1 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X132.67 Y120.9 E.5289
M73 P24 R15
G1 X123.33 Y120.9 E.34788
G1 X123.33 Y135.1 E.5289
G1 X132.61 Y135.1 E.34565
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 X132.618 Y133.1 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X131.617 Y125.534 Z.6 F60000
G1 X131.088 Y121.54 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50854
G1 F6300
M204 S500
G1 X131.824 Y122.276 E.03951
G1 X131.824 Y122.935 E.02498
G1 X130.635 Y121.746 E.06381
G1 X129.977 Y121.746 E.02498
G1 X131.824 Y123.593 E.09914
G1 X131.824 Y124.252 E.02498
G1 X129.318 Y121.746 E.13448
G1 X128.66 Y121.746 E.02498
G1 X131.824 Y124.91 E.16981
G1 X131.824 Y125.569 E.02498
G1 X128.001 Y121.746 E.20514
G1 X127.343 Y121.746 E.02498
G1 X131.824 Y126.227 E.24048
G1 X131.824 Y126.886 E.02498
G1 X126.684 Y121.746 E.27581
G1 X126.026 Y121.746 E.02498
G1 X131.824 Y127.544 E.31114
G1 X131.824 Y128.203 E.02498
G1 X125.367 Y121.746 E.34648
G1 X124.709 Y121.746 E.02498
G1 X131.824 Y128.861 E.38181
G1 X131.824 Y129.52 E.02498
G1 X124.176 Y121.871 E.41042
G1 X124.176 Y122.529 E.02498
G1 X131.824 Y130.178 E.41042
G1 X131.824 Y130.837 E.02498
G1 X124.176 Y123.188 E.41042
G1 X124.176 Y123.846 E.02498
G1 X131.824 Y131.495 E.41042
G1 X131.824 Y132.154 E.02498
G1 X124.176 Y124.505 E.41042
G1 X124.176 Y125.163 E.02498
G1 X131.824 Y132.812 E.41042
G1 X131.824 Y133.471 E.02498
G1 X124.176 Y125.822 E.41042
G1 X124.176 Y126.48 E.02498
G1 X131.824 Y134.129 E.41042
G1 X131.824 Y134.254 E.00476
G1 X131.291 Y134.254 E.02023
G1 X124.176 Y127.139 E.38182
G1 X124.176 Y127.797 E.02498
G1 X130.633 Y134.254 E.34648
G1 X129.974 Y134.254 E.02498
G1 X124.176 Y128.456 E.31115
G1 X124.176 Y129.114 E.02498
G1 X129.316 Y134.254 E.27582
G1 X128.657 Y134.254 E.02498
G1 X124.176 Y129.773 E.24048
G1 X124.176 Y130.431 E.02498
G1 X127.999 Y134.254 E.20515
G1 X127.34 Y134.254 E.02498
G1 X124.176 Y131.09 E.16982
M73 P25 R15
G1 X124.176 Y131.748 E.02498
G1 X126.682 Y134.254 E.13448
G1 X126.023 Y134.254 E.02498
G1 X124.176 Y132.407 E.09915
G1 X124.176 Y133.065 E.02498
G1 X125.365 Y134.254 E.06382
G1 X124.706 Y134.254 E.02498
G1 X123.97 Y133.518 E.03952
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6300
G1 X124.706 Y134.254 E-.39583
G1 X125.365 Y134.254 E-.25022
G1 X125.153 Y134.042 E-.11395
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====





    ;updata chamber autocooling in Xth layer
    
        
            M142 P1 R30 S40 U0.7 V1.0 O45; set PLA/TPU ND0.4 chamber autocooling
        
    

;not reset fan



; update layer progress
M73 L2
M991 S0 P1 ;notify layer change

M106 S255
; open powerlost recovery
M1003 S1
; OBJECT_ID: 258
M204 S10000
G17
G3 Z.6 I-.137 J1.209 P1  F60000
G1 X132.563 Y134.881 Z.6
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7017
M204 S4000
G1 X132.563 Y121.119 E.28545
G1 X123.437 Y121.119 E.18929
G1 X123.437 Y134.881 E.28545
G1 X132.503 Y134.881 E.18804
M204 S250
G1 X132.972 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2880
M204 S2000
G1 X132.972 Y120.71 E.28104
G1 F2999.283
G1 X132.901 Y120.71 E.00137
G1 F3600
G1 X132.501 Y120.71 E.00771
G1 X123.499 Y120.71 E.17352
G1 X123.099 Y120.71 E.00771
G1 F2999.283
G1 X123.028 Y120.71 E.00137
G1 F2880
G1 X123.028 Y135.29 E.28104
G1 F2999.283
G1 X123.099 Y135.29 E.00137
G1 F3600
G1 X123.499 Y135.29 E.00771
G1 X132.901 Y135.29 E.18123
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 X132.912 Y135.29 E.00021
; WIPE_START
M204 S4000
G1 X132.92 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.575 Y134.71 Z.72 F60000
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.429782
G1 F7017
M204 S4000
G1 X132.215 Y134.07 E.01789
G1 X132.215 Y133.499 E.01129
G1 X131.181 Y134.533 E.02889
G1 X130.609 Y134.533 E.01129
G1 X132.215 Y132.927 E.04486
G1 X132.215 Y132.356 E.01129
G1 X130.038 Y134.533 E.06082
G1 X129.466 Y134.533 E.01129
G1 X132.215 Y131.784 E.07678
G1 X132.215 Y131.213 E.01129
G1 X128.895 Y134.533 E.09274
G1 X128.324 Y134.533 E.01129
G1 X132.215 Y130.642 E.10871
G1 X132.215 Y130.07 E.01129
G1 X127.752 Y134.533 E.12467
G1 X127.181 Y134.533 E.01129
G1 X132.215 Y129.499 E.14063
G1 X132.215 Y128.928 E.01129
G1 X126.61 Y134.533 E.15659
G1 X126.038 Y134.533 E.01129
G1 X132.215 Y128.356 E.17256
G1 X132.215 Y127.785 E.01129
G1 X125.467 Y134.533 E.18852
G1 X124.895 Y134.533 E.01129
G1 X132.215 Y127.213 E.20448
G1 X132.215 Y126.642 E.01129
G1 X124.324 Y134.533 E.22044
G1 X123.785 Y134.533 E.01065
G1 X123.785 Y134.5 E.00064
G1 X132.215 Y126.071 E.2355
G1 X132.215 Y125.499 E.01129
G1 X123.785 Y133.929 E.2355
G1 X123.785 Y133.358 E.01129
G1 X132.215 Y124.928 E.2355
G1 X132.215 Y124.356 E.01129
G1 X123.785 Y132.786 E.2355
G1 X123.785 Y132.215 E.01129
G1 X132.215 Y123.785 E.2355
G1 X132.215 Y123.214 E.01129
G1 X123.785 Y131.644 E.2355
G1 X123.785 Y131.072 E.01129
G1 X132.215 Y122.642 E.2355
G1 X132.215 Y122.071 E.01129
G1 X123.785 Y130.501 E.2355
G1 X123.785 Y129.929 E.01129
G1 X132.215 Y121.5 E.2355
G1 X132.215 Y121.467 E.00064
G1 X131.676 Y121.467 E.01065
G1 X123.785 Y129.358 E.22044
G1 X123.785 Y128.787 E.01129
G1 X131.105 Y121.467 E.20448
G1 X130.533 Y121.467 E.01129
G1 X123.785 Y128.215 E.18852
G1 X123.785 Y127.644 E.01129
G1 X129.962 Y121.467 E.17256
G1 X129.39 Y121.467 E.01129
G1 X123.785 Y127.072 E.15659
G1 X123.785 Y126.501 E.01129
G1 X128.819 Y121.467 E.14063
G1 X128.248 Y121.467 E.01129
G1 X123.785 Y125.93 E.12467
G1 X123.785 Y125.358 E.01129
G1 X127.676 Y121.467 E.10871
G1 X127.105 Y121.467 E.01129
G1 X123.785 Y124.787 E.09274
G1 X123.785 Y124.216 E.01129
G1 X126.534 Y121.467 E.07678
G1 X125.962 Y121.467 E.01129
G1 X123.785 Y123.644 E.06082
G1 X123.785 Y123.073 E.01129
G1 X125.391 Y121.467 E.04486
G1 X124.819 Y121.467 E.01129
G1 X123.785 Y122.501 E.02889
G1 X123.785 Y121.93 E.01129
G1 X124.425 Y121.29 E.01789
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.785 Y121.93 E-.3441
G1 X123.785 Y122.501 E-.21713
G1 X124.155 Y122.131 E-.19877
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L3
M991 S0 P2 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.72 I-1.013 J.675 P1  F60000
G1 X132.647 Y134.881 Z.72
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7009
M204 S4000
G1 X132.647 Y121.119 E.28545
G1 X123.353 Y121.119 E.19277
G1 X123.353 Y134.881 E.28545
G1 X132.587 Y134.881 E.19153
; COOLING_NODE: 0
M204 S250
G1 X133.056 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3398
M204 S2000
G1 X133.056 Y120.71 E.28104
G1 X133.013 Y120.71 E.00083
G1 X122.987 Y120.71 E.19326
G1 X122.944 Y120.71 E.00083
G1 X122.944 Y135.29 E.28104
G1 X122.987 Y135.29 E.00083
G1 X132.996 Y135.29 E.19293
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.004 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.472 Y134.523 Z.84 F60000
G1 X124.326 Y134.71 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.422652
G1 F7009
M204 S4000
G1 X123.701 Y134.085 E.01715
G1 X123.701 Y133.524 E.01089
G1 X124.71 Y134.533 E.02769
G1 X125.271 Y134.533 E.01089
G1 X123.701 Y132.963 E.04309
G1 X123.701 Y132.401 E.01089
G1 X125.833 Y134.533 E.0585
G1 X126.394 Y134.533 E.01089
G1 X123.701 Y131.84 E.0739
G1 X123.701 Y131.279 E.01089
G1 X126.955 Y134.533 E.08931
G1 X127.517 Y134.533 E.01089
G1 X123.701 Y130.717 E.10471
G1 X123.701 Y130.156 E.01089
G1 X128.078 Y134.533 E.12011
G1 X128.639 Y134.533 E.01089
G1 X123.701 Y129.595 E.13552
G1 X123.701 Y129.034 E.01089
G1 X129.2 Y134.533 E.15092
G1 X129.762 Y134.533 E.01089
G1 X123.701 Y128.472 E.16633
G1 X123.701 Y127.911 E.01089
G1 X130.323 Y134.533 E.18173
G1 X130.884 Y134.533 E.01089
G1 X123.701 Y127.35 E.19713
G1 X123.701 Y126.788 E.01089
G1 X131.446 Y134.533 E.21254
G1 X132.007 Y134.533 E.01089
G1 X123.701 Y126.227 E.22794
G1 X123.701 Y125.666 E.01089
G1 X132.299 Y134.263 E.23595
G1 X132.299 Y133.702 E.01089
G1 X123.701 Y125.104 E.23595
G1 X123.701 Y124.543 E.01089
G1 X132.299 Y133.141 E.23595
G1 X132.299 Y132.58 E.01089
G1 X123.701 Y123.982 E.23595
G1 X123.701 Y123.42 E.01089
G1 X132.299 Y132.018 E.23595
G1 X132.299 Y131.457 E.01089
G1 X123.701 Y122.859 E.23595
G1 X123.701 Y122.298 E.01089
G1 X132.299 Y130.896 E.23595
G1 X132.299 Y130.334 E.01089
G1 X123.701 Y121.737 E.23595
G1 X123.701 Y121.467 E.00523
G1 X123.993 Y121.467 E.00566
G1 X132.299 Y129.773 E.22794
G1 X132.299 Y129.212 E.01089
G1 X124.554 Y121.467 E.21254
G1 X125.116 Y121.467 E.01089
G1 X132.299 Y128.65 E.19714
G1 X132.299 Y128.089 E.01089
G1 X125.677 Y121.467 E.18173
G1 X126.238 Y121.467 E.01089
G1 X132.299 Y127.528 E.16633
G1 X132.299 Y126.967 E.01089
G1 X126.799 Y121.467 E.15092
G1 X127.361 Y121.467 E.01089
G1 X132.299 Y126.405 E.13552
G1 X132.299 Y125.844 E.01089
G1 X127.922 Y121.467 E.12012
G1 X128.483 Y121.467 E.01089
G1 X132.299 Y125.283 E.10471
G1 X132.299 Y124.721 E.01089
G1 X129.045 Y121.467 E.08931
G1 X129.606 Y121.467 E.01089
G1 X132.299 Y124.16 E.0739
G1 X132.299 Y123.599 E.01089
G1 X130.167 Y121.467 E.0585
M73 P26 R15
G1 X130.729 Y121.467 E.01089
G1 X132.299 Y123.037 E.0431
G1 X132.299 Y122.476 E.01089
G1 X131.29 Y121.467 E.02769
G1 X131.851 Y121.467 E.01089
G1 X132.476 Y122.092 E.01716
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X131.851 Y121.467 E-.33597
G1 X131.29 Y121.467 E-.21329
G1 X131.682 Y121.859 E-.21073
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L4
M991 S0 P3 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.84 I-1.213 J.098 P1  F60000
G1 X132.731 Y134.881 Z.84
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7079
M204 S4000
G1 X132.731 Y121.119 E.28545
G1 X123.269 Y121.119 E.19626
G1 X123.269 Y134.881 E.28545
G1 X132.671 Y134.881 E.19501
; COOLING_NODE: 0
M204 S250
G1 X133.14 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3248
M204 S2000
G1 X133.14 Y120.71 E.28104
G1 X133.097 Y120.71 E.00083
G1 X122.903 Y120.71 E.1965
G1 X122.86 Y120.71 E.00083
G1 X122.86 Y135.29 E.28104
G1 X122.903 Y135.29 E.00083
G1 X133.08 Y135.29 E.19617
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.088 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.751 Y134.71 Z.96 F60000
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.425622
G1 F7079
M204 S4000
G1 X132.383 Y134.079 E.01746
G1 X132.383 Y133.513 E.01106
G1 X131.363 Y134.533 E.02819
G1 X130.798 Y134.533 E.01106
G1 X132.383 Y132.948 E.04382
G1 X132.383 Y132.382 E.01106
G1 X130.232 Y134.533 E.05946
G1 X129.667 Y134.533 E.01106
G1 X132.383 Y131.817 E.0751
G1 X132.383 Y131.251 E.01106
G1 X129.101 Y134.533 E.09073
G1 X128.536 Y134.533 E.01106
G1 X132.383 Y130.686 E.10637
G1 X132.383 Y130.12 E.01106
G1 X127.97 Y134.533 E.122
G1 X127.405 Y134.533 E.01106
G1 X132.383 Y129.555 E.13764
G1 X132.383 Y128.989 E.01106
G1 X126.839 Y134.533 E.15327
G1 X126.274 Y134.533 E.01106
G1 X132.383 Y128.424 E.16891
G1 X132.383 Y127.858 E.01106
G1 X125.708 Y134.533 E.18454
G1 X125.143 Y134.533 E.01106
G1 X132.383 Y127.293 E.20018
G1 X132.383 Y126.727 E.01106
G1 X124.577 Y134.533 E.21581
G1 X124.012 Y134.533 E.01106
G1 X132.383 Y126.162 E.23145
G1 X132.383 Y125.596 E.01106
G1 X123.617 Y134.362 E.24236
G1 X123.617 Y133.797 E.01106
G1 X132.383 Y125.031 E.24236
G1 X132.383 Y124.465 E.01106
G1 X123.617 Y133.231 E.24236
G1 X123.617 Y132.666 E.01106
G1 X132.383 Y123.9 E.24236
G1 X132.383 Y123.334 E.01106
G1 X123.617 Y132.1 E.24236
G1 X123.617 Y131.535 E.01106
G1 X132.383 Y122.769 E.24236
G1 X132.383 Y122.203 E.01106
G1 X123.617 Y130.969 E.24236
G1 X123.617 Y130.404 E.01106
G1 X132.383 Y121.638 E.24236
G1 X132.383 Y121.467 E.00334
G1 X131.988 Y121.467 E.00772
G1 X123.617 Y129.838 E.23145
G1 X123.617 Y129.273 E.01106
G1 X131.423 Y121.467 E.21581
G1 X130.857 Y121.467 E.01106
G1 X123.617 Y128.707 E.20018
G1 X123.617 Y128.142 E.01106
G1 X130.292 Y121.467 E.18454
G1 X129.726 Y121.467 E.01106
G1 X123.617 Y127.576 E.16891
G1 X123.617 Y127.011 E.01106
G1 X129.161 Y121.467 E.15327
G1 X128.595 Y121.467 E.01106
G1 X123.617 Y126.445 E.13764
G1 X123.617 Y125.88 E.01106
G1 X128.03 Y121.467 E.122
G1 X127.464 Y121.467 E.01106
G1 X123.617 Y125.314 E.10636
G1 X123.617 Y124.749 E.01106
G1 X126.899 Y121.467 E.09073
G1 X126.333 Y121.467 E.01106
G1 X123.617 Y124.183 E.07509
G1 X123.617 Y123.618 E.01106
G1 X125.768 Y121.467 E.05946
G1 X125.202 Y121.467 E.01106
G1 X123.617 Y123.052 E.04382
G1 X123.617 Y122.487 E.01106
G1 X124.637 Y121.467 E.02819
G1 X124.071 Y121.467 E.01106
G1 X123.44 Y122.098 E.01746
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.071 Y121.467 E-.33932
G1 X124.637 Y121.467 E-.21489
G1 X124.254 Y121.85 E-.2058
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L5
M991 S0 P4 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.96 I-1.017 J.668 P1  F60000
G1 X132.815 Y134.881 Z.96
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7193
M204 S4000
G1 X132.815 Y121.119 E.28545
G1 X123.185 Y121.119 E.19974
G1 X123.185 Y134.881 E.28545
G1 X132.755 Y134.881 E.1985
; COOLING_NODE: 0
M204 S250
G1 X133.224 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3119
M204 S2000
G1 X133.224 Y120.71 E.28104
G1 X133.181 Y120.71 E.00083
G1 X122.819 Y120.71 E.19973
G1 X122.776 Y120.71 E.00083
G1 X122.776 Y135.29 E.28104
G1 X122.819 Y135.29 E.00083
G1 X133.164 Y135.29 E.19941
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.172 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.633 Y134.48 Z1.08 F60000
G1 X124.171 Y134.71 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.428592
G1 F7193
M204 S4000
G1 X123.533 Y134.073 E.01776
G1 X123.533 Y133.503 E.01122
G1 X124.563 Y134.533 E.02869
G1 X125.133 Y134.533 E.01122
G1 X123.533 Y132.933 E.04456
G1 X123.533 Y132.364 E.01122
G1 X125.702 Y134.533 E.06043
G1 X126.272 Y134.533 E.01122
G1 X123.533 Y131.794 E.07629
G1 X123.533 Y131.224 E.01122
G1 X126.842 Y134.533 E.09216
G1 X127.412 Y134.533 E.01122
G1 X123.533 Y130.654 E.10803
G1 X123.533 Y130.085 E.01122
G1 X127.981 Y134.533 E.1239
G1 X128.551 Y134.533 E.01122
G1 X123.533 Y129.515 E.13977
G1 X123.533 Y128.945 E.01122
G1 X129.121 Y134.533 E.15564
G1 X129.69 Y134.533 E.01122
G1 X123.533 Y128.376 E.17151
G1 X123.533 Y127.806 E.01122
G1 X130.26 Y134.533 E.18737
G1 X130.83 Y134.533 E.01122
G1 X123.533 Y127.236 E.20324
G1 X123.533 Y126.666 E.01122
G1 X131.399 Y134.533 E.21911
G1 X131.969 Y134.533 E.01122
G1 X123.533 Y126.097 E.23498
G1 X123.533 Y125.527 E.01122
G1 X132.467 Y134.461 E.24884
G1 X132.467 Y133.891 E.01122
G1 X123.533 Y124.957 E.24884
G1 X123.533 Y124.388 E.01122
G1 X132.467 Y133.321 E.24884
G1 X132.467 Y132.752 E.01122
G1 X123.533 Y123.818 E.24884
G1 X123.533 Y123.248 E.01122
G1 X132.467 Y132.182 E.24884
G1 X132.467 Y131.612 E.01122
G1 X123.533 Y122.679 E.24884
G1 X123.533 Y122.109 E.01122
G1 X132.467 Y131.043 E.24884
G1 X132.467 Y130.473 E.01122
G1 X123.533 Y121.539 E.24884
G1 X123.533 Y121.467 E.00142
G1 X124.031 Y121.467 E.0098
G1 X132.467 Y129.903 E.23498
G1 X132.467 Y129.334 E.01122
G1 X124.6 Y121.467 E.21911
G1 X125.17 Y121.467 E.01122
G1 X132.467 Y128.764 E.20325
G1 X132.467 Y128.194 E.01122
G1 X125.74 Y121.467 E.18738
G1 X126.31 Y121.467 E.01122
G1 X132.467 Y127.624 E.17151
G1 X132.467 Y127.055 E.01122
G1 X126.879 Y121.467 E.15564
G1 X127.449 Y121.467 E.01122
G1 X132.467 Y126.485 E.13977
G1 X132.467 Y125.915 E.01122
G1 X128.019 Y121.467 E.1239
G1 X128.588 Y121.467 E.01122
G1 X132.467 Y125.346 E.10803
G1 X132.467 Y124.776 E.01122
G1 X129.158 Y121.467 E.09217
G1 X129.728 Y121.467 E.01122
G1 X132.467 Y124.206 E.0763
G1 X132.467 Y123.637 E.01122
G1 X130.297 Y121.467 E.06043
G1 X130.867 Y121.467 E.01122
G1 X132.467 Y123.067 E.04456
G1 X132.467 Y122.497 E.01122
G1 X131.437 Y121.467 E.02869
G1 X132.007 Y121.467 E.01122
G1 X132.644 Y122.105 E.01776
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X132.007 Y121.467 E-.34274
G1 X131.437 Y121.467 E-.21649
G1 X131.81 Y121.841 E-.20077
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L6
M991 S0 P5 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.08 I-1.213 J.101 P1  F60000
G1 X132.899 Y134.881 Z1.08
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2825
M204 S4000
G1 X132.899 Y121.119 E.28545
G1 X123.101 Y121.119 E.20323
G1 X123.101 Y134.881 E.28545
G1 X132.839 Y134.881 E.20198
; COOLING_NODE: 0
M204 S250
G1 X133.308 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2825
M204 S2000
M73 P27 R15
G1 X133.308 Y120.71 E.28104
G1 X133.265 Y120.71 E.00083
G1 X122.735 Y120.71 E.20297
G1 X122.692 Y120.71 E.00083
G1 X122.692 Y135.29 E.28104
G1 X122.735 Y135.29 E.00083
G1 X133.248 Y135.29 E.20265
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.256 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.508 Y134.49 Z1.2 F60000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2825
M204 S4000
G1 X132.508 Y121.57 E.2259
M204 S10000
G1 X129.818 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2825
M204 S4000
G1 X131.515 Y121.482 E.0352
G2 X130.236 Y123.903 I1.765 J2.481 E.05891
G1 X130.516 Y124.358 E.01109
G3 X131.986 Y125.269 I-6.34 J11.884 E.0359
G1 X132.117 Y125.454 E.0047
G1 X132.117 Y128.265 E.05831
G1 X131.98 Y128.455 E.00487
G2 X130.236 Y131.186 I1.415 J2.826 E.07057
G1 X130.516 Y131.642 E.01109
G3 X131.986 Y132.552 I-6.338 J11.88 E.0359
G1 X132.117 Y132.737 E.0047
G1 X132.117 Y134.434 E.0352
M204 S10000
G1 X123.492 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2825
M204 S4000
G1 X123.492 Y121.57 E.2259
M204 S10000
G1 X123.883 Y123.462 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2825
M204 S4000
G1 X123.883 Y121.765 E.0352
G3 X124.232 Y121.482 I.802 J.633 E.00938
G1 X126.615 Y121.482 E.04943
G1 X126.624 Y121.627 E.00302
G2 X128.338 Y123.903 I3.14 J-.581 E.06126
G1 X129.126 Y124.358 E.01887
G1 X129.406 Y124.814 E.01109
G1 X129.376 Y125.269 E.00946
G3 X127.662 Y127.545 I-3.14 J-.581 E.06126
G1 X126.874 Y128 E.01887
G1 X126.594 Y128.455 E.01109
G1 X126.624 Y128.91 E.00946
G2 X128.338 Y131.186 I3.14 J-.581 E.06126
G1 X129.126 Y131.642 E.01887
G1 X129.406 Y132.097 E.01109
G1 X129.376 Y132.552 E.00946
G3 X128.127 Y134.518 I-3.023 J-.541 E.04955
G1 X125.744 Y134.518 E.04943
G1 X125.734 Y134.373 E.00302
G2 X123.883 Y132.017 I-3.277 J.67 E.06443
G1 X123.883 Y129.048 E.0616
G3 X125.484 Y128 I5.368 J6.456 E.03978
G1 X125.764 Y127.545 E.01109
G1 X125.734 Y127.09 E.00946
G2 X123.883 Y124.734 I-3.277 J.67 E.06443
G1 X123.883 Y126.431 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X123.883 Y124.734 E-.64486
G1 X124.137 Y124.9 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L7
M991 S0 P6 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.2 I-.911 J.807 P1  F60000
G1 X132.983 Y134.881 Z1.2
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2870
M204 S4000
G1 X132.983 Y121.119 E.28545
G1 X123.017 Y121.119 E.20671
G1 X123.017 Y134.881 E.28545
G1 X132.923 Y134.881 E.20547
; COOLING_NODE: 0
M204 S250
G1 X133.392 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2870
M204 S2000
G1 X133.392 Y120.71 E.28104
G1 X133.349 Y120.71 E.00083
G1 X122.651 Y120.71 E.20621
G1 X122.608 Y120.71 E.00083
G1 X122.608 Y135.29 E.28104
G1 X122.651 Y135.29 E.00083
G1 X133.332 Y135.29 E.20588
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.34 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.592 Y134.49 Z1.32 F60000
G1 Z.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2870
M204 S4000
G1 X132.592 Y121.57 E.2259
M204 S10000
G1 X129.876 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2870
M204 S4000
G1 X131.573 Y121.482 E.0352
G2 X130.276 Y123.043 I1.826 J2.837 E.04275
G1 X129.821 Y124.148 E.02479
G3 X128.91 Y124.042 I-.324 J-1.177 E.01949
G3 X126.634 Y122.033 I.934 J-3.352 E.06517
G1 X126.408 Y121.482 E.01235
G1 X124.29 Y121.482 E.04393
G2 X123.799 Y121.858 I.625 J1.323 E.01292
G1 X123.799 Y124.83 E.06163
G3 X125.724 Y126.684 I-.992 J2.956 E.0573
G1 X126.179 Y127.79 E.02479
G2 X127.09 Y127.684 I.324 J-1.177 E.01949
G2 X129.366 Y125.674 I-.934 J-3.352 E.06517
G1 X129.821 Y124.569 E.02479
G3 X130.731 Y124.675 I.324 J1.177 E.01949
G3 X132.201 Y125.5 I-1.094 J3.671 E.03525
G1 X132.201 Y128.471 E.06164
G2 X130.276 Y130.326 I.992 J2.956 E.0573
G1 X129.821 Y131.431 E.02479
G3 X128.91 Y131.325 I-.324 J-1.177 E.01949
G3 X126.634 Y129.316 I.934 J-3.352 E.06517
G1 X126.179 Y128.211 E.02479
G2 X125.269 Y128.317 I-.324 J1.177 E.01949
G2 X123.799 Y129.141 I1.094 J3.671 E.03525
G1 X123.799 Y132.113 E.06163
G3 X125.724 Y133.967 I-.992 J2.956 E.0573
G1 X126.104 Y134.518 E.01387
G1 X128.069 Y134.518 E.04075
G2 X129.366 Y132.957 I-1.826 J-2.837 E.04275
G1 X129.821 Y131.852 E.02479
G3 X130.731 Y131.958 I.324 J1.177 E.01949
G3 X132.201 Y132.783 I-1.094 J3.671 E.03525
G1 X132.201 Y134.48 E.0352
M204 S10000
G1 X123.408 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2870
M204 S4000
G1 X123.408 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.408 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L8
M991 S0 P7 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.32 I-.925 J.79 P1  F60000
G1 X133.067 Y134.881 Z1.32
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2844
M204 S4000
G1 X133.067 Y121.119 E.28545
G1 X122.933 Y121.119 E.21019
G1 X122.933 Y134.881 E.28545
G1 X133.007 Y134.881 E.20895
; COOLING_NODE: 0
M204 S250
G1 X133.476 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2844
M204 S2000
G1 X133.476 Y120.71 E.28104
G1 X133.433 Y120.71 E.00083
G1 X122.567 Y120.71 E.20945
G1 X122.524 Y120.71 E.00083
G1 X122.524 Y135.29 E.28104
G1 X122.567 Y135.29 E.00083
G1 X133.416 Y135.29 E.20912
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.424 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.676 Y134.49 Z1.44 F60000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2844
M204 S4000
G1 X132.676 Y121.57 E.2259
M204 S10000
G1 X129.956 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2844
M204 S4000
G1 X131.653 Y121.482 E.0352
G2 X130.276 Y122.849 I1.392 J2.78 E.04093
G1 X129.821 Y123.609 E.01838
G1 X129.366 Y123.904 E.01126
G1 X128.91 Y123.891 E.00945
G3 X126.634 Y122.226 I.521 J-3.101 E.06065
G1 X126.189 Y121.482 E.018
G1 X124.37 Y121.482 E.03772
G2 X123.715 Y121.937 I1.7 J3.148 E.01657
G1 X123.715 Y124.915 E.06177
G3 X125.724 Y126.49 I-.677 J2.932 E.0547
G1 X126.179 Y127.25 E.01838
G1 X126.634 Y127.546 E.01126
G1 X127.09 Y127.532 E.00945
G2 X129.366 Y125.868 I-.521 J-3.101 E.06065
G1 X129.821 Y125.108 E.01838
G1 X130.276 Y124.812 E.01126
G1 X130.731 Y124.826 E.00945
G3 X132.285 Y125.578 I-.543 J3.103 E.03627
G1 X132.285 Y128.556 E.06177
G2 X130.276 Y130.132 I.677 J2.932 E.0547
G1 X129.821 Y130.892 E.01838
G1 X129.366 Y131.188 E.01126
G1 X128.91 Y131.174 E.00945
G3 X126.634 Y129.51 I.521 J-3.101 E.06065
G1 X126.179 Y128.75 E.01838
G1 X125.724 Y128.454 E.01126
G1 X125.269 Y128.468 E.00945
G2 X123.715 Y129.22 I.543 J3.103 E.03627
G1 X123.715 Y132.198 E.06177
M73 P28 R15
G3 X125.724 Y133.774 I-.677 J2.932 E.0547
G1 X126.17 Y134.518 E.018
G1 X128 Y134.514 E.03796
G2 X129.366 Y133.151 I-1.614 J-2.983 E.04058
G1 X129.821 Y132.391 E.01838
G1 X130.276 Y132.096 E.01126
G1 X130.731 Y132.109 E.00945
G3 X132.285 Y132.861 I-.543 J3.103 E.03627
G1 X132.285 Y134.518 E.03436
G1 X132.245 Y134.518 E.00084
M204 S10000
G1 X123.324 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2844
M204 S4000
G1 X123.324 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.324 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L9
M991 S0 P8 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.44 I-.919 J.798 P1  F60000
G1 X133.151 Y134.881 Z1.44
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2841
M204 S4000
G1 X133.151 Y121.119 E.28545
G1 X122.849 Y121.119 E.21368
G1 X122.849 Y134.881 E.28545
G1 X133.091 Y134.881 E.21244
; COOLING_NODE: 0
M204 S250
G1 X133.56 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2841
M204 S2000
G1 X133.56 Y120.71 E.28104
G1 X133.517 Y120.71 E.00083
G1 X122.483 Y120.71 E.21269
G1 X122.44 Y120.71 E.00083
G1 X122.44 Y135.29 E.28104
G1 X122.483 Y135.29 E.00083
G1 X133.5 Y135.29 E.21236
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.508 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.76 Y134.49 Z1.56 F60000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2841
M204 S4000
G1 X132.76 Y121.57 E.2259
M204 S10000
G1 X132.369 Y122.65 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2841
M204 S4000
G1 X132.369 Y121.482 E.02422
G2 X130.731 Y122.139 I-.141 J2.02 E.03787
G1 X129.821 Y123.344 E.03133
G1 X129.366 Y123.692 E.01188
G1 X128.91 Y123.758 E.00954
G3 X127.09 Y122.937 I.244 J-2.968 E.04226
G1 X126.179 Y121.731 E.03133
G1 X125.854 Y121.482 E.0085
G1 X124.557 Y121.482 E.0269
G2 X123.631 Y121.989 I.617 J2.226 E.02209
G1 X123.631 Y125.001 E.06248
G3 X125.269 Y125.78 I-.312 J2.767 E.03832
G1 X126.179 Y126.986 E.03133
G1 X126.634 Y127.334 E.01188
G1 X127.09 Y127.4 E.00954
G2 X128.91 Y126.578 I-.244 J-2.968 E.04226
G1 X129.821 Y125.373 E.03133
G1 X130.276 Y125.025 E.01189
G1 X130.731 Y124.959 E.00954
G3 X132.369 Y125.63 I-.203 J2.826 E.03734
G1 X132.369 Y128.643 E.06248
G2 X130.731 Y129.422 I.312 J2.767 E.03832
G1 X129.821 Y130.627 E.03133
G1 X129.366 Y130.975 E.01188
G1 X128.91 Y131.042 E.00954
G3 X127.09 Y130.22 I.244 J-2.968 E.04226
G1 X126.179 Y129.014 E.03133
G1 X125.724 Y128.666 E.01189
G1 X125.269 Y128.6 E.00954
G2 X123.631 Y129.272 I.203 J2.826 E.03735
G1 X123.631 Y132.284 E.06248
G3 X125.269 Y133.063 I-.312 J2.767 E.03832
G1 X126.179 Y134.269 E.03134
G1 X126.505 Y134.518 E.0085
G1 X127.73 Y134.518 E.02541
G2 X128.91 Y133.861 I-.455 J-2.207 E.02845
G1 X129.821 Y132.656 E.03133
G1 X130.276 Y132.308 E.01188
G1 X130.731 Y132.242 E.00954
G3 X132.369 Y132.914 I-.202 J2.826 E.03734
G1 X132.369 Y134.518 E.03328
G1 X132.276 Y134.518 E.00192
M204 S10000
G1 X123.24 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2841
M204 S4000
G1 X123.24 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.24 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L10
M991 S0 P9 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.56 I-.912 J.806 P1  F60000
G1 X133.235 Y134.881 Z1.56
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2847
M204 S4000
G1 X133.235 Y121.119 E.28545
G1 X122.765 Y121.119 E.21716
G1 X122.765 Y134.881 E.28545
G1 X133.175 Y134.881 E.21592
; COOLING_NODE: 0
M204 S250
G1 X133.644 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2847
M204 S2000
G1 X133.644 Y120.71 E.28104
G1 X133.601 Y120.71 E.00083
G1 X122.399 Y120.71 E.21593
G1 X122.356 Y120.71 E.00083
G1 X122.356 Y135.29 E.28104
G1 X122.399 Y135.29 E.00083
G1 X133.584 Y135.29 E.2156
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.592 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.844 Y134.49 Z1.68 F60000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2847
M204 S4000
G1 X132.844 Y121.57 E.2259
M204 S10000
G1 X132.453 Y122.698 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2847
M204 S4000
G1 X132.453 Y121.482 E.02522
G2 X130.731 Y122.089 I-.149 J2.323 E.03892
G1 X129.821 Y123.149 E.02898
G3 X128.455 Y123.623 I-1.116 J-1.012 E.03127
G3 X127.09 Y122.986 I.519 J-2.893 E.03161
G1 X126.179 Y121.926 E.02898
G1 X125.724 Y121.556 E.01216
G2 X123.547 Y122.019 I-.664 J2.229 E.04814
G1 X123.547 Y125.079 E.06348
G3 X125.269 Y125.731 I.02 J2.548 E.03907
G1 X126.179 Y126.791 E.02898
G2 X127.545 Y127.265 I1.116 J-1.012 E.03127
G2 X128.91 Y126.628 I-.519 J-2.893 E.03161
G1 X129.821 Y125.567 E.02898
G3 X131.186 Y125.094 I1.116 J1.012 E.03127
G3 X132.453 Y125.66 I-.485 J2.784 E.02908
G1 X132.453 Y128.721 E.06348
G2 X130.731 Y129.373 I-.02 J2.548 E.03907
G1 X129.821 Y130.433 E.02898
G3 X128.455 Y130.907 I-1.116 J-1.012 E.03127
G3 X127.09 Y130.269 I.519 J-2.893 E.03161
G1 X126.179 Y129.209 E.02898
G2 X124.814 Y128.735 I-1.116 J1.012 E.03127
G2 X123.547 Y129.302 I.485 J2.784 E.02908
G1 X123.547 Y132.362 E.06348
G3 X125.269 Y133.014 I.02 J2.548 E.03907
G1 X126.179 Y134.074 E.02898
G1 X126.634 Y134.444 E.01216
G2 X128.91 Y133.911 I.666 J-2.282 E.05069
G1 X129.821 Y132.851 E.02898
G3 X131.186 Y132.377 I1.116 J1.012 E.03127
G3 X132.453 Y132.943 I-.485 J2.784 E.02908
G1 X132.453 Y134.518 E.03266
G1 X132.331 Y134.518 E.00254
M204 S10000
G1 X123.156 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2847
M204 S4000
G1 X123.156 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.156 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L11
M991 S0 P10 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.68 I-.905 J.813 P1  F60000
G1 X133.319 Y134.881 Z1.68
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2867
M204 S4000
G1 X133.319 Y121.119 E.28545
G1 X122.681 Y121.119 E.22065
G1 X122.681 Y134.881 E.28545
G1 X133.259 Y134.881 E.2194
; COOLING_NODE: 0
M204 S250
G1 X133.728 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2867
M204 S2000
G1 X133.728 Y120.71 E.28104
G1 X133.685 Y120.71 E.00083
G1 X122.315 Y120.71 E.21916
G1 X122.272 Y120.71 E.00083
G1 X122.272 Y135.29 E.28104
G1 X122.315 Y135.29 E.00083
G1 X133.668 Y135.29 E.21884
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.676 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.928 Y134.49 Z1.8 F60000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2867
M204 S4000
G1 X132.928 Y121.57 E.2259
M204 S10000
G1 X132.537 Y123.233 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2867
M204 S4000
G1 X132.537 Y121.536 E.0352
G2 X130.731 Y122.037 I-.304 J2.408 E.03991
G3 X129.366 Y123.371 I-6.759 J-5.552 E.03968
M73 P29 R15
G3 X127.09 Y123.038 I-.858 J-2.078 E.05009
G2 X125.724 Y121.704 I-6.758 J5.551 E.03968
G2 X123.463 Y122.028 I-.857 J2.07 E.04972
G1 X123.463 Y125.178 E.06533
G3 X125.269 Y125.679 I.304 J2.409 E.03991
G2 X126.634 Y127.013 I6.759 J-5.552 E.03968
G2 X128.91 Y126.68 I.858 J-2.078 E.05009
G3 X130.276 Y125.345 I6.758 J5.551 E.03968
G3 X132.537 Y125.67 I.857 J2.07 E.04972
G1 X132.537 Y128.819 E.06533
G2 X130.731 Y129.32 I-.304 J2.409 E.03991
G3 X129.366 Y130.655 I-6.759 J-5.552 E.03968
G3 X127.09 Y130.321 I-.858 J-2.078 E.05009
G2 X125.724 Y128.987 I-6.759 J5.552 E.03968
G2 X123.463 Y129.311 I-.857 J2.07 E.04972
G1 X123.463 Y132.461 E.06533
G3 X125.269 Y132.962 I.304 J2.409 E.03991
G2 X126.634 Y134.296 I6.759 J-5.552 E.03968
G2 X128.91 Y133.963 I.858 J-2.078 E.05009
G3 X130.276 Y132.629 I6.758 J5.551 E.03968
G3 X132.537 Y132.953 I.857 J2.07 E.04972
G1 X132.537 Y134.518 E.03247
G1 X132.405 Y134.518 E.00273
M204 S10000
G1 X123.072 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
M73 P29 R14
G1 F2867
M204 S4000
G1 X123.072 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X123.072 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L12
M991 S0 P11 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.8 I-.899 J.821 P1  F60000
G1 X133.403 Y134.881 Z1.8
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2884
M204 S4000
G1 X133.403 Y121.119 E.28545
G1 X122.597 Y121.119 E.22413
G1 X122.597 Y134.881 E.28545
G1 X133.343 Y134.881 E.22289
; COOLING_NODE: 0
M204 S250
G1 X133.812 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2884
M204 S2000
G1 X133.812 Y120.71 E.28104
G1 X133.769 Y120.71 E.00083
G1 X122.231 Y120.71 E.2224
G1 X122.188 Y120.71 E.00083
G1 X122.188 Y135.29 E.28104
G1 X122.231 Y135.29 E.00083
G1 X133.752 Y135.29 E.22208
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.76 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.012 Y134.49 Z1.92 F60000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2884
M204 S4000
G1 X133.012 Y121.57 E.2259
M204 S10000
G1 X132.621 Y123.357 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2884
M204 S4000
G1 X132.621 Y121.66 E.0352
G2 X130.276 Y122.367 I-.596 J2.267 E.05346
G3 X128.91 Y123.446 I-2.787 J-2.124 E.03648
G3 X126.634 Y122.708 I-.477 J-2.407 E.05184
G2 X125.269 Y121.629 I-2.787 J2.124 E.03648
G2 X123.379 Y122.04 I-.479 J2.345 E.0413
G1 X123.379 Y125.302 E.06765
G3 X125.724 Y126.009 I.596 J2.267 E.05346
G2 X127.09 Y127.088 I2.787 J-2.125 E.03648
G2 X129.366 Y126.35 I.477 J-2.407 E.05184
G3 X130.731 Y125.271 I2.787 J2.124 E.03648
G3 X132.621 Y125.682 I.479 J2.345 E.0413
G1 X132.621 Y128.943 E.06765
G2 X130.276 Y129.65 I-.596 J2.267 E.05346
G3 X128.91 Y130.729 I-2.787 J-2.125 E.03648
G3 X126.634 Y129.991 I-.477 J-2.407 E.05184
G2 X125.269 Y128.912 I-2.787 J2.125 E.03648
G2 X123.379 Y129.323 I-.479 J2.345 E.0413
G1 X123.379 Y132.585 E.06765
G3 X125.724 Y133.292 I.596 J2.266 E.05346
G2 X127.09 Y134.371 I2.787 J-2.124 E.03648
G2 X129.366 Y133.633 I.477 J-2.407 E.05184
G3 X130.731 Y132.554 I2.787 J2.124 E.03648
G3 X132.621 Y132.965 I.479 J2.345 E.0413
G1 X132.621 Y134.518 E.03221
G1 X132.477 Y134.518 E.00299
M204 S10000
G1 X122.988 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2884
M204 S4000
G1 X122.988 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.988 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L13
M991 S0 P12 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.92 I-.892 J.828 P1  F60000
G1 X133.487 Y134.881 Z1.92
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2907
M204 S4000
G1 X133.487 Y121.119 E.28545
G1 X122.513 Y121.119 E.22762
G1 X122.513 Y134.881 E.28545
G1 X133.427 Y134.881 E.22637
; COOLING_NODE: 0
M204 S250
G1 X133.896 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2907
M204 S2000
G1 X133.896 Y120.71 E.28104
G1 X133.853 Y120.71 E.00083
G1 X122.147 Y120.71 E.22564
G1 X122.104 Y120.71 E.00083
G1 X122.104 Y135.29 E.28104
G1 X122.147 Y135.29 E.00083
G1 X133.836 Y135.29 E.22531
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.844 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.096 Y134.49 Z2.04 F60000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2907
M204 S4000
G1 X133.096 Y121.57 E.2259
M204 S10000
G1 X132.705 Y123.49 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2907
M204 S4000
G1 X132.705 Y121.793 E.0352
G2 X130.276 Y122.267 I-.863 J2.038 E.05447
G3 X128.91 Y123.363 I-3.504 J-2.967 E.03654
G3 X126.179 Y122.355 I-.637 J-2.479 E.06424
G2 X123.295 Y122.038 I-1.613 J1.395 E.06619
G1 X123.295 Y125.435 E.07045
G3 X125.724 Y125.908 I.863 J2.038 E.05447
G2 X127.09 Y127.004 I3.504 J-2.968 E.03654
G2 X129.821 Y125.996 I.637 J-2.479 E.06424
G3 X132.705 Y125.68 I1.613 J1.395 E.06619
G1 X132.705 Y129.076 E.07045
G2 X130.276 Y129.55 I-.863 J2.038 E.05447
G3 X128.91 Y130.646 I-3.504 J-2.967 E.03654
G3 X126.179 Y129.638 I-.637 J-2.479 E.06424
G2 X123.295 Y129.321 I-1.613 J1.395 E.06619
G1 X123.295 Y132.718 E.07045
G3 X125.724 Y133.191 I.863 J2.038 E.05447
G2 X127.09 Y134.287 I3.504 J-2.968 E.03654
G2 X129.821 Y133.279 I.637 J-2.479 E.06424
G3 X132.705 Y132.963 I1.613 J1.395 E.06619
G1 X132.705 Y134.518 E.03225
G1 X132.563 Y134.518 E.00295
M204 S10000
G1 X122.904 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2907
M204 S4000
G1 X122.904 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.904 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L14
M991 S0 P13 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.04 I-.885 J.835 P1  F60000
G1 X133.571 Y134.881 Z2.04
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2934
M204 S4000
G1 X133.571 Y121.119 E.28545
G1 X122.429 Y121.119 E.2311
G1 X122.429 Y134.881 E.28545
G1 X133.511 Y134.881 E.22986
; COOLING_NODE: 0
M204 S250
G1 X133.98 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2930
M204 S2000
G1 X133.98 Y120.71 E.28104
G1 X133.937 Y120.71 E.00083
G1 X122.063 Y120.71 E.22888
G1 X122.02 Y120.71 E.00083
G1 X122.02 Y135.29 E.28104
G1 X122.063 Y135.29 E.00083
G1 X133.92 Y135.29 E.22855
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X133.928 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P30 R14
G1 X133.18 Y134.49 Z2.16 F60000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2934
M204 S4000
G1 X133.18 Y121.57 E.2259
M204 S10000
G1 X132.789 Y123.627 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2934
M204 S4000
G1 X132.789 Y121.93 E.0352
G2 X129.821 Y122.599 I-1.101 J2.035 E.06886
G3 X126.179 Y122.477 I-1.773 J-1.484 E.08704
G2 X123.211 Y122.019 I-1.729 J1.36 E.06857
G1 X123.211 Y125.572 E.0737
G3 X126.179 Y126.24 I1.101 J2.035 E.06887
G2 X129.821 Y126.118 I1.773 J-1.484 E.08704
G3 X132.789 Y125.66 I1.729 J1.36 E.06857
G1 X132.789 Y129.213 E.0737
G2 X129.821 Y129.882 I-1.101 J2.035 E.06886
G3 X126.179 Y129.76 I-1.773 J-1.484 E.08704
G2 X123.211 Y129.302 I-1.729 J1.36 E.06857
G1 X123.211 Y132.855 E.0737
G3 X126.179 Y133.523 I1.101 J2.035 E.06887
G2 X129.821 Y133.402 I1.773 J-1.484 E.08704
G3 X132.789 Y132.943 I1.729 J1.36 E.06857
G1 X132.789 Y134.518 E.03266
G1 X132.667 Y134.518 E.00254
M204 S10000
G1 X122.82 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2934
M204 S4000
G1 X122.82 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.82 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L15
M991 S0 P14 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.16 I-.879 J.842 P1  F60000
G1 X133.655 Y134.881 Z2.16
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2956
M204 S4000
G1 X133.655 Y121.119 E.28545
G1 X122.345 Y121.119 E.23459
G1 X122.345 Y134.881 E.28545
G1 X133.595 Y134.881 E.23334
; COOLING_NODE: 0
M204 S250
G1 X134.064 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2952
M204 S2000
G1 X134.064 Y120.71 E.28104
G1 X134.021 Y120.71 E.00083
G1 X121.979 Y120.71 E.23212
G1 X121.936 Y120.71 E.00083
G1 X121.936 Y135.29 E.28104
G1 X121.979 Y135.29 E.00083
G1 X134.004 Y135.29 E.23179
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.012 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.264 Y134.49 Z2.28 F60000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2956
M204 S4000
G1 X133.264 Y121.57 E.2259
M204 S10000
G1 X123.127 Y123.679 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2956
M204 S4000
G1 X123.127 Y121.982 E.0352
G3 X126.179 Y122.597 I1.189 J1.979 E.07088
G2 X129.821 Y122.478 I1.774 J-1.484 E.08702
G3 X132.873 Y122.074 I1.734 J1.364 E.07068
G1 X132.873 Y125.623 E.07362
G2 X129.821 Y126.239 I-1.189 J1.979 E.07087
G3 X126.179 Y126.12 I-1.774 J-1.484 E.08702
G2 X123.127 Y125.716 I-1.734 J1.364 E.07069
G1 X123.127 Y129.265 E.07362
G3 X126.179 Y129.88 I1.189 J1.979 E.07088
G2 X129.821 Y129.762 I1.774 J-1.484 E.08702
G3 X132.873 Y129.357 I1.734 J1.364 E.07068
G1 X132.873 Y132.907 E.07362
G2 X129.821 Y133.522 I-1.189 J1.979 E.07087
G3 X126.179 Y133.403 I-1.774 J-1.484 E.08702
G2 X123.127 Y132.999 I-1.734 J1.364 E.07069
G1 X123.127 Y134.518 E.03151
G1 X123.305 Y134.518 E.00369
M204 S10000
G1 X122.736 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2956
M204 S4000
G1 X122.736 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.736 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L16
M991 S0 P15 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.28 I-.872 J.849 P1  F60000
G1 X133.739 Y134.881 Z2.28
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2974
M204 S4000
G1 X133.739 Y121.119 E.28545
G1 X122.261 Y121.119 E.23807
G1 X122.261 Y134.881 E.28545
G1 X133.679 Y134.881 E.23683
; COOLING_NODE: 0
M204 S250
G1 X134.148 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2974
M204 S2000
G1 X134.148 Y120.71 E.28104
G1 X134.105 Y120.71 E.00083
G1 X121.895 Y120.71 E.23536
G1 X121.852 Y120.71 E.00083
G1 X121.852 Y135.29 E.28104
G1 X121.895 Y135.29 E.00083
G1 X134.088 Y135.29 E.23503
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.096 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.348 Y134.49 Z2.4 F60000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2974
M204 S4000
G1 X133.348 Y121.57 E.2259
M204 S10000
G1 X123.043 Y123.624 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2974
M204 S4000
G1 X123.043 Y121.927 E.0352
G3 X125.724 Y122.265 I1.123 J1.894 E.06035
G2 X127.09 Y123.362 I3.515 J-2.98 E.03655
G2 X129.821 Y122.356 I.639 J-2.475 E.06422
G3 X132.957 Y122.228 I1.629 J1.428 E.07282
G1 X132.957 Y125.568 E.0693
G2 X130.276 Y125.907 I-1.123 J1.894 E.06035
G3 X128.91 Y127.003 I-3.516 J-2.981 E.03655
G3 X126.179 Y125.998 I-.639 J-2.475 E.06422
G2 X123.043 Y125.869 I-1.629 J1.428 E.07282
G1 X123.043 Y129.21 E.0693
G3 X125.724 Y129.549 I1.123 J1.894 E.06035
G2 X127.09 Y130.645 I3.516 J-2.981 E.03655
G2 X129.821 Y129.639 I.639 J-2.475 E.06422
G3 X132.957 Y129.511 I1.629 J1.428 E.07282
G1 X132.957 Y132.852 E.0693
G2 X130.276 Y133.19 I-1.123 J1.894 E.06035
G3 X128.91 Y134.286 I-3.516 J-2.981 E.03655
G3 X126.179 Y133.281 I-.639 J-2.475 E.06422
G2 X123.043 Y133.152 I-1.629 J1.428 E.07282
G1 X123.043 Y134.518 E.02833
G1 X123.374 Y134.518 E.00687
M204 S10000
G1 X122.652 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2974
M204 S4000
G1 X122.652 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.652 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L17
M991 S0 P16 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.4 I-.866 J.855 P1  F60000
G1 X133.823 Y134.881 Z2.4
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2994
M204 S4000
G1 X133.823 Y121.119 E.28545
G1 X122.177 Y121.119 E.24156
G1 X122.177 Y134.881 E.28545
G1 X133.763 Y134.881 E.24031
; COOLING_NODE: 0
M204 S250
G1 X134.232 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2994
M204 S2000
G1 X134.232 Y120.71 E.28104
G1 X134.189 Y120.71 E.00083
G1 X121.811 Y120.71 E.23859
M73 P31 R14
G1 X121.768 Y120.71 E.00083
G1 X121.768 Y135.29 E.28104
G1 X121.811 Y135.29 E.00083
G1 X134.172 Y135.29 E.23827
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.18 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.432 Y134.49 Z2.52 F60000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2994
M204 S4000
G1 X133.432 Y121.57 E.2259
M204 S10000
G1 X122.959 Y123.562 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2994
M204 S4000
G1 X122.959 Y121.865 E.0352
G3 X125.724 Y122.366 I1.076 J1.94 E.06312
G2 X127.09 Y123.445 I2.795 J-2.134 E.03648
G2 X129.366 Y122.709 I.48 J-2.405 E.05183
G3 X130.731 Y121.63 I2.795 J2.134 E.03648
G3 X133.041 Y122.402 I.482 J2.402 E.05286
G1 X133.041 Y125.506 E.0644
G2 X130.276 Y126.008 I-1.076 J1.94 E.06312
G3 X128.91 Y127.087 I-2.795 J-2.134 E.03648
G3 X126.634 Y126.351 I-.48 J-2.405 E.05183
G2 X125.269 Y125.272 I-2.795 J2.134 E.03648
G2 X122.959 Y126.043 I-.482 J2.402 E.05287
G1 X122.959 Y129.148 E.0644
G3 X125.724 Y129.649 I1.076 J1.94 E.06312
G2 X127.09 Y130.728 I2.795 J-2.134 E.03648
G2 X129.366 Y129.992 I.48 J-2.405 E.05183
G3 X130.731 Y128.914 I2.795 J2.134 E.03648
G3 X133.041 Y129.685 I.482 J2.402 E.05286
G1 X133.041 Y132.789 E.0644
G2 X130.276 Y133.291 I-1.076 J1.94 E.06312
G3 X128.91 Y134.37 I-2.795 J-2.134 E.03648
G3 X126.634 Y133.634 I-.48 J-2.405 E.05183
G2 X125.269 Y132.555 I-2.795 J2.133 E.03648
G2 X122.959 Y133.327 I-.482 J2.402 E.05287
G1 X122.959 Y134.518 E.02471
G1 X123.465 Y134.518 E.01049
M204 S10000
G1 X122.568 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F2994
M204 S4000
G1 X122.568 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.568 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L18
M991 S0 P17 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.52 I-.859 J.862 P1  F60000
G1 X133.907 Y134.881 Z2.52
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3019
M204 S4000
G1 X133.907 Y121.119 E.28545
G1 X122.093 Y121.119 E.24504
G1 X122.093 Y134.881 E.28545
G1 X133.847 Y134.881 E.2438
; COOLING_NODE: 0
M204 S250
G1 X134.316 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3017
M204 S2000
G1 X134.316 Y120.71 E.28104
G1 X134.273 Y120.71 E.00083
G1 X121.727 Y120.71 E.24183
G1 X121.684 Y120.71 E.00083
G1 X121.684 Y135.29 E.28104
G1 X121.727 Y135.29 E.00083
G1 X134.256 Y135.29 E.24151
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.264 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.516 Y134.49 Z2.64 F60000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3019
M204 S4000
G1 X133.516 Y121.57 E.2259
M204 S10000
G1 X122.875 Y123.502 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3019
M204 S4000
G1 X122.875 Y121.805 E.0352
G3 X124.814 Y121.754 I1.012 J1.622 E.04219
G1 X125.269 Y122.037 E.01111
G2 X126.634 Y123.37 I6.801 J-5.6 E.03966
G2 X128.91 Y123.039 I.86 J-2.076 E.05008
G3 X130.276 Y121.706 I6.8 J5.6 E.03966
G3 X132.552 Y122.037 I.86 J2.076 E.05008
G1 X133.125 Y122.635 E.01719
G1 X133.125 Y125.446 E.05831
G2 X131.186 Y125.396 I-1.012 J1.622 E.04219
G1 X130.731 Y125.678 E.01111
G3 X129.366 Y127.011 I-6.801 J-5.6 E.03966
G3 X127.09 Y126.68 I-.86 J-2.076 E.05008
G2 X125.724 Y125.347 I-6.8 J5.6 E.03966
G2 X123.448 Y125.678 I-.86 J2.076 E.05008
G1 X122.875 Y126.277 E.01719
G1 X122.875 Y129.088 E.05831
G3 X124.814 Y129.037 I1.012 J1.622 E.04219
G1 X125.269 Y129.32 E.01111
G2 X126.634 Y130.653 I6.801 J-5.601 E.03966
G2 X128.91 Y130.322 I.86 J-2.076 E.05008
G3 X130.276 Y128.989 I6.8 J5.599 E.03966
G3 X132.552 Y129.32 I.86 J2.076 E.05008
G1 X133.125 Y129.918 E.01719
G1 X133.125 Y132.729 E.05831
G2 X131.186 Y132.679 I-1.012 J1.622 E.04219
G1 X130.731 Y132.961 E.01111
G3 X129.366 Y134.294 I-6.801 J-5.601 E.03966
G3 X127.09 Y133.963 I-.86 J-2.076 E.05008
G2 X125.724 Y132.63 I-6.8 J5.6 E.03966
G2 X123.448 Y132.961 I-.86 J2.076 E.05008
G1 X122.875 Y133.56 E.01719
G1 X122.875 Y134.518 E.01987
G1 X123.614 Y134.518 E.01533
M204 S10000
G1 X122.484 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3019
M204 S4000
G1 X122.484 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.484 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L19
M991 S0 P18 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.64 I-.853 J.868 P1  F60000
G1 X133.991 Y134.881 Z2.64
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3048
M204 S4000
G1 X133.991 Y121.119 E.28545
G1 X122.009 Y121.119 E.24853
G1 X122.009 Y134.881 E.28545
G1 X133.931 Y134.881 E.24728
; COOLING_NODE: 0
M204 S250
G1 X134.4 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S2000
G1 X134.4 Y120.71 E.28104
G1 X134.357 Y120.71 E.00083
G1 X121.643 Y120.71 E.24507
G1 X121.6 Y120.71 E.00083
G1 X121.6 Y135.29 E.28104
G1 X121.643 Y135.29 E.00083
G1 X134.34 Y135.29 E.24474
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.348 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.6 Y134.49 Z2.76 F60000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3048
M204 S4000
G1 X133.6 Y121.57 E.2259
M204 S10000
G1 X122.791 Y123.419 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3048
M204 S4000
G1 X122.791 Y121.722 E.0352
G3 X123.274 Y121.482 I.512 J.424 E.01152
G3 X125.269 Y122.089 I.237 J2.804 E.04431
G1 X126.179 Y123.147 E.02896
G2 X127.545 Y123.623 I1.118 J-1.013 E.03128
G2 X128.91 Y122.987 I-.516 J-2.892 E.0316
G1 X129.821 Y121.928 E.02896
G1 X130.276 Y121.558 E.01217
G3 X132.552 Y122.089 I.669 J2.279 E.05068
G1 X133.209 Y122.853 E.0209
G1 X133.209 Y125.364 E.05209
G2 X132.097 Y125.094 I-.858 J1.111 E.02445
G2 X130.731 Y125.73 I.516 J2.891 E.0316
G1 X129.821 Y126.789 E.02896
G3 X128.455 Y127.264 I-1.118 J-1.013 E.03128
G3 X127.09 Y126.628 I.516 J-2.891 E.0316
G1 X126.179 Y125.57 E.02896
G2 X124.814 Y125.094 I-1.118 J1.013 E.03128
G2 X123.448 Y125.73 I.516 J2.892 E.0316
G1 X122.791 Y126.494 E.0209
G1 X122.791 Y129.005 E.05209
G3 X123.903 Y128.736 I.858 J1.111 E.02445
G3 X125.269 Y129.372 I-.516 J2.891 E.0316
G1 X126.179 Y130.43 E.02896
G2 X127.545 Y130.906 I1.118 J-1.013 E.03128
G2 X128.91 Y130.27 I-.516 J-2.891 E.0316
G1 X129.821 Y129.211 E.02896
G3 X131.186 Y128.736 I1.118 J1.013 E.03128
G3 X132.552 Y129.372 I-.516 J2.892 E.0316
G1 X133.209 Y130.136 E.0209
G1 X133.209 Y132.647 E.05209
G2 X132.097 Y132.378 I-.858 J1.111 E.02445
G2 X130.731 Y133.013 I.516 J2.892 E.0316
G1 X129.821 Y134.072 E.02896
G1 X129.366 Y134.442 E.01217
G3 X127.09 Y133.911 I-.669 J-2.279 E.05068
G1 X126.179 Y132.853 E.02896
G2 X124.814 Y132.378 I-1.118 J1.013 E.03128
G2 X123.448 Y133.013 I.516 J2.892 E.0316
G1 X122.791 Y133.777 E.0209
G1 X122.791 Y134.518 E.01536
G1 X123.747 Y134.518 E.01984
M204 S10000
G1 X122.4 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3048
M204 S4000
G1 X122.4 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.4 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L20
M991 S0 P19 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.76 I-.847 J.874 P1  F60000
G1 X134.075 Y134.881 Z2.76
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3058
M204 S4000
G1 X134.075 Y121.119 E.28545
G1 X121.925 Y121.119 E.25201
G1 X121.925 Y134.881 E.28545
G1 X134.015 Y134.881 E.25077
; COOLING_NODE: 0
M204 S250
G1 X134.484 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3051
M204 S2000
M73 P32 R14
G1 X134.484 Y120.71 E.28104
G1 X134.441 Y120.71 E.00083
G1 X121.559 Y120.71 E.24831
G1 X121.516 Y120.71 E.00083
G1 X121.516 Y135.29 E.28104
G1 X121.559 Y135.29 E.00083
G1 X134.424 Y135.29 E.24798
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.432 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.684 Y134.49 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3058
M204 S4000
G1 X133.684 Y121.57 E.2259
M204 S10000
G1 X122.707 Y121.729 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3058
M204 S4000
G1 X122.707 Y121.482 E.00512
G1 X124.157 Y121.482 E.03008
G3 X125.269 Y122.138 I-.698 J2.453 E.02707
G1 X126.179 Y123.341 E.0313
G1 X126.634 Y123.69 E.01189
G1 X127.09 Y123.757 E.00954
G2 X128.91 Y122.937 I-.24 J-2.965 E.04224
G1 X129.821 Y121.734 E.0313
G1 X130.15 Y121.482 E.0086
G1 X131.44 Y121.482 E.02677
G3 X132.552 Y122.138 I-.698 J2.453 E.02707
G1 X133.293 Y123.118 E.02547
G1 X133.293 Y125.246 E.04415
G2 X132.552 Y124.96 I-.628 J.524 E.0172
G2 X130.731 Y125.78 I.24 J2.965 E.04224
G1 X129.821 Y126.983 E.0313
G1 X129.366 Y127.331 E.01189
G1 X128.91 Y127.398 E.00954
G3 X127.09 Y126.579 I.24 J-2.965 E.04224
G1 X126.179 Y125.376 E.0313
G1 X125.724 Y125.027 E.01189
G1 X125.269 Y124.96 E.00954
G2 X123.448 Y125.78 I.24 J2.965 E.04224
G1 X122.707 Y126.759 E.02548
G1 X122.707 Y128.887 E.04415
G3 X123.448 Y128.602 I.628 J.524 E.0172
G3 X125.269 Y129.421 I-.24 J2.965 E.04224
G1 X126.179 Y130.625 E.0313
G1 X126.634 Y130.973 E.01189
G1 X127.09 Y131.04 E.00954
G2 X128.91 Y130.22 I-.24 J-2.965 E.04224
G1 X129.821 Y129.017 E.0313
G1 X130.276 Y128.669 E.01189
G1 X130.731 Y128.602 E.00954
G3 X132.552 Y129.421 I-.24 J2.965 E.04224
G1 X133.293 Y130.401 E.02547
G1 X133.293 Y132.529 E.04415
G2 X132.552 Y132.243 I-.628 J.524 E.0172
G2 X130.731 Y133.063 I.24 J2.965 E.04224
G1 X129.821 Y134.266 E.0313
G1 X129.492 Y134.518 E.00859
G1 X128.272 Y134.518 E.0253
G3 X127.09 Y133.862 I.453 J-2.21 E.02849
G1 X126.179 Y132.659 E.0313
G1 X125.724 Y132.31 E.01189
G1 X125.269 Y132.243 E.00954
G2 X123.448 Y133.063 I.24 J2.965 E.04224
G1 X122.707 Y134.042 E.02548
G1 X122.707 Y132.345 E.0352
M204 S10000
G1 X122.316 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3058
M204 S4000
G1 X122.316 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.316 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L21
M991 S0 P20 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.88 I-.841 J.88 P1  F60000
G1 X134.159 Y134.881 Z2.88
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3093
M204 S4000
G1 X134.159 Y121.119 E.28545
G1 X121.841 Y121.119 E.2555
G1 X121.841 Y134.881 E.28545
G1 X134.099 Y134.881 E.25425
; COOLING_NODE: 0
M204 S250
G1 X134.568 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3062
M204 S2000
G1 X134.568 Y120.71 E.28104
G1 X134.525 Y120.71 E.00083
G1 X121.475 Y120.71 E.25155
G1 X121.432 Y120.71 E.00083
G1 X121.432 Y135.29 E.28104
G1 X121.475 Y135.29 E.00083
G1 X134.508 Y135.29 E.25122
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.516 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.768 Y134.49 Z3 F60000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3093
M204 S4000
G1 X133.768 Y121.57 E.2259
M204 S10000
G1 X122.648 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3093
M204 S4000
G1 X124.345 Y121.482 E.0352
G3 X125.724 Y122.847 I-1.386 J2.78 E.04093
G1 X126.179 Y123.605 E.01834
G1 X126.634 Y123.901 E.01127
G1 X127.09 Y123.889 E.00945
G2 X129.366 Y122.229 I-.516 J-3.097 E.0606
G1 X129.814 Y121.482 E.01806
G1 X131.628 Y121.482 E.03763
G3 X133.007 Y122.847 I-1.386 J2.779 E.04093
G1 X133.377 Y123.463 E.0149
G1 X133.377 Y125.057 E.03307
G2 X132.552 Y124.828 I-.578 J.482 E.01889
G2 X130.276 Y126.488 I.516 J3.097 E.0606
G1 X129.821 Y127.246 E.01834
G1 X129.366 Y127.543 E.01127
G1 X128.91 Y127.53 E.00945
G3 X126.634 Y125.87 I.516 J-3.097 E.0606
G1 X126.179 Y125.112 E.01834
G1 X125.724 Y124.816 E.01127
G1 X125.269 Y124.828 E.00945
G2 X122.993 Y126.488 I.516 J3.097 E.0606
G1 X122.623 Y127.104 E.0149
G1 X122.623 Y128.698 E.03306
G3 X123.448 Y128.47 I.578 J.482 E.01889
G3 X125.724 Y130.13 I-.516 J3.097 E.0606
G1 X126.179 Y130.888 E.01834
G1 X126.634 Y131.184 E.01127
G1 X127.09 Y131.172 E.00945
G2 X129.366 Y129.512 I-.516 J-3.097 E.0606
G1 X129.821 Y128.754 E.01834
G1 X130.276 Y128.457 E.01127
G1 X130.731 Y128.47 E.00945
G3 X133.007 Y130.13 I-.516 J3.097 E.0606
G1 X133.377 Y130.746 E.0149
G1 X133.377 Y132.34 E.03307
G2 X132.552 Y132.111 I-.578 J.482 E.01889
G2 X130.276 Y133.771 I.516 J3.097 E.0606
G1 X129.828 Y134.518 E.01806
G1 X128 Y134.514 E.03791
G3 X126.634 Y133.153 I1.611 J-2.983 E.04054
G1 X126.179 Y132.395 E.01834
G1 X125.724 Y132.099 E.01127
G1 X125.269 Y132.111 E.00945
G2 X122.993 Y133.771 I.516 J3.097 E.0606
G1 X122.623 Y134.387 E.0149
G1 X122.623 Y132.69 E.0352
M204 S10000
G1 X122.232 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3093
M204 S4000
G1 X122.232 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.232 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L22
M991 S0 P21 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3 I-.834 J.886 P1  F60000
G1 X134.243 Y134.881 Z3
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3129
M204 S4000
G1 X134.243 Y121.119 E.28545
G1 X121.757 Y121.119 E.25898
G1 X121.757 Y134.881 E.28545
G1 X134.183 Y134.881 E.25774
; COOLING_NODE: 0
M204 S250
G1 X134.652 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3067
M204 S2000
G1 X134.652 Y120.71 E.28104
G1 X134.609 Y120.71 E.00083
G1 X121.391 Y120.71 E.25479
G1 X121.348 Y120.71 E.00083
G1 X121.348 Y135.29 E.28104
G1 X121.391 Y135.29 E.00083
G1 X134.592 Y135.29 E.25446
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.6 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.852 Y134.49 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3129
M204 S4000
G1 X133.852 Y121.57 E.2259
M204 S10000
G1 X122.729 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3129
M204 S4000
G1 X124.426 Y121.482 E.0352
G3 X125.724 Y123.04 I-1.824 J2.839 E.04271
G1 X126.179 Y124.132 E.02454
G2 X127.09 Y124.04 I.349 J-1.103 E.01951
G2 X129.366 Y122.036 I-.928 J-3.349 E.06509
G1 X129.596 Y121.482 E.01244
G1 X131.709 Y121.482 E.04383
G3 X133.007 Y123.04 I-1.824 J2.839 E.04271
G1 X133.461 Y124.128 E.02446
G1 X133.461 Y124.585 E.00948
G2 X132.552 Y124.677 I-.348 J1.101 E.01948
G2 X130.276 Y126.681 I.928 J3.349 E.06509
G1 X129.821 Y127.773 E.02454
G3 X128.91 Y127.681 I-.349 J-1.103 E.01951
G3 X126.634 Y125.677 I.928 J-3.349 E.06509
G1 X126.179 Y124.585 E.02454
G2 X125.269 Y124.677 I-.349 J1.103 E.01951
G2 X122.993 Y126.681 I.928 J3.349 E.06509
G1 X122.539 Y127.77 E.02447
G1 X122.539 Y128.227 E.00948
G3 X123.448 Y128.319 I.348 J1.101 E.01949
G3 X125.724 Y130.323 I-.928 J3.349 E.06509
G1 X126.179 Y131.415 E.02454
G2 X127.09 Y131.323 I.349 J-1.103 E.01951
G2 X129.366 Y129.319 I-.928 J-3.349 E.06509
G1 X129.821 Y128.227 E.02454
G3 X130.731 Y128.319 I.349 J1.103 E.01951
G3 X133.007 Y130.323 I-.928 J3.349 E.06509
G1 X133.461 Y131.411 E.02446
G1 X133.461 Y131.868 E.00948
G2 X132.552 Y131.96 I-.348 J1.101 E.01948
M73 P33 R14
G2 X130.276 Y133.964 I.928 J3.349 E.06509
G1 X129.896 Y134.518 E.01393
G1 X127.932 Y134.518 E.04073
G3 X126.634 Y132.96 I1.824 J-2.839 E.04271
G1 X126.179 Y131.869 E.02454
G2 X125.269 Y131.96 I-.349 J1.103 E.01951
G2 X122.993 Y133.964 I.928 J3.349 E.06509
G1 X122.612 Y134.518 E.01393
G1 X122.539 Y134.518 E.00152
G1 X122.539 Y132.894 E.03368
M204 S10000
G1 X122.148 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3129
M204 S4000
G1 X122.148 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.148 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L23
M991 S0 P22 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.12 I-.828 J.892 P1  F60000
G1 X134.327 Y134.881 Z3.12
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3111
M204 S4000
G1 X134.327 Y121.119 E.28545
G1 X121.673 Y121.119 E.26247
G1 X121.673 Y134.881 E.28545
G1 X134.267 Y134.881 E.26122
; COOLING_NODE: 0
M204 S250
G1 X134.736 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3067
M204 S2000
G1 X134.736 Y120.71 E.28104
G1 X134.693 Y120.71 E.00083
G1 X121.307 Y120.71 E.25802
G1 X121.264 Y120.71 E.00083
G1 X121.264 Y135.29 E.28104
G1 X121.307 Y135.29 E.00083
G1 X134.676 Y135.29 E.2577
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.684 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.936 Y134.49 Z3.24 F60000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3111
M204 S4000
G1 X133.936 Y121.57 E.2259
M204 S10000
G1 X122.787 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3111
M204 S4000
G1 X124.484 Y121.482 E.0352
G3 X125.736 Y123.448 I-1.774 J2.512 E.04959
G1 X125.768 Y123.903 E.00946
G1 X125.489 Y124.358 E.01107
G1 X124.699 Y124.814 E.01892
G2 X122.981 Y127.09 I1.426 J2.862 E.06131
G1 X122.949 Y127.545 E.00946
G1 X123.228 Y128 E.01107
G1 X124.018 Y128.455 E.01892
G3 X125.736 Y130.731 I-1.426 J2.862 E.06131
G1 X125.768 Y131.186 E.00946
G1 X125.489 Y131.642 E.01107
G1 X124.699 Y132.097 E.01892
G2 X122.981 Y134.373 I1.426 J2.862 E.06131
G1 X122.971 Y134.518 E.00302
G1 X127.874 Y134.518 E.10171
G3 X126.622 Y132.552 I1.774 J-2.511 E.04958
G1 X126.591 Y132.097 E.00946
G1 X126.869 Y131.642 E.01107
G1 X127.66 Y131.186 E.01892
G2 X129.378 Y128.91 I-1.426 J-2.862 E.06131
G1 X129.409 Y128.455 E.00946
G1 X129.131 Y128 E.01107
G1 X128.34 Y127.545 E.01892
G3 X126.622 Y125.269 I1.426 J-2.862 E.06131
G1 X126.591 Y124.814 E.00946
G1 X126.869 Y124.358 E.01107
G1 X127.66 Y123.903 E.01892
G2 X129.378 Y121.627 I-1.426 J-2.862 E.06131
G1 X129.388 Y121.482 E.00302
G1 X131.767 Y121.482 E.04936
G3 X133.019 Y123.448 I-1.774 J2.511 E.04959
G1 X133.051 Y123.903 E.00946
G1 X132.772 Y124.358 E.01107
G1 X131.982 Y124.814 E.01892
G2 X130.264 Y127.09 I1.426 J2.862 E.06131
G1 X130.232 Y127.545 E.00946
G1 X130.511 Y128 E.01107
G1 X131.301 Y128.455 E.01892
G3 X133.019 Y130.731 I-1.426 J2.862 E.06131
G1 X133.051 Y131.186 E.00946
G1 X132.772 Y131.642 E.01107
G1 X131.982 Y132.097 E.01892
G2 X130.264 Y134.373 I1.426 J2.863 E.06131
G1 X130.254 Y134.518 E.00302
G1 X131.951 Y134.518 E.0352
M204 S10000
G1 X122.064 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3111
M204 S4000
G1 X122.064 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X122.064 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L24
M991 S0 P23 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.24 I-.822 J.897 P1  F60000
G1 X134.411 Y134.881 Z3.24
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3083
M204 S4000
G1 X134.411 Y121.119 E.28545
G1 X121.589 Y121.119 E.26595
G1 X121.589 Y134.881 E.28545
G1 X134.351 Y134.881 E.26471
; COOLING_NODE: 0
M204 S250
G1 X134.82 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3066
M204 S2000
G1 X134.82 Y120.71 E.28104
G1 X134.777 Y120.71 E.00083
G1 X121.223 Y120.71 E.26126
G1 X121.18 Y120.71 E.00083
G1 X121.18 Y135.29 E.28104
G1 X121.223 Y135.29 E.00083
G1 X134.76 Y135.29 E.26094
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.768 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.02 Y134.49 Z3.36 F60000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3083
M204 S4000
G1 X134.02 Y121.57 E.2259
M204 S10000
G1 X122.855 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3083
M204 S4000
G1 X124.552 Y121.482 E.0352
G1 X124.749 Y121.627 E.00508
G3 X125.601 Y123.448 I-2.159 J2.12 E.0425
G1 X125.547 Y123.903 E.00951
G1 X125.204 Y124.358 E.01181
G1 X123.968 Y125.269 E.03185
G2 X123.116 Y127.09 I2.159 J2.12 E.0425
G1 X123.17 Y127.545 E.00951
G1 X123.513 Y128 E.01181
G1 X124.749 Y128.91 E.03185
G3 X125.601 Y130.731 I-2.159 J2.12 E.0425
G1 X125.547 Y131.186 E.00951
G1 X125.204 Y131.642 E.01181
G1 X123.968 Y132.552 E.03185
G2 X123.116 Y134.373 I2.159 J2.12 E.0425
G1 X123.133 Y134.518 E.00303
G1 X127.807 Y134.518 E.09693
G1 X127.609 Y134.373 E.00508
G3 X126.758 Y132.552 I2.159 J-2.12 E.0425
G1 X126.812 Y132.097 E.00951
G1 X127.154 Y131.642 E.01181
G1 X128.391 Y130.731 E.03185
G2 X129.242 Y128.91 I-2.159 J-2.12 E.0425
G1 X129.188 Y128.455 E.00951
G1 X128.846 Y128 E.01181
G1 X127.609 Y127.09 E.03185
G3 X126.758 Y125.269 I2.159 J-2.12 E.0425
G1 X126.812 Y124.814 E.00951
G1 X127.154 Y124.358 E.01181
G1 X128.391 Y123.448 E.03185
G2 X129.242 Y121.627 I-2.159 J-2.12 E.0425
G1 X129.225 Y121.482 E.00303
G1 X131.835 Y121.482 E.05414
G1 X132.032 Y121.627 E.00508
G3 X132.884 Y123.448 I-2.159 J2.12 E.0425
G1 X132.83 Y123.903 E.00951
G1 X132.487 Y124.358 E.01181
G1 X131.251 Y125.269 E.03185
G2 X130.399 Y127.09 I2.159 J2.12 E.0425
G1 X130.454 Y127.545 E.00951
G1 X130.796 Y128 E.01181
G1 X132.032 Y128.91 E.03185
G3 X132.884 Y130.731 I-2.159 J2.12 E.0425
G1 X132.83 Y131.186 E.00951
G1 X132.487 Y131.642 E.01181
G1 X131.251 Y132.552 E.03185
G2 X130.399 Y134.373 I2.159 J2.12 E.0425
G1 X130.417 Y134.518 E.00303
G1 X132.114 Y134.518 E.0352
M204 S10000
G1 X121.98 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3083
M204 S4000
G1 X121.98 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.98 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L25
M991 S0 P24 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.36 I-.816 J.903 P1  F60000
G1 X134.495 Y134.881 Z3.36
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3067
M204 S4000
G1 X134.495 Y121.119 E.28545
G1 X121.505 Y121.119 E.26944
G1 X121.505 Y134.881 E.28545
G1 X134.435 Y134.881 E.26819
; COOLING_NODE: 0
M204 S250
G1 X134.904 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S2000
M73 P33 R13
G1 X134.904 Y120.71 E.28104
G1 X134.861 Y120.71 E.00083
G1 X121.139 Y120.71 E.2645
G1 X121.096 Y120.71 E.00083
G1 X121.096 Y135.29 E.28104
G1 X121.139 Y135.29 E.00083
G1 X134.844 Y135.29 E.26417
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.852 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.104 Y134.49 Z3.48 F60000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3067
M204 S4000
G1 X134.104 Y121.57 E.2259
M204 S10000
G1 X122.928 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3067
M204 S4000
M73 P34 R13
G1 X124.625 Y121.482 E.0352
G3 X125.456 Y122.993 I-1.689 J1.912 E.03648
G3 X125.001 Y124.358 I-1.447 J.276 E.03119
G1 X123.919 Y125.269 E.02933
G2 X123.261 Y126.634 I2.258 J1.929 E.03179
G2 X123.716 Y128 I1.447 J.276 E.03119
G1 X124.798 Y128.91 E.02933
G3 X125.456 Y130.276 I-2.257 J1.929 E.03179
G3 X125.001 Y131.642 I-1.447 J.276 E.03119
G1 X123.919 Y132.552 E.02933
G2 X123.271 Y134.518 I1.835 J1.694 E.04427
G1 X127.733 Y134.518 E.09254
G3 X126.903 Y133.007 I1.689 J-1.912 E.03648
G3 X127.358 Y131.642 I1.447 J-.276 E.03119
G1 X128.44 Y130.731 E.02933
G2 X129.097 Y129.366 I-2.258 J-1.929 E.03179
G2 X128.642 Y128 I-1.447 J-.276 E.03119
G1 X127.561 Y127.09 E.02933
G3 X126.903 Y125.724 I2.257 J-1.929 E.03179
G3 X127.358 Y124.358 I1.447 J-.276 E.03119
G1 X128.44 Y123.448 E.02933
G2 X129.087 Y121.482 I-1.835 J-1.694 E.04427
G1 X131.909 Y121.482 E.05852
G3 X132.739 Y122.993 I-1.689 J1.912 E.03648
G3 X132.284 Y124.358 I-1.447 J.276 E.03119
G1 X131.202 Y125.269 E.02933
G2 X130.544 Y126.634 I2.257 J1.929 E.03179
G2 X130.999 Y128 I1.447 J.276 E.03119
G1 X132.081 Y128.91 E.02933
G3 X132.739 Y130.276 I-2.257 J1.929 E.03179
G3 X132.284 Y131.642 I-1.447 J.276 E.03119
G1 X131.202 Y132.552 E.02933
G2 X130.555 Y134.518 I1.835 J1.694 E.04427
G1 X132.252 Y134.518 E.0352
M204 S10000
G1 X121.896 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3067
M204 S4000
G1 X121.896 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.896 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L26
M991 S0 P25 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.48 I-.81 J.908 P1  F60000
G1 X134.579 Y134.881 Z3.48
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3060
M204 S4000
G1 X134.579 Y121.119 E.28545
G1 X121.421 Y121.119 E.27292
G1 X121.421 Y134.881 E.28545
G1 X134.519 Y134.881 E.27168
; COOLING_NODE: 0
M204 S250
G1 X134.988 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3060
M204 S2000
G1 X134.988 Y120.71 E.28104
G1 X134.945 Y120.71 E.00083
G1 X121.055 Y120.71 E.26774
G1 X121.012 Y120.71 E.00083
G1 X121.012 Y135.29 E.28104
G1 X121.055 Y135.29 E.00083
G1 X134.928 Y135.29 E.26741
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X134.936 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.188 Y134.49 Z3.6 F60000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3060
M204 S4000
G1 X134.188 Y121.57 E.2259
M204 S10000
G1 X122.998 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3060
M204 S4000
G1 X124.695 Y121.482 E.0352
G3 X125.216 Y123.903 I-1.526 J1.595 E.05454
G3 X123.867 Y125.269 I-6.315 J-4.889 E.03991
G2 X123.501 Y127.545 I1.739 J1.448 E.05017
G2 X124.85 Y128.91 I6.315 J-4.889 E.03991
G3 X125.216 Y131.186 I-1.739 J1.448 E.05017
G3 X123.867 Y132.552 I-6.314 J-4.889 E.03991
G2 X123.392 Y134.518 I1.807 J1.478 E.04339
G1 X127.663 Y134.518 E.08861
G3 X127.142 Y132.097 I1.526 J-1.595 E.05454
G3 X128.491 Y130.731 I6.314 J4.889 E.03991
G2 X128.858 Y128.455 I-1.739 J-1.448 E.05017
G2 X127.509 Y127.09 I-6.314 J4.888 E.03991
G3 X127.142 Y124.814 I1.739 J-1.448 E.05017
G3 X128.491 Y123.448 I6.314 J4.888 E.03991
G2 X128.967 Y121.482 I-1.807 J-1.478 E.04339
G1 X131.978 Y121.482 E.06246
G3 X132.5 Y123.903 I-1.526 J1.595 E.05454
G3 X131.15 Y125.269 I-6.315 J-4.89 E.03991
G2 X130.784 Y127.545 I1.739 J1.448 E.05017
G2 X132.133 Y128.91 I6.314 J-4.889 E.03991
G3 X132.5 Y131.186 I-1.739 J1.448 E.05017
G3 X131.15 Y132.552 I-6.315 J-4.889 E.03991
G2 X130.675 Y134.518 I1.807 J1.478 E.04339
G1 X132.372 Y134.518 E.0352
M204 S10000
G1 X121.812 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3060
M204 S4000
G1 X121.812 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.812 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L27
M991 S0 P26 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.6 I-.804 J.914 P1  F60000
G1 X134.663 Y134.881 Z3.6
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3058
M204 S4000
G1 X134.663 Y121.119 E.28545
G1 X121.337 Y121.119 E.2764
G1 X121.337 Y134.881 E.28545
G1 X134.603 Y134.881 E.27516
; COOLING_NODE: 0
M204 S250
G1 X135.072 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3058
M204 S2000
G1 X135.072 Y120.71 E.28104
G1 X135.029 Y120.71 E.00083
G1 X120.971 Y120.71 E.27098
G1 X120.928 Y120.71 E.00083
G1 X120.928 Y135.29 E.28104
G1 X120.971 Y135.29 E.00083
G1 X135.012 Y135.29 E.27065
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.02 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.272 Y134.49 Z3.72 F60000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3058
M204 S4000
G1 X134.272 Y121.57 E.2259
M204 S10000
G1 X123.082 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3058
M204 S4000
G1 X124.779 Y121.482 E.0352
G3 X125.282 Y123.448 I-1.836 J1.517 E.04348
G3 X124.206 Y124.814 I-3.083 J-1.323 E.03648
G2 X123.435 Y127.09 I1.664 J1.832 E.05204
G2 X124.511 Y128.455 I3.083 J-1.323 E.03648
G3 X125.282 Y130.731 I-1.664 J1.832 E.05204
G3 X124.206 Y132.097 I-3.083 J-1.323 E.03648
G2 X123.498 Y134.518 I1.525 J1.76 E.05529
G1 X127.579 Y134.518 E.08466
G3 X127.076 Y132.552 I1.836 J-1.517 E.04348
G3 X128.153 Y131.186 I3.083 J1.323 E.03648
G2 X128.924 Y128.91 I-1.664 J-1.832 E.05204
G2 X127.847 Y127.545 I-3.083 J1.323 E.03648
G3 X127.076 Y125.269 I1.664 J-1.832 E.05204
G3 X128.153 Y123.903 I3.083 J1.323 E.03648
G2 X128.86 Y121.482 I-1.525 J-1.76 E.05529
G1 X132.062 Y121.482 E.06641
G3 X132.565 Y123.448 I-1.836 J1.517 E.04348
G3 X131.489 Y124.814 I-3.083 J-1.323 E.03648
G2 X130.718 Y127.09 I1.664 J1.832 E.05204
G2 X131.794 Y128.455 I3.083 J-1.323 E.03648
G3 X132.565 Y130.731 I-1.664 J1.832 E.05204
G3 X131.489 Y132.097 I-3.083 J-1.323 E.03648
G2 X130.781 Y134.518 I1.525 J1.76 E.05529
G1 X132.478 Y134.518 E.0352
M204 S10000
G1 X121.728 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3058
M204 S4000
G1 X121.728 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.728 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L28
M991 S0 P27 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.72 I-.798 J.919 P1  F60000
G1 X134.747 Y134.881 Z3.72
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3062
M204 S4000
G1 X134.747 Y121.119 E.28545
G1 X121.253 Y121.119 E.27989
G1 X121.253 Y134.881 E.28545
G1 X134.687 Y134.881 E.27865
; COOLING_NODE: 0
M204 S250
G1 X135.156 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3062
M204 S2000
G1 X135.156 Y120.71 E.28104
G1 X135.113 Y120.71 E.00083
G1 X120.887 Y120.71 E.27422
G1 X120.844 Y120.71 E.00083
G1 X120.844 Y135.29 E.28104
G1 X120.887 Y135.29 E.00083
G1 X135.096 Y135.29 E.27389
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
M73 P35 R13
G1 X135.104 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.356 Y134.49 Z3.84 F60000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3062
M204 S4000
G1 X134.356 Y121.57 E.2259
M204 S10000
G1 X123.154 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3062
M204 S4000
G1 X124.851 Y121.482 E.0352
G3 X125.197 Y123.448 I-1.857 J1.341 E.04284
G3 X124.105 Y124.814 I-3.889 J-1.992 E.03652
G2 X124.154 Y128 I1.502 J1.571 E.0742
G3 X125.197 Y130.731 I-1.48 J2.13 E.06443
G3 X124.105 Y132.097 I-3.889 J-1.992 E.03652
G2 X123.594 Y134.518 I1.56 J1.594 E.05441
G1 X127.507 Y134.518 E.08117
G3 X127.161 Y132.552 I1.857 J-1.341 E.04284
G3 X128.254 Y131.186 I3.89 J1.992 E.03652
G2 X128.205 Y128 I-1.502 J-1.571 E.0742
G3 X127.161 Y125.269 I1.48 J-2.13 E.06443
G3 X128.254 Y123.903 I3.89 J1.992 E.03652
G2 X128.765 Y121.482 I-1.56 J-1.594 E.05441
G1 X132.134 Y121.482 E.0699
G3 X132.481 Y123.448 I-1.857 J1.341 E.04284
G3 X131.388 Y124.814 I-3.89 J-1.992 E.03652
G2 X131.437 Y128 I1.502 J1.571 E.0742
G3 X132.481 Y130.731 I-1.48 J2.13 E.06443
G3 X131.388 Y132.097 I-3.89 J-1.992 E.03652
G2 X130.877 Y134.518 I1.56 J1.594 E.05441
G1 X132.574 Y134.518 E.0352
M204 S10000
G1 X121.644 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3062
M204 S4000
G1 X121.644 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.644 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L29
M991 S0 P28 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.84 I-.792 J.924 P1  F60000
G1 X134.831 Y134.881 Z3.84
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3068
M204 S4000
G1 X134.831 Y121.119 E.28545
G1 X121.169 Y121.119 E.28337
G1 X121.169 Y134.881 E.28545
G1 X134.771 Y134.881 E.28213
; COOLING_NODE: 0
M204 S250
G1 X135.24 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3068
M204 S2000
G1 X135.24 Y120.71 E.28104
G1 X135.197 Y120.71 E.00083
G1 X120.803 Y120.71 E.27745
G1 X120.76 Y120.71 E.00083
G1 X120.76 Y135.29 E.28104
G1 X120.803 Y135.29 E.00083
G1 X135.18 Y135.29 E.27713
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.188 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.44 Y134.49 Z3.96 F60000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3068
M204 S4000
G1 X134.44 Y121.57 E.2259
M204 S10000
G1 X123.229 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3068
M204 S4000
G1 X124.926 Y121.482 E.0352
G3 X124.44 Y124.358 I-1.855 J1.166 E.06621
G2 X124.277 Y128 I1.363 J1.886 E.08687
G3 X124.44 Y131.642 I-1.363 J1.886 E.08687
G2 X123.682 Y134.518 I1.385 J1.903 E.06679
G1 X127.432 Y134.518 E.0778
G3 X127.918 Y131.642 I1.855 J-1.166 E.06621
G2 X128.082 Y128 I-1.363 J-1.886 E.08687
G3 X127.918 Y124.358 I1.363 J-1.886 E.08687
G2 X128.677 Y121.482 I-1.385 J-1.903 E.06679
G1 X132.209 Y121.482 E.07327
G3 X131.723 Y124.358 I-1.855 J1.166 E.06621
G2 X131.56 Y128 I1.363 J1.886 E.08687
G3 X131.723 Y131.642 I-1.363 J1.886 E.08687
G2 X130.965 Y134.518 I1.385 J1.903 E.06679
G1 X132.662 Y134.518 E.0352
M204 S10000
G1 X121.56 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3068
M204 S4000
G1 X121.56 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.56 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L30
M991 S0 P29 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.96 I-.787 J.929 P1  F60000
G1 X134.915 Y134.881 Z3.96
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3080
M204 S4000
G1 X134.915 Y121.119 E.28545
G1 X121.085 Y121.119 E.28686
G1 X121.085 Y134.881 E.28545
G1 X134.855 Y134.881 E.28561
; COOLING_NODE: 0
M204 S250
G1 X135.324 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3080
M204 S2000
G1 X135.324 Y120.71 E.28104
G1 X135.281 Y120.71 E.00083
G1 X120.719 Y120.71 E.28069
G1 X120.676 Y120.71 E.00083
G1 X120.676 Y135.29 E.28104
G1 X120.719 Y135.29 E.00083
G1 X135.264 Y135.29 E.28037
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.272 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.524 Y134.49 Z4.08 F60000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3080
M204 S4000
G1 X134.524 Y121.57 E.2259
M204 S10000
G1 X123.308 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3080
M204 S4000
G1 X125.005 Y121.482 E.0352
G3 X124.32 Y124.358 I-2.031 J1.036 E.06673
G2 X124.397 Y128 I1.452 J1.791 E.0871
G3 X124.32 Y131.642 I-1.452 J1.791 E.0871
G2 X123.763 Y134.518 I1.36 J1.756 E.06636
G1 X127.353 Y134.518 E.07447
G3 X128.038 Y131.642 I2.031 J-1.036 E.06673
G2 X127.962 Y128 I-1.452 J-1.791 E.0871
G3 X128.038 Y124.358 I1.452 J-1.791 E.0871
G2 X128.596 Y121.482 I-1.36 J-1.756 E.06636
G1 X132.289 Y121.482 E.0766
G3 X131.603 Y124.358 I-2.031 J1.036 E.06673
G2 X131.68 Y128 I1.452 J1.791 E.0871
G3 X131.603 Y131.642 I-1.452 J1.791 E.0871
G2 X131.046 Y134.518 I1.36 J1.756 E.06636
G1 X132.743 Y134.518 E.0352
M204 S10000
G1 X121.476 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3080
M204 S4000
G1 X121.476 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.476 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L31
M991 S0 P30 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.08 I-.781 J.933 P1  F60000
G1 X134.999 Y134.881 Z4.08
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3075
M204 S4000
G1 X134.999 Y121.119 E.28545
G1 X121.001 Y121.119 E.29034
G1 X121.001 Y134.881 E.28545
G1 X134.939 Y134.881 E.2891
; COOLING_NODE: 0
M204 S250
G1 X135.408 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3075
M204 S2000
G1 X135.408 Y120.71 E.28104
M73 P36 R13
G1 X135.365 Y120.71 E.00083
G1 X120.635 Y120.71 E.28393
G1 X120.592 Y120.71 E.00083
G1 X120.592 Y135.29 E.28104
G1 X120.635 Y135.29 E.00083
G1 X135.348 Y135.29 E.2836
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.356 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.608 Y134.49 Z4.2 F60000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3075
M204 S4000
G1 X134.608 Y121.57 E.2259
M204 S10000
G1 X134.071 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3075
M204 S4000
G1 X132.374 Y121.482 E.0352
G3 X131.931 Y123.903 I-2.016 J.883 E.05418
G2 X130.831 Y125.269 I3.165 J3.675 E.03657
G2 X131.802 Y128 I2.43 J.674 E.06405
G3 X131.931 Y131.186 I-1.431 J1.654 E.07412
G2 X130.831 Y132.552 I3.165 J3.675 E.03657
G2 X131.122 Y134.518 I2.159 J.685 E.04267
G1 X127.268 Y134.518 E.07995
G3 X127.71 Y132.097 I2.016 J-.883 E.05418
G2 X128.81 Y130.731 I-3.165 J-3.675 E.03657
G2 X127.84 Y128 I-2.43 J-.674 E.06405
G3 X127.71 Y124.814 I1.431 J-1.654 E.07412
G2 X128.81 Y123.448 I-3.165 J-3.675 E.03657
G2 X128.519 Y121.482 I-2.159 J-.685 E.04268
G1 X125.091 Y121.482 E.07112
G3 X124.648 Y123.903 I-2.016 J.883 E.05418
G2 X123.548 Y125.269 I3.165 J3.675 E.03657
G2 X124.518 Y128 I2.431 J.674 E.06405
G3 X124.648 Y131.186 I-1.431 J1.654 E.07412
G2 X123.548 Y132.552 I3.165 J3.675 E.03657
G2 X123.839 Y134.518 I2.159 J.685 E.04267
G1 X122.142 Y134.518 E.0352
M204 S10000
G1 X121.392 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3075
M204 S4000
G1 X121.392 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.392 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L32
M991 S0 P31 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.2 I-.775 J.938 P1  F60000
G1 X135.083 Y134.881 Z4.2
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3092
M204 S4000
G1 X135.083 Y121.119 E.28545
G1 X120.917 Y121.119 E.29383
G1 X120.917 Y134.881 E.28545
G1 X135.023 Y134.881 E.29258
; COOLING_NODE: 0
M204 S250
G1 X135.492 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3092
M204 S2000
G1 X135.492 Y120.71 E.28104
G1 X135.449 Y120.71 E.00083
G1 X120.551 Y120.71 E.28717
G1 X120.508 Y120.71 E.00083
G1 X120.508 Y135.29 E.28104
G1 X120.551 Y135.29 E.00083
G1 X135.432 Y135.29 E.28684
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.44 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.692 Y134.49 Z4.32 F60000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3092
M204 S4000
G1 X134.692 Y121.57 E.2259
M204 S10000
G1 X134.163 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3092
M204 S4000
G1 X132.466 Y121.482 E.0352
G3 X131.831 Y123.903 I-2.173 J.724 E.05493
G2 X130.749 Y125.269 I2.259 J2.9 E.03648
G2 X131.452 Y127.545 I2.377 J.512 E.05164
G3 X132.534 Y128.91 I-2.259 J2.9 E.03648
G3 X131.831 Y131.186 I-2.377 J.512 E.05164
G2 X130.749 Y132.552 I2.259 J2.9 E.03648
G2 X131.195 Y134.518 I2.288 J.514 E.04322
G1 X127.175 Y134.518 E.08339
G3 X127.811 Y132.097 I2.173 J-.724 E.05493
G2 X128.892 Y130.731 I-2.259 J-2.9 E.03648
G2 X128.189 Y128.455 I-2.377 J-.512 E.05164
G3 X127.108 Y127.09 I2.259 J-2.9 E.03648
G3 X127.811 Y124.814 I2.377 J-.512 E.05164
G2 X128.892 Y123.448 I-2.259 J-2.9 E.03648
G2 X128.446 Y121.482 I-2.288 J-.514 E.04322
G1 X125.183 Y121.482 E.06768
G3 X124.548 Y123.903 I-2.173 J.724 E.05493
G2 X123.466 Y125.269 I2.259 J2.9 E.03648
G2 X124.169 Y127.545 I2.377 J.512 E.05164
G3 X125.251 Y128.91 I-2.259 J2.9 E.03648
G3 X124.548 Y131.186 I-2.377 J.512 E.05164
G2 X123.466 Y132.552 I2.259 J2.9 E.03648
G2 X123.912 Y134.518 I2.288 J.514 E.04322
G1 X122.215 Y134.518 E.0352
M204 S10000
G1 X121.308 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3092
M204 S4000
G1 X121.308 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.308 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L33
M991 S0 P32 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.32 I-.769 J.943 P1  F60000
G1 X135.167 Y134.881 Z4.32
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3537
M204 S4000
G1 X135.167 Y121.119 E.28545
G1 X120.833 Y121.119 E.29731
G1 X120.833 Y134.881 E.28545
G1 X135.107 Y134.881 E.29607
; COOLING_NODE: 0
M204 S250
G1 X135.576 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3301
M204 S2000
G1 X135.576 Y120.71 E.28104
G1 X135.533 Y120.71 E.00083
G1 X120.467 Y120.71 E.29041
G1 X120.424 Y120.71 E.00083
G1 X120.424 Y135.29 E.28104
G1 X120.467 Y135.29 E.00083
G1 X135.516 Y135.29 E.29008
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.524 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.776 Y134.49 Z4.44 F60000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3537
M204 S4000
G1 X134.776 Y121.57 E.2259
M204 S10000
G1 X134.266 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3537
M204 S4000
G1 X132.569 Y121.482 E.0352
G3 X132.152 Y123.448 I-2.227 J.555 E.04315
G2 X130.833 Y124.814 I6.305 J7.409 E.03944
G2 X131.131 Y127.09 I2.049 J.889 E.05
G3 X132.45 Y128.455 I-6.305 J7.409 E.03944
G3 X132.152 Y130.731 I-2.049 J.889 E.05
G2 X130.833 Y132.097 I6.306 J7.41 E.03944
G2 X131.28 Y134.518 I1.981 J.886 E.0543
G1 X134.356 Y134.518 E.0638
G3 X134.385 Y133.328 I1.625 J-.556 E.02522
G1 X134.385 Y127.311 E.12481
G3 X134.385 Y126.045 I1.592 J-.633 E.0269
G1 X134.385 Y124.348 E.0352
M204 S10000
G1 X128.77 Y134.518 F60000
G1 F3537
M204 S4000
G1 X127.073 Y134.518 E.0352
G3 X127.49 Y132.552 I2.227 J-.555 E.04315
G2 X128.808 Y131.186 I-6.304 J-7.408 E.03944
G2 X128.51 Y128.91 I-2.049 J-.889 E.05
G3 X127.192 Y127.545 I6.304 J-7.408 E.03944
G3 X127.49 Y125.269 I2.049 J-.889 E.05
G2 X128.808 Y123.903 I-6.305 J-7.409 E.03944
G2 X128.361 Y121.482 I-1.981 J-.886 E.0543
G1 X125.286 Y121.482 E.0638
G3 X124.869 Y123.448 I-2.227 J.555 E.04315
G2 X123.55 Y124.814 I6.305 J7.409 E.03944
G2 X123.848 Y127.09 I2.049 J.889 E.05
G3 X125.167 Y128.455 I-6.305 J7.409 E.03944
G3 X124.869 Y130.731 I-2.049 J.889 E.05
G2 X123.55 Y132.097 I6.306 J7.41 E.03944
G2 X123.997 Y134.518 I1.981 J.886 E.0543
G1 X121.615 Y134.518 E.04941
G1 X121.615 Y130.952 E.07396
G2 X121.615 Y129.686 I-1.593 J-.633 E.02691
G1 X121.615 Y123.669 E.1248
G2 X121.615 Y122.403 I-1.593 J-.633 E.02691
G1 X121.615 Y121.482 E.0191
G1 X122.391 Y121.482 E.0161
M204 S10000
G1 X121.224 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3537
M204 S4000
G1 X121.224 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.224 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L34
M991 S0 P33 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.44 I-.764 J.947 P1  F60000
G1 X135.251 Y134.881 Z4.44
M73 P37 R13
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3577
M204 S4000
G1 X135.251 Y121.119 E.28545
G1 X120.749 Y121.119 E.3008
G1 X120.749 Y134.881 E.28545
G1 X135.191 Y134.881 E.29955
; COOLING_NODE: 0
M204 S250
G1 X135.66 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3369
M204 S2000
G1 X135.66 Y120.71 E.28104
G1 X135.617 Y120.71 E.00083
G1 X120.383 Y120.71 E.29365
G1 X120.34 Y120.71 E.00083
G1 X120.34 Y135.29 E.28104
G1 X120.383 Y135.29 E.00083
G1 X135.6 Y135.29 E.29332
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.608 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.86 Y134.49 Z4.56 F60000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3577
M204 S4000
G1 X134.86 Y121.57 E.2259
M204 S10000
G1 X134.381 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3577
M204 S4000
G1 X132.684 Y121.482 E.0352
G3 X132.099 Y123.448 I-2.402 J.356 E.04392
G2 X130.689 Y124.814 I3.398 J4.92 E.0409
G2 X131.184 Y127.09 I2.229 J.707 E.05057
G3 X132.594 Y128.455 I-3.398 J4.919 E.0409
G3 X132.099 Y130.731 I-2.229 J.707 E.05057
G2 X130.689 Y132.097 I3.398 J4.92 E.0409
G2 X131.349 Y134.518 I2.174 J.708 E.0551
G1 X134.241 Y134.518 E.05998
G3 X134.469 Y133.098 I2.144 J-.384 E.03041
G1 X134.469 Y127.757 E.11077
G3 X134.469 Y125.814 I1.64 J-.972 E.04229
G1 X134.469 Y124.117 E.0352
M204 S10000
G1 X128.655 Y134.518 F60000
G1 F3577
M204 S4000
G1 X126.958 Y134.518 E.0352
G3 X127.542 Y132.552 I2.402 J-.356 E.04392
G2 X128.952 Y131.186 I-3.398 J-4.919 E.0409
G2 X128.458 Y128.91 I-2.229 J-.707 E.05057
G3 X127.048 Y127.545 I3.398 J-4.919 E.0409
G3 X127.542 Y125.269 I2.229 J-.707 E.05057
G2 X128.952 Y123.903 I-3.398 J-4.92 E.0409
G2 X128.292 Y121.482 I-2.174 J-.708 E.0551
G1 X125.401 Y121.482 E.05998
G3 X124.816 Y123.448 I-2.402 J.356 E.04392
G2 X123.406 Y124.814 I3.398 J4.919 E.0409
G2 X123.901 Y127.09 I2.229 J.707 E.05057
G3 X125.311 Y128.455 I-3.398 J4.92 E.0409
G3 X124.816 Y130.731 I-2.229 J.707 E.05057
G2 X123.406 Y132.097 I3.398 J4.92 E.0409
G2 X124.066 Y134.518 I2.174 J.708 E.0551
G1 X121.531 Y134.518 E.05259
G1 X121.531 Y131.355 E.0656
G2 X121.79 Y130.276 I-1.167 J-.851 E.02363
G2 X121.531 Y129.456 I-2.366 J.297 E.01794
G1 X121.531 Y124.072 E.11167
G2 X121.79 Y122.993 I-1.167 J-.851 E.02363
G2 X121.531 Y122.173 I-2.367 J.297 E.01794
G1 X121.531 Y121.482 E.01432
G1 X122.537 Y121.482 E.02088
M204 S10000
G1 X121.14 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3577
M204 S4000
G1 X121.14 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.14 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L35
M991 S0 P34 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.56 I-.758 J.952 P1  F60000
G1 X135.335 Y134.881 Z4.56
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3625
M204 S4000
G1 X135.335 Y121.119 E.28545
G1 X120.665 Y121.119 E.30428
G1 X120.665 Y134.881 E.28545
G1 X135.275 Y134.881 E.30304
; COOLING_NODE: 0
M204 S250
G1 X135.744 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3428
M204 S2000
G1 X135.744 Y120.71 E.28104
G1 X135.701 Y120.71 E.00083
G1 X120.299 Y120.71 E.29688
G1 X120.256 Y120.71 E.00083
G1 X120.256 Y135.29 E.28104
G1 X120.299 Y135.29 E.00083
G1 X135.684 Y135.29 E.29656
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.692 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.944 Y134.49 Z4.68 F60000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3625
M204 S4000
G1 X134.944 Y121.57 E.2259
M204 S10000
G1 X134.512 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3625
M204 S4000
G1 X132.815 Y121.482 E.0352
G3 X132.05 Y123.448 I-2.616 J.114 E.04504
G1 X130.875 Y124.358 E.03082
G1 X130.522 Y124.814 E.01195
G2 X131.234 Y127.09 I2.514 J.463 E.05146
G1 X132.408 Y128 E.03082
G1 X132.762 Y128.455 E.01195
G3 X132.05 Y130.731 I-2.514 J.463 E.05146
G1 X130.875 Y131.642 E.03082
G2 X130.444 Y132.552 I.637 J.859 E.02176
G1 X130.639 Y133.462 E.01931
G2 X131.421 Y134.518 I2.58 J-1.094 E.0275
G1 X134.11 Y134.518 E.05578
G1 X134.085 Y134.373 E.00305
G3 X134.553 Y132.843 I6.867 J1.263 E.03325
G1 X134.517 Y128 E.10046
G3 X134.085 Y127.09 I.637 J-.859 E.02176
G3 X134.553 Y125.56 I6.867 J1.263 E.03325
G1 X134.553 Y123.863 E.0352
M204 S10000
G1 X122.596 Y121.482 F60000
G1 F3625
M204 S4000
G1 X121.447 Y121.482 E.02383
G1 X121.447 Y122.03 E.01137
G3 X121.915 Y123.448 I-2.596 J1.643 E.03128
G1 X121.837 Y123.903 E.00958
G3 X121.447 Y124.402 I-6.462 J-4.651 E.01313
G1 X121.447 Y129.314 E.10188
G3 X121.915 Y130.731 I-2.596 J1.643 E.03128
G1 X121.837 Y131.186 E.00958
G3 X121.447 Y131.685 I-6.46 J-4.65 E.01313
G1 X121.447 Y134.518 E.05876
G1 X124.138 Y134.518 E.05581
G1 X123.951 Y134.373 E.00491
G3 X123.161 Y132.552 I2.134 J-2.008 E.042
G3 X123.592 Y131.642 I1.068 J-.051 E.02176
G1 X124.766 Y130.731 E.03082
G2 X125.556 Y128.91 I-2.134 J-2.008 E.042
G2 X125.125 Y128 I-1.068 J-.051 E.02176
G1 X123.951 Y127.09 E.03082
G3 X123.161 Y125.269 I2.134 J-2.008 E.042
G3 X123.592 Y124.358 I1.068 J-.051 E.02176
G1 X124.766 Y123.448 E.03082
G2 X125.556 Y121.627 I-2.134 J-2.008 E.042
G1 X125.531 Y121.482 E.00306
G1 X128.221 Y121.482 E.05578
G1 X128.408 Y121.627 E.00492
G3 X129.198 Y123.448 I-2.134 J2.008 E.042
G3 X128.767 Y124.358 I-1.068 J.051 E.02176
G1 X127.592 Y125.269 E.03082
G2 X126.802 Y127.09 I2.134 J2.008 E.042
G2 X127.233 Y128 I1.068 J.051 E.02176
G1 X128.408 Y128.91 E.03082
G3 X129.198 Y130.731 I-2.134 J2.008 E.042
G3 X128.767 Y131.642 I-1.068 J.051 E.02176
G1 X127.592 Y132.552 E.03082
G2 X126.802 Y134.373 I2.134 J2.008 E.042
G1 X126.827 Y134.518 E.00305
G1 X128.524 Y134.518 E.0352
M204 S10000
G1 X121.056 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3625
M204 S4000
G1 X121.056 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X121.056 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L36
M991 S0 P35 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.68 I-.753 J.956 P1  F60000
G1 X135.419 Y134.881 Z4.68
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3695
M204 S4000
G1 X135.419 Y121.119 E.28545
G1 X120.581 Y121.119 E.30777
G1 X120.581 Y134.881 E.28545
G1 X135.359 Y134.881 E.30652
; COOLING_NODE: 0
M204 S250
G1 X135.828 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3476
M204 S2000
G1 X135.828 Y120.71 E.28104
G1 X135.785 Y120.71 E.00083
G1 X120.215 Y120.71 E.30012
G1 X120.172 Y120.71 E.00083
G1 X120.172 Y135.29 E.28104
G1 X120.215 Y135.29 E.00083
G1 X135.768 Y135.29 E.2998
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.776 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.028 Y134.49 Z4.8 F60000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3695
M204 S4000
G1 X135.028 Y121.57 E.2259
M204 S10000
G1 X134.637 Y121.509 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3695
M204 S4000
G1 X132.967 Y121.482 E.03464
G3 X132.417 Y122.993 I-4.142 J-.654 E.03356
G3 X130.628 Y124.358 I-4.807 J-4.442 E.04691
G1 X130.318 Y124.814 E.01142
G2 X130.866 Y126.634 I2.932 J.11 E.04017
G2 X132.655 Y128 I4.807 J-4.441 E.04691
G1 X132.965 Y128.455 E.01142
G3 X132.417 Y130.276 I-2.932 J.11 E.04017
G3 X130.628 Y131.642 I-4.807 J-4.442 E.04691
G1 X130.318 Y132.097 E.01142
G2 X131.486 Y134.518 I2.886 J.1 E.05799
G1 X133.957 Y134.518 E.05127
G1 X133.956 Y134.373 E.00301
M73 P38 R13
G3 X134.637 Y132.866 I3.093 J.49 E.03472
G1 X134.637 Y128.228 E.09619
G3 X133.96 Y127.545 I.434 J-1.107 E.02055
G1 X133.956 Y127.09 E.00944
G3 X134.637 Y125.582 I3.093 J.49 E.03472
G1 X134.637 Y123.885 E.0352
M204 S10000
G1 X122.601 Y121.482 F60000
G1 F3695
M204 S4000
G1 X121.363 Y121.482 E.02569
G1 X121.363 Y121.941 E.00951
G3 X122.044 Y123.448 I-2.412 J1.997 E.03472
G3 X121.363 Y124.587 I-1.041 J.151 E.02978
G1 X121.363 Y129.224 E.09618
G3 X122.044 Y130.731 I-2.412 J1.997 E.03472
G3 X121.363 Y131.87 I-1.041 J.151 E.02978
G1 X121.363 Y134.518 E.05492
G1 X124.203 Y134.518 E.0589
G3 X123.031 Y132.552 I1.759 J-2.379 E.04874
G1 X123.035 Y132.097 E.00944
G1 X123.345 Y131.642 E.01142
G1 X124.077 Y131.186 E.01788
G2 X125.685 Y128.91 I-1.458 J-2.737 E.05996
G1 X125.682 Y128.455 E.00944
G1 X125.372 Y128 E.01142
G1 X124.64 Y127.545 E.01788
G3 X123.031 Y125.269 I1.458 J-2.737 E.05996
G1 X123.035 Y124.814 E.00944
G1 X123.345 Y124.358 E.01142
G1 X124.077 Y123.903 E.01788
G2 X125.685 Y121.627 I-1.458 J-2.737 E.05996
G1 X125.684 Y121.482 E.00301
G1 X128.156 Y121.482 E.05126
G3 X129.327 Y123.448 I-1.758 J2.38 E.04874
G1 X129.323 Y123.903 E.00944
G1 X129.013 Y124.358 E.01142
G1 X128.282 Y124.814 E.01788
G2 X126.673 Y127.09 I1.458 J2.737 E.05996
G1 X126.677 Y127.545 E.00944
G1 X126.987 Y128 E.01142
G1 X127.719 Y128.455 E.01788
G3 X129.327 Y130.731 I-1.458 J2.737 E.05996
G1 X129.323 Y131.186 E.00944
G1 X129.013 Y131.642 E.01142
G1 X128.282 Y132.097 E.01788
G2 X126.673 Y134.373 I1.458 J2.737 E.05996
G1 X126.674 Y134.518 E.00301
G1 X128.371 Y134.518 E.0352
M204 S10000
G1 X120.972 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3695
M204 S4000
G1 X120.972 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.972 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L37
M991 S0 P36 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.8 I-.748 J.96 P1  F60000
G1 X135.503 Y134.881 Z4.8
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3814
M204 S4000
G1 X135.503 Y121.119 E.28545
G1 X120.497 Y121.119 E.31125
G1 X120.497 Y134.881 E.28545
G1 X135.443 Y134.881 E.31001
; COOLING_NODE: 0
M204 S250
G1 X135.912 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X135.912 Y120.71 E.28104
G1 F3511
G1 X135.869 Y120.71 E.00083
G1 X120.131 Y120.71 E.30336
G1 X120.088 Y120.71 E.00083
G1 F3480
G1 X120.088 Y135.29 E.28104
G1 F3511
G1 X120.131 Y135.29 E.00083
G1 X135.852 Y135.29 E.30303
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.86 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.112 Y134.49 Z4.92 F60000
G1 Z4.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3814
M204 S4000
G1 X135.112 Y121.57 E.2259
M204 S10000
G1 X134.721 Y121.61 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3814
M204 S4000
G1 X134.721 Y121.482 E.00266
G1 X133.152 Y121.482 E.03254
G3 X131.957 Y123.448 I-3.522 J-.795 E.04857
G3 X130.202 Y124.358 I-5.759 J-8.953 E.04106
G1 X130.054 Y124.814 E.00993
G2 X131.326 Y127.09 I4.022 J-.754 E.05504
G2 X133.081 Y128 I5.76 J-8.954 E.04106
G1 X133.229 Y128.455 E.00993
G3 X131.957 Y130.731 I-4.022 J-.754 E.05504
G3 X130.202 Y131.642 I-5.76 J-8.955 E.04106
G2 X130.167 Y132.552 I.714 J.483 E.01991
G2 X131.574 Y134.518 I3.209 J-.811 E.05134
G1 X133.773 Y134.518 E.0456
G3 X134.721 Y132.79 I3.475 J.783 E.04142
G1 X134.721 Y128.409 E.09088
G1 X133.844 Y128 E.02007
G1 X133.696 Y127.545 E.00993
G3 X134.721 Y125.507 I4.052 J.762 E.04794
G1 X134.721 Y123.81 E.0352
M204 S10000
G1 X122.593 Y121.482 F60000
G1 F3814
M204 S4000
G1 X121.279 Y121.482 E.02725
G1 X121.279 Y121.866 E.00795
G3 X122.191 Y123.448 I-2.46 J2.472 E.03834
G3 X122.156 Y124.358 I-.749 J.427 E.01991
G1 X121.279 Y124.767 E.02008
G1 X121.279 Y129.149 E.09088
G3 X122.191 Y130.731 I-2.46 J2.472 E.03834
G3 X122.156 Y131.642 I-.749 J.427 E.01991
G1 X121.279 Y132.051 E.02008
G1 X121.279 Y134.518 E.05118
G1 X124.291 Y134.518 E.06248
G3 X122.884 Y132.552 I1.802 J-2.777 E.05134
G3 X122.919 Y131.642 I.749 J-.427 E.01991
G1 X123.895 Y131.186 E.02234
G2 X125.833 Y128.91 I-1.368 J-3.127 E.06417
G2 X125.798 Y128 I-.749 J-.427 E.01991
G1 X124.821 Y127.545 E.02234
G3 X122.884 Y125.269 I1.368 J-3.127 E.06417
G3 X122.919 Y124.358 I.749 J-.427 E.01991
G1 X123.895 Y123.903 E.02234
G2 X125.869 Y121.482 I-1.392 J-3.149 E.06725
G1 X128.067 Y121.482 E.04559
G3 X129.475 Y123.448 I-1.802 J2.777 E.05134
G3 X129.439 Y124.358 I-.749 J.427 E.01991
G1 X128.463 Y124.814 E.02234
G2 X126.526 Y127.09 I1.368 J3.127 E.06417
G2 X126.561 Y128 I.749 J.427 E.01991
G1 X127.537 Y128.455 E.02234
G3 X129.475 Y130.731 I-1.368 J3.127 E.06417
G3 X129.439 Y131.642 I-.749 J.427 E.01991
G1 X128.463 Y132.097 E.02234
G2 X126.49 Y134.518 I1.392 J3.149 E.06724
G1 X128.187 Y134.518 E.0352
M204 S10000
G1 X120.888 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3814
M204 S4000
G1 X120.888 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.888 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L38
M991 S0 P37 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.92 I-.742 J.964 P1  F60000
G1 X135.587 Y134.881 Z4.92
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3653
M204 S4000
G1 X135.587 Y121.119 E.28545
G1 X120.413 Y121.119 E.31474
G1 X120.413 Y134.881 E.28545
G1 X135.527 Y134.881 E.31349
; COOLING_NODE: 0
M204 S250
G1 X135.996 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
M73 P38 R12
G1 X135.996 Y120.71 E.28104
G1 F3537
G1 X135.953 Y120.71 E.00083
G1 X120.047 Y120.71 E.3066
G1 X120.004 Y120.71 E.00083
G1 F3480
G1 X120.004 Y135.29 E.28104
G1 F3537
G1 X120.047 Y135.29 E.00083
G1 X135.936 Y135.29 E.30627
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X135.944 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.196 Y134.49 Z5.04 F60000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3653
M204 S4000
G1 X135.196 Y121.57 E.2259
M204 S10000
G1 X131.688 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3653
M204 S4000
G1 X133.385 Y121.482 E.0352
G3 X132.097 Y123.318 I-5.677 J-2.612 E.04677
G3 X130.276 Y123.991 I-2.356 J-3.572 E.04062
G1 X129.821 Y123.734 E.01084
G1 X129.366 Y122.908 E.01956
G2 X128.02 Y121.482 I-3.037 J1.517 E.04126
G1 X126.101 Y121.482 E.0398
G3 X124.814 Y123.318 I-5.677 J-2.612 E.04677
G3 X122.993 Y123.991 I-2.356 J-3.572 E.04062
G1 X122.538 Y123.734 E.01084
G2 X121.195 Y121.78 I-6.029 J2.703 E.04946
G1 X121.195 Y124.935 E.06545
G3 X122.082 Y124.726 I.87 J1.698 E.0191
G1 X122.538 Y124.982 E.01084
G2 X123.903 Y126.96 I6.017 J-2.696 E.05012
G2 X125.724 Y127.633 I2.356 J-3.572 E.04062
G1 X126.179 Y127.376 E.01084
G3 X127.545 Y125.399 I6.017 J2.696 E.05012
G3 X129.366 Y124.726 I2.356 J3.572 E.04062
G1 X129.821 Y124.982 E.01084
G2 X131.186 Y126.96 I6.017 J-2.696 E.05012
G2 X133.007 Y127.633 I2.356 J-3.572 E.04062
G1 X133.462 Y127.376 E.01084
G3 X134.805 Y125.421 I6.029 J2.703 E.04946
G1 X134.805 Y128.577 E.06545
G2 X133.918 Y128.367 I-.869 J1.698 E.0191
G1 X133.462 Y128.624 E.01084
G3 X132.097 Y130.601 I-6.017 J-2.696 E.05012
G3 X130.276 Y131.275 I-2.356 J-3.572 E.04062
G1 X129.821 Y131.018 E.01084
G2 X128.455 Y129.041 I-6.017 J2.696 E.05012
G2 X126.634 Y128.367 I-2.356 J3.572 E.04062
G1 X126.179 Y128.624 E.01084
G3 X124.814 Y130.601 I-6.017 J-2.696 E.05012
G3 X122.993 Y131.275 I-2.356 J-3.572 E.04062
G1 X122.538 Y131.018 E.01084
G2 X121.195 Y129.063 I-6.029 J2.703 E.04946
G1 X121.195 Y132.218 E.06545
G3 X122.082 Y132.009 I.87 J1.698 E.0191
G1 X122.538 Y132.266 E.01084
G1 X122.993 Y133.092 E.01956
G2 X124.338 Y134.518 I3.037 J-1.517 E.04125
G1 X126.242 Y134.518 E.03948
G3 X127.545 Y132.682 I6.019 J2.892 E.04692
G3 X129.366 Y132.009 I2.356 J3.572 E.04062
G1 X129.821 Y132.266 E.01084
G1 X130.276 Y133.092 E.01956
G2 X131.621 Y134.518 I3.036 J-1.516 E.04125
G1 X133.525 Y134.518 E.03948
G3 X134.805 Y132.704 I6.033 J2.901 E.04626
G1 X134.805 Y131.007 E.0352
M204 S10000
G1 X120.804 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3653
M204 S4000
G1 X120.804 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.804 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L39
M991 S0 P38 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.04 I-.737 J.969 P1  F60000
G1 X135.671 Y134.881 Z5.04
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3626
M204 S4000
G1 X135.671 Y121.119 E.28545
G1 X120.329 Y121.119 E.31822
G1 X120.329 Y134.881 E.28545
G1 X135.611 Y134.881 E.31698
; COOLING_NODE: 0
M204 S250
G1 X136.08 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.08 Y120.71 E.28104
G1 F3555
G1 X136.037 Y120.71 E.00083
M73 P39 R12
G1 X119.963 Y120.71 E.30984
G1 X119.92 Y120.71 E.00083
G1 F3480
G1 X119.92 Y135.29 E.28104
G1 F3555
G1 X119.963 Y135.29 E.00083
G1 X136.02 Y135.29 E.30951
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.028 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.28 Y134.49 Z5.16 F60000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3626
M204 S4000
G1 X135.28 Y121.57 E.2259
M204 S10000
G1 X131.994 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3626
M204 S4000
G1 X133.691 Y121.482 E.0352
G1 X133.462 Y121.65 E.00589
G1 X132.552 Y122.92 E.03241
G3 X130.731 Y123.802 I-2.177 J-2.173 E.04276
G1 X130.276 Y123.76 E.00948
G1 X129.821 Y123.425 E.01173
G1 X128.91 Y122.155 E.03241
G2 X127.878 Y121.482 I-2 J1.939 E.02578
G1 X126.408 Y121.482 E.0305
G1 X126.179 Y121.65 E.00589
G1 X125.269 Y122.92 E.03241
G3 X123.448 Y123.802 I-2.177 J-2.173 E.04276
G1 X122.993 Y123.76 E.00948
G1 X122.538 Y123.425 E.01173
G1 X121.627 Y122.155 E.03241
G2 X121.111 Y121.731 I-1.276 J1.028 E.01395
G1 X121.111 Y125.052 E.06887
G3 X122.082 Y124.957 I.616 J1.28 E.02067
G1 X122.538 Y125.292 E.01173
G1 X123.448 Y126.562 E.03241
G2 X125.269 Y127.444 I2.177 J-2.173 E.04276
G1 X125.724 Y127.402 E.00948
G1 X126.179 Y127.067 E.01173
G1 X127.09 Y125.797 E.03241
G3 X128.91 Y124.915 I2.177 J2.173 E.04276
G1 X129.366 Y124.957 E.00948
G1 X129.821 Y125.292 E.01173
G1 X130.731 Y126.562 E.03241
G2 X132.552 Y127.444 I2.177 J-2.173 E.04276
G1 X133.007 Y127.402 E.00948
G1 X133.462 Y127.067 E.01173
G1 X134.373 Y125.797 E.03241
G3 X134.889 Y125.373 I1.276 J1.028 E.01395
G1 X134.889 Y128.693 E.06887
G2 X133.918 Y128.598 I-.615 J1.28 E.02067
G1 X133.462 Y128.934 E.01173
G1 X132.552 Y130.203 E.03241
G3 X130.731 Y131.085 I-2.177 J-2.173 E.04276
G1 X130.276 Y131.044 E.00948
G1 X129.821 Y130.708 E.01173
G1 X128.91 Y129.438 E.03241
G2 X127.09 Y128.556 I-2.177 J2.173 E.04276
G1 X126.634 Y128.598 E.00948
G1 X126.179 Y128.934 E.01173
G1 X125.269 Y130.203 E.03241
G3 X123.448 Y131.085 I-2.177 J-2.173 E.04276
G1 X122.993 Y131.044 E.00948
G1 X122.538 Y130.708 E.01173
G1 X121.627 Y129.438 E.03241
G2 X121.111 Y129.015 I-1.276 J1.028 E.01395
G1 X121.111 Y132.335 E.06887
G3 X122.082 Y132.24 I.616 J1.28 E.02067
G1 X122.538 Y132.575 E.01173
G1 X123.448 Y133.845 E.03241
G2 X124.567 Y134.518 I1.648 J-1.473 E.02749
G1 X125.903 Y134.518 E.02772
G1 X126.179 Y134.35 E.00671
G1 X127.09 Y133.08 E.03241
G3 X128.91 Y132.198 I2.177 J2.173 E.04276
G1 X129.366 Y132.24 E.00948
G1 X129.821 Y132.575 E.01173
G1 X130.731 Y133.845 E.03241
G2 X131.85 Y134.518 I1.648 J-1.473 E.02749
G1 X133.186 Y134.518 E.02772
G1 X133.462 Y134.35 E.00671
G1 X134.373 Y133.08 E.03241
G3 X134.889 Y132.656 I1.276 J1.028 E.01395
G1 X134.889 Y130.959 E.0352
M204 S10000
G1 X120.72 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3626
M204 S4000
G1 X120.72 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.72 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L40
M991 S0 P39 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.16 I-.732 J.972 P1  F60000
G1 X135.755 Y134.881 Z5.16
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3614
M204 S4000
G1 X135.755 Y121.119 E.28545
G1 X120.245 Y121.119 E.32171
G1 X120.245 Y134.881 E.28545
G1 X135.695 Y134.881 E.32046
; COOLING_NODE: 0
M204 S250
G1 X136.164 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.164 Y120.71 E.28104
G1 F3569
G1 X136.121 Y120.71 E.00083
G1 X119.879 Y120.71 E.31308
G1 X119.836 Y120.71 E.00083
G1 F3480
G1 X119.836 Y135.29 E.28104
G1 F3569
G1 X119.879 Y135.29 E.00083
G1 X136.104 Y135.29 E.31275
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.112 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.364 Y134.49 Z5.28 F60000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3614
M204 S4000
G1 X135.364 Y121.57 E.2259
M204 S10000
G1 X132.297 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3614
M204 S4000
G1 X133.994 Y121.482 E.0352
G1 X133.462 Y121.863 E.01357
G1 X132.552 Y122.969 E.0297
G3 X131.186 Y123.647 I-1.974 J-2.259 E.03198
G3 X129.821 Y123.212 I-.303 J-1.41 E.03111
G1 X128.91 Y122.107 E.0297
G2 X127.744 Y121.482 I-1.903 J2.151 E.02769
G1 X126.634 Y121.5 E.02302
G1 X126.179 Y121.863 E.01209
G1 X125.269 Y122.969 E.0297
G3 X123.903 Y123.647 I-1.974 J-2.259 E.03198
G3 X122.538 Y123.212 I-.303 J-1.41 E.03111
G1 X121.627 Y122.107 E.0297
G2 X121.027 Y121.697 I-1.288 J1.242 E.01518
G1 X121.027 Y125.109 E.07078
G3 X122.538 Y125.505 I.448 J1.372 E.03423
G1 X123.448 Y126.61 E.0297
G2 X124.814 Y127.289 I1.973 J-2.259 E.03198
G2 X126.179 Y126.853 I.303 J-1.41 E.03111
G1 X127.09 Y125.748 E.0297
G3 X128.455 Y125.07 I1.973 J2.259 E.03198
G3 X129.821 Y125.505 I.303 J1.41 E.03111
G1 X130.731 Y126.61 E.0297
G2 X132.097 Y127.289 I1.973 J-2.259 E.03198
G2 X133.462 Y126.853 I.303 J-1.41 E.03111
G1 X134.373 Y125.748 E.0297
G3 X134.973 Y125.338 I1.288 J1.242 E.01518
G1 X134.973 Y128.751 E.07078
G2 X133.462 Y129.147 I-.447 J1.372 E.03423
G1 X132.552 Y130.252 E.0297
G3 X131.186 Y130.93 I-1.973 J-2.259 E.03198
G3 X129.821 Y130.495 I-.303 J-1.41 E.03111
G1 X128.91 Y129.39 E.0297
G2 X127.545 Y128.712 I-1.973 J2.259 E.03198
G2 X126.179 Y129.147 I-.303 J1.41 E.03111
G1 X125.269 Y130.252 E.0297
G3 X123.903 Y130.93 I-1.973 J-2.259 E.03198
G3 X122.538 Y130.495 I-.303 J-1.41 E.03111
G1 X121.627 Y129.39 E.0297
G2 X121.027 Y128.98 I-1.288 J1.242 E.01518
G1 X121.027 Y132.392 E.07078
G3 X122.538 Y132.788 I.448 J1.372 E.03423
G1 X123.448 Y133.893 E.0297
G2 X124.614 Y134.518 I1.903 J-2.151 E.02769
G1 X125.724 Y134.5 E.02302
G1 X126.179 Y134.137 E.01209
G1 X127.09 Y133.032 E.0297
G3 X128.455 Y132.353 I1.973 J2.259 E.03198
G3 X129.821 Y132.788 I.303 J1.41 E.03111
G1 X130.731 Y133.893 E.0297
G2 X131.897 Y134.518 I1.903 J-2.151 E.02769
G1 X133.007 Y134.5 E.02302
G1 X133.462 Y134.137 E.01209
G1 X134.373 Y133.032 E.0297
G3 X134.973 Y132.622 I1.288 J1.242 E.01518
G1 X134.973 Y134.319 E.0352
M204 S10000
G1 X120.636 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3614
M204 S4000
G1 X120.636 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.636 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L41
M991 S0 P40 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.28 I-.726 J.976 P1  F60000
G1 X135.839 Y134.881 Z5.28
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3634
M204 S4000
G1 X135.839 Y121.119 E.28545
G1 X120.161 Y121.119 E.32519
G1 X120.161 Y134.881 E.28545
G1 X135.779 Y134.881 E.32395
; COOLING_NODE: 0
M204 S250
G1 X136.248 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.248 Y120.71 E.28104
G1 F3578
G1 X136.205 Y120.71 E.00083
G1 X119.795 Y120.71 E.31631
G1 X119.752 Y120.71 E.00083
G1 F3480
G1 X119.752 Y135.29 E.28104
G1 F3578
G1 X119.795 Y135.29 E.00083
G1 X136.188 Y135.29 E.31599
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.196 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.448 Y134.49 Z5.4 F60000
G1 Z5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3634
M204 S4000
G1 X135.448 Y121.57 E.2259
M204 S10000
G1 X135.057 Y123.234 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3634
M204 S4000
G1 X135.057 Y121.537 E.0352
G2 X133.918 Y121.655 I-.386 J1.828 E.02415
G2 X132.552 Y123.02 I4.458 J5.827 E.04016
G3 X130.276 Y123.42 I-1.479 J-1.735 E.05027
G3 X128.91 Y122.056 I4.458 J-5.827 E.04016
G2 X126.634 Y121.655 I-1.479 J1.735 E.05027
G2 X125.269 Y123.02 I4.459 J5.828 E.04016
G3 X122.993 Y123.42 I-1.479 J-1.735 E.05027
G3 X121.627 Y122.056 I4.459 J-5.827 E.04016
G2 X120.943 Y121.668 I-1.269 J1.444 E.01643
G1 X120.943 Y125.179 E.07281
G3 X122.082 Y125.297 I.387 J1.828 E.02415
G3 X123.448 Y126.661 I-4.458 J5.827 E.04016
G2 X125.724 Y127.062 I1.479 J-1.735 E.05027
G2 X127.09 Y125.697 I-4.459 J-5.828 E.04016
G3 X129.366 Y125.297 I1.479 J1.735 E.05027
G3 X130.731 Y126.661 I-4.459 J5.828 E.04016
G2 X133.007 Y127.062 I1.479 J-1.735 E.05027
G2 X134.373 Y125.697 I-4.459 J-5.828 E.04016
G3 X135.057 Y125.31 I1.269 J1.444 E.01642
G1 X135.057 Y128.82 E.07281
G2 X133.918 Y128.938 I-.386 J1.828 E.02415
G2 X132.552 Y130.303 I4.459 J5.828 E.04016
G3 X130.276 Y130.703 I-1.479 J-1.735 E.05027
G3 X128.91 Y129.339 I4.458 J-5.827 E.04016
G2 X126.634 Y128.938 I-1.479 J1.735 E.05027
G2 X125.269 Y130.303 I4.46 J5.828 E.04016
G3 X122.993 Y130.703 I-1.479 J-1.735 E.05027
G3 X121.627 Y129.339 I4.459 J-5.827 E.04016
G2 X120.943 Y128.952 I-1.269 J1.444 E.01643
G1 X120.943 Y132.462 E.07281
G3 X122.082 Y132.58 I.387 J1.828 E.02415
G3 X123.448 Y133.944 I-4.458 J5.827 E.04016
G2 X125.724 Y134.345 I1.479 J-1.735 E.05027
G2 X127.09 Y132.98 I-4.458 J-5.827 E.04016
G3 X129.366 Y132.58 I1.479 J1.735 E.05027
G3 X130.731 Y133.944 I-4.459 J5.828 E.04016
G2 X133.007 Y134.345 I1.479 J-1.735 E.05027
G2 X134.373 Y132.98 I-4.458 J-5.827 E.04016
G3 X135.057 Y132.593 I1.269 J1.444 E.01642
G1 X135.057 Y130.896 E.0352
M204 S10000
G1 X120.552 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3634
M204 S4000
G1 X120.552 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.552 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L42
M991 S0 P41 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.4 I-.721 J.98 P1  F60000
G1 X135.923 Y134.881 Z5.4
M73 P40 R12
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3641
M204 S4000
G1 X135.923 Y121.119 E.28545
G1 X120.077 Y121.119 E.32868
G1 X120.077 Y134.881 E.28545
G1 X135.863 Y134.881 E.32743
; COOLING_NODE: 0
M204 S250
G1 X136.332 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.332 Y120.71 E.28104
G1 F3585
G1 X136.289 Y120.71 E.00083
G1 X119.711 Y120.71 E.31955
G1 X119.668 Y120.71 E.00083
G1 F3480
G1 X119.668 Y135.29 E.28104
G1 F3585
G1 X119.711 Y135.29 E.00083
G1 X136.272 Y135.29 E.31923
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.28 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.532 Y134.49 Z5.52 F60000
G1 Z5.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3641
M204 S4000
G1 X135.532 Y121.57 E.2259
M204 S10000
G1 X135.141 Y123.283 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3641
M204 S4000
G1 X135.141 Y121.586 E.0352
G2 X133.462 Y122.179 I-.345 J1.694 E.0388
G3 X132.097 Y123.331 I-3.475 J-2.736 E.03731
G3 X129.821 Y122.896 I-.844 J-1.755 E.05148
G2 X128.455 Y121.745 I-3.475 J2.736 E.03731
G2 X126.179 Y122.179 I-.844 J1.755 E.05148
G3 X124.814 Y123.331 I-3.475 J-2.736 E.03731
G3 X122.538 Y122.896 I-.844 J-1.755 E.05148
G2 X120.859 Y121.646 I-3.081 J2.386 E.04395
G1 X120.859 Y125.227 E.07428
G3 X122.538 Y125.821 I.345 J1.694 E.0388
G2 X123.903 Y126.972 I3.475 J-2.736 E.03731
G2 X126.179 Y126.538 I.844 J-1.754 E.05148
G3 X127.545 Y125.386 I3.475 J2.736 E.03731
G3 X129.821 Y125.821 I.844 J1.755 E.05148
G2 X131.186 Y126.972 I3.475 J-2.736 E.03731
G2 X133.462 Y126.538 I.844 J-1.754 E.05148
G3 X135.141 Y125.288 I3.081 J2.386 E.04395
G1 X135.141 Y128.869 E.07428
G2 X133.462 Y129.462 I-.345 J1.694 E.0388
G3 X132.097 Y130.614 I-3.475 J-2.736 E.03731
G3 X129.821 Y130.179 I-.844 J-1.755 E.05148
G2 X128.455 Y129.028 I-3.475 J2.736 E.03731
G2 X126.179 Y129.462 I-.844 J1.755 E.05148
G3 X124.814 Y130.614 I-3.475 J-2.736 E.03731
G3 X122.538 Y130.179 I-.844 J-1.755 E.05148
G2 X120.859 Y128.929 I-3.081 J2.386 E.04395
G1 X120.859 Y132.51 E.07428
G3 X122.538 Y133.104 I.345 J1.694 E.0388
G2 X123.903 Y134.255 I3.475 J-2.736 E.03731
G2 X126.179 Y133.821 I.844 J-1.755 E.05148
G3 X127.545 Y132.669 I3.475 J2.736 E.03731
G3 X129.821 Y133.104 I.844 J1.755 E.05148
G2 X131.186 Y134.255 I3.475 J-2.736 E.03731
G2 X133.462 Y133.821 I.844 J-1.755 E.05148
G3 X135.141 Y132.571 I3.081 J2.386 E.04395
G1 X135.141 Y134.268 E.0352
M204 S10000
G1 X120.468 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3641
M204 S4000
G1 X120.468 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.468 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L43
M991 S0 P42 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.52 I-.716 J.984 P1  F60000
G1 X136.007 Y134.881 Z5.52
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3656
M204 S4000
G1 X136.007 Y121.119 E.28545
G1 X119.993 Y121.119 E.33216
G1 X119.993 Y134.881 E.28545
G1 X135.947 Y134.881 E.33092
; COOLING_NODE: 0
M204 S250
G1 X136.416 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.416 Y120.71 E.28104
G1 F3589
G1 X136.373 Y120.71 E.00083
G1 X119.627 Y120.71 E.32279
G1 X119.584 Y120.71 E.00083
G1 F3480
G1 X119.584 Y135.29 E.28104
G1 F3589
G1 X119.627 Y135.29 E.00083
G1 X136.356 Y135.29 E.32246
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.364 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.616 Y134.49 Z5.64 F60000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3656
M204 S4000
G1 X135.616 Y121.57 E.2259
M204 S10000
G1 X135.225 Y123.311 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3656
M204 S4000
G1 X135.225 Y121.614 E.0352
G2 X134.373 Y121.685 I-.27 J1.925 E.01788
G2 X133.007 Y122.774 I1.856 J3.728 E.0365
G3 X130.731 Y123.391 I-1.679 J-1.688 E.05117
G3 X129.366 Y122.302 I1.856 J-3.728 E.0365
G2 X127.09 Y121.685 I-1.679 J1.688 E.05117
G2 X125.724 Y122.774 I1.856 J3.728 E.0365
G3 X122.538 Y122.764 I-1.589 J-1.473 E.07426
G2 X120.775 Y121.63 I-2.595 J2.098 E.04422
G1 X120.775 Y125.256 E.0752
G3 X121.627 Y125.326 I.27 J1.925 E.01789
G3 X122.993 Y126.415 I-1.856 J3.728 E.0365
G2 X125.269 Y127.032 I1.679 J-1.688 E.05117
G2 X126.634 Y125.943 I-1.856 J-3.728 E.0365
G3 X128.91 Y125.326 I1.679 J1.688 E.05117
G3 X130.276 Y126.415 I-1.856 J3.728 E.0365
G2 X133.462 Y126.406 I1.589 J-1.473 E.07426
G3 X135.225 Y125.272 I2.595 J2.098 E.04422
G1 X135.225 Y128.898 E.0752
G2 X134.373 Y128.968 I-.27 J1.925 E.01788
G2 X133.007 Y130.057 I1.856 J3.728 E.0365
G3 X130.731 Y130.674 I-1.679 J-1.688 E.05117
G3 X129.366 Y129.585 I1.856 J-3.728 E.0365
G2 X127.09 Y128.968 I-1.679 J1.688 E.05117
G2 X125.724 Y130.057 I1.856 J3.728 E.0365
G3 X122.538 Y130.047 I-1.589 J-1.473 E.07425
G2 X120.775 Y128.914 I-2.596 J2.098 E.04422
G1 X120.775 Y132.539 E.0752
G3 X121.627 Y132.609 I.27 J1.926 E.01789
G3 X122.993 Y133.699 I-1.856 J3.728 E.0365
G2 X125.269 Y134.315 I1.679 J-1.688 E.05117
G2 X126.634 Y133.226 I-1.856 J-3.728 E.0365
G3 X128.91 Y132.609 I1.679 J1.688 E.05117
G3 X130.276 Y133.699 I-1.856 J3.728 E.0365
G2 X133.462 Y133.689 I1.589 J-1.473 E.07425
G3 X135.225 Y132.555 I2.595 J2.098 E.04422
G1 X135.225 Y134.252 E.0352
M204 S10000
G1 X120.384 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3656
M204 S4000
G1 X120.384 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.384 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L44
M991 S0 P43 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.64 I-.711 J.988 P1  F60000
G1 X136.091 Y134.881 Z5.64
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3677
M204 S4000
G1 X136.091 Y121.119 E.28545
G1 X119.909 Y121.119 E.33565
G1 X119.909 Y134.881 E.28545
G1 X136.031 Y134.881 E.3344
; COOLING_NODE: 0
M204 S250
G1 X136.5 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.5 Y120.71 E.28104
G1 F3593
G1 X136.457 Y120.71 E.00083
G1 X119.543 Y120.71 E.32603
G1 X119.5 Y120.71 E.00083
G1 F3480
G1 X119.5 Y135.29 E.28104
G1 F3593
G1 X119.543 Y135.29 E.00083
G1 X136.44 Y135.29 E.3257
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.448 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.7 Y134.49 Z5.76 F60000
G1 Z5.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3677
M204 S4000
G1 X135.7 Y121.57 E.2259
M204 S10000
G1 X120.691 Y123.323 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3677
M204 S4000
G1 X120.691 Y121.626 E.0352
G3 X122.538 Y122.64 I-.233 J2.612 E.04498
G2 X125.724 Y122.874 I1.705 J-1.405 E.07408
G3 X127.09 Y121.763 I4.184 J3.746 E.03667
G3 X129.821 Y122.64 I.764 J2.311 E.06363
G2 X133.007 Y122.874 I1.705 J-1.405 E.07408
G3 X134.373 Y121.763 I4.183 J3.746 E.03667
G3 X135.309 Y121.629 I.857 J2.655 E.01971
G1 X135.309 Y125.268 E.07547
G2 X133.462 Y126.282 I.233 J2.612 E.04497
G3 X130.276 Y126.516 I-1.705 J-1.405 E.07408
G2 X128.91 Y125.404 I-4.183 J3.745 E.03667
G2 X126.179 Y126.282 I-.764 J2.311 E.06363
G3 X122.993 Y126.516 I-1.705 J-1.405 E.07408
M73 P41 R12
G2 X121.627 Y125.404 I-4.183 J3.745 E.03667
G2 X120.691 Y125.271 I-.856 J2.654 E.01971
G1 X120.691 Y128.909 E.07547
G3 X122.538 Y129.924 I-.233 J2.612 E.04498
G2 X125.724 Y130.157 I1.705 J-1.405 E.07408
G3 X127.09 Y129.046 I4.183 J3.746 E.03667
G3 X129.821 Y129.924 I.764 J2.311 E.06363
G2 X133.007 Y130.157 I1.705 J-1.405 E.07408
G3 X134.373 Y129.046 I4.183 J3.745 E.03667
G3 X135.309 Y128.912 I.857 J2.655 E.01971
G1 X135.309 Y132.551 E.07547
G2 X133.462 Y133.565 I.233 J2.612 E.04497
G3 X130.276 Y133.799 I-1.705 J-1.405 E.07408
G2 X128.91 Y132.688 I-4.183 J3.746 E.03667
G2 X126.179 Y133.565 I-.764 J2.311 E.06363
G3 X122.993 Y133.799 I-1.705 J-1.405 E.07408
G2 X121.627 Y132.688 I-4.183 J3.746 E.03667
G2 X120.691 Y132.554 I-.856 J2.653 E.01971
G1 X120.691 Y134.251 E.0352
M204 S10000
G1 X120.3 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3677
M204 S4000
G1 X120.3 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.3 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L45
M991 S0 P44 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.76 I-.706 J.991 P1  F60000
G1 X136.175 Y134.881 Z5.76
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3709
M204 S4000
G1 X136.175 Y121.119 E.28545
G1 X119.825 Y121.119 E.33913
G1 X119.825 Y134.881 E.28545
G1 X136.115 Y134.881 E.33789
; COOLING_NODE: 0
M204 S250
G1 X136.584 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.584 Y120.71 E.28104
G1 F3595
G1 X136.541 Y120.71 E.00083
G1 X119.459 Y120.71 E.32927
G1 X119.416 Y120.71 E.00083
G1 F3480
G1 X119.416 Y135.29 E.28104
G1 F3595
G1 X119.459 Y135.29 E.00083
G1 X136.524 Y135.29 E.32894
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.532 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.784 Y134.49 Z5.88 F60000
G1 Z5.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3709
M204 S4000
G1 X135.784 Y121.57 E.2259
M204 S10000
G1 X135.393 Y123.334 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3709
M204 S4000
G1 X135.393 Y121.637 E.0352
G2 X133.462 Y122.555 I-.046 J2.393 E.04597
G3 X129.821 Y122.52 I-1.807 J-1.416 E.08723
G2 X126.179 Y122.555 I-1.807 J1.416 E.08723
G3 X122.538 Y122.52 I-1.807 J-1.416 E.08723
G2 X120.607 Y121.639 I-1.826 J1.447 E.0457
G1 X120.607 Y125.279 E.07549
G3 X122.538 Y126.197 I.046 J2.392 E.04597
G2 X126.179 Y126.162 I1.807 J-1.416 E.08723
G3 X129.821 Y126.197 I1.807 J1.416 E.08723
G2 X133.462 Y126.162 I1.807 J-1.416 E.08723
G3 X135.393 Y125.281 I1.826 J1.447 E.0457
G1 X135.393 Y128.92 E.07549
G2 X133.462 Y129.838 I-.046 J2.393 E.04597
G3 X129.821 Y129.803 I-1.807 J-1.416 E.08723
G2 X126.179 Y129.838 I-1.807 J1.416 E.08723
G3 X122.538 Y129.803 I-1.807 J-1.416 E.08723
G2 X120.607 Y128.923 I-1.826 J1.447 E.0457
G1 X120.607 Y132.562 E.07549
G3 X122.538 Y133.48 I.046 J2.392 E.04597
G2 X126.179 Y133.445 I1.807 J-1.416 E.08723
G3 X129.821 Y133.48 I1.807 J1.416 E.08723
G2 X133.462 Y133.445 I1.807 J-1.416 E.08723
G3 X135.393 Y132.564 I1.826 J1.447 E.0457
G1 X135.393 Y134.261 E.0352
M204 S10000
G1 X120.216 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3709
M204 S4000
G1 X120.216 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.216 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L46
M991 S0 P45 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.88 I-.701 J.995 P1  F60000
G1 X136.259 Y134.881 Z5.88
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3739
M204 S4000
G1 X136.259 Y121.119 E.28545
G1 X119.741 Y121.119 E.34261
G1 X119.741 Y134.881 E.28545
G1 X136.199 Y134.881 E.34137
; COOLING_NODE: 0
M204 S250
G1 X136.668 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.668 Y120.71 E.28104
G1 F3596
G1 X136.625 Y120.71 E.00083
G1 X119.375 Y120.71 E.33251
G1 X119.332 Y120.71 E.00083
G1 F3480
G1 X119.332 Y135.29 E.28104
G1 F3596
G1 X119.375 Y135.29 E.00083
G1 X136.608 Y135.29 E.33218
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.616 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.868 Y134.49 Z6 F60000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3739
M204 S4000
G1 X135.868 Y121.57 E.2259
M204 S10000
G1 X135.477 Y123.323 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3739
M204 S4000
G1 X135.477 Y121.626 E.0352
G2 X133.462 Y122.676 I.069 J2.589 E.04878
G3 X130.276 Y122.845 I-1.673 J-1.421 E.0741
G2 X128.91 Y121.741 I-3.849 J3.365 E.03661
G2 X126.179 Y122.676 I-.708 J2.386 E.06388
G3 X122.993 Y122.845 I-1.673 J-1.421 E.0741
G2 X121.627 Y121.741 I-3.849 J3.365 E.03661
G2 X120.523 Y121.659 I-.717 J2.194 E.0232
G1 X120.523 Y125.268 E.07485
G3 X122.538 Y126.318 I-.069 J2.589 E.04879
G2 X125.724 Y126.486 I1.673 J-1.421 E.0741
G3 X127.09 Y125.382 I3.849 J3.365 E.03661
G3 X129.821 Y126.318 I.708 J2.386 E.06388
G2 X133.007 Y126.486 I1.673 J-1.421 E.0741
G3 X134.373 Y125.382 I3.849 J3.365 E.03661
G3 X135.477 Y125.301 I.717 J2.194 E.02319
G1 X135.477 Y128.909 E.07485
G2 X133.462 Y129.959 I.069 J2.589 E.04878
G3 X130.276 Y130.128 I-1.673 J-1.421 E.0741
G2 X128.91 Y129.024 I-3.849 J3.365 E.03661
G2 X126.179 Y129.959 I-.708 J2.386 E.06388
G3 X122.993 Y130.128 I-1.673 J-1.421 E.0741
G2 X121.627 Y129.024 I-3.849 J3.365 E.03661
G2 X120.523 Y128.942 I-.717 J2.194 E.0232
G1 X120.523 Y132.551 E.07485
G3 X122.538 Y133.601 I-.068 J2.589 E.04879
G2 X125.724 Y133.769 I1.673 J-1.421 E.0741
G3 X127.09 Y132.665 I3.849 J3.365 E.03661
G3 X129.821 Y133.601 I.708 J2.386 E.06388
G2 X133.007 Y133.769 I1.673 J-1.421 E.0741
G3 X134.373 Y132.665 I3.849 J3.365 E.03661
G3 X135.477 Y132.584 I.717 J2.194 E.02319
G1 X135.477 Y134.281 E.0352
M204 S10000
G1 X120.132 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3739
M204 S4000
G1 X120.132 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.132 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L47
M991 S0 P46 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6 I-.696 J.998 P1  F60000
G1 X136.343 Y134.881 Z6
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3777
M204 S4000
G1 X136.343 Y121.119 E.28545
G1 X119.657 Y121.119 E.3461
G1 X119.657 Y134.881 E.28545
G1 X136.283 Y134.881 E.34486
; COOLING_NODE: 0
M204 S250
G1 X136.752 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.752 Y120.71 E.28104
G1 F3598
G1 X136.709 Y120.71 E.00083
G1 X119.291 Y120.71 E.33574
G1 X119.248 Y120.71 E.00083
G1 F3480
G1 X119.248 Y135.29 E.28104
G1 F3598
G1 X119.291 Y135.29 E.00083
G1 X136.692 Y135.29 E.33542
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.7 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.952 Y134.49 Z6.12 F60000
G1 Z5.72
M73 P42 R12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3777
M204 S4000
G1 X135.952 Y121.57 E.2259
M204 S10000
G1 X135.561 Y123.293 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3777
M204 S4000
G1 X135.561 Y121.596 E.0352
G2 X133.462 Y122.802 I.218 J2.808 E.05189
G3 X130.276 Y122.744 I-1.567 J-1.484 E.07437
G2 X128.91 Y121.66 I-3.012 J2.392 E.03648
G2 X126.634 Y122.331 I-.544 J2.35 E.05146
G3 X125.269 Y123.415 I-3.013 J-2.392 E.03648
G3 X122.993 Y122.744 I-.544 J-2.35 E.05146
G2 X121.627 Y121.66 I-3.012 J2.392 E.03648
G2 X120.439 Y121.685 I-.546 J2.271 E.02493
G1 X120.439 Y125.238 E.07369
G3 X122.538 Y126.444 I-.218 J2.808 E.05189
G2 X125.724 Y126.386 I1.567 J-1.484 E.07437
G3 X127.09 Y125.302 I3.013 J2.392 E.03648
G3 X129.366 Y125.973 I.544 J2.35 E.05146
G2 X130.731 Y127.057 I3.012 J-2.392 E.03648
G2 X133.007 Y126.386 I.544 J-2.35 E.05146
G3 X134.373 Y125.302 I3.012 J2.392 E.03648
G3 X135.561 Y125.327 I.546 J2.271 E.02493
G1 X135.561 Y128.88 E.07369
G2 X133.462 Y130.085 I.218 J2.808 E.05189
G3 X130.276 Y130.027 I-1.567 J-1.484 E.07437
G2 X128.91 Y128.943 I-3.012 J2.392 E.03648
G2 X126.634 Y129.614 I-.544 J2.35 E.05146
G3 X125.269 Y130.698 I-3.013 J-2.393 E.03648
G3 X122.993 Y130.027 I-.544 J-2.35 E.05146
G2 X121.627 Y128.943 I-3.012 J2.392 E.03648
G2 X120.439 Y128.968 I-.546 J2.271 E.02493
G1 X120.439 Y132.521 E.07369
G3 X122.538 Y133.727 I-.218 J2.808 E.05189
G2 X125.724 Y133.669 I1.567 J-1.484 E.07437
G3 X127.09 Y132.585 I3.013 J2.392 E.03648
G3 X129.366 Y133.256 I.544 J2.35 E.05146
G2 X130.731 Y134.34 I3.012 J-2.392 E.03648
G2 X133.007 Y133.669 I.544 J-2.35 E.05146
G3 X134.373 Y132.585 I3.012 J2.392 E.03648
G3 X135.561 Y132.61 I.546 J2.271 E.02493
G1 X135.561 Y134.307 E.0352
M204 S10000
G1 X120.048 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3777
M204 S4000
G1 X120.048 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X120.048 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L48
M991 S0 P47 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.12 I-.692 J1.001 P1  F60000
G1 X136.427 Y134.881 Z6.12
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3824
M204 S4000
G1 X136.427 Y121.119 E.28545
G1 X119.573 Y121.119 E.34958
G1 X119.573 Y134.881 E.28545
G1 X136.367 Y134.881 E.34834
; COOLING_NODE: 0
M204 S250
G1 X136.836 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.836 Y120.71 E.28104
G1 F3598
G1 X136.793 Y120.71 E.00083
G1 X119.207 Y120.71 E.33898
G1 X119.164 Y120.71 E.00083
G1 F3480
G1 X119.164 Y135.29 E.28104
G1 F3598
G1 X119.207 Y135.29 E.00083
G1 X136.776 Y135.29 E.33866
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.784 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.036 Y134.49 Z6.24 F60000
G1 Z5.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3824
M204 S4000
G1 X136.036 Y121.57 E.2259
M204 S10000
G1 X135.645 Y123.244 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3824
M204 S4000
G1 X135.645 Y121.547 E.0352
G2 X133.918 Y122.433 I.229 J2.573 E.04128
G3 X132.552 Y123.504 I-2.449 J-1.716 E.03653
G3 X130.276 Y122.642 I-.349 J-2.513 E.05265
G2 X128.91 Y121.571 I-2.449 J1.716 E.03653
G2 X126.634 Y122.433 I-.349 J2.513 E.05265
G3 X125.269 Y123.504 I-2.449 J-1.716 E.03653
G3 X122.993 Y122.642 I-.349 J-2.513 E.05265
G2 X121.627 Y121.571 I-2.449 J1.716 E.03653
G2 X120.355 Y121.718 I-.363 J2.444 E.02687
G1 X120.355 Y125.189 E.07199
G3 X122.083 Y126.075 I-.229 J2.573 E.04128
G2 X123.448 Y127.146 I2.449 J-1.716 E.03653
G2 X125.724 Y126.284 I.349 J-2.513 E.05265
G3 X127.09 Y125.213 I2.449 J1.716 E.03653
G3 X129.366 Y126.075 I.349 J2.513 E.05265
G2 X130.731 Y127.146 I2.449 J-1.716 E.03653
G2 X133.007 Y126.284 I.349 J-2.513 E.05265
G3 X134.373 Y125.213 I2.449 J1.716 E.03653
G3 X135.645 Y125.359 I.363 J2.444 E.02687
G1 X135.645 Y128.83 E.07199
G2 X133.918 Y129.716 I.229 J2.573 E.04128
G3 X132.552 Y130.787 I-2.449 J-1.716 E.03653
G3 X130.276 Y129.925 I-.349 J-2.513 E.05265
G2 X128.91 Y128.854 I-2.449 J1.716 E.03653
G2 X126.634 Y129.716 I-.349 J2.513 E.05265
G3 X125.269 Y130.787 I-2.449 J-1.716 E.03653
G3 X122.993 Y129.925 I-.349 J-2.513 E.05265
G2 X121.627 Y128.854 I-2.449 J1.715 E.03653
G2 X120.355 Y129.001 I-.363 J2.444 E.02687
G1 X120.355 Y132.472 E.07199
G3 X122.083 Y133.358 I-.229 J2.573 E.04128
G2 X123.448 Y134.429 I2.449 J-1.715 E.03653
G2 X125.724 Y133.567 I.349 J-2.513 E.05265
G3 X127.09 Y132.496 I2.449 J1.716 E.03653
G3 X129.366 Y133.358 I.349 J2.513 E.05265
G2 X130.731 Y134.429 I2.449 J-1.715 E.03653
G2 X133.007 Y133.567 I.349 J-2.513 E.05265
G3 X134.373 Y132.496 I2.449 J1.715 E.03653
G3 X135.645 Y132.643 I.363 J2.443 E.02687
G1 X135.645 Y134.34 E.0352
M204 S10000
G1 X119.964 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3824
M204 S4000
G1 X119.964 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.964 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L49
M991 S0 P48 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.24 I-.687 J1.005 P1  F60000
G1 X136.511 Y134.881 Z6.24
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3881
M204 S4000
G1 X136.511 Y121.119 E.28545
G1 X119.489 Y121.119 E.35307
G1 X119.489 Y134.881 E.28545
G1 X136.451 Y134.881 E.35182
; COOLING_NODE: 0
M204 S250
G1 X136.92 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X136.92 Y120.71 E.28104
G1 F3599
G1 X136.877 Y120.71 E.00083
G1 X119.123 Y120.71 E.34222
G1 X119.08 Y120.71 E.00083
G1 F3480
G1 X119.08 Y135.29 E.28104
G1 F3599
G1 X119.123 Y135.29 E.00083
G1 X136.86 Y135.29 E.34189
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.868 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.12 Y134.49 Z6.36 F60000
G1 Z5.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3881
M204 S4000
G1 X136.12 Y121.57 E.2259
M204 S10000
G1 X135.729 Y123.156 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3881
M204 S4000
G1 X135.729 Y121.482 E.03473
G2 X134.373 Y122.071 I.28 J2.501 E.03113
G3 X133.007 Y123.464 I-5.22 J-3.752 E.04061
G3 X130.731 Y123.004 I-.742 J-2.192 E.05045
G2 X129.366 Y121.612 I-5.22 J3.752 E.04061
G2 X127.09 Y122.071 I-.741 J2.196 E.05044
G3 X125.724 Y123.464 I-5.22 J-3.752 E.04061
G3 X123.448 Y123.004 I-.742 J-2.192 E.05045
G2 X122.083 Y121.612 I-5.22 J3.753 E.04061
G2 X120.271 Y121.757 I-.744 J2.092 E.03884
G1 X120.271 Y125.119 E.06973
G3 X121.627 Y125.713 I-.434 J2.838 E.03106
G2 X122.993 Y127.105 I5.219 J-3.752 E.04061
G2 X125.269 Y126.646 I.742 J-2.192 E.05045
G3 X126.634 Y125.253 I5.22 J3.752 E.04061
G3 X128.91 Y125.713 I.742 J2.192 E.05045
G2 X130.276 Y127.105 I5.22 J-3.752 E.04061
G2 X132.552 Y126.646 I.742 J-2.192 E.05045
G3 X133.918 Y125.253 I5.22 J3.753 E.04061
G3 X135.729 Y125.399 I.744 J2.091 E.03883
G1 X135.729 Y128.76 E.06973
G2 X134.373 Y129.354 I.435 J2.838 E.03106
G3 X133.007 Y130.747 I-5.22 J-3.752 E.04061
G3 X130.731 Y130.287 I-.742 J-2.192 E.05045
G2 X129.366 Y128.895 I-5.219 J3.752 E.04061
G2 X127.09 Y129.354 I-.742 J2.192 E.05045
G3 X125.724 Y130.747 I-5.22 J-3.752 E.04061
G3 X123.448 Y130.287 I-.742 J-2.192 E.05045
G2 X122.083 Y128.895 I-5.22 J3.753 E.04061
G2 X120.271 Y129.04 I-.744 J2.091 E.03884
G1 X120.271 Y132.402 E.06973
G3 X121.627 Y132.996 I-.434 J2.838 E.03106
G2 X122.993 Y134.388 I5.22 J-3.752 E.04061
G2 X125.269 Y133.929 I.741 J-2.197 E.05044
G3 X126.634 Y132.536 I5.22 J3.752 E.04061
G3 X128.91 Y132.996 I.742 J2.192 E.05045
G2 X130.276 Y134.388 I5.22 J-3.753 E.04061
G2 X132.552 Y133.929 I.741 J-2.197 E.05044
G3 X133.918 Y132.536 I5.22 J3.753 E.04061
G3 X135.729 Y132.682 I.744 J2.091 E.03883
G1 X135.729 Y134.379 E.0352
M204 S10000
G1 X119.88 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3881
M204 S4000
G1 X119.88 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.88 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L50
M991 S0 P49 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.36 I-.682 J1.008 P1  F60000
G1 X136.595 Y134.881 Z6.36
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3949
M204 S4000
G1 X136.595 Y121.119 E.28545
G1 X119.405 Y121.119 E.35655
G1 X119.405 Y134.881 E.28545
G1 X136.535 Y134.881 E.35531
; COOLING_NODE: 0
M204 S250
G1 X137.004 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.004 Y120.71 E.28104
G1 F3599
M73 P43 R12
G1 X136.961 Y120.71 E.00083
G1 X119.039 Y120.71 E.34546
G1 X118.996 Y120.71 E.00083
G1 F3480
G1 X118.996 Y135.29 E.28104
G1 F3599
G1 X119.039 Y135.29 E.00083
G1 X136.944 Y135.29 E.34513
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X136.952 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.204 Y134.49 Z6.48 F60000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3949
M204 S4000
G1 X136.204 Y121.57 E.2259
M204 S10000
G1 X135.813 Y122.947 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3949
M204 S4000
G1 X135.813 Y121.482 E.03038
G2 X134.373 Y122.121 I.074 J2.109 E.03349
G1 X133.462 Y123.269 E.03038
G3 X132.552 Y123.715 I-.89 J-.664 E.02184
G3 X130.731 Y122.954 I.136 J-2.884 E.04177
G1 X129.821 Y121.807 E.03038
G1 X129.408 Y121.482 E.01089
G1 X128.298 Y121.482 E.02303
G2 X127.09 Y122.121 I.486 J2.379 E.02874
G1 X126.179 Y123.269 E.03038
G3 X125.269 Y123.715 I-.89 J-.664 E.02184
G3 X123.448 Y122.954 I.136 J-2.884 E.04177
G1 X122.538 Y121.807 E.03038
G1 X122.125 Y121.482 E.01089
G1 X121.015 Y121.482 E.02303
G2 X120.187 Y121.824 I.436 J2.227 E.0187
G1 X120.187 Y125.078 E.06748
G3 X121.627 Y125.763 I-.31 J2.507 E.03366
G1 X122.538 Y126.91 E.03038
G2 X123.448 Y127.356 I.89 J-.664 E.02184
G2 X125.269 Y126.596 I-.136 J-2.884 E.04177
G1 X126.179 Y125.448 E.03038
G3 X127.09 Y125.002 I.89 J.664 E.02184
G3 X128.91 Y125.763 I-.136 J2.884 E.04177
G1 X129.821 Y126.91 E.03038
G2 X130.731 Y127.356 I.89 J-.664 E.02184
G2 X132.552 Y126.596 I-.136 J-2.884 E.04177
G1 X133.462 Y125.448 E.03038
G3 X134.373 Y125.002 I.89 J.664 E.02184
G3 X135.813 Y125.466 I-.144 J2.917 E.03174
G1 X135.813 Y128.719 E.06749
G2 X134.373 Y129.404 I.31 J2.507 E.03366
G1 X133.462 Y130.552 E.03038
G3 X132.552 Y130.998 I-.89 J-.664 E.02184
G3 X130.731 Y130.237 I.136 J-2.884 E.04177
G1 X129.821 Y129.09 E.03038
G2 X128.91 Y128.644 I-.89 J.664 E.02184
G2 X127.09 Y129.404 I.136 J2.884 E.04177
G1 X126.179 Y130.552 E.03038
G3 X125.269 Y130.998 I-.89 J-.664 E.02184
G3 X123.448 Y130.237 I.136 J-2.884 E.04177
G1 X122.538 Y129.09 E.03038
G2 X121.627 Y128.644 I-.89 J.664 E.02184
G2 X120.187 Y129.107 I.144 J2.916 E.03175
G1 X120.187 Y132.361 E.06748
G3 X121.627 Y133.046 I-.31 J2.507 E.03366
G1 X122.538 Y134.194 E.03038
G1 X122.951 Y134.518 E.01089
G2 X124.359 Y134.459 I.544 J-3.851 E.02939
G2 X125.269 Y133.879 I-.944 J-2.485 E.02255
G1 X126.179 Y132.731 E.03038
G3 X127.09 Y132.285 I.89 J.664 E.02184
G3 X128.91 Y133.046 I-.136 J2.884 E.04177
G1 X129.821 Y134.194 E.03038
G1 X130.234 Y134.518 E.01089
G2 X131.642 Y134.459 I.544 J-3.851 E.02939
G2 X132.552 Y133.879 I-.944 J-2.485 E.02255
G1 X133.462 Y132.731 E.03038
G3 X134.373 Y132.285 I.89 J.664 E.02184
G3 X135.813 Y132.749 I-.144 J2.917 E.03174
G1 X135.813 Y134.446 E.0352
M204 S10000
G1 X119.796 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F3949
M204 S4000
G1 X119.796 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.796 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L51
M991 S0 P50 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.48 I-.677 J1.011 P1  F60000
G1 X136.679 Y134.881 Z6.48
M73 P43 R11
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4024
M204 S4000
G1 X136.679 Y121.119 E.28545
G1 X119.321 Y121.119 E.36004
G1 X119.321 Y134.881 E.28545
G1 X136.619 Y134.881 E.35879
; COOLING_NODE: 0
M204 S250
G1 X137.088 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.088 Y120.71 E.28104
G1 F3599
G1 X137.045 Y120.71 E.00083
G1 X118.955 Y120.71 E.3487
G1 X118.912 Y120.71 E.00083
G1 F3480
G1 X118.912 Y135.29 E.28104
G1 F3599
G1 X118.955 Y135.29 E.00083
G1 X137.028 Y135.29 E.34837
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
G1 F3600
M204 S4000
G1 X137.036 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.288 Y134.49 Z6.6 F60000
G1 Z6.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4024
M204 S4000
G1 X136.288 Y121.57 E.2259
M204 S10000
G1 X133.654 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4024
M204 S4000
G1 X135.351 Y121.482 E.0352
G2 X134.373 Y122.169 I1.26 J2.834 E.02495
G1 X133.462 Y123.501 E.03347
G1 X133.007 Y123.822 E.01155
G1 X132.552 Y123.841 E.00945
G3 X130.731 Y122.906 I.459 J-3.135 E.04323
G1 X129.821 Y121.574 E.03347
G1 X129.691 Y121.482 E.0033
G1 X128.068 Y121.482 E.03366
G2 X127.09 Y122.169 I1.261 J2.835 E.02495
G1 X126.179 Y123.501 E.03347
G1 X125.724 Y123.822 E.01155
G1 X125.269 Y123.841 E.00945
G3 X123.448 Y122.906 I.459 J-3.135 E.04323
G1 X122.538 Y121.574 E.03347
G1 X122.408 Y121.482 E.0033
G1 X120.785 Y121.482 E.03366
G2 X120.103 Y121.905 I1.139 J2.597 E.0167
G1 X120.103 Y124.963 E.06343
G3 X121.627 Y125.811 I-.555 J2.792 E.03677
G1 X122.538 Y127.143 E.03347
G1 X122.993 Y127.464 E.01155
G1 X123.448 Y127.483 E.00945
G2 X125.269 Y126.548 I-.459 J-3.135 E.04323
G1 X126.179 Y125.215 E.03347
G1 X126.634 Y124.895 E.01155
G1 X127.09 Y124.876 E.00945
G3 X128.91 Y125.811 I-.459 J3.135 E.04323
G1 X129.821 Y127.143 E.03347
G1 X130.276 Y127.464 E.01155
G1 X130.731 Y127.483 E.00945
G2 X132.552 Y126.548 I-.459 J-3.135 E.04323
G1 X133.462 Y125.215 E.03347
G1 X133.918 Y124.895 E.01155
G1 X134.373 Y124.876 E.00945
G3 X135.897 Y125.546 I-.418 J3.017 E.03499
G1 X135.897 Y128.605 E.06343
G2 X134.373 Y129.452 I.555 J2.792 E.03677
G1 X133.462 Y130.785 E.03347
G1 X133.007 Y131.106 E.01155
G1 X132.552 Y131.124 E.00945
G3 X130.731 Y130.189 I.459 J-3.135 E.04323
G1 X129.821 Y128.857 E.03347
G1 X129.366 Y128.536 E.01155
G1 X128.91 Y128.517 E.00945
G2 X127.09 Y129.452 I.459 J3.135 E.04323
G1 X126.179 Y130.785 E.03347
G1 X125.724 Y131.106 E.01155
G1 X125.269 Y131.124 E.00945
G3 X123.448 Y130.189 I.459 J-3.135 E.04323
G1 X122.538 Y128.857 E.03347
G1 X122.083 Y128.536 E.01155
G1 X121.627 Y128.517 E.00945
G2 X120.103 Y129.188 I.418 J3.017 E.03499
G1 X120.103 Y132.246 E.06343
G3 X121.627 Y133.094 I-.555 J2.792 E.03677
G1 X122.538 Y134.426 E.03347
G1 X122.746 Y134.518 E.00472
G1 X124.218 Y134.518 E.03053
G2 X125.269 Y133.831 I-.681 J-2.19 E.02638
G1 X126.179 Y132.499 E.03347
G1 X126.634 Y132.178 E.01155
G1 X127.09 Y132.159 E.00945
G3 X128.91 Y133.094 I-.459 J3.135 E.04323
G1 X129.821 Y134.426 E.03347
G1 X130.029 Y134.518 E.00472
G1 X131.501 Y134.518 E.03053
G2 X132.552 Y133.831 I-.681 J-2.19 E.02638
G1 X133.462 Y132.499 E.03347
G1 X133.918 Y132.178 E.01155
G1 X134.373 Y132.159 E.00945
G3 X135.897 Y132.83 I-.418 J3.017 E.03499
G1 X135.888 Y134.518 E.03502
M204 S10000
G1 X119.712 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4024
M204 S4000
G1 X119.712 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.712 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L52
M991 S0 P51 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.6 I-.673 J1.014 P1  F60000
G1 X136.763 Y134.881 Z6.6
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4141
M204 S4000
G1 X136.763 Y121.119 E.28545
G1 X119.237 Y121.119 E.36352
G1 X119.237 Y134.881 E.28545
G1 X136.703 Y134.881 E.36228
; COOLING_NODE: 0
M204 S250
G1 X137.172 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.172 Y120.71 E.28104
G1 F3600
G1 X137.129 Y120.71 E.00083
G1 X118.871 Y120.71 E.35194
G1 X118.828 Y120.71 E.00083
G1 F3480
G1 X118.828 Y135.29 E.28104
G1 F3600
G1 X118.871 Y135.29 E.00083
G1 X137.112 Y135.29 E.35161
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.12 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.372 Y134.49 Z6.72 F60000
G1 Z6.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4141
M204 S4000
G1 X136.372 Y121.57 E.2259
M204 S10000
G1 X133.544 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4141
M204 S4000
G1 X135.241 Y121.482 E.0352
G2 X133.918 Y122.965 I1.755 J2.898 E.04183
G1 X133.462 Y123.871 E.02104
G3 X132.552 Y123.985 I-.537 J-.598 E.02026
G3 X130.276 Y122.111 I.776 J-3.262 E.06332
G1 X129.96 Y121.482 E.01459
G1 X127.958 Y121.482 E.04154
G2 X126.634 Y122.965 I1.755 J2.898 E.04183
G1 X126.179 Y123.871 E.02104
G3 X125.269 Y123.985 I-.537 J-.598 E.02025
G3 X122.993 Y122.111 I.776 J-3.262 E.06332
G1 X122.677 Y121.482 E.01459
G1 X120.675 Y121.482 E.04154
G2 X120.019 Y121.999 I.883 J1.793 E.01745
G1 X120.019 Y124.817 E.05844
G3 X122.083 Y126.606 I-.814 J3.023 E.05862
G1 X122.538 Y127.513 E.02104
G2 X123.448 Y127.627 I.537 J-.598 E.02026
G2 X125.724 Y125.752 I-.776 J-3.262 E.06332
G1 X126.179 Y124.846 E.02104
G3 X127.09 Y124.732 I.537 J.598 E.02025
G3 X129.366 Y126.606 I-.776 J3.262 E.06332
G1 X129.821 Y127.513 E.02104
G2 X130.731 Y127.627 I.537 J-.598 E.02025
G2 X133.007 Y125.752 I-.776 J-3.262 E.06332
G1 X133.462 Y124.846 E.02104
G3 X134.373 Y124.732 I.537 J.598 E.02025
G3 X135.981 Y125.641 I-.805 J3.302 E.03881
G1 X135.981 Y128.458 E.05844
G2 X133.918 Y130.248 I.814 J3.023 E.05862
G1 X133.462 Y131.154 E.02104
G3 X132.552 Y131.268 I-.537 J-.598 E.02025
G3 X130.276 Y129.394 I.776 J-3.262 E.06332
G1 X129.821 Y128.487 E.02104
G2 X128.91 Y128.373 I-.537 J.598 E.02025
G2 X126.634 Y130.248 I.776 J3.262 E.06332
G1 X126.179 Y131.154 E.02104
G3 X125.269 Y131.268 I-.537 J-.598 E.02025
G3 X122.993 Y129.394 I.776 J-3.262 E.06332
G1 X122.538 Y128.487 E.02104
G2 X121.627 Y128.373 I-.537 J.598 E.02025
G2 X120.019 Y129.283 I.805 J3.301 E.03881
G1 X120.019 Y132.1 E.05844
G3 X122.083 Y133.889 I-.814 J3.023 E.05862
G1 X122.471 Y134.518 E.01532
G1 X124.401 Y134.518 E.04004
G2 X125.724 Y133.036 I-1.755 J-2.898 E.04183
G1 X126.179 Y132.129 E.02104
G3 X127.09 Y132.015 I.537 J.598 E.02025
M73 P44 R11
G3 X129.366 Y133.889 I-.776 J3.262 E.06332
G1 X129.754 Y134.518 E.01532
G1 X131.684 Y134.518 E.04004
G2 X133.007 Y133.036 I-1.755 J-2.898 E.04183
G1 X133.462 Y132.129 E.02104
G3 X134.373 Y132.015 I.537 J.598 E.02025
G3 X135.981 Y132.924 I-.805 J3.301 E.03881
G1 X135.981 Y134.518 E.03306
G1 X135.878 Y134.518 E.00214
M204 S10000
G1 X119.628 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4141
M204 S4000
G1 X119.628 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.628 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L53
M991 S0 P52 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.72 I-.668 J1.017 P1  F60000
G1 X136.847 Y134.881 Z6.72
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4245
M204 S4000
G1 X136.847 Y121.119 E.28545
G1 X119.153 Y121.119 E.36701
G1 X119.153 Y134.881 E.28545
G1 X136.787 Y134.881 E.36576
; COOLING_NODE: 0
M204 S250
G1 X137.256 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.256 Y120.71 E.28104
G1 F3600
G1 X137.213 Y120.71 E.00083
G1 X118.787 Y120.71 E.35517
G1 X118.744 Y120.71 E.00083
G1 F3480
G1 X118.744 Y135.29 E.28104
G1 F3600
G1 X118.787 Y135.29 E.00083
G1 X137.196 Y135.29 E.35485
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.204 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.456 Y134.49 Z6.84 F60000
G1 Z6.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4245
M204 S4000
G1 X136.456 Y121.57 E.2259
M204 S10000
G1 X136.065 Y122.302 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4245
M204 S4000
G1 X136.065 Y121.482 E.01701
G1 X135.188 Y121.482 E.01819
G2 X133.782 Y123.903 I1.833 J2.683 E.06004
G1 X134.011 Y124.358 E.01056
G3 X136.065 Y125.723 I-2.534 J6.042 E.05147
G1 X136.065 Y128.257 E.05255
G2 X134.501 Y129.366 I2.357 J4.983 E.03997
G2 X133.782 Y131.186 I3.882 J2.583 E.0409
G1 X134.011 Y131.642 E.01056
G3 X136.065 Y133.006 I-2.534 J6.042 E.05147
G1 X136.065 Y134.518 E.03135
G1 X131.737 Y134.518 E.08978
G2 X133.142 Y132.097 I-1.833 J-2.683 E.06003
G1 X132.914 Y131.642 E.01056
G3 X130.859 Y130.276 I2.534 J-6.042 E.05149
G3 X130.141 Y128.455 I3.882 J-2.583 E.0409
G1 X130.369 Y128 E.01056
G2 X132.424 Y126.634 I-2.533 J-6.041 E.05149
G2 X133.142 Y124.814 I-3.882 J-2.583 E.0409
G1 X132.914 Y124.358 E.01056
G3 X130.859 Y122.993 I2.533 J-6.041 E.05149
G3 X130.19 Y121.482 I4.427 J-2.865 E.03442
G1 X127.905 Y121.482 E.04739
G2 X126.499 Y123.903 I1.833 J2.683 E.06004
G1 X126.728 Y124.358 E.01056
G3 X128.783 Y125.724 I-2.534 J6.042 E.05149
G3 X129.501 Y127.545 I-3.882 J2.583 E.0409
G1 X129.273 Y128 E.01056
G2 X127.218 Y129.366 I2.533 J6.041 E.05149
G2 X126.499 Y131.186 I3.882 J2.583 E.0409
G1 X126.728 Y131.642 E.01056
G3 X128.783 Y133.007 I-2.533 J6.041 E.05149
G3 X129.452 Y134.518 I-4.428 J2.866 E.03442
G1 X127.755 Y134.518 E.0352
M204 S10000
G1 X119.544 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4245
M204 S4000
G1 X119.544 Y121.57 E.2259
M204 S10000
G1 X119.935 Y123.779 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4245
M204 S4000
G1 X119.935 Y122.082 E.0352
G3 X120.622 Y121.482 I1.625 J1.168 E.01908
G1 X122.907 Y121.482 E.04739
G1 X122.93 Y121.627 E.00305
G2 X124.762 Y123.903 I3.231 J-.725 E.06276
G1 X125.631 Y124.358 E.02036
G1 X125.859 Y124.814 E.01056
G3 X123.955 Y127.545 I-3.337 J-.297 E.07227
G1 X123.086 Y128 E.02036
G1 X122.858 Y128.455 E.01056
G2 X124.762 Y131.186 I3.337 J-.297 E.07227
G1 X125.631 Y131.642 E.02036
G1 X125.859 Y132.097 E.01056
G3 X124.454 Y134.518 I-3.239 J-.262 E.06003
G1 X122.169 Y134.518 E.04739
G1 X122.146 Y134.373 E.00305
G2 X120.314 Y132.097 I-3.231 J.725 E.06276
G1 X119.935 Y131.898 E.00887
G1 X119.935 Y129.365 E.05255
G3 X121.989 Y128 I4.588 J4.677 E.05147
G1 X122.218 Y127.545 E.01056
G2 X120.314 Y124.814 I-3.337 J.297 E.07227
G1 X119.935 Y124.615 E.00887
G1 X119.935 Y126.312 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X119.935 Y124.615 E-.64486
G1 X120.203 Y124.756 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L54
M991 S0 P53 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.84 I-.63 J1.041 P1  F60000
G1 X136.931 Y134.881 Z6.84
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F4201
M204 S4000
G1 X136.931 Y121.119 E.28545
G1 X119.069 Y121.119 E.37049
G1 X119.069 Y134.881 E.28545
G1 X136.871 Y134.881 E.36925
; COOLING_NODE: 0
M204 S250
G1 X137.34 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.34 Y120.71 E.28104
G1 F3600
G1 X137.297 Y120.71 E.00083
G1 X118.703 Y120.71 E.35841
G1 X118.66 Y120.71 E.00083
G1 F3480
G1 X118.66 Y135.29 E.28104
G1 F3600
G1 X118.703 Y135.29 E.00083
G1 X137.28 Y135.29 E.35809
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.288 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.54 Y134.49 Z6.96 F60000
G1 Z6.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4201
M204 S4000
G1 X136.54 Y121.57 E.2259
M204 S10000
G1 X136.149 Y122.147 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4201
M204 S4000
G1 X136.149 Y121.482 E.0138
G1 X135.117 Y121.482 E.0214
G2 X134.024 Y123.903 I1.637 J2.196 E.05753
G1 X134.352 Y124.358 E.01163
G1 X135.657 Y125.269 E.03301
G3 X136.149 Y125.888 I-1.237 J1.487 E.01651
G1 X136.149 Y128.046 E.04476
G1 X134.909 Y128.91 E.03136
G2 X134.024 Y131.186 I1.858 J2.032 E.05248
G1 X134.352 Y131.642 E.01163
G1 X135.657 Y132.552 E.03301
G3 X136.149 Y133.171 I-1.237 J1.487 E.01651
G1 X136.149 Y134.518 E.02794
G1 X131.808 Y134.518 E.09005
G2 X132.9 Y132.097 I-1.637 J-2.196 E.05752
G1 X132.573 Y131.642 E.01163
G1 X131.267 Y130.731 E.03301
G3 X130.383 Y128.455 I1.858 J-2.032 E.05248
G1 X130.71 Y128 E.01163
G1 X132.016 Y127.09 E.03301
G2 X132.9 Y124.814 I-1.858 J-2.032 E.05248
G1 X132.573 Y124.358 E.01163
G1 X131.267 Y123.448 E.03301
G3 X130.363 Y121.482 I1.89 J-2.06 E.04609
G1 X127.834 Y121.482 E.05247
G2 X126.741 Y123.903 I1.637 J2.196 E.05753
G1 X127.069 Y124.358 E.01163
G1 X128.374 Y125.269 E.03301
G3 X129.259 Y127.545 I-1.858 J2.032 E.05248
G1 X128.931 Y128 E.01163
G1 X127.626 Y128.91 E.03301
G2 X126.741 Y131.186 I1.858 J2.032 E.05248
G1 X127.069 Y131.642 E.01163
G1 X128.374 Y132.552 E.03301
G3 X129.278 Y134.518 I-1.89 J2.06 E.04609
G1 X124.525 Y134.518 E.0986
G2 X125.617 Y132.097 I-1.637 J-2.196 E.05752
G1 X125.29 Y131.642 E.01163
G1 X123.984 Y130.731 E.03301
G3 X123.1 Y128.455 I1.858 J-2.032 E.05248
G1 X123.427 Y128 E.01163
G1 X124.733 Y127.09 E.03301
G2 X125.617 Y124.814 I-1.858 J-2.032 E.05248
G1 X125.29 Y124.358 E.01163
G1 X123.984 Y123.448 E.03301
G3 X123.08 Y121.482 I1.89 J-2.06 E.04609
G1 X120.551 Y121.482 E.05247
G2 X119.851 Y122.246 I1.647 J2.211 E.02163
G1 X119.851 Y124.404 E.04475
G1 X121.091 Y125.269 E.03136
G3 X121.976 Y127.545 I-1.858 J2.032 E.05248
G1 X121.648 Y128 E.01163
G1 X120.343 Y128.91 E.03301
G2 X119.851 Y129.53 I1.238 J1.488 E.01652
G1 X119.851 Y131.687 E.04475
G1 X121.091 Y132.552 E.03136
G3 X121.995 Y134.518 I-1.89 J2.06 E.04609
G1 X120.298 Y134.518 E.0352
M204 S10000
G1 X119.46 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F4201
M204 S4000
G1 X119.46 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.46 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L55
M991 S0 P54 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.96 I-.659 J1.023 P1  F60000
G1 X137.015 Y134.881 Z6.96
G1 Z6.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4845
M204 S4000
G1 X137.015 Y121.119 E.28545
G1 X118.985 Y121.119 E.37398
G1 X118.985 Y134.881 E.28545
G1 X136.955 Y134.881 E.37273
; COOLING_NODE: 0
M204 S250
G1 X137.424 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.424 Y120.71 E.28104
G1 F3600
G1 X137.381 Y120.71 E.00083
G1 X118.619 Y120.71 E.36165
G1 X118.576 Y120.71 E.00083
G1 F3480
G1 X118.576 Y135.29 E.28104
G1 F3600
G1 X118.619 Y135.29 E.00083
G1 X137.364 Y135.29 E.36132
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.372 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.624 Y134.49 Z7.08 F60000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383472
M73 P45 R11
G1 F4845
M204 S4000
G1 X136.624 Y121.57 E.22596
M204 S10000
G1 X136.233 Y121.987 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4845
M204 S4000
G1 X136.233 Y121.482 E.01048
G1 X135.041 Y121.482 E.02472
G2 X134.291 Y122.538 I1.816 J2.085 E.02711
G1 X134.12 Y123.448 E.01921
G2 X134.576 Y124.358 I1.139 J-.001 E.02189
G1 X135.706 Y125.269 E.03009
G3 X136.233 Y126.091 I-1.719 J1.683 E.0204
G1 X136.233 Y127.694 E.03325
G1 X135.99 Y128 E.0081
G1 X134.861 Y128.91 E.03009
G2 X134.216 Y131.186 I1.789 J1.737 E.05113
G1 X134.576 Y131.642 E.01204
G1 X135.706 Y132.552 E.03009
G3 X136.233 Y133.374 I-1.719 J1.683 E.0204
G1 X136.233 Y134.518 E.02372
G1 X131.884 Y134.518 E.09021
G2 X132.634 Y133.462 I-1.817 J-2.085 E.02711
G1 X132.805 Y132.552 E.01921
G2 X132.349 Y131.642 I-1.139 J.001 E.02189
G1 X131.219 Y130.731 E.03009
G3 X130.574 Y128.455 I1.789 J-1.737 E.05113
G1 X130.934 Y128 E.01204
G1 X132.064 Y127.09 E.03009
G2 X132.709 Y124.814 I-1.789 J-1.737 E.05113
G1 X132.349 Y124.358 E.01204
G1 X131.219 Y123.448 E.03009
G3 X130.525 Y121.876 I1.908 J-1.781 E.03631
G1 X127.386 Y121.876 E.06511
G2 X126.837 Y123.448 I2.157 J1.636 E.03511
G2 X127.293 Y124.358 I1.139 J-.001 E.02189
G1 X128.422 Y125.269 E.03009
G3 X129.068 Y127.545 I-1.789 J1.737 E.05113
G1 X128.707 Y128 E.01204
G1 X127.578 Y128.91 E.03009
G2 X126.932 Y131.186 I1.789 J1.737 E.05113
G1 X127.293 Y131.642 E.01204
G1 X128.422 Y132.552 E.03009
G3 X129.116 Y134.124 I-1.908 J1.782 E.03632
G1 X124.972 Y134.124 E.08596
G2 X125.521 Y132.552 I-2.157 J-1.636 E.0351
G2 X125.066 Y131.642 I-1.139 J.001 E.02189
G1 X123.936 Y130.731 E.03009
G3 X123.291 Y128.455 I1.789 J-1.737 E.05113
G1 X123.651 Y128 E.01204
G1 X124.781 Y127.09 E.03009
G2 X125.426 Y124.814 I-1.789 J-1.737 E.05113
G1 X125.066 Y124.358 E.01204
G1 X123.936 Y123.448 E.03009
G3 X123.226 Y121.482 I1.84 J-1.776 E.04467
G1 X120.475 Y121.482 E.05707
G2 X119.767 Y122.45 I1.751 J2.024 E.02508
G1 X119.767 Y124.052 E.03323
G1 X120.01 Y124.358 E.00811
G1 X121.139 Y125.269 E.03009
G3 X121.785 Y127.545 I-1.789 J1.737 E.05113
G1 X121.424 Y128 E.01204
G1 X120.295 Y128.91 E.03009
G2 X119.767 Y129.733 I1.719 J1.683 E.02041
G1 X119.767 Y131.335 E.03323
G1 X120.01 Y131.642 E.00811
G1 X121.139 Y132.552 E.03009
G3 X121.849 Y134.518 I-1.84 J1.776 E.04467
G1 X120.153 Y134.518 E.0352
M204 S10000
G1 X119.376 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383472
G1 F4845
M204 S4000
G1 X119.376 Y121.57 E.22596
M204 S10000
G1 X130.781 Y121.498 F60000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X125.963 Y121.498 E.08009
; Slow Down End
M204 S10000
G1 X129.323 Y134.502 F60000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X124.957 Y134.502 E.07258
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X126.957 Y134.502 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L56
M991 S0 P55 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.08 I-.045 J1.216 P1  F60000
G1 X137.099 Y134.881 Z7.08
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.099 Y121.119 E.28545
G1 X118.901 Y121.119 E.37746
G1 X118.901 Y134.881 E.28545
G1 X137.039 Y134.881 E.37622
; COOLING_NODE: 0
M204 S250
G1 X137.508 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.508 Y120.71 E.28104
G1 F3600
G1 X137.465 Y120.71 E.00083
G1 X118.535 Y120.71 E.36489
G1 X118.492 Y120.71 E.00083
G1 F3480
G1 X118.492 Y135.29 E.28104
G1 F3600
G1 X118.535 Y135.29 E.00083
G1 X137.448 Y135.29 E.36456
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.456 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.708 Y134.49 Z7.2 F60000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F10800
M204 S4000
G1 X136.708 Y121.57 E.2259
M204 S10000
G1 X133.273 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X134.97 Y121.482 E.0352
G2 X134.375 Y123.903 I1.519 J1.657 E.05482
G2 X135.756 Y125.269 I5.407 J-4.086 E.04042
G3 X136.191 Y127.545 I-1.744 J1.513 E.05035
G3 X134.81 Y128.91 I-5.407 J-4.086 E.04042
G2 X134.375 Y131.186 I1.733 J1.511 E.05037
G2 X135.756 Y132.552 I5.407 J-4.086 E.04042
G3 X136.317 Y134.518 I-2.396 J1.747 E.04329
G1 X131.954 Y134.518 E.09049
G2 X132.397 Y133.951 I-.915 J-1.171 E.01506
G1 X133.163 Y133.715 E.01664
G2 X133.4 Y132.853 I-2.716 J-1.21 E.01861
M204 S10000
G1 X128.3 Y134.703 F60000
; FEATURE: Bridge
; LINE_WIDTH: 0.50069
; LAYER_HEIGHT: 0.489898
G1 F1500
M204 S4000
G1 X132.776 Y133.324 E.37572
G1 X132.911 Y132.867 E.03824
G1 X132.935 Y132.699 E.01361
G1 X127.218 Y134.46 E.47984
G1 X125.347 Y134.46 E.15007
G1 X132.9 Y132.134 E.63394
G1 X132.84 Y131.966 E.01425
G1 X132.563 Y131.661 E.03306
G1 X125.01 Y133.988 E.63404
G1 X125.195 Y133.355 E.05291
G1 X132.066 Y131.238 E.57674
G3 X131.555 Y130.819 I19.18 J-23.868 E.05296
G1 X125.289 Y132.75 E.52604
G1 X125.311 Y132.576 E.01406
G1 X125.175 Y132.208 E.03142
G1 X131.178 Y130.359 E.50395
G1 X131.091 Y130.243 E.01171
G1 X130.922 Y129.862 E.0334
G1 X124.869 Y131.726 E.50807
G2 X124.413 Y131.291 I-1.681 J1.303 E.05079
G1 X130.778 Y129.33 E.53427
G3 X130.732 Y128.768 I1.538 J-.407 E.04549
G1 X123.901 Y130.872 E.57344
G3 X123.471 Y130.428 I.706 J-1.114 E.05004
G1 X130.928 Y128.131 E.62594
G1 X131.269 Y127.617 E.0495
G1 X131.594 Y127.35 E.03374
G1 X123.2 Y129.936 E.7046
G1 X123.142 Y129.801 E.01174
G1 X123.067 Y129.4 E.03272
G1 X132.511 Y126.491 E.79272
G1 X132.777 Y126.081 E.03925
G1 X132.847 Y125.812 E.02234
G1 X123.088 Y128.818 E.81921
G1 X123.486 Y128.246 E.05584
G1 X123.729 Y128.044 E.02541
G1 X132.954 Y125.203 E.7743
G1 X132.97 Y125.035 E.01351
G1 X132.818 Y124.668 E.03185
G1 X124.68 Y127.175 E.68315
G1 X125.067 Y126.569 E.05769
G1 X125.092 Y126.472 E.00807
G1 X132.396 Y124.222 E.61313
G3 X131.882 Y123.804 I5.95 J-7.848 E.05316
G1 X125.243 Y125.849 E.55733
G1 X125.294 Y125.257 E.04769
G1 X131.403 Y123.375 E.51275
G1 X131.064 Y122.904 E.04661
G1 X125.091 Y124.743 E.50135
G1 X125.036 Y124.616 E.0111
G1 X124.714 Y124.283 E.03717
G1 X130.853 Y122.392 E.51532
G1 X130.741 Y121.85 E.04437
G1 X124.227 Y123.857 E.54683
G3 X123.729 Y123.434 I5.026 J-6.414 E.05239
G1 X129.879 Y121.54 E.51619
G1 X128.008 Y121.54 E.15007
G1 X123.354 Y122.973 E.39064
G1 X123.311 Y122.913 E.00595
M73 P46 R11
G1 X123.132 Y122.466 E.03866
G1 X126.926 Y121.297 E.31846
M204 S10000
G1 X122.801 Y122.936 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F9000
M204 S4000
G1 X122.488 Y122.154 E.01748
G1 X123.304 Y121.902 E.01772
G3 X123.352 Y121.482 I.691 J-.135 E.00891
G1 X120.404 Y121.482 E.06114
G2 X119.809 Y123.903 I1.519 J1.657 E.05482
G2 X121.19 Y125.269 I5.407 J-4.086 E.04042
G3 X121.625 Y127.545 I-1.733 J1.511 E.05037
G3 X120.244 Y128.91 I-5.407 J-4.086 E.04042
G2 X119.809 Y131.186 I1.744 J1.513 E.05035
G2 X121.19 Y132.552 I5.407 J-4.086 E.04042
G3 X121.724 Y134.518 I-1.81 J1.547 E.04366
G1 X123.421 Y134.518 E.0352
M204 S10000
G1 X119.292 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F10800
M204 S4000
G1 X119.292 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.292 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L57
M991 S0 P56 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.2 I-.65 J1.029 P1  F60000
G1 X137.183 Y134.881 Z7.2
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5234
M204 S4000
G1 X137.183 Y121.119 E.28545
G1 X118.817 Y121.119 E.38095
G1 X118.817 Y134.881 E.28545
G1 X137.123 Y134.881 E.3797
; COOLING_NODE: 0
M204 S250
G1 X137.592 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3480
M204 S2000
G1 X137.592 Y120.71 E.28104
G1 F3600
G1 X137.549 Y120.71 E.00083
G1 X118.451 Y120.71 E.36813
G1 X118.408 Y120.71 E.00083
G1 F3480
G1 X118.408 Y135.29 E.28104
G1 F3600
G1 X118.451 Y135.29 E.00083
G1 X137.532 Y135.29 E.3678
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

; WIPE_START
M204 S4000
G1 X137.54 Y133.29 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.792 Y134.49 Z7.32 F60000
G1 Z6.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5234
M204 S4000
G1 X136.792 Y121.57 E.2259
M204 S10000
G1 X136.401 Y121.665 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5234
M204 S4000
G1 X136.401 Y121.482 E.0038
G1 X134.887 Y121.482 E.0314
G2 X134.514 Y123.903 I1.612 J1.488 E.05391
G2 X135.81 Y125.269 I40.291 J-36.941 E.03905
G3 X136.053 Y127.545 I-1.765 J1.339 E.04989
G3 X134.757 Y128.91 I-40.274 J-36.925 E.03905
G2 X134.514 Y131.186 I1.765 J1.339 E.04989
G2 X135.81 Y132.552 I40.308 J-36.957 E.03905
G3 X136.179 Y134.518 I-1.816 J1.359 E.04297
G1 X132.038 Y134.518 E.08591
G2 X132.411 Y132.097 I-1.612 J-1.488 E.05391
G2 X131.115 Y130.731 I-40.291 J36.941 E.03905
G3 X130.872 Y128.455 I1.765 J-1.339 E.04989
G3 X132.168 Y127.09 I40.257 J36.909 E.03905
G2 X132.411 Y124.814 I-1.765 J-1.339 E.04989
G2 X131.115 Y123.448 I-40.308 J36.957 E.03905
G3 X130.746 Y121.482 I1.816 J-1.359 E.04297
G1 X129.203 Y121.482 E.032
G1 X129.203 Y121.636 E.0032
M204 S10000
G1 X128 Y133.678 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.430752
G1 F5234
M204 S4000
G1 X128 Y122.382 E.22366
M204 S10000
G1 X128.4 Y122.322 F60000
; LINE_WIDTH: 0.419992
G1 F5234
M204 S4000
G1 X128.4 Y121.923 E.0077
G1 X127.6 Y121.923 E.01541
G1 X127.6 Y134.077 E.23428
G1 X128.4 Y134.077 E.01541
G1 X128.4 Y122.382 E.22542
M204 S10000
G1 X128.794 Y122.322 F60000
G1 F5234
M204 S4000
G1 X128.794 Y121.528 E.0153
G1 X127.206 Y121.528 E.0306
G1 X127.206 Y134.472 E.24948
G1 X128.794 Y134.472 E.0306
G1 X128.794 Y122.382 E.23302
M204 S10000
G1 X126.452 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5234
M204 S4000
G1 X124.755 Y134.518 E.0352
G2 X125.314 Y132.552 I-1.831 J-1.583 E.04377
G2 X124.241 Y131.186 I-2.859 J1.142 E.03651
G3 X123.403 Y128.91 I1.655 J-1.902 E.05248
G3 X124.476 Y127.545 I2.86 J1.142 E.03651
G2 X125.314 Y125.269 I-1.655 J-1.902 E.05248
G2 X124.241 Y123.903 I-2.86 J1.142 E.03651
G3 X123.463 Y121.482 I1.513 J-1.823 E.05569
G1 X120.321 Y121.482 E.06516
G2 X119.762 Y123.448 I1.831 J1.583 E.04377
G2 X120.834 Y124.814 I2.86 J-1.142 E.03651
G3 X121.672 Y127.09 I-1.655 J1.902 E.05248
G3 X120.6 Y128.455 I-2.86 J-1.142 E.03651
G2 X119.762 Y130.731 I1.655 J1.902 E.05248
G2 X120.834 Y132.097 I2.86 J-1.142 E.03651
G3 X121.613 Y134.518 I-1.513 J1.823 E.05569
G1 X119.916 Y134.518 E.0352
M204 S10000
G1 X119.208 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5234
M204 S4000
G1 X119.208 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.208 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L58
M991 S0 P57 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.32 I-.646 J1.031 P1  F60000
G1 X137.267 Y134.881 Z7.32
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5247
M204 S4000
G1 X137.267 Y121.119 E.28545
G1 X118.733 Y121.119 E.38443
G1 X118.733 Y134.881 E.28545
G1 X137.207 Y134.881 E.38319
; COOLING_NODE: 0
M204 S250
G1 X137.633 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X137.676 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X137.676 Y120.71 E.28104
G1 F3600
G1 X137.633 Y120.71 E.00083
G1 X118.367 Y120.71 E.37137
G1 X118.324 Y120.71 E.00083
G1 F3480
G1 X118.324 Y135.29 E.28104
G1 F3600
G1 X118.367 Y135.29 E.00083
G1 X137.573 Y135.29 E.37021
; WIPE_START
M204 S4000
G1 X137.676 Y135.29 E-.03914
G1 X137.676 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.876 Y134.49 Z7.44 F60000
G1 Z7.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5247
M204 S4000
G1 X136.876 Y121.57 E.2259
M204 S10000
G1 X136.485 Y121.51 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5247
M204 S4000
G1 X134.816 Y121.482 E.03463
G2 X135.034 Y124.358 I1.635 J1.322 E.06594
G3 X136.229 Y126.634 I-1.605 J2.294 E.05539
G3 X135.532 Y128 I-2.115 J-.219 E.03254
G2 X134.337 Y130.276 I1.605 J2.294 E.05539
G2 X135.034 Y131.642 I2.115 J-.219 E.03254
G3 X136.229 Y133.918 I-1.605 J2.294 E.05539
G3 X136.08 Y134.518 I-1.112 J.042 E.013
G1 X132.109 Y134.518 E.08236
G2 X131.89 Y131.642 I-1.635 J-1.322 E.06593
G3 X130.696 Y129.366 I1.605 J-2.294 E.05539
G3 X131.393 Y128 I2.115 J.219 E.03254
G2 X132.588 Y125.724 I-1.605 J-2.294 E.05539
G2 X131.89 Y124.358 I-2.115 J.219 E.03254
G3 X130.696 Y122.082 I1.605 J-2.294 E.05539
G3 X130.845 Y121.482 I1.112 J-.042 E.013
G1 X129.287 Y121.482 E.03231
G1 X129.287 Y121.621 E.00289
M204 S10000
G1 X128.878 Y122.406 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F5247
M204 S4000
G1 X128.878 Y121.528 E.01692
G1 X127.122 Y121.528 E.03384
G1 X127.122 Y134.472 E.24948
G1 X128.878 Y134.472 E.03384
G1 X128.878 Y122.466 E.2314
M204 S10000
G1 X128.484 Y122.406 F60000
G1 F5247
M204 S4000
G1 X128.484 Y121.923 E.00932
G1 X127.516 Y121.923 E.01864
G1 X127.516 Y134.077 E.23428
G1 X128.484 Y134.077 E.01864
G1 X128.484 Y122.466 E.22381
M204 S10000
G1 X128 Y133.594 F60000
; LINE_WIDTH: 0.598752
G1 F5247
M204 S4000
G1 X128 Y122.466 E.31174
M204 S10000
G1 X126.523 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5247
M204 S4000
G1 X124.826 Y134.518 E.0352
G2 X125.226 Y132.552 I-1.849 J-1.4 E.04303
G2 X124.14 Y131.186 I-3.576 J1.73 E.03649
G3 X123.491 Y128.91 I1.682 J-1.71 E.05134
G3 X124.577 Y127.545 I3.577 J1.73 E.03649
G2 X125.226 Y125.269 I-1.682 J-1.71 E.05134
G2 X124.14 Y123.903 I-3.576 J1.73 E.03649
G3 X123.562 Y121.482 I1.547 J-1.649 E.05468
G1 X120.25 Y121.482 E.0687
G2 X119.85 Y123.448 I1.848 J1.4 E.04304
G2 X120.936 Y124.814 I3.576 J-1.73 E.03649
G3 X121.584 Y127.09 I-1.682 J1.71 E.05134
G3 X120.498 Y128.455 I-3.576 J-1.73 E.03649
G2 X119.85 Y130.731 I1.682 J1.71 E.05134
G2 X120.936 Y132.097 I3.576 J-1.73 E.03649
G3 X121.514 Y134.518 I-1.547 J1.649 E.05467
G1 X119.817 Y134.518 E.0352
M204 S10000
G1 X119.124 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5247
M204 S4000
G1 X119.124 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.124 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L59
M991 S0 P58 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.44 I-.642 J1.034 P1  F60000
G1 X137.351 Y134.881 Z7.44
G1 Z7.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5990
M204 S4000
G1 X137.351 Y121.119 E.28545
G1 X118.649 Y121.119 E.38792
G1 X118.649 Y134.881 E.28545
G1 X137.291 Y134.881 E.38667
; COOLING_NODE: 0
M204 S250
G1 X137.717 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X137.76 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X137.76 Y120.71 E.28104
G1 F3600
G1 X137.717 Y120.71 E.00083
G1 X118.283 Y120.71 E.3746
G1 X118.24 Y120.71 E.00083
G1 F3480
G1 X118.24 Y135.29 E.28104
G1 F3600
G1 X118.283 Y135.29 E.00083
M73 P47 R11
G1 X137.657 Y135.29 E.37345
; WIPE_START
M204 S4000
G1 X137.76 Y135.29 E-.03914
G1 X137.76 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.96 Y134.49 Z7.56 F60000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5990
M204 S4000
G1 X136.96 Y121.57 E.2259
M204 S10000
G1 X136.439 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5990
M204 S4000
G1 X134.742 Y121.482 E.0352
G2 X135.159 Y124.358 I1.797 J1.208 E.06609
G3 X136.071 Y127.09 I-1.444 J2 E.06377
G3 X134.964 Y128.455 I-4.622 J-2.615 E.03663
G2 X135.159 Y131.642 I1.61 J1.501 E.07409
G3 X135.99 Y134.518 I-1.399 J1.962 E.067
G1 X132.183 Y134.518 E.07896
G2 X131.765 Y131.642 I-1.797 J-1.208 E.06609
G3 X130.854 Y128.91 I1.444 J-2 E.06377
G3 X131.961 Y127.545 I4.622 J2.615 E.03663
G2 X131.765 Y124.358 I-1.61 J-1.501 E.07408
G3 X130.935 Y121.482 I1.399 J-1.962 E.06701
G1 X129.371 Y121.482 E.03245
G1 X129.371 Y121.615 E.00275
M204 S10000
G1 X129.139 Y122.17 F60000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F5990
M204 S2000
G1 X128.32 Y121.351 E.02232
G1 X128.187 Y121.217
G1 X127.629 Y121.217
G1 X127.763 Y121.351
G1 X129.139 Y122.727 E.03752
G1 X129.273 Y122.861
G1 X129.273 Y123.419
G1 X129.139 Y123.285
G1 X127.205 Y121.351 E.05272
G1 X127.072 Y121.217
G1 X126.727 Y121.431
G1 X126.861 Y121.564
G1 X129.139 Y123.843 E.0621
G1 X129.273 Y123.976
G1 X129.273 Y124.534
G1 X129.139 Y124.4
G1 X126.861 Y122.122 E.0621
G1 X126.727 Y121.988
G1 X126.727 Y122.546
G1 X126.861 Y122.679
G1 X129.139 Y124.958 E.0621
G1 X129.273 Y125.091
G1 X129.273 Y125.649
G1 X129.139 Y125.515
G1 X126.861 Y123.237 E.0621
G1 X126.727 Y123.103
G1 X126.727 Y123.661
G1 X126.861 Y123.795
G1 X129.139 Y126.073 E.0621
G1 X129.273 Y126.206
G1 X129.273 Y126.764
G1 X129.139 Y126.63
G1 X126.861 Y124.352 E.0621
G1 X126.727 Y124.218
G1 X126.727 Y124.776
G1 X126.861 Y124.91
G1 X129.139 Y127.188 E.0621
G1 X129.273 Y127.321
G1 X129.273 Y127.879
G1 X129.139 Y127.745
G1 X126.861 Y125.467 E.0621
G1 X126.727 Y125.334
G1 X126.727 Y125.891
G1 X126.861 Y126.025
G1 X129.139 Y128.303 E.0621
G1 X129.273 Y128.436
G1 X129.273 Y128.994
G1 X129.139 Y128.86
G1 X126.861 Y126.582 E.0621
G1 X126.727 Y126.449
G1 X126.727 Y127.006
G1 X126.861 Y127.14
G1 X129.139 Y129.418 E.0621
G1 X129.273 Y129.552
G1 X129.273 Y130.109
G1 X129.139 Y129.975
G1 X126.861 Y127.697 E.0621
G1 X126.727 Y127.564
G1 X126.727 Y128.121
G1 X126.861 Y128.255
G1 X129.139 Y130.533 E.0621
G1 X129.273 Y130.667
G1 X129.273 Y131.224
G1 X129.139 Y131.091
G1 X126.861 Y128.812 E.0621
G1 X126.727 Y128.679
G1 X126.727 Y129.236
G1 X126.861 Y129.37
G1 X129.139 Y131.648 E.0621
G1 X129.273 Y131.782
G1 X129.273 Y132.339
G1 X129.139 Y132.206
G1 X126.861 Y129.927 E.0621
G1 X126.727 Y129.794
G1 X126.727 Y130.351
G1 X126.861 Y130.485
G1 X129.139 Y132.763 E.0621
G1 X129.273 Y132.897
G1 X129.273 Y133.454
G1 X129.139 Y133.321
G1 X126.861 Y131.043 E.0621
G1 X126.727 Y130.909
G1 X126.727 Y131.466
G1 X126.861 Y131.6
G1 X129.139 Y133.878 E.0621
G1 X129.273 Y134.012
G1 X129.273 Y134.569
G1 X129.139 Y134.436
G1 X126.861 Y132.158 E.0621
G1 X126.727 Y132.024
G1 X126.727 Y132.582
G1 X126.861 Y132.715
G1 X128.795 Y134.649 E.05271
G1 X128.928 Y134.783
G1 X128.371 Y134.783
G1 X128.237 Y134.649
G1 X126.861 Y133.273 E.03752
G1 X126.727 Y133.139
G1 X126.727 Y133.697
G1 X126.861 Y133.83
G1 X127.68 Y134.649 E.02232
M204 S10000
G1 X126.597 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5990
M204 S4000
G1 X124.9 Y134.518 E.0352
G2 X124.482 Y131.642 I-1.797 J-1.208 E.06609
G3 X123.571 Y128.91 I1.444 J-2 E.06377
G3 X124.678 Y127.545 I4.622 J2.615 E.03663
G2 X124.482 Y124.358 I-1.61 J-1.501 E.07409
G3 X123.652 Y121.482 I1.399 J-1.962 E.06701
G1 X120.176 Y121.482 E.07211
G2 X120.593 Y124.358 I1.797 J1.208 E.06609
G3 X121.505 Y127.09 I-1.444 J2 E.06377
G3 X120.398 Y128.455 I-4.622 J-2.615 E.03663
G2 X120.593 Y131.642 I1.61 J1.501 E.07408
G3 X121.423 Y134.518 I-1.399 J1.962 E.067
G1 X119.726 Y134.518 E.0352
M204 S10000
G1 X119.04 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F5990
M204 S4000
G1 X119.04 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X119.04 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L60
M991 S0 P59 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.56 I.345 J1.167 P1  F60000
G1 X127.327 Y121.119 Z7.56
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6365
M204 S4000
G1 X118.565 Y121.119 E.18174
G1 X118.565 Y134.881 E.28545
G1 X127.327 Y134.881 E.18174
G1 X127.327 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.736 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X118.199 Y120.71 E.18383
G1 X118.156 Y120.71 E.00083
G1 F3480
G1 X118.156 Y135.29 E.28104
G1 F3600
G1 X118.199 Y135.29 E.00083
G1 X127.736 Y135.29 E.18383
G1 X127.736 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.736 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.188 Y128.376 Z7.68 F60000
G1 X126.545 Y134.388 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6365
M204 S4000
G1 X126.545 Y134.518 E.00269
G1 X124.977 Y134.518 E.03251
G2 X124.362 Y131.642 I-1.969 J-1.082 E.06652
G3 X124.355 Y128 I1.385 J-1.823 E.08733
G2 X124.362 Y124.358 I-1.385 J-1.823 E.08733
G3 X123.735 Y121.482 I1.352 J-1.801 E.06655
G1 X120.098 Y121.482 E.07545
G2 X120.714 Y124.358 I1.969 J1.083 E.06652
G3 X120.72 Y128 I-1.385 J1.823 E.08733
G2 X120.714 Y131.642 I1.385 J1.823 E.08733
G3 X121.34 Y134.518 I-1.352 J1.801 E.06655
G1 X119.643 Y134.518 E.0352
M204 S10000
G1 X118.956 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6365
M204 S4000
G1 X118.956 Y121.57 E.2259
M204 S10000
G1 X126.936 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6365
M204 S4000
G1 X126.936 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X126.936 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.128 Y129.164 Z7.68 F60000
G1 X137.435 Y134.881 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6365
M204 S4000
G1 X137.435 Y121.119 E.28545
G1 X128.673 Y121.119 E.18174
G1 X128.673 Y134.881 E.28545
G1 X137.375 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X137.801 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X137.844 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X137.844 Y120.71 E.28104
G1 F3600
G1 X137.801 Y120.71 E.00083
G1 X128.264 Y120.71 E.18383
G1 X128.264 Y135.29 E.28104
G1 X137.741 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X137.844 Y135.29 E-.03914
G1 X137.844 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.044 Y134.49 Z7.68 F60000
G1 Z7.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6365
M204 S4000
G1 X137.044 Y121.57 E.2259
M204 S10000
G1 X136.361 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6365
M204 S4000
G1 X134.664 Y121.482 E.0352
G2 X135.28 Y124.358 I1.969 J1.083 E.06652
G3 X135.286 Y128 I-1.385 J1.823 E.08733
G2 X135.28 Y131.642 I1.385 J1.823 E.08733
G3 X135.906 Y134.518 I-1.352 J1.801 E.06655
G1 X132.261 Y134.518 E.07562
G2 X131.645 Y131.642 I-1.969 J-1.082 E.06652
G3 X131.638 Y128 I1.385 J-1.823 E.08733
G2 X131.645 Y124.358 I-1.385 J-1.823 E.08733
G3 X131.018 Y121.482 I1.352 J-1.801 E.06655
G1 X129.455 Y121.482 E.03243
G1 X129.455 Y121.616 E.00277
M204 S10000
G1 X129.064 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6365
M204 S4000
G1 X129.064 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X129.064 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L61
M991 S0 P60 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.68 I.977 J-.726 P1  F60000
G1 X127.243 Y121.119 Z7.68
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6353
M204 S4000
G1 X118.481 Y121.119 E.18174
G1 X118.481 Y134.881 E.28545
G1 X127.243 Y134.881 E.18174
G1 X127.243 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.652 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X118.115 Y120.71 E.18383
G1 X118.072 Y120.71 E.00083
G1 F3480
G1 X118.072 Y135.29 E.28104
G1 F3600
G1 X118.115 Y135.29 E.00083
G1 X127.652 Y135.29 E.18383
G1 X127.652 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.652 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.51 Y121.482 Z7.8 F60000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6353
M204 S4000
G1 X123.813 Y121.482 E.0352
G2 X124.241 Y124.358 I1.806 J1.202 E.06611
G3 X125.142 Y127.09 I-1.441 J1.99 E.06373
G3 X124.034 Y128.455 I-4.69 J-2.674 E.03664
G2 X124.241 Y131.642 I1.618 J1.495 E.07408
G3 X125.06 Y134.518 I-1.397 J1.953 E.06697
G1 X121.262 Y134.518 E.07879
G2 X120.834 Y131.642 I-1.806 J-1.201 E.06611
G3 X119.933 Y128.91 I1.441 J-1.99 E.06373
G3 X121.041 Y127.545 I4.691 J2.674 E.03664
G2 X120.834 Y124.358 I-1.619 J-1.495 E.07408
G3 X120.015 Y121.482 I1.397 J-1.953 E.06697
G1 X119.263 Y121.482 E.0156
G1 X119.263 Y122.427 E.0196
M204 S10000
G1 X118.872 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6353
M204 S4000
G1 X118.872 Y121.57 E.2259
M204 S10000
G1 X126.852 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6353
M204 S4000
G1 X126.852 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X126.852 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.088 Y129.123 Z7.8 F60000
G1 X137.519 Y134.881 Z7.8
M73 P48 R11
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6353
M204 S4000
G1 X137.519 Y121.119 E.28545
G1 X128.757 Y121.119 E.18174
M73 P48 R10
G1 X128.757 Y134.881 E.28545
G1 X137.459 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X137.885 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X137.928 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X137.928 Y120.71 E.28104
G1 F3600
G1 X137.885 Y120.71 E.00083
G1 X128.348 Y120.71 E.18383
G1 X128.348 Y135.29 E.28104
G1 X137.825 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X137.928 Y135.29 E-.03914
G1 X137.928 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.128 Y134.49 Z7.8 F60000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6353
M204 S4000
G1 X137.128 Y121.57 E.2259
M204 S10000
G1 X136.737 Y133.73 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6353
M204 S4000
G1 X136.737 Y134.518 E.01635
G1 X135.828 Y134.518 E.01885
G2 X135.401 Y131.642 I-1.806 J-1.201 E.06611
G3 X134.499 Y128.91 I1.441 J-1.99 E.06373
G3 X135.608 Y127.545 I4.69 J2.674 E.03664
G2 X135.401 Y124.358 I-1.619 J-1.495 E.07408
G3 X134.581 Y121.482 I1.397 J-1.953 E.06697
G1 X131.096 Y121.482 E.07228
G2 X131.524 Y124.358 I1.806 J1.201 E.06611
G3 X132.425 Y127.09 I-1.441 J1.99 E.06373
G3 X131.317 Y128.455 I-4.691 J-2.674 E.03664
G2 X131.524 Y131.642 I1.618 J1.495 E.07408
G3 X132.343 Y134.518 I-1.397 J1.953 E.06697
G1 X130.646 Y134.518 E.0352
M204 S10000
G1 X129.148 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6353
M204 S4000
G1 X129.148 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X129.148 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L62
M991 S0 P61 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.8 I.945 J-.767 P1  F60000
G1 X127.159 Y121.119 Z7.8
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6367
M204 S4000
G1 X118.397 Y121.119 E.18174
G1 X118.397 Y134.881 E.28545
G1 X127.159 Y134.881 E.18174
G1 X127.159 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.568 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X118.031 Y120.71 E.18383
G1 X117.988 Y120.71 E.00083
G1 F3480
G1 X117.988 Y135.29 E.28104
G1 F3600
G1 X118.031 Y135.29 E.00083
G1 X127.568 Y135.29 E.18383
G1 X127.568 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.568 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.584 Y121.482 Z7.92 F60000
G1 Z7.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6367
M204 S4000
G1 X123.887 Y121.482 E.0352
G2 X124.117 Y124.358 I1.644 J1.316 E.06594
G3 X125.302 Y126.634 I-1.602 J2.281 E.05532
G3 X124.6 Y128 I-2.13 J-.231 E.03257
G2 X123.415 Y130.276 I1.602 J2.281 E.05532
G2 X124.117 Y131.642 I2.13 J-.231 E.03257
G3 X125.302 Y133.918 I-1.602 J2.281 E.05532
G3 X125.15 Y134.518 I-1.117 J.037 E.01301
G1 X121.188 Y134.518 E.08218
G2 X120.959 Y131.642 I-1.644 J-1.316 E.06594
G3 X119.773 Y129.366 I1.602 J-2.281 E.05532
G3 X120.475 Y128 I2.13 J.231 E.03257
G2 X121.661 Y125.724 I-1.602 J-2.281 E.05532
G2 X120.959 Y124.358 I-2.13 J.231 E.03257
G3 X119.773 Y122.082 I1.602 J-2.281 E.05532
G3 X119.925 Y121.482 I1.117 J-.037 E.01302
G1 X119.179 Y121.482 E.01548
G1 X119.179 Y122.433 E.01972
M204 S10000
G1 X118.788 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6367
M204 S4000
G1 X118.788 Y121.57 E.2259
M204 S10000
G1 X126.768 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6367
M204 S4000
G1 X126.768 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X126.768 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.048 Y129.082 Z7.92 F60000
G1 X137.603 Y134.881 Z7.92
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6367
M204 S4000
G1 X137.603 Y121.119 E.28545
G1 X128.841 Y121.119 E.18174
G1 X128.841 Y134.881 E.28545
G1 X137.543 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X137.969 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.012 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.012 Y120.71 E.28104
G1 F3600
G1 X137.969 Y120.71 E.00083
G1 X128.432 Y120.71 E.18383
G1 X128.432 Y135.29 E.28104
G1 X137.909 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.012 Y135.29 E-.03914
G1 X138.012 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.212 Y134.49 Z7.92 F60000
G1 Z7.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6367
M204 S4000
G1 X137.212 Y121.57 E.2259
M204 S10000
G1 X136.821 Y133.888 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6367
M204 S4000
G1 X136.821 Y134.518 E.01308
G1 X135.754 Y134.518 E.02212
G2 X136.146 Y132.552 I-1.85 J-1.391 E.043
G2 X135.059 Y131.186 I-3.621 J1.767 E.03649
G3 X134.42 Y128.91 I1.684 J-1.7 E.05129
G3 X135.507 Y127.545 I3.621 J1.767 E.03649
G2 X136.146 Y125.269 I-1.684 J-1.7 E.05129
G2 X135.059 Y123.903 I-3.621 J1.767 E.03649
G3 X134.491 Y121.482 I1.549 J-1.64 E.05463
G1 X131.17 Y121.482 E.06889
G2 X130.779 Y123.448 I1.85 J1.391 E.04301
G2 X131.866 Y124.814 I3.621 J-1.767 E.03649
G3 X132.505 Y127.09 I-1.684 J1.7 E.05129
G3 X131.418 Y128.455 I-3.621 J-1.767 E.03649
G2 X130.779 Y130.731 I1.684 J1.7 E.05129
G2 X131.866 Y132.097 I3.621 J-1.767 E.03649
G3 X132.433 Y134.518 I-1.549 J1.64 E.05463
G1 X130.736 Y134.518 E.0352
M204 S10000
G1 X129.232 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6367
M204 S4000
G1 X129.232 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X129.232 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L63
M991 S0 P62 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.92 I-.975 J.729 P1  F60000
G1 X137.687 Y134.881 Z7.92
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6384
M204 S4000
G1 X137.687 Y121.119 E.28545
G1 X128.925 Y121.119 E.18174
G1 X128.925 Y134.881 E.28545
G1 X137.627 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.053 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.096 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.096 Y120.71 E.28104
G1 F3600
G1 X138.053 Y120.71 E.00083
G1 X128.516 Y120.71 E.18383
G1 X128.516 Y135.29 E.28104
G1 X137.993 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.096 Y135.29 E-.03914
G1 X138.096 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.296 Y134.49 Z8.04 F60000
G1 Z7.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6384
M204 S4000
G1 X137.296 Y121.57 E.2259
M204 S10000
G1 X136.905 Y134.043 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6384
M204 S4000
G1 X136.905 Y134.518 E.00985
G1 X135.683 Y134.518 E.02535
G2 X136.234 Y132.552 I-1.832 J-1.573 E.04372
G2 X135.161 Y131.186 I-2.892 J1.168 E.03651
G3 X134.333 Y128.91 I1.656 J-1.891 E.05241
G3 X135.406 Y127.545 I2.892 J1.168 E.03651
G2 X136.234 Y125.269 I-1.656 J-1.891 E.05241
G2 X135.161 Y123.903 I-2.892 J1.168 E.03651
G3 X134.393 Y121.482 I1.515 J-1.813 E.05563
G1 X131.242 Y121.482 E.06535
G2 X130.691 Y123.448 I1.832 J1.573 E.04372
G2 X131.764 Y124.814 I2.892 J-1.168 E.03651
G3 X132.592 Y127.09 I-1.656 J1.891 E.05241
G3 X131.519 Y128.455 I-2.892 J-1.168 E.03651
G2 X130.691 Y130.731 I1.656 J1.891 E.05241
G2 X131.764 Y132.097 I2.892 J-1.168 E.03651
G3 X132.532 Y134.518 I-1.515 J1.813 E.05562
G1 X130.835 Y134.518 E.0352
M204 S10000
G1 X129.316 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6384
M204 S4000
G1 X129.316 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.316 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.075 Y121.119 Z8.04 F60000
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6384
M204 S4000
G1 X118.313 Y121.119 E.18174
G1 X118.313 Y134.881 E.28545
G1 X127.075 Y134.881 E.18174
G1 X127.075 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.484 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.947 Y120.71 E.18383
G1 X117.904 Y120.71 E.00083
G1 F3480
G1 X117.904 Y135.29 E.28104
G1 F3600
G1 X117.947 Y135.29 E.00083
G1 X127.484 Y135.29 E.18383
G1 X127.484 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.484 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.656 Y121.482 Z8.04 F60000
G1 Z7.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6384
M204 S4000
G1 X123.959 Y121.482 E.0352
G2 X123.983 Y124.358 I1.449 J1.426 E.06628
G3 X125.297 Y126.179 I-2.378 J3.099 E.04723
G3 X124.734 Y128 I-1.777 J.448 E.04157
G2 X123.42 Y129.821 I2.378 J3.099 E.04723
G2 X123.983 Y131.642 I1.777 J.448 E.04157
G3 X125.297 Y133.462 I-2.378 J3.099 E.04723
M73 P49 R10
G3 X125.249 Y134.518 I-1.969 J.44 E.02218
G1 X121.117 Y134.518 E.08572
G2 X121.092 Y131.642 I-1.449 J-1.426 E.06628
G3 X119.779 Y129.821 I2.378 J-3.099 E.04723
G3 X120.342 Y128 I1.777 J-.448 E.04157
G2 X121.655 Y126.179 I-2.378 J-3.099 E.04723
G2 X121.092 Y124.358 I-1.777 J-.448 E.04157
G3 X119.779 Y122.538 I2.378 J-3.099 E.04723
G3 X119.826 Y121.482 I1.969 J-.44 E.02218
G1 X119.095 Y121.482 E.01517
G1 X119.095 Y122.448 E.02003
M204 S10000
G1 X118.704 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6384
M204 S4000
G1 X118.704 Y121.57 E.2259
M204 S10000
G1 X126.684 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6384
M204 S4000
G1 X126.684 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.684 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L64
M991 S0 P63 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.04 I-.869 J.852 P1  F60000
G1 X137.771 Y134.881 Z8.04
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6427
M204 S4000
G1 X137.771 Y121.119 E.28545
G1 X129.009 Y121.119 E.18174
G1 X129.009 Y134.881 E.28545
G1 X137.711 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.137 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.18 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.18 Y120.71 E.28104
G1 F3600
G1 X138.137 Y120.71 E.00083
G1 X128.6 Y120.71 E.18383
G1 X128.6 Y135.29 E.28104
G1 X138.077 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.18 Y135.29 E-.03914
G1 X138.18 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.38 Y134.49 Z8.16 F60000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6427
M204 S4000
G1 X137.38 Y121.57 E.2259
M204 S10000
G1 X136.989 Y134.21 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6427
M204 S4000
G1 X136.989 Y134.518 E.00638
G1 X135.6 Y134.518 E.02882
G2 X136.183 Y132.097 I-1.52 J-1.647 E.05477
G2 X134.807 Y130.731 I-5.528 J4.194 E.04034
G3 X134.383 Y128.455 I1.734 J-1.501 E.05034
G3 X135.759 Y127.09 I5.528 J4.193 E.04034
G2 X136.183 Y124.814 I-1.734 J-1.501 E.05034
G2 X134.807 Y123.448 I-5.528 J4.193 E.04034
G3 X134.282 Y121.482 I1.809 J-1.536 E.04362
G1 X131.325 Y121.482 E.06134
G2 X130.741 Y123.903 I1.52 J1.647 E.05478
G2 X132.117 Y125.269 I5.528 J-4.193 E.04034
G3 X132.542 Y127.545 I-1.734 J1.501 E.05034
G3 X131.166 Y128.91 I-5.528 J-4.193 E.04034
G2 X130.741 Y131.186 I1.734 J1.501 E.05034
G2 X132.117 Y132.552 I5.527 J-4.193 E.04034
G3 X132.642 Y134.518 I-1.81 J1.536 E.04362
G1 X130.945 Y134.518 E.0352
M204 S10000
G1 X129.4 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6427
M204 S4000
G1 X129.4 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.4 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.991 Y121.119 Z8.16 F60000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6427
M204 S4000
G1 X118.229 Y121.119 E.18174
G1 X118.229 Y134.881 E.28545
G1 X126.991 Y134.881 E.18174
G1 X126.991 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.4 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.863 Y120.71 E.18383
G1 X117.82 Y120.71 E.00083
G1 F3480
G1 X117.82 Y135.29 E.28104
G1 F3600
G1 X117.863 Y135.29 E.00083
G1 X127.4 Y135.29 E.18383
G1 X127.4 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.4 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.739 Y121.482 Z8.16 F60000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6427
M204 S4000
G1 X124.042 Y121.482 E.0352
G2 X123.458 Y123.903 I1.52 J1.647 E.05478
G2 X124.834 Y125.269 I5.528 J-4.194 E.04034
G3 X125.259 Y127.545 I-1.734 J1.501 E.05034
G3 X123.883 Y128.91 I-5.527 J-4.193 E.04034
G2 X123.458 Y131.186 I1.734 J1.501 E.05034
G2 X124.834 Y132.552 I5.528 J-4.193 E.04034
G3 X125.359 Y134.518 I-1.81 J1.536 E.04362
G1 X121.033 Y134.518 E.08973
G2 X121.617 Y132.097 I-1.52 J-1.647 E.05477
G2 X120.241 Y130.731 I-5.528 J4.194 E.04034
G3 X119.817 Y128.455 I1.734 J-1.501 E.05034
G3 X121.193 Y127.09 I5.528 J4.193 E.04034
G2 X121.617 Y124.814 I-1.734 J-1.501 E.05034
G2 X120.241 Y123.448 I-5.528 J4.193 E.04034
G3 X119.716 Y121.482 I1.809 J-1.536 E.04362
G1 X119.011 Y121.482 E.01463
G1 X119.011 Y122.474 E.02057
M204 S10000
G1 X118.62 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6427
M204 S4000
G1 X118.62 Y121.57 E.2259
M204 S10000
G1 X126.6 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6427
M204 S4000
G1 X126.6 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.6 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L65
M991 S0 P64 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.16 I-.863 J.858 P1  F60000
G1 X137.855 Y134.881 Z8.16
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6477
M204 S4000
G1 X137.855 Y121.119 E.28545
G1 X129.093 Y121.119 E.18174
G1 X129.093 Y134.881 E.28545
G1 X137.795 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.221 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.264 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.264 Y120.71 E.28104
G1 F3600
G1 X138.221 Y120.71 E.00083
G1 X128.684 Y120.71 E.18383
G1 X128.684 Y135.29 E.28104
G1 X138.161 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.264 Y135.29 E-.03914
G1 X138.264 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.464 Y134.49 Z8.28 F60000
G1 Z7.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6477
M204 S4000
G1 X137.464 Y121.57 E.2259
M204 S10000
G1 X137.073 Y134.365 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6477
M204 S4000
G1 X137.073 Y134.518 E.00318
G1 X135.529 Y134.518 E.03202
G2 X136.401 Y133.007 I-1.685 J-1.979 E.03689
G2 X135.98 Y131.642 I-1.384 J-.321 E.03105
G1 X134.858 Y130.731 E.02997
G3 X134.165 Y129.366 I2.26 J-2.005 E.03211
G3 X134.586 Y128 I1.384 J-.321 E.03106
G1 X135.708 Y127.09 E.02997
G2 X136.401 Y125.724 I-2.26 J-2.005 E.03211
G2 X135.98 Y124.358 I-1.384 J-.321 E.03105
G1 X134.858 Y123.448 E.02997
G3 X134.158 Y121.482 I1.856 J-1.769 E.04459
G1 X131.396 Y121.482 E.05729
G2 X130.524 Y122.993 I1.685 J1.979 E.0369
G2 X130.944 Y124.358 I1.384 J.321 E.03106
G1 X132.066 Y125.269 E.02997
G3 X132.759 Y126.634 I-2.26 J2.005 E.03211
G3 X132.339 Y128 I-1.384 J.321 E.03105
G1 X131.217 Y128.91 E.02997
G2 X130.524 Y130.276 I2.26 J2.005 E.03211
G2 X130.944 Y131.642 I1.384 J.321 E.03106
G1 X132.066 Y132.552 E.02997
G3 X132.767 Y134.518 I-1.856 J1.769 E.04458
G1 X131.07 Y134.518 E.0352
M204 S10000
G1 X129.484 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6477
M204 S4000
G1 X129.484 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.484 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.907 Y121.119 Z8.28 F60000
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6477
M204 S4000
G1 X118.145 Y121.119 E.18174
G1 X118.145 Y134.881 E.28545
G1 X126.907 Y134.881 E.18174
G1 X126.907 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.316 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.779 Y120.71 E.18383
G1 X117.736 Y120.71 E.00083
G1 F3480
G1 X117.736 Y135.29 E.28104
G1 F3600
G1 X117.779 Y135.29 E.00083
G1 X127.316 Y135.29 E.18383
G1 X127.316 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.316 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.81 Y121.482 Z8.28 F60000
G1 Z7.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6477
M204 S4000
G1 X124.113 Y121.482 E.0352
G2 X123.3 Y123.903 I1.509 J1.853 E.05589
G1 X123.661 Y124.358 E.01206
G1 X124.783 Y125.269 E.02997
G3 X125.417 Y127.545 I-1.76 J1.716 E.05112
G1 X125.056 Y128 E.01206
G1 X123.934 Y128.91 E.02997
G2 X123.3 Y131.186 I1.76 J1.716 E.05112
G1 X123.661 Y131.642 E.01206
G1 X124.783 Y132.552 E.02997
G3 X125.484 Y134.518 I-1.856 J1.769 E.04458
G1 X120.963 Y134.518 E.09378
G2 X121.776 Y132.097 I-1.509 J-1.853 E.05589
G1 X121.414 Y131.642 E.01206
G1 X120.292 Y130.731 E.02997
G3 X119.658 Y128.455 I1.76 J-1.716 E.05112
G1 X120.02 Y128 E.01206
G1 X121.142 Y127.09 E.02997
G2 X121.776 Y124.814 I-1.76 J-1.716 E.05112
G1 X121.414 Y124.358 E.01206
G1 X120.292 Y123.448 E.02997
G3 X119.591 Y121.482 I1.856 J-1.769 E.04459
G1 X118.927 Y121.482 E.01378
G1 X118.927 Y122.515 E.02142
M204 S10000
G1 X118.536 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6477
M204 S4000
G1 X118.536 Y121.57 E.2259
M204 S10000
G1 X126.516 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6477
M204 S4000
G1 X126.516 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.516 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L66
M991 S0 P65 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.28 I-.856 J.865 P1  F60000
G1 X137.939 Y134.881 Z8.28
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6552
M204 S4000
G1 X137.939 Y121.119 E.28545
G1 X129.177 Y121.119 E.18174
G1 X129.177 Y134.881 E.28545
G1 X137.879 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.305 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.348 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.348 Y120.71 E.28104
G1 F3600
M73 P50 R10
G1 X138.305 Y120.71 E.00083
G1 X128.768 Y120.71 E.18383
G1 X128.768 Y135.29 E.28104
G1 X138.245 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.348 Y135.29 E-.03914
G1 X138.348 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.548 Y134.49 Z8.4 F60000
G1 Z8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6552
M204 S4000
G1 X137.548 Y121.57 E.2259
M204 S10000
G1 X137.15 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6552
M204 S4000
G1 X135.453 Y134.518 E.0352
G2 X136.563 Y132.552 I-1.692 J-2.252 E.04818
G1 X136.531 Y132.097 E.00947
G1 X136.201 Y131.642 E.01166
G1 X134.906 Y130.731 E.03282
G3 X134.003 Y128.91 I2.184 J-2.219 E.04295
G1 X134.035 Y128.455 E.00947
G1 X134.365 Y128 E.01166
G1 X135.66 Y127.09 E.03282
G2 X136.563 Y125.269 I-2.184 J-2.218 E.04295
G1 X136.531 Y124.814 E.00947
G1 X136.201 Y124.358 E.01166
G1 X134.906 Y123.448 E.03282
G3 X134.003 Y121.627 I2.184 J-2.218 E.04295
G1 X134.013 Y121.482 E.00302
G1 X131.471 Y121.482 E.05272
G2 X130.361 Y123.448 I1.692 J2.252 E.04819
G1 X130.394 Y123.903 E.00947
G1 X130.724 Y124.358 E.01166
G1 X132.018 Y125.269 E.03282
G3 X132.922 Y127.09 I-2.184 J2.219 E.04295
G1 X132.889 Y127.545 E.00947
G1 X132.559 Y128 E.01166
G1 X131.265 Y128.91 E.03282
G2 X130.361 Y130.731 I2.184 J2.218 E.04295
G1 X130.394 Y131.186 E.00947
G1 X130.724 Y131.642 E.01166
G1 X132.018 Y132.552 E.03282
G3 X132.922 Y134.373 I-2.184 J2.219 E.04295
G1 X132.911 Y134.518 E.00302
G1 X131.214 Y134.518 E.0352
M204 S10000
G1 X129.568 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6552
M204 S4000
G1 X129.568 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.568 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.823 Y121.119 Z8.4 F60000
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6552
M204 S4000
G1 X118.061 Y121.119 E.18174
G1 X118.061 Y134.881 E.28545
G1 X126.823 Y134.881 E.18174
G1 X126.823 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.232 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.695 Y120.71 E.18383
G1 X117.652 Y120.71 E.00083
G1 F3480
G1 X117.652 Y135.29 E.28104
G1 F3600
G1 X117.695 Y135.29 E.00083
G1 X127.232 Y135.29 E.18383
G1 X127.232 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.232 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.885 Y121.482 Z8.4 F60000
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6552
M204 S4000
G1 X124.188 Y121.482 E.0352
G2 X123.111 Y123.903 I1.633 J2.177 E.05741
G1 X123.441 Y124.358 E.01166
G1 X124.735 Y125.269 E.03282
G3 X125.606 Y127.545 I-1.853 J2.014 E.05239
G1 X125.276 Y128 E.01166
G1 X123.982 Y128.91 E.03282
G2 X123.111 Y131.186 I1.853 J2.014 E.05239
G1 X123.441 Y131.642 E.01166
G1 X124.735 Y132.552 E.03282
G3 X125.628 Y134.518 I-1.886 J2.043 E.046
G1 X120.887 Y134.518 E.09834
G2 X121.965 Y132.097 I-1.634 J-2.177 E.05741
G1 X121.635 Y131.642 E.01166
G1 X120.34 Y130.731 E.03282
G3 X119.469 Y128.455 I1.853 J-2.014 E.05239
G1 X119.799 Y128 E.01166
G1 X121.094 Y127.09 E.03282
G2 X121.965 Y124.814 I-1.853 J-2.014 E.05239
G1 X121.635 Y124.358 E.01166
G1 X120.34 Y123.448 E.03282
G3 X119.447 Y121.482 I1.886 J-2.043 E.046
G1 X118.843 Y121.482 E.01253
G1 X118.843 Y122.575 E.02267
M204 S10000
G1 X118.452 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6552
M204 S4000
G1 X118.452 Y121.57 E.2259
M204 S10000
G1 X126.432 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6552
M204 S4000
G1 X126.432 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.432 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L67
M991 S0 P66 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.4 I-.85 J.871 P1  F60000
G1 X138.023 Y134.881 Z8.4
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6662
M204 S4000
G1 X138.023 Y121.119 E.28545
G1 X129.261 Y121.119 E.18174
G1 X129.261 Y134.881 E.28545
G1 X137.963 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.389 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.432 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.432 Y120.71 E.28104
G1 F3600
G1 X138.389 Y120.71 E.00083
G1 X128.852 Y120.71 E.18383
G1 X128.852 Y135.29 E.28104
G1 X138.329 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.432 Y135.29 E-.03914
G1 X138.432 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.632 Y134.49 Z8.52 F60000
G1 Z8.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6662
M204 S4000
G1 X137.632 Y121.57 E.2259
M204 S10000
G1 X137.08 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6662
M204 S4000
G1 X135.383 Y134.518 E.0352
G2 X136.769 Y132.097 I-1.822 J-2.651 E.05986
G1 X136.532 Y131.642 E.01065
G1 X135.676 Y131.186 E.0201
G3 X133.797 Y128.455 I1.43 J-2.996 E.072
G1 X134.035 Y128 E.01065
G1 X134.89 Y127.545 E.0201
G2 X136.769 Y124.814 I-1.43 J-2.996 E.072
G1 X136.532 Y124.358 E.01065
G1 X135.676 Y123.903 E.0201
G3 X133.862 Y121.627 I1.404 J-2.98 E.06253
G1 X133.841 Y121.482 E.00304
G1 X131.542 Y121.482 E.0477
G2 X130.155 Y123.903 I1.822 J2.651 E.05986
G1 X130.393 Y124.358 E.01065
G1 X131.248 Y124.814 E.0201
G3 X133.128 Y127.545 I-1.43 J2.996 E.072
G1 X132.89 Y128 E.01065
G1 X132.035 Y128.455 E.0201
G2 X130.155 Y131.186 I1.43 J2.996 E.072
G1 X130.393 Y131.642 E.01065
G1 X131.248 Y132.097 E.0201
G3 X133.063 Y134.373 I-1.404 J2.98 E.06253
G1 X133.083 Y134.518 E.00304
G1 X131.386 Y134.518 E.0352
M204 S10000
G1 X129.652 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6662
M204 S4000
G1 X129.652 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.652 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.739 Y121.119 Z8.52 F60000
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6662
M204 S4000
G1 X117.977 Y121.119 E.18174
G1 X117.977 Y134.881 E.28545
G1 X126.739 Y134.881 E.18174
G1 X126.739 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.148 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.611 Y120.71 E.18383
G1 X117.568 Y120.71 E.00083
G1 F3480
G1 X117.568 Y135.29 E.28104
G1 F3600
G1 X117.611 Y135.29 E.00083
G1 X127.148 Y135.29 E.18383
G1 X127.148 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.148 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.956 Y121.482 Z8.52 F60000
G1 Z8.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6662
M204 S4000
G1 X124.259 Y121.482 E.0352
G2 X122.872 Y123.903 I1.821 J2.651 E.05986
G1 X123.11 Y124.358 E.01065
G3 X125.14 Y125.724 I-2.587 J6.037 E.05105
G3 X125.845 Y127.545 I-3.78 J2.509 E.04081
G1 X125.607 Y128 E.01065
G2 X123.577 Y129.366 I2.586 J6.037 E.05105
G2 X122.872 Y131.186 I3.779 J2.509 E.04081
G1 X123.11 Y131.642 E.01065
G3 X125.14 Y133.007 I-2.586 J6.037 E.05105
G3 X125.8 Y134.518 I-4.339 J2.795 E.03434
G1 X120.817 Y134.518 E.10337
G2 X122.203 Y132.097 I-1.822 J-2.651 E.05986
G1 X121.965 Y131.642 E.01065
G3 X119.935 Y130.276 I2.587 J-6.037 E.05105
G3 X119.231 Y128.455 I3.779 J-2.509 E.04081
G1 X119.469 Y128 E.01065
G2 X121.499 Y126.634 I-2.586 J-6.037 E.05105
G2 X122.203 Y124.814 I-3.779 J-2.509 E.04081
G1 X121.965 Y124.358 E.01065
G3 X119.935 Y122.993 I2.586 J-6.037 E.05105
G3 X119.275 Y121.482 I4.338 J-2.795 E.03434
G1 X118.759 Y121.482 E.0107
G1 X118.759 Y122.663 E.0245
M204 S10000
G1 X118.368 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6662
M204 S4000
G1 X118.368 Y121.57 E.2259
M204 S10000
G1 X126.348 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6662
M204 S4000
G1 X126.348 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.348 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L68
M991 S0 P67 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.52 I-.844 J.877 P1  F60000
G1 X138.107 Y134.881 Z8.52
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7199
M204 S4000
G1 X138.107 Y121.119 E.28545
G1 X129.345 Y121.119 E.18174
G1 X129.345 Y134.881 E.28545
G1 X138.047 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.473 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.516 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.516 Y120.71 E.28104
G1 F3600
G1 X138.473 Y120.71 E.00083
G1 X128.936 Y120.71 E.18383
G1 X128.936 Y135.29 E.28104
G1 X138.413 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.516 Y135.29 E-.03914
G1 X138.516 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.716 Y134.49 Z8.64 F60000
G1 Z8.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7199
M204 S4000
G1 X137.716 Y121.57 E.2259
M204 S10000
G1 X135.31 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7199
M204 S4000
G1 X133.613 Y121.482 E.0352
G2 X134.828 Y123.323 I5.376 J-2.227 E.04602
G2 X136.649 Y124.088 I2.877 J-4.295 E.04122
G1 X137.104 Y123.9 E.01022
G1 X137.325 Y123.451 E.01039
G1 X137.325 Y124.725 E.02644
G1 X137.104 Y124.817 E.00496
G3 X135.738 Y126.964 I-6.029 J-2.326 E.05313
M73 P51 R10
G3 X133.918 Y127.73 I-2.877 J-4.295 E.04122
G1 X133.462 Y127.542 E.01022
G2 X132.097 Y125.394 I-6.029 J2.326 E.05313
G2 X130.276 Y124.629 I-2.877 J4.295 E.04122
G1 X130.127 Y124.69 E.00334
G1 X130.127 Y123.278 E.0293
G3 X131.186 Y121.753 I4.82 J2.217 E.03872
G1 X131.595 Y121.482 E.01017
G1 X130.127 Y121.482 E.03046
G1 X130.127 Y121.711 E.00474
M204 S10000
G1 X129.736 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7199
M204 S4000
G1 X129.736 Y121.57 E.2259
M204 S10000
G1 X131.697 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7199
M204 S4000
G1 X133.394 Y134.518 E.0352
G3 X132.552 Y133.142 I36.198 J-23.101 E.03347
G2 X130.276 Y131.912 I-2.814 J2.486 E.05478
G1 X130.127 Y131.973 E.00334
G1 X130.127 Y130.561 E.0293
G3 X131.186 Y129.036 I4.82 J2.217 E.03872
G3 X133.007 Y128.27 I2.877 J4.295 E.04122
G1 X133.462 Y128.458 E.01022
G2 X134.828 Y130.606 I6.029 J-2.326 E.05313
G2 X136.649 Y131.371 I2.877 J-4.295 E.04122
G1 X137.104 Y131.183 E.01022
G1 X137.325 Y130.734 E.01039
G1 X137.325 Y132.009 E.02644
G1 X137.104 Y132.1 E.00496
G3 X135.738 Y134.247 I-6.029 J-2.326 E.05313
G1 X135.329 Y134.518 E.01017
G1 X137.026 Y134.518 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X135.329 Y134.518 E-.64486
G1 X135.582 Y134.351 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.313 Y128.024 Z8.64 F60000
G1 X126.655 Y121.119 Z8.64
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F7199
M204 S4000
G1 X117.893 Y121.119 E.18174
G1 X117.893 Y134.881 E.28545
G1 X126.655 Y134.881 E.18174
G1 X126.655 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X127.064 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.527 Y120.71 E.18383
G1 X117.484 Y120.71 E.00083
G1 F3480
G1 X117.484 Y135.29 E.28104
G1 F3600
G1 X117.527 Y135.29 E.00083
G1 X127.064 Y135.29 E.18383
G1 X127.064 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X125.064 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.675 Y122.807 Z8.64 F60000
G1 Z8.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7199
M204 S4000
G1 X118.675 Y121.482 E.02748
G1 X119.047 Y121.482 E.00772
G2 X120.262 Y123.323 I5.376 J-2.227 E.04602
G2 X122.083 Y124.088 I2.877 J-4.295 E.04122
G1 X122.538 Y123.9 E.01022
G3 X123.903 Y121.753 I6.029 J2.326 E.05313
G1 X124.312 Y121.482 E.01017
G1 X125.873 Y121.482 E.03237
G1 X125.873 Y126.919 E.11278
G2 X124.814 Y125.394 I-4.819 J2.217 E.03871
G2 X122.993 Y124.629 I-2.877 J4.295 E.04122
G1 X122.538 Y124.817 E.01022
G3 X121.172 Y126.964 I-6.029 J-2.326 E.05313
G3 X119.351 Y127.73 I-2.877 J-4.295 E.04122
G1 X118.896 Y127.542 E.01022
G1 X118.675 Y127.092 E.01039
G1 X118.675 Y128.367 E.02644
G1 X118.896 Y128.458 E.00496
G2 X120.262 Y130.606 I6.029 J-2.326 E.05313
G2 X122.083 Y131.371 I2.877 J-4.295 E.04122
G1 X122.538 Y131.183 E.01022
G3 X123.903 Y129.036 I6.029 J2.326 E.05313
G3 X125.724 Y128.27 I2.877 J4.295 E.04122
G1 X125.873 Y128.332 E.00334
G1 X125.873 Y134.138 E.12043
G3 X125.269 Y133.142 I26.182 J-16.563 E.02416
G2 X122.993 Y131.912 I-2.814 J2.486 E.05478
G1 X122.538 Y132.1 E.01022
G3 X121.172 Y134.247 I-6.029 J-2.326 E.05313
G1 X120.763 Y134.518 E.01017
G1 X119.066 Y134.518 E.0352
M204 S10000
G1 X118.284 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7199
M204 S4000
G1 X118.284 Y121.57 E.2259
M204 S10000
G1 X126.264 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7199
M204 S4000
G1 X126.264 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.264 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L69
M991 S0 P68 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.64 I-.837 J.883 P1  F60000
G1 X138.191 Y134.881 Z8.64
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7154
M204 S4000
G1 X138.191 Y121.119 E.28545
G1 X129.429 Y121.119 E.18174
G1 X129.429 Y134.881 E.28545
G1 X138.131 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.557 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.6 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.6 Y120.71 E.28104
G1 F3600
G1 X138.557 Y120.71 E.00083
G1 X129.02 Y120.71 E.18383
G1 X129.02 Y135.29 E.28104
G1 X138.497 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.6 Y135.29 E-.03914
G1 X138.6 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.8 Y134.49 Z8.76 F60000
G1 Z8.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7154
M204 S4000
G1 X137.8 Y121.57 E.2259
M204 S10000
G1 X130.45 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7154
M204 S4000
G1 X130.211 Y121.482 E.00496
G1 X130.211 Y122.94 E.03024
G3 X131.701 Y121.482 I2.697 J1.266 E.04416
G1 X133.352 Y121.482 E.03425
G1 X133.462 Y121.559 E.0028
G1 X134.373 Y122.904 E.03368
G2 X136.194 Y123.848 I2.299 J-2.205 E.04332
G1 X136.649 Y123.834 E.00945
G2 X137.409 Y123.065 I-.622 J-1.376 E.02293
G1 X137.409 Y124.988 E.03988
G1 X137.104 Y125.201 E.00772
G1 X136.194 Y126.545 E.03368
G3 X134.373 Y127.49 I-2.299 J-2.205 E.04332
G1 X133.918 Y127.475 E.00945
G1 X133.462 Y127.158 E.01152
G1 X132.552 Y125.813 E.03368
G2 X130.731 Y124.869 I-2.299 J2.205 E.04332
G1 X130.211 Y124.928 E.01086
G1 X130.211 Y130.223 E.10982
G3 X132.552 Y128.51 I2.749 J1.301 E.06271
G1 X133.007 Y128.525 E.00945
G1 X133.462 Y128.842 E.01152
G1 X134.373 Y130.187 E.03368
G2 X136.194 Y131.131 I2.299 J-2.205 E.04332
G1 X136.649 Y131.117 E.00945
G2 X137.409 Y130.349 I-.622 J-1.376 E.02293
G1 X137.409 Y132.271 E.03988
G1 X137.104 Y132.484 E.00772
G1 X136.194 Y133.829 E.03368
G3 X135.283 Y134.5 I-2.061 J-1.84 E.02364
G1 X133.651 Y134.518 E.03385
G1 X133.462 Y134.441 E.00423
G1 X132.552 Y133.096 E.03368
G2 X130.731 Y132.152 I-2.299 J2.205 E.04332
G1 X130.211 Y132.212 E.01086
G1 X130.211 Y133.909 E.0352
M204 S10000
G1 X129.82 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7154
M204 S4000
G1 X129.82 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.82 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.571 Y121.119 Z8.76 F60000
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7154
M204 S4000
G1 X117.809 Y121.119 E.18174
G1 X117.809 Y134.881 E.28545
G1 X126.571 Y134.881 E.18174
G1 X126.571 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.98 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.443 Y120.71 E.18383
G1 X117.4 Y120.71 E.00083
G1 F3480
G1 X117.4 Y135.29 E.28104
G1 F3600
G1 X117.443 Y135.29 E.00083
G1 X126.98 Y135.29 E.18383
G1 X126.98 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.98 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.483 Y121.482 Z8.76 F60000
G1 Z8.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7154
M204 S4000
G1 X118.786 Y121.482 E.0352
G1 X118.896 Y121.559 E.0028
G1 X119.807 Y122.904 E.03368
G2 X122.083 Y123.834 I2.096 J-1.879 E.05278
G1 X122.538 Y123.516 E.01152
G1 X123.448 Y122.172 E.03368
G3 X124.418 Y121.482 I2.292 J2.196 E.02482
G1 X125.789 Y121.482 E.02845
G1 X125.789 Y126.581 E.10577
G2 X122.993 Y124.883 I-2.674 J1.252 E.07192
G1 X122.538 Y125.201 E.01152
G1 X121.627 Y126.545 E.03368
G3 X119.351 Y127.475 I-2.096 J-1.879 E.05278
G3 X118.591 Y126.707 I.623 J-1.376 E.02293
G1 X118.591 Y128.629 E.03988
G1 X118.896 Y128.842 E.00772
G1 X119.807 Y130.187 E.03368
G2 X122.083 Y131.117 I2.096 J-1.879 E.05278
G1 X122.538 Y130.799 E.01152
G1 X123.448 Y129.455 E.03368
G3 X125.724 Y128.525 I2.096 J1.879 E.05278
G1 X125.789 Y128.57 E.00164
G1 X125.789 Y133.864 E.10982
G2 X122.993 Y132.166 I-2.674 J1.252 E.07192
G1 X122.538 Y132.484 E.01152
G1 X121.627 Y133.829 E.03368
G3 X120.59 Y134.518 I-1.763 J-1.528 E.02615
G1 X119.085 Y134.518 E.03122
G1 X118.896 Y134.441 E.00423
G1 X118.591 Y133.99 E.01129
G1 X118.591 Y132.293 E.0352
M204 S10000
G1 X118.2 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7154
M204 S4000
G1 X118.2 Y121.57 E.2259
M204 S10000
G1 X126.18 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7154
M204 S4000
G1 X126.18 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.18 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L70
M991 S0 P69 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.76 I-.831 J.889 P1  F60000
G1 X138.275 Y134.881 Z8.76
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7092
M204 S4000
G1 X138.275 Y121.119 E.28545
G1 X129.513 Y121.119 E.18174
G1 X129.513 Y134.881 E.28545
G1 X138.215 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.641 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.684 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.684 Y120.71 E.28104
G1 F3600
G1 X138.641 Y120.71 E.00083
G1 X129.104 Y120.71 E.18383
G1 X129.104 Y135.29 E.28104
G1 X138.581 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.684 Y135.29 E-.03914
G1 X138.684 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.884 Y134.49 Z8.88 F60000
G1 Z8.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7092
M204 S4000
G1 X137.884 Y121.57 E.2259
M204 S10000
G1 X130.295 Y124.374 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7092
M204 S4000
G1 X130.295 Y122.677 E.0352
G3 X131.923 Y121.482 I2.191 J1.278 E.04309
G1 X133.061 Y121.482 E.02361
G1 X133.462 Y121.796 E.01056
G1 X134.373 Y122.951 E.03051
G2 X136.194 Y123.721 I1.972 J-2.126 E.04184
G1 X136.649 Y123.636 E.00961
G2 X137.493 Y122.786 I-1.321 J-2.156 E.02509
G1 X137.493 Y125.133 E.04869
G1 X137.104 Y125.438 E.01025
G1 X136.194 Y126.593 E.03051
G3 X134.373 Y127.363 I-1.972 J-2.126 E.04184
G3 X133.462 Y126.921 I-.03 J-1.097 E.02181
G1 X132.552 Y125.765 E.03051
G2 X130.731 Y124.996 I-1.972 J2.126 E.04184
G1 X130.295 Y125.078 E.0092
G1 X130.295 Y129.961 E.10129
G3 X132.552 Y128.637 I2.336 J1.398 E.05661
G3 X133.462 Y129.079 I.03 J1.097 E.02181
G1 X134.373 Y130.235 E.03051
G2 X136.194 Y131.004 I1.972 J-2.126 E.04184
G1 X136.649 Y130.919 E.00961
G2 X137.493 Y130.069 I-1.321 J-2.156 E.02509
G1 X137.493 Y132.416 E.04869
G1 X137.104 Y132.721 E.01025
G1 X136.194 Y133.876 E.03051
G3 X135.283 Y134.461 I-1.864 J-1.902 E.0226
G3 X133.863 Y134.518 I-.867 J-3.868 E.02964
G1 X133.462 Y134.204 E.01056
M73 P52 R10
G1 X132.552 Y133.049 E.03051
G2 X130.731 Y132.279 I-1.972 J2.126 E.04184
G1 X130.295 Y132.361 E.0092
G1 X130.295 Y134.058 E.0352
M204 S10000
G1 X129.904 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7092
M204 S4000
G1 X129.904 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.904 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.487 Y121.119 Z8.88 F60000
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7092
M204 S4000
G1 X117.725 Y121.119 E.18174
G1 X117.725 Y134.881 E.28545
G1 X126.487 Y134.881 E.18174
G1 X126.487 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.896 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.359 Y120.71 E.18383
G1 X117.316 Y120.71 E.00083
G1 F3480
G1 X117.316 Y135.29 E.28104
G1 F3600
G1 X117.359 Y135.29 E.00083
G1 X126.896 Y135.29 E.18383
G1 X126.896 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.896 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.195 Y121.482 Z8.88 F60000
G1 Z8.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7092
M204 S4000
G1 X118.507 Y121.482 E.03501
G1 X118.896 Y121.796 E.01037
G1 X119.807 Y122.951 E.03051
G2 X122.083 Y123.636 I1.781 J-1.796 E.05132
G1 X122.538 Y123.279 E.01199
G1 X123.448 Y122.124 E.03051
G3 X124.64 Y121.482 I1.708 J1.744 E.02845
G1 X125.705 Y121.482 E.02209
G1 X125.705 Y126.319 E.10033
G2 X122.993 Y125.081 I-2.224 J1.283 E.06597
G1 X122.538 Y125.438 E.01199
G1 X121.627 Y126.593 E.03051
G3 X119.351 Y127.277 I-1.781 J-1.796 E.05132
G3 X118.507 Y126.427 I1.321 J-2.156 E.0251
G1 X118.507 Y128.774 E.04869
G1 X118.896 Y129.079 E.01025
G1 X119.807 Y130.235 E.03051
G2 X122.083 Y130.919 I1.781 J-1.796 E.05132
G1 X122.538 Y130.562 E.01199
G1 X123.448 Y129.407 E.03051
G3 X125.705 Y128.719 I1.78 J1.795 E.05091
G1 X125.705 Y133.602 E.10128
G2 X122.993 Y132.364 I-2.224 J1.283 E.06597
G1 X122.538 Y132.721 E.01199
G1 X121.627 Y133.876 E.03051
G3 X120.403 Y134.518 I-1.653 J-1.664 E.0291
G1 X119.297 Y134.518 E.02295
G3 X118.507 Y133.71 I1.261 J-2.024 E.02366
G1 X118.507 Y132.013 E.0352
M204 S10000
G1 X118.116 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7092
M204 S4000
G1 X118.116 Y121.57 E.2259
M204 S10000
G1 X126.096 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7092
M204 S4000
G1 X126.096 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X126.096 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L71
M991 S0 P70 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.88 I-.825 J.895 P1  F60000
G1 X138.359 Y134.881 Z8.88
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7040
M204 S4000
G1 X138.359 Y121.119 E.28545
G1 X129.597 Y121.119 E.18174
G1 X129.597 Y134.881 E.28545
G1 X138.299 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.725 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.768 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.768 Y120.71 E.28104
G1 F3600
G1 X138.725 Y120.71 E.00083
G1 X129.188 Y120.71 E.18383
G1 X129.188 Y135.29 E.28104
G1 X138.665 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.768 Y135.29 E-.03914
G1 X138.768 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.968 Y134.49 Z9 F60000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7040
M204 S4000
G1 X137.968 Y121.57 E.2259
M204 S10000
G1 X130.379 Y124.167 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7040
M204 S4000
G1 X130.379 Y122.47 E.0352
G3 X133.007 Y121.604 I1.895 J1.331 E.06152
G3 X134.373 Y123.002 I-3.759 J5.039 E.0407
G2 X136.649 Y123.472 I1.544 J-1.733 E.05049
G2 X137.577 Y122.565 I-2.416 J-3.403 E.02702
G1 X137.577 Y125.24 E.05548
G2 X136.194 Y126.643 I3.902 J5.231 E.04103
G3 X133.918 Y127.113 I-1.544 J-1.733 E.05049
G3 X132.552 Y125.715 I3.76 J-5.04 E.0407
G2 X130.379 Y125.214 I-1.543 J1.731 E.04825
G1 X130.379 Y129.753 E.09414
G3 X133.007 Y128.887 I1.895 J1.331 E.06152
G3 X134.373 Y130.285 I-3.76 J5.039 E.0407
G2 X136.649 Y130.755 I1.544 J-1.733 E.05049
G2 X137.577 Y129.849 I-2.416 J-3.404 E.02702
G1 X137.577 Y132.523 E.05548
G2 X136.194 Y133.926 I3.902 J5.231 E.04103
G3 X133.918 Y134.396 I-1.546 J-1.739 E.05047
G3 X132.552 Y132.998 I3.76 J-5.039 E.0407
G2 X130.379 Y132.497 I-1.543 J1.731 E.04825
G1 X130.379 Y134.194 E.0352
M204 S10000
G1 X129.988 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7040
M204 S4000
G1 X129.988 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X129.988 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.403 Y121.119 Z9 F60000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7040
M204 S4000
G1 X117.641 Y121.119 E.18174
G1 X117.641 Y134.881 E.28545
G1 X126.403 Y134.881 E.18174
G1 X126.403 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.812 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.275 Y120.71 E.18383
G1 X117.232 Y120.71 E.00083
G1 F3480
G1 X117.232 Y135.29 E.28104
G1 F3600
G1 X117.275 Y135.29 E.00083
G1 X126.812 Y135.29 E.18383
G1 X126.812 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.812 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.004 Y121.482 Z9 F60000
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7040
M204 S4000
G1 X118.423 Y121.482 E.03279
G1 X118.441 Y121.604 E.00255
G3 X119.807 Y123.002 I-3.759 J5.039 E.0407
G2 X122.083 Y123.472 I1.544 J-1.733 E.05049
G2 X123.448 Y122.074 I-3.76 J-5.039 E.0407
G3 X125.621 Y121.482 I1.746 J2.126 E.04813
G1 X125.621 Y126.111 E.09602
G2 X122.993 Y125.245 I-1.895 J1.331 E.06151
G2 X121.627 Y126.643 I3.76 J5.039 E.0407
G3 X119.351 Y127.113 I-1.544 J-1.733 E.05049
G3 X118.423 Y126.207 I2.416 J-3.404 E.02702
G1 X118.441 Y128.887 E.05559
G3 X119.807 Y130.285 I-3.76 J5.039 E.0407
G2 X122.083 Y130.755 I1.544 J-1.733 E.05049
G2 X123.448 Y129.357 I-3.76 J-5.04 E.0407
G3 X125.621 Y128.856 I1.543 J1.731 E.04825
G1 X125.621 Y133.394 E.09414
G2 X122.993 Y132.529 I-1.895 J1.331 E.06151
G2 X121.627 Y133.926 I3.759 J5.039 E.0407
G3 X119.351 Y134.396 I-1.546 J-1.739 E.05047
G3 X118.423 Y133.49 I2.416 J-3.404 E.02702
G1 X118.423 Y131.793 E.0352
M204 S10000
G1 X118.032 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7040
M204 S4000
G1 X118.032 Y121.57 E.2259
M204 S10000
G1 X126.012 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7040
M204 S4000
G1 X126.012 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X126.012 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L72
M991 S0 P71 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9 I-.819 J.9 P1  F60000
G1 X138.443 Y134.881 Z9
G1 Z8.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X138.443 Y121.119 E.28545
G1 X129.681 Y121.119 E.18174
G1 X129.681 Y134.881 E.28545
G1 X138.383 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.809 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
M73 P52 R9
G1 X138.852 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.852 Y120.71 E.28104
G1 F3600
G1 X138.809 Y120.71 E.00083
G1 X129.272 Y120.71 E.18383
G1 X129.272 Y135.29 E.28104
G1 X138.749 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.852 Y135.29 E-.03914
G1 X138.852 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.052 Y134.49 Z9.12 F60000
G1 Z8.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X138.052 Y121.57 E.2259
M204 S10000
G1 X130.463 Y123.964 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X130.463 Y122.267 E.0352
G3 X133.007 Y121.745 I1.635 J1.513 E.05751
G3 X134.373 Y123.055 I-25.714 J28.186 E.03925
G2 X136.649 Y123.33 I1.367 J-1.757 E.04995
G2 X137.661 Y122.345 I-7.849 J-9.079 E.02931
G1 X137.661 Y125.347 E.06227
G2 X136.649 Y126.278 I2.026 J3.217 E.02869
G3 X134.373 Y127.151 I-1.937 J-1.65 E.05272
G3 X133.007 Y126.08 I1.058 J-2.756 E.03653
G2 X130.463 Y125.313 I-1.833 J1.478 E.05856
G1 X130.463 Y129.55 E.08788
G3 X133.007 Y129.029 I1.635 J1.512 E.05751
G3 X134.373 Y130.338 I-25.705 J28.178 E.03925
G2 X136.649 Y130.613 I1.367 J-1.757 E.04995
G2 X137.661 Y129.628 I-7.85 J-9.08 E.02931
G1 X137.661 Y132.63 E.06227
G2 X136.649 Y133.562 I2.025 J3.217 E.02869
G3 X134.373 Y134.434 I-1.937 J-1.65 E.05272
G3 X133.007 Y133.363 I1.058 J-2.756 E.03653
G2 X130.463 Y132.597 I-1.833 J1.478 E.05856
G1 X130.463 Y134.294 E.0352
M204 S10000
G1 X130.072 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X130.072 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.072 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.319 Y121.119 Z9.12 F60000
G1 Z8.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X117.557 Y121.119 E.18174
G1 X117.557 Y134.881 E.28545
G1 X126.319 Y134.881 E.18174
G1 X126.319 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.728 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.191 Y120.71 E.18383
G1 X117.148 Y120.71 E.00083
G1 F3480
G1 X117.148 Y135.29 E.28104
G1 F3600
G1 X117.191 Y135.29 E.00083
M73 P53 R9
G1 X126.728 Y135.29 E.18383
G1 X126.728 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.728 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.813 Y121.482 Z9.12 F60000
G1 Z8.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X118.339 Y121.482 E.03057
G1 X118.339 Y121.705 E.00463
G1 X118.441 Y121.745 E.00227
G3 X119.807 Y123.055 I-25.698 J28.17 E.03925
G2 X122.083 Y123.33 I1.367 J-1.757 E.04995
G2 X123.448 Y122.021 I-25.705 J-28.178 E.03925
G3 X125.537 Y121.672 I1.367 J1.756 E.04578
G1 X125.537 Y125.908 E.08788
G2 X122.993 Y125.387 I-1.635 J1.512 E.05751
G2 X121.627 Y126.696 I25.714 J28.186 E.03925
G3 X119.351 Y126.971 I-1.367 J-1.757 E.04995
G3 X118.339 Y125.986 I7.85 J-9.08 E.02932
G1 X118.339 Y128.988 E.06227
G1 X118.441 Y129.029 E.00227
G3 X119.807 Y130.338 I-25.69 J28.161 E.03925
G2 X122.083 Y130.613 I1.367 J-1.757 E.04995
G2 X123.448 Y129.304 I-25.714 J-28.186 E.03925
G3 X125.537 Y128.955 I1.367 J1.756 E.04578
G1 X125.537 Y133.191 E.08788
G2 X122.993 Y132.67 I-1.635 J1.512 E.05751
G2 X121.627 Y133.979 I25.705 J28.178 E.03925
G3 X119.351 Y134.255 I-1.367 J-1.757 E.04995
G3 X118.339 Y133.27 I7.852 J-9.082 E.02932
G1 X118.339 Y131.573 E.0352
M204 S10000
G1 X117.948 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X117.948 Y121.57 E.2259
M204 S10000
G1 X125.928 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6999
M204 S4000
G1 X125.928 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X125.928 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L73
M991 S0 P72 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.12 I-.813 J.906 P1  F60000
G1 X138.527 Y134.881 Z9.12
G1 Z8.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6975
M204 S4000
G1 X138.527 Y121.119 E.28545
G1 X129.765 Y121.119 E.18174
G1 X129.765 Y134.881 E.28545
G1 X138.467 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.893 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X138.936 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X138.936 Y120.71 E.28104
G1 F3600
G1 X138.893 Y120.71 E.00083
G1 X129.356 Y120.71 E.18383
G1 X129.356 Y135.29 E.28104
G1 X138.833 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X138.936 Y135.29 E-.03914
G1 X138.936 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.136 Y134.49 Z9.24 F60000
G1 Z8.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6975
M204 S4000
G1 X138.136 Y121.57 E.2259
M204 S10000
G1 X130.547 Y123.812 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6975
M204 S4000
G1 X130.547 Y122.115 E.0352
G3 X132.552 Y121.656 I1.469 J1.809 E.04419
G3 X133.918 Y122.739 I-1.612 J3.435 E.03648
G2 X136.649 Y123.204 I1.664 J-1.521 E.06188
G2 X137.745 Y122.184 I-67.641 J-73.815 E.03106
G1 X137.745 Y125.425 E.06722
G2 X136.649 Y126.381 I2.213 J3.645 E.03032
G3 X134.373 Y127.061 I-1.741 J-1.677 E.05151
G3 X133.007 Y125.978 I1.612 J-3.435 E.03648
G2 X130.547 Y125.385 I-1.671 J1.532 E.05569
G1 X130.547 Y129.398 E.08325
G3 X132.552 Y128.939 I1.469 J1.809 E.04419
G3 X133.918 Y130.022 I-1.612 J3.434 E.03648
G2 X136.649 Y130.487 I1.664 J-1.521 E.06188
G2 X137.745 Y129.467 I-67.758 J-73.941 E.03106
G1 X137.745 Y132.708 E.06722
G2 X136.649 Y133.664 I2.213 J3.645 E.03032
G3 X134.373 Y134.344 I-1.741 J-1.677 E.05151
G3 X133.007 Y133.261 I1.612 J-3.435 E.03648
G2 X130.547 Y132.668 I-1.671 J1.532 E.05569
G1 X130.547 Y134.365 E.0352
M204 S10000
G1 X130.156 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6975
M204 S4000
G1 X130.156 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.156 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.235 Y121.119 Z9.24 F60000
G1 Z8.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6975
M204 S4000
G1 X117.473 Y121.119 E.18174
G1 X117.473 Y134.881 E.28545
G1 X126.235 Y134.881 E.18174
G1 X126.235 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.644 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.107 Y120.71 E.18383
G1 X117.064 Y120.71 E.00083
G1 F3480
G1 X117.064 Y135.29 E.28104
G1 F3600
G1 X117.107 Y135.29 E.00083
G1 X126.644 Y135.29 E.18383
G1 X126.644 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.644 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.651 Y121.482 Z9.24 F60000
G1 Z8.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6975
M204 S4000
G1 X118.255 Y121.482 E.02895
G1 X118.255 Y121.783 E.00625
G3 X119.351 Y122.739 I-2.213 J3.645 E.03032
G2 X122.538 Y122.809 I1.625 J-1.414 E.07442
G3 X124.814 Y121.583 I2.338 J1.615 E.05566
G3 X125.453 Y121.743 I.047 J1.173 E.01385
G1 X125.453 Y125.756 E.08324
G2 X122.538 Y125.908 I-1.379 J1.579 E.06698
G3 X120.262 Y127.134 I-2.338 J-1.615 E.05566
G3 X118.896 Y126.45 I.18 J-2.066 E.03244
G2 X118.255 Y125.826 I-2.945 J2.382 E.01861
G1 X118.255 Y129.066 E.06722
G3 X119.351 Y130.022 I-2.212 J3.644 E.03032
G2 X122.538 Y130.092 I1.625 J-1.414 E.07442
G3 X124.814 Y128.867 I2.338 J1.615 E.05566
G3 X125.453 Y129.026 I.047 J1.173 E.01385
G1 X125.453 Y133.039 E.08324
G2 X122.538 Y133.191 I-1.379 J1.579 E.06698
G3 X120.262 Y134.417 I-2.338 J-1.615 E.05566
G3 X118.896 Y133.733 I.18 J-2.066 E.03244
G2 X118.255 Y133.109 I-2.945 J2.382 E.01861
G1 X118.255 Y131.412 E.0352
M204 S10000
G1 X117.864 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6975
M204 S4000
G1 X117.864 Y121.57 E.2259
M204 S10000
G1 X125.844 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6975
M204 S4000
G1 X125.844 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 8.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X125.844 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L74
M991 S0 P73 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.24 I-.807 J.911 P1  F60000
G1 X138.611 Y134.881 Z9.24
G1 Z8.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X138.611 Y121.119 E.28545
G1 X129.849 Y121.119 E.18174
G1 X129.849 Y134.881 E.28545
G1 X138.551 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X138.977 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.02 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.02 Y120.71 E.28104
G1 F3600
G1 X138.977 Y120.71 E.00083
G1 X129.44 Y120.71 E.18383
G1 X129.44 Y135.29 E.28104
G1 X138.917 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.02 Y135.29 E-.03914
G1 X139.02 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.22 Y134.49 Z9.36 F60000
G1 Z8.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X138.22 Y121.57 E.2259
M204 S10000
G1 X130.631 Y123.674 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X130.631 Y121.977 E.0352
G3 X132.552 Y121.737 I1.216 J1.922 E.04148
G3 X133.918 Y122.839 I-2.43 J4.406 E.0366
G2 X136.649 Y123.089 I1.522 J-1.579 E.06146
G3 X137.829 Y122.039 I12.694 J13.075 E.03278
G1 X137.829 Y125.48 E.07137
G2 X136.649 Y126.481 I2.811 J4.51 E.03222
G3 X133.462 Y126.324 I-1.519 J-1.581 E.0741
G2 X130.631 Y125.433 I-2.002 J1.417 E.06613
G1 X130.631 Y129.26 E.07937
G3 X132.552 Y129.02 I1.216 J1.922 E.04148
G3 X133.918 Y130.123 I-2.429 J4.405 E.0366
G2 X136.649 Y130.372 I1.522 J-1.579 E.06146
G3 X137.829 Y129.322 I12.692 J13.072 E.03278
G1 X137.829 Y132.763 E.07137
G2 X136.649 Y133.764 I2.811 J4.51 E.03222
G3 X133.462 Y133.607 I-1.519 J-1.581 E.0741
G2 X130.631 Y132.716 I-2.002 J1.417 E.06613
G1 X130.631 Y134.413 E.0352
M204 S10000
G1 X130.24 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X130.24 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.24 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.151 Y121.119 Z9.36 F60000
G1 Z8.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X117.389 Y121.119 E.18174
G1 X117.389 Y134.881 E.28545
G1 X126.151 Y134.881 E.18174
G1 X126.151 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.56 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X117.023 Y120.71 E.18383
G1 X116.98 Y120.71 E.00083
G1 F3480
G1 X116.98 Y135.29 E.28104
G1 F3600
G1 X117.023 Y135.29 E.00083
G1 X126.56 Y135.29 E.18383
G1 X126.56 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.56 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.512 Y121.482 Z9.36 F60000
G1 Z8.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X118.171 Y121.482 E.02781
G1 X118.171 Y121.838 E.00739
G3 X119.351 Y122.839 I-2.81 J4.509 E.03222
G2 X122.538 Y122.683 I1.519 J-1.581 E.0741
G3 X125.369 Y121.791 I2.002 J1.417 E.06612
G1 X125.369 Y125.618 E.07937
G2 X122.538 Y126.034 I-1.181 J1.806 E.0649
G3 X119.807 Y126.98 I-2.033 J-1.453 E.06393
G3 X118.441 Y125.878 I2.429 J-4.405 E.0366
G1 X118.171 Y125.68 E.00694
G1 X118.171 Y129.121 E.07137
G3 X119.351 Y130.123 I-2.81 J4.509 E.03222
M73 P54 R9
G2 X122.538 Y129.966 I1.519 J-1.581 E.0741
G3 X125.369 Y129.075 I2.002 J1.417 E.06612
G1 X125.369 Y132.901 E.07937
G2 X122.538 Y133.317 I-1.181 J1.806 E.0649
G3 X119.807 Y134.263 I-2.033 J-1.453 E.06393
G3 X118.441 Y133.161 I2.43 J-4.406 E.0366
G1 X118.171 Y132.963 E.00694
G1 X118.171 Y131.266 E.0352
M204 S10000
G1 X117.78 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X117.78 Y121.57 E.2259
M204 S10000
G1 X125.76 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6961
M204 S4000
G1 X125.76 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X125.76 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L75
M991 S0 P74 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.36 I-.801 J.916 P1  F60000
G1 X138.695 Y134.881 Z9.36
G1 Z9.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X138.695 Y121.119 E.28545
G1 X129.933 Y121.119 E.18174
G1 X129.933 Y134.881 E.28545
G1 X138.635 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.061 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.104 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.104 Y120.71 E.28104
G1 F3600
G1 X139.061 Y120.71 E.00083
G1 X129.524 Y120.71 E.18383
G1 X129.524 Y135.29 E.28104
G1 X139.001 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.104 Y135.29 E-.03914
G1 X139.104 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.304 Y134.49 Z9.48 F60000
G1 Z9.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X138.304 Y121.57 E.2259
M204 S10000
G1 X130.715 Y123.545 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X130.715 Y121.848 E.0352
G3 X133.462 Y122.514 I.955 J2.061 E.06328
G2 X136.649 Y122.982 I1.826 J-1.352 E.07424
G3 X137.913 Y121.904 I6.226 J6.02 E.03452
G1 X137.913 Y125.515 E.0749
G2 X137.104 Y126.155 I1.265 J2.429 E.02153
G3 X133.462 Y126.203 I-1.839 J-1.379 E.08719
G2 X130.715 Y125.462 I-1.85 J1.393 E.06356
G1 X130.715 Y129.132 E.07612
G3 X133.462 Y129.797 I.955 J2.061 E.06328
G2 X136.649 Y130.265 I1.826 J-1.352 E.07424
G3 X137.913 Y129.187 I6.226 J6.021 E.03452
G1 X137.913 Y132.798 E.0749
G2 X137.104 Y133.438 I1.265 J2.429 E.02153
G3 X133.462 Y133.486 I-1.839 J-1.379 E.08719
G2 X130.715 Y132.745 I-1.85 J1.393 E.06356
G1 X130.715 Y134.442 E.0352
M204 S10000
G1 X130.324 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X130.324 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.324 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.067 Y121.119 Z9.48 F60000
G1 Z9.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X117.305 Y121.119 E.18174
G1 X117.305 Y134.881 E.28545
G1 X126.067 Y134.881 E.18174
G1 X126.067 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.476 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.939 Y120.71 E.18383
G1 X116.896 Y120.71 E.00083
G1 F3480
G1 X116.896 Y135.29 E.28104
G1 F3600
G1 X116.939 Y135.29 E.00083
G1 X126.476 Y135.29 E.18383
G1 X126.476 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.476 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.393 Y121.482 Z9.48 F60000
G1 Z9.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6961
M204 S4000
G1 X118.087 Y121.482 E.02709
G1 X118.087 Y121.873 E.00811
G3 X119.351 Y122.941 I-4.033 J6.059 E.0344
G2 X122.538 Y122.562 I1.407 J-1.751 E.07414
G3 X125.285 Y121.82 I1.85 J1.393 E.06356
G1 X125.285 Y125.49 E.07612
G2 X122.538 Y126.155 I-.955 J2.061 E.06328
G3 X118.896 Y126.203 I-1.839 J-1.379 E.08719
G2 X118.087 Y125.545 I-2.255 J1.947 E.02174
G1 X118.087 Y129.156 E.0749
G3 X119.351 Y130.224 I-4.032 J6.058 E.0344
G2 X122.538 Y129.845 I1.407 J-1.751 E.07414
G3 X125.285 Y129.103 I1.85 J1.393 E.06356
G1 X125.285 Y132.773 E.07612
G2 X122.538 Y133.438 I-.955 J2.061 E.06328
G3 X118.896 Y133.486 I-1.839 J-1.379 E.08719
G2 X118.087 Y132.829 I-2.255 J1.947 E.02174
G1 X118.087 Y131.132 E.0352
M204 S10000
G1 X117.696 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6961
M204 S4000
G1 X117.696 Y121.57 E.2259
M204 S10000
G1 X125.676 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6961
M204 S4000
G1 X125.676 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X125.676 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L76
M991 S0 P75 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.48 I-.795 J.921 P1  F60000
G1 X138.779 Y134.881 Z9.48
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6953
M204 S4000
G1 X138.779 Y121.119 E.28545
G1 X130.017 Y121.119 E.18174
G1 X130.017 Y134.881 E.28545
G1 X138.719 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.145 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.188 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.188 Y120.71 E.28104
G1 F3600
G1 X139.145 Y120.71 E.00083
G1 X129.608 Y120.71 E.18383
G1 X129.608 Y135.29 E.28104
G1 X139.085 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.188 Y135.29 E-.03914
G1 X139.188 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.388 Y134.49 Z9.6 F60000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6953
M204 S4000
G1 X138.388 Y121.57 E.2259
M204 S10000
G1 X136.595 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6953
M204 S4000
G1 X137.997 Y121.482 E.02909
G1 X137.997 Y121.777 E.00611
G2 X136.649 Y122.88 I2.905 J4.927 E.03627
G3 X133.462 Y122.634 I-1.476 J-1.648 E.07408
G2 X130.799 Y121.749 I-1.953 J1.425 E.06211
G1 X130.799 Y125.493 E.07766
G3 X133.462 Y126.083 I.969 J1.931 E.06124
G2 X136.649 Y126.687 I1.911 J-1.375 E.07421
G3 X137.997 Y125.532 I8.07 J8.05 E.03687
G1 X137.997 Y129.06 E.07319
G2 X136.649 Y130.163 I2.904 J4.926 E.03627
G3 X133.462 Y129.917 I-1.476 J-1.648 E.07408
G2 X130.799 Y129.032 I-1.953 J1.425 E.06212
G1 X130.799 Y132.776 E.07766
G3 X133.462 Y133.366 I.969 J1.931 E.06124
G2 X136.649 Y133.971 I1.911 J-1.375 E.07421
G3 X137.997 Y132.815 I8.067 J8.046 E.03687
G1 X137.997 Y131.118 E.0352
M204 S10000
G1 X130.408 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6953
M204 S4000
G1 X130.408 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.408 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.983 Y121.119 Z9.6 F60000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6953
M204 S4000
G1 X117.221 Y121.119 E.18174
G1 X117.221 Y134.881 E.28545
G1 X125.983 Y134.881 E.18174
G1 X125.983 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.392 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.855 Y120.71 E.18383
G1 X116.812 Y120.71 E.00083
G1 F3480
G1 X116.812 Y135.29 E.28104
G1 F3600
G1 X116.855 Y135.29 E.00083
G1 X126.392 Y135.29 E.18383
G1 X126.392 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.392 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.201 Y123.548 Z9.6 F60000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6953
M204 S4000
G1 X125.201 Y121.851 E.0352
G2 X122.538 Y122.441 I-.969 J1.931 E.06124
G3 X119.351 Y123.046 I-1.911 J-1.375 E.07421
G2 X118.003 Y121.89 I-8.069 J8.048 E.03688
G1 X118.003 Y125.418 E.07319
G3 X119.351 Y126.521 I-2.904 J4.927 E.03627
G2 X122.538 Y126.276 I1.476 J-1.648 E.07408
G3 X125.201 Y125.39 I1.953 J1.425 E.06211
G1 X125.201 Y129.134 E.07766
G2 X122.538 Y129.724 I-.969 J1.931 E.06124
G3 X119.351 Y130.329 I-1.911 J-1.375 E.07421
G2 X118.003 Y129.173 I-8.068 J8.047 E.03688
G1 X118.003 Y132.701 E.07319
G3 X119.351 Y133.804 I-2.904 J4.927 E.03627
G2 X122.538 Y133.559 I1.476 J-1.648 E.07408
G3 X125.201 Y132.673 I1.953 J1.425 E.06211
G1 X125.201 Y134.37 E.0352
M204 S10000
G1 X125.592 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6953
M204 S4000
G1 X125.592 Y121.57 E.2259
M204 S10000
G1 X117.612 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F6953
M204 S4000
G1 X117.612 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.612 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L77
M991 S0 P76 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.6 I-.572 J1.074 P1  F60000
G1 X138.863 Y134.881 Z9.6
G1 Z9.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X138.863 Y121.119 E.28545
G1 X130.101 Y121.119 E.18174
G1 X130.101 Y134.881 E.28545
G1 X138.803 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.229 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.272 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
M73 P55 R9
G1 X139.272 Y120.71 E.28104
G1 F3600
G1 X139.229 Y120.71 E.00083
G1 X129.692 Y120.71 E.18383
G1 X129.692 Y135.29 E.28104
G1 X139.169 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.272 Y135.29 E-.03914
G1 X139.272 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.472 Y134.49 Z9.72 F60000
G1 Z9.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X138.472 Y121.57 E.2259
M204 S10000
G1 X136.578 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X138.081 Y121.482 E.03117
G1 X138.081 Y121.676 E.00403
G1 X138.014 Y121.689 E.00141
G2 X136.649 Y122.779 I1.896 J3.775 E.03651
G3 X134.373 Y123.386 I-1.67 J-1.689 E.05112
G3 X133.007 Y122.296 I1.896 J-3.775 E.03651
G2 X130.883 Y121.66 I-1.656 J1.664 E.0479
G1 X130.883 Y125.51 E.07985
G3 X132.552 Y125.331 I1.044 J1.86 E.03579
G3 X133.918 Y126.421 I-1.896 J3.776 E.03651
G2 X137.104 Y126.399 I1.583 J-1.482 E.07424
G3 X138.081 Y125.55 I3.649 J3.213 E.02693
G1 X138.081 Y128.959 E.07071
G1 X138.014 Y128.972 E.00141
G2 X136.649 Y130.062 I1.896 J3.775 E.03651
G3 X134.373 Y130.67 I-1.67 J-1.689 E.05112
G3 X133.007 Y129.579 I1.896 J-3.776 E.03651
G2 X130.883 Y128.943 I-1.656 J1.664 E.0479
G1 X130.883 Y132.793 E.07986
G3 X132.552 Y132.614 I1.044 J1.859 E.03579
G3 X133.918 Y133.704 I-1.896 J3.775 E.03651
G2 X137.104 Y133.682 I1.583 J-1.482 E.07424
G3 X138.081 Y132.833 I3.648 J3.212 E.02693
G1 X138.081 Y131.136 E.0352
M204 S10000
G1 X130.492 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X130.492 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.492 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.899 Y121.119 Z9.72 F60000
G1 Z9.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X117.137 Y121.119 E.18174
G1 X117.137 Y134.881 E.28545
G1 X125.899 Y134.881 E.18174
G1 X125.899 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.308 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.771 Y120.71 E.18383
G1 X116.728 Y120.71 E.00083
G1 F3480
G1 X116.728 Y135.29 E.28104
G1 F3600
G1 X116.771 Y135.29 E.00083
G1 X126.308 Y135.29 E.18383
G1 X126.308 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.308 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.117 Y123.565 Z9.72 F60000
G1 Z9.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X125.117 Y121.868 E.0352
G2 X122.538 Y122.318 I-1.016 J1.797 E.05883
G3 X120.262 Y123.473 I-2.239 J-1.591 E.05506
G3 X118.896 Y122.758 I.272 J-2.18 E.03268
G2 X117.919 Y121.909 I-3.647 J3.211 E.02693
G1 X117.919 Y125.318 E.07071
G3 X118.896 Y125.959 I-.839 J2.343 E.02448
G2 X121.172 Y127.115 I2.239 J-1.591 E.05506
G2 X122.538 Y126.399 I-.272 J-2.18 E.03268
G3 X124.814 Y125.244 I2.239 J1.591 E.05506
G1 X125.117 Y125.302 E.0064
G1 X125.117 Y129.151 E.07985
G2 X122.538 Y129.601 I-1.016 J1.797 E.05883
G3 X120.262 Y130.756 I-2.239 J-1.591 E.05506
G3 X118.896 Y130.041 I.272 J-2.18 E.03268
G2 X117.919 Y129.192 I-3.647 J3.211 E.02693
G1 X117.919 Y132.601 E.07071
G3 X118.896 Y133.242 I-.839 J2.342 E.02448
G2 X121.172 Y134.398 I2.239 J-1.591 E.05506
G2 X122.538 Y133.682 I-.272 J-2.18 E.03268
G3 X124.814 Y132.527 I2.239 J1.591 E.05506
G1 X125.117 Y132.585 E.0064
G1 X125.117 Y134.282 E.0352
M204 S10000
G1 X125.508 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X125.508 Y121.57 E.2259
M204 S10000
G1 X117.528 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F6977
M204 S4000
G1 X117.528 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.528 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L78
M991 S0 P77 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.72 I-.568 J1.076 P1  F60000
G1 X138.947 Y134.881 Z9.72
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X138.947 Y121.119 E.28545
G1 X130.185 Y121.119 E.18174
G1 X130.185 Y134.881 E.28545
G1 X138.887 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.313 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.356 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.356 Y120.71 E.28104
G1 F3600
G1 X139.313 Y120.71 E.00083
G1 X129.776 Y120.71 E.18383
G1 X129.776 Y135.29 E.28104
G1 X139.253 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.356 Y135.29 E-.03914
G1 X139.356 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.556 Y134.49 Z9.84 F60000
G1 Z9.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X138.556 Y121.57 E.2259
M204 S10000
G1 X136.572 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X138.165 Y121.482 E.03303
G1 X138.165 Y121.587 E.00217
G1 X138.014 Y121.603 E.00314
G2 X136.649 Y122.678 I1.257 J3.002 E.03649
G3 X134.373 Y123.472 I-1.856 J-1.661 E.05219
G3 X133.007 Y122.397 I1.257 J-3.002 E.03649
G2 X130.967 Y121.577 I-1.846 J1.646 E.04726
G1 X130.967 Y125.508 E.08154
G3 X132.552 Y125.245 I1.122 J1.852 E.03414
G3 X133.918 Y126.32 I-1.257 J3.002 E.03649
G2 X136.649 Y126.92 I1.759 J-1.489 E.06232
G3 X138.165 Y125.556 I29.5 J31.27 E.04231
G1 X138.165 Y128.87 E.06874
G1 X138.014 Y128.886 E.00314
G2 X136.649 Y129.961 I1.257 J3.002 E.03649
G3 X134.373 Y130.755 I-1.856 J-1.661 E.05219
G3 X133.007 Y129.68 I1.257 J-3.002 E.03649
G2 X130.967 Y128.86 I-1.846 J1.646 E.04726
G1 X130.967 Y132.791 E.08154
G3 X132.552 Y132.528 I1.122 J1.852 E.03414
G3 X133.918 Y133.603 I-1.257 J3.002 E.03649
G2 X136.649 Y134.203 I1.759 J-1.489 E.06232
G3 X138.165 Y132.839 I29.518 J31.291 E.04231
G1 X138.165 Y131.142 E.0352
M204 S10000
G1 X130.576 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X130.576 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.576 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.815 Y121.119 Z9.84 F60000
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X117.053 Y121.119 E.18174
G1 X117.053 Y134.881 E.28545
G1 X125.815 Y134.881 E.18174
G1 X125.815 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.224 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.687 Y120.71 E.18383
G1 X116.644 Y120.71 E.00083
G1 F3480
G1 X116.644 Y135.29 E.28104
G1 F3600
G1 X116.687 Y135.29 E.00083
G1 X126.224 Y135.29 E.18383
G1 X126.224 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.224 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.033 Y123.564 Z9.84 F60000
G1 Z9.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X125.033 Y121.867 E.0352
G2 X122.538 Y122.187 I-1.059 J1.635 E.05673
G3 X120.717 Y123.473 I-3.014 J-2.334 E.04693
G3 X118.896 Y122.889 I-.426 J-1.802 E.04168
G2 X117.835 Y121.914 I-3.803 J3.075 E.03
G1 X117.835 Y125.228 E.06874
G3 X118.896 Y125.828 I-.353 J1.863 E.02574
G2 X120.717 Y127.114 I3.014 J-2.335 E.04693
G2 X122.538 Y126.53 I.426 J-1.802 E.04168
G3 X124.359 Y125.244 I3.014 J2.335 E.04693
G3 X125.033 Y125.219 I.395 J1.512 E.01411
G1 X125.033 Y129.15 E.08154
G2 X122.538 Y129.47 I-1.059 J1.635 E.05673
G3 X120.717 Y130.756 I-3.014 J-2.335 E.04693
G3 X118.896 Y130.172 I-.426 J-1.802 E.04168
G2 X117.835 Y129.197 I-3.802 J3.075 E.03
G1 X117.835 Y132.511 E.06874
G3 X118.896 Y133.111 I-.353 J1.863 E.02574
G2 X120.717 Y134.397 I3.014 J-2.335 E.04693
G2 X122.538 Y133.814 I.426 J-1.802 E.04168
G3 X124.359 Y132.527 I3.014 J2.335 E.04693
G3 X125.033 Y132.502 I.395 J1.512 E.01411
G1 X125.033 Y134.199 E.0352
M204 S10000
G1 X125.424 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X125.424 Y121.57 E.2259
M204 S10000
G1 X117.444 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F6999
M204 S4000
G1 X117.444 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.56
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X117.444 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L79
M991 S0 P78 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.84 I-.565 J1.078 P1  F60000
G1 X139.031 Y134.881 Z9.84
G1 Z9.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X139.031 Y121.119 E.28545
G1 X130.269 Y121.119 E.18174
G1 X130.269 Y134.881 E.28545
G1 X138.971 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.397 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.44 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.44 Y120.71 E.28104
G1 F3600
G1 X139.397 Y120.71 E.00083
G1 X129.86 Y120.71 E.18383
G1 X129.86 Y135.29 E.28104
G1 X139.337 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.44 Y135.29 E-.03914
G1 X139.44 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.64 Y134.49 Z9.96 F60000
G1 Z9.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X138.64 Y121.57 E.2259
M204 S10000
G1 X138.249 Y123.199 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X138.249 Y121.502 E.0352
G2 X137.559 Y121.663 I-.089 J1.18 E.01492
G2 X136.194 Y123.022 I4.581 J5.966 E.04008
M73 P56 R9
G3 X133.918 Y123.413 I-1.469 J-1.736 E.05024
G3 X132.552 Y122.053 I4.582 J-5.967 E.04008
G2 X131.051 Y121.5 I-1.547 J1.886 E.0338
G1 X131.051 Y125.487 E.0827
G3 X133.007 Y125.304 I1.16 J1.85 E.04227
G3 X134.373 Y126.664 I-4.581 J5.966 E.04008
G2 X136.649 Y127.054 I1.469 J-1.736 E.05024
G2 X138.014 Y125.695 I-4.583 J-5.968 E.04009
G1 X138.249 Y125.542 E.0058
G1 X138.249 Y128.785 E.06727
G2 X137.559 Y128.946 I-.089 J1.18 E.01492
G2 X136.194 Y130.306 I4.582 J5.967 E.04009
G3 X133.918 Y130.696 I-1.469 J-1.736 E.05024
G3 X132.552 Y129.336 I4.582 J-5.967 E.04008
G2 X131.051 Y128.783 I-1.547 J1.886 E.0338
G1 X131.051 Y132.77 E.0827
G3 X133.007 Y132.587 I1.16 J1.851 E.04227
G3 X134.373 Y133.947 I-4.581 J5.966 E.04008
G2 X136.649 Y134.338 I1.469 J-1.736 E.05024
G2 X138.014 Y132.978 I-4.582 J-5.967 E.04008
G1 X138.249 Y132.825 E.0058
G1 X138.249 Y131.128 E.0352
M204 S10000
G1 X130.66 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X130.66 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.66 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.731 Y121.119 Z9.96 F60000
G1 Z9.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X116.969 Y121.119 E.18174
G1 X116.969 Y134.881 E.28545
G1 X125.731 Y134.881 E.18174
G1 X125.731 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.14 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.603 Y120.71 E.18383
G1 X116.56 Y120.71 E.00083
G1 F3480
G1 X116.56 Y135.29 E.28104
G1 F3600
G1 X116.603 Y135.29 E.00083
G1 X126.14 Y135.29 E.18383
G1 X126.14 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.14 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.949 Y123.542 Z9.96 F60000
G1 Z9.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X124.949 Y121.845 E.0352
G2 X122.993 Y121.663 I-1.16 J1.851 E.04227
G2 X121.627 Y123.022 I4.581 J5.966 E.04008
G3 X119.351 Y123.413 I-1.469 J-1.736 E.05024
G3 X117.986 Y122.053 I4.582 J-5.967 E.04008
G1 X117.751 Y121.901 E.00581
G1 X117.751 Y125.144 E.06727
G3 X118.896 Y125.683 I-.046 J1.582 E.02701
G1 X119.807 Y126.664 E.02776
G2 X122.083 Y127.054 I1.469 J-1.736 E.05024
G2 X123.448 Y125.695 I-4.583 J-5.968 E.04009
G3 X124.949 Y125.141 I1.547 J1.886 E.0338
G1 X124.949 Y129.128 E.0827
G2 X122.993 Y128.946 I-1.16 J1.851 E.04227
G2 X121.627 Y130.306 I4.582 J5.967 E.04009
G3 X119.351 Y130.696 I-1.469 J-1.736 E.05024
G3 X117.986 Y129.336 I4.582 J-5.967 E.04008
G1 X117.751 Y129.184 E.00581
G1 X117.751 Y132.427 E.06727
G3 X118.896 Y132.966 I-.046 J1.582 E.02701
G1 X119.807 Y133.947 E.02776
G2 X122.083 Y134.338 I1.469 J-1.736 E.05024
G2 X123.448 Y132.978 I-4.582 J-5.967 E.04008
G3 X124.949 Y132.425 I1.547 J1.886 E.0338
G1 X124.949 Y134.122 E.0352
M204 S10000
G1 X125.34 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X125.34 Y121.57 E.2259
M204 S10000
G1 X117.36 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7035
M204 S4000
G1 X117.36 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.36 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L80
M991 S0 P79 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.96 I-.561 J1.08 P1  F60000
G1 X139.115 Y134.881 Z9.96
G1 Z9.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7066
M204 S4000
G1 X139.115 Y121.119 E.28545
G1 X130.353 Y121.119 E.18174
G1 X130.353 Y134.881 E.28545
G1 X139.055 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.481 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.524 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.524 Y120.71 E.28104
G1 F3600
G1 X139.481 Y120.71 E.00083
G1 X129.944 Y120.71 E.18383
G1 X129.944 Y135.29 E.28104
G1 X139.421 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.524 Y135.29 E-.03914
G1 X139.524 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.724 Y134.49 Z10.08 F60000
G1 Z9.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7066
M204 S4000
G1 X138.724 Y121.57 E.2259
M204 S10000
G1 X135.973 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7066
M204 S4000
G1 X137.67 Y121.482 E.0352
G1 X137.559 Y121.508 E.00237
G1 X137.104 Y121.873 E.0121
G1 X136.194 Y122.971 E.02959
G3 X134.828 Y123.643 I-1.96 J-2.258 E.03192
G3 X133.462 Y123.202 I-.295 J-1.421 E.03114
G1 X132.552 Y122.104 E.02959
G2 X131.135 Y121.482 I-1.71 J1.969 E.03259
G1 X131.135 Y125.445 E.0822
G3 X132.097 Y125.074 I1.654 J2.855 E.02147
G3 X133.462 Y125.515 I.295 J1.421 E.03114
G1 X134.373 Y126.613 E.02959
G2 X135.738 Y127.285 I1.96 J-2.258 E.03192
G2 X137.104 Y126.844 I.295 J-1.421 E.03114
G1 X138.014 Y125.746 E.02959
G1 X138.333 Y125.508 E.00825
G1 X138.333 Y128.706 E.06633
G2 X137.104 Y129.156 I-.194 J1.373 E.02828
G1 X136.194 Y130.254 E.02959
G3 X134.828 Y130.926 I-1.96 J-2.259 E.03192
G3 X133.462 Y130.485 I-.295 J-1.421 E.03114
G1 X132.552 Y129.387 E.02959
G2 X131.135 Y128.712 I-1.785 J1.919 E.03307
G1 X131.135 Y132.728 E.08331
G3 X132.097 Y132.357 I1.654 J2.854 E.02147
G3 X133.462 Y132.798 I.295 J1.421 E.03114
G1 X134.373 Y133.896 E.02959
G2 X135.549 Y134.518 I1.891 J-2.152 E.02786
G1 X136.649 Y134.492 E.02281
G1 X137.104 Y134.127 E.0121
G1 X138.014 Y133.029 E.02959
G1 X138.333 Y132.791 E.00825
G1 X138.333 Y131.094 E.0352
M204 S10000
G1 X130.744 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7066
M204 S4000
G1 X130.744 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.744 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.647 Y121.119 Z10.08 F60000
G1 Z9.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7066
M204 S4000
G1 X116.885 Y121.119 E.18174
G1 X116.885 Y134.881 E.28545
G1 X125.647 Y134.881 E.18174
G1 X125.647 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X126.056 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.519 Y120.71 E.18383
G1 X116.476 Y120.71 E.00083
G1 F3480
G1 X116.476 Y135.29 E.28104
G1 F3600
G1 X116.519 Y135.29 E.00083
G1 X126.056 Y135.29 E.18383
G1 X126.056 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X124.056 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.865 Y123.5 Z10.08 F60000
G1 Z9.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7066
M204 S4000
G1 X124.865 Y121.803 E.0352
G2 X123.104 Y121.482 I-1.388 J2.621 E.03772
G1 X122.993 Y121.508 E.00237
G1 X122.538 Y121.873 E.0121
G1 X121.627 Y122.971 E.02959
G3 X119.351 Y123.567 I-1.674 J-1.749 E.05096
G1 X118.896 Y123.202 E.0121
G1 X117.986 Y122.104 E.02959
G1 X117.667 Y121.867 E.00825
G1 X117.667 Y125.064 E.06633
G3 X118.896 Y125.515 I.194 J1.373 E.02828
G1 X119.807 Y126.613 E.02959
G2 X122.083 Y127.209 I1.674 J-1.749 E.05096
G1 X122.538 Y126.844 E.0121
G1 X123.448 Y125.746 E.02959
G3 X124.865 Y125.07 I1.785 J1.919 E.03307
G1 X124.865 Y129.086 E.08331
G2 X122.993 Y128.792 I-1.271 J1.98 E.04046
G1 X122.538 Y129.156 E.0121
G1 X121.627 Y130.254 E.02959
G3 X119.351 Y130.85 I-1.674 J-1.749 E.05096
G1 X118.896 Y130.485 E.0121
G1 X117.986 Y129.387 E.02959
G1 X117.667 Y129.15 E.00825
G1 X117.667 Y132.347 E.06633
G3 X118.896 Y132.798 I.194 J1.373 E.02828
G1 X119.807 Y133.896 E.02959
G2 X121.972 Y134.518 I1.764 J-2.062 E.04819
G1 X122.083 Y134.492 E.00236
G1 X122.538 Y134.127 E.0121
G1 X123.448 Y133.029 E.02959
G3 X124.865 Y132.353 I1.785 J1.919 E.03307
G1 X124.865 Y134.05 E.0352
M204 S10000
G1 X125.256 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7066
M204 S4000
G1 X125.256 Y121.57 E.2259
M204 S10000
G1 X117.276 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7066
M204 S4000
G1 X117.276 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.276 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L81
M991 S0 P80 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.08 I-.558 J1.082 P1  F60000
G1 X139.199 Y134.881 Z10.08
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7125
M204 S4000
G1 X139.199 Y121.119 E.28545
G1 X130.437 Y121.119 E.18174
G1 X130.437 Y134.881 E.28545
G1 X139.139 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.565 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.608 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.608 Y120.71 E.28104
G1 F3600
G1 X139.565 Y120.71 E.00083
G1 X130.028 Y120.71 E.18383
G1 X130.028 Y135.29 E.28104
G1 X139.505 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.608 Y135.29 E-.03914
G1 X139.608 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.808 Y134.49 Z10.2 F60000
G1 Z9.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7125
M204 S4000
G1 X138.808 Y121.57 E.2259
M204 S10000
G1 X135.651 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7125
M204 S4000
G1 X137.348 Y121.482 E.0352
G1 X137.104 Y121.663 E.00631
G1 X136.194 Y122.923 E.03223
G3 X134.373 Y123.796 I-2.16 J-2.169 E.04268
G1 X133.918 Y123.75 E.00949
G1 X133.462 Y123.412 E.01176
G1 X132.552 Y122.153 E.03223
G1 X132.097 Y121.765 E.0124
G2 X131.219 Y121.482 I-.753 J.832 E.01971
G1 X131.219 Y125.389 E.08104
G3 X132.552 Y124.921 I1.598 J2.422 E.0296
G1 X133.007 Y124.967 E.00949
G1 X133.462 Y125.305 E.01176
G1 X134.373 Y126.564 E.03223
G2 X136.194 Y127.437 I2.16 J-2.169 E.04268
G1 X136.649 Y127.391 E.00949
G1 X137.104 Y127.054 E.01176
G1 X138.014 Y125.794 E.03223
G1 X138.417 Y125.452 E.01097
G1 X138.417 Y128.668 E.06671
G2 X137.559 Y128.609 I-.509 J1.13 E.01822
G1 X137.104 Y128.946 E.01176
G1 X136.194 Y130.206 E.03223
G3 X134.373 Y131.079 I-2.16 J-2.169 E.04268
G1 X133.918 Y131.033 E.00949
G1 X133.462 Y130.695 E.01176
G1 X132.552 Y129.436 E.03223
G2 X131.219 Y128.69 I-1.883 J1.8 E.03216
G1 X131.219 Y132.672 E.0826
G3 X132.552 Y132.205 I1.598 J2.423 E.0296
G1 X133.007 Y132.25 E.00949
G1 X133.462 Y132.588 E.01176
G1 X134.373 Y133.847 E.03223
G2 X135.502 Y134.518 I1.643 J-1.48 E.02765
G1 X136.82 Y134.518 E.02734
G1 X137.104 Y134.337 E.00699
G1 X138.014 Y133.078 E.03223
G1 X138.417 Y132.735 E.01097
G1 X138.417 Y131.038 E.0352
M204 S10000
G1 X130.828 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7125
M204 S4000
G1 X130.828 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.828 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.563 Y121.119 Z10.2 F60000
G1 Z9.8
M73 P57 R9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7125
M204 S4000
G1 X116.801 Y121.119 E.18174
G1 X116.801 Y134.881 E.28545
G1 X125.563 Y134.881 E.18174
G1 X125.563 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.972 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.435 Y120.71 E.18383
G1 X116.392 Y120.71 E.00083
G1 F3480
G1 X116.392 Y135.29 E.28104
G1 F3600
G1 X116.435 Y135.29 E.00083
G1 X125.972 Y135.29 E.18383
G1 X125.972 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.972 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.781 Y123.444 Z10.2 F60000
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7125
M204 S4000
G1 X124.781 Y121.747 E.0352
G2 X124.226 Y121.482 I-.806 J.973 E.01289
G1 X122.782 Y121.482 E.02996
G1 X122.538 Y121.663 E.00631
G1 X121.627 Y122.923 E.03223
G3 X119.351 Y123.75 I-1.956 J-1.836 E.05212
G1 X118.896 Y123.412 E.01176
G1 X117.986 Y122.153 E.03223
G1 X117.583 Y121.81 E.01097
G1 X117.583 Y125.026 E.06671
G3 X118.896 Y125.305 I.459 J1.069 E.02968
G1 X119.807 Y126.564 E.03223
G2 X122.083 Y127.391 I1.956 J-1.836 E.05212
G1 X122.538 Y127.054 E.01176
G1 X123.448 Y125.794 E.03223
G3 X124.781 Y125.048 I1.883 J1.8 E.03216
G1 X124.781 Y129.031 E.0826
G2 X122.993 Y128.609 I-1.452 J2.156 E.03895
G1 X122.538 Y128.946 E.01176
G1 X121.627 Y130.206 E.03223
G3 X119.351 Y131.033 I-1.956 J-1.836 E.05212
G1 X118.896 Y130.695 E.01176
G1 X117.986 Y129.436 E.03223
G1 X117.583 Y129.093 E.01097
G1 X117.583 Y132.309 E.06671
G3 X118.896 Y132.588 I.459 J1.069 E.02968
G1 X119.807 Y133.847 E.03223
G2 X120.935 Y134.518 I1.643 J-1.48 E.02765
G1 X122.253 Y134.518 E.02734
G1 X122.538 Y134.337 E.00699
G1 X123.448 Y133.078 E.03223
G3 X124.781 Y132.331 I1.883 J1.8 E.03216
G1 X124.781 Y134.028 E.0352
M204 S10000
G1 X125.172 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7125
M204 S4000
G1 X125.172 Y121.57 E.2259
M204 S10000
G1 X117.192 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7125
M204 S4000
G1 X117.192 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 9.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.192 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L82
M991 S0 P81 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.2 I-.555 J1.083 P1  F60000
G1 X139.283 Y134.881 Z10.2
G1 Z9.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7215
M204 S4000
G1 X139.283 Y121.119 E.28545
G1 X130.521 Y121.119 E.18174
G1 X130.521 Y134.881 E.28545
G1 X139.223 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.649 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.692 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.692 Y120.71 E.28104
G1 F3600
G1 X139.649 Y120.71 E.00083
G1 X130.112 Y120.71 E.18383
G1 X130.112 Y135.29 E.28104
G1 X139.589 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.692 Y135.29 E-.03914
G1 X139.692 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.892 Y134.49 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7215
M204 S4000
G1 X138.892 Y121.57 E.2259
M204 S10000
G1 X135.34 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7215
M204 S4000
G1 X137.037 Y121.482 E.0352
G1 X136.649 Y122.176 E.0165
G3 X134.373 Y123.933 I-2.91 J-1.417 E.06179
G1 X133.918 Y123.978 E.00949
G1 X133.462 Y123.714 E.01092
G1 X133.007 Y122.899 E.01936
G2 X131.658 Y121.482 I-3.029 J1.533 E.04117
G1 X131.303 Y121.482 E.00736
G1 X131.303 Y125.326 E.07974
G3 X132.552 Y124.784 I1.872 J2.603 E.02846
G1 X133.007 Y124.739 E.00949
G1 X133.462 Y125.003 E.01092
G1 X133.918 Y125.818 E.01936
G2 X136.194 Y127.575 I2.91 J-1.417 E.06179
G1 X136.649 Y127.619 E.00949
G1 X137.104 Y127.355 E.01092
G1 X137.559 Y126.541 E.01936
G3 X138.501 Y125.38 I3.579 J1.941 E.03119
G1 X138.501 Y128.602 E.06683
G2 X137.559 Y128.381 I-.905 J1.739 E.02028
G1 X137.104 Y128.645 E.01092
G1 X136.649 Y129.459 E.01936
G3 X134.373 Y131.216 I-2.91 J-1.417 E.06179
G1 X133.918 Y131.261 E.00949
G1 X133.462 Y130.997 E.01092
G1 X133.007 Y130.182 E.01936
G2 X131.303 Y128.632 I-2.702 J1.259 E.04905
G1 X131.303 Y132.609 E.08249
G3 X132.552 Y132.067 I1.872 J2.603 E.02846
G1 X133.007 Y132.022 E.00949
G1 X133.462 Y132.286 E.01092
G1 X133.918 Y133.101 E.01936
G2 X135.267 Y134.518 I3.029 J-1.533 E.04117
G1 X137.166 Y134.518 E.03939
G1 X137.559 Y133.824 E.01655
G3 X138.501 Y132.663 I3.579 J1.942 E.03119
G1 X138.501 Y130.966 E.0352
M204 S10000
G1 X130.912 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7215
M204 S4000
G1 X130.912 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.912 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P57 R8
G1 X125.479 Y121.119 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7215
M204 S4000
G1 X116.717 Y121.119 E.18174
G1 X116.717 Y134.881 E.28545
G1 X125.479 Y134.881 E.18174
G1 X125.479 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.888 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.351 Y120.71 E.18383
G1 X116.308 Y120.71 E.00083
G1 F3480
G1 X116.308 Y135.29 E.28104
G1 F3600
G1 X116.351 Y135.29 E.00083
G1 X125.888 Y135.29 E.18383
G1 X125.888 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.888 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.697 Y123.382 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7215
M204 S4000
G1 X124.697 Y121.685 E.0352
G1 X124.375 Y121.482 E.00789
G1 X122.47 Y121.482 E.0395
G3 X121.172 Y123.317 I-5.71 J-2.662 E.04688
G3 X119.351 Y123.978 I-2.297 J-3.494 E.04054
G1 X118.896 Y123.714 E.01092
G2 X117.531 Y121.758 I-6.005 J2.738 E.04975
G1 X117.499 Y124.96 E.06642
G3 X118.441 Y124.739 I.905 J1.739 E.02028
G1 X118.896 Y125.003 E.01092
G2 X120.262 Y126.959 I6.004 J-2.738 E.04975
G2 X122.083 Y127.619 I2.297 J-3.494 E.04054
G1 X122.538 Y127.355 E.01092
G3 X123.903 Y125.4 I6.004 J2.738 E.04975
G3 X124.697 Y124.991 I1.337 J1.622 E.01866
G1 X124.697 Y128.968 E.08249
G2 X122.993 Y128.381 I-2.178 J3.556 E.03768
G1 X122.538 Y128.645 E.01092
G3 X121.172 Y130.601 I-6.004 J-2.738 E.04975
G3 X119.351 Y131.261 I-2.297 J-3.494 E.04054
G1 X118.896 Y130.997 E.01092
G2 X117.531 Y129.041 I-6.004 J2.738 E.04975
G1 X117.499 Y132.243 E.06642
G3 X118.441 Y132.022 I.905 J1.739 E.02028
G1 X118.896 Y132.286 E.01092
G2 X120.262 Y134.242 I6.004 J-2.738 E.04975
G1 X120.701 Y134.518 E.01075
G1 X122.599 Y134.518 E.03939
G3 X123.903 Y132.683 I5.83 J2.762 E.04694
G3 X124.697 Y132.274 I1.337 J1.622 E.01866
G1 X124.697 Y133.971 E.0352
M204 S10000
G1 X125.088 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7215
M204 S4000
G1 X125.088 Y121.57 E.2259
M204 S10000
G1 X117.108 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7215
M204 S4000
G1 X117.108 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X117.108 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L83
M991 S0 P82 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.32 I-.551 J1.085 P1  F60000
G1 X139.367 Y134.881 Z10.32
G1 Z10.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7307
M204 S4000
G1 X139.367 Y121.119 E.28545
G1 X130.605 Y121.119 E.18174
G1 X130.605 Y134.881 E.28545
G1 X139.307 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.733 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.776 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.776 Y120.71 E.28104
G1 F3600
G1 X139.733 Y120.71 E.00083
G1 X130.196 Y120.71 E.18383
G1 X130.196 Y135.29 E.28104
G1 X139.673 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.776 Y135.29 E-.03914
G1 X139.776 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.976 Y134.49 Z10.44 F60000
G1 Z10.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7307
M204 S4000
G1 X138.976 Y121.57 E.2259
M204 S10000
G1 X138.585 Y123.598 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7307
M204 S4000
G1 X138.585 Y125.295 E.0352
G2 X137.442 Y127.09 I2.354 J2.76 E.0448
G2 X137.447 Y128 I.783 J.451 E.01979
G3 X138.585 Y128.533 I-2.131 J6.033 E.02612
G1 X138.585 Y132.578 E.08389
G2 X137.403 Y134.518 I2.463 J2.83 E.04787
G1 X135.221 Y134.518 E.04526
G3 X133.8 Y132.552 I1.804 J-2.8 E.0515
G3 X133.805 Y131.642 I.782 J-.451 E.01979
G1 X134.809 Y131.186 E.02286
G2 X136.766 Y128.91 I-1.361 J-3.15 E.06444
G2 X136.761 Y128 I-.782 J-.451 E.01979
G1 X135.758 Y127.545 E.02286
G3 X133.8 Y125.269 I1.361 J-3.15 E.06444
G3 X133.805 Y124.358 I.782 J-.451 E.01979
G1 X134.809 Y123.903 E.02286
G2 X136.804 Y121.482 I-1.388 J-3.177 E.06754
G1 X131.703 Y121.482 E.10581
G3 X133.124 Y123.448 I-1.804 J2.8 E.0515
G3 X133.12 Y124.358 I-.783 J.451 E.01979
G2 X131.387 Y125.235 I3.573 J9.213 E.04034
G1 X131.387 Y128.582 E.06943
G3 X133.124 Y130.731 I-1.497 J2.987 E.05909
G3 X133.12 Y131.642 I-.783 J.451 E.01979
G2 X131.387 Y132.518 I3.572 J9.212 E.04034
G1 X131.387 Y134.215 E.0352
M204 S10000
G1 X130.996 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7307
M204 S4000
G1 X130.996 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X130.996 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.395 Y121.119 Z10.44 F60000
G1 Z10.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7307
M204 S4000
G1 X116.633 Y121.119 E.18174
G1 X116.633 Y134.881 E.28545
G1 X125.395 Y134.881 E.18174
G1 X125.395 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.804 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.267 Y120.71 E.18383
G1 X116.224 Y120.71 E.00083
M73 P58 R8
G1 F3480
G1 X116.224 Y135.29 E.28104
G1 F3600
G1 X116.267 Y135.29 E.00083
G1 X125.804 Y135.29 E.18383
G1 X125.804 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.804 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.613 Y123.244 Z10.44 F60000
G1 Z10.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7307
M204 S4000
G1 X124.613 Y124.941 E.0352
G2 X122.876 Y127.09 I1.497 J2.987 E.05909
G2 X122.88 Y128 I.783 J.451 E.01979
G3 X124.613 Y128.877 I-3.573 J9.212 E.04034
G1 X124.613 Y132.224 E.06943
G2 X122.837 Y134.518 I1.518 J3.01 E.0622
G1 X120.655 Y134.518 E.04526
G3 X119.234 Y132.552 I1.804 J-2.8 E.0515
G3 X119.239 Y131.642 I.782 J-.451 E.01979
G1 X120.243 Y131.186 E.02286
G2 X122.2 Y128.91 I-1.361 J-3.15 E.06444
G2 X122.195 Y128 I-.782 J-.451 E.01979
G1 X121.191 Y127.545 E.02286
G3 X119.234 Y125.269 I1.361 J-3.15 E.06444
G3 X119.239 Y124.358 I.782 J-.451 E.01979
G1 X120.243 Y123.903 E.02286
G2 X122.238 Y121.482 I-1.388 J-3.177 E.06754
G1 X117.415 Y121.482 E.10005
G1 X117.415 Y121.653 E.00354
G3 X118.558 Y123.448 I-2.354 J2.761 E.0448
G3 X118.554 Y124.358 I-.783 J.451 E.01979
G2 X117.415 Y124.892 I2.131 J6.032 E.02612
G1 X117.415 Y128.936 E.08389
G3 X118.558 Y130.731 I-2.354 J2.761 E.0448
G3 X118.554 Y131.642 I-.783 J.451 E.01979
G2 X117.415 Y132.175 I2.13 J6.032 E.02612
G1 X117.415 Y133.872 E.0352
M204 S10000
G1 X117.024 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7307
M204 S4000
G1 X117.024 Y121.57 E.2259
M204 S10000
G1 X125.004 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7307
M204 S4000
G1 X125.004 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X125.004 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L84
M991 S0 P83 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.44 I-.75 J.958 P1  F60000
G1 X139.451 Y134.881 Z10.44
G1 Z10.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7152
M204 S4000
G1 X139.451 Y121.119 E.28545
G1 X130.689 Y121.119 E.18174
G1 X130.689 Y134.881 E.28545
G1 X139.391 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.817 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.86 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.86 Y120.71 E.28104
G1 F3600
G1 X139.817 Y120.71 E.00083
G1 X130.28 Y120.71 E.18383
G1 X130.28 Y135.29 E.28104
G1 X139.757 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.86 Y135.29 E-.03914
G1 X139.86 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.06 Y134.49 Z10.56 F60000
G1 Z10.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7152
M204 S4000
G1 X139.06 Y121.57 E.2259
M204 S10000
G1 X138.669 Y123.5 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7152
M204 S4000
G1 X138.669 Y125.197 E.0352
G2 X137.59 Y127.09 I1.899 J2.335 E.04624
G1 X137.589 Y127.545 E.00944
G1 X137.896 Y128 E.01138
G3 X138.669 Y128.479 I-3.563 J6.615 E.01888
G1 X138.669 Y132.48 E.08299
G2 X137.59 Y134.373 I1.898 J2.335 E.04624
G1 X137.59 Y134.518 E.00301
G1 X135.132 Y134.518 E.051
G3 X133.949 Y132.552 I1.761 J-2.398 E.04885
G1 X133.948 Y132.097 E.00944
G1 X134.254 Y131.642 E.01138
G1 X134.993 Y131.186 E.01801
G2 X136.617 Y128.91 I-1.45 J-2.752 E.06015
G1 X136.618 Y128.455 E.00944
G1 X136.312 Y128 E.01138
G1 X135.573 Y127.545 E.01801
G3 X133.949 Y125.269 I1.45 J-2.752 E.06015
G1 X133.948 Y124.814 E.00944
G1 X134.254 Y124.358 E.01138
G1 X134.993 Y123.903 E.01801
G2 X136.617 Y121.627 I-1.45 J-2.752 E.06015
G1 X136.618 Y121.482 E.00301
G1 X131.793 Y121.482 E.10008
G3 X132.976 Y123.448 I-1.761 J2.398 E.04886
G1 X132.977 Y123.903 E.00944
G1 X132.671 Y124.358 E.01138
G2 X131.471 Y125.137 I5.817 J10.276 E.02968
G1 X131.471 Y128.539 E.07056
G3 X132.976 Y130.731 I-1.504 J2.645 E.05708
G1 X132.977 Y131.186 E.00944
G1 X132.671 Y131.642 E.01138
G2 X131.471 Y132.42 I5.815 J10.272 E.02968
G1 X131.471 Y134.117 E.0352
M204 S10000
G1 X131.08 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7152
M204 S4000
G1 X131.08 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.08 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.311 Y121.119 Z10.56 F60000
G1 Z10.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7152
M204 S4000
G1 X116.549 Y121.119 E.18174
G1 X116.549 Y134.881 E.28545
G1 X125.311 Y134.881 E.18174
G1 X125.311 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.72 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.183 Y120.71 E.18383
G1 X116.14 Y120.71 E.00083
G1 F3480
G1 X116.14 Y135.29 E.28104
G1 F3600
G1 X116.183 Y135.29 E.00083
G1 X125.72 Y135.29 E.18383
G1 X125.72 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.72 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.529 Y123.2 Z10.56 F60000
G1 Z10.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7152
M204 S4000
G1 X124.529 Y124.897 E.0352
G2 X123.024 Y127.09 I1.504 J2.645 E.05708
G1 X123.023 Y127.545 E.00944
G1 X123.33 Y128 E.01138
G3 X124.529 Y128.779 I-5.818 J10.276 E.02968
G1 X124.529 Y132.181 E.07057
G2 X123.024 Y134.373 I1.504 J2.645 E.05708
G1 X123.024 Y134.518 E.00301
G1 X120.565 Y134.518 E.051
G3 X119.383 Y132.552 I1.761 J-2.398 E.04885
G1 X119.382 Y132.097 E.00944
G1 X119.688 Y131.642 E.01138
G1 X120.427 Y131.186 E.01801
G2 X122.051 Y128.91 I-1.45 J-2.752 E.06015
G1 X122.052 Y128.455 E.00944
G1 X121.746 Y128 E.01138
G1 X121.007 Y127.545 E.01801
G3 X119.383 Y125.269 I1.45 J-2.752 E.06015
G1 X119.382 Y124.814 E.00944
G1 X119.688 Y124.358 E.01138
G1 X120.427 Y123.903 E.01801
G2 X122.051 Y121.627 I-1.45 J-2.752 E.06015
G1 X122.051 Y121.482 E.00301
G1 X117.331 Y121.482 E.09792
G1 X117.331 Y121.555 E.00152
G3 X118.41 Y123.448 I-1.898 J2.335 E.04624
G1 X118.411 Y123.903 E.00944
G1 X118.104 Y124.358 E.01138
G2 X117.331 Y124.838 I3.559 J6.608 E.01888
G1 X117.331 Y128.838 E.08299
G3 X118.41 Y130.731 I-1.898 J2.335 E.04624
G1 X118.411 Y131.186 E.00944
G1 X118.104 Y131.642 E.01138
G2 X117.331 Y132.121 I3.558 J6.607 E.01888
G1 X117.331 Y133.818 E.0352
M204 S10000
G1 X116.94 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7152
M204 S4000
G1 X116.94 Y121.57 E.2259
M204 S10000
G1 X124.92 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7152
M204 S4000
G1 X124.92 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.92 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L85
M991 S0 P84 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.56 I-.745 J.962 P1  F60000
G1 X139.535 Y134.881 Z10.56
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X139.535 Y121.119 E.28545
G1 X130.773 Y121.119 E.18174
G1 X130.773 Y134.881 E.28545
G1 X139.475 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.901 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X139.944 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X139.944 Y120.71 E.28104
G1 F3600
G1 X139.901 Y120.71 E.00083
G1 X130.364 Y120.71 E.18383
G1 X130.364 Y135.29 E.28104
G1 X139.841 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X139.944 Y135.29 E-.03914
G1 X139.944 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.144 Y134.49 Z10.68 F60000
G1 Z10.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X139.144 Y121.57 E.2259
M204 S10000
G1 X138.753 Y123.373 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X138.753 Y125.07 E.0352
G1 X138.519 Y125.269 E.00636
G2 X137.72 Y127.09 I2.137 J2.023 E.04207
G1 X137.795 Y127.545 E.00957
G2 X138.753 Y128.466 I2.234 J-1.363 E.02788
G1 X138.753 Y132.354 E.08063
G1 X138.519 Y132.552 E.00636
G2 X137.72 Y134.373 I2.137 J2.023 E.04207
G1 X137.744 Y134.518 E.00305
G1 X135.066 Y134.518 E.05555
G1 X134.878 Y134.373 E.00494
G3 X134.079 Y132.552 I2.137 J-2.023 E.04207
G3 X134.506 Y131.642 I1.055 J-.061 E.02173
G1 X135.688 Y130.731 E.03096
G2 X136.487 Y128.91 I-2.137 J-2.023 E.04207
G2 X136.061 Y128 I-1.056 J-.061 E.02173
G1 X134.878 Y127.09 E.03096
G3 X134.079 Y125.269 I2.137 J-2.023 E.04207
G3 X134.506 Y124.358 I1.056 J-.061 E.02173
G1 X135.688 Y123.448 E.03096
G2 X136.487 Y121.627 I-2.137 J-2.023 E.04207
G1 X136.464 Y121.482 E.00305
G1 X131.858 Y121.482 E.09553
G1 X132.047 Y121.627 E.00494
G3 X132.846 Y123.448 I-2.137 J2.023 E.04207
G3 X132.419 Y124.358 I-1.056 J.061 E.02173
G1 X131.555 Y125.024 E.02262
G1 X131.555 Y128.532 E.07277
G1 X132.047 Y128.91 E.01288
G3 X132.846 Y130.731 I-2.137 J2.023 E.04207
G3 X132.419 Y131.642 I-1.056 J.061 E.02173
G1 X131.555 Y132.307 E.02262
G1 X131.555 Y134.004 E.0352
M204 S10000
G1 X131.164 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X131.164 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.164 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.227 Y121.119 Z10.68 F60000
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X116.465 Y121.119 E.18174
G1 X116.465 Y134.881 E.28545
G1 X125.227 Y134.881 E.18174
G1 X125.227 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.636 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.099 Y120.71 E.18383
G1 X116.056 Y120.71 E.00083
G1 F3480
G1 X116.056 Y135.29 E.28104
G1 F3600
G1 X116.099 Y135.29 E.00083
G1 X125.636 Y135.29 E.18383
G1 X125.636 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.636 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.445 Y123.154 Z10.68 F60000
G1 Z10.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P59 R8
G1 F7078
M204 S4000
G1 X124.445 Y124.851 E.0352
G2 X123.154 Y127.09 I1.652 J2.444 E.05548
G2 X123.581 Y128 I1.056 J.06 E.02173
G1 X124.445 Y128.665 E.02262
G1 X124.445 Y132.134 E.07196
G2 X123.154 Y134.373 I1.652 J2.444 E.05548
G1 X123.178 Y134.518 E.00305
G1 X120.5 Y134.518 E.05555
G1 X120.312 Y134.373 E.00494
G3 X119.513 Y132.552 I2.137 J-2.023 E.04207
G3 X119.939 Y131.642 I1.055 J-.061 E.02173
G1 X121.122 Y130.731 E.03096
G2 X121.921 Y128.91 I-2.137 J-2.023 E.04207
G2 X121.495 Y128 I-1.056 J-.061 E.02173
G1 X120.312 Y127.09 E.03096
G3 X119.513 Y125.269 I2.137 J-2.023 E.04207
G3 X119.939 Y124.358 I1.056 J-.061 E.02173
G1 X121.122 Y123.448 E.03096
G2 X121.921 Y121.627 I-2.137 J-2.023 E.04207
G1 X121.897 Y121.482 E.00305
G1 X117.292 Y121.482 E.09553
G1 X117.481 Y121.627 E.00494
G3 X118.28 Y123.448 I-2.137 J2.023 E.04207
G1 X118.205 Y123.903 E.00957
G3 X117.247 Y124.825 I-2.234 J-1.364 E.02788
G1 X117.247 Y128.731 E.08101
G1 X117.481 Y128.91 E.00612
G3 X118.28 Y130.731 I-2.137 J2.023 E.04207
G1 X118.205 Y131.186 E.00957
G3 X117.247 Y132.108 I-2.234 J-1.364 E.02788
G1 X117.247 Y133.805 E.0352
M204 S10000
G1 X116.856 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X116.856 Y121.57 E.2259
M204 S10000
G1 X124.836 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7078
M204 S4000
G1 X124.836 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.836 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L86
M991 S0 P85 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.68 I-.739 J.967 P1  F60000
G1 X139.619 Y134.881 Z10.68
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7017
M204 S4000
G1 X139.619 Y121.119 E.28545
G1 X130.857 Y121.119 E.18174
G1 X130.857 Y134.881 E.28545
G1 X139.559 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X139.985 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.028 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.028 Y120.71 E.28104
G1 F3600
G1 X139.985 Y120.71 E.00083
G1 X130.448 Y120.71 E.18383
G1 X130.448 Y135.29 E.28104
G1 X139.925 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.028 Y135.29 E-.03914
G1 X140.028 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.228 Y134.49 Z10.8 F60000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7017
M204 S4000
G1 X139.228 Y121.57 E.2259
M204 S10000
G1 X138.837 Y123.251 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7017
M204 S4000
G1 X138.837 Y124.948 E.0352
G2 X137.964 Y127.545 I1.325 J1.89 E.06082
G2 X138.837 Y128.437 I3.054 J-2.114 E.02601
G1 X138.837 Y132.232 E.07871
G2 X137.876 Y134.518 I1.4 J1.933 E.05409
G1 X134.994 Y134.518 E.05978
G3 X134.206 Y133.007 I1.692 J-1.844 E.03607
G3 X134.694 Y131.642 I1.516 J-.228 E.03133
G1 X135.738 Y130.731 E.02873
G2 X136.36 Y129.366 I-2.254 J-1.851 E.03148
G2 X135.872 Y128 I-1.516 J-.228 E.03133
G1 X134.828 Y127.09 E.02873
G3 X134.206 Y125.724 I2.254 J-1.851 E.03148
G3 X134.694 Y124.358 I1.516 J-.228 E.03133
G1 X135.738 Y123.448 E.02873
G2 X136.332 Y121.482 I-1.82 J-1.622 E.04397
G1 X131.93 Y121.482 E.0913
G3 X132.602 Y123.903 I-1.513 J1.724 E.05516
G3 X131.639 Y124.874 I-3.33 J-2.34 E.0285
G1 X131.639 Y128.511 E.07544
G3 X132.602 Y131.186 I-1.326 J1.988 E.06316
G3 X131.639 Y132.157 I-3.33 J-2.34 E.0285
G1 X131.639 Y133.854 E.0352
M204 S10000
G1 X131.248 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7017
M204 S4000
G1 X131.248 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.248 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.143 Y121.119 Z10.8 F60000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7017
M204 S4000
G1 X116.381 Y121.119 E.18174
G1 X116.381 Y134.881 E.28545
G1 X125.143 Y134.881 E.18174
G1 X125.143 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.552 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X116.015 Y120.71 E.18383
G1 X115.972 Y120.71 E.00083
G1 F3480
G1 X115.972 Y135.29 E.28104
G1 F3600
G1 X116.015 Y135.29 E.00083
G1 X125.552 Y135.29 E.18383
G1 X125.552 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.552 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.361 Y123.173 Z10.8 F60000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7017
M204 S4000
G1 X124.361 Y124.87 E.0352
G2 X123.398 Y127.545 I1.326 J1.988 E.06316
G2 X124.361 Y128.516 I3.33 J-2.34 E.0285
G1 X124.361 Y132.153 E.07545
G2 X123.31 Y134.518 I1.363 J2.022 E.05659
G1 X120.428 Y134.518 E.05978
G3 X119.64 Y133.007 I1.692 J-1.844 E.03607
G3 X120.128 Y131.642 I1.516 J-.228 E.03133
G1 X121.172 Y130.731 E.02873
G2 X121.794 Y129.366 I-2.254 J-1.851 E.03148
G2 X121.306 Y128 I-1.516 J-.228 E.03133
G1 X120.262 Y127.09 E.02873
G3 X119.64 Y125.724 I2.254 J-1.851 E.03148
G3 X120.128 Y124.358 I1.516 J-.228 E.03133
G1 X121.172 Y123.448 E.02873
G2 X121.765 Y121.482 I-1.82 J-1.622 E.04397
G1 X117.364 Y121.482 E.0913
G3 X118.036 Y123.903 I-1.513 J1.724 E.05516
G3 X117.163 Y124.796 I-3.054 J-2.115 E.02601
G1 X117.163 Y128.59 E.07871
G3 X118.036 Y131.186 I-1.325 J1.89 E.06083
G3 X117.163 Y132.079 I-3.054 J-2.115 E.02601
G1 X117.163 Y133.776 E.0352
M204 S10000
G1 X116.772 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7017
M204 S4000
G1 X116.772 Y121.57 E.2259
M204 S10000
G1 X124.752 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7017
M204 S4000
G1 X124.752 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X124.752 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L87
M991 S0 P86 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.8 I-.734 J.971 P1  F60000
G1 X139.703 Y134.881 Z10.8
G1 Z10.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X139.703 Y121.119 E.28545
G1 X130.941 Y121.119 E.18174
G1 X130.941 Y134.881 E.28545
G1 X139.643 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.069 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.112 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.112 Y120.71 E.28104
G1 F3600
G1 X140.069 Y120.71 E.00083
G1 X130.532 Y120.71 E.18383
G1 X130.532 Y135.29 E.28104
G1 X140.009 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.112 Y135.29 E-.03914
G1 X140.112 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.312 Y134.49 Z10.92 F60000
G1 Z10.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X139.312 Y121.57 E.2259
M204 S10000
G1 X138.921 Y123.084 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X138.921 Y124.781 E.0352
G2 X137.937 Y127.09 I1.489 J1.999 E.05456
G2 X138.921 Y128.415 I2.818 J-1.065 E.03469
G1 X138.921 Y132.064 E.07568
G2 X137.992 Y134.518 I1.351 J1.915 E.05778
G1 X134.925 Y134.518 E.06361
G3 X134.468 Y132.097 I1.533 J-1.544 E.05433
G3 X135.791 Y130.731 I7.402 J5.848 E.03951
G2 X136.099 Y128.455 I-1.749 J-1.395 E.05003
G2 X134.775 Y127.09 I-7.402 J5.848 E.03951
G3 X134.468 Y124.814 I1.749 J-1.395 E.05003
G3 X135.791 Y123.448 I7.401 J5.847 E.03951
G2 X136.216 Y121.482 I-1.809 J-1.42 E.04318
G1 X131.999 Y121.482 E.08746
G3 X132.629 Y123.448 I-1.754 J1.646 E.04426
G3 X131.723 Y124.698 I-2.686 J-.994 E.03243
G1 X131.723 Y128.497 E.07881
G3 X132.629 Y130.731 I-1.523 J1.919 E.05228
G3 X131.723 Y131.981 I-2.686 J-.994 E.03243
G1 X131.723 Y133.678 E.0352
M204 S10000
G1 X131.332 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X131.332 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.332 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.059 Y121.119 Z10.92 F60000
G1 Z10.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X116.297 Y121.119 E.18174
G1 X116.297 Y134.881 E.28545
G1 X125.059 Y134.881 E.18174
G1 X125.059 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.468 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.931 Y120.71 E.18383
G1 X115.888 Y120.71 E.00083
G1 F3480
G1 X115.888 Y135.29 E.28104
G1 F3600
G1 X115.931 Y135.29 E.00083
G1 X125.468 Y135.29 E.18383
G1 X125.468 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.468 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.277 Y123.159 Z10.92 F60000
G1 Z10.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6977
M204 S4000
G1 X124.277 Y124.856 E.0352
G2 X123.371 Y127.09 I1.523 J1.919 E.05228
G2 X124.277 Y128.34 I2.686 J-.994 E.03243
G1 X124.277 Y132.139 E.07881
G2 X123.426 Y134.518 I1.375 J1.834 E.05551
G1 X120.359 Y134.518 E.06361
G3 X119.901 Y132.097 I1.533 J-1.544 E.05433
G3 X121.225 Y130.731 I7.402 J5.848 E.03951
G2 X121.532 Y128.455 I-1.749 J-1.395 E.05003
G2 X120.209 Y127.09 I-7.402 J5.848 E.03951
G3 X119.901 Y124.814 I1.749 J-1.395 E.05003
G3 X121.225 Y123.448 I7.401 J5.847 E.03951
G2 X121.65 Y121.482 I-1.809 J-1.42 E.04318
G1 X117.433 Y121.482 E.08746
G3 X118.063 Y123.448 I-1.754 J1.646 E.04426
G3 X117.079 Y124.773 I-2.818 J-1.065 E.03469
G1 X117.079 Y128.422 E.07568
G3 X118.063 Y130.731 I-1.489 J1.999 E.05457
G3 X117.079 Y132.057 I-2.818 J-1.065 E.03469
G1 X117.079 Y133.754 E.0352
M204 S10000
G1 X116.688 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6977
M204 S4000
G1 X116.688 Y121.57 E.2259
M204 S10000
G1 X124.668 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6977
M204 S4000
G1 X124.668 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.668 Y123.57 E-.76
; WIPE_END
M73 P60 R8
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L88
M991 S0 P87 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.92 I-.729 J.974 P1  F60000
G1 X139.787 Y134.881 Z10.92
G1 Z10.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6951
M204 S4000
G1 X139.787 Y121.119 E.28545
G1 X131.025 Y121.119 E.18174
G1 X131.025 Y134.881 E.28545
G1 X139.727 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.153 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.196 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.196 Y120.71 E.28104
G1 F3600
G1 X140.153 Y120.71 E.00083
G1 X130.616 Y120.71 E.18383
G1 X130.616 Y135.29 E.28104
G1 X140.093 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.196 Y135.29 E-.03914
G1 X140.196 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.396 Y134.49 Z11.04 F60000
G1 Z10.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6951
M204 S4000
G1 X139.396 Y121.57 E.2259
M204 S10000
G1 X139.005 Y122.865 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6951
M204 S4000
G1 X139.005 Y124.562 E.0352
G2 X138.028 Y127.09 I1.538 J2.047 E.05924
G2 X139.005 Y128.357 I3.109 J-1.388 E.0335
G1 X139.005 Y131.845 E.07236
G2 X138.095 Y134.518 I1.4 J1.968 E.06256
G1 X134.841 Y134.518 E.0675
G3 X134.386 Y132.552 I1.841 J-1.461 E.04326
G3 X135.467 Y131.186 I3.301 J1.502 E.03648
G2 X136.18 Y128.91 I-1.673 J-1.774 E.05169
G2 X135.099 Y127.545 I-3.302 J1.502 E.03648
G3 X134.386 Y125.269 I1.673 J-1.773 E.05169
G3 X135.467 Y123.903 I3.301 J1.502 E.03648
G2 X136.113 Y121.482 I-1.535 J-1.706 E.05498
G1 X132.084 Y121.482 E.08357
G3 X132.538 Y123.448 I-1.841 J1.461 E.04326
G3 X131.807 Y124.481 I-2.766 J-1.183 E.02644
G1 X131.807 Y128.438 E.08208
G3 X132.538 Y130.731 I-1.642 J1.787 E.05225
G3 X131.807 Y131.764 I-2.766 J-1.183 E.02644
G1 X131.807 Y133.461 E.0352
M204 S10000
G1 X131.416 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6951
M204 S4000
G1 X131.416 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.416 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.975 Y121.119 Z11.04 F60000
G1 Z10.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6951
M204 S4000
G1 X116.213 Y121.119 E.18174
G1 X116.213 Y134.881 E.28545
G1 X124.975 Y134.881 E.18174
G1 X124.975 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.384 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.847 Y120.71 E.18383
G1 X115.804 Y120.71 E.00083
G1 F3480
G1 X115.804 Y135.29 E.28104
G1 F3600
G1 X115.847 Y135.29 E.00083
G1 X125.384 Y135.29 E.18383
G1 X125.384 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.384 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.193 Y123.099 Z11.04 F60000
G1 Z10.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6951
M204 S4000
G1 X124.193 Y124.796 E.0352
G2 X123.462 Y127.09 I1.642 J1.787 E.05225
G2 X124.193 Y128.122 I2.765 J-1.183 E.02644
G1 X124.193 Y132.079 E.08208
G2 X123.529 Y134.518 I1.564 J1.736 E.05539
G1 X120.274 Y134.518 E.0675
G3 X119.82 Y132.552 I1.841 J-1.461 E.04326
G3 X120.901 Y131.186 I3.301 J1.502 E.03648
G2 X121.614 Y128.91 I-1.673 J-1.774 E.05169
G2 X120.533 Y127.545 I-3.301 J1.502 E.03648
G3 X119.82 Y125.269 I1.673 J-1.773 E.05169
G3 X120.901 Y123.903 I3.301 J1.502 E.03648
G2 X121.547 Y121.482 I-1.535 J-1.706 E.05498
G1 X117.518 Y121.482 E.08357
G3 X117.972 Y123.448 I-1.841 J1.461 E.04326
G3 X116.995 Y124.715 I-3.109 J-1.388 E.0335
G1 X116.995 Y128.203 E.07236
G3 X117.972 Y130.731 I-1.538 J2.047 E.05924
G3 X116.995 Y131.998 I-3.109 J-1.388 E.0335
G1 X116.995 Y133.695 E.0352
M204 S10000
G1 X116.604 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6951
M204 S4000
G1 X116.604 Y121.57 E.2259
M204 S10000
G1 X124.584 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6951
M204 S4000
G1 X124.584 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.584 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L89
M991 S0 P88 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.04 I-.724 J.978 P1  F60000
G1 X139.871 Y134.881 Z11.04
G1 Z10.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6936
M204 S4000
G1 X139.871 Y121.119 E.28545
G1 X131.109 Y121.119 E.18174
G1 X131.109 Y134.881 E.28545
G1 X139.811 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.237 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.28 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.28 Y120.71 E.28104
G1 F3600
G1 X140.237 Y120.71 E.00083
G1 X130.7 Y120.71 E.18383
G1 X130.7 Y135.29 E.28104
G1 X140.177 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.28 Y135.29 E-.03914
G1 X140.28 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.48 Y134.49 Z11.16 F60000
G1 Z10.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6936
M204 S4000
G1 X139.48 Y121.57 E.2259
M204 S10000
G1 X139.089 Y122.664 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6936
M204 S4000
G1 X139.089 Y124.361 E.0352
G2 X138.11 Y127.09 I1.463 J2.065 E.06404
G2 X139.089 Y128.334 I3.895 J-2.056 E.03302
G1 X139.089 Y131.644 E.06865
G1 X138.64 Y132.097 E.01323
G2 X138.188 Y134.518 I1.571 J1.546 E.05421
G1 X134.768 Y134.518 E.07094
G3 X134.469 Y132.552 I1.866 J-1.29 E.0427
G3 X135.567 Y131.186 I4.207 J2.26 E.03656
G2 X135.45 Y128 I-1.552 J-1.538 E.07413
G3 X134.469 Y125.269 I1.463 J-2.067 E.0641
G3 X135.567 Y123.903 I4.207 J2.26 E.03656
G2 X136.02 Y121.482 I-1.571 J-1.546 E.05421
G1 X132.157 Y121.482 E.08013
G3 X131.891 Y124.265 I-1.714 J1.24 E.06334
G1 X131.891 Y128.42 E.08618
G3 X131.891 Y131.548 I-1.509 J1.564 E.07243
G1 X131.891 Y133.245 E.0352
M204 S10000
G1 X131.5 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6936
M204 S4000
G1 X131.5 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.5 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.891 Y121.119 Z11.16 F60000
G1 Z10.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6936
M204 S4000
G1 X116.129 Y121.119 E.18174
G1 X116.129 Y134.881 E.28545
G1 X124.891 Y134.881 E.18174
G1 X124.891 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.3 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.763 Y120.71 E.18383
G1 X115.72 Y120.71 E.00083
G1 F3480
G1 X115.72 Y135.29 E.28104
G1 F3600
G1 X115.763 Y135.29 E.00083
G1 X125.3 Y135.29 E.18383
G1 X125.3 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.3 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.109 Y123.082 Z11.16 F60000
G1 Z10.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6936
M204 S4000
G1 X124.109 Y124.778 E.0352
G2 X124.109 Y127.906 I1.509 J1.564 E.07242
G1 X124.109 Y132.062 E.08619
G2 X123.622 Y134.518 I1.59 J1.592 E.05508
G1 X120.202 Y134.518 E.07094
G3 X120.551 Y131.642 I1.74 J-1.248 E.06601
G2 X121.531 Y128.91 I-1.463 J-2.067 E.0641
G2 X120.433 Y127.545 I-4.207 J2.26 E.03656
G3 X120.551 Y124.358 I1.552 J-1.538 E.07413
G2 X121.531 Y121.627 I-1.463 J-2.067 E.0641
G1 X121.454 Y121.482 E.00342
G1 X117.591 Y121.482 E.08013
G3 X117.242 Y124.358 I-1.74 J1.248 E.06601
G1 X116.911 Y124.693 E.00975
G1 X116.911 Y128.002 E.06865
G3 X117.89 Y130.731 I-1.463 J2.065 E.06404
G3 X116.911 Y131.976 I-3.895 J-2.056 E.03302
G1 X116.911 Y133.673 E.0352
M204 S10000
G1 X116.52 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6936
M204 S4000
G1 X116.52 Y121.57 E.2259
M204 S10000
G1 X124.5 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6936
M204 S4000
G1 X124.5 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 10.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.5 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L90
M991 S0 P89 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.16 I-.719 J.982 P1  F60000
G1 X139.955 Y134.881 Z11.16
G1 Z10.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X139.955 Y121.119 E.28545
G1 X131.193 Y121.119 E.18174
G1 X131.193 Y134.881 E.28545
G1 X139.895 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.321 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.364 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.364 Y120.71 E.28104
G1 F3600
G1 X140.321 Y120.71 E.00083
G1 X130.784 Y120.71 E.18383
G1 X130.784 Y135.29 E.28104
G1 X140.261 Y135.29 E.18268
; WIPE_START
M204 S4000
M73 P61 R8
G1 X140.364 Y135.29 E-.03914
G1 X140.364 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.564 Y134.49 Z11.28 F60000
G1 Z10.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X139.564 Y121.57 E.2259
M204 S10000
G1 X139.173 Y122.44 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X139.173 Y124.137 E.0352
G1 X138.969 Y124.358 E.00624
G2 X138.185 Y127.09 I1.407 J1.882 E.0633
G2 X139.173 Y128.31 I5.078 J-3.1 E.03267
G1 X139.173 Y131.42 E.0645
G1 X138.969 Y131.642 E.00624
G2 X138.273 Y134.518 I1.345 J1.848 E.06677
G1 X134.692 Y134.518 E.0743
G3 X135.238 Y131.642 I1.908 J-1.127 E.06634
G2 X135.328 Y128 I-1.374 J-1.856 E.08706
G3 X135.238 Y124.358 I1.374 J-1.856 E.08706
G2 X135.934 Y121.482 I-1.345 J-1.848 E.06677
G1 X132.233 Y121.482 E.07678
G3 X131.975 Y124.044 I-1.832 J1.109 E.0573
G1 X131.975 Y128.4 E.09036
G3 X131.975 Y131.327 I-1.565 J1.463 E.06683
G1 X131.975 Y133.024 E.0352
M204 S10000
G1 X131.584 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X131.584 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.584 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.807 Y121.119 Z11.28 F60000
G1 Z10.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X116.045 Y121.119 E.18174
G1 X116.045 Y134.881 E.28545
G1 X124.807 Y134.881 E.18174
G1 X124.807 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.216 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.679 Y120.71 E.18383
G1 X115.636 Y120.71 E.00083
G1 F3480
G1 X115.636 Y135.29 E.28104
G1 F3600
G1 X115.679 Y135.29 E.00083
G1 X125.216 Y135.29 E.18383
G1 X125.216 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.216 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.025 Y123.062 Z11.28 F60000
G1 Z10.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X124.025 Y124.759 E.0352
G2 X124.025 Y127.685 I1.565 J1.463 E.06683
G1 X124.025 Y132.042 E.09037
G2 X123.707 Y134.518 I1.619 J1.466 E.05512
G1 X120.125 Y134.518 E.0743
G3 X120.672 Y131.642 I1.908 J-1.127 E.06634
G2 X120.762 Y128 I-1.374 J-1.856 E.08706
G3 X120.672 Y124.358 I1.374 J-1.856 E.08706
G2 X121.368 Y121.482 I-1.345 J-1.848 E.06677
G1 X117.667 Y121.482 E.07678
G3 X117.12 Y124.358 I-1.908 J1.127 E.06634
G1 X116.827 Y124.669 E.00885
G1 X116.827 Y127.778 E.0645
G3 X117.763 Y128.91 I-5.107 J5.177 E.03053
G3 X117.12 Y131.642 I-2.009 J.968 E.06295
G1 X116.827 Y131.952 E.00885
G1 X116.827 Y133.649 E.0352
M204 S10000
G1 X116.436 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X116.436 Y121.57 E.2259
M204 S10000
G1 X124.416 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6931
M204 S4000
G1 X124.416 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.416 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L91
M991 S0 P90 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.28 I-.714 J.986 P1  F60000
G1 X140.039 Y134.881 Z11.28
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X140.039 Y121.119 E.28545
G1 X131.277 Y121.119 E.18174
G1 X131.277 Y134.881 E.28545
G1 X139.979 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.405 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.448 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.448 Y120.71 E.28104
G1 F3600
G1 X140.405 Y120.71 E.00083
G1 X130.868 Y120.71 E.18383
G1 X130.868 Y135.29 E.28104
G1 X140.345 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.448 Y135.29 E-.03914
G1 X140.448 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.648 Y134.49 Z11.4 F60000
G1 Z11
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X139.648 Y121.57 E.2259
M204 S10000
G1 X139.257 Y122.235 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X139.257 Y123.932 E.0352
G1 X138.849 Y124.358 E.01224
G2 X138.254 Y127.09 I1.361 J1.727 E.06284
G2 X139.257 Y128.282 I7.115 J-4.967 E.03237
G1 X139.257 Y131.215 E.06082
G1 X138.849 Y131.642 E.01224
G2 X138.353 Y134.518 I1.368 J1.717 E.06623
G1 X134.611 Y134.518 E.07763
G3 X135.359 Y131.642 I2.13 J-.981 E.06676
G2 X135.208 Y128 I-1.516 J-1.761 E.0869
G3 X135.359 Y124.358 I1.516 J-1.761 E.0869
G2 X135.855 Y121.482 I-1.368 J-1.717 E.06623
G1 X132.314 Y121.482 E.07344
G3 X132.059 Y123.819 I-1.869 J.978 E.05171
G1 X132.059 Y128.376 E.09453
G3 X132.059 Y131.102 I-1.664 J1.363 E.06123
G1 X132.059 Y132.799 E.0352
M204 S10000
G1 X131.668 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X131.668 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.668 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.723 Y121.119 Z11.4 F60000
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X115.961 Y121.119 E.18174
G1 X115.961 Y134.881 E.28545
G1 X124.723 Y134.881 E.18174
G1 X124.723 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.132 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.595 Y120.71 E.18383
G1 X115.552 Y120.71 E.00083
G1 F3480
G1 X115.552 Y135.29 E.28104
G1 F3600
G1 X115.595 Y135.29 E.00083
G1 X125.132 Y135.29 E.18383
G1 X125.132 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.132 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.941 Y123.037 Z11.4 F60000
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6931
M204 S4000
G1 X123.941 Y124.734 E.0352
G2 X123.941 Y127.46 I1.665 J1.363 E.06122
G1 X123.941 Y132.018 E.09454
G2 X123.787 Y134.518 I1.649 J1.357 E.05553
G1 X120.044 Y134.518 E.07763
G3 X120.792 Y131.642 I2.13 J-.981 E.06676
G2 X120.641 Y128 I-1.516 J-1.761 E.0869
G3 X120.792 Y124.358 I1.516 J-1.761 E.0869
G2 X121.289 Y121.482 I-1.368 J-1.717 E.06623
G1 X117.748 Y121.482 E.07344
G3 X117 Y124.358 I-2.13 J.982 E.06676
G1 X116.743 Y124.641 E.00792
G1 X116.743 Y127.573 E.06082
G3 X117.833 Y128.91 I-4.009 J4.382 E.03592
G3 X117 Y131.642 I-2.254 J.805 E.06346
G1 X116.743 Y131.924 E.00792
G1 X116.743 Y133.621 E.0352
M204 S10000
G1 X116.352 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6931
M204 S4000
G1 X116.352 Y121.57 E.2259
M204 S10000
G1 X124.332 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6931
M204 S4000
G1 X124.332 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.332 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L92
M991 S0 P91 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.4 I-.709 J.989 P1  F60000
G1 X140.123 Y134.881 Z11.4
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6945
M204 S4000
G1 X140.123 Y121.119 E.28545
G1 X131.361 Y121.119 E.18174
G1 X131.361 Y134.881 E.28545
G1 X140.063 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.489 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.532 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.532 Y120.71 E.28104
G1 F3600
G1 X140.489 Y120.71 E.00083
G1 X130.952 Y120.71 E.18383
G1 X130.952 Y135.29 E.28104
G1 X140.429 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.532 Y135.29 E-.03914
G1 X140.532 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.732 Y134.49 Z11.52 F60000
G1 Z11.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6945
M204 S4000
G1 X139.732 Y121.57 E.2259
M204 S10000
G1 X139.341 Y122.001 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6945
M204 S4000
G1 X139.341 Y123.698 E.0352
G3 X138.727 Y124.358 I-2.773 J-1.963 E.01877
G2 X138.317 Y127.09 I1.397 J1.606 E.06233
G2 X139.341 Y128.247 I11.49 J-9.132 E.03208
G1 X139.341 Y130.981 E.0567
G3 X138.727 Y131.642 I-2.774 J-1.964 E.01877
G2 X138.428 Y134.518 I1.4 J1.599 E.06597
G1 X134.523 Y134.518 E.081
G1 X134.448 Y134.373 E.00339
G3 X135.481 Y131.642 I2.51 J-.612 E.06437
G2 X135.542 Y128.455 I-1.45 J-1.621 E.07419
G3 X134.448 Y127.09 I2.847 J-3.4 E.03653
G3 X135.481 Y124.358 I2.51 J-.612 E.06437
G2 X135.78 Y121.482 I-1.4 J-1.599 E.06597
G1 X132.401 Y121.482 E.07007
G3 X132.143 Y123.587 I-1.935 J.831 E.04609
G1 X132.143 Y128.344 E.09868
M73 P62 R8
G3 X132.143 Y130.87 I-1.68 J1.263 E.05621
G1 X132.143 Y132.567 E.0352
M204 S10000
G1 X131.752 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6945
M204 S4000
G1 X131.752 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.752 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.639 Y121.119 Z11.52 F60000
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6945
M204 S4000
G1 X115.877 Y121.119 E.18174
G1 X115.877 Y134.881 E.28545
G1 X124.639 Y134.881 E.18174
G1 X124.639 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X125.048 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.511 Y120.71 E.18383
G1 X115.468 Y120.71 E.00083
G1 F3480
G1 X115.468 Y135.29 E.28104
G1 F3600
G1 X115.511 Y135.29 E.00083
G1 X125.048 Y135.29 E.18383
G1 X125.048 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X123.048 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.857 Y122.7 Z11.52 F60000
G1 Z11.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6945
M204 S4000
G1 X123.857 Y124.397 E.0352
G3 X123.524 Y125.269 I-1.907 J-.23 E.01955
G2 X123.751 Y127.09 I2.154 J.656 E.0392
G1 X123.857 Y127.509 E.00897
G1 X123.857 Y131.68 E.08653
G3 X123.524 Y132.552 I-1.907 J-.23 E.01955
G2 X123.788 Y134.518 I2.636 J.647 E.04212
G1 X119.957 Y134.518 E.07945
G3 X120.458 Y132.097 I2.063 J-.836 E.05437
G2 X121.552 Y130.731 I-2.847 J-3.4 E.03653
G2 X120.519 Y128 I-2.51 J-.612 E.06437
G3 X120.458 Y124.814 I1.45 J-1.621 E.07419
G2 X121.552 Y123.448 I-2.847 J-3.4 E.03653
G2 X121.213 Y121.482 I-2.197 J-.634 E.04282
G1 X117.835 Y121.482 E.07007
G3 X117.334 Y123.903 I-2.063 J.836 E.05437
M73 P62 R7
G2 X116.659 Y124.606 I5.103 J5.579 E.02023
G1 X116.659 Y127.339 E.0567
G2 X117.675 Y128.455 I32.94 J-28.969 E.03131
G3 X117.334 Y131.186 I-1.895 J1.15 E.06159
G2 X116.659 Y131.889 I5.104 J5.58 E.02023
G1 X116.659 Y133.586 E.0352
M204 S10000
G1 X116.268 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6945
M204 S4000
G1 X116.268 Y121.57 E.2259
M204 S10000
G1 X124.248 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6945
M204 S4000
G1 X124.248 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.248 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L93
M991 S0 P92 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.52 I-.704 J.993 P1  F60000
G1 X140.207 Y134.881 Z11.52
G1 Z11.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6959
M204 S4000
G1 X140.207 Y121.119 E.28545
G1 X131.445 Y121.119 E.18174
G1 X131.445 Y134.881 E.28545
G1 X140.147 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.573 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.616 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.616 Y120.71 E.28104
G1 F3600
G1 X140.573 Y120.71 E.00083
G1 X131.036 Y120.71 E.18383
G1 X131.036 Y135.29 E.28104
G1 X140.513 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.616 Y135.29 E-.03914
G1 X140.616 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.816 Y134.49 Z11.64 F60000
G1 Z11.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6959
M204 S4000
G1 X139.816 Y121.57 E.2259
M204 S10000
G1 X139.425 Y121.808 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6959
M204 S4000
G1 X139.425 Y123.505 E.0352
G2 X138.206 Y124.814 I198.599 J186.172 E.0371
G2 X138.376 Y127.09 I1.959 J.998 E.04977
G3 X139.425 Y128.232 I-43.885 J41.368 E.03217
G1 X139.425 Y130.788 E.05302
G3 X138.597 Y131.642 I-4.344 J-3.384 E.02472
G2 X138.5 Y134.518 I1.376 J1.486 E.0664
G1 X134.428 Y134.518 E.08447
G3 X134.308 Y133.918 I.941 J-.501 E.01288
G3 X135.611 Y131.642 I2.941 J.173 E.05638
G2 X136.259 Y130.276 I-1.3 J-1.453 E.0322
G2 X134.955 Y128 I-2.941 J.173 E.05638
G3 X134.308 Y126.634 I1.3 J-1.453 E.0322
G3 X135.611 Y124.358 I2.941 J.173 E.05638
G2 X135.707 Y121.482 I-1.376 J-1.486 E.0664
G1 X132.497 Y121.482 E.0666
G3 X132.227 Y123.381 I-2.101 J.67 E.04116
G1 X132.227 Y128.3 E.10203
G3 X132.227 Y130.664 I-1.676 J1.182 E.05226
G1 X132.227 Y132.361 E.0352
M204 S10000
G1 X131.836 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6959
M204 S4000
G1 X131.836 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.836 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.603 Y121.135 Z11.64 F60000
G1 X124.555 Y121.119 Z11.64
G1 Z11.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6959
M204 S4000
G1 X115.793 Y121.119 E.18174
G1 X115.793 Y134.881 E.28545
G1 X124.555 Y134.881 E.18174
G1 X124.555 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.964 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.427 Y120.71 E.18383
G1 X115.384 Y120.71 E.00083
G1 F3480
G1 X115.384 Y135.29 E.28104
G1 F3600
G1 X115.427 Y135.29 E.00083
G1 X124.964 Y135.29 E.18383
G1 X124.964 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.964 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.773 Y122.849 Z11.64 F60000
G1 Z11.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6959
M204 S4000
G1 X123.773 Y124.546 E.0352
G2 X123.773 Y127.022 I1.814 J1.238 E.05458
G1 X123.773 Y131.829 E.0997
G2 X123.773 Y134.306 I1.814 J1.238 E.05458
G1 X123.773 Y134.518 E.0044
G1 X119.862 Y134.518 E.08113
G3 X120.559 Y132.097 I2.224 J-.671 E.05524
G2 X121.636 Y130.731 I-2.041 J-2.718 E.03648
G2 X120.875 Y128.455 I-2.427 J-.454 E.05198
G3 X119.798 Y127.09 I2.041 J-2.718 E.03648
G3 X120.559 Y124.814 I2.427 J-.454 E.05198
G2 X121.636 Y123.448 I-2.041 J-2.718 E.03648
G2 X121.141 Y121.482 I-2.332 J-.458 E.04344
G1 X117.931 Y121.482 E.0666
G3 X117.233 Y123.903 I-2.224 J.671 E.05524
G2 X116.575 Y124.56 I2.693 J3.361 E.01932
G1 X116.575 Y127.146 E.05365
G3 X117.794 Y128.455 I-197.909 J185.526 E.0371
G3 X117.233 Y131.186 I-2.059 J1 E.06218
G2 X116.575 Y131.843 I2.694 J3.362 E.01932
G1 X116.575 Y133.54 E.0352
M204 S10000
G1 X116.184 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6959
M204 S4000
G1 X116.184 Y121.57 E.2259
M204 S10000
G1 X124.164 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6959
M204 S4000
G1 X124.164 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.164 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L94
M991 S0 P93 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.64 I-.699 J.996 P1  F60000
G1 X140.291 Y134.881 Z11.64
G1 Z11.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7069
M204 S4000
G1 X140.291 Y121.119 E.28545
G1 X131.529 Y121.119 E.18174
G1 X131.529 Y134.881 E.28545
G1 X140.231 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.657 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.7 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.7 Y120.71 E.28104
G1 F3600
G1 X140.657 Y120.71 E.00083
G1 X131.12 Y120.71 E.18383
G1 X131.12 Y135.29 E.28104
G1 X140.597 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.7 Y135.29 E-.03914
G1 X140.7 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.9 Y134.49 Z11.76 F60000
G1 Z11.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7069
M204 S4000
G1 X139.9 Y121.57 E.2259
M204 S10000
G1 X139.509 Y121.513 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7069
M204 S4000
G1 X139.509 Y123.21 E.0352
G1 X139.419 Y123.448 E.00528
G2 X138.074 Y124.814 I5.132 J6.398 E.03984
G2 X138.431 Y127.09 I2.097 J.837 E.05015
G1 X139.394 Y128 E.0275
G1 X139.509 Y128.265 E.00598
G1 X139.509 Y130.493 E.04622
G1 X139.419 Y130.731 E.00528
G2 X138.074 Y132.097 I5.133 J6.398 E.03984
G2 X138.584 Y134.518 I2.037 J.835 E.0545
G1 X134.322 Y134.518 E.08841
G3 X134.789 Y132.552 I2.274 J-.498 E.04335
G2 X136.134 Y131.186 I-5.132 J-6.397 E.03984
G2 X135.777 Y128.91 I-2.097 J-.837 E.05015
G3 X134.433 Y127.545 I5.132 J-6.397 E.03984
G3 X134.789 Y125.269 I2.097 J-.837 E.05015
G2 X136.134 Y123.903 I-5.132 J-6.398 E.03984
G2 X135.623 Y121.482 I-2.037 J-.835 E.0545
G1 X132.603 Y121.482 E.06266
G3 X132.311 Y123.171 I-2.173 J.494 E.03649
G1 X132.311 Y128.239 E.10512
G1 X132.492 Y128.455 E.00586
G3 X132.311 Y130.454 I-2.005 J.826 E.04328
G1 X132.311 Y132.151 E.0352
M204 S10000
G1 X131.92 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7069
M204 S4000
G1 X131.92 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X131.92 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.67 Y121.185 Z11.76 F60000
G1 X124.471 Y121.119 Z11.76
G1 Z11.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7069
M204 S4000
G1 X115.709 Y121.119 E.18174
G1 X115.709 Y134.881 E.28545
G1 X124.471 Y134.881 E.18174
G1 X124.471 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.88 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.343 Y120.71 E.18383
G1 X115.3 Y120.71 E.00083
G1 F3480
G1 X115.3 Y135.29 E.28104
G1 F3600
G1 X115.343 Y135.29 E.00083
M73 P63 R7
G1 X124.88 Y135.29 E.18383
G1 X124.88 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.88 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.689 Y122.887 Z11.76 F60000
G1 Z11.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7069
M204 S4000
G1 X123.689 Y124.584 E.0352
G2 X123.689 Y126.812 I1.564 J1.114 E.04932
G1 X123.689 Y131.867 E.10484
G2 X123.689 Y134.095 I1.564 J1.114 E.04932
G1 X123.689 Y134.518 E.00876
G1 X119.756 Y134.518 E.08158
G3 X120.223 Y132.552 I2.274 J-.498 E.04335
G2 X121.568 Y131.186 I-5.132 J-6.397 E.03984
G2 X121.211 Y128.91 I-2.097 J-.837 E.05015
G3 X119.866 Y127.545 I5.132 J-6.397 E.03984
G3 X120.223 Y125.269 I2.097 J-.837 E.05015
G2 X121.568 Y123.903 I-5.132 J-6.398 E.03984
G2 X121.057 Y121.482 I-2.037 J-.835 E.0545
G1 X118.036 Y121.482 E.06266
G3 X117.569 Y123.448 I-2.274 J.498 E.04336
G2 X116.491 Y124.496 I3.913 J5.107 E.03125
G1 X116.491 Y126.947 E.05084
G1 X116.581 Y127.09 E.00351
G3 X117.926 Y128.455 I-5.132 J6.398 E.03984
G3 X117.569 Y130.731 I-2.097 J.837 E.05015
G2 X116.491 Y131.779 I3.914 J5.108 E.03125
G1 X116.491 Y134.23 E.05084
G2 X116.735 Y134.518 I.687 J-.335 E.00791
G1 X118.432 Y134.518 E.0352
M204 S10000
G1 X116.1 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7069
M204 S4000
G1 X116.1 Y121.57 E.2259
M204 S10000
G1 X124.08 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7069
M204 S4000
G1 X124.08 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X124.08 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L95
M991 S0 P94 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.76 I-.694 J1 P1  F60000
G1 X140.375 Y134.881 Z11.76
G1 Z11.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7110
M204 S4000
G1 X140.375 Y121.119 E.28545
G1 X131.613 Y121.119 E.18174
G1 X131.613 Y134.881 E.28545
G1 X140.315 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.741 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.784 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.784 Y120.71 E.28104
G1 F3600
G1 X140.741 Y120.71 E.00083
G1 X131.204 Y120.71 E.18383
G1 X131.204 Y135.29 E.28104
G1 X140.681 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.784 Y135.29 E-.03914
G1 X140.784 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.984 Y134.49 Z11.88 F60000
G1 Z11.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7110
M204 S4000
G1 X139.984 Y121.57 E.2259
M204 S10000
G1 X139.551 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7110
M204 S4000
G1 X139.593 Y121.482 E.00086
G1 X139.593 Y123.137 E.03434
G1 X139.367 Y123.448 E.00797
G1 X138.292 Y124.358 E.02922
G1 X137.924 Y124.814 E.01214
G2 X138.483 Y127.09 I2.3 J.642 E.05081
G1 X139.593 Y128.044 E.03037
G1 X139.593 Y130.421 E.0493
G1 X139.367 Y130.731 E.00797
G1 X138.292 Y131.642 E.02922
G1 X137.924 Y132.097 E.01214
G2 X138.654 Y134.518 I2.241 J.645 E.05544
G1 X134.203 Y134.518 E.09233
G3 X134.841 Y132.552 I2.47 J-.285 E.04421
G1 X135.916 Y131.642 E.02922
G1 X136.284 Y131.186 E.01214
G2 X135.725 Y128.91 I-2.3 J-.642 E.05081
G1 X134.65 Y128 E.02922
G1 X134.282 Y127.545 E.01214
G3 X134.841 Y125.269 I2.3 J-.642 E.05081
G1 X135.916 Y124.358 E.02922
G1 X136.284 Y123.903 E.01214
G2 X135.554 Y121.482 I-2.241 J-.645 E.05544
G1 X132.722 Y121.482 E.05874
G3 X132.395 Y123.021 I-2.435 J.287 E.03321
G1 X132.395 Y128.149 E.10638
G1 X132.642 Y128.455 E.00817
G3 X132.395 Y130.304 I-2.246 J.64 E.03979
G1 X132.395 Y132.001 E.0352
M204 S10000
G1 X132.004 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7110
M204 S4000
G1 X132.004 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.004 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.739 Y121.232 Z11.88 F60000
G1 X124.387 Y121.119 Z11.88
G1 Z11.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7110
M204 S4000
G1 X115.625 Y121.119 E.18174
G1 X115.625 Y134.881 E.28545
G1 X124.387 Y134.881 E.18174
G1 X124.387 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.796 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.259 Y120.71 E.18383
G1 X115.216 Y120.71 E.00083
G1 F3480
G1 X115.216 Y135.29 E.28104
G1 F3600
G1 X115.259 Y135.29 E.00083
G1 X124.796 Y135.29 E.18383
G1 X124.796 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.796 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.605 Y122.811 Z11.88 F60000
G1 Z11.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7110
M204 S4000
G1 X123.605 Y124.508 E.0352
G2 X123.265 Y125.724 I1.029 J.944 E.02719
G2 X123.605 Y126.667 I3.678 J-.795 E.02085
G1 X123.605 Y131.791 E.10628
G2 X123.265 Y133.007 I1.029 J.944 E.02719
G2 X123.605 Y133.95 I3.678 J-.795 E.02085
G1 X123.605 Y134.518 E.01178
G1 X119.637 Y134.518 E.08231
G3 X120.275 Y132.552 I2.47 J-.285 E.04421
G1 X121.35 Y131.642 E.02922
G2 X121.811 Y130.276 I-.998 J-1.097 E.03122
G2 X121.159 Y128.91 I-2.908 J.55 E.03174
G1 X120.084 Y128 E.02922
G3 X119.623 Y126.634 I.998 J-1.097 E.03122
G3 X120.275 Y125.269 I2.909 J.55 E.03174
G1 X121.35 Y124.358 E.02922
G2 X121.811 Y122.993 I-.998 J-1.097 E.03122
G2 X120.988 Y121.482 I-2.513 J.39 E.03641
G1 X118.156 Y121.482 E.05874
G3 X117.518 Y123.448 I-2.47 J.285 E.04422
G1 X116.407 Y124.402 E.03037
G1 X116.407 Y126.779 E.0493
G1 X116.633 Y127.09 E.00797
G1 X117.708 Y128 E.02922
G3 X118.169 Y129.366 I-.998 J1.097 E.03122
G3 X117.518 Y130.731 I-2.908 J-.55 E.03174
G1 X116.407 Y131.685 E.03037
G1 X116.407 Y134.062 E.0493
G2 X116.805 Y134.518 I1.135 J-.589 E.01267
G1 X118.502 Y134.518 E.0352
M204 S10000
G1 X116.016 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7110
M204 S4000
G1 X116.016 Y121.57 E.2259
M204 S10000
G1 X123.996 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7110
M204 S4000
G1 X123.996 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X123.996 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L96
M991 S0 P95 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.88 I-.689 J1.003 P1  F60000
G1 X140.459 Y134.881 Z11.88
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7175
M204 S4000
G1 X140.459 Y121.119 E.28545
G1 X131.697 Y121.119 E.18174
G1 X131.697 Y134.881 E.28545
G1 X140.399 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.825 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.868 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.868 Y120.71 E.28104
G1 F3600
G1 X140.825 Y120.71 E.00083
G1 X131.288 Y120.71 E.18383
G1 X131.288 Y135.29 E.28104
G1 X140.765 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.868 Y135.29 E-.03914
G1 X140.868 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.068 Y134.49 Z12 F60000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7175
M204 S4000
G1 X140.068 Y121.57 E.2259
M204 S10000
G1 X139.514 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7175
M204 S4000
G1 X139.677 Y121.482 E.00337
G1 X139.677 Y123.016 E.03183
G1 X139.318 Y123.448 E.01165
G1 X138.091 Y124.358 E.03169
G1 X137.747 Y124.814 E.01184
G2 X138.532 Y127.09 I2.606 J.375 E.05186
G1 X139.677 Y127.94 E.02959
G1 X139.677 Y130.3 E.04895
G1 X139.318 Y130.731 E.01165
G1 X138.091 Y131.642 E.03169
G1 X137.747 Y132.097 E.01184
G1 X137.689 Y132.552 E.00952
G1 X137.91 Y133.462 E.01943
G2 X138.727 Y134.518 I2.586 J-1.158 E.02795
G1 X134.066 Y134.518 E.09669
G3 X134.89 Y132.552 I2.689 J-.028 E.04546
G1 X136.117 Y131.642 E.03169
G1 X136.461 Y131.186 E.01184
G2 X135.676 Y128.91 I-2.606 J-.375 E.05186
G1 X134.449 Y128 E.03169
G1 X134.105 Y127.545 E.01184
G3 X134.89 Y125.269 I2.606 J-.375 E.05186
G1 X136.117 Y124.358 E.03169
G1 X136.461 Y123.903 E.01184
G1 X136.519 Y123.448 E.00952
G1 X136.297 Y122.538 E.01943
G2 X135.481 Y121.482 I-2.587 J1.158 E.02795
G1 X132.859 Y121.482 E.05438
G1 X132.877 Y121.627 E.00304
G1 X132.656 Y122.538 E.01943
G1 X132.479 Y122.87 E.00781
G1 X132.479 Y128.005 E.10651
G1 X132.819 Y128.455 E.01171
G1 X132.877 Y128.91 E.00952
G1 X132.656 Y129.821 E.01943
G1 X132.479 Y130.153 E.00781
G1 X132.479 Y131.85 E.0352
M204 S10000
G1 X132.088 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7175
M204 S4000
G1 X132.088 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.088 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.808 Y121.278 Z12 F60000
G1 X124.303 Y121.119 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7175
M204 S4000
G1 X115.541 Y121.119 E.18174
G1 X115.541 Y134.881 E.28545
G1 X124.303 Y134.881 E.18174
G1 X124.303 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.712 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.175 Y120.71 E.18383
G1 X115.132 Y120.71 E.00083
G1 F3480
G1 X115.132 Y135.29 E.28104
G1 F3600
G1 X115.175 Y135.29 E.00083
G1 X124.712 Y135.29 E.18383
G1 X124.712 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.712 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.521 Y122.666 Z12 F60000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7175
M204 S4000
G1 X123.521 Y124.363 E.0352
G1 X123.181 Y124.814 E.01171
G1 X123.123 Y125.269 E.00952
G1 X123.344 Y126.179 E.01943
G1 X123.521 Y126.511 E.0078
G1 X123.521 Y131.647 E.10652
M73 P64 R7
G1 X123.181 Y132.097 E.01171
G1 X123.123 Y132.552 E.00952
G1 X123.344 Y133.462 E.01943
G1 X123.521 Y133.794 E.0078
G1 X123.521 Y134.518 E.01501
G1 X119.5 Y134.518 E.08341
G1 X119.481 Y134.373 E.00303
G3 X120.324 Y132.552 I2.998 J.282 E.04243
G1 X121.551 Y131.642 E.03169
G1 X121.895 Y131.186 E.01184
G1 X121.953 Y130.731 E.00952
G2 X121.11 Y128.91 I-2.998 J.282 E.04243
G1 X119.883 Y128 E.03169
G1 X119.539 Y127.545 E.01184
G1 X119.481 Y127.09 E.00952
G3 X120.324 Y125.269 I2.998 J.282 E.04243
G1 X121.551 Y124.358 E.03169
G1 X121.895 Y123.903 E.01184
G1 X121.953 Y123.448 E.00952
G2 X121.11 Y121.627 I-2.998 J.282 E.04243
G1 X120.914 Y121.482 E.00505
G1 X118.293 Y121.482 E.05438
G1 X118.311 Y121.627 E.00304
G3 X117.468 Y123.448 I-2.998 J-.282 E.04243
G1 X116.323 Y124.298 E.02959
G1 X116.323 Y126.658 E.04895
G1 X116.682 Y127.09 E.01165
G1 X117.909 Y128 E.03169
G1 X118.253 Y128.455 E.01184
G1 X118.311 Y128.91 E.00952
G3 X117.468 Y130.731 I-2.998 J-.282 E.04243
G1 X116.323 Y131.581 E.02959
G1 X116.323 Y133.941 E.04895
G2 X116.878 Y134.518 I1.465 J-.854 E.01676
G1 X118.575 Y134.518 E.0352
M204 S10000
G1 X115.932 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7175
M204 S4000
G1 X115.932 Y121.57 E.2259
M204 S10000
G1 X123.912 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7175
M204 S4000
G1 X123.912 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.912 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L97
M991 S0 P96 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12 I-.684 J1.006 P1  F60000
G1 X140.543 Y134.881 Z12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7266
M204 S4000
G1 X140.543 Y121.119 E.28545
G1 X131.781 Y121.119 E.18174
G1 X131.781 Y134.881 E.28545
G1 X140.483 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.909 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X140.952 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X140.952 Y120.71 E.28104
G1 F3600
G1 X140.909 Y120.71 E.00083
G1 X131.372 Y120.71 E.18383
G1 X131.372 Y135.29 E.28104
G1 X140.849 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X140.952 Y135.29 E-.03914
G1 X140.952 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.152 Y134.49 Z12.12 F60000
G1 Z11.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7266
M204 S4000
G1 X140.152 Y121.57 E.2259
M204 S10000
G1 X139.48 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7266
M204 S4000
G1 X139.761 Y121.482 E.00584
G1 X139.761 Y122.898 E.02936
G1 X139.703 Y122.993 E.00232
G3 X137.813 Y124.358 I-4.749 J-4.582 E.04862
G1 X137.529 Y124.814 E.01113
G2 X138.147 Y126.634 I3.89 J-.306 E.0403
G2 X139.761 Y127.839 I4.291 J-4.065 E.04199
G1 X139.761 Y130.181 E.04857
G1 X139.703 Y130.276 E.00232
G3 X137.813 Y131.642 I-4.749 J-4.582 E.04862
G1 X137.529 Y132.097 E.01113
G2 X138.794 Y134.518 I3.025 J-.04 E.0588
G1 X133.905 Y134.518 E.10142
G3 X134.505 Y133.007 I4.475 J.904 E.0339
G3 X136.395 Y131.642 I4.749 J4.582 E.04862
G1 X136.679 Y131.186 E.01113
G2 X136.061 Y129.366 I-3.89 J.306 E.0403
G2 X134.171 Y128 I-4.749 J4.582 E.04862
G1 X133.887 Y127.545 E.01113
G3 X134.505 Y125.724 I3.89 J.306 E.0403
G3 X136.395 Y124.358 I4.749 J4.582 E.04862
G1 X136.679 Y123.903 E.01113
G2 X135.413 Y121.482 I-3.025 J.04 E.0588
G1 X133.02 Y121.482 E.04964
G1 X132.699 Y122.538 E.02289
G1 X132.563 Y122.759 E.00539
G1 X132.563 Y127.889 E.1064
G1 X132.754 Y128 E.00458
G1 X133.038 Y128.455 E.01113
G1 X133.012 Y128.91 E.00946
G1 X132.699 Y129.821 E.01997
G1 X132.563 Y130.042 E.00539
G1 X132.563 Y131.739 E.0352
M204 S10000
G1 X132.172 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7266
M204 S4000
G1 X132.172 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.172 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.878 Y121.322 Z12.12 F60000
G1 X124.219 Y121.119 Z12.12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7266
M204 S4000
G1 X115.457 Y121.119 E.18174
G1 X115.457 Y134.881 E.28545
G1 X124.219 Y134.881 E.18174
G1 X124.219 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.628 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.091 Y120.71 E.18383
G1 X115.048 Y120.71 E.00083
G1 F3480
G1 X115.048 Y135.29 E.28104
G1 F3600
G1 X115.091 Y135.29 E.00083
G1 X124.628 Y135.29 E.18383
G1 X124.628 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.628 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.437 Y122.522 Z12.12 F60000
G1 Z11.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7266
M204 S4000
G1 X123.437 Y124.219 E.0352
G2 X122.988 Y125.269 I.451 J.814 E.02551
G1 X123.301 Y126.179 E.01997
G1 X123.437 Y126.401 E.00539
G1 X123.437 Y131.502 E.10581
G2 X122.988 Y132.552 I.451 J.814 E.02551
G1 X123.301 Y133.462 E.01997
G1 X123.437 Y133.684 E.00539
G1 X123.437 Y134.518 E.0173
G1 X119.338 Y134.518 E.08501
G1 X119.347 Y134.373 E.00302
G3 X121.048 Y132.097 I3.131 J.566 E.0611
G1 X121.829 Y131.642 E.01875
G1 X122.113 Y131.186 E.01113
G1 X122.087 Y130.731 E.00946
G2 X120.386 Y128.455 I-3.131 J.566 E.0611
G1 X119.605 Y128 E.01875
G1 X119.321 Y127.545 E.01113
G1 X119.347 Y127.09 E.00946
G3 X121.048 Y124.814 I3.131 J.566 E.0611
G1 X121.829 Y124.358 E.01875
G1 X122.113 Y123.903 E.01113
G1 X122.087 Y123.448 E.00946
G2 X120.847 Y121.482 I-3.012 J.526 E.04946
G1 X118.454 Y121.482 E.04964
G1 X118.446 Y121.627 E.00302
G3 X116.744 Y123.903 I-3.131 J-.566 E.0611
G1 X116.239 Y124.198 E.01213
G1 X116.239 Y126.539 E.04857
G2 X117.407 Y127.545 I2.896 J-2.182 E.03221
G1 X118.187 Y128 E.01875
G1 X118.472 Y128.455 E.01113
G1 X118.446 Y128.91 E.00946
G3 X116.744 Y131.186 I-3.131 J-.566 E.0611
G1 X116.239 Y131.481 E.01213
G1 X116.239 Y133.822 E.04857
G2 X116.945 Y134.518 I2.586 J-1.919 E.02064
G1 X118.642 Y134.518 E.0352
M204 S10000
G1 X115.848 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7266
M204 S4000
G1 X115.848 Y121.57 E.2259
M204 S10000
G1 X123.828 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7266
M204 S4000
G1 X123.828 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.828 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L98
M991 S0 P97 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.12 I-.68 J1.009 P1  F60000
G1 X140.627 Y134.881 Z12.12
G1 Z11.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7383
M204 S4000
G1 X140.627 Y121.119 E.28545
G1 X131.865 Y121.119 E.18174
G1 X131.865 Y134.881 E.28545
G1 X140.567 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X140.993 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.036 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.036 Y120.71 E.28104
G1 F3600
G1 X140.993 Y120.71 E.00083
G1 X131.456 Y120.71 E.18383
G1 X131.456 Y135.29 E.28104
G1 X140.933 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.036 Y135.29 E-.03914
G1 X141.036 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.236 Y134.49 Z12.24 F60000
G1 Z11.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7383
M204 S4000
G1 X140.236 Y121.57 E.2259
M204 S10000
G1 X132.647 Y124.369 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7383
M204 S4000
G1 X132.647 Y122.672 E.0352
G2 X133.22 Y121.482 I-4.203 J-2.758 E.02747
G1 X135.355 Y121.482 E.04427
G3 X136.649 Y123.052 I-1.834 J2.83 E.04287
G1 X137.104 Y124.208 E.02577
G2 X138.014 Y124.048 I.194 J-1.571 E.01945
G2 X139.845 Y122.825 I-1.012 J-3.496 E.0464
G1 X139.845 Y127.693 E.10098
G3 X137.559 Y125.665 I.949 J-3.372 E.0656
G1 X137.104 Y124.509 E.02577
G2 X136.194 Y124.669 I-.194 J1.571 E.01945
G2 X133.918 Y126.694 I.952 J3.362 E.06539
G1 X133.462 Y127.849 E.02577
G3 X132.647 Y127.721 I-.198 J-1.4 E.01737
G1 X132.647 Y129.955 E.04633
G2 X133.462 Y128.151 I-6.401 J-3.979 E.04119
G3 X134.373 Y128.31 I.194 J1.571 E.01945
G3 X136.649 Y130.335 I-.952 J3.362 E.06539
G1 X137.104 Y131.491 E.02577
G2 X138.014 Y131.331 I.194 J-1.571 E.01945
G2 X139.845 Y130.108 I-1.012 J-3.496 E.0464
G1 X139.845 Y134.518 E.09147
G1 X138.853 Y134.518 E.02058
G3 X137.559 Y132.948 I1.834 J-2.829 E.04287
G1 X137.104 Y131.792 E.02577
G2 X136.194 Y131.952 I-.194 J1.571 E.01945
G2 X133.918 Y133.977 I.952 J3.362 E.06539
G1 X133.539 Y134.518 E.0137
G1 X132.647 Y134.518 E.01849
G1 X132.647 Y133.712 E.01671
M204 S10000
G1 X132.256 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7383
M204 S4000
G1 X132.256 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.256 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.949 Y121.365 Z12.24 F60000
G1 X124.135 Y121.119 Z12.24
G1 Z11.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7383
M204 S4000
G1 X115.373 Y121.119 E.18174
G1 X115.373 Y134.881 E.28545
G1 X124.135 Y134.881 E.18174
G1 X124.135 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.544 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X115.007 Y120.71 E.18383
G1 X114.964 Y120.71 E.00083
G1 F3480
G1 X114.964 Y135.29 E.28104
G1 F3600
G1 X115.007 Y135.29 E.00083
G1 X124.544 Y135.29 E.18383
G1 X124.544 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.544 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.155 Y122.355 Z12.24 F60000
G1 Z11.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7383
M204 S4000
G1 X116.155 Y124.052 E.0352
G2 X117.531 Y123.328 I-2.932 J-7.246 E.03229
G2 X118.654 Y121.482 I-3.614 J-3.464 E.04519
G1 X120.789 Y121.482 E.04427
G3 X121.627 Y122.232 I-1.314 J2.312 E.02352
G3 X122.538 Y124.208 I-7 J4.423 E.04525
G2 X123.353 Y124.08 I.198 J-1.4 E.01737
G1 X123.353 Y126.313 E.04633
G3 X122.538 Y124.509 I6.401 J-3.979 E.04118
G2 X121.627 Y124.669 I-.194 J1.571 E.01945
G2 X119.807 Y125.874 I1.067 J3.59 E.04596
G2 X118.896 Y127.849 I7 J4.423 E.04525
G3 X117.986 Y127.69 I-.194 J-1.571 E.01946
G3 X116.155 Y126.467 I1.012 J-3.496 E.0464
G1 X116.155 Y131.335 E.10098
G2 X117.986 Y130.126 I-1.295 J-3.952 E.04605
G2 X118.896 Y128.151 I-7 J-4.423 E.04525
G3 X119.807 Y128.31 I.194 J1.571 E.01945
G3 X121.627 Y129.516 I-1.067 J3.59 E.04596
G3 X122.538 Y131.491 I-7 J4.423 E.04525
G2 X123.353 Y131.363 I.198 J-1.4 E.01737
G1 X123.353 Y133.596 E.04633
M73 P65 R7
G3 X122.538 Y131.792 I6.401 J-3.979 E.04118
G2 X121.627 Y131.952 I-.194 J1.571 E.01945
G2 X119.807 Y133.157 I1.067 J3.59 E.04596
G3 X118.972 Y134.518 I-6.928 J-3.311 E.03317
G1 X117.004 Y134.518 E.04084
G3 X116.155 Y133.75 I2.328 J-3.424 E.02382
G1 X116.155 Y132.053 E.0352
M204 S10000
G1 X115.764 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7383
M204 S4000
G1 X115.764 Y121.57 E.2259
M204 S10000
G1 X123.744 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7383
M204 S4000
G1 X123.744 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 11.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.744 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L99
M991 S0 P98 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.24 I-.675 J1.013 P1  F60000
G1 X140.711 Y134.881 Z12.24
G1 Z11.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7216
M204 S4000
G1 X140.711 Y121.119 E.28545
G1 X131.949 Y121.119 E.18174
G1 X131.949 Y134.881 E.28545
G1 X140.651 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.077 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.12 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.12 Y120.71 E.28104
G1 F3600
G1 X141.077 Y120.71 E.00083
G1 X131.54 Y120.71 E.18383
G1 X131.54 Y135.29 E.28104
G1 X141.017 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.12 Y135.29 E-.03914
G1 X141.12 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.32 Y134.49 Z12.36 F60000
G1 Z11.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7216
M204 S4000
G1 X140.32 Y121.57 E.2259
M204 S10000
G1 X132.731 Y124.322 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7216
M204 S4000
G1 X132.731 Y122.625 E.0352
G2 X133.445 Y121.482 I-8.792 J-6.289 E.02798
G1 X135.277 Y121.482 E.038
G3 X136.649 Y122.855 I-1.412 J2.781 E.04094
G1 X137.104 Y123.622 E.01849
G1 X137.559 Y123.914 E.01122
G1 X138.014 Y123.896 E.00945
G2 X139.929 Y122.75 I-.502 J-3.011 E.04739
G1 X139.929 Y127.541 E.09938
G1 X139.835 Y127.538 E.00195
G3 X137.559 Y125.862 I.535 J-3.11 E.06079
G1 X137.104 Y125.095 E.01849
G1 X136.649 Y124.803 E.01122
G1 X136.194 Y124.821 E.00945
G2 X133.918 Y126.497 I.535 J3.11 E.06079
G1 X133.462 Y127.263 E.01849
G1 X133.007 Y127.555 E.01122
G1 X132.731 Y127.545 E.00573
G1 X132.731 Y129.908 E.04903
G2 X133.462 Y128.737 I-9.013 J-6.44 E.02867
G1 X133.918 Y128.445 E.01122
G1 X134.373 Y128.462 E.00945
G3 X136.649 Y130.138 I-.535 J3.11 E.06079
G1 X137.104 Y130.905 E.01849
G1 X137.559 Y131.197 E.01122
G1 X138.014 Y131.179 E.00945
G2 X139.929 Y130.033 I-.502 J-3.011 E.04739
G1 X139.929 Y134.518 E.09302
G3 X138.925 Y134.516 I-.494 J-4.132 E.02088
G3 X137.559 Y133.145 I1.622 J-2.981 E.04071
G1 X137.104 Y132.378 E.01849
G1 X136.649 Y132.086 E.01122
G1 X136.194 Y132.104 E.00945
G2 X133.918 Y133.78 I.535 J3.11 E.06079
G1 X133.479 Y134.518 E.0178
G1 X135.176 Y134.518 E.0352
M204 S10000
G1 X132.34 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7216
M204 S4000
G1 X132.34 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.34 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.021 Y121.406 Z12.36 F60000
G1 X124.051 Y121.119 Z12.36
G1 Z11.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7216
M204 S4000
G1 X115.289 Y121.119 E.18174
G1 X115.289 Y134.881 E.28545
G1 X124.051 Y134.881 E.18174
G1 X124.051 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.46 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.923 Y120.71 E.18383
G1 X114.88 Y120.71 E.00083
G1 F3480
G1 X114.88 Y135.29 E.28104
G1 F3600
G1 X114.923 Y135.29 E.00083
G1 X124.46 Y135.29 E.18383
G1 X124.46 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.46 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.071 Y122.203 Z12.36 F60000
G1 Z11.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7216
M204 S4000
G1 X116.071 Y123.9 E.0352
G2 X117.531 Y123.315 I-1.044 J-4.718 E.03276
G2 X118.879 Y121.482 I-4.493 J-4.719 E.04744
G1 X120.711 Y121.482 E.038
G3 X121.172 Y121.761 I-.385 J1.158 E.01127
G3 X122.538 Y123.622 I-4.549 J4.769 E.04813
G1 X122.993 Y123.914 E.01122
G1 X123.269 Y123.903 E.00573
G1 X123.269 Y126.267 E.04902
G3 X122.538 Y125.095 I9.012 J-6.44 E.02866
G1 X122.083 Y124.803 E.01122
G2 X120.262 Y125.402 I.236 J3.783 E.0402
G2 X118.896 Y127.263 I4.549 J4.769 E.04813
G1 X118.441 Y127.555 E.01122
G3 X116.071 Y126.391 I.007 J-3.01 E.0567
G1 X116.071 Y131.183 E.09939
G2 X117.531 Y130.598 I-1.044 J-4.718 E.03276
G2 X118.896 Y128.737 I-4.549 J-4.769 E.04813
G1 X119.351 Y128.445 E.01122
G3 X121.172 Y129.044 I-.236 J3.783 E.0402
G3 X122.538 Y130.905 I-4.549 J4.769 E.04813
G1 X122.993 Y131.197 E.01122
G1 X123.269 Y131.186 E.00573
G1 X123.269 Y133.55 E.04902
G3 X122.538 Y132.378 I9.009 J-6.438 E.02866
G1 X122.083 Y132.086 E.01122
G2 X120.262 Y132.685 I.236 J3.783 E.0402
G2 X118.913 Y134.518 I4.492 J4.718 E.04744
G1 X117.091 Y134.518 E.0378
G3 X116.071 Y133.675 I.756 J-1.953 E.02793
G1 X116.071 Y131.978 E.0352
M204 S10000
G1 X115.68 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7216
M204 S4000
G1 X115.68 Y121.57 E.2259
M204 S10000
G1 X123.66 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7216
M204 S4000
G1 X123.66 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.66 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L100
M991 S0 P99 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.36 I-.67 J1.016 P1  F60000
G1 X140.795 Y134.881 Z12.36
G1 Z12.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7142
M204 S4000
G1 X140.795 Y121.119 E.28545
G1 X132.033 Y121.119 E.18174
G1 X132.033 Y134.881 E.28545
G1 X140.735 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.161 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.204 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.204 Y120.71 E.28104
G1 F3600
G1 X141.161 Y120.71 E.00083
G1 X131.624 Y120.71 E.18383
G1 X131.624 Y135.29 E.28104
G1 X141.101 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.204 Y135.29 E-.03914
G1 X141.204 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.404 Y134.49 Z12.48 F60000
G1 Z12.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7142
M204 S4000
G1 X140.404 Y121.57 E.2259
M204 S10000
G1 X132.815 Y124.281 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7142
M204 S4000
G1 X132.815 Y122.584 E.0352
G1 X133.462 Y121.722 E.02236
G1 X133.778 Y121.482 E.00822
G1 X135.094 Y121.482 E.02731
G3 X136.194 Y122.141 I-.733 J2.47 E.02686
G1 X137.104 Y123.353 E.03145
G1 X137.559 Y123.7 E.01187
G1 X138.014 Y123.763 E.00953
G2 X139.835 Y122.935 I-.256 J-2.978 E.04231
G1 X140.013 Y122.698 E.00615
G1 X140.013 Y127.38 E.09712
G1 X139.835 Y127.405 E.00373
G3 X138.014 Y126.576 I.256 J-2.978 E.04231
G1 X137.104 Y125.364 E.03145
G1 X136.649 Y125.017 E.01187
G1 X136.194 Y124.954 E.00953
G2 X134.373 Y125.782 I.256 J2.978 E.04231
G1 X133.462 Y126.995 E.03145
G1 X133.007 Y127.341 E.01187
G1 X132.815 Y127.368 E.00402
G1 X132.815 Y129.868 E.05184
G1 X133.462 Y129.006 E.02236
G1 X133.918 Y128.659 E.01187
G1 X134.373 Y128.595 E.00953
G3 X136.194 Y129.424 I-.256 J2.978 E.04231
G1 X137.104 Y130.636 E.03145
G1 X137.559 Y130.983 E.01187
G1 X138.014 Y131.046 E.00953
G2 X139.835 Y130.218 I-.256 J-2.978 E.04231
G1 X140.013 Y129.981 E.00615
G1 X140.013 Y134.518 E.09411
G3 X138.925 Y134.474 I-.412 J-3.258 E.0227
G3 X138.014 Y133.859 I1.023 J-2.498 E.02294
G1 X137.104 Y132.647 E.03145
G1 X136.649 Y132.3 E.01187
G1 X136.194 Y132.237 E.00953
G2 X134.373 Y133.065 I.256 J2.978 E.04231
G1 X133.462 Y134.278 E.03145
G1 X133.147 Y134.518 E.00822
G1 X134.844 Y134.518 E.0352
M204 S10000
G1 X132.424 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7142
M204 S4000
G1 X132.424 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.424 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.093 Y121.446 Z12.48 F60000
G1 X123.967 Y121.119 Z12.48
G1 Z12.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7142
M204 S4000
G1 X115.205 Y121.119 E.18174
G1 X115.205 Y134.881 E.28545
G1 X123.967 Y134.881 E.18174
G1 X123.967 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.376 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.839 Y120.71 E.18383
G1 X114.796 Y120.71 E.00083
G1 F3480
G1 X114.796 Y135.29 E.28104
G1 F3600
G1 X114.839 Y135.29 E.00083
G1 X124.376 Y135.29 E.18383
G1 X124.376 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.376 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.987 Y122.041 Z12.48 F60000
G1 Z12.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7142
M204 S4000
G1 X115.987 Y123.738 E.0352
G2 X117.986 Y122.935 I.094 J-2.653 E.04601
G1 X118.896 Y121.722 E.03145
G1 X119.212 Y121.482 E.00822
G1 X120.528 Y121.482 E.02731
G3 X121.627 Y122.141 I-.733 J2.47 E.02686
G1 X122.538 Y123.353 E.03145
G1 X122.993 Y123.7 E.01187
G1 X123.185 Y123.727 E.00402
G1 X123.185 Y126.226 E.05184
G1 X122.538 Y125.364 E.02236
G1 X122.083 Y125.017 E.01187
G2 X119.807 Y125.782 I-.399 J2.581 E.05175
G1 X118.896 Y126.995 E.03145
G1 X118.441 Y127.341 E.01187
G1 X117.986 Y127.405 E.00953
G1 X117.075 Y127.19 E.0194
G3 X115.987 Y126.339 I1.126 J-2.561 E.02896
G1 X115.987 Y131.022 E.09712
G2 X117.986 Y130.218 I.094 J-2.653 E.04601
G1 X118.896 Y129.006 E.03145
G1 X119.351 Y128.659 E.01187
G3 X121.627 Y129.424 I.399 J2.581 E.05175
G1 X122.538 Y130.636 E.03145
G1 X122.993 Y130.983 E.01187
G1 X123.185 Y131.01 E.00402
G1 X123.185 Y133.509 E.05184
G1 X122.538 Y132.647 E.02236
G1 X122.083 Y132.3 E.01187
G2 X119.807 Y133.065 I-.399 J2.581 E.05175
G1 X118.896 Y134.278 E.03145
G1 X118.581 Y134.518 E.00822
G1 X117.339 Y134.518 E.02576
G3 X115.987 Y133.622 I.339 J-1.98 E.03463
G1 X115.987 Y131.925 E.0352
M204 S10000
G1 X115.596 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7142
M204 S4000
G1 X115.596 Y121.57 E.2259
M204 S10000
G1 X123.576 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7142
M204 S4000
G1 X123.576 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.576 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L101
M991 S0 P100 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.48 I-.666 J1.019 P1  F60000
G1 X140.879 Y134.881 Z12.48
M73 P66 R7
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7093
M204 S4000
G1 X140.879 Y121.119 E.28545
G1 X132.117 Y121.119 E.18174
G1 X132.117 Y134.881 E.28545
G1 X140.819 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.245 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.288 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.288 Y120.71 E.28104
G1 F3600
G1 X141.245 Y120.71 E.00083
G1 X131.708 Y120.71 E.18383
G1 X131.708 Y135.29 E.28104
G1 X141.185 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.288 Y135.29 E-.03914
G1 X141.288 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.488 Y134.49 Z12.6 F60000
G1 Z12.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7093
M204 S4000
G1 X140.488 Y121.57 E.2259
M204 S10000
G1 X132.899 Y124.275 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7093
M204 S4000
G1 X132.899 Y122.578 E.0352
G3 X133.918 Y121.55 I3.3 J2.251 E.03018
G3 X136.194 Y122.091 I.657 J2.292 E.05072
G1 X137.104 Y123.156 E.02906
G2 X138.469 Y123.626 I1.11 J-1.007 E.03125
G2 X140.097 Y122.678 I-.373 J-2.511 E.04003
G1 X140.097 Y127.218 E.09419
G3 X138.014 Y126.626 I-.457 J-2.351 E.04661
G1 X137.104 Y125.561 E.02906
G2 X135.738 Y125.091 I-1.11 J1.007 E.03125
G2 X134.373 Y125.733 I.529 J2.898 E.03165
G1 X133.462 Y126.798 E.02906
G1 X132.899 Y127.196 E.0143
G1 X132.899 Y129.861 E.05529
G3 X133.918 Y128.833 I3.3 J2.251 E.03018
G3 X136.194 Y129.375 I.66 J2.28 E.05074
G1 X137.104 Y130.439 E.02906
G2 X138.469 Y130.909 I1.11 J-1.007 E.03125
G2 X140.097 Y129.961 I-.373 J-2.511 E.04003
G1 X140.097 Y134.518 E.09453
G3 X138.014 Y133.909 I-.309 J-2.809 E.0462
G1 X137.104 Y132.844 E.02906
G2 X135.738 Y132.374 I-1.11 J1.007 E.03125
G2 X134.373 Y133.016 I.529 J2.898 E.03165
G1 X133.462 Y134.081 E.02906
G1 X132.899 Y134.518 E.01479
G1 X134.557 Y134.518 E.03439
M204 S10000
G1 X132.508 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7093
M204 S4000
G1 X132.508 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.508 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.166 Y121.484 Z12.6 F60000
G1 X123.883 Y121.119 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7093
M204 S4000
G1 X115.121 Y121.119 E.18174
G1 X115.121 Y134.881 E.28545
G1 X123.883 Y134.881 E.18174
G1 X123.883 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.292 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.755 Y120.71 E.18383
G1 X114.712 Y120.71 E.00083
G1 F3480
G1 X114.712 Y135.29 E.28104
G1 F3600
G1 X114.755 Y135.29 E.00083
G1 X124.292 Y135.29 E.18383
G1 X124.292 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.292 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.903 Y121.88 Z12.6 F60000
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7093
M204 S4000
G1 X115.903 Y123.577 E.0352
G2 X117.986 Y122.984 I.457 J-2.351 E.04661
G1 X118.896 Y121.919 E.02906
G1 X119.351 Y121.55 E.01216
G3 X121.627 Y122.091 I.657 J2.292 E.05072
G1 X122.538 Y123.156 E.02906
G1 X123.101 Y123.554 E.0143
G1 X123.101 Y126.219 E.05529
G2 X122.083 Y125.192 I-3.3 J2.251 E.03018
G2 X119.807 Y125.733 I-.66 J2.28 E.05074
G1 X118.896 Y126.798 E.02906
G1 X118.441 Y127.167 E.01216
G3 X115.903 Y126.319 I-.659 J-2.25 E.05907
G1 X115.903 Y130.86 E.09419
G2 X117.986 Y130.267 I.457 J-2.351 E.04661
G1 X118.896 Y129.202 E.02906
G1 X119.351 Y128.833 E.01216
G3 X121.627 Y129.375 I.66 J2.28 E.05074
G1 X122.538 Y130.439 E.02906
G1 X123.101 Y130.837 E.0143
G1 X123.101 Y133.503 E.05529
G2 X122.083 Y132.475 I-3.3 J2.251 E.03018
G2 X119.807 Y133.016 I-.66 J2.28 E.05074
G1 X118.896 Y134.081 E.02906
G1 X118.441 Y134.45 E.01216
G3 X115.903 Y133.602 I-.594 J-2.445 E.05852
G1 X115.903 Y131.905 E.0352
M204 S10000
G1 X115.512 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7093
M204 S4000
G1 X115.512 Y121.57 E.2259
M204 S10000
G1 X123.492 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7093
M204 S4000
G1 X123.492 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.492 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L102
M991 S0 P101 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.6 I-.661 J1.022 P1  F60000
G1 X140.963 Y134.881 Z12.6
G1 Z12.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7049
M204 S4000
G1 X140.963 Y121.119 E.28545
G1 X132.201 Y121.119 E.18174
G1 X132.201 Y134.881 E.28545
G1 X140.903 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.329 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.372 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.372 Y120.71 E.28104
G1 F3600
G1 X141.329 Y120.71 E.00083
G1 X131.792 Y120.71 E.18383
G1 X131.792 Y135.29 E.28104
G1 X141.269 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.372 Y135.29 E-.03914
G1 X141.372 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.572 Y134.49 Z12.72 F60000
G1 Z12.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7049
M204 S4000
G1 X140.572 Y121.57 E.2259
M204 S10000
G1 X132.983 Y124.28 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7049
M204 S4000
G1 X132.983 Y122.583 E.0352
G3 X133.918 Y121.698 I4.408 J3.718 E.02675
G3 X136.194 Y122.039 I.851 J2.084 E.05011
G2 X137.559 Y123.377 I6.636 J-5.41 E.03973
G2 X140.181 Y122.673 I.858 J-2.038 E.06063
G1 X140.181 Y127.058 E.09096
G3 X138.014 Y126.678 I-.745 J-2.117 E.04769
G2 X136.649 Y125.34 I-6.638 J5.411 E.03973
G2 X134.373 Y125.681 I-.851 J2.084 E.05011
G3 X132.983 Y127.027 I-6.339 J-5.154 E.04023
G1 X132.983 Y129.867 E.05889
G3 X133.918 Y128.982 I4.408 J3.719 E.02675
G3 X136.194 Y129.323 I.851 J2.084 E.05011
G2 X137.559 Y130.66 I6.637 J-5.41 E.03973
G2 X140.181 Y129.956 I.858 J-2.038 E.06063
G1 X140.181 Y134.341 E.09096
G3 X138.014 Y133.961 I-.745 J-2.117 E.04769
G2 X136.649 Y132.623 I-6.637 J5.411 E.03973
G2 X134.373 Y132.964 I-.851 J2.084 E.05011
G3 X132.983 Y134.31 I-6.339 J-5.154 E.04023
G1 X132.983 Y134.518 E.0043
G1 X134.472 Y134.518 E.0309
M204 S10000
G1 X132.592 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7049
M204 S4000
G1 X132.592 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.592 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.24 Y121.521 Z12.72 F60000
G1 X123.799 Y121.119 Z12.72
G1 Z12.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7049
M204 S4000
G1 X115.037 Y121.119 E.18174
G1 X115.037 Y134.881 E.28545
G1 X123.799 Y134.881 E.18174
G1 X123.799 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.208 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.671 Y120.71 E.18383
G1 X114.628 Y120.71 E.00083
G1 F3480
G1 X114.628 Y135.29 E.28104
G1 F3600
G1 X114.671 Y135.29 E.00083
G1 X124.208 Y135.29 E.18383
G1 X124.208 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.208 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.819 Y121.72 Z12.72 F60000
G1 Z12.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7049
M204 S4000
G1 X115.819 Y123.417 E.0352
G2 X117.986 Y123.036 I.745 J-2.117 E.04769
G3 X119.351 Y121.698 I6.638 J5.411 E.03973
G3 X121.627 Y122.039 I.851 J2.084 E.05011
G2 X122.993 Y123.377 I6.636 J-5.41 E.03973
G1 X123.017 Y126.225 E.05908
G2 X122.083 Y125.34 I-4.407 J3.718 E.02675
G2 X119.807 Y125.681 I-.851 J2.084 E.05011
G3 X118.441 Y127.018 I-6.637 J-5.411 E.03973
G3 X115.819 Y126.314 I-.858 J-2.038 E.06063
G1 X115.819 Y130.7 E.09096
G2 X117.986 Y130.319 I.745 J-2.117 E.04769
G3 X119.351 Y128.982 I6.638 J5.412 E.03973
G3 X121.627 Y129.323 I.851 J2.084 E.05011
G2 X122.993 Y130.66 I6.637 J-5.41 E.03973
G1 X123.017 Y133.508 E.05908
G2 X122.083 Y132.623 I-4.407 J3.718 E.02675
G2 X119.807 Y132.964 I-.851 J2.084 E.05011
G3 X118.441 Y134.302 I-6.636 J-5.41 E.03973
G3 X115.819 Y133.597 I-.858 J-2.038 E.06063
G1 X115.819 Y131.9 E.0352
M204 S10000
G1 X115.428 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7049
M204 S4000
G1 X115.428 Y121.57 E.2259
M204 S10000
G1 X123.408 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7049
M204 S4000
G1 X123.408 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.408 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L103
M991 S0 P102 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.72 I-.657 J1.024 P1  F60000
G1 X141.047 Y134.881 Z12.72
G1 Z12.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7018
M204 S4000
G1 X141.047 Y121.119 E.28545
M73 P66 R6
G1 X132.285 Y121.119 E.18174
G1 X132.285 Y134.881 E.28545
G1 X140.987 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.413 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.456 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.456 Y120.71 E.28104
G1 F3600
G1 X141.413 Y120.71 E.00083
G1 X131.876 Y120.71 E.18383
G1 X131.876 Y135.29 E.28104
G1 X141.353 Y135.29 E.18268
; WIPE_START
M204 S4000
M73 P67 R6
G1 X141.456 Y135.29 E-.03914
G1 X141.456 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.656 Y134.49 Z12.84 F60000
G1 Z12.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7018
M204 S4000
G1 X140.656 Y121.57 E.2259
M204 S10000
G1 X133.067 Y124.338 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7018
M204 S4000
G1 X133.067 Y122.641 E.0352
G3 X134.373 Y121.626 I2.638 J2.047 E.03466
G3 X136.649 Y122.371 I.47 J2.413 E.05189
G2 X138.014 Y123.45 I2.764 J-2.097 E.03648
G2 X140.265 Y122.726 I.47 J-2.399 E.05119
G1 X140.265 Y126.899 E.08657
G3 X137.559 Y126.346 I-.989 J-2.055 E.06154
G2 X136.194 Y125.267 I-2.764 J2.097 E.03648
G2 X133.918 Y126.013 I-.47 J2.413 E.05189
G3 X133.067 Y126.836 I-4.356 J-3.649 E.0246
G1 X133.067 Y129.924 E.06404
G3 X134.373 Y128.909 I2.638 J2.047 E.03466
G3 X136.649 Y129.654 I.47 J2.413 E.05189
G2 X138.014 Y130.733 I2.764 J-2.097 E.03648
G2 X140.265 Y130.009 I.47 J-2.399 E.05119
G1 X140.265 Y134.182 E.08657
G3 X137.559 Y133.629 I-.989 J-2.055 E.06154
G2 X136.194 Y132.551 I-2.764 J2.097 E.03648
G2 X133.918 Y133.296 I-.47 J2.413 E.05189
G3 X133.067 Y134.119 I-4.356 J-3.649 E.0246
G1 X133.067 Y134.518 E.00827
G1 X134.365 Y134.518 E.02693
M204 S10000
G1 X132.676 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7018
M204 S4000
G1 X132.676 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.676 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.314 Y121.557 Z12.84 F60000
G1 X123.715 Y121.119 Z12.84
G1 Z12.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7018
M204 S4000
G1 X114.953 Y121.119 E.18174
G1 X114.953 Y134.881 E.28545
G1 X123.715 Y134.881 E.18174
G1 X123.715 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.124 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.587 Y120.71 E.18383
G1 X114.544 Y120.71 E.00083
G1 F3480
G1 X114.544 Y135.29 E.28104
G1 F3600
G1 X114.587 Y135.29 E.00083
G1 X124.124 Y135.29 E.18383
G1 X124.124 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.124 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.735 Y121.56 Z12.84 F60000
G1 Z12.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7018
M204 S4000
G1 X115.735 Y123.257 E.0352
G2 X117.986 Y123.091 I.987 J-1.956 E.04918
G2 X119.351 Y121.829 I-173.79 J-189.406 E.03857
G3 X121.627 Y121.984 I1.011 J1.95 E.04975
G3 X122.933 Y123.195 I-85.202 J93.208 E.03693
G1 X122.933 Y126.282 E.06404
G2 X122.083 Y125.471 I-4.299 J3.656 E.02442
G2 X119.807 Y125.626 I-1.011 J1.95 E.04975
G2 X118.441 Y126.888 I174.88 J190.586 E.03857
G3 X115.735 Y126.367 I-1.013 J-2.029 E.06143
G1 X115.735 Y130.541 E.08657
G2 X117.986 Y130.374 I.987 J-1.956 E.04918
G2 X119.351 Y129.112 I-174.169 J-189.818 E.03857
G3 X121.627 Y129.267 I1.011 J1.95 E.04975
G3 X122.933 Y130.478 I-85.002 J92.991 E.03693
G1 X122.933 Y133.565 E.06404
G2 X122.083 Y132.754 I-4.299 J3.656 E.02442
G2 X119.807 Y132.909 I-1.011 J1.95 E.04975
G2 X118.441 Y134.171 I174.497 J190.171 E.03857
G3 X115.735 Y133.65 I-1.013 J-2.029 E.06143
G1 X115.735 Y131.953 E.0352
M204 S10000
G1 X115.344 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7018
M204 S4000
G1 X115.344 Y121.57 E.2259
M204 S10000
G1 X123.324 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7018
M204 S4000
G1 X123.324 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.56
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X123.324 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L104
M991 S0 P103 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.84 I-.652 J1.027 P1  F60000
G1 X141.131 Y134.881 Z12.84
G1 Z12.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X141.131 Y121.119 E.28545
G1 X132.369 Y121.119 E.18174
G1 X132.369 Y134.881 E.28545
G1 X141.071 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.497 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.54 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.54 Y120.71 E.28104
G1 F3600
G1 X141.497 Y120.71 E.00083
G1 X131.96 Y120.71 E.18383
G1 X131.96 Y135.29 E.28104
G1 X141.437 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.54 Y135.29 E-.03914
G1 X141.54 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.74 Y134.49 Z12.96 F60000
G1 Z12.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X140.74 Y121.57 E.2259
M204 S10000
G1 X133.151 Y124.358 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X133.151 Y122.661 E.0352
G3 X134.373 Y121.71 I3.103 J2.724 E.03231
G3 X137.104 Y122.726 I.629 J2.489 E.06428
G2 X140.349 Y122.746 I1.632 J-1.463 E.07579
G1 X140.349 Y126.718 E.08238
G3 X137.559 Y126.446 I-1.234 J-1.795 E.06316
G2 X136.194 Y125.351 I-3.47 J2.928 E.03654
G2 X133.462 Y126.367 I-.629 J2.489 E.06428
G1 X133.151 Y126.642 E.00862
G1 X133.151 Y129.944 E.06848
G3 X134.373 Y128.993 I3.102 J2.724 E.03231
G3 X137.104 Y130.009 I.629 J2.489 E.06428
G2 X140.349 Y130.029 I1.632 J-1.463 E.07579
G1 X140.349 Y134.001 E.08238
G3 X137.559 Y133.729 I-1.234 J-1.795 E.06316
G2 X136.194 Y132.634 I-3.47 J2.927 E.03654
G2 X133.462 Y133.65 I-.629 J2.489 E.06428
G1 X133.151 Y133.926 E.00862
G1 X133.151 Y134.518 E.01229
G1 X134.256 Y134.518 E.02291
M204 S10000
G1 X132.76 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X132.76 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.76 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.389 Y121.591 Z12.96 F60000
G1 X123.631 Y121.119 Z12.96
G1 Z12.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X114.869 Y121.119 E.18174
G1 X114.869 Y134.881 E.28545
G1 X123.631 Y134.881 E.18174
G1 X123.631 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X124.04 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.503 Y120.71 E.18383
G1 X114.46 Y120.71 E.00083
G1 F3480
G1 X114.46 Y135.29 E.28104
G1 F3600
G1 X114.503 Y135.29 E.00083
G1 X124.04 Y135.29 E.18383
G1 X124.04 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X122.04 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.754 Y121.482 Z12.96 F60000
G1 Z12.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6999
M204 S4000
G1 X115.651 Y121.482 E.00214
G1 X115.651 Y123.076 E.03306
G2 X116.165 Y123.366 I.843 J-.894 E.01236
G2 X118.896 Y122.35 I.629 J-2.489 E.06428
G3 X121.627 Y121.925 I1.615 J1.394 E.06237
G3 X122.849 Y123.001 I-9.678 J12.221 E.03378
G1 X122.849 Y126.302 E.06848
G2 X121.627 Y125.351 I-3.102 J2.724 E.03231
G2 X118.896 Y126.367 I-.629 J2.489 E.06428
G3 X115.651 Y126.387 I-1.632 J-1.463 E.07579
G1 X115.651 Y130.359 E.08238
G2 X116.165 Y130.649 I.843 J-.894 E.01236
G2 X118.896 Y129.633 I.629 J-2.489 E.06428
G3 X121.627 Y129.208 I1.615 J1.394 E.06237
G3 X122.849 Y130.284 I-9.678 J12.221 E.03378
G1 X122.849 Y133.586 E.06848
G2 X121.627 Y132.634 I-3.102 J2.723 E.03231
G2 X118.896 Y133.65 I-.629 J2.489 E.06428
G3 X115.651 Y133.671 I-1.632 J-1.463 E.07579
G1 X115.651 Y131.974 E.0352
M204 S10000
G1 X115.26 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6999
M204 S4000
G1 X115.26 Y121.57 E.2259
M204 S10000
G1 X123.24 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6999
M204 S4000
G1 X123.24 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.24 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L105
M991 S0 P104 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.96 I-.648 J1.03 P1  F60000
G1 X141.215 Y134.881 Z12.96
G1 Z12.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6990
M204 S4000
G1 X141.215 Y121.119 E.28545
G1 X132.453 Y121.119 E.18174
G1 X132.453 Y134.881 E.28545
G1 X141.155 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.581 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.624 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.624 Y120.71 E.28104
G1 F3600
G1 X141.581 Y120.71 E.00083
G1 X132.044 Y120.71 E.18383
G1 X132.044 Y135.29 E.28104
G1 X141.521 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.624 Y135.29 E-.03914
G1 X141.624 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.824 Y134.49 Z13.08 F60000
G1 Z12.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6990
M204 S4000
G1 X140.824 Y121.57 E.2259
M204 S10000
G1 X133.235 Y124.386 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6990
M204 S4000
G1 X133.235 Y122.689 E.0352
G3 X134.373 Y121.786 I3.806 J3.627 E.03023
G3 X137.104 Y122.603 I.819 J2.234 E.06341
G2 X140.433 Y122.77 I1.737 J-1.364 E.07835
G1 X140.433 Y126.53 E.078
G3 X137.104 Y126.114 I-1.47 J-1.768 E.078
G2 X133.462 Y126.245 I-1.77 J1.483 E.0871
G1 X133.235 Y126.452 E.00638
G1 X133.235 Y129.972 E.073
M73 P68 R6
G3 X134.373 Y129.069 I3.806 J3.627 E.03023
G3 X137.104 Y129.886 I.819 J2.234 E.06341
G2 X140.433 Y130.053 I1.737 J-1.364 E.07835
G1 X140.433 Y133.813 E.078
G3 X137.104 Y133.397 I-1.47 J-1.768 E.078
G2 X133.462 Y133.528 I-1.77 J1.483 E.0871
G1 X133.235 Y133.735 E.00638
G1 X133.235 Y134.518 E.01623
G1 X134.149 Y134.518 E.01897
M204 S10000
G1 X132.844 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6990
M204 S4000
G1 X132.844 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.844 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.464 Y121.625 Z13.08 F60000
G1 X123.547 Y121.119 Z13.08
G1 Z12.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6990
M204 S4000
G1 X114.785 Y121.119 E.18174
G1 X114.785 Y134.881 E.28545
G1 X123.547 Y134.881 E.18174
G1 X123.547 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.956 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.419 Y120.71 E.18383
G1 X114.376 Y120.71 E.00083
G1 F3480
G1 X114.376 Y135.29 E.28104
G1 F3600
G1 X114.419 Y135.29 E.00083
G1 X123.956 Y135.29 E.18383
G1 X123.956 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.956 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.858 Y121.482 Z13.08 F60000
G1 Z12.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6990
M204 S4000
G1 X115.567 Y121.482 E.00603
G1 X115.567 Y122.888 E.02917
G2 X118.896 Y122.472 I1.47 J-1.768 E.078
G3 X121.627 Y121.861 I1.738 J1.358 E.06289
G3 X122.765 Y122.811 I-4.445 J6.483 E.03078
G1 X122.765 Y126.33 E.073
G1 X122.538 Y126.114 E.00651
G2 X118.896 Y126.245 I-1.77 J1.483 E.0871
G3 X115.567 Y126.411 I-1.737 J-1.364 E.07835
G1 X115.567 Y130.171 E.078
G2 X118.896 Y129.755 I1.47 J-1.768 E.078
G3 X121.627 Y129.144 I1.738 J1.358 E.06289
G3 X122.765 Y130.094 I-4.444 J6.482 E.03078
G1 X122.765 Y133.613 E.073
G1 X122.538 Y133.397 E.00651
G2 X118.896 Y133.528 I-1.77 J1.483 E.0871
G3 X115.567 Y133.694 I-1.737 J-1.364 E.07835
G1 X115.567 Y131.997 E.0352
M204 S10000
G1 X115.176 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6990
M204 S4000
G1 X115.176 Y121.57 E.2259
M204 S10000
G1 X123.156 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6990
M204 S4000
G1 X123.156 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X123.156 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L106
M991 S0 P105 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.08 I-.644 J1.033 P1  F60000
G1 X141.299 Y134.881 Z13.08
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6974
M204 S4000
G1 X141.299 Y121.119 E.28545
G1 X132.537 Y121.119 E.18174
G1 X132.537 Y134.881 E.28545
G1 X141.239 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.665 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.708 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.708 Y120.71 E.28104
G1 F3600
G1 X141.665 Y120.71 E.00083
G1 X132.128 Y120.71 E.18383
G1 X132.128 Y135.29 E.28104
G1 X141.605 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.708 Y135.29 E-.03914
G1 X141.708 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.908 Y134.49 Z13.2 F60000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6974
M204 S4000
G1 X140.908 Y121.57 E.2259
M204 S10000
G1 X140.139 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6974
M204 S4000
G1 X140.517 Y121.482 E.00784
G1 X140.517 Y122.801 E.02736
G3 X137.104 Y122.483 I-1.566 J-1.669 E.08036
G2 X133.462 Y122.592 I-1.778 J1.48 E.08701
G1 X133.319 Y122.723 E.00403
G1 X133.319 Y126.261 E.07337
G3 X134.373 Y125.434 I3.624 J3.534 E.02786
G3 X137.104 Y126.234 I.835 J2.211 E.06335
G2 X140.517 Y126.341 I1.753 J-1.417 E.08037
G1 X140.517 Y130.084 E.07764
G3 X137.104 Y129.766 I-1.566 J-1.669 E.08036
G2 X133.462 Y129.875 I-1.778 J1.48 E.08701
G1 X133.319 Y130.007 E.00403
G1 X133.319 Y133.544 E.07337
G3 X134.373 Y132.717 I3.624 J3.533 E.02786
G3 X137.104 Y133.517 I.835 J2.211 E.06335
G2 X140.517 Y133.624 I1.753 J-1.417 E.08037
G1 X140.517 Y131.927 E.0352
M204 S10000
G1 X132.928 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6974
M204 S4000
G1 X132.928 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X132.928 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.539 Y121.657 Z13.2 F60000
G1 X123.463 Y121.119 Z13.2
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6974
M204 S4000
G1 X114.701 Y121.119 E.18174
G1 X114.701 Y134.881 E.28545
G1 X123.463 Y134.881 E.18174
G1 X123.463 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.872 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.335 Y120.71 E.18383
G1 X114.292 Y120.71 E.00083
G1 F3480
G1 X114.292 Y135.29 E.28104
G1 F3600
G1 X114.335 Y135.29 E.00083
G1 X123.872 Y135.29 E.18383
G1 X123.872 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.872 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.681 Y124.316 Z13.2 F60000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6974
M204 S4000
G1 X122.681 Y122.619 E.0352
G1 X122.538 Y122.483 E.0041
G2 X118.896 Y122.592 I-1.778 J1.48 E.08701
G3 X115.483 Y122.7 I-1.753 J-1.417 E.08037
G1 X115.483 Y126.443 E.07764
G2 X118.896 Y126.125 I1.566 J-1.669 E.08036
G3 X121.627 Y125.497 I1.751 J1.362 E.06292
G3 X122.681 Y126.365 I-3.802 J5.688 E.02837
G1 X122.681 Y129.902 E.07337
G1 X122.538 Y129.766 E.0041
G2 X118.896 Y129.875 I-1.778 J1.48 E.08701
G3 X115.483 Y129.983 I-1.753 J-1.417 E.08037
G1 X115.483 Y133.726 E.07764
G2 X118.896 Y133.408 I1.566 J-1.669 E.08036
G3 X121.627 Y132.78 I1.751 J1.362 E.06292
G3 X122.681 Y133.648 I-3.803 J5.689 E.02837
G1 X122.681 Y134.518 E.01804
G1 X121.854 Y134.518 E.01716
M204 S10000
G1 X123.072 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6974
M204 S4000
G1 X123.072 Y121.57 E.2259
M204 S10000
G1 X115.092 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F6974
M204 S4000
G1 X115.092 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 12.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X115.092 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L107
M991 S0 P106 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.2 I-.481 J1.118 P1  F60000
G1 X141.383 Y134.881 Z13.2
G1 Z12.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6998
M204 S4000
G1 X141.383 Y121.119 E.28545
G1 X132.621 Y121.119 E.18174
G1 X132.621 Y134.881 E.28545
G1 X141.323 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.749 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.792 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.792 Y120.71 E.28104
G1 F3600
G1 X141.749 Y120.71 E.00083
G1 X132.212 Y120.71 E.18383
G1 X132.212 Y135.29 E.28104
G1 X141.689 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.792 Y135.29 E-.03914
G1 X141.792 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.992 Y134.49 Z13.32 F60000
G1 Z12.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6998
M204 S4000
G1 X140.992 Y121.57 E.2259
M204 S10000
G1 X140.264 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6998
M204 S4000
G1 X140.601 Y121.482 E.00699
G1 X140.601 Y122.842 E.02821
G3 X137.559 Y122.814 I-1.507 J-1.539 E.07006
G2 X136.194 Y121.717 I-3.551 J3.021 E.03655
G2 X133.462 Y122.714 I-.647 J2.465 E.06418
G1 X133.403 Y122.767 E.00165
G1 X133.403 Y126.062 E.06834
G3 X136.649 Y125.903 I1.695 J1.396 E.07588
G2 X138.014 Y127 I3.55 J-3.021 E.03655
G2 X140.601 Y126.146 I.661 J-2.342 E.05997
G1 X140.601 Y130.125 E.08253
G3 X137.559 Y130.097 I-1.507 J-1.539 E.07006
G2 X136.194 Y129 I-3.551 J3.021 E.03655
G2 X133.462 Y129.997 I-.647 J2.465 E.06418
G1 X133.403 Y130.05 E.00165
G1 X133.403 Y133.345 E.06834
G3 X136.649 Y133.186 I1.695 J1.396 E.07588
G2 X138.014 Y134.283 I3.551 J-3.021 E.03655
G2 X140.601 Y133.43 I.661 J-2.342 E.05997
G1 X140.601 Y131.733 E.0352
M204 S10000
G1 X133.012 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6998
M204 S4000
G1 X133.012 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.012 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.615 Y121.688 Z13.32 F60000
G1 X123.379 Y121.119 Z13.32
G1 Z12.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6998
M204 S4000
G1 X114.617 Y121.119 E.18174
G1 X114.617 Y134.881 E.28545
G1 X123.379 Y134.881 E.18174
G1 X123.379 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.788 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.251 Y120.71 E.18383
G1 X114.208 Y120.71 E.00083
G1 F3480
M73 P69 R6
G1 X114.208 Y135.29 E.28104
G1 F3600
G1 X114.251 Y135.29 E.00083
G1 X123.788 Y135.29 E.18383
G1 X123.788 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.788 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.597 Y124.117 Z13.32 F60000
G1 Z12.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6998
M204 S4000
G1 X122.597 Y122.42 E.0352
G2 X119.807 Y121.919 I-1.682 J1.345 E.06419
G2 X118.441 Y123.118 I11.133 J14.064 E.0377
G3 X115.399 Y122.505 I-1.183 J-1.983 E.07058
G1 X115.399 Y126.484 E.08253
G2 X116.165 Y127 I1.445 J-1.317 E.01935
G2 X118.896 Y126.003 I.647 J-2.465 E.06418
G3 X120.717 Y125.262 I1.616 J1.364 E.0424
G3 X122.597 Y126.408 I-.641 J3.167 E.0466
G1 X122.597 Y129.703 E.06834
G2 X119.807 Y129.202 I-1.682 J1.345 E.06419
G2 X118.441 Y130.401 I11.133 J14.064 E.0377
G3 X115.399 Y129.788 I-1.183 J-1.983 E.07058
G1 X115.399 Y133.767 E.08253
G2 X116.165 Y134.283 I1.445 J-1.317 E.01935
G2 X118.896 Y133.286 I.647 J-2.465 E.06418
G3 X120.717 Y132.545 I1.616 J1.364 E.0424
G3 X122.597 Y133.691 I-.641 J3.167 E.0466
G1 X122.597 Y134.518 E.01714
G1 X121.726 Y134.518 E.01806
M204 S10000
G1 X122.988 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6998
M204 S4000
G1 X122.988 Y121.57 E.2259
M204 S10000
G1 X115.008 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F6998
M204 S4000
G1 X115.008 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X115.008 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L108
M991 S0 P107 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.32 I-.478 J1.119 P1  F60000
G1 X141.467 Y134.881 Z13.32
G1 Z13.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7016
M204 S4000
G1 X141.467 Y121.119 E.28545
G1 X132.705 Y121.119 E.18174
G1 X132.705 Y134.881 E.28545
G1 X141.407 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.833 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.876 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.876 Y120.71 E.28104
G1 F3600
G1 X141.833 Y120.71 E.00083
G1 X132.296 Y120.71 E.18383
G1 X132.296 Y135.29 E.28104
G1 X141.773 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.876 Y135.29 E-.03914
G1 X141.876 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.076 Y134.49 Z13.44 F60000
G1 Z13.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7016
M204 S4000
G1 X141.076 Y121.57 E.2259
M204 S10000
G1 X140.4 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7016
M204 S4000
G1 X140.685 Y121.482 E.00591
G1 X140.685 Y122.894 E.02929
G3 X138.469 Y123.338 I-1.424 J-1.359 E.04992
G3 X137.104 Y122.233 I1.88 J-3.72 E.03671
G2 X134.373 Y121.979 I-1.511 J1.439 E.06208
G2 X133.487 Y122.816 I3.27 J4.346 E.02534
G1 X133.487 Y125.853 E.063
G3 X136.194 Y125.62 I1.489 J1.456 E.06139
G3 X137.559 Y126.877 I-82.727 J91.309 E.03849
G2 X140.29 Y126.355 I1.028 J-2.029 E.06205
G1 X140.685 Y125.939 E.0119
G1 X140.685 Y130.177 E.08793
G3 X138.469 Y130.621 I-1.424 J-1.359 E.04992
G3 X137.104 Y129.516 I1.88 J-3.72 E.03671
G2 X134.373 Y129.262 I-1.511 J1.439 E.06208
G2 X133.487 Y130.099 I3.27 J4.347 E.02534
G1 X133.487 Y133.137 E.063
G3 X136.194 Y132.904 I1.489 J1.456 E.06139
G3 X137.559 Y134.16 I-82.641 J91.214 E.03849
G2 X140.29 Y133.638 I1.028 J-2.029 E.06205
G1 X140.685 Y133.222 E.0119
G1 X140.685 Y131.525 E.0352
M204 S10000
G1 X133.096 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7016
M204 S4000
G1 X133.096 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.096 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.692 Y121.719 Z13.44 F60000
G1 X123.295 Y121.119 Z13.44
G1 Z13.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7016
M204 S4000
G1 X114.533 Y121.119 E.18174
G1 X114.533 Y134.881 E.28545
G1 X123.295 Y134.881 E.18174
G1 X123.295 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.704 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.167 Y120.71 E.18383
G1 X114.124 Y120.71 E.00083
G1 F3480
G1 X114.124 Y135.29 E.28104
G1 F3600
G1 X114.167 Y135.29 E.00083
G1 X123.704 Y135.29 E.18383
G1 X123.704 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.704 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.513 Y123.909 Z13.44 F60000
G1 Z13.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7016
M204 S4000
G1 X122.513 Y122.212 E.0352
G1 X122.083 Y121.84 E.01179
G2 X119.351 Y122.362 I-1.028 J2.029 E.06205
G3 X117.986 Y123.442 I-2.818 J-2.161 E.03648
G3 X115.315 Y122.297 I-.438 J-2.667 E.06363
G1 X115.315 Y126.536 E.08793
G1 X115.71 Y126.877 E.01082
G2 X118.441 Y126.355 I1.028 J-2.029 E.06205
G3 X119.807 Y125.275 I2.818 J2.162 E.03648
G3 X122.513 Y126.458 I.431 J2.702 E.06471
G1 X122.513 Y129.495 E.063
G1 X122.083 Y129.124 E.01179
G2 X119.351 Y129.645 I-1.028 J2.029 E.06205
G3 X117.986 Y130.725 I-2.818 J-2.162 E.03648
G3 X115.315 Y129.58 I-.438 J-2.667 E.06363
G1 X115.315 Y133.819 E.08793
G1 X115.71 Y134.16 E.01082
G2 X118.441 Y133.638 I1.028 J-2.029 E.06205
G3 X119.807 Y132.559 I2.818 J2.161 E.03648
G3 X122.513 Y133.741 I.431 J2.702 E.06471
G1 X122.513 Y134.518 E.01612
G1 X121.593 Y134.518 E.01908
M204 S10000
G1 X122.904 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7016
M204 S4000
G1 X122.904 Y121.57 E.2259
M204 S10000
G1 X114.924 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7016
M204 S4000
G1 X114.924 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114.924 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L109
M991 S0 P108 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.44 I-.476 J1.12 P1  F60000
G1 X141.551 Y134.881 Z13.44
G1 Z13.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7058
M204 S4000
G1 X141.551 Y121.119 E.28545
G1 X132.789 Y121.119 E.18174
G1 X132.789 Y134.881 E.28545
G1 X141.491 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X141.917 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X141.96 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X141.96 Y120.71 E.28104
G1 F3600
G1 X141.917 Y120.71 E.00083
G1 X132.38 Y120.71 E.18383
G1 X132.38 Y135.29 E.28104
G1 X141.857 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X141.96 Y135.29 E-.03914
G1 X141.96 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.16 Y134.49 Z13.56 F60000
G1 Z13.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7058
M204 S4000
G1 X141.16 Y121.57 E.2259
M204 S10000
G1 X133.571 Y124.566 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7058
M204 S4000
G1 X133.571 Y122.869 E.0352
G1 X134.373 Y122.034 E.024
G3 X136.649 Y121.711 I1.409 J1.746 E.05006
G3 X138.014 Y123.041 I-5.563 J7.079 E.03961
G1 X138.469 Y123.322 E.0111
G2 X140.769 Y122.957 I.916 J-1.656 E.05202
G1 X140.769 Y125.716 E.05722
G2 X139.835 Y126.682 I4.071 J4.866 E.02794
G3 X137.559 Y127.006 I-1.409 J-1.746 E.05006
G3 X136.194 Y125.676 I5.563 J-7.079 E.03961
G1 X135.738 Y125.395 E.0111
G2 X133.571 Y125.644 I-.911 J1.626 E.04834
G1 X133.571 Y130.152 E.0935
G1 X134.373 Y129.318 E.024
G3 X136.649 Y128.994 I1.409 J1.746 E.05006
G3 X138.014 Y130.324 I-5.563 J7.079 E.03961
G1 X138.469 Y130.605 E.0111
G2 X140.769 Y130.24 I.916 J-1.656 E.05202
G1 X140.769 Y132.999 E.05722
G2 X139.835 Y133.966 I4.071 J4.866 E.02794
G3 X137.559 Y134.289 I-1.409 J-1.746 E.05006
G3 X136.194 Y132.959 I5.562 J-7.078 E.03961
G1 X135.738 Y132.678 E.0111
G2 X133.571 Y132.927 I-.911 J1.626 E.04834
G1 X133.571 Y134.518 E.033
G1 X133.677 Y134.518 E.0022
M204 S10000
G1 X133.18 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7058
M204 S4000
G1 X133.18 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.18 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.768 Y121.748 Z13.56 F60000
G1 X123.211 Y121.119 Z13.56
G1 Z13.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7058
M204 S4000
G1 X114.449 Y121.119 E.18174
G1 X114.449 Y134.881 E.28545
G1 X123.211 Y134.881 E.18174
G1 X123.211 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.62 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X114.083 Y120.71 E.18383
G1 X114.04 Y120.71 E.00083
G1 F3480
G1 X114.04 Y135.29 E.28104
G1 F3600
G1 X114.083 Y135.29 E.00083
G1 X123.62 Y135.29 E.18383
G1 X123.62 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.62 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.336 Y121.482 Z13.56 F60000
G1 Z13.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7058
M204 S4000
G1 X115.231 Y121.482 E.02292
G1 X115.231 Y122.074 E.01228
G3 X116.165 Y123.041 I-4.074 J4.87 E.02794
G2 X118.441 Y123.364 I1.409 J-1.746 E.05006
G2 X119.807 Y122.034 I-5.562 J-7.078 E.03961
G3 X122.083 Y121.711 I1.409 J1.746 E.05006
M73 P70 R6
G1 X122.429 Y122.002 E.00939
G1 X122.429 Y126.51 E.0935
G1 X121.627 Y125.676 E.024
G2 X119.351 Y125.353 I-1.409 J1.746 E.05006
G2 X117.986 Y126.682 I5.563 J7.079 E.03961
G3 X115.71 Y127.006 I-1.409 J-1.746 E.05006
G3 X115.231 Y126.599 I1.675 J-2.454 E.01306
G1 X115.231 Y129.357 E.05722
G3 X116.165 Y130.324 I-4.074 J4.869 E.02794
G2 X118.441 Y130.647 I1.409 J-1.746 E.05006
G2 X119.807 Y129.318 I-5.562 J-7.078 E.03961
G3 X122.083 Y128.994 I1.409 J1.746 E.05006
G1 X122.429 Y129.285 E.00939
G1 X122.429 Y133.793 E.0935
G1 X121.627 Y132.959 E.024
G2 X119.351 Y132.636 I-1.409 J1.746 E.05006
G2 X117.986 Y133.966 I5.563 J7.079 E.03961
G3 X115.71 Y134.289 I-1.409 J-1.746 E.05006
G3 X115.231 Y133.882 I1.674 J-2.454 E.01306
G1 X115.231 Y132.185 E.0352
M204 S10000
G1 X114.84 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7058
M204 S4000
G1 X114.84 Y121.57 E.2259
M204 S10000
G1 X122.82 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7058
M204 S4000
G1 X122.82 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X122.82 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L110
M991 S0 P109 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.56 I-.627 J1.043 P1  F60000
G1 X141.635 Y134.881 Z13.56
G1 Z13.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7090
M204 S4000
G1 X141.635 Y121.119 E.28545
G1 X132.873 Y121.119 E.18174
G1 X132.873 Y134.881 E.28545
G1 X141.575 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.001 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.044 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.044 Y120.71 E.28104
G1 F3600
G1 X142.001 Y120.71 E.00083
G1 X132.464 Y120.71 E.18383
G1 X132.464 Y135.29 E.28104
G1 X141.941 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.044 Y135.29 E-.03914
G1 X142.044 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.244 Y134.49 Z13.68 F60000
G1 Z13.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7090
M204 S4000
G1 X141.244 Y121.57 E.2259
M204 S10000
G1 X133.655 Y124.614 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7090
M204 S4000
G1 X133.655 Y122.917 E.0352
G1 X134.373 Y122.087 E.02277
G3 X136.649 Y121.564 I1.599 J1.747 E.05065
G1 X137.104 Y121.935 E.01217
G1 X138.014 Y122.989 E.02888
G2 X138.925 Y123.512 I1.714 J-1.929 E.02193
G2 X140.853 Y123.016 I.65 J-1.468 E.04454
G1 X140.853 Y125.489 E.0513
G1 X139.835 Y126.63 E.03172
G3 X138.469 Y127.262 I-1.871 J-2.255 E.03156
G3 X137.104 Y126.782 I-.241 J-1.497 E.0313
G1 X136.194 Y125.728 E.02888
G2 X134.828 Y125.097 I-1.871 J2.255 E.03156
G2 X133.655 Y125.42 I-.249 J1.389 E.02609
G1 X133.655 Y130.201 E.09917
G1 X134.373 Y129.37 E.02277
G3 X135.738 Y128.739 I1.871 J2.255 E.03156
G3 X137.104 Y129.218 I.241 J1.497 E.0313
G1 X138.014 Y130.272 E.02888
G2 X138.925 Y130.795 I1.714 J-1.929 E.02193
G2 X140.853 Y130.299 I.65 J-1.468 E.04454
G1 X140.853 Y132.772 E.0513
G1 X139.835 Y133.913 E.03172
G3 X137.559 Y134.436 I-1.599 J-1.747 E.05065
G1 X137.104 Y134.065 E.01217
G1 X136.194 Y133.011 E.02888
G2 X134.828 Y132.38 I-1.871 J2.255 E.03156
G2 X133.655 Y132.703 I-.249 J1.389 E.02609
G1 X133.655 Y134.4 E.0352
M204 S10000
G1 X133.264 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7090
M204 S4000
G1 X133.264 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.264 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.845 Y121.777 Z13.68 F60000
G1 X123.127 Y121.119 Z13.68
G1 Z13.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7090
M204 S4000
G1 X114.365 Y121.119 E.18174
G1 X114.365 Y134.881 E.28545
G1 X123.127 Y134.881 E.18174
G1 X123.127 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.536 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.999 Y120.71 E.18383
G1 X113.956 Y120.71 E.00083
G1 F3480
G1 X113.956 Y135.29 E.28104
G1 F3600
G1 X113.999 Y135.29 E.00083
G1 X123.536 Y135.29 E.18383
G1 X123.536 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.536 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.479 Y121.482 Z13.68 F60000
G1 Z13.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7090
M204 S4000
G1 X115.147 Y121.482 E.02762
G1 X115.147 Y121.847 E.00758
G1 X116.165 Y122.989 E.03172
G2 X118.441 Y123.511 I1.596 J-1.736 E.05067
G1 X118.896 Y123.14 E.01217
G1 X119.807 Y122.087 E.02888
G3 X122.083 Y121.564 I1.599 J1.747 E.05065
G1 X122.345 Y121.778 E.00702
G1 X122.345 Y126.559 E.09917
G1 X121.627 Y125.728 E.02277
G2 X119.351 Y125.206 I-1.596 J1.737 E.05067
G1 X118.896 Y125.577 E.01217
G1 X117.986 Y126.63 E.02888
G3 X115.71 Y127.152 I-1.596 J-1.737 E.05067
G3 X115.147 Y126.657 I1.118 J-1.839 E.01563
G1 X115.147 Y129.131 E.0513
G1 X116.165 Y130.272 E.03172
G2 X118.441 Y130.794 I1.596 J-1.737 E.05067
G1 X118.896 Y130.424 E.01217
G1 X119.807 Y129.37 E.02888
G3 X122.083 Y128.848 I1.596 J1.736 E.05067
G1 X122.345 Y129.061 E.00702
G1 X122.345 Y133.842 E.09917
G1 X121.627 Y133.011 E.02277
G2 X119.351 Y132.489 I-1.596 J1.736 E.05067
G1 X118.896 Y132.86 E.01217
G1 X117.986 Y133.913 E.02888
G3 X115.71 Y134.436 I-1.599 J-1.747 E.05065
G3 X115.147 Y133.941 I1.118 J-1.839 E.01563
G1 X115.147 Y132.244 E.0352
M204 S10000
G1 X114.756 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7090
M204 S4000
G1 X114.756 Y121.57 E.2259
M204 S10000
G1 X122.736 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7090
M204 S4000
G1 X122.736 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X122.736 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L111
M991 S0 P110 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.68 I-.623 J1.045 P1  F60000
G1 X141.719 Y134.881 Z13.68
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7155
M204 S4000
G1 X141.719 Y121.119 E.28545
G1 X132.957 Y121.119 E.18174
G1 X132.957 Y134.881 E.28545
G1 X141.659 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.085 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.128 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.128 Y120.71 E.28104
G1 F3600
G1 X142.085 Y120.71 E.00083
G1 X132.548 Y120.71 E.18383
G1 X132.548 Y135.29 E.28104
G1 X142.025 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.128 Y135.29 E-.03914
G1 X142.128 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.328 Y134.49 Z13.8 F60000
G1 Z13.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7155
M204 S4000
G1 X141.328 Y121.57 E.2259
M204 S10000
G1 X133.949 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7155
M204 S4000
G1 X133.739 Y121.482 E.00435
G1 X133.739 Y122.969 E.03085
G1 X134.373 Y122.136 E.02171
G3 X135.494 Y121.482 I1.794 J1.787 E.02724
G1 X136.765 Y121.482 E.02635
G1 X137.104 Y121.743 E.00887
G1 X138.014 Y122.939 E.03119
G2 X139.835 Y123.752 I2.048 J-2.143 E.04218
G2 X140.937 Y123.081 I-.079 J-1.371 E.02786
G1 X140.937 Y125.237 E.04472
G1 X140.745 Y125.384 E.00501
G1 X139.835 Y126.581 E.03119
G3 X138.014 Y127.393 I-2.048 J-2.143 E.04218
G1 X137.559 Y127.324 E.00955
G1 X137.104 Y126.974 E.01191
G1 X136.194 Y125.778 E.03119
G2 X134.373 Y124.965 I-2.048 J2.143 E.04218
G2 X133.739 Y125.172 I-.129 J.679 E.01443
G1 X133.739 Y130.252 E.10539
G1 X134.373 Y129.419 E.02171
G3 X136.194 Y128.607 I2.048 J2.143 E.04218
G1 X136.649 Y128.676 E.00955
G1 X137.104 Y129.026 E.01191
G1 X138.014 Y130.222 E.03119
G2 X139.835 Y131.035 I2.048 J-2.143 E.04218
G2 X140.937 Y130.364 I-.079 J-1.371 E.02786
G1 X140.937 Y132.52 E.04472
G1 X140.745 Y132.667 E.00501
G1 X139.835 Y133.864 E.03119
G3 X138.647 Y134.518 I-1.637 J-1.567 E.02858
G1 X137.443 Y134.518 E.02497
G1 X137.104 Y134.258 E.00887
G1 X136.194 Y133.061 E.03119
G2 X134.373 Y132.248 I-2.048 J2.143 E.04218
G2 X133.739 Y132.455 I-.129 J.679 E.01443
G1 X133.739 Y134.152 E.0352
M204 S10000
G1 X133.348 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7155
M204 S4000
G1 X133.348 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.348 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.923 Y121.804 Z13.8 F60000
G1 X123.043 Y121.119 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7155
M204 S4000
G1 X114.281 Y121.119 E.18174
G1 X114.281 Y134.881 E.28545
G1 X123.043 Y134.881 E.18174
G1 X123.043 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.452 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.915 Y120.71 E.18383
G1 X113.872 Y120.71 E.00083
G1 F3480
G1 X113.872 Y135.29 E.28104
G1 F3600
G1 X113.915 Y135.29 E.00083
G1 X123.452 Y135.29 E.18383
G1 X123.452 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.452 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.063 Y123.292 Z13.8 F60000
G1 Z13.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7155
M204 S4000
G1 X115.063 Y121.595 E.0352
G1 X115.255 Y121.743 E.00501
G1 X116.165 Y122.939 E.03119
G2 X118.441 Y123.682 I1.85 J-1.81 E.05163
G1 X118.896 Y123.333 E.01191
G1 X119.807 Y122.136 E.03119
G3 X120.928 Y121.482 I1.794 J1.787 E.02724
G1 X122.261 Y121.482 E.02765
G1 X122.261 Y126.611 E.10638
G2 X120.717 Y125.172 I-2.973 J1.642 E.04452
G1 X119.807 Y124.965 E.01936
G1 X119.351 Y125.034 E.00955
G1 X118.896 Y125.384 E.0119
G1 X117.986 Y126.581 E.03119
G3 X115.71 Y127.324 I-1.85 J-1.81 E.05163
G3 X115.063 Y126.723 I.783 J-1.49 E.01854
G1 X115.063 Y128.878 E.04472
G1 X115.255 Y129.026 E.00501
G1 X116.165 Y130.222 E.03119
G2 X118.441 Y130.966 I1.85 J-1.81 E.05163
G1 X118.896 Y130.616 E.01191
G1 X119.807 Y129.419 E.03119
G3 X122.083 Y128.676 I1.85 J1.81 E.05163
G1 X122.261 Y128.813 E.00467
G1 X122.261 Y133.894 E.10539
G2 X120.717 Y132.455 I-2.973 J1.642 E.04452
G1 X119.807 Y132.248 E.01936
G1 X119.351 Y132.318 E.00955
G1 X118.896 Y132.667 E.0119
G1 X117.986 Y133.864 E.03119
G3 X116.797 Y134.518 I-1.637 J-1.567 E.02858
G1 X115.594 Y134.518 E.02497
G3 X115.063 Y134.006 I.677 J-1.232 E.01548
G1 X115.063 Y132.309 E.0352
M204 S10000
G1 X114.672 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7155
M204 S4000
G1 X114.672 Y121.57 E.2259
M204 S10000
G1 X122.652 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7155
M204 S4000
G1 X122.652 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X122.652 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L112
M991 S0 P111 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.8 I-.619 J1.048 P1  F60000
G1 X141.803 Y134.881 Z13.8
M73 P71 R6
G1 Z13.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7226
M204 S4000
G1 X141.803 Y121.119 E.28545
G1 X133.041 Y121.119 E.18174
G1 X133.041 Y134.881 E.28545
G1 X141.743 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.169 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.212 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.212 Y120.71 E.28104
G1 F3600
G1 X142.169 Y120.71 E.00083
G1 X132.632 Y120.71 E.18383
G1 X132.632 Y135.29 E.28104
G1 X142.109 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.212 Y135.29 E-.03914
G1 X142.212 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.412 Y134.49 Z13.92 F60000
G1 Z13.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7226
M204 S4000
G1 X141.412 Y121.57 E.2259
M204 S10000
G1 X134.006 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7226
M204 S4000
G1 X133.823 Y121.482 E.00379
G1 X133.823 Y122.997 E.03141
G3 X135.302 Y121.482 I3.089 J1.537 E.04463
G1 X137.102 Y121.482 E.03733
G1 X137.559 Y122.235 E.01827
G2 X139.835 Y123.883 I2.777 J-1.439 E.06045
G2 X141.021 Y123.137 I.165 J-1.054 E.03171
G1 X141.021 Y124.943 E.03746
G1 X140.745 Y125.125 E.00684
G1 X140.29 Y125.877 E.01823
G3 X138.014 Y127.525 I-2.777 J-1.439 E.06045
G1 X137.559 Y127.534 E.00944
G1 X137.104 Y127.234 E.01131
G1 X136.649 Y126.482 E.01823
G2 X134.373 Y124.834 I-2.777 J1.439 E.06045
G1 X133.918 Y124.825 E.00944
G1 X133.823 Y124.887 E.00235
G1 X133.823 Y130.28 E.11185
G3 X136.194 Y128.475 I2.979 J1.454 E.06409
G1 X136.649 Y128.466 E.00944
G1 X137.104 Y128.766 E.01131
G1 X137.559 Y129.518 E.01823
G2 X139.835 Y131.166 I2.777 J-1.439 E.06045
G2 X141.021 Y130.42 I.165 J-1.054 E.03171
G1 X141.021 Y132.226 E.03746
G1 X140.745 Y132.408 E.00684
G1 X140.29 Y133.16 E.01823
G3 X138.925 Y134.512 I-2.969 J-1.632 E.04042
G1 X137.104 Y134.517 E.03777
G1 X136.649 Y133.765 E.01823
G2 X134.373 Y132.117 I-2.777 J1.439 E.06045
G1 X133.918 Y132.108 E.00944
G1 X133.823 Y132.17 E.00235
G1 X133.823 Y133.867 E.0352
M204 S10000
G1 X133.432 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7226
M204 S4000
G1 X133.432 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.432 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126 Y121.831 Z13.92 F60000
G1 X122.959 Y121.119 Z13.92
G1 Z13.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7226
M204 S4000
G1 X114.197 Y121.119 E.18174
G1 X114.197 Y134.881 E.28545
G1 X122.959 Y134.881 E.18174
G1 X122.959 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.368 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.831 Y120.71 E.18383
G1 X113.788 Y120.71 E.00083
G1 F3480
G1 X113.788 Y135.29 E.28104
G1 F3600
G1 X113.831 Y135.29 E.00083
G1 X123.368 Y135.29 E.18383
G1 X123.368 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.368 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.979 Y122.905 Z13.92 F60000
G1 Z13.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7226
M204 S4000
G1 X114.979 Y121.482 E.02952
G1 X115.255 Y121.483 E.00572
G2 X116.62 Y123.314 I5.873 J-2.957 E.04762
G2 X118.441 Y123.892 I1.985 J-3.096 E.04008
G1 X118.896 Y123.592 E.01131
G3 X120.262 Y121.761 I5.874 J2.957 E.04762
G3 X120.736 Y121.482 I.845 J.892 E.01152
G1 X122.177 Y121.482 E.02989
G1 X122.177 Y126.638 E.10695
G2 X121.172 Y125.403 I-4.545 J2.671 E.03315
G2 X119.351 Y124.825 I-1.985 J3.096 E.04009
G1 X118.896 Y125.125 E.01131
G3 X117.531 Y126.956 I-5.874 J-2.957 E.04762
G3 X115.71 Y127.534 I-1.985 J-3.096 E.04009
G3 X114.979 Y126.779 I.429 J-1.146 E.02253
G1 X114.979 Y128.585 E.03747
G1 X115.255 Y128.766 E.00685
G2 X116.62 Y130.597 I5.873 J-2.957 E.04762
G2 X118.441 Y131.175 I1.985 J-3.096 E.04008
G1 X118.896 Y130.875 E.01131
G3 X120.262 Y129.045 I5.873 J2.957 E.04762
G3 X122.083 Y128.466 I1.985 J3.096 E.04009
G1 X122.177 Y128.529 E.00235
G1 X122.177 Y133.921 E.11185
G2 X121.172 Y132.686 I-4.545 J2.671 E.03315
G2 X119.351 Y132.108 I-1.985 J3.096 E.04009
G1 X118.896 Y132.408 E.01131
G3 X117.531 Y134.239 I-5.874 J-2.957 E.04762
G1 X117.027 Y134.518 E.01195
G1 X115.255 Y134.517 E.03676
G1 X114.979 Y134.062 E.01104
G1 X114.979 Y132.365 E.0352
M204 S10000
G1 X114.588 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7226
M204 S4000
G1 X114.588 Y121.57 E.2259
M204 S10000
G1 X122.568 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7226
M204 S4000
G1 X122.568 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X122.568 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L113
M991 S0 P112 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z13.92 I-.615 J1.05 P1  F60000
G1 X141.887 Y134.881 Z13.92
G1 Z13.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7344
M204 S4000
G1 X141.887 Y121.119 E.28545
G1 X133.125 Y121.119 E.18174
G1 X133.125 Y134.881 E.28545
G1 X141.827 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.253 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.296 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.296 Y120.71 E.28104
G1 F3600
G1 X142.253 Y120.71 E.00083
G1 X132.716 Y120.71 E.18383
G1 X132.716 Y135.29 E.28104
G1 X142.193 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.296 Y135.29 E-.03914
G1 X142.296 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.496 Y134.49 Z14.04 F60000
G1 Z13.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7344
M204 S4000
G1 X141.496 Y121.57 E.2259
M204 S10000
G1 X141.105 Y121.556 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7344
M204 S4000
G1 X141.105 Y123.253 E.0352
G1 X140.745 Y124.088 E.01887
G3 X139.835 Y124.034 I-.4 J-.95 E.0196
G3 X137.559 Y122.045 I.911 J-3.339 E.06488
G1 X137.317 Y121.482 E.01271
G1 X135.218 Y121.482 E.04353
G2 X133.907 Y123.055 I1.959 J2.966 E.04309
G1 X133.918 Y124.549 E.031
G3 X135.738 Y125.39 I-1.694 J6.062 E.04178
G3 X136.649 Y126.672 I-2.131 J2.478 E.03294
G1 X137.104 Y127.73 E.02389
G2 X138.014 Y127.675 I.4 J-.95 E.0196
G2 X140.29 Y125.686 I-.911 J-3.339 E.06488
G1 X140.745 Y124.629 E.02389
M73 P71 R5
G1 X141.105 Y124.566 E.00757
G1 X141.105 Y130.536 E.12383
G1 X140.745 Y131.371 E.01887
G3 X139.835 Y131.317 I-.4 J-.95 E.0196
G3 X137.559 Y129.328 I.911 J-3.339 E.06488
G1 X137.104 Y128.27 E.02389
G2 X136.194 Y128.325 I-.4 J.95 E.0196
G2 X133.907 Y130.338 I.897 J3.324 E.06546
G1 X133.918 Y131.833 E.031
G3 X135.738 Y132.673 I-1.695 J6.062 E.04178
G3 X136.649 Y133.955 I-2.131 J2.478 E.03294
G1 X137.03 Y134.518 E.0141
G1 X138.99 Y134.518 E.04065
G2 X140.29 Y132.969 I-1.816 J-2.846 E.0426
G1 X140.745 Y131.912 E.02389
G1 X141.105 Y131.849 E.00757
G1 X141.105 Y133.546 E.0352
M204 S10000
G1 X133.516 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7344
M204 S4000
G1 X133.516 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.516 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.078 Y121.857 Z14.04 F60000
G1 X122.875 Y121.119 Z14.04
G1 Z13.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7344
M204 S4000
G1 X114.113 Y121.119 E.18174
G1 X114.113 Y134.881 E.28545
G1 X122.875 Y134.881 E.18174
G1 X122.875 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.284 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.747 Y120.71 E.18383
G1 X113.704 Y120.71 E.00083
G1 F3480
G1 X113.704 Y135.29 E.28104
G1 F3600
G1 X113.747 Y135.29 E.00083
G1 X123.284 Y135.29 E.18383
G1 X123.284 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.284 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.093 Y121.738 Z14.04 F60000
G1 Z13.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7344
M204 S4000
G1 X122.093 Y121.482 E.00531
G1 X120.652 Y121.482 E.02989
G2 X119.807 Y122.228 I1.307 J2.332 E.02357
G2 X118.896 Y124.088 I7.983 J5.06 E.04304
G1 X118.441 Y124.168 E.00958
G3 X116.62 Y123.327 I1.694 J-6.062 E.04178
G3 X115.468 Y121.482 I3.84 J-3.682 E.04544
G1 X114.895 Y121.482 E.01188
G1 X114.895 Y126.894 E.11226
G1 X115.255 Y127.73 E.01887
G2 X116.165 Y127.675 I.4 J-.95 E.0196
G2 X117.986 Y126.489 I-1.02 J-3.555 E.04575
G2 X118.896 Y124.629 I-7.984 J-5.061 E.04304
G3 X119.807 Y124.683 I.4 J.95 E.0196
G3 X122.093 Y126.696 I-.897 J3.324 E.06546
G1 X122.093 Y128.193 E.03104
G1 X121.627 Y128.325 E.01004
G2 X119.807 Y129.512 I1.02 J3.555 E.04575
G2 X118.896 Y131.371 I7.983 J5.06 E.04304
G3 X117.986 Y131.317 I-.4 J-.95 E.0196
G3 X116.165 Y130.13 I1.02 J-3.555 E.04575
G3 X115.255 Y128.27 I7.983 J-5.06 E.04304
G1 X114.895 Y128.208 E.00757
G1 X114.895 Y134.096 E.12215
G1 X115.181 Y134.518 E.01057
G1 X117.14 Y134.518 E.04065
G2 X117.986 Y133.772 I-1.306 J-2.332 E.02357
G2 X118.896 Y131.912 I-7.984 J-5.061 E.04304
G1 X119.351 Y131.833 E.00958
G3 X121.172 Y132.673 I-1.695 J6.062 E.04178
G3 X122.093 Y133.971 I-4.137 J3.912 E.03311
G1 X122.093 Y132.274 E.0352
M204 S10000
G1 X122.484 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7344
M204 S4000
G1 X122.484 Y121.57 E.2259
M204 S10000
G1 X114.504 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7344
M204 S4000
G1 X114.504 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114.504 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L114
M991 S0 P113 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.04 I-.463 J1.125 P1  F60000
G1 X141.971 Y134.881 Z14.04
G1 Z13.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7287
M204 S4000
G1 X141.971 Y121.119 E.28545
G1 X133.209 Y121.119 E.18174
G1 X133.209 Y134.881 E.28545
G1 X141.911 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.337 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.38 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

M73 P72 R5
G1 F3480
G1 X142.38 Y120.71 E.28104
G1 F3600
G1 X142.337 Y120.71 E.00083
G1 X132.8 Y120.71 E.18383
G1 X132.8 Y135.29 E.28104
G1 X142.277 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.38 Y135.29 E-.03914
G1 X142.38 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.58 Y134.49 Z14.16 F60000
G1 Z13.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7287
M204 S4000
G1 X141.58 Y121.57 E.2259
M204 S10000
G1 X141.189 Y121.734 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7287
M204 S4000
G1 X141.189 Y123.431 E.0352
G2 X141.189 Y130.714 I319.975 J3.642 E.15107
G2 X141.189 Y134.518 I161.016 J1.902 E.07891
G1 X139.047 Y134.518 E.04443
G2 X140.344 Y132.097 I-1.773 J-2.507 E.05906
G1 X140.07 Y131.642 E.01102
G3 X138.146 Y130.276 I2.799 J-5.98 E.0492
G3 X137.506 Y128.455 I3.382 J-2.212 E.04042
G1 X137.78 Y128 E.01102
G2 X139.703 Y126.634 I-2.798 J-5.98 E.0492
G2 X140.344 Y124.814 I-3.382 J-2.212 E.04042
G1 X140.07 Y124.358 E.01102
G3 X138.146 Y122.993 I2.798 J-5.979 E.0492
G3 X137.53 Y121.482 I3.979 J-2.503 E.03401
G1 X135.161 Y121.482 E.04914
G2 X133.991 Y124.114 I1.497 J2.241 E.06303
G1 X134.138 Y124.358 E.00592
G3 X136.062 Y125.724 I-2.799 J5.98 E.0492
G3 X136.702 Y127.545 I-3.383 J2.212 E.04042
G1 X136.428 Y128 E.01102
G2 X134.504 Y129.366 I2.798 J5.979 E.0492
G2 X133.991 Y131.397 I2.29 J1.659 E.04452
G1 X134.138 Y131.642 E.00592
G3 X136.062 Y133.007 I-2.798 J5.98 E.0492
G3 X136.678 Y134.518 I-3.98 J2.504 E.03401
G1 X134.981 Y134.518 E.0352
M204 S10000
G1 X133.6 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7287
M204 S4000
G1 X133.6 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.6 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.157 Y121.882 Z14.16 F60000
G1 X122.791 Y121.119 Z14.16
G1 Z13.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7287
M204 S4000
G1 X114.029 Y121.119 E.18174
G1 X114.029 Y134.881 E.28545
G1 X122.791 Y134.881 E.18174
G1 X122.791 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.2 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.663 Y120.71 E.18383
G1 X113.62 Y120.71 E.00083
G1 F3480
G1 X113.62 Y135.29 E.28104
G1 F3600
G1 X113.663 Y135.29 E.00083
G1 X123.2 Y135.29 E.18383
G1 X123.2 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.2 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.014 Y125.228 Z14.16 F60000
G1 X114.811 Y125.375 Z14.16
G1 Z13.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7287
M204 S4000
G2 X114.853 Y127.545 I13.298 J.829 E.04506
G1 X114.811 Y127.614 E.00168
G1 X114.811 Y134.518 E.1432
G1 X117.198 Y134.518 E.04951
G2 X118.459 Y132.552 I-1.776 J-2.527 E.04968
G1 X118.494 Y132.097 E.00947
G1 X118.22 Y131.642 E.01102
G1 X117.422 Y131.186 E.01905
G3 X115.692 Y128.91 I1.423 J-2.878 E.06146
G1 X115.656 Y128.455 E.00947
G1 X115.931 Y128 E.01102
G1 X116.728 Y127.545 E.01905
G2 X118.459 Y125.269 I-1.423 J-2.878 E.06146
G1 X118.494 Y124.814 E.00947
G1 X118.22 Y124.358 E.01102
G1 X117.422 Y123.903 E.01905
G3 X115.692 Y121.627 I1.423 J-2.878 E.06146
G1 X115.681 Y121.482 E.00302
G1 X120.595 Y121.482 E.10193
G2 X119.334 Y123.448 I1.776 J2.527 E.04968
G1 X119.298 Y123.903 E.00947
G1 X119.572 Y124.358 E.01102
G1 X120.37 Y124.814 E.01905
G3 X122.009 Y126.831 I-1.319 J2.746 E.0557
G1 X122.009 Y127.756 E.01918
G1 X121.862 Y128 E.00592
G1 X121.064 Y128.455 E.01905
G2 X119.334 Y130.731 I1.423 J2.878 E.06146
G1 X119.298 Y131.186 E.00947
G1 X119.572 Y131.642 E.01102
G3 X121.059 Y132.552 I-6.221 J11.832 E.03619
G3 X122.009 Y134.518 I-1.629 J2 E.04676
G1 X120.716 Y134.518 E.02683
M204 S10000
G1 X122.4 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7287
M204 S4000
G1 X122.4 Y121.57 E.2259
M204 S10000
G1 X114.42 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7287
M204 S4000
G1 X114.42 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 13.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114.42 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L115
M991 S0 P114 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.16 I-.461 J1.126 P1  F60000
G1 X142.055 Y134.881 Z14.16
G1 Z13.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6578
M204 S4000
G1 X142.055 Y121.119 E.28545
G1 X133.293 Y121.119 E.18174
G1 X133.293 Y134.881 E.28545
G1 X141.995 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.421 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.464 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.464 Y120.71 E.28104
G1 F3600
G1 X142.421 Y120.71 E.00083
G1 X132.884 Y120.71 E.18383
G1 X132.884 Y135.29 E.28104
G1 X142.361 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.464 Y135.29 E-.03914
G1 X142.464 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.664 Y134.49 Z14.28 F60000
G1 Z13.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6578
M204 S4000
G1 X141.664 Y121.57 E.2259
M204 S10000
G1 X140.812 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6578
M204 S4000
G1 X139.115 Y134.518 E.0352
G1 X139.313 Y134.373 E.0051
G2 X140.172 Y132.552 I-2.162 J-2.132 E.04256
G1 X140.12 Y132.097 E.0095
G1 X139.78 Y131.642 E.01179
G1 X138.536 Y130.731 E.03197
G3 X137.677 Y128.91 I2.163 J-2.133 E.04256
G1 X137.729 Y128.455 E.0095
G1 X138.07 Y128 E.01179
G1 X139.313 Y127.09 E.03197
G2 X140.172 Y125.269 I-2.162 J-2.132 E.04256
G1 X140.12 Y124.814 E.0095
G1 X139.78 Y124.358 E.01179
G1 X138.536 Y123.448 E.03197
G3 X137.677 Y121.627 I2.162 J-2.133 E.04256
G1 X137.694 Y121.482 E.00303
G1 X135.093 Y121.482 E.05395
G2 X134.087 Y123.903 I1.575 J2.073 E.05699
G1 X134.428 Y124.358 E.01179
G1 X135.672 Y125.269 E.03197
G3 X136.53 Y127.09 I-2.162 J2.133 E.04256
G1 X136.479 Y127.545 E.0095
G1 X136.138 Y128 E.01179
G1 X134.894 Y128.91 E.03197
G2 X134.087 Y131.186 I2.086 J2.021 E.05166
G1 X134.428 Y131.642 E.01179
G1 X135.672 Y132.552 E.03197
G3 X136.53 Y134.373 I-2.162 J2.133 E.04256
G1 X136.514 Y134.518 E.00303
G1 X134.817 Y134.518 E.0352
M204 S10000
G1 X133.684 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6578
M204 S4000
G1 X133.684 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.684 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.235 Y121.907 Z14.28 F60000
G1 X122.707 Y121.119 Z14.28
G1 Z13.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6578
M204 S4000
G1 X113.945 Y121.119 E.18174
G1 X113.945 Y134.881 E.28545
G1 X122.707 Y134.881 E.18174
G1 X122.707 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.116 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.579 Y120.71 E.18383
G1 X113.536 Y120.71 E.00083
G1 F3480
G1 X113.536 Y135.29 E.28104
G1 F3600
G1 X113.579 Y135.29 E.00083
G1 X123.116 Y135.29 E.18383
G1 X123.116 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.116 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.78 Y128.361 Z14.28 F60000
G1 X122.316 Y134.49 Z14.28
G1 Z13.88
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6578
M204 S4000
G1 X122.316 Y121.57 E.2259
M204 S10000
G1 X120.529 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6578
M204 S4000
G1 X121.925 Y134.518 E.02895
G2 X121.106 Y132.552 I-2.616 J-.064 E.0455
G1 X119.862 Y131.642 E.03197
G1 X119.521 Y131.186 E.01179
G3 X120.328 Y128.91 I2.636 J-.346 E.05199
G1 X121.572 Y128 E.03197
G1 X121.913 Y127.545 E.01179
G2 X121.106 Y125.269 I-2.893 J-.255 E.05166
G1 X119.862 Y124.358 E.03197
G1 X119.521 Y123.903 E.01179
G1 X119.47 Y123.448 E.0095
G1 X119.699 Y122.538 E.01947
G3 X120.527 Y121.482 I2.587 J1.176 E.02809
G1 X115.844 Y121.482 E.09712
G2 X116.687 Y123.448 I2.712 J.001 E.0456
G1 X117.93 Y124.358 E.03197
G1 X118.271 Y124.814 E.01179
G3 X117.464 Y127.09 I-2.636 J.346 E.05199
G1 X116.22 Y128 E.03197
G1 X115.88 Y128.455 E.01179
G2 X116.687 Y130.731 I2.636 J.346 E.05199
G1 X117.93 Y131.642 E.03197
G1 X118.271 Y132.097 E.01179
G1 X118.323 Y132.552 E.0095
G1 X118.093 Y133.462 E.01947
G3 X117.266 Y134.518 I-2.587 J-1.176 E.02808
G1 X115.569 Y134.518 E.0352
M204 S10000
G1 X114.336 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6578
M204 S4000
G1 X114.336 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114.336 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L116
M991 S0 P115 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.28 I-.459 J1.127 P1  F60000
G1 X142.139 Y134.881 Z14.28
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6516
M204 S4000
G1 X142.139 Y121.119 E.28545
G1 X133.377 Y121.119 E.18174
G1 X133.377 Y134.881 E.28545
G1 X142.079 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.505 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.548 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.548 Y120.71 E.28104
G1 F3600
G1 X142.505 Y120.71 E.00083
G1 X132.968 Y120.71 E.18383
G1 X132.968 Y135.29 E.28104
G1 X142.445 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.548 Y135.29 E-.03914
G1 X142.548 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.748 Y134.49 Z14.4 F60000
G1 Z14
M73 P73 R5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6516
M204 S4000
G1 X141.748 Y121.57 E.2259
M204 S10000
G1 X140.886 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6516
M204 S4000
G1 X139.189 Y134.518 E.0352
G2 X140.025 Y133.007 I-1.689 J-1.921 E.03653
G2 X139.574 Y131.642 I-1.439 J-.282 E.03117
G1 X138.487 Y130.731 E.02941
G3 X137.825 Y129.366 I2.258 J-1.939 E.03183
G3 X138.275 Y128 I1.439 J-.282 E.03117
G1 X139.362 Y127.09 E.02941
G2 X140.025 Y125.724 I-2.258 J-1.939 E.03183
G2 X139.574 Y124.358 I-1.439 J-.282 E.03117
G1 X138.487 Y123.448 E.02941
G3 X137.833 Y121.482 I1.837 J-1.704 E.04431
G1 X135.019 Y121.482 E.05836
G2 X134.301 Y122.538 I1.829 J2.016 E.02673
G2 X134.634 Y124.358 I1.418 J.682 E.04105
G1 X135.721 Y125.269 E.02941
G3 X136.383 Y126.634 I-2.258 J1.939 E.03183
G3 X135.933 Y128 I-1.439 J.282 E.03117
G1 X134.846 Y128.91 E.02941
G2 X134.301 Y129.821 I1.921 J1.768 E.02216
G2 X134.634 Y131.642 I1.418 J.682 E.04105
G1 X135.721 Y132.552 E.02941
G3 X136.375 Y134.518 I-1.837 J1.704 E.04431
G1 X134.678 Y134.518 E.0352
M204 S10000
G1 X133.768 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6516
M204 S4000
G1 X133.768 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.768 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.314 Y121.931 Z14.4 F60000
G1 X122.623 Y121.119 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6516
M204 S4000
G1 X113.861 Y121.119 E.18174
G1 X113.861 Y134.881 E.28545
G1 X122.623 Y134.881 E.18174
G1 X122.623 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X123.032 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.495 Y120.71 E.18383
G1 X113.452 Y120.71 E.00083
G1 F3480
G1 X113.452 Y135.29 E.28104
G1 F3600
G1 X113.495 Y135.29 E.00083
G1 X123.032 Y135.29 E.18383
G1 X123.032 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X121.032 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.696 Y128.361 Z14.4 F60000
G1 X122.232 Y134.49 Z14.4
G1 Z14
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6516
M204 S4000
G1 X122.232 Y121.57 E.2259
M204 S10000
G1 X120.35 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6516
M204 S4000
G1 X121.841 Y134.518 E.03092
G2 X121.154 Y132.552 I-2.749 J-.143 E.0443
G1 X120.067 Y131.642 E.02941
G1 X119.701 Y131.186 E.01212
G3 X120.279 Y128.91 I2.324 J-.621 E.05089
G1 X121.366 Y128 E.02941
G1 X121.733 Y127.545 E.01212
G2 X121.154 Y125.269 I-2.301 J-.627 E.05093
G1 X120.067 Y124.358 E.02941
G1 X119.701 Y123.903 E.01212
G3 X120.453 Y121.482 I2.261 J-.625 E.05555
G1 X115.983 Y121.482 E.09271
G2 X116.638 Y123.448 I2.492 J.262 E.04431
G1 X117.725 Y124.358 E.02941
G1 X118.091 Y124.814 E.01212
G3 X117.513 Y127.09 I-2.324 J.621 E.05089
G1 X116.426 Y128 E.02941
G1 X116.06 Y128.455 E.01212
G2 X116.638 Y130.731 I2.324 J.621 E.05089
G1 X117.725 Y131.642 E.02941
G1 X118.091 Y132.097 E.01212
G3 X117.34 Y134.518 I-2.261 J.625 E.05555
G1 X115.643 Y134.518 E.0352
M204 S10000
G1 X114.252 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6516
M204 S4000
G1 X114.252 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114.252 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L117
M991 S0 P116 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.4 I-.456 J1.128 P1  F60000
G1 X142.223 Y134.881 Z14.4
G1 Z14.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6480
M204 S4000
G1 X142.223 Y121.119 E.28545
G1 X133.461 Y121.119 E.18174
G1 X133.461 Y134.881 E.28545
G1 X142.163 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.589 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.632 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.632 Y120.71 E.28104
G1 F3600
G1 X142.589 Y120.71 E.00083
G1 X133.052 Y120.71 E.18383
G1 X133.052 Y135.29 E.28104
G1 X142.529 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.632 Y135.29 E-.03914
G1 X142.632 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.832 Y134.49 Z14.52 F60000
G1 Z14.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6480
M204 S4000
G1 X141.832 Y121.57 E.2259
M204 S10000
G1 X140.956 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6480
M204 S4000
G1 X139.259 Y134.518 E.0352
G2 X139.788 Y132.097 I-1.525 J-1.602 E.05457
G2 X138.436 Y130.731 I-6.198 J4.786 E.03997
G3 X138.061 Y128.455 I1.738 J-1.455 E.05019
G3 X139.414 Y127.09 I6.197 J4.785 E.03997
G2 X139.788 Y124.814 I-1.738 J-1.455 E.05019
G2 X138.436 Y123.448 I-6.197 J4.785 E.03997
G3 X137.953 Y121.482 I1.807 J-1.485 E.04342
G1 X134.949 Y121.482 E.06231
G2 X134.42 Y123.903 I1.525 J1.602 E.05457
G2 X135.772 Y125.269 I6.198 J-4.786 E.03997
G3 X136.147 Y127.545 I-1.738 J1.455 E.05019
G3 X134.794 Y128.91 I-6.197 J-4.785 E.03997
G2 X134.42 Y131.186 I1.738 J1.455 E.05019
G2 X135.772 Y132.552 I6.197 J-4.785 E.03997
G3 X136.254 Y134.518 I-1.807 J1.486 E.04342
G1 X134.557 Y134.518 E.0352
M204 S10000
G1 X133.852 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6480
M204 S4000
G1 X133.852 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.852 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.393 Y121.954 Z14.52 F60000
G1 X122.539 Y121.119 Z14.52
G1 Z14.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6480
M204 S4000
G1 X113.777 Y121.119 E.18174
G1 X113.777 Y134.881 E.28545
G1 X122.539 Y134.881 E.18174
G1 X122.539 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.948 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.411 Y120.71 E.18383
G1 X113.368 Y120.71 E.00083
G1 F3480
G1 X113.368 Y135.29 E.28104
G1 F3600
G1 X113.411 Y135.29 E.00083
G1 X122.948 Y135.29 E.18383
G1 X122.948 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.948 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.757 Y121.805 Z14.52 F60000
G1 Z14.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6480
M204 S4000
G1 X121.757 Y121.482 E.0067
G1 X120.383 Y121.482 E.0285
G2 X119.853 Y123.903 I1.525 J1.602 E.05457
G2 X121.206 Y125.269 I6.198 J-4.786 E.03997
G3 X121.58 Y127.545 I-1.738 J1.455 E.05019
G3 X120.228 Y128.91 I-6.197 J-4.785 E.03997
G2 X119.853 Y131.186 I1.738 J1.455 E.05019
G2 X121.206 Y132.552 I6.197 J-4.785 E.03997
G3 X121.688 Y134.518 I-1.807 J1.485 E.04342
G1 X117.409 Y134.518 E.08876
G2 X117.939 Y132.097 I-1.525 J-1.602 E.05457
G2 X116.586 Y130.731 I-6.198 J4.786 E.03997
G3 X116.212 Y128.455 I1.738 J-1.455 E.05019
G3 X117.564 Y127.09 I6.197 J4.785 E.03997
G2 X117.939 Y124.814 I-1.738 J-1.455 E.05019
G2 X116.586 Y123.448 I-6.197 J4.785 E.03997
G3 X116.104 Y121.482 I1.807 J-1.486 E.04342
G1 X114.559 Y121.482 E.03205
G1 X114.559 Y121.634 E.00315
M204 S10000
G1 X114.168 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6480
M204 S4000
G1 X114.168 Y121.57 E.2259
M204 S10000
G1 X122.148 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6480
M204 S4000
G1 X122.148 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X122.148 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L118
M991 S0 P117 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.52 I-.595 J1.061 P1  F60000
G1 X142.307 Y134.881 Z14.52
G1 Z14.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6437
M204 S4000
G1 X142.307 Y121.119 E.28545
G1 X133.545 Y121.119 E.18174
G1 X133.545 Y134.881 E.28545
G1 X142.247 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.673 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.716 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.716 Y120.71 E.28104
G1 F3600
G1 X142.673 Y120.71 E.00083
G1 X133.136 Y120.71 E.18383
G1 X133.136 Y135.29 E.28104
G1 X142.613 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.716 Y135.29 E-.03914
G1 X142.716 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.916 Y134.49 Z14.64 F60000
G1 Z14.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6437
M204 S4000
G1 X141.916 Y121.57 E.2259
M204 S10000
G1 X141.039 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6437
M204 S4000
G1 X139.343 Y134.518 E.0352
G2 X139.852 Y132.552 I-1.835 J-1.525 E.04351
G2 X138.776 Y131.186 I-3.056 J1.301 E.03649
G3 X137.997 Y128.91 I1.663 J-1.84 E.05209
G3 X139.073 Y127.545 I3.056 J1.302 E.03649
G2 X139.852 Y125.269 I-1.663 J-1.84 E.05209
G2 X138.776 Y123.903 I-3.056 J1.301 E.03649
G3 X138.06 Y121.482 I1.524 J-1.767 E.05534
G1 X134.865 Y121.482 E.06627
G2 X134.356 Y123.448 I2.043 J1.579 E.0433
G2 X135.432 Y124.814 I3.056 J-1.301 E.03649
G3 X136.21 Y127.09 I-1.663 J1.84 E.05209
G3 X135.134 Y128.455 I-3.056 J-1.302 E.03649
G2 X134.356 Y130.731 I1.81 J1.89 E.05184
G2 X135.432 Y132.097 I3.056 J-1.301 E.03649
G3 X136.148 Y134.518 I-1.524 J1.767 E.05533
G1 X134.451 Y134.518 E.0352
M204 S10000
G1 X133.936 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6437
M204 S4000
G1 X133.936 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X133.936 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.472 Y121.977 Z14.64 F60000
G1 X122.455 Y121.119 Z14.64
G1 Z14.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6437
M204 S4000
G1 X113.693 Y121.119 E.18174
G1 X113.693 Y134.881 E.28545
G1 X122.455 Y134.881 E.18174
G1 X122.455 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.864 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.327 Y120.71 E.18383
G1 X113.284 Y120.71 E.00083
M73 P74 R5
G1 F3480
G1 X113.284 Y135.29 E.28104
G1 F3600
G1 X113.327 Y135.29 E.00083
G1 X122.864 Y135.29 E.18383
G1 X122.864 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.864 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.673 Y121.805 Z14.64 F60000
G1 Z14.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6437
M204 S4000
G1 X121.673 Y121.482 E.0067
G1 X120.299 Y121.482 E.0285
G2 X120.377 Y124.358 I1.466 J1.4 E.06636
G3 X121.673 Y126.398 I-1.649 J2.479 E.05161
G3 X121.057 Y128 I-1.813 J.222 E.03707
G2 X119.737 Y130.276 I1.642 J2.474 E.05654
G2 X120.377 Y131.642 I1.923 J-.069 E.03215
G3 X121.673 Y133.681 I-1.649 J2.479 E.05161
G3 X121.581 Y134.518 I-1.653 J.242 E.01766
G1 X117.493 Y134.518 E.0848
G2 X117.415 Y131.642 I-1.466 J-1.4 E.06636
G3 X116.095 Y129.366 I1.642 J-2.474 E.05654
G3 X116.735 Y128 I1.923 J.069 E.03215
G2 X118.056 Y125.724 I-1.642 J-2.474 E.05654
G2 X117.415 Y124.358 I-1.923 J.069 E.03215
G3 X116.095 Y122.082 I1.642 J-2.474 E.05654
G3 X116.211 Y121.482 I1.055 J-.108 E.01287
G1 X114.514 Y121.482 E.0352
M204 S10000
G1 X114.084 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6437
M204 S4000
G1 X114.084 Y121.57 E.2259
M204 S10000
G1 X122.064 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6437
M204 S4000
G1 X122.064 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F8640
G1 X122.064 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L119
M991 S0 P118 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.64 I-.592 J1.063 P1  F60000
G1 X142.391 Y134.881 Z14.64
G1 Z14.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6374
M204 S4000
G1 X142.391 Y121.119 E.28545
G1 X133.629 Y121.119 E.18174
G1 X133.629 Y134.881 E.28545
G1 X142.331 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.757 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.8 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.8 Y120.71 E.28104
G1 F3600
G1 X142.757 Y120.71 E.00083
G1 X133.22 Y120.71 E.18383
G1 X133.22 Y135.29 E.28104
G1 X142.697 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.8 Y135.29 E-.03914
G1 X142.8 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142 Y134.49 Z14.76 F60000
G1 Z14.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6374
M204 S4000
G1 X142 Y121.57 E.2259
M204 S10000
G1 X141.111 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6374
M204 S4000
G1 X139.414 Y134.518 E.0352
G2 X139.767 Y132.552 I-1.856 J-1.347 E.04286
G2 X138.675 Y131.186 I-3.852 J1.96 E.03652
G3 X138.715 Y128 I1.495 J-1.575 E.07421
G2 X139.767 Y125.269 I-1.482 J-2.139 E.06447
G2 X138.675 Y123.903 I-3.852 J1.96 E.03652
G3 X138.157 Y121.482 I1.558 J-1.6 E.05444
G1 X134.793 Y121.482 E.06976
G2 X134.411 Y122.33 I1.895 J1.365 E.01942
G1 X134.441 Y123.448 E.0232
G2 X135.533 Y124.814 I3.852 J-1.96 E.03652
G3 X135.493 Y128 I-1.495 J1.575 E.07421
G2 X134.411 Y129.613 I2.099 J2.577 E.04088
G1 X134.441 Y130.731 E.0232
G2 X135.533 Y132.097 I3.852 J-1.96 E.03652
G3 X136.051 Y134.518 I-1.558 J1.6 E.05444
G1 X134.411 Y134.518 E.03402
G1 X134.411 Y134.461 E.00118
M204 S10000
G1 X134.02 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6374
M204 S4000
G1 X134.02 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.02 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.551 Y121.999 Z14.76 F60000
G1 X122.371 Y121.119 Z14.76
G1 Z14.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6374
M204 S4000
G1 X113.609 Y121.119 E.18174
G1 X113.609 Y134.881 E.28545
G1 X122.371 Y134.881 E.18174
G1 X122.371 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.78 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.243 Y120.71 E.18383
G1 X113.2 Y120.71 E.00083
G1 F3480
G1 X113.2 Y135.29 E.28104
G1 F3600
G1 X113.243 Y135.29 E.00083
G1 X122.78 Y135.29 E.18383
G1 X122.78 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.78 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.444 Y128.361 Z14.76 F60000
G1 X121.98 Y134.49 Z14.76
G1 Z14.36
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6374
M204 S4000
G1 X121.98 Y121.57 E.2259
M204 S10000
G1 X121.156 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6374
M204 S4000
G1 X121.589 Y134.518 E.00899
G1 X121.589 Y133.254 E.02621
G2 X120.507 Y131.642 I-3.181 J.964 E.04087
G3 X120.467 Y128.455 I1.455 J-1.612 E.07421
G2 X121.559 Y127.09 I-2.76 J-3.326 E.03652
G2 X120.507 Y124.358 I-2.557 J-.584 E.0644
G3 X120.227 Y121.482 I1.404 J-1.589 E.06596
G1 X116.307 Y121.482 E.08131
G1 X116.233 Y121.627 E.00338
G2 X117.285 Y124.358 I2.534 J.592 E.06447
G3 X117.325 Y127.545 I-1.455 J1.612 E.07421
G2 X116.233 Y128.91 I2.76 J3.326 E.03652
G2 X117.285 Y131.642 I2.534 J.592 E.06447
G3 X117.565 Y134.518 I-1.404 J1.589 E.06596
G1 X115.868 Y134.518 E.0352
M204 S10000
G1 X114 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6374
M204 S4000
G1 X114 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X114 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L120
M991 S0 P119 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.76 I-.449 J1.131 P1  F60000
G1 X142.475 Y134.881 Z14.76
G1 Z14.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X142.475 Y121.119 E.28545
G1 X133.713 Y121.119 E.18174
G1 X133.713 Y134.881 E.28545
G1 X142.415 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.841 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.884 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.884 Y120.71 E.28104
G1 F3600
G1 X142.841 Y120.71 E.00083
G1 X133.304 Y120.71 E.18383
G1 X133.304 Y135.29 E.28104
G1 X142.781 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.884 Y135.29 E-.03914
G1 X142.884 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.084 Y134.49 Z14.88 F60000
G1 Z14.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X142.084 Y121.57 E.2259
M204 S10000
G1 X140.8 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X141.693 Y121.482 E.01852
G2 X141.693 Y123.055 I28.025 J.786 E.03263
G1 X141.693 Y129.569 E.13512
G2 X141.693 Y130.338 I2.47 J.384 E.01601
G1 X141.693 Y134.518 E.0867
G1 X139.489 Y134.518 E.04571
G2 X139.011 Y131.642 I-1.849 J-1.171 E.06619
G3 X138.425 Y128.455 I1.374 J-1.9 E.07419
G2 X139.59 Y127.09 I-7.62 J-7.677 E.03727
G2 X139.011 Y124.358 I-1.942 J-1.015 E.06278
G3 X138.245 Y121.482 I1.386 J-1.91 E.06681
G1 X134.719 Y121.482 E.07314
G2 X134.495 Y121.944 I.854 J.698 E.01074
G1 X134.495 Y123.364 E.02944
G2 X135.197 Y124.358 I2.679 J-1.145 E.02544
G3 X135.782 Y127.545 I-1.374 J1.9 E.07419
G2 X134.618 Y128.91 I7.621 J7.677 E.03727
G1 X134.495 Y129.227 E.00705
G1 X134.495 Y130.647 E.02944
G2 X135.197 Y131.642 I2.679 J-1.145 E.02544
G3 X135.963 Y134.518 I-1.386 J1.91 E.06681
G1 X134.495 Y134.518 E.03046
G1 X134.495 Y134.289 E.00474
M204 S10000
G1 X134.104 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X134.104 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.104 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.631 Y122.02 Z14.88 F60000
G1 X122.287 Y121.119 Z14.88
G1 Z14.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G1 X113.525 Y121.119 E.18174
G1 X113.525 Y134.881 E.28545
G1 X122.287 Y134.881 E.18174
G1 X122.287 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.696 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.159 Y120.71 E.18383
G1 X113.116 Y120.71 E.00083
G1 F3480
G1 X113.116 Y135.29 E.28104
G1 F3600
G1 X113.159 Y135.29 E.00083
G1 X122.696 Y135.29 E.18383
G1 X122.696 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.696 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.307 Y124.23 Z14.88 F60000
G1 Z14.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7078
M204 S4000
G3 X114.307 Y126.697 I-49.49 J1.233 E.05117
G1 X114.307 Y133.21 E.1351
G3 X114.307 Y134.518 I-10.476 J.654 E.02714
G1 X117.64 Y134.518 E.06914
G2 X117.162 Y131.642 I-1.849 J-1.171 E.06619
G3 X116.311 Y128.91 I1.426 J-1.943 E.06353
G3 X117.426 Y127.545 I5.054 J2.989 E.03671
G2 X117.162 Y124.358 I-1.662 J-1.467 E.07408
G3 X116.395 Y121.482 I1.386 J-1.91 E.06681
G1 X120.152 Y121.482 E.07793
G2 X120.63 Y124.358 I1.849 J1.171 E.06619
G3 X121.505 Y125.606 I-1.952 J2.298 E.03196
G1 X121.482 Y127.09 E.03077
M73 P75 R5
G3 X120.367 Y128.455 I-5.055 J-2.989 E.03671
G2 X120.63 Y131.642 I1.662 J1.467 E.07408
G3 X121.505 Y132.89 I-1.952 J2.298 E.03196
G1 X121.505 Y134.518 E.03378
G1 X121.436 Y134.518 E.00142
M204 S10000
G1 X121.896 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7078
M204 S4000
G1 X121.896 Y121.57 E.2259
M204 S10000
G1 X113.916 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7078
M204 S4000
G1 X113.916 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X113.916 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L121
M991 S0 P120 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z14.88 I-.447 J1.132 P1  F60000
G1 X142.559 Y134.881 Z14.88
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7019
M204 S4000
G1 X142.559 Y121.119 E.28545
G1 X133.797 Y121.119 E.18174
G1 X133.797 Y134.881 E.28545
G1 X142.499 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X142.925 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.968 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X142.968 Y120.71 E.28104
G1 F3600
G1 X142.925 Y120.71 E.00083
G1 X133.388 Y120.71 E.18383
G1 X133.388 Y135.29 E.28104
G1 X142.865 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X142.968 Y135.29 E-.03914
G1 X142.968 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.168 Y134.49 Z15 F60000
G1 Z14.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7019
M204 S4000
G1 X142.168 Y121.57 E.2259
M204 S10000
G1 X134.579 Y121.723 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7019
M204 S4000
G1 X134.579 Y123.42 E.0352
G2 X135.317 Y124.358 I3.596 J-2.068 E.02485
G3 X135.249 Y128 I-1.444 J1.795 E.08713
G2 X134.579 Y128.863 I1.88 J2.152 E.02281
G1 X134.579 Y130.703 E.03816
G2 X135.317 Y131.642 I3.597 J-2.069 E.02485
G3 X135.882 Y134.518 I-1.359 J1.761 E.06638
G1 X139.568 Y134.518 E.07647
G2 X138.891 Y131.642 I-2.024 J-1.041 E.06671
G3 X138.958 Y128 I1.444 J-1.795 E.08713
G2 X138.891 Y124.358 I-1.444 J-1.795 E.08713
G3 X138.326 Y121.482 I1.359 J-1.761 E.06638
G1 X141.777 Y121.482 E.07158
G3 X141.656 Y122.538 I-12.977 J-.957 E.02205
G2 X141.777 Y123.179 I1.501 J.049 E.01366
G1 X141.777 Y129.091 E.12263
G2 X141.777 Y130.463 I1.727 J.686 E.02913
G1 X141.777 Y132.16 E.0352
M204 S10000
G1 X134.188 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7019
M204 S4000
G1 X134.188 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.188 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.71 Y122.041 Z15 F60000
G1 X122.203 Y121.119 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7019
M204 S4000
G1 X113.441 Y121.119 E.18174
G1 X113.441 Y134.881 E.28545
G1 X122.203 Y134.881 E.18174
G1 X122.203 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.612 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X113.075 Y120.71 E.18383
G1 X113.032 Y120.71 E.00083
G1 F3480
G1 X113.032 Y135.29 E.28104
G1 F3600
G1 X113.075 Y135.29 E.00083
G1 X122.612 Y135.29 E.18383
G1 X122.612 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.612 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.223 Y123.753 Z15 F60000
G1 Z14.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7019
M204 S4000
G1 X114.223 Y125.45 E.0352
G3 X114.223 Y126.821 I-1.727 J.686 E.02914
G1 X114.223 Y132.733 E.12262
G3 X114.344 Y133.462 I-1.564 J.635 E.01547
G2 X114.223 Y134.518 I5.502 J1.168 E.02207
G1 X117.719 Y134.518 E.07252
G2 X117.042 Y131.642 I-2.024 J-1.041 E.06671
G3 X117.109 Y128 I1.444 J-1.795 E.08713
G2 X117.042 Y124.358 I-1.444 J-1.795 E.08713
G3 X116.477 Y121.482 I1.359 J-1.761 E.06638
G1 X120.073 Y121.482 E.0746
G2 X120.322 Y123.903 I1.866 J1.031 E.05373
G3 X121.421 Y125.222 I-4.727 J5.057 E.03569
G1 X121.421 Y127.057 E.03807
G3 X120.683 Y128 I-3.429 J-1.922 E.02494
G2 X120.322 Y131.186 I1.376 J1.769 E.07412
G3 X121.421 Y132.505 I-4.727 J5.057 E.03569
G1 X121.421 Y134.202 E.0352
M204 S10000
G1 X121.812 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7019
M204 S4000
G1 X121.812 Y121.57 E.2259
M204 S10000
G1 X113.832 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7019
M204 S4000
G1 X113.832 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.832 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L122
M991 S0 P121 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15 I-.445 J1.133 P1  F60000
G1 X142.643 Y134.881 Z15
G1 Z14.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7031
M204 S4000
G1 X142.643 Y121.119 E.28545
G1 X133.881 Y121.119 E.18174
G1 X133.881 Y134.881 E.28545
G1 X142.583 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.009 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.052 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.052 Y120.71 E.28104
G1 F3600
G1 X143.009 Y120.71 E.00083
G1 X133.472 Y120.71 E.18383
G1 X133.472 Y135.29 E.28104
G1 X142.949 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.052 Y135.29 E-.03914
G1 X143.052 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.252 Y134.49 Z15.12 F60000
G1 Z14.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7031
M204 S4000
G1 X142.252 Y121.57 E.2259
M204 S10000
G1 X134.663 Y121.763 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7031
M204 S4000
G1 X134.663 Y123.46 E.0352
G2 X135.844 Y124.814 I12.378 J-9.608 E.03728
G3 X135.577 Y127.545 I-1.842 J1.199 E.06148
G2 X134.663 Y128.565 I4.574 J5.016 E.02845
G1 X134.663 Y130.743 E.04519
G2 X135.844 Y132.097 I12.38 J-9.609 E.03727
G3 X135.805 Y134.518 I-1.737 J1.183 E.05353
G1 X139.653 Y134.518 E.07982
G2 X138.77 Y131.642 I-2.293 J-.869 E.06719
G3 X138.631 Y128.455 I1.429 J-1.658 E.07411
G2 X139.732 Y127.09 I-3.209 J-3.714 E.03658
G2 X138.77 Y124.358 I-2.42 J-.682 E.06401
G3 X138.403 Y121.482 I1.388 J-1.639 E.06603
G1 X141.807 Y121.482 E.07062
G2 X141.861 Y123.317 I2.262 J.852 E.03907
G1 X141.861 Y128.602 E.10962
G2 X141.861 Y130.601 I2.284 J.999 E.04265
G1 X141.861 Y132.298 E.0352
M204 S10000
G1 X134.272 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7031
M204 S4000
G1 X134.272 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.272 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.79 Y122.061 Z15.12 F60000
G1 X122.119 Y121.119 Z15.12
G1 Z14.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7031
M204 S4000
G1 X113.357 Y121.119 E.18174
G1 X113.357 Y134.881 E.28545
G1 X122.119 Y134.881 E.18174
G1 X122.119 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.528 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.991 Y120.71 E.18383
G1 X112.948 Y120.71 E.00083
G1 F3480
G1 X112.948 Y135.29 E.28104
G1 F3600
G1 X112.991 Y135.29 E.00083
G1 X122.528 Y135.29 E.18383
G1 X122.528 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.528 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.139 Y123.383 Z15.12 F60000
G1 Z14.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7031
M204 S4000
G1 X114.139 Y125.08 E.0352
G3 X114.139 Y126.914 I-1.901 J.917 E.03935
G1 X114.139 Y132.363 E.11303
G3 X114.349 Y133.462 I-1.837 J.921 E.02351
G2 X114.139 Y134.518 I4.436 J1.433 E.02237
G1 X117.804 Y134.518 E.07602
G2 X116.92 Y131.642 I-2.293 J-.869 E.0672
G3 X116.782 Y128.455 I1.429 J-1.658 E.07411
G2 X117.883 Y127.09 I-3.209 J-3.714 E.03658
G2 X116.92 Y124.358 I-2.42 J-.682 E.06401
G3 X116.553 Y121.482 I1.388 J-1.639 E.06603
G1 X119.988 Y121.482 E.07125
G2 X120.088 Y123.448 I2.005 J.884 E.04235
G2 X121.337 Y124.923 I54.521 J-44.902 E.0401
G1 X121.337 Y127.102 E.04519
G3 X120.562 Y128 I-3.512 J-2.248 E.02469
G2 X120.088 Y130.731 I1.399 J1.65 E.06241
G2 X121.337 Y132.206 I54.598 J-44.968 E.0401
G1 X121.337 Y133.903 E.0352
M204 S10000
G1 X121.728 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7031
M204 S4000
G1 X121.728 Y121.57 E.2259
M204 S10000
G1 X113.748 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7031
M204 S4000
G1 X113.748 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.748 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L123
M991 S0 P122 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.12 I-.442 J1.134 P1  F60000
G1 X142.727 Y134.881 Z15.12
G1 Z14.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7052
M204 S4000
G1 X142.727 Y121.119 E.28545
G1 X133.965 Y121.119 E.18174
G1 X133.965 Y134.881 E.28545
G1 X142.667 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.093 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.136 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

M73 P76 R5
G1 F3480
G1 X143.136 Y120.71 E.28104
G1 F3600
G1 X143.093 Y120.71 E.00083
G1 X133.556 Y120.71 E.18383
G1 X133.556 Y135.29 E.28104
G1 X143.033 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.136 Y135.29 E-.03914
G1 X143.136 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.336 Y134.49 Z15.24 F60000
G1 Z14.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7052
M204 S4000
G1 X142.336 Y121.57 E.2259
M204 S10000
G1 X134.747 Y121.791 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7052
M204 S4000
G1 X134.747 Y123.488 E.0352
G2 X135.959 Y124.814 I53.465 J-47.667 E.03727
G3 X135.476 Y127.545 I-2 J1.055 E.06193
G2 X134.747 Y128.294 I3.675 J4.309 E.02171
G1 X134.747 Y130.771 E.05138
G2 X135.959 Y132.097 I53.497 J-47.697 E.03727
G3 X135.732 Y134.518 I-1.872 J1.046 E.05363
G1 X139.746 Y134.518 E.08325
G2 X139.118 Y132.097 I-2.166 J-.73 E.0549
G3 X138.036 Y130.731 I2.289 J-2.925 E.03648
G3 X138.732 Y128.455 I2.371 J-.52 E.05159
G2 X139.814 Y127.09 I-2.289 J-2.925 E.03648
G2 X139.118 Y124.814 I-2.371 J-.52 E.05159
G3 X138.036 Y123.448 I2.289 J-2.925 E.03648
G3 X138.476 Y121.482 I2.283 J-.521 E.0432
G1 X141.745 Y121.482 E.06782
G2 X141.945 Y123.346 I2.048 J.723 E.04021
G1 X141.945 Y128.392 E.10465
G2 X141.945 Y130.63 I1.737 J1.119 E.04905
G1 X141.945 Y132.327 E.0352
M204 S10000
G1 X134.356 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7052
M204 S4000
G1 X134.356 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.356 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.87 Y122.081 Z15.24 F60000
G1 X122.035 Y121.119 Z15.24
G1 Z14.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7052
M204 S4000
G1 X113.273 Y121.119 E.18174
G1 X113.273 Y134.881 E.28545
G1 X122.035 Y134.881 E.18174
G1 X122.035 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.444 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.907 Y120.71 E.18383
G1 X112.864 Y120.71 E.00083
G1 F3480
G1 X112.864 Y135.29 E.28104
G1 F3600
G1 X112.907 Y135.29 E.00083
G1 X122.444 Y135.29 E.18383
G1 X122.444 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.444 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.055 Y123.053 Z15.24 F60000
G1 Z14.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7052
M204 S4000
G1 X114.055 Y124.75 E.0352
G3 X114.055 Y126.988 I-1.737 J1.119 E.04905
G1 X114.055 Y132.033 E.10465
G3 X114.237 Y133.918 I-1.674 J1.113 E.04089
G2 X114.055 Y134.518 I.491 J.477 E.01352
G1 X117.896 Y134.518 E.07968
G2 X118.034 Y133.918 I-.953 J-.534 E.01295
G2 X116.794 Y131.642 I-2.86 J.082 E.05579
G3 X116.117 Y130.276 I1.366 J-1.527 E.03239
G3 X117.357 Y128 I2.86 J.082 E.05579
G2 X118.034 Y126.634 I-1.366 J-1.527 E.03239
G2 X116.794 Y124.358 I-2.86 J.082 E.05579
G3 X116.626 Y121.482 I1.429 J-1.526 E.06594
G1 X119.896 Y121.482 E.06782
G2 X120.148 Y123.448 I2.096 J.73 E.04262
G2 X121.253 Y124.652 I24.866 J-21.713 E.0339
G1 X121.253 Y127.129 E.05139
G3 X120.435 Y128 I-4.131 J-3.061 E.02483
G2 X120.148 Y130.731 I1.429 J1.531 E.06212
G2 X121.253 Y131.935 I24.873 J-21.719 E.0339
G1 X121.253 Y133.632 E.0352
M204 S10000
G1 X121.644 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7052
M204 S4000
G1 X121.644 Y121.57 E.2259
M204 S10000
G1 X113.664 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7052
M204 S4000
G1 X113.664 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 14.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.664 Y123.57 E-.76
; WIPE_END
M73 P76 R4
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L124
M991 S0 P123 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.24 I-.44 J1.135 P1  F60000
G1 X142.811 Y134.881 Z15.24
G1 Z14.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7080
M204 S4000
G1 X142.811 Y121.119 E.28545
G1 X134.049 Y121.119 E.18174
G1 X134.049 Y134.881 E.28545
G1 X142.751 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.177 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.22 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.22 Y120.71 E.28104
G1 F3600
G1 X143.177 Y120.71 E.00083
G1 X133.64 Y120.71 E.18383
G1 X133.64 Y135.29 E.28104
G1 X143.117 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.22 Y135.29 E-.03914
G1 X143.22 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.42 Y134.49 Z15.36 F60000
G1 Z14.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7080
M204 S4000
G1 X142.42 Y121.57 E.2259
M204 S10000
G1 X134.831 Y121.81 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7080
M204 S4000
G1 X134.831 Y123.507 E.0352
G3 X136.086 Y124.814 I-6.204 J7.217 E.03764
G3 X135.796 Y127.09 I-2.044 J.896 E.04999
G2 X134.831 Y128.04 I4.483 J5.518 E.02813
G1 X134.831 Y130.79 E.05706
G3 X136.086 Y132.097 I-6.205 J7.218 E.03764
G3 X135.647 Y134.518 I-1.974 J.892 E.05428
G1 X139.848 Y134.518 E.08713
G2 X139.437 Y132.552 I-2.221 J-.562 E.04312
G3 X138.122 Y131.186 I6.484 J-7.564 E.03939
G3 X138.412 Y128.91 I2.044 J-.896 E.04999
G2 X139.728 Y127.545 I-6.482 J-7.562 E.03939
G2 X139.437 Y125.269 I-2.044 J-.896 E.04999
G3 X138.122 Y123.903 I6.484 J-7.564 E.03939
G3 X138.561 Y121.482 I1.974 J-.892 E.05428
G1 X141.643 Y121.482 E.06394
G2 X142.029 Y123.407 I2.198 J.561 E.04212
G1 X142.029 Y128.14 E.09818
G2 X141.78 Y130.276 I1.399 J1.246 E.0475
G1 X142.029 Y130.69 E.01003
G1 X142.029 Y132.387 E.0352
M204 S10000
G1 X134.44 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7080
M204 S4000
G1 X134.44 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.44 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.951 Y122.1 Z15.36 F60000
G1 X121.951 Y121.119 Z15.36
G1 Z14.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7080
M204 S4000
G1 X113.189 Y121.119 E.18174
G1 X113.189 Y134.881 E.28545
G1 X121.951 Y134.881 E.18174
G1 X121.951 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.36 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.823 Y120.71 E.18383
G1 X112.78 Y120.71 E.00083
G1 F3480
G1 X112.78 Y135.29 E.28104
G1 F3600
G1 X112.823 Y135.29 E.00083
G1 X122.36 Y135.29 E.18383
G1 X122.36 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.36 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.971 Y122.802 Z15.36 F60000
G1 Z14.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7080
M204 S4000
G1 X113.971 Y124.499 E.0352
G1 X114.237 Y124.814 E.00855
G3 X113.971 Y127.049 I-2.024 J.893 E.04898
G1 X113.971 Y131.782 E.09818
G1 X114.237 Y132.097 E.00855
G3 X113.971 Y134.332 I-2.024 J.893 E.04898
G1 X113.971 Y134.518 E.00386
G1 X117.998 Y134.518 E.08354
G2 X117.588 Y132.552 I-2.221 J-.562 E.04312
G3 X116.272 Y131.186 I6.482 J-7.562 E.03939
G3 X116.563 Y128.91 I2.044 J-.896 E.04999
G2 X117.879 Y127.545 I-6.484 J-7.564 E.03939
G2 X117.588 Y125.269 I-2.044 J-.896 E.04999
G3 X116.272 Y123.903 I6.483 J-7.563 E.03939
G3 X116.711 Y121.482 I1.974 J-.892 E.05428
G1 X119.794 Y121.482 E.06394
G2 X120.204 Y123.448 I2.221 J.562 E.04312
G3 X121.169 Y124.398 I-4.486 J5.52 E.02812
G1 X121.169 Y127.149 E.05706
G2 X119.914 Y128.455 I6.205 J7.218 E.03764
G2 X120.204 Y130.731 I2.044 J.896 E.04999
G3 X121.169 Y131.681 I-4.486 J5.52 E.02812
G1 X121.169 Y133.378 E.0352
M204 S10000
G1 X121.56 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7080
M204 S4000
G1 X121.56 Y121.57 E.2259
M204 S10000
G1 X113.58 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7080
M204 S4000
G1 X113.58 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.58 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L125
M991 S0 P124 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.36 I-.438 J1.135 P1  F60000
G1 X142.895 Y134.881 Z15.36
G1 Z15.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7123
M204 S4000
G1 X142.895 Y121.119 E.28545
G1 X134.133 Y121.119 E.18174
G1 X134.133 Y134.881 E.28545
G1 X142.835 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.261 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.304 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.304 Y120.71 E.28104
G1 F3600
G1 X143.261 Y120.71 E.00083
G1 X133.724 Y120.71 E.18383
G1 X133.724 Y135.29 E.28104
G1 X143.201 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.304 Y135.29 E-.03914
G1 X143.304 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.504 Y134.49 Z15.48 F60000
G1 Z15.08
M73 P77 R4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7123
M204 S4000
G1 X142.504 Y121.57 E.2259
M204 S10000
G1 X134.915 Y121.832 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7123
M204 S4000
G1 X134.915 Y123.529 E.0352
G3 X136.229 Y124.814 I-3.274 J4.664 E.03829
G3 X135.743 Y127.09 I-2.22 J.715 E.05054
G1 X134.915 Y127.819 E.02289
G1 X134.915 Y130.812 E.06208
G3 X136.229 Y132.097 I-3.274 J4.664 E.03829
G3 X135.578 Y134.518 I-2.166 J.716 E.05506
G1 X139.962 Y134.518 E.09093
G2 X139.384 Y132.552 I-2.394 J-.364 E.04388
G3 X137.978 Y131.186 I3.475 J-4.985 E.04083
G3 X138.465 Y128.91 I2.22 J-.715 E.05054
G2 X139.871 Y127.545 I-3.474 J-4.984 E.04083
G2 X139.384 Y125.269 I-2.22 J-.715 E.05054
G3 X137.978 Y123.903 I3.475 J-4.985 E.04083
G3 X138.63 Y121.482 I2.166 J-.716 E.05506
G1 X141.529 Y121.482 E.06014
G2 X142.113 Y123.454 I2.393 J.364 E.04406
G1 X142.113 Y127.894 E.0921
G2 X141.597 Y129.821 I.994 J1.298 E.04449
G2 X142.113 Y130.737 I3.558 J-1.399 E.02189
G1 X142.113 Y132.434 E.0352
M204 S10000
G1 X134.524 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7123
M204 S4000
G1 X134.524 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.524 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.031 Y122.119 Z15.48 F60000
G1 X121.867 Y121.119 Z15.48
G1 Z15.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7123
M204 S4000
G1 X113.105 Y121.119 E.18174
G1 X113.105 Y134.881 E.28545
G1 X121.867 Y134.881 E.18174
G1 X121.867 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.276 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.739 Y120.71 E.18383
G1 X112.696 Y120.71 E.00083
G1 F3480
G1 X112.696 Y135.29 E.28104
G1 F3600
G1 X112.739 Y135.29 E.00083
G1 X122.276 Y135.29 E.18383
G1 X122.276 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.276 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.887 Y122.471 Z15.48 F60000
G1 Z15.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7123
M204 S4000
G1 X113.887 Y124.168 E.0352
G2 X114.38 Y124.814 I2.829 J-1.649 E.0169
G3 X113.887 Y127.103 I-2.082 J.749 E.05118
G1 X113.887 Y131.451 E.09019
G2 X114.38 Y132.097 I2.829 J-1.648 E.0169
G3 X113.894 Y134.373 I-2.22 J.715 E.05054
G2 X113.887 Y134.518 I.14 J.079 E.00313
G1 X118.113 Y134.518 E.08765
G2 X117.535 Y132.552 I-2.394 J-.364 E.04388
G3 X116.129 Y131.186 I3.475 J-4.984 E.04083
G3 X116.616 Y128.91 I2.22 J-.715 E.05054
G2 X118.022 Y127.545 I-3.475 J-4.984 E.04083
G2 X117.535 Y125.269 I-2.22 J-.715 E.05054
G3 X116.129 Y123.903 I3.475 J-4.985 E.04083
G3 X116.78 Y121.482 I2.166 J-.716 E.05506
G1 X119.68 Y121.482 E.06014
G2 X120.257 Y123.448 I2.394 J.365 E.04388
G1 X121.085 Y124.178 E.02289
G1 X121.085 Y127.17 E.06208
G2 X119.771 Y128.455 I3.273 J4.664 E.03829
G2 X120.257 Y130.731 I2.22 J.715 E.05054
G1 X121.085 Y131.461 E.02289
G1 X121.085 Y133.158 E.0352
M204 S10000
G1 X121.476 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7123
M204 S4000
G1 X121.476 Y121.57 E.2259
M204 S10000
G1 X113.496 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7123
M204 S4000
G1 X113.496 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.496 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L126
M991 S0 P125 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.48 I-.436 J1.136 P1  F60000
G1 X142.979 Y134.881 Z15.48
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7182
M204 S4000
G1 X142.979 Y121.119 E.28545
G1 X134.217 Y121.119 E.18174
G1 X134.217 Y134.881 E.28545
G1 X142.919 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.345 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.388 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.388 Y120.71 E.28104
G1 F3600
G1 X143.345 Y120.71 E.00083
G1 X133.808 Y120.71 E.18383
G1 X133.808 Y135.29 E.28104
G1 X143.285 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.388 Y135.29 E-.03914
G1 X143.388 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.588 Y134.49 Z15.6 F60000
G1 Z15.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7182
M204 S4000
G1 X142.588 Y121.57 E.2259
M204 S10000
G1 X134.999 Y121.849 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7182
M204 S4000
G1 X134.999 Y123.546 E.0352
G1 X136.042 Y124.358 E.02742
G3 X136.476 Y125.269 I-.643 J.866 E.02178
G3 X134.999 Y127.63 I-2.887 J-.163 E.06029
G1 X134.999 Y130.829 E.06635
G1 X136.042 Y131.642 E.02742
G3 X136.476 Y132.552 I-.643 J.866 E.02178
G1 X136.284 Y133.462 E.0193
G3 X135.507 Y134.518 I-2.578 J-1.086 E.02745
G1 X140.092 Y134.518 E.09512
G2 X139.335 Y132.552 I-2.607 J-.124 E.04499
G1 X138.166 Y131.642 E.03072
G1 X137.812 Y131.186 E.01197
G3 X138.515 Y128.91 I2.503 J-.473 E.05141
G1 X139.683 Y128 E.03072
G1 X140.037 Y127.545 E.01197
G2 X139.335 Y125.269 I-2.503 J-.473 E.05141
G1 X138.166 Y124.358 E.03072
G3 X137.732 Y123.448 I.643 J-.866 E.02178
G1 X137.923 Y122.538 E.0193
G3 X138.701 Y121.482 I2.578 J1.085 E.02745
G1 X141.399 Y121.482 E.05595
G2 X142.197 Y123.489 I2.738 J.073 E.04604
G1 X142.197 Y127.697 E.08729
G2 X141.453 Y128.455 I1.13 J1.852 E.02226
G2 X142.197 Y130.772 I2.508 J.473 E.0526
G1 X142.197 Y132.469 E.0352
M204 S10000
G1 X134.608 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7182
M204 S4000
G1 X134.608 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.608 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.111 Y122.138 Z15.6 F60000
G1 X121.783 Y121.119 Z15.6
G1 Z15.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7182
M204 S4000
G1 X113.021 Y121.119 E.18174
G1 X113.021 Y134.881 E.28545
G1 X121.783 Y134.881 E.18174
G1 X121.783 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.192 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.655 Y120.71 E.18383
G1 X112.612 Y120.71 E.00083
G1 F3480
G1 X112.612 Y135.29 E.28104
G1 F3600
G1 X112.655 Y135.29 E.00083
G1 X122.192 Y135.29 E.18383
G1 X122.192 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.192 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.803 Y122.194 Z15.6 F60000
G1 Z15.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7182
M204 S4000
G1 X113.803 Y123.891 E.0352
G1 X114.192 Y124.358 E.01261
G3 X114.627 Y125.269 I-.643 J.866 E.02178
G3 X113.803 Y127.18 I-2.984 J-.153 E.04409
G1 X113.803 Y131.174 E.08285
G3 X114.547 Y132.097 I-13.565 J11.696 E.02458
G3 X113.844 Y134.373 I-2.503 J.474 E.05141
G2 X113.803 Y134.518 I.141 J.118 E.00322
G1 X118.243 Y134.518 E.0921
G2 X117.485 Y132.552 I-2.607 J-.124 E.04499
G1 X116.317 Y131.642 E.03072
G1 X115.963 Y131.186 E.01197
G3 X116.666 Y128.91 I2.503 J-.474 E.05141
G1 X117.834 Y128 E.03072
G1 X118.188 Y127.545 E.01197
G2 X117.485 Y125.269 I-2.503 J-.473 E.05141
G1 X116.317 Y124.358 E.03072
G3 X115.882 Y123.448 I.643 J-.866 E.02178
G1 X116.074 Y122.538 E.0193
G3 X116.852 Y121.482 I2.578 J1.086 E.02745
G1 X119.549 Y121.482 E.05595
G2 X121.001 Y123.989 I2.781 J.063 E.0632
G1 X121.001 Y127.188 E.06635
G1 X119.959 Y128 E.02741
G2 X119.524 Y128.91 I.643 J.866 E.02178
G2 X121.001 Y131.272 I2.887 J-.163 E.06028
G1 X121.001 Y132.969 E.0352
M204 S10000
G1 X121.392 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7182
M204 S4000
G1 X121.392 Y121.57 E.2259
M204 S10000
G1 X113.412 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7182
M204 S4000
G1 X113.412 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.412 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L127
M991 S0 P126 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.6 I-.434 J1.137 P1  F60000
G1 X143.063 Y134.881 Z15.6
G1 Z15.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7259
M204 S4000
G1 X143.063 Y121.119 E.28545
G1 X134.301 Y121.119 E.18174
G1 X134.301 Y134.881 E.28545
G1 X143.003 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.429 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.472 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.472 Y120.71 E.28104
G1 F3600
G1 X143.429 Y120.71 E.00083
G1 X133.892 Y120.71 E.18383
G1 X133.892 Y135.29 E.28104
G1 X143.369 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.472 Y135.29 E-.03914
G1 X143.472 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.672 Y134.49 Z15.72 F60000
G1 Z15.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7259
M204 S4000
G1 X142.672 Y121.57 E.2259
M204 S10000
G1 X135.083 Y121.867 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7259
M204 S4000
G1 X135.083 Y123.564 E.0352
G2 X136.285 Y124.358 I7.212 J-9.602 E.0299
G1 X136.598 Y124.814 E.01146
G3 X135.083 Y127.491 I-2.957 J.094 E.0671
G1 X135.083 Y130.847 E.06961
G2 X136.285 Y131.642 I7.215 J-9.606 E.0299
G1 X136.598 Y132.097 E.01145
G3 X135.442 Y134.518 I-2.87 J.117 E.0579
G1 X140.244 Y134.518 E.0996
G2 X139.7 Y133.007 I-4.106 J.626 E.03352
G2 X137.923 Y131.642 I-4.811 J4.421 E.04671
G1 X137.61 Y131.186 E.01145
G3 X138.15 Y129.366 I2.905 J-.13 E.04013
G3 X139.926 Y128 I4.811 J4.421 E.04671
M73 P78 R4
G1 X140.239 Y127.545 E.01145
G2 X139.7 Y125.724 I-2.905 J-.13 E.04013
G2 X137.923 Y124.358 I-4.811 J4.421 E.04671
G1 X137.61 Y123.903 E.01145
G3 X138.766 Y121.482 I2.87 J-.117 E.0579
G1 X141.247 Y121.482 E.05146
G2 X142.281 Y123.503 I2.967 J-.243 E.04831
G1 X142.281 Y127.551 E.08396
G1 X141.564 Y128 E.01754
G1 X141.252 Y128.455 E.01145
G2 X142.281 Y130.786 I2.918 J.104 E.05469
G1 X142.281 Y132.483 E.0352
M204 S10000
G1 X134.692 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7259
M204 S4000
G1 X134.692 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.692 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.192 Y122.155 Z15.72 F60000
G1 X121.699 Y121.119 Z15.72
G1 Z15.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7259
M204 S4000
G1 X112.937 Y121.119 E.18174
G1 X112.937 Y134.881 E.28545
G1 X121.699 Y134.881 E.18174
G1 X121.699 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.108 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.571 Y120.71 E.18383
G1 X112.528 Y120.71 E.00083
G1 F3480
G1 X112.528 Y135.29 E.28104
G1 F3600
G1 X112.571 Y135.29 E.00083
G1 X122.108 Y135.29 E.18383
G1 X122.108 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.108 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.719 Y122.212 Z15.72 F60000
G1 Z15.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7259
M204 S4000
G1 X113.719 Y123.909 E.0352
G1 X114.436 Y124.358 E.01754
G1 X114.748 Y124.814 E.01145
G3 X113.719 Y127.187 I-3.14 J.048 E.0553
G1 X113.719 Y131.192 E.08309
G1 X114.436 Y131.642 E.01754
G1 X114.748 Y132.097 E.01145
G3 X113.796 Y134.373 I-2.842 J.148 E.05293
G2 X113.719 Y134.518 I.053 J.121 E.00368
G1 X118.395 Y134.518 E.09699
G2 X117.85 Y133.007 I-4.106 J.626 E.03352
G2 X116.074 Y131.642 I-4.811 J4.421 E.04671
G1 X115.761 Y131.186 E.01145
G3 X116.3 Y129.366 I2.905 J-.13 E.04013
G3 X118.077 Y128 I4.811 J4.421 E.04671
G1 X118.39 Y127.545 E.01145
G2 X117.85 Y125.724 I-2.905 J-.129 E.04013
G2 X116.074 Y124.358 I-4.811 J4.421 E.04671
G1 X115.761 Y123.903 E.01145
G3 X116.916 Y121.482 I2.87 J-.117 E.0579
G1 X119.398 Y121.482 E.05146
G2 X120.917 Y123.849 I2.998 J-.253 E.06071
G1 X120.917 Y127.205 E.06961
G3 X119.715 Y128 I-7.212 J-9.603 E.0299
G1 X119.402 Y128.455 E.01145
G2 X120.917 Y131.133 I2.957 J.094 E.0671
G1 X120.917 Y132.83 E.0352
M204 S10000
G1 X121.308 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7259
M204 S4000
G1 X121.308 Y121.57 E.2259
M204 S10000
G1 X113.328 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7259
M204 S4000
G1 X113.328 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.328 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L128
M991 S0 P127 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.72 I-.432 J1.138 P1  F60000
G1 X143.147 Y134.881 Z15.72
G1 Z15.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7402
M204 S4000
G1 X143.147 Y121.119 E.28545
G1 X134.385 Y121.119 E.18174
G1 X134.385 Y134.881 E.28545
G1 X143.087 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.513 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.556 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.556 Y120.71 E.28104
G1 F3600
G1 X143.513 Y120.71 E.00083
G1 X133.976 Y120.71 E.18383
G1 X133.976 Y135.29 E.28104
G1 X143.453 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.556 Y135.29 E-.03914
G1 X143.556 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.756 Y134.49 Z15.84 F60000
G1 Z15.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7402
M204 S4000
G1 X142.756 Y121.57 E.2259
M204 S10000
G1 X135.167 Y121.87 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7402
M204 S4000
G1 X135.167 Y123.567 E.0352
G2 X136.696 Y124.358 I5.177 J-8.123 E.03576
G3 X136.751 Y125.269 I-.677 J.498 E.02
G3 X135.167 Y127.345 I-3.186 J-.788 E.05572
G1 X135.167 Y130.85 E.07269
G2 X136.696 Y131.642 I5.178 J-8.124 E.03576
G3 X136.751 Y132.552 I-.677 J.498 E.02
G3 X135.354 Y134.518 I-3.198 J-.793 E.05122
G1 X140.427 Y134.518 E.10523
G2 X139.242 Y132.552 I-3.431 J.728 E.04851
G2 X137.512 Y131.642 I-5.937 J9.182 E.0406
G1 X137.35 Y131.186 E.01002
G3 X138.608 Y128.91 I3.915 J.678 E.05495
G3 X140.337 Y128 I5.938 J9.184 E.0406
G1 X140.5 Y127.545 E.01002
G2 X139.242 Y125.269 I-3.915 J.678 E.05495
G2 X137.512 Y124.358 I-5.938 J9.184 E.0406
G3 X137.456 Y123.448 I.677 J-.498 E.02
G3 X138.854 Y121.482 I3.198 J.793 E.05122
G1 X141.064 Y121.482 E.04584
G2 X142.365 Y123.516 I3.337 J-.701 E.0512
G1 X142.365 Y127.395 E.08046
G3 X141.154 Y128 I-3.975 J-6.448 E.02812
G2 X141.098 Y128.91 I.677 J.498 E.02
G2 X142.365 Y130.799 I3.268 J-.823 E.04813
G1 X142.365 Y132.496 E.0352
M204 S10000
G1 X134.776 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7402
M204 S4000
G1 X134.776 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.776 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.273 Y122.173 Z15.84 F60000
G1 X121.615 Y121.119 Z15.84
G1 Z15.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7402
M204 S4000
G1 X112.853 Y121.119 E.18174
G1 X112.853 Y134.881 E.28545
G1 X121.615 Y134.881 E.18174
G1 X121.615 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X122.024 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.487 Y120.71 E.18383
G1 X112.444 Y120.71 E.00083
G1 F3480
G1 X112.444 Y135.29 E.28104
G1 F3600
G1 X112.487 Y135.29 E.00083
G1 X122.024 Y135.29 E.18383
G1 X122.024 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X120.024 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.635 Y121.953 Z15.84 F60000
G1 Z15.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7402
M204 S4000
G1 X113.635 Y123.65 E.0352
G1 X113.888 Y123.903 E.00744
G1 X114.847 Y124.358 E.022
G1 X115.009 Y124.814 E.01002
G3 X114.524 Y126.179 I-4.397 J-.792 E.03019
G3 X113.635 Y127.256 I-9.578 J-7.006 E.02898
G1 X113.635 Y130.933 E.07626
G1 X113.888 Y131.186 E.00744
G1 X114.847 Y131.642 E.022
G1 X115.009 Y132.097 E.01002
G3 X114.524 Y133.462 I-4.397 J-.791 E.03019
G3 X113.65 Y134.518 I-8.548 J-6.193 E.02845
G1 X118.578 Y134.518 E.10222
G2 X117.392 Y132.552 I-3.431 J.728 E.04851
G2 X115.663 Y131.642 I-5.938 J9.183 E.0406
G1 X115.5 Y131.186 E.01003
G3 X116.758 Y128.91 I3.915 J.679 E.05495
G3 X118.488 Y128 I5.938 J9.184 E.0406
G1 X118.65 Y127.545 E.01002
G2 X117.392 Y125.269 I-3.915 J.679 E.05495
G2 X115.663 Y124.358 I-5.939 J9.185 E.0406
G3 X115.607 Y123.448 I.677 J-.498 E.02
G3 X117.005 Y121.482 I3.198 J.793 E.05122
G1 X119.215 Y121.482 E.04584
G2 X120.833 Y123.704 I3.234 J-.656 E.0588
G1 X120.833 Y127.208 E.07269
G3 X119.304 Y128 I-5.178 J-8.124 E.03576
G2 X119.249 Y128.91 I.677 J.498 E.02
G2 X120.833 Y130.987 I3.186 J-.788 E.05572
G1 X120.833 Y132.684 E.0352
M204 S10000
G1 X121.224 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7402
M204 S4000
G1 X121.224 Y121.57 E.2259
M204 S10000
G1 X113.244 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7402
M204 S4000
G1 X113.244 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.56
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X113.244 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L129
M991 S0 P128 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.84 I-.429 J1.139 P1  F60000
G1 X143.231 Y134.881 Z15.84
G1 Z15.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7209
M204 S4000
G1 X143.231 Y121.119 E.28545
G1 X134.469 Y121.119 E.18174
G1 X134.469 Y134.881 E.28545
G1 X143.171 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.597 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.64 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.64 Y120.71 E.28104
G1 F3600
G1 X143.597 Y120.71 E.00083
G1 X134.06 Y120.71 E.18383
G1 X134.06 Y135.29 E.28104
G1 X143.537 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.64 Y135.29 E-.03914
G1 X143.64 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.84 Y134.49 Z15.96 F60000
G1 Z15.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7209
M204 S4000
G1 X142.84 Y121.57 E.2259
M204 S10000
G1 X142.449 Y125.23 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7209
M204 S4000
G1 X142.449 Y123.533 E.0352
G1 X142.111 Y123.318 E.00831
G3 X140.831 Y121.482 I4.369 J-4.409 E.04668
G1 X138.901 Y121.482 E.04003
G1 X138.469 Y121.757 E.01062
G2 X137.104 Y123.751 I4.66 J4.656 E.05041
G1 X136.649 Y124.002 E.01078
G3 X135.283 Y123.608 I.139 J-3.048 E.02975
G1 X135.251 Y127.262 E.07579
G2 X135.738 Y126.96 I-.462 J-1.291 E.01198
G2 X137.104 Y124.966 I-4.659 J-4.656 E.05041
G1 X137.559 Y124.715 E.01078
G3 X139.38 Y125.398 I-.582 J4.319 E.04068
G3 X140.745 Y127.392 I-4.66 J4.656 E.05041
G1 X141.201 Y127.643 E.01078
G2 X142.449 Y127.293 I-.107 J-2.781 E.02714
G1 X142.449 Y130.817 E.07308
G1 X142.111 Y130.602 E.00831
G3 X140.745 Y128.608 I4.659 J-4.656 E.05041
G1 X140.29 Y128.357 E.01078
G2 X138.469 Y129.04 I.582 J4.318 E.04068
G2 X137.104 Y131.034 I4.66 J4.656 E.05041
G1 X136.649 Y131.285 E.01078
G3 X135.283 Y130.891 I.139 J-3.048 E.02975
G1 X135.251 Y134.518 E.07523
G1 X135.738 Y134.243 E.0116
G2 X137.104 Y132.249 I-4.66 J-4.656 E.05041
G1 X137.559 Y131.998 E.01078
G3 X139.38 Y132.682 I-.582 J4.318 E.04068
G3 X140.683 Y134.518 I-4.868 J4.834 E.04691
G1 X142.38 Y134.518 E.0352
M204 S10000
G1 X134.86 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
M73 P79 R4
G1 F7209
M204 S4000
G1 X134.86 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.86 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.354 Y122.19 Z15.96 F60000
G1 X121.531 Y121.119 Z15.96
G1 Z15.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7209
M204 S4000
G1 X112.769 Y121.119 E.18174
G1 X112.769 Y134.881 E.28545
G1 X121.531 Y134.881 E.18174
G1 X121.531 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.94 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.403 Y120.71 E.18383
G1 X112.36 Y120.71 E.00083
G1 F3480
G1 X112.36 Y135.29 E.28104
G1 F3600
G1 X112.403 Y135.29 E.00083
G1 X121.94 Y135.29 E.18383
G1 X121.94 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.94 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.749 Y121.923 Z15.96 F60000
G1 Z15.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7209
M204 S4000
G1 X120.749 Y123.62 E.0352
G3 X119.351 Y122.16 I1.424 J-2.762 E.0427
G1 X118.982 Y121.482 E.01601
G1 X117.052 Y121.482 E.04003
G2 X115.71 Y122.916 I1.7 J2.937 E.04133
G1 X115.255 Y123.751 E.01973
G1 X114.799 Y124.002 E.01078
G3 X113.551 Y123.652 I.107 J-2.781 E.02714
G1 X113.551 Y127.175 E.07309
G2 X114.799 Y125.801 I-1.755 J-2.849 E.03901
G1 X115.255 Y124.966 E.01973
G1 X115.71 Y124.715 E.01078
G3 X117.531 Y125.398 I-.582 J4.319 E.04068
G3 X118.896 Y127.392 I-4.66 J4.656 E.05041
G1 X119.351 Y127.643 E.01078
G2 X120.749 Y127.229 I-.893 J-5.578 E.03032
G1 X120.749 Y130.903 E.07621
G3 X119.351 Y129.443 I1.424 J-2.762 E.0427
G1 X118.896 Y128.608 E.01973
G1 X118.441 Y128.357 E.01078
G2 X116.62 Y129.04 I.582 J4.318 E.04068
G2 X115.255 Y131.034 I4.659 J4.656 E.05041
G1 X114.799 Y131.285 E.01078
G3 X113.551 Y130.935 I.107 J-2.781 E.02714
G1 X113.551 Y134.458 E.07309
G2 X114.799 Y133.085 I-1.755 J-2.849 E.03901
G1 X115.255 Y132.249 E.01973
G1 X115.71 Y131.998 E.01078
G3 X117.531 Y132.682 I-.582 J4.318 E.04068
G3 X118.833 Y134.518 I-4.868 J4.834 E.04691
G1 X120.53 Y134.518 E.0352
M204 S10000
G1 X121.14 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7209
M204 S4000
G1 X121.14 Y121.57 E.2259
M204 S10000
G1 X113.16 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7209
M204 S4000
G1 X113.16 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.16 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L130
M991 S0 P129 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z15.96 I-.427 J1.139 P1  F60000
G1 X143.315 Y134.881 Z15.96
G1 Z15.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7117
M204 S4000
G1 X143.315 Y121.119 E.28545
G1 X134.553 Y121.119 E.18174
G1 X134.553 Y134.881 E.28545
G1 X143.255 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.681 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.724 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.724 Y120.71 E.28104
G1 F3600
G1 X143.681 Y120.71 E.00083
G1 X134.144 Y120.71 E.18383
G1 X134.144 Y135.29 E.28104
G1 X143.621 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.724 Y135.29 E-.03914
G1 X143.724 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.924 Y134.49 Z16.08 F60000
G1 Z15.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7117
M204 S4000
G1 X142.924 Y121.57 E.2259
M204 S10000
G1 X142.533 Y121.847 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7117
M204 S4000
G1 X142.533 Y123.544 E.0352
G3 X141.656 Y122.918 I1.064 J-2.418 E.02251
G1 X140.745 Y121.641 E.03254
G1 X140.529 Y121.482 E.00556
G1 X139.039 Y121.482 E.03091
G2 X138.014 Y122.157 I1.002 J2.637 E.02566
G1 X137.104 Y123.435 E.03254
G1 X136.649 Y123.768 E.01171
G1 X136.193 Y123.807 E.00948
G1 X135.335 Y123.577 E.01844
G1 X135.335 Y127.175 E.07465
G2 X136.193 Y126.56 I-1.049 J-2.369 E.02207
G1 X137.104 Y125.282 E.03254
G1 X137.559 Y124.949 E.01171
G1 X138.014 Y124.91 E.00948
G3 X139.835 Y125.799 I-.37 J3.066 E.04282
G1 X140.745 Y127.076 E.03254
G1 X141.201 Y127.41 E.01171
G1 X141.656 Y127.449 E.00948
G1 X142.533 Y127.213 E.01884
G1 X142.533 Y130.827 E.07497
G3 X141.656 Y130.201 I1.064 J-2.418 E.02251
G1 X140.745 Y128.924 E.03254
G1 X140.29 Y128.59 E.01171
G1 X139.835 Y128.551 E.00948
G2 X138.014 Y129.44 I.37 J3.066 E.04282
G1 X137.104 Y130.718 E.03254
G1 X136.649 Y131.052 E.01171
G1 X136.193 Y131.09 E.00948
G1 X135.335 Y130.86 E.01844
G1 X135.335 Y134.459 E.07465
G2 X136.193 Y133.843 I-1.049 J-2.369 E.02207
G1 X137.104 Y132.565 E.03254
G1 X137.559 Y132.232 E.01171
G1 X138.014 Y132.193 E.00948
G3 X139.835 Y133.082 I-.37 J3.066 E.04282
G1 X140.745 Y134.359 E.03254
G1 X141.015 Y134.518 E.00649
G1 X139.318 Y134.518 E.0352
M204 S10000
G1 X134.944 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7117
M204 S4000
G1 X134.944 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X134.944 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.435 Y122.207 Z16.08 F60000
G1 X121.447 Y121.119 Z16.08
G1 Z15.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7117
M204 S4000
G1 X112.685 Y121.119 E.18174
G1 X112.685 Y134.881 E.28545
G1 X121.447 Y134.881 E.18174
G1 X121.447 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.856 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.319 Y120.71 E.18383
G1 X112.276 Y120.71 E.00083
G1 F3480
G1 X112.276 Y135.29 E.28104
G1 F3600
G1 X112.319 Y135.29 E.00083
G1 X121.856 Y135.29 E.18383
G1 X121.856 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.856 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.665 Y121.837 Z16.08 F60000
G1 Z15.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7117
M204 S4000
G1 X120.665 Y123.534 E.0352
G3 X119.807 Y122.918 I1.048 J-2.368 E.02207
G1 X118.896 Y121.641 E.03254
G1 X118.68 Y121.482 E.00556
G1 X117.19 Y121.482 E.03091
G2 X116.165 Y122.157 I1.003 J2.637 E.02566
G1 X115.255 Y123.435 E.03254
G1 X114.799 Y123.768 E.01171
G1 X114.344 Y123.807 E.00948
G1 X113.467 Y123.571 E.01884
G1 X113.467 Y127.186 E.07497
G2 X114.344 Y126.56 I-1.064 J-2.419 E.02251
G1 X115.255 Y125.282 E.03254
G1 X115.71 Y124.949 E.01171
G3 X117.986 Y125.799 I.29 J2.694 E.05226
G1 X118.896 Y127.076 E.03254
G1 X119.351 Y127.41 E.01171
G1 X119.807 Y127.449 E.00948
G1 X120.665 Y127.218 E.01844
G1 X120.665 Y130.817 E.07465
G3 X119.807 Y130.201 I1.048 J-2.368 E.02207
G1 X118.896 Y128.924 E.03254
G1 X118.441 Y128.59 E.01171
G2 X116.165 Y129.44 I-.29 J2.695 E.05226
G1 X115.255 Y130.718 E.03254
G1 X114.799 Y131.052 E.01171
G1 X114.344 Y131.09 E.00948
G1 X113.467 Y130.855 E.01884
G1 X113.467 Y134.469 E.07497
G2 X114.344 Y133.843 I-1.064 J-2.419 E.02251
G1 X115.255 Y132.565 E.03254
G1 X115.71 Y132.232 E.01171
G3 X117.986 Y133.082 I.29 J2.694 E.05226
G1 X118.896 Y134.359 E.03254
G1 X119.166 Y134.518 E.00649
G1 X117.469 Y134.518 E.0352
M204 S10000
G1 X121.056 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7117
M204 S4000
G1 X121.056 Y121.57 E.2259
M204 S10000
G1 X113.076 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7117
M204 S4000
G1 X113.076 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X113.076 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L131
M991 S0 P130 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.08 I-.425 J1.14 P1  F60000
G1 X143.399 Y134.881 Z16.08
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7059
M204 S4000
G1 X143.399 Y121.119 E.28545
G1 X134.637 Y121.119 E.18174
G1 X134.637 Y134.881 E.28545
G1 X143.339 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.765 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.808 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.808 Y120.71 E.28104
G1 F3600
G1 X143.765 Y120.71 E.00083
G1 X134.228 Y120.71 E.18383
G1 X134.228 Y135.29 E.28104
G1 X143.705 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.808 Y135.29 E-.03914
G1 X143.808 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.008 Y134.49 Z16.2 F60000
G1 Z15.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7059
M204 S4000
G1 X143.008 Y121.57 E.2259
M204 S10000
G1 X142.617 Y121.842 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7059
M204 S4000
G1 X142.617 Y123.539 E.0352
G3 X141.656 Y122.967 I1.165 J-3.047 E.02332
G1 X140.745 Y121.856 E.02979
G1 X140.29 Y121.493 E.01208
G1 X139.173 Y121.482 E.02318
G2 X138.014 Y122.109 I.753 J2.778 E.02757
G1 X137.104 Y123.219 E.02979
G3 X135.738 Y123.65 I-1.057 J-.971 E.03109
G1 X135.419 Y123.563 E.00686
G1 X135.419 Y127.103 E.07343
G2 X136.193 Y126.608 I-.805 J-2.115 E.0192
G1 X137.104 Y125.498 E.02979
G3 X138.469 Y125.067 I1.057 J.971 E.03109
G3 X139.835 Y125.75 I-.618 J2.942 E.03202
G1 X140.745 Y126.861 E.02979
G2 X142.111 Y127.291 I1.057 J-.971 E.03109
G2 X142.617 Y127.143 I-.164 J-1.497 E.01099
G1 X142.617 Y130.823 E.07632
G3 X141.656 Y130.25 I1.165 J-3.048 E.02332
G1 X140.745 Y129.139 E.02979
G2 X139.38 Y128.709 I-1.057 J.971 E.03109
G2 X138.014 Y129.392 I.618 J2.942 E.03202
G1 X137.104 Y130.502 E.02979
G3 X135.738 Y130.933 I-1.057 J-.971 E.03109
G1 X135.419 Y130.846 E.00686
G1 X135.419 Y134.386 E.07343
G2 X136.193 Y133.891 I-.805 J-2.114 E.0192
G1 X137.104 Y132.781 E.02979
G3 X138.469 Y132.35 I1.057 J.971 E.03109
G3 X139.835 Y133.033 I-.618 J2.942 E.03202
G1 X140.745 Y134.144 E.02979
G1 X141.249 Y134.518 E.01301
G1 X139.552 Y134.518 E.0352
M204 S10000
G1 X135.028 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7059
M204 S4000
G1 X135.028 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.028 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.516 Y122.223 Z16.2 F60000
G1 X121.363 Y121.119 Z16.2
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7059
M204 S4000
G1 X112.601 Y121.119 E.18174
G1 X112.601 Y134.881 E.28545
G1 X121.363 Y134.881 E.18174
G1 X121.363 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.772 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.235 Y120.71 E.18383
G1 X112.192 Y120.71 E.00083
M73 P80 R4
G1 F3480
G1 X112.192 Y135.29 E.28104
G1 F3600
G1 X112.235 Y135.29 E.00083
G1 X121.772 Y135.29 E.18383
G1 X121.772 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.772 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.581 Y121.764 Z16.2 F60000
G1 Z15.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7059
M204 S4000
G1 X120.581 Y123.461 E.0352
G3 X119.807 Y122.967 I.805 J-2.114 E.01919
G1 X118.896 Y121.856 E.02979
G1 X118.393 Y121.482 E.01301
G2 X116.165 Y122.109 I-.452 J2.667 E.0496
G1 X115.255 Y123.219 E.02979
G1 X114.799 Y123.582 E.01208
G3 X113.383 Y123.502 I-.613 J-1.714 E.03023
G1 X113.383 Y127.181 E.07632
G2 X114.344 Y126.608 I-1.165 J-3.047 E.02333
G1 X115.255 Y125.498 E.02979
G1 X115.71 Y125.135 E.01208
G3 X117.986 Y125.75 I.58 J2.37 E.05104
G1 X118.896 Y126.861 E.02979
G1 X119.351 Y127.224 E.01208
G2 X120.581 Y127.204 I.584 J-1.908 E.02593
G1 X120.581 Y130.744 E.07343
G3 X119.807 Y130.25 I.805 J-2.114 E.01919
G1 X118.896 Y129.139 E.02979
G1 X118.441 Y128.776 E.01208
G2 X116.165 Y129.392 I-.58 J2.37 E.05104
G1 X115.255 Y130.502 E.02979
G1 X114.799 Y130.865 E.01208
G3 X113.383 Y130.785 I-.613 J-1.714 E.03023
G1 X113.383 Y134.464 E.07632
G2 X114.344 Y133.891 I-1.165 J-3.047 E.02333
G1 X115.255 Y132.781 E.02979
G1 X115.71 Y132.418 E.01208
G3 X117.986 Y133.033 I.58 J2.37 E.05104
G1 X118.896 Y134.144 E.02979
G1 X119.399 Y134.518 E.01301
G1 X117.703 Y134.518 E.0352
M204 S10000
G1 X120.972 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7059
M204 S4000
G1 X120.972 Y121.57 E.2259
M204 S10000
G1 X112.992 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7059
M204 S4000
G1 X112.992 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 15.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X112.992 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L132
M991 S0 P131 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.2 I-.423 J1.141 P1  F60000
G1 X143.483 Y134.881 Z16.2
G1 Z15.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7102
M204 S4000
G1 X143.483 Y121.119 E.28545
G1 X134.721 Y121.119 E.18174
G1 X134.721 Y134.881 E.28545
G1 X143.423 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.849 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.892 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.892 Y120.71 E.28104
G1 F3600
G1 X143.849 Y120.71 E.00083
G1 X134.312 Y120.71 E.18383
G1 X134.312 Y135.29 E.28104
G1 X143.789 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.892 Y135.29 E-.03914
G1 X143.892 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.092 Y134.49 Z16.32 F60000
G1 Z15.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7102
M204 S4000
G1 X143.092 Y121.57 E.2259
M204 S10000
G1 X142.701 Y121.825 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7102
M204 S4000
G1 X142.701 Y123.522 E.0352
G3 X141.656 Y123.018 I.67 J-2.721 E.02425
G2 X140.29 Y121.649 I-5.736 J4.359 E.04022
G2 X138.014 Y122.058 I-.79 J2.143 E.05029
G3 X136.649 Y123.426 I-5.736 J-4.359 E.04022
G3 X135.503 Y123.539 I-.747 J-1.715 E.02427
G1 X135.503 Y127.051 E.07286
G2 X136.193 Y126.659 I-.593 J-1.849 E.01659
G3 X137.559 Y125.291 I5.735 J4.359 E.04022
G3 X139.835 Y125.699 I.79 J2.143 E.05029
G2 X141.201 Y127.068 I5.735 J-4.359 E.04022
G2 X142.701 Y127.085 I.769 J-1.639 E.03209
G1 X142.701 Y130.806 E.07718
G3 X141.656 Y130.301 I.67 J-2.721 E.02425
G2 X140.29 Y128.933 I-5.735 J4.359 E.04022
G2 X138.014 Y129.341 I-.79 J2.143 E.05029
G3 X136.649 Y130.709 I-5.736 J-4.359 E.04022
G3 X135.503 Y130.822 I-.747 J-1.715 E.02427
G1 X135.503 Y134.334 E.07286
G2 X136.193 Y133.942 I-.593 J-1.849 E.01659
G3 X137.559 Y132.574 I5.736 J4.359 E.04022
G3 X139.835 Y132.982 I.79 J2.143 E.05029
G2 X141.201 Y134.351 I5.736 J-4.359 E.04022
G2 X142.701 Y134.368 I.769 J-1.639 E.03209
G1 X142.701 Y132.671 E.0352
M204 S10000
G1 X135.112 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7102
M204 S4000
G1 X135.112 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.112 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.597 Y122.239 Z16.32 F60000
G1 X121.279 Y121.119 Z16.32
G1 Z15.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7102
M204 S4000
G1 X112.517 Y121.119 E.18174
G1 X112.517 Y134.881 E.28545
G1 X121.279 Y134.881 E.18174
G1 X121.279 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.688 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.151 Y120.71 E.18383
G1 X112.108 Y120.71 E.00083
G1 F3480
G1 X112.108 Y135.29 E.28104
G1 F3600
G1 X112.151 Y135.29 E.00083
G1 X121.688 Y135.29 E.18383
G1 X121.688 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.688 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.497 Y125.107 Z16.32 F60000
G1 Z15.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7102
M204 S4000
G1 X120.497 Y123.41 E.0352
G3 X119.807 Y123.018 I.593 J-1.849 E.01658
G2 X118.441 Y121.649 I-5.736 J4.359 E.04022
G2 X116.165 Y122.058 I-.79 J2.143 E.05029
G1 X115.255 Y123.048 E.0279
G3 X113.299 Y123.443 I-1.264 J-1.219 E.04401
G1 X113.299 Y127.164 E.07718
G2 X114.344 Y126.659 I-.67 J-2.721 E.02425
G3 X115.71 Y125.291 I5.735 J4.358 E.04022
G3 X117.986 Y125.699 I.79 J2.143 E.05029
G1 X118.896 Y126.69 E.0279
G2 X120.497 Y127.18 I1.188 J-1.018 E.03665
G1 X120.497 Y130.693 E.07285
G3 X119.807 Y130.301 I.593 J-1.849 E.01658
G2 X118.441 Y128.933 I-5.735 J4.359 E.04022
G2 X116.165 Y129.341 I-.79 J2.143 E.05029
G1 X115.255 Y130.331 E.0279
G3 X113.299 Y130.726 I-1.264 J-1.219 E.04401
G1 X113.299 Y134.447 E.07718
G2 X114.344 Y133.942 I-.67 J-2.721 E.02425
G3 X115.71 Y132.574 I5.736 J4.359 E.04022
G3 X117.986 Y132.982 I.79 J2.143 E.05029
G1 X118.896 Y133.973 E.0279
G2 X120.497 Y134.464 I1.188 J-1.018 E.03665
G1 X120.497 Y132.767 E.0352
M204 S10000
G1 X120.888 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7102
M204 S4000
G1 X120.888 Y121.57 E.2259
M204 S10000
G1 X112.908 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7102
M204 S4000
G1 X112.908 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.04
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X112.908 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L133
M991 S0 P132 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.32 I-.421 J1.142 P1  F60000
G1 X143.567 Y134.881 Z16.32
G1 Z16.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7064
M204 S4000
G1 X143.567 Y121.119 E.28545
G1 X134.805 Y121.119 E.18174
G1 X134.805 Y134.881 E.28545
G1 X143.507 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X143.933 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X143.976 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X143.976 Y120.71 E.28104
G1 F3600
G1 X143.933 Y120.71 E.00083
G1 X134.396 Y120.71 E.18383
G1 X134.396 Y135.29 E.28104
G1 X143.873 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X143.976 Y135.29 E-.03914
G1 X143.976 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.176 Y134.49 Z16.44 F60000
G1 Z16.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7064
M204 S4000
G1 X143.176 Y121.57 E.2259
M204 S10000
G1 X142.785 Y121.803 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7064
M204 S4000
G1 X142.785 Y123.5 E.0352
G3 X141.201 Y122.669 I.304 J-2.505 E.03794
G2 X139.835 Y121.595 I-2.575 J1.869 E.0365
G2 X137.559 Y122.407 I-.402 J2.47 E.05231
G3 X136.193 Y123.481 I-2.575 J-1.869 E.0365
G3 X135.587 Y123.51 I-.369 J-1.36 E.01269
G1 X135.587 Y127.02 E.07281
G2 X137.104 Y125.816 I-1.724 J-3.729 E.04055
G3 X139.38 Y125.387 I1.427 J1.319 E.05147
G3 X140.745 Y126.543 I-2.133 J3.904 E.03737
G2 X142.785 Y127.047 I1.391 J-1.251 E.04627
G1 X142.785 Y130.783 E.0775
G3 X141.201 Y129.952 I.304 J-2.505 E.03794
G2 X139.835 Y128.878 I-2.575 J1.869 E.0365
G2 X137.559 Y129.69 I-.402 J2.47 E.05231
G3 X136.193 Y130.764 I-2.575 J-1.87 E.0365
G3 X135.587 Y130.793 I-.369 J-1.36 E.01269
G1 X135.587 Y134.303 E.07281
G2 X137.104 Y133.099 I-1.723 J-3.729 E.04055
G3 X139.38 Y132.67 I1.427 J1.319 E.05147
G3 X140.745 Y133.826 I-2.133 J3.904 E.03737
G2 X142.785 Y134.33 I1.391 J-1.252 E.04627
G1 X142.785 Y132.633 E.0352
M204 S10000
G1 X135.196 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7064
M204 S4000
G1 X135.196 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.196 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.678 Y122.254 Z16.44 F60000
G1 X121.195 Y121.119 Z16.44
G1 Z16.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7064
M204 S4000
G1 X112.433 Y121.119 E.18174
G1 X112.433 Y134.881 E.28545
G1 X121.195 Y134.881 E.18174
G1 X121.195 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.604 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X112.067 Y120.71 E.18383
G1 X112.024 Y120.71 E.00083
G1 F3480
G1 X112.024 Y135.29 E.28104
G1 F3600
G1 X112.067 Y135.29 E.00083
G1 X121.604 Y135.29 E.18383
G1 X121.604 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.604 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.413 Y125.075 Z16.44 F60000
G1 Z16.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P81 R4
G1 F7064
M204 S4000
G1 X120.413 Y123.378 E.0352
G3 X118.896 Y122.174 I1.724 J-3.729 E.04055
G2 X117.075 Y121.601 I-1.383 J1.216 E.04162
G2 X115.255 Y122.901 I1.238 J3.658 E.04709
G3 X113.215 Y123.405 I-1.391 J-1.251 E.04627
G1 X113.215 Y127.141 E.0775
G1 X113.434 Y127.116 E.00457
G2 X115.255 Y125.816 I-1.238 J-3.658 E.04709
G3 X117.075 Y125.242 I1.383 J1.216 E.04162
G3 X118.896 Y126.543 I-1.238 J3.658 E.04709
G2 X120.413 Y127.151 I1.312 J-1.077 E.03536
G1 X120.413 Y130.661 E.0728
G3 X118.896 Y129.457 I1.724 J-3.729 E.04055
G2 X117.075 Y128.884 I-1.383 J1.216 E.04162
G2 X115.255 Y130.185 I1.238 J3.658 E.04709
G3 X113.215 Y130.688 I-1.391 J-1.251 E.04627
G1 X113.215 Y134.424 E.0775
G1 X113.434 Y134.399 E.00457
G2 X115.255 Y133.099 I-1.238 J-3.658 E.04709
G3 X117.075 Y132.526 I1.383 J1.216 E.04162
G3 X118.896 Y133.826 I-1.238 J3.658 E.04709
G2 X120.413 Y134.434 I1.312 J-1.077 E.03536
G1 X120.413 Y132.737 E.0352
M204 S10000
G1 X120.804 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7064
M204 S4000
G1 X120.804 Y121.57 E.2259
M204 S10000
G1 X112.824 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7064
M204 S4000
G1 X112.824 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.16
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X112.824 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L134
M991 S0 P133 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.44 I-.419 J1.142 P1  F60000
G1 X143.651 Y134.881 Z16.44
G1 Z16.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7034
M204 S4000
G1 X143.651 Y121.119 E.28545
G1 X134.889 Y121.119 E.18174
M73 P81 R3
G1 X134.889 Y134.881 E.28545
G1 X143.591 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.017 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.06 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.06 Y120.71 E.28104
G1 F3600
G1 X144.017 Y120.71 E.00083
G1 X134.48 Y120.71 E.18383
G1 X134.48 Y135.29 E.28104
G1 X143.957 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.06 Y135.29 E-.03914
G1 X144.06 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.26 Y134.49 Z16.56 F60000
G1 Z16.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7034
M204 S4000
G1 X143.26 Y121.57 E.2259
M204 S10000
G1 X142.869 Y121.774 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7034
M204 S4000
G1 X142.869 Y123.471 E.0352
G3 X140.745 Y122.306 I.127 J-2.749 E.05203
G2 X137.559 Y122.305 I-1.594 J1.466 E.07427
G3 X136.193 Y123.394 I-3.192 J-2.604 E.0365
G3 X135.671 Y123.475 I-.441 J-1.118 E.01106
G1 X135.671 Y127.007 E.07327
G2 X137.104 Y125.948 I-1.379 J-3.364 E.03734
G3 X140.29 Y125.947 I1.594 J1.466 E.07427
G2 X141.656 Y127.035 I3.192 J-2.604 E.0365
G2 X142.869 Y127.028 I.592 J-2.261 E.02546
G1 X142.869 Y130.755 E.0773
G3 X140.745 Y129.589 I.127 J-2.749 E.05203
G2 X137.559 Y129.589 I-1.594 J1.466 E.07427
G3 X136.193 Y130.677 I-3.192 J-2.604 E.0365
G3 X135.671 Y130.758 I-.441 J-1.118 E.01106
G1 X135.671 Y134.29 E.07327
G2 X137.104 Y133.231 I-1.379 J-3.364 E.03734
G3 X140.29 Y133.23 I1.594 J1.466 E.07427
G2 X141.656 Y134.319 I3.192 J-2.604 E.0365
G2 X142.869 Y134.311 I.592 J-2.261 E.02546
G1 X142.869 Y132.614 E.0352
M204 S10000
G1 X135.28 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7034
M204 S4000
G1 X135.28 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.28 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.759 Y122.269 Z16.56 F60000
G1 X121.111 Y121.119 Z16.56
G1 Z16.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7034
M204 S4000
G1 X112.349 Y121.119 E.18174
G1 X112.349 Y134.881 E.28545
G1 X121.111 Y134.881 E.18174
G1 X121.111 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.52 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.983 Y120.71 E.18383
G1 X111.94 Y120.71 E.00083
G1 F3480
G1 X111.94 Y135.29 E.28104
G1 F3600
G1 X111.983 Y135.29 E.00083
G1 X121.52 Y135.29 E.18383
G1 X121.52 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.52 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.329 Y121.669 Z16.56 F60000
G1 Z16.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7034
M204 S4000
G1 X120.329 Y123.366 E.0352
G3 X118.896 Y122.306 I1.38 J-3.364 E.03734
G2 X117.531 Y121.598 I-1.616 J1.445 E.03262
G2 X115.255 Y122.769 I-.015 J2.768 E.0552
G3 X113.131 Y123.386 I-1.532 J-1.312 E.04855
G1 X113.131 Y127.113 E.0773
G2 X115.255 Y125.948 I-.127 J-2.749 E.05203
G3 X116.62 Y125.239 I1.616 J1.445 E.03262
G3 X118.896 Y126.411 I.015 J2.768 E.0552
G2 X120.329 Y127.116 I1.517 J-1.274 E.0341
G1 X120.329 Y130.649 E.07327
G3 X118.896 Y129.589 I1.379 J-3.364 E.03734
G2 X117.531 Y128.881 I-1.616 J1.445 E.03262
G2 X115.255 Y130.052 I-.015 J2.768 E.0552
G3 X113.131 Y130.669 I-1.532 J-1.312 E.04855
G1 X113.131 Y134.396 E.0773
G2 X115.255 Y133.231 I-.127 J-2.749 E.05203
G3 X116.62 Y132.523 I1.616 J1.445 E.03262
G3 X118.896 Y133.694 I.015 J2.768 E.0552
G2 X120.329 Y134.4 I1.517 J-1.274 E.0341
G1 X120.329 Y132.703 E.0352
M204 S10000
G1 X120.72 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7034
M204 S4000
G1 X120.72 Y121.57 E.2259
M204 S10000
G1 X112.74 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7034
M204 S4000
G1 X112.74 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.28
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X112.74 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L135
M991 S0 P134 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.56 I-.417 J1.143 P1  F60000
G1 X143.735 Y134.881 Z16.56
G1 Z16.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7023
M204 S4000
G1 X143.735 Y121.119 E.28545
G1 X134.973 Y121.119 E.18174
G1 X134.973 Y134.881 E.28545
G1 X143.675 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.101 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.144 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.144 Y120.71 E.28104
G1 F3600
G1 X144.101 Y120.71 E.00083
G1 X134.564 Y120.71 E.18383
G1 X134.564 Y135.29 E.28104
G1 X144.041 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.144 Y135.29 E-.03914
G1 X144.144 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.344 Y134.49 Z16.68 F60000
G1 Z16.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7023
M204 S4000
G1 X143.344 Y121.57 E.2259
M204 S10000
G1 X142.953 Y121.74 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7023
M204 S4000
G1 X142.953 Y123.437 E.0352
G3 X140.745 Y122.43 I-.182 J-2.524 E.05249
G2 X137.559 Y122.205 I-1.701 J1.407 E.07408
G3 X136.193 Y123.315 I-4.136 J-3.691 E.03666
G1 X135.755 Y123.43 E.0094
G1 X135.755 Y127.009 E.07424
G2 X137.104 Y126.072 I-1.137 J-3.075 E.03444
G3 X140.29 Y125.847 I1.701 J1.407 E.07408
G2 X141.656 Y126.957 I4.135 J-3.691 E.03666
G2 X142.953 Y127.028 I.773 J-2.252 E.02729
G1 X142.953 Y130.72 E.0766
G3 X140.745 Y129.713 I-.182 J-2.524 E.05249
G2 X137.559 Y129.488 I-1.701 J1.407 E.07408
G3 X136.193 Y130.599 I-4.135 J-3.691 E.03666
G1 X135.755 Y130.714 E.0094
G1 X135.755 Y134.293 E.07424
G2 X137.104 Y133.355 I-1.137 J-3.075 E.03444
G3 X140.29 Y133.13 I1.701 J1.407 E.07408
G2 X141.656 Y134.24 I4.135 J-3.691 E.03666
G2 X142.953 Y134.311 I.773 J-2.252 E.02729
G1 X142.953 Y132.614 E.0352
M204 S10000
G1 X135.364 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7023
M204 S4000
G1 X135.364 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.364 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.841 Y122.284 Z16.68 F60000
G1 X121.027 Y121.119 Z16.68
G1 Z16.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7023
M204 S4000
G1 X112.265 Y121.119 E.18174
G1 X112.265 Y134.881 E.28545
G1 X121.027 Y134.881 E.18174
G1 X121.027 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.436 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.899 Y120.71 E.18383
G1 X111.856 Y120.71 E.00083
G1 F3480
G1 X111.856 Y135.29 E.28104
G1 F3600
G1 X111.899 Y135.29 E.00083
G1 X121.436 Y135.29 E.18383
G1 X121.436 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.436 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.245 Y121.671 Z16.68 F60000
G1 Z16.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7023
M204 S4000
G1 X120.245 Y123.368 E.0352
G3 X119.351 Y122.87 I.605 J-2.139 E.02141
G2 X117.986 Y121.76 I-4.136 J3.692 E.03666
G2 X115.255 Y122.645 I-.757 J2.321 E.06366
G3 X113.047 Y123.386 I-1.694 J-1.39 E.05092
G1 X113.047 Y127.079 E.0766
G2 X114.799 Y126.512 I.254 J-2.207 E.03939
G3 X116.165 Y125.402 I4.135 J3.691 E.03666
G3 X118.896 Y126.287 I.757 J2.321 E.06366
G2 X120.245 Y127.072 I1.871 J-1.663 E.03292
G1 X120.245 Y130.651 E.07424
G3 X119.351 Y130.153 I.605 J-2.138 E.02141
G2 X117.986 Y129.043 I-4.136 J3.692 E.03666
G2 X115.255 Y129.928 I-.757 J2.321 E.06366
G3 X113.047 Y130.669 I-1.694 J-1.39 E.05092
G1 X113.047 Y134.362 E.0766
G2 X114.799 Y133.795 I.254 J-2.207 E.03939
G3 X116.165 Y132.685 I4.135 J3.691 E.03666
G3 X118.896 Y133.57 I.757 J2.321 E.06366
G2 X120.245 Y134.355 I1.871 J-1.663 E.03292
G1 X120.245 Y134.518 E.00338
G1 X118.711 Y134.518 E.03182
M204 S10000
G1 X120.636 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7023
M204 S4000
G1 X120.636 Y121.57 E.2259
M204 S10000
G1 X112.656 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7023
M204 S4000
G1 X112.656 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X112.656 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L136
M991 S0 P135 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.68 I-.415 J1.144 P1  F60000
G1 X143.819 Y134.881 Z16.68
M73 P82 R3
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7046
M204 S4000
G1 X143.819 Y121.119 E.28545
G1 X135.057 Y121.119 E.18174
G1 X135.057 Y134.881 E.28545
G1 X143.759 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.185 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.228 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.228 Y120.71 E.28104
G1 F3600
G1 X144.185 Y120.71 E.00083
G1 X134.648 Y120.71 E.18383
G1 X134.648 Y135.29 E.28104
G1 X144.125 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.228 Y135.29 E-.03914
G1 X144.228 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.428 Y134.49 Z16.8 F60000
G1 Z16.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7046
M204 S4000
G1 X143.428 Y121.57 E.2259
M204 S10000
G1 X135.839 Y121.667 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7046
M204 S4000
G1 X135.839 Y123.364 E.0352
G2 X137.104 Y122.525 I-.903 J-2.733 E.03187
G3 X140.745 Y122.551 I1.811 J1.408 E.08726
G2 X143.037 Y123.393 I1.812 J-1.391 E.05343
G1 X143.037 Y127.042 E.07569
G3 X140.745 Y126.166 I-.439 J-2.286 E.0536
G2 X137.104 Y126.192 I-1.811 J1.408 E.08726
G3 X135.839 Y127.015 I-2.094 J-1.835 E.03169
G1 X135.839 Y130.647 E.07535
G2 X137.104 Y129.808 I-.903 J-2.733 E.03187
G3 X140.745 Y129.834 I1.811 J1.408 E.08726
G2 X143.037 Y130.676 I1.812 J-1.391 E.05343
G1 X143.037 Y134.326 E.07569
G3 X140.745 Y133.449 I-.439 J-2.286 E.0536
G2 X137.104 Y133.475 I-1.811 J1.408 E.08726
G3 X135.839 Y134.298 I-2.094 J-1.836 E.03169
G1 X135.839 Y134.518 E.00456
G1 X137.316 Y134.518 E.03064
M204 S10000
G1 X135.448 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7046
M204 S4000
G1 X135.448 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.448 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.922 Y122.299 Z16.8 F60000
G1 X120.943 Y121.119 Z16.8
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7046
M204 S4000
G1 X112.181 Y121.119 E.18174
G1 X112.181 Y134.881 E.28545
G1 X120.943 Y134.881 E.18174
G1 X120.943 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.352 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.815 Y120.71 E.18383
G1 X111.772 Y120.71 E.00083
G1 F3480
G1 X111.772 Y135.29 E.28104
G1 F3600
G1 X111.815 Y135.29 E.00083
G1 X121.352 Y135.29 E.18383
G1 X121.352 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.352 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.963 Y121.704 Z16.8 F60000
G1 Z16.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7046
M204 S4000
G1 X112.963 Y123.401 E.0352
G2 X115.255 Y122.525 I.439 J-2.286 E.0536
G3 X118.896 Y122.551 I1.811 J1.408 E.08726
G2 X120.161 Y123.373 I2.094 J-1.835 E.03169
G1 X120.161 Y127.006 E.07535
G3 X118.896 Y126.166 I.903 J-2.733 E.03187
G2 X115.255 Y126.192 I-1.811 J1.408 E.08726
G3 X112.963 Y127.035 I-1.812 J-1.391 E.05343
G1 X112.963 Y130.684 E.07569
G2 X115.255 Y129.808 I.439 J-2.286 E.0536
G3 X118.896 Y129.834 I1.811 J1.408 E.08726
G2 X120.161 Y130.656 I2.094 J-1.835 E.03169
G1 X120.161 Y134.289 E.07535
G3 X118.896 Y133.449 I.903 J-2.733 E.03187
G2 X115.255 Y133.475 I-1.811 J1.408 E.08726
G3 X112.963 Y134.318 I-1.812 J-1.391 E.05343
G1 X112.963 Y132.621 E.0352
M204 S10000
G1 X112.572 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7046
M204 S4000
G1 X112.572 Y121.57 E.2259
M204 S10000
G1 X120.552 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7046
M204 S4000
G1 X120.552 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X120.552 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L137
M991 S0 P136 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.8 I-.531 J1.095 P1  F60000
G1 X143.903 Y134.881 Z16.8
G1 Z16.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X143.903 Y121.119 E.28545
G1 X135.141 Y121.119 E.18174
G1 X135.141 Y134.881 E.28545
G1 X143.843 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.269 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.312 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.312 Y120.71 E.28104
G1 F3600
G1 X144.269 Y120.71 E.00083
G1 X134.732 Y120.71 E.18383
G1 X134.732 Y135.29 E.28104
G1 X144.209 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.312 Y135.29 E-.03914
G1 X144.312 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.512 Y134.49 Z16.92 F60000
G1 Z16.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X143.512 Y121.57 E.2259
M204 S10000
G1 X135.923 Y124.988 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X135.923 Y123.291 E.0352
G2 X137.104 Y122.404 I-1.398 J-3.09 E.03089
G3 X140.29 Y122.227 I1.677 J1.419 E.07409
G2 X141.656 Y123.332 I3.891 J-3.412 E.03661
G2 X143.121 Y123.327 I.726 J-1.974 E.03104
G1 X143.121 Y127.061 E.07745
G3 X140.745 Y126.045 I-.344 J-2.483 E.0563
G2 X137.559 Y125.868 I-1.677 J1.419 E.07409
G3 X136.193 Y126.973 I-3.891 J-3.412 E.03661
G1 X135.923 Y127.04 E.00578
G1 X135.923 Y130.574 E.07332
G2 X137.104 Y129.687 I-1.398 J-3.09 E.03089
G3 X140.29 Y129.51 I1.677 J1.419 E.07409
G2 X141.656 Y130.615 I3.891 J-3.412 E.03661
G2 X143.121 Y130.61 I.726 J-1.974 E.03104
G1 X143.121 Y134.344 E.07745
G3 X140.745 Y133.329 I-.344 J-2.483 E.0563
G2 X137.559 Y133.151 I-1.677 J1.419 E.07409
G3 X136.193 Y134.256 I-3.891 J-3.412 E.03661
G1 X135.923 Y134.323 E.00578
G1 X135.923 Y134.518 E.00405
G1 X137.425 Y134.518 E.03115
M204 S10000
G1 X135.532 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X135.532 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.532 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.004 Y122.313 Z16.92 F60000
G1 X120.859 Y121.119 Z16.92
G1 Z16.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X112.097 Y121.119 E.18174
G1 X112.097 Y134.881 E.28545
G1 X120.859 Y134.881 E.18174
G1 X120.859 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.268 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.731 Y120.71 E.18383
G1 X111.688 Y120.71 E.00083
G1 F3480
G1 X111.688 Y135.29 E.28104
G1 F3600
G1 X111.731 Y135.29 E.00083
G1 X121.268 Y135.29 E.18383
G1 X121.268 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.268 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.879 Y121.722 Z16.92 F60000
G1 Z16.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7035
M204 S4000
G1 X112.879 Y123.419 E.0352
G2 X114.799 Y122.849 I.366 J-2.287 E.04297
G3 X116.165 Y121.744 I3.891 J3.412 E.03661
G3 X118.896 Y122.672 I.716 J2.376 E.06385
G2 X120.077 Y123.398 I1.788 J-1.583 E.02918
G1 X120.077 Y126.933 E.07332
G3 X119.351 Y126.49 I.587 J-1.778 E.01778
G2 X117.986 Y125.385 I-3.891 J3.412 E.03661
G2 X115.255 Y126.313 I-.716 J2.376 E.06385
G3 X112.879 Y126.968 I-1.665 J-1.4 E.05434
G1 X112.879 Y130.702 E.07745
G2 X114.799 Y130.132 I.366 J-2.287 E.04297
G3 X116.165 Y129.027 I3.891 J3.412 E.03661
G3 X118.896 Y129.955 I.716 J2.376 E.06385
G2 X120.077 Y130.681 I1.788 J-1.583 E.02918
G1 X120.077 Y134.216 E.07332
G3 X119.351 Y133.773 I.586 J-1.778 E.01778
G2 X117.986 Y132.668 I-3.891 J3.412 E.03661
G2 X115.255 Y133.596 I-.716 J2.376 E.06385
G3 X112.879 Y134.252 I-1.665 J-1.4 E.05434
G1 X112.879 Y132.555 E.0352
M204 S10000
G1 X112.488 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7035
M204 S4000
G1 X112.488 Y121.57 E.2259
M204 S10000
G1 X120.468 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7035
M204 S4000
G1 X120.468 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.64
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X120.468 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L138
M991 S0 P137 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z16.92 I-.527 J1.097 P1  F60000
G1 X143.987 Y134.881 Z16.92
G1 Z16.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7051
M204 S4000
G1 X143.987 Y121.119 E.28545
G1 X135.225 Y121.119 E.18174
G1 X135.225 Y134.881 E.28545
G1 X143.927 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.353 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.396 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.396 Y120.71 E.28104
G1 F3600
G1 X144.353 Y120.71 E.00083
G1 X134.816 Y120.71 E.18383
G1 X134.816 Y135.29 E.28104
G1 X144.293 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.396 Y135.29 E-.03914
G1 X144.396 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P83 R3
G1 X143.596 Y134.49 Z17.04 F60000
G1 Z16.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7051
M204 S4000
G1 X143.596 Y121.57 E.2259
M204 S10000
G1 X136.007 Y124.907 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7051
M204 S4000
G1 X136.007 Y123.21 E.0352
G2 X137.559 Y121.882 I-10.967 J-14.389 E.04239
G3 X140.29 Y122.327 I1.081 J1.971 E.06183
G2 X141.656 Y123.412 I3.039 J-2.424 E.03649
G2 X143.205 Y123.253 I.573 J-2.04 E.03308
G1 X143.205 Y127.099 E.07977
G3 X141.201 Y126.39 I-.287 J-2.376 E.0457
G2 X139.835 Y125.305 I-3.039 J2.424 E.03649
G2 X137.559 Y125.969 I-.551 J2.344 E.05142
G3 X136.193 Y127.053 I-3.039 J-2.424 E.03649
G1 X136.007 Y127.084 E.00392
G1 X136.007 Y130.493 E.07071
G2 X137.559 Y129.165 I-10.968 J-14.391 E.04239
G3 X140.29 Y129.61 I1.081 J1.971 E.06183
G2 X141.656 Y130.695 I3.039 J-2.424 E.03649
G2 X143.205 Y130.536 I.573 J-2.039 E.03308
G1 X143.205 Y134.382 E.07977
G3 X141.201 Y133.673 I-.287 J-2.376 E.0457
G2 X139.835 Y132.588 I-3.039 J2.424 E.03649
G2 X137.559 Y133.252 I-.551 J2.344 E.05142
G3 X136.193 Y134.337 I-3.039 J-2.424 E.03649
G1 X136.007 Y134.368 E.00392
G1 X136.007 Y134.518 E.00312
G1 X137.554 Y134.518 E.03208
M204 S10000
G1 X135.616 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7051
M204 S4000
G1 X135.616 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.616 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.086 Y122.327 Z17.04 F60000
G1 X120.775 Y121.119 Z17.04
G1 Z16.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7051
M204 S4000
G1 X112.013 Y121.119 E.18174
G1 X112.013 Y134.881 E.28545
G1 X120.775 Y134.881 E.18174
G1 X120.775 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.184 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.647 Y120.71 E.18383
G1 X111.604 Y120.71 E.00083
G1 F3480
G1 X111.604 Y135.29 E.28104
G1 F3600
G1 X111.647 Y135.29 E.00083
G1 X121.184 Y135.29 E.18383
G1 X121.184 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.184 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.795 Y121.76 Z17.04 F60000
G1 Z16.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7051
M204 S4000
G1 X112.795 Y123.457 E.0352
G1 X112.979 Y123.488 E.00386
G2 X115.255 Y122.278 I-.039 J-2.819 E.05552
G3 X116.62 Y121.588 I1.566 J1.401 E.03249
G3 X118.896 Y122.797 I-.039 J2.819 E.05552
G2 X119.993 Y123.443 I1.555 J-1.386 E.02683
G1 X119.993 Y126.852 E.0707
G3 X118.896 Y125.92 I2.113 J-3.6 E.03
G2 X117.531 Y125.229 I-1.566 J1.401 E.03249
G2 X115.255 Y126.438 I.039 J2.819 E.05552
G3 X112.795 Y126.894 I-1.519 J-1.334 E.05594
G1 X112.795 Y130.74 E.07977
G1 X112.979 Y130.771 E.00386
G2 X115.255 Y129.562 I-.039 J-2.819 E.05552
G3 X116.62 Y128.871 I1.566 J1.401 E.03249
G3 X118.896 Y130.08 I-.039 J2.819 E.05552
G2 X119.993 Y130.726 I1.555 J-1.386 E.02683
G1 X119.993 Y134.135 E.0707
G3 X118.896 Y133.203 I2.114 J-3.6 E.03
G2 X117.531 Y132.512 I-1.566 J1.401 E.03249
G2 X115.255 Y133.722 I.039 J2.819 E.05552
G3 X112.795 Y134.177 I-1.519 J-1.334 E.05594
G1 X112.795 Y132.48 E.0352
M204 S10000
G1 X112.404 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7051
M204 S4000
G1 X112.404 Y121.57 E.2259
M204 S10000
G1 X120.384 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7051
M204 S4000
G1 X120.384 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.76
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X120.384 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L139
M991 S0 P138 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.04 I-.524 J1.098 P1  F60000
G1 X144.071 Y134.881 Z17.04
G1 Z16.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7075
M204 S4000
G1 X144.071 Y121.119 E.28545
G1 X135.309 Y121.119 E.18174
G1 X135.309 Y134.881 E.28545
G1 X144.011 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.437 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.48 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.48 Y120.71 E.28104
G1 F3600
G1 X144.437 Y120.71 E.00083
G1 X134.9 Y120.71 E.18383
G1 X134.9 Y135.29 E.28104
G1 X144.377 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.48 Y135.29 E-.03914
G1 X144.48 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.68 Y134.49 Z17.16 F60000
G1 Z16.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7075
M204 S4000
G1 X143.68 Y121.57 E.2259
M204 S10000
G1 X136.091 Y124.817 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7075
M204 S4000
G1 X136.091 Y123.12 E.0352
G3 X137.559 Y121.758 I773.682 J832.261 E.04154
G3 X140.29 Y122.429 I.921 J2.145 E.06261
G2 X141.656 Y123.501 I2.467 J-1.739 E.03652
G2 X143.289 Y123.17 I.411 J-2.166 E.03544
G1 X143.289 Y127.158 E.08272
G3 X141.201 Y126.288 I-.183 J-2.504 E.04868
G2 X139.835 Y125.216 I-2.467 J1.739 E.03652
G2 X137.559 Y126.071 I-.358 J2.507 E.05259
G3 X136.193 Y127.142 I-2.467 J-1.738 E.03652
G1 X136.091 Y127.151 E.00213
G1 X136.091 Y130.403 E.06746
G3 X137.559 Y129.041 I747.365 J803.902 E.04154
G3 X140.29 Y129.712 I.921 J2.145 E.06261
G2 X141.656 Y130.784 I2.467 J-1.739 E.03652
G2 X143.289 Y130.453 I.411 J-2.166 E.03544
G1 X143.289 Y134.441 E.08272
G3 X141.201 Y133.571 I-.183 J-2.504 E.04868
G2 X139.835 Y132.5 I-2.467 J1.738 E.03652
G2 X137.559 Y133.354 I-.358 J2.507 E.05259
G3 X136.193 Y134.425 I-2.468 J-1.739 E.03652
G1 X136.091 Y134.434 E.00213
G1 X136.091 Y134.518 E.00174
G1 X137.704 Y134.518 E.03346
M204 S10000
G1 X135.7 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7075
M204 S4000
G1 X135.7 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.7 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.167 Y122.34 Z17.16 F60000
G1 X120.691 Y121.119 Z17.16
G1 Z16.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7075
M204 S4000
G1 X111.929 Y121.119 E.18174
G1 X111.929 Y134.881 E.28545
G1 X120.691 Y134.881 E.18174
G1 X120.691 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.1 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.563 Y120.71 E.18383
G1 X111.52 Y120.71 E.00083
G1 F3480
G1 X111.52 Y135.29 E.28104
G1 F3600
G1 X111.563 Y135.29 E.00083
G1 X121.1 Y135.29 E.18383
G1 X121.1 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.1 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.711 Y121.819 Z17.16 F60000
G1 Z16.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7075
M204 S4000
G1 X112.711 Y123.516 E.0352
G2 X113.434 Y123.479 I.275 J-1.671 E.01513
G2 X115.255 Y122.144 I-1.346 J-3.745 E.04748
G3 X117.075 Y121.597 I1.357 J1.212 E.04149
G3 X118.896 Y122.932 I-1.346 J3.745 E.04748
G2 X119.909 Y123.509 I1.389 J-1.259 E.02459
G1 X119.909 Y126.761 E.06746
G3 X118.896 Y125.785 I3.388 J-4.529 E.02925
G2 X117.075 Y125.238 I-1.357 J1.212 E.0415
G2 X115.255 Y126.573 I1.346 J3.745 E.04748
G3 X112.711 Y126.811 I-1.413 J-1.384 E.05761
G1 X112.711 Y130.799 E.08272
G2 X113.434 Y130.762 I.275 J-1.671 E.01513
G2 X115.255 Y129.427 I-1.346 J-3.745 E.04748
G3 X117.075 Y128.88 I1.357 J1.212 E.04149
G3 X118.896 Y130.215 I-1.346 J3.745 E.04748
G2 X119.909 Y130.792 I1.389 J-1.259 E.02459
G1 X119.909 Y134.045 E.06746
G3 X118.896 Y133.068 I3.388 J-4.529 E.02925
G2 X117.075 Y132.521 I-1.357 J1.212 E.04149
G2 X115.255 Y133.856 I1.346 J3.745 E.04748
G3 X112.711 Y134.094 I-1.413 J-1.384 E.05761
G1 X112.711 Y132.397 E.0352
M204 S10000
G1 X112.32 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7075
M204 S4000
G1 X112.32 Y121.57 E.2259
M204 S10000
G1 X120.3 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7075
M204 S4000
G1 X120.3 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 16.88
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X120.3 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L140
M991 S0 P139 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.16 I-.521 J1.1 P1  F60000
G1 X144.155 Y134.881 Z17.16
G1 Z16.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7115
M204 S4000
G1 X144.155 Y121.119 E.28545
G1 X135.393 Y121.119 E.18174
G1 X135.393 Y134.881 E.28545
G1 X144.095 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.521 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.564 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.564 Y120.71 E.28104
G1 F3600
G1 X144.521 Y120.71 E.00083
G1 X134.984 Y120.71 E.18383
G1 X134.984 Y135.29 E.28104
G1 X144.461 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.564 Y135.29 E-.03914
G1 X144.564 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.764 Y134.49 Z17.28 F60000
G1 Z16.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7115
M204 S4000
G1 X143.764 Y121.57 E.2259
M204 S10000
G1 X136.175 Y124.716 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7115
M204 S4000
G1 X136.193 Y123.006 E.03546
G3 X137.559 Y121.618 I5.293 J3.839 E.04055
G3 X139.835 Y122.069 I.749 J2.187 E.05042
G2 X141.201 Y123.458 I5.293 J-3.839 E.04055
G2 X143.373 Y123.077 I.745 J-2.133 E.04779
G1 X143.373 Y127.24 E.08637
G3 X141.656 Y126.648 I-.104 J-2.483 E.03857
G2 X140.29 Y125.259 I-5.292 J3.838 E.04055
G2 X138.014 Y125.711 I-.749 J2.184 E.05043
G3 X136.649 Y127.099 I-5.293 J-3.838 E.04055
G3 X136.175 Y127.241 I-.461 J-.681 E.01041
G1 X136.193 Y130.289 E.06324
G3 X137.559 Y128.901 I5.293 J3.839 E.04055
G3 X139.835 Y129.352 I.75 J2.184 E.05043
G2 X141.201 Y130.741 I5.293 J-3.839 E.04055
M73 P84 R3
G2 X143.373 Y130.36 I.745 J-2.133 E.04779
G1 X143.373 Y134.518 E.08625
G3 X141.656 Y133.931 I-.121 J-2.452 E.03856
G2 X140.29 Y132.542 I-5.293 J3.839 E.04055
G2 X138.014 Y132.994 I-.75 J2.184 E.05043
G3 X136.649 Y134.382 I-5.293 J-3.839 E.04055
G3 X136.175 Y134.518 I-.455 J-.694 E.01038
G1 X136.175 Y132.859 E.03441
M204 S10000
G1 X135.784 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7115
M204 S4000
G1 X135.784 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.784 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.249 Y122.353 Z17.28 F60000
G1 X120.607 Y121.119 Z17.28
G1 Z16.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7115
M204 S4000
G1 X111.845 Y121.119 E.18174
G1 X111.845 Y134.881 E.28545
G1 X120.607 Y134.881 E.18174
G1 X120.607 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X121.016 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.479 Y120.71 E.18383
G1 X111.436 Y120.71 E.00083
G1 F3480
G1 X111.436 Y135.29 E.28104
G1 F3600
G1 X111.479 Y135.29 E.00083
G1 X121.016 Y135.29 E.18383
G1 X121.016 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X119.016 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.627 Y121.902 Z17.28 F60000
G1 Z16.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7115
M204 S4000
G1 X112.627 Y123.599 E.0352
G2 X114.344 Y123.006 I.104 J-2.483 E.03858
G3 X115.71 Y121.618 I5.293 J3.838 E.04055
G3 X117.986 Y122.069 I.749 J2.187 E.05042
G1 X118.896 Y123.083 E.02826
G2 X119.825 Y123.599 I1.303 J-1.249 E.02238
G1 X119.825 Y126.66 E.0635
G2 X118.441 Y125.259 I-12.022 J10.49 E.04088
G2 X116.165 Y125.711 I-.749 J2.184 E.05042
G3 X114.799 Y127.099 I-5.293 J-3.839 E.04055
G3 X112.627 Y126.718 I-.745 J-2.133 E.0478
G1 X112.627 Y130.882 E.08637
G2 X114.344 Y130.289 I.104 J-2.483 E.03858
G3 X115.71 Y128.901 I5.293 J3.839 E.04055
G3 X117.986 Y129.352 I.75 J2.184 E.05043
G1 X118.896 Y130.366 E.02826
G2 X119.825 Y130.882 I1.303 J-1.249 E.02238
G1 X119.825 Y133.944 E.0635
G2 X118.441 Y132.542 I-12.021 J10.489 E.04088
G2 X116.165 Y132.994 I-.75 J2.184 E.05042
G3 X114.799 Y134.382 I-5.293 J-3.839 E.04055
G3 X112.627 Y134.001 I-.745 J-2.136 E.04779
G1 X112.627 Y132.304 E.0352
M204 S10000
G1 X112.236 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7115
M204 S4000
G1 X112.236 Y121.57 E.2259
M204 S10000
G1 X120.216 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7115
M204 S4000
G1 X120.216 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X120.216 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L141
M991 S0 P140 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.28 I-.518 J1.101 P1  F60000
G1 X144.239 Y134.881 Z17.28
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7158
M204 S4000
G1 X144.239 Y121.119 E.28545
G1 X135.477 Y121.119 E.18174
G1 X135.477 Y134.881 E.28545
G1 X144.179 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.605 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.648 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.648 Y120.71 E.28104
G1 F3600
G1 X144.605 Y120.71 E.00083
G1 X135.068 Y120.71 E.18383
G1 X135.068 Y135.29 E.28104
G1 X144.545 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.648 Y135.29 E-.03914
G1 X144.648 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.848 Y134.49 Z17.4 F60000
G1 Z17
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7158
M204 S4000
G1 X143.848 Y121.57 E.2259
M204 S10000
G1 X136.259 Y124.571 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7158
M204 S4000
G1 X136.259 Y122.874 E.0352
G1 X137.104 Y121.814 E.02811
G1 X137.526 Y121.482 E.01114
G1 X138.615 Y121.482 E.02259
G3 X139.835 Y122.119 I-.464 J2.375 E.02896
G1 X140.745 Y123.261 E.03029
G2 X141.656 Y123.71 I.897 J-.67 E.02186
G2 X143.457 Y122.971 I-.119 J-2.856 E.04121
G1 X143.457 Y127.348 E.09079
G3 X141.656 Y126.598 I.132 J-2.854 E.04131
G1 X140.745 Y125.456 E.03029
G2 X139.835 Y125.007 I-.897 J.67 E.02186
G2 X138.014 Y125.761 I.124 J2.875 E.04172
G1 X137.104 Y126.903 E.03029
G1 X136.649 Y127.261 E.01202
G1 X136.259 Y127.339 E.00824
G1 X136.259 Y130.157 E.05846
G1 X137.104 Y129.097 E.02811
G3 X138.014 Y128.648 I.897 J.67 E.02186
G3 X139.835 Y129.403 I-.124 J2.875 E.04172
G1 X140.745 Y130.544 E.03029
G2 X141.656 Y130.993 I.897 J-.67 E.02186
G2 X143.457 Y130.254 I-.119 J-2.855 E.04121
G1 X143.457 Y134.518 E.08844
G3 X141.656 Y133.881 I-.246 J-2.169 E.04102
G1 X140.745 Y132.739 E.03029
G2 X139.835 Y132.29 I-.897 J.67 E.02186
G2 X138.014 Y133.044 I.124 J2.875 E.04172
G1 X137.104 Y134.186 E.03029
G1 X136.682 Y134.518 E.01114
G1 X138.379 Y134.518 E.0352
M204 S10000
G1 X135.868 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7158
M204 S4000
G1 X135.868 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.868 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.331 Y122.366 Z17.4 F60000
G1 X120.523 Y121.119 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7158
M204 S4000
G1 X111.761 Y121.119 E.18174
G1 X111.761 Y134.881 E.28545
G1 X120.523 Y134.881 E.18174
G1 X120.523 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.932 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.395 Y120.71 E.18383
G1 X111.352 Y120.71 E.00083
G1 F3480
G1 X111.352 Y135.29 E.28104
G1 F3600
G1 X111.395 Y135.29 E.00083
G1 X120.932 Y135.29 E.18383
G1 X120.932 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.932 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.543 Y122.009 Z17.4 F60000
G1 Z17
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7158
M204 S4000
G1 X112.543 Y123.706 E.0352
G2 X114.344 Y122.956 I-.132 J-2.854 E.04131
G1 X115.255 Y121.814 E.03029
G1 X115.676 Y121.482 E.01114
G1 X116.765 Y121.482 E.02259
G3 X117.986 Y122.119 I-.464 J2.375 E.02896
G1 X118.896 Y123.261 E.03029
G1 X119.351 Y123.62 E.01202
G1 X119.741 Y123.697 E.00824
G1 X119.741 Y126.515 E.05845
G1 X118.896 Y125.456 E.0281
G1 X118.441 Y125.097 E.01202
G2 X116.165 Y125.761 I-.519 J2.455 E.05122
G1 X115.255 Y126.903 E.03029
G1 X114.799 Y127.261 E.01202
G3 X112.543 Y126.613 I-.523 J-2.43 E.05072
G1 X112.543 Y130.99 E.09079
G2 X114.344 Y130.239 I-.132 J-2.854 E.04131
G1 X115.255 Y129.097 E.03029
G1 X115.71 Y128.739 E.01202
G3 X117.986 Y129.403 I.519 J2.456 E.05122
G1 X118.896 Y130.544 E.03029
G1 X119.351 Y130.903 E.01202
G1 X119.741 Y130.98 E.00824
G1 X119.741 Y133.798 E.05845
G1 X118.896 Y132.739 E.0281
G1 X118.441 Y132.381 E.01202
G2 X116.165 Y133.044 I-.519 J2.456 E.05122
G1 X115.255 Y134.186 E.03029
G1 X114.833 Y134.518 E.01114
G1 X113.759 Y134.518 E.02228
G3 X112.543 Y133.896 I.418 J-2.315 E.02874
G1 X112.543 Y132.199 E.0352
M204 S10000
G1 X112.152 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7158
M204 S4000
G1 X112.152 Y121.57 E.2259
M204 S10000
G1 X120.132 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7158
M204 S4000
G1 X120.132 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.12
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X120.132 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L142
M991 S0 P141 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.4 I-.515 J1.102 P1  F60000
G1 X144.323 Y134.881 Z17.4
G1 Z17.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7220
M204 S4000
G1 X144.323 Y121.119 E.28545
G1 X135.561 Y121.119 E.18174
G1 X135.561 Y134.881 E.28545
G1 X144.263 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.689 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.732 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.732 Y120.71 E.28104
G1 F3600
G1 X144.689 Y120.71 E.00083
G1 X135.152 Y120.71 E.18383
G1 X135.152 Y135.29 E.28104
G1 X144.629 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.732 Y135.29 E-.03914
G1 X144.732 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.932 Y134.49 Z17.52 F60000
G1 Z17.12
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7220
M204 S4000
G1 X143.932 Y121.57 E.2259
M204 S10000
G1 X136.343 Y124.388 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7220
M204 S4000
G1 X136.343 Y122.691 E.0352
G1 X137.104 Y121.585 E.02785
G1 X137.248 Y121.482 E.00367
G1 X138.85 Y121.482 E.03323
G3 X139.835 Y122.167 I-1.216 J2.799 E.02505
G1 X140.745 Y123.491 E.03332
G1 X141.201 Y123.814 E.01158
G1 X141.656 Y123.836 E.00945
G2 X143.541 Y122.814 I-.343 J-2.884 E.04555
G1 X143.541 Y127.474 E.09666
G1 X143.477 Y127.477 E.00134
G3 X141.656 Y126.55 I.445 J-3.124 E.04317
G1 X140.745 Y125.226 E.03332
G1 X140.29 Y124.903 E.01158
G1 X139.835 Y124.881 E.00945
G2 X138.014 Y125.809 I.445 J3.124 E.04317
G1 X137.104 Y127.132 E.03332
G1 X136.649 Y127.455 E.01158
G1 X136.343 Y127.47 E.00635
G1 X136.343 Y129.974 E.05193
G1 X137.104 Y128.868 E.02785
G1 X137.559 Y128.545 E.01158
G1 X138.014 Y128.523 E.00945
G3 X139.835 Y129.45 I-.445 J3.124 E.04317
G1 X140.745 Y130.774 E.03332
G1 X141.201 Y131.097 E.01158
G1 X141.656 Y131.119 E.00945
G2 X143.541 Y130.098 I-.343 J-2.884 E.04555
G1 X143.541 Y134.518 E.09169
G3 X142.566 Y134.496 I-.412 J-3.416 E.02029
G3 X141.656 Y133.833 I1.133 J-2.511 E.02353
G1 X140.745 Y132.509 E.03332
G1 X140.29 Y132.186 E.01158
G1 X139.835 Y132.164 E.00945
G2 X138.014 Y133.092 I.445 J3.124 E.04317
G1 X137.104 Y134.415 E.03332
G1 X136.883 Y134.518 E.00505
G1 X136.343 Y134.518 E.0112
G1 X136.343 Y133.361 E.024
M204 S10000
G1 X135.952 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7220
M204 S4000
G1 X135.952 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X135.952 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.413 Y122.379 Z17.52 F60000
G1 X120.439 Y121.119 Z17.52
G1 Z17.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7220
M204 S4000
G1 X111.677 Y121.119 E.18174
G1 X111.677 Y134.881 E.28545
G1 X120.439 Y134.881 E.18174
G1 X120.439 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
M73 P85 R3
G1 X120.848 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.311 Y120.71 E.18383
G1 X111.268 Y120.71 E.00083
G1 F3480
G1 X111.268 Y135.29 E.28104
G1 F3600
G1 X111.311 Y135.29 E.00083
G1 X120.848 Y135.29 E.18383
G1 X120.848 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.848 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.459 Y122.136 Z17.52 F60000
G1 Z17.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7220
M204 S4000
G1 X112.459 Y123.833 E.0352
G2 X114.344 Y122.908 I-.23 J-2.853 E.0446
G1 X115.255 Y121.585 E.03332
G1 X115.399 Y121.482 E.00367
G1 X117.001 Y121.482 E.03323
G3 X117.986 Y122.167 I-1.216 J2.799 E.02505
G1 X118.896 Y123.491 E.03332
G1 X119.351 Y123.814 E.01158
G1 X119.657 Y123.829 E.00635
G1 X119.657 Y126.332 E.05193
G1 X118.896 Y125.226 E.02784
G1 X118.441 Y124.903 E.01158
G2 X116.165 Y125.809 I-.214 J2.774 E.05261
G1 X115.255 Y127.132 E.03332
G1 X114.799 Y127.455 E.01158
G3 X112.459 Y126.456 I-.183 J-2.811 E.05477
G1 X112.459 Y131.116 E.09666
G2 X114.344 Y130.191 I-.23 J-2.853 E.0446
G1 X115.255 Y128.868 E.03332
G1 X115.71 Y128.545 E.01158
G3 X117.986 Y129.45 I.214 J2.774 E.05261
G1 X118.896 Y130.774 E.03332
G1 X119.351 Y131.097 E.01158
G1 X119.657 Y131.112 E.00635
G1 X119.657 Y133.615 E.05193
G1 X118.896 Y132.509 E.02784
G1 X118.441 Y132.186 E.01158
G2 X116.165 Y133.092 I-.214 J2.774 E.05261
G1 X115.255 Y134.415 E.03332
G1 X115.034 Y134.518 E.00505
G1 X113.584 Y134.518 E.03007
G3 X112.459 Y133.739 I.372 J-1.74 E.02914
G1 X112.459 Y132.042 E.0352
M204 S10000
G1 X112.068 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7220
M204 S4000
G1 X112.068 Y121.57 E.2259
M204 S10000
G1 X120.048 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7220
M204 S4000
G1 X120.048 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.24
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X120.048 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L143
M991 S0 P142 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.52 I-.513 J1.104 P1  F60000
G1 X144.407 Y134.881 Z17.52
G1 Z17.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7325
M204 S4000
G1 X144.407 Y121.119 E.28545
G1 X135.645 Y121.119 E.18174
G1 X135.645 Y134.881 E.28545
G1 X144.347 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.773 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.816 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.816 Y120.71 E.28104
G1 F3600
G1 X144.773 Y120.71 E.00083
G1 X135.236 Y120.71 E.18383
G1 X135.236 Y135.29 E.28104
G1 X144.713 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.816 Y135.29 E-.03914
G1 X144.816 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.016 Y134.49 Z17.64 F60000
G1 Z17.24
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7325
M204 S4000
G1 X144.016 Y121.57 E.2259
M204 S10000
G1 X136.427 Y124.178 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7325
M204 S4000
G1 X136.427 Y122.481 E.0352
G2 X136.973 Y121.482 I-6.103 J-3.984 E.02363
G1 X138.964 Y121.482 E.0413
G3 X140.29 Y122.957 I-1.746 J2.904 E.04175
G1 X140.745 Y123.85 E.0208
G1 X141.201 Y124.062 E.01041
G2 X143.625 Y122.62 I-.314 J-3.287 E.06045
G1 X143.625 Y127.648 E.10429
G1 X143.477 Y127.621 E.00313
G3 X141.201 Y125.76 I.76 J-3.252 E.06314
G1 X140.745 Y124.866 E.0208
G1 X140.29 Y124.655 E.01041
G2 X137.559 Y126.598 I.349 J3.381 E.0727
G1 X137.104 Y127.492 E.0208
G1 X136.649 Y127.703 E.01041
G1 X136.427 Y127.663 E.00467
G1 X136.427 Y129.764 E.04358
G2 X137.104 Y128.508 I-7.68 J-4.95 E.02962
G1 X137.559 Y128.297 E.01041
G3 X140.29 Y130.24 I-.349 J3.381 E.0727
G1 X140.745 Y131.134 E.0208
G1 X141.201 Y131.345 E.01041
G2 X143.625 Y129.903 I-.314 J-3.287 E.06045
G1 X143.625 Y134.518 E.09572
G1 X142.527 Y134.518 E.02278
G3 X141.201 Y133.043 I1.746 J-2.904 E.04175
G1 X140.745 Y132.15 E.0208
G1 X140.29 Y131.939 E.01041
G2 X137.559 Y133.881 I.349 J3.381 E.0727
G1 X137.17 Y134.518 E.01547
G1 X136.427 Y134.518 E.01542
G1 X136.427 Y133.564 E.01978
M204 S10000
G1 X136.036 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7325
M204 S4000
G1 X136.036 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.036 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.495 Y122.392 Z17.64 F60000
G1 X120.355 Y121.119 Z17.64
G1 Z17.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7325
M204 S4000
G1 X111.593 Y121.119 E.18174
G1 X111.593 Y134.881 E.28545
G1 X120.355 Y134.881 E.18174
G1 X120.355 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.764 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.227 Y120.71 E.18383
G1 X111.184 Y120.71 E.00083
G1 F3480
G1 X111.184 Y135.29 E.28104
G1 F3600
G1 X111.227 Y135.29 E.00083
G1 X120.764 Y135.29 E.18383
G1 X120.764 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.764 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.375 Y122.309 Z17.64 F60000
G1 Z17.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7325
M204 S4000
G1 X112.375 Y124.006 E.0352
G2 X113.889 Y123.321 I-1.461 J-5.248 E.0346
G2 X115.124 Y121.482 I-4.237 J-4.178 E.04622
G1 X117.115 Y121.482 E.0413
G1 X117.531 Y121.754 E.01031
G3 X118.896 Y123.85 I-4.675 J4.539 E.05222
G1 X119.351 Y124.062 E.01041
G1 X119.573 Y124.021 E.00467
G1 X119.573 Y126.122 E.04358
G3 X118.896 Y124.866 I7.678 J-4.948 E.02962
G1 X118.441 Y124.655 E.01041
G2 X116.62 Y125.396 I.891 J4.802 E.04105
G2 X115.255 Y127.492 I4.676 J4.539 E.05222
G1 X114.799 Y127.703 E.01041
G3 X112.375 Y126.261 I.314 J-3.287 E.06045
G1 X112.375 Y131.289 E.10429
G2 X113.889 Y130.604 I-1.462 J-5.249 E.0346
G2 X115.255 Y128.508 I-4.676 J-4.539 E.05222
G1 X115.71 Y128.297 E.01041
G3 X117.531 Y129.037 I-.891 J4.801 E.04105
G3 X118.896 Y131.134 I-4.675 J4.539 E.05222
G1 X119.351 Y131.345 E.01041
G1 X119.573 Y131.305 E.00467
G1 X119.573 Y133.405 E.04358
G3 X118.896 Y132.15 I7.68 J-4.949 E.02962
G1 X118.441 Y131.939 E.01041
G2 X116.165 Y133.138 I.403 J3.525 E.05461
G2 X115.321 Y134.518 I754.852 J462.525 E.03356
G1 X113.394 Y134.518 E.03997
G3 X112.375 Y133.544 I1.514 J-2.606 E.02951
G1 X112.375 Y131.847 E.0352
M204 S10000
G1 X111.984 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7325
M204 S4000
G1 X111.984 Y121.57 E.2259
M204 S10000
G1 X119.964 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7325
M204 S4000
G1 X119.964 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.36
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X119.964 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L144
M991 S0 P143 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.64 I-.51 J1.105 P1  F60000
G1 X144.491 Y134.881 Z17.64
G1 Z17.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7370
M204 S4000
G1 X144.491 Y121.119 E.28545
G1 X135.729 Y121.119 E.18174
G1 X135.729 Y134.881 E.28545
G1 X144.431 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.857 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.9 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.9 Y120.71 E.28104
G1 F3600
G1 X144.857 Y120.71 E.00083
G1 X135.32 Y120.71 E.18383
G1 X135.32 Y135.29 E.28104
G1 X144.797 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.9 Y135.29 E-.03914
G1 X144.9 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.1 Y134.49 Z17.76 F60000
G1 Z17.36
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7370
M204 S4000
G1 X144.1 Y121.57 E.2259
M204 S10000
G1 X142.905 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7370
M204 S4000
M73 P85 R2
G1 X143.709 Y121.482 E.01668
G1 X143.709 Y122.375 E.01852
G3 X143.349 Y122.993 I-1.671 J-.559 E.01494
G3 X141.275 Y124.358 I-4.565 J-4.677 E.05183
G1 X141.054 Y124.814 E.01049
G2 X141.783 Y126.634 I4.693 J-.822 E.04097
G2 X143.709 Y127.923 I4.349 J-4.415 E.04835
G1 X143.709 Y129.658 E.03598
G3 X143.349 Y130.276 I-1.672 J-.559 E.01494
G3 X141.275 Y131.642 I-4.566 J-4.677 E.05183
G1 X141.054 Y132.097 E.01049
G2 X142.475 Y134.518 I3.262 J-.286 E.06017
G1 X137.465 Y134.518 E.10391
G3 X138.142 Y133.007 I5.175 J1.41 E.03447
G3 X140.216 Y131.642 I4.565 J4.677 E.05183
G1 X140.436 Y131.186 E.01049
G2 X139.708 Y129.366 I-4.694 J.822 E.04097
G2 X137.633 Y128 I-4.566 J4.677 E.05183
G1 X137.413 Y127.545 E.01049
G3 X138.142 Y125.724 I4.693 J.822 E.04097
G3 X140.216 Y124.358 I4.566 J4.677 E.05183
G1 X140.436 Y123.903 E.01049
G2 X139.016 Y121.482 I-3.262 J.286 E.06017
G1 X136.743 Y121.482 E.04716
G3 X136.511 Y122.157 I-1.736 J-.218 E.01491
G1 X136.511 Y127.967 E.12052
G1 X136.795 Y128.455 E.01171
G3 X136.511 Y129.44 I-2.506 J-.189 E.02141
G1 X136.511 Y131.137 E.0352
M204 S10000
G1 X136.12 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7370
M204 S4000
G1 X136.12 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.12 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.577 Y122.404 Z17.76 F60000
G1 X120.271 Y121.119 Z17.76
G1 Z17.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7370
M204 S4000
G1 X111.509 Y121.119 E.18174
G1 X111.509 Y134.881 E.28545
G1 X120.271 Y134.881 E.18174
G1 X120.271 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.68 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.143 Y120.71 E.18383
G1 X111.1 Y120.71 E.00083
G1 F3480
M73 P86 R2
G1 X111.1 Y135.29 E.28104
G1 F3600
G1 X111.143 Y135.29 E.00083
G1 X120.68 Y135.29 E.18383
G1 X120.68 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.68 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.489 Y122.616 Z17.76 F60000
G1 Z17.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7370
M204 S4000
G1 X119.489 Y124.313 E.0352
G1 X119.205 Y124.814 E.01194
G2 X119.489 Y125.798 I2.505 J-.189 E.02141
G1 X119.489 Y131.596 E.12026
G1 X119.205 Y132.097 E.01194
G2 X119.489 Y133.082 I2.505 J-.189 E.02141
G1 X119.489 Y134.518 E.02979
G1 X115.616 Y134.518 E.08034
G1 X115.641 Y134.373 E.00305
G3 X117.486 Y132.097 I3.241 J.742 E.06294
G1 X118.367 Y131.642 E.02056
G1 X118.587 Y131.186 E.01049
G2 X116.665 Y128.455 I-3.358 J.321 E.07247
G1 X115.784 Y128 E.02056
G1 X115.564 Y127.545 E.01049
G3 X117.486 Y124.814 I3.358 J.321 E.07247
G1 X118.367 Y124.358 E.02056
G1 X118.587 Y123.903 E.01049
G2 X117.167 Y121.482 I-3.262 J.286 E.06017
G1 X114.893 Y121.482 E.04716
G1 X114.869 Y121.627 E.00305
G3 X113.023 Y123.903 I-3.241 J-.742 E.06294
G1 X112.291 Y124.282 E.0171
G1 X112.291 Y126.016 E.03598
G2 X113.845 Y127.545 I2.762 J-1.253 E.04624
G1 X114.725 Y128 E.02056
G1 X114.946 Y128.455 E.01049
G3 X113.023 Y131.186 I-3.358 J-.321 E.07247
G1 X112.291 Y131.565 E.0171
G1 X112.291 Y133.299 E.03598
G2 X113.342 Y134.518 I2.108 J-.756 E.03415
G1 X115.039 Y134.518 E.0352
M204 S10000
G1 X111.9 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7370
M204 S4000
G1 X111.9 Y121.57 E.2259
M204 S10000
G1 X119.88 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7370
M204 S4000
G1 X119.88 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.48
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X119.88 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L145
M991 S0 P144 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.76 I-.507 J1.106 P1  F60000
G1 X144.575 Y134.881 Z17.76
G1 Z17.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6630
M204 S4000
G1 X144.575 Y121.119 E.28545
G1 X135.813 Y121.119 E.18174
G1 X135.813 Y134.881 E.28545
G1 X144.515 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X144.941 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X144.984 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X144.984 Y120.71 E.28104
G1 F3600
G1 X144.941 Y120.71 E.00083
G1 X135.404 Y120.71 E.18383
G1 X135.404 Y135.29 E.28104
G1 X144.881 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X144.984 Y135.29 E-.03914
G1 X144.984 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.184 Y134.49 Z17.88 F60000
G1 Z17.48
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6630
M204 S4000
G1 X144.184 Y121.57 E.2259
M204 S10000
G1 X142.471 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6630
M204 S4000
G1 X143.793 Y121.482 E.02742
G3 X142.939 Y123.448 I-2.565 J.054 E.04587
G1 X141.625 Y124.358 E.03316
G1 X141.299 Y124.814 E.01161
G1 X141.274 Y125.269 E.00946
G2 X142.194 Y127.09 I3.112 J-.43 E.0431
G1 X143.508 Y128 E.03316
G1 X143.793 Y128.399 E.01017
G3 X142.939 Y130.731 I-2.637 J.356 E.0536
G1 X141.625 Y131.642 E.03316
G1 X141.299 Y132.097 E.01161
G1 X141.274 Y132.552 E.00946
G2 X142.403 Y134.518 I2.824 J-.315 E.04838
G1 X137.64 Y134.518 E.0988
G1 X137.632 Y134.373 E.00302
G3 X138.552 Y132.552 I3.112 J.43 E.0431
G1 X139.866 Y131.642 E.03316
G1 X140.192 Y131.186 E.01161
G1 X140.217 Y130.731 E.00946
G2 X139.297 Y128.91 I-3.112 J.43 E.0431
G1 X137.983 Y128 E.03316
G1 X137.658 Y127.545 E.01161
G1 X137.632 Y127.09 E.00946
G3 X138.552 Y125.269 I3.112 J.43 E.0431
G1 X139.866 Y124.358 E.03316
G1 X140.192 Y123.903 E.01161
G1 X140.217 Y123.448 E.00946
G2 X139.087 Y121.482 I-2.824 J.315 E.04838
G1 X137.39 Y121.482 E.0352
M204 S10000
G1 X136.204 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6630
M204 S4000
G1 X136.204 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.204 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.66 Y122.416 Z17.88 F60000
G1 X120.187 Y121.119 Z17.88
G1 Z17.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6630
M204 S4000
G1 X111.425 Y121.119 E.18174
G1 X111.425 Y134.881 E.28545
G1 X120.187 Y134.881 E.18174
G1 X120.187 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.596 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X111.059 Y120.71 E.18383
G1 X111.016 Y120.71 E.00083
G1 F3480
G1 X111.016 Y135.29 E.28104
G1 F3600
G1 X111.059 Y135.29 E.00083
G1 X120.596 Y135.29 E.18383
G1 X120.596 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.596 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.26 Y128.361 Z17.88 F60000
G1 X119.796 Y134.49 Z17.88
G1 Z17.48
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6630
M204 S4000
G1 X119.796 Y121.57 E.2259
M204 S10000
G1 X117.488 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6630
M204 S4000
G1 X115.791 Y134.518 E.0352
G3 X116.703 Y132.552 I2.805 J.107 E.04615
G1 X118.017 Y131.642 E.03316
G1 X118.342 Y131.186 E.01161
G2 X117.448 Y128.91 I-2.757 J-.23 E.05254
G1 X116.134 Y128 E.03316
G1 X115.808 Y127.545 E.01161
G3 X116.703 Y125.269 I2.758 J-.23 E.05254
G1 X118.017 Y124.358 E.03316
G1 X118.342 Y123.903 E.01161
G2 X117.238 Y121.482 I-2.744 J-.211 E.05761
G1 X114.718 Y121.482 E.05227
G3 X113.806 Y123.448 I-2.805 J-.106 E.04615
G1 X112.492 Y124.358 E.03316
G1 X112.207 Y124.757 E.01017
G2 X113.061 Y127.09 I2.638 J.356 E.0536
G1 X114.376 Y128 E.03316
G1 X114.701 Y128.455 E.01161
G3 X113.806 Y130.731 I-2.757 J.23 E.05254
G1 X112.492 Y131.642 E.03316
G1 X112.207 Y132.041 E.01017
G2 X113.271 Y134.518 I2.62 J.342 E.05869
G1 X114.968 Y134.518 E.0352
M204 S10000
G1 X111.816 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6630
M204 S4000
G1 X111.816 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X111.816 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L146
M991 S0 P145 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z17.88 I-.396 J1.151 P1  F60000
G1 X144.659 Y134.881 Z17.88
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6587
M204 S4000
G1 X144.659 Y121.119 E.28545
G1 X135.897 Y121.119 E.18174
G1 X135.897 Y134.881 E.28545
G1 X144.599 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.025 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.068 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.068 Y120.71 E.28104
G1 F3600
G1 X145.025 Y120.71 E.00083
G1 X135.488 Y120.71 E.18383
G1 X135.488 Y135.29 E.28104
G1 X144.965 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.068 Y135.29 E-.03914
G1 X145.068 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.268 Y134.49 Z18 F60000
G1 Z17.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6587
M204 S4000
G1 X144.268 Y121.57 E.2259
M204 S10000
G1 X142.007 Y121.482 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6587
M204 S4000
G1 X143.704 Y121.482 E.0352
G1 X143.734 Y121.627 E.00307
G3 X142.987 Y123.448 I-2.866 J-.112 E.04167
G1 X141.851 Y124.358 E.03018
G2 X141.399 Y125.269 I.677 J.904 E.02187
G2 X142.146 Y127.09 I2.866 J-.112 E.04167
G1 X143.281 Y128 E.03018
G3 X143.734 Y128.91 I-.677 J.904 E.02187
G3 X142.987 Y130.731 I-2.866 J-.112 E.04167
G1 X141.851 Y131.642 E.03018
G2 X141.399 Y132.552 I.677 J.904 E.02187
G2 X142.146 Y134.373 I2.866 J-.112 E.04167
G1 X142.327 Y134.518 E.00481
G1 X137.787 Y134.518 E.09417
G1 X137.757 Y134.373 E.00307
G3 X138.504 Y132.552 I2.866 J.112 E.04167
G1 X139.64 Y131.642 E.03018
G2 X140.092 Y130.731 I-.677 J-.904 E.02187
G2 X139.345 Y128.91 I-2.866 J.112 E.04167
G1 X138.21 Y128 E.03018
G3 X137.757 Y127.09 I.677 J-.904 E.02187
G3 X138.504 Y125.269 I2.866 J.112 E.04167
G1 X139.64 Y124.358 E.03018
G2 X140.092 Y123.448 I-.677 J-.904 E.02187
G2 X139.345 Y121.627 I-2.866 J.112 E.04167
G1 X139.164 Y121.482 E.00481
G1 X137.467 Y121.482 E.0352
M204 S10000
G1 X136.288 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6587
M204 S4000
G1 X136.288 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.288 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.742 Y122.427 Z18 F60000
G1 X120.103 Y121.119 Z18
G1 Z17.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6587
M204 S4000
G1 X111.341 Y121.119 E.18174
G1 X111.341 Y134.881 E.28545
G1 X120.103 Y134.881 E.18174
G1 X120.103 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.512 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.975 Y120.71 E.18383
G1 X110.932 Y120.71 E.00083
G1 F3480
G1 X110.932 Y135.29 E.28104
G1 F3600
G1 X110.975 Y135.29 E.00083
G1 X120.512 Y135.29 E.18383
G1 X120.512 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.512 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.176 Y128.361 Z18 F60000
G1 X119.712 Y134.49 Z18
G1 Z17.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6587
M204 S4000
G1 X119.712 Y121.57 E.2259
M204 S10000
G1 X117.635 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P87 R2
G1 F6587
M204 S4000
G1 X115.938 Y134.518 E.0352
G3 X116.655 Y132.552 I2.559 J-.18 E.04471
G1 X117.79 Y131.642 E.03018
G1 X118.15 Y131.186 E.01203
G2 X117.496 Y128.91 I-2.444 J-.53 E.05117
G1 X116.361 Y128 E.03018
G1 X116.001 Y127.545 E.01203
G3 X116.655 Y125.269 I2.444 J-.53 E.05117
G1 X117.79 Y124.358 E.03018
G2 X118.243 Y123.448 I-.677 J-.904 E.02187
G1 X118.069 Y122.538 E.01922
G2 X117.315 Y121.482 I-2.569 J1.038 E.02717
G1 X114.572 Y121.482 E.0569
G3 X113.854 Y123.448 I-2.559 J.18 E.04471
G1 X112.719 Y124.358 E.03018
G1 X112.359 Y124.814 E.01203
G2 X113.013 Y127.09 I2.444 J.53 E.05117
G1 X114.149 Y128 E.03018
G1 X114.508 Y128.455 E.01203
G3 X113.854 Y130.731 I-2.444 J.53 E.05117
G1 X112.719 Y131.642 E.03018
G2 X112.266 Y132.552 I.677 J.904 E.02187
G1 X112.44 Y133.462 E.01922
G2 X113.194 Y134.518 I2.569 J-1.039 E.02716
G1 X114.891 Y134.518 E.0352
M204 S10000
G1 X111.732 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6587
M204 S4000
G1 X111.732 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.72
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X111.732 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L147
M991 S0 P146 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18 I-.394 J1.151 P1  F60000
G1 X144.743 Y134.881 Z18
G1 Z17.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6530
M204 S4000
G1 X144.743 Y121.119 E.28545
G1 X135.981 Y121.119 E.18174
G1 X135.981 Y134.881 E.28545
G1 X144.683 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.109 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.152 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.152 Y120.71 E.28104
G1 F3600
G1 X145.109 Y120.71 E.00083
G1 X135.572 Y120.71 E.18383
G1 X135.572 Y135.29 E.28104
G1 X145.049 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.152 Y135.29 E-.03914
G1 X145.152 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.352 Y134.49 Z18.12 F60000
G1 Z17.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6530
M204 S4000
G1 X144.352 Y121.57 E.2259
M204 S10000
G1 X143.961 Y122.796 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6530
M204 S4000
G1 X143.961 Y121.482 E.02725
G1 X143.578 Y121.482 E.00795
G3 X143.037 Y123.448 I-2.352 J.411 E.0437
G2 X141.652 Y124.814 I3.934 J5.374 E.04048
G2 X142.095 Y127.09 I2.176 J.758 E.0504
G3 X143.48 Y128.455 I-3.934 J5.374 E.04048
G3 X143.037 Y130.731 I-2.176 J.758 E.0504
G2 X141.652 Y132.097 I3.935 J5.374 E.04048
G2 X142.256 Y134.518 I2.122 J.757 E.05485
G1 X137.913 Y134.518 E.09008
G3 X138.454 Y132.552 I2.352 J-.411 E.0437
G2 X139.838 Y131.186 I-3.935 J-5.374 E.04048
G2 X139.396 Y128.91 I-2.176 J-.758 E.0504
G3 X138.011 Y127.545 I3.934 J-5.374 E.04048
G3 X138.454 Y125.269 I2.176 J-.758 E.0504
G2 X139.838 Y123.903 I-3.935 J-5.375 E.04048
G2 X139.235 Y121.482 I-2.122 J-.757 E.05486
G1 X137.538 Y121.482 E.0352
M204 S10000
G1 X136.372 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6530
M204 S4000
G1 X136.372 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.372 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.824 Y122.439 Z18.12 F60000
G1 X120.019 Y121.119 Z18.12
G1 Z17.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6530
M204 S4000
G1 X111.257 Y121.119 E.18174
G1 X111.257 Y134.881 E.28545
G1 X120.019 Y134.881 E.18174
G1 X120.019 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.428 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.891 Y120.71 E.18383
G1 X110.848 Y120.71 E.00083
G1 F3480
G1 X110.848 Y135.29 E.28104
G1 F3600
G1 X110.891 Y135.29 E.00083
G1 X120.428 Y135.29 E.18383
G1 X120.428 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.428 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.092 Y128.361 Z18.12 F60000
G1 X119.628 Y134.49 Z18.12
G1 Z17.72
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6530
M204 S4000
G1 X119.628 Y121.57 E.2259
M204 S10000
G1 X117.761 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6530
M204 S4000
G1 X116.064 Y134.518 E.0352
G3 X116.605 Y132.552 I2.352 J-.411 E.0437
G2 X117.989 Y131.186 I-3.934 J-5.374 E.04048
G2 X117.546 Y128.91 I-2.176 J-.758 E.0504
G3 X116.162 Y127.545 I3.935 J-5.374 E.04048
G3 X116.605 Y125.269 I2.176 J-.758 E.0504
G2 X117.989 Y123.903 I-3.935 J-5.374 E.04048
G2 X117.385 Y121.482 I-2.122 J-.757 E.05486
G1 X114.445 Y121.482 E.06099
G3 X113.905 Y123.448 I-2.352 J.411 E.0437
G2 X112.52 Y124.814 I3.934 J5.374 E.04048
G2 X112.963 Y127.09 I2.176 J.758 E.0504
G3 X114.348 Y128.455 I-3.934 J5.374 E.04048
G3 X113.905 Y130.731 I-2.176 J.758 E.0504
G2 X112.52 Y132.097 I3.935 J5.374 E.04048
G2 X113.124 Y134.518 I2.122 J.757 E.05485
G1 X114.821 Y134.518 E.0352
M204 S10000
G1 X111.648 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6530
M204 S4000
G1 X111.648 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.84
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X111.648 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L148
M991 S0 P147 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.12 I-.393 J1.152 P1  F60000
G1 X144.827 Y134.881 Z18.12
G1 Z17.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6484
M204 S4000
G1 X144.827 Y121.119 E.28545
G1 X136.065 Y121.119 E.18174
G1 X136.065 Y134.881 E.28545
G1 X144.767 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.193 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.236 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.236 Y120.71 E.28104
G1 F3600
G1 X145.193 Y120.71 E.00083
G1 X135.656 Y120.71 E.18383
G1 X135.656 Y135.29 E.28104
G1 X145.133 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.236 Y135.29 E-.03914
G1 X145.236 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.436 Y134.49 Z18.24 F60000
G1 Z17.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6484
M204 S4000
G1 X144.436 Y121.57 E.2259
M204 S10000
G1 X144.045 Y122.6 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6484
M204 S4000
G1 X144.045 Y121.482 E.0232
G1 X143.466 Y121.482 E.012
G3 X142.679 Y123.903 I-2.299 J.591 E.05574
G2 X141.607 Y125.269 I1.764 J2.488 E.03652
G2 X142.453 Y127.545 I2.499 J.366 E.05254
G3 X143.525 Y128.91 I-1.764 J2.488 E.03652
G3 X142.679 Y131.186 I-2.499 J.366 E.05254
G2 X141.607 Y132.552 I1.764 J2.488 E.03652
G2 X142.173 Y134.518 I2.397 J.375 E.0438
G1 X138.025 Y134.518 E.08605
G3 X138.812 Y132.097 I2.299 J-.591 E.05574
G2 X139.884 Y130.731 I-1.764 J-2.488 E.03652
G2 X139.038 Y128.455 I-2.499 J-.366 E.05254
G3 X137.966 Y127.09 I1.764 J-2.488 E.03652
G3 X138.812 Y124.814 I2.499 J-.366 E.05254
G2 X139.884 Y123.448 I-1.764 J-2.488 E.03652
G2 X139.318 Y121.482 I-2.397 J-.375 E.0438
G1 X137.621 Y121.482 E.0352
M204 S10000
G1 X136.456 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6484
M204 S4000
G1 X136.456 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.456 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.906 Y122.45 Z18.24 F60000
G1 X119.935 Y121.119 Z18.24
G1 Z17.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6484
M204 S4000
G1 X111.173 Y121.119 E.18174
G1 X111.173 Y134.881 E.28545
G1 X119.935 Y134.881 E.18174
G1 X119.935 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.344 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.807 Y120.71 E.18383
G1 X110.764 Y120.71 E.00083
G1 F3480
G1 X110.764 Y135.29 E.28104
G1 F3600
G1 X110.807 Y135.29 E.00083
G1 X120.344 Y135.29 E.18383
G1 X120.344 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.344 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.008 Y128.361 Z18.24 F60000
G1 X119.544 Y134.49 Z18.24
G1 Z17.84
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6484
M204 S4000
G1 X119.544 Y121.57 E.2259
M204 S10000
G1 X117.872 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6484
M204 S4000
G1 X116.175 Y134.518 E.0352
G3 X116.551 Y132.552 I2.191 J-.6 E.04299
G2 X117.85 Y131.186 I-35.429 J-35.002 E.0391
G2 X117.6 Y128.91 I-2.014 J-.93 E.0499
G3 X116.301 Y127.545 I35.416 J-34.99 E.0391
G3 X116.551 Y125.269 I2.014 J-.93 E.0499
G2 X117.85 Y123.903 I-35.415 J-34.989 E.0391
G2 X117.469 Y121.482 I-1.992 J-.927 E.05393
G1 X114.334 Y121.482 E.06502
G3 X113.958 Y123.448 I-2.19 J.6 E.04299
G2 X112.659 Y124.814 I35.429 J35.002 E.0391
G2 X112.909 Y127.09 I2.014 J.93 E.0499
G3 X114.208 Y128.455 I-35.372 J34.948 E.0391
G3 X113.958 Y130.731 I-2.014 J.93 E.0499
G2 X112.659 Y132.097 I35.415 J34.989 E.0391
G2 X113.041 Y134.518 I1.992 J.927 E.05393
G1 X111.955 Y134.518 E.02252
G1 X111.955 Y133.906 E.01268
M204 S10000
G1 X111.564 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6484
M204 S4000
G1 X111.564 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 17.96
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X111.564 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L149
M991 S0 P148 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.24 I-.391 J1.152 P1  F60000
G1 X144.911 Y134.881 Z18.24
G1 Z17.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6462
M204 S4000
G1 X144.911 Y121.119 E.28545
G1 X136.149 Y121.119 E.18174
G1 X136.149 Y134.881 E.28545
G1 X144.851 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.277 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
M73 P88 R2
G1 X145.32 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.32 Y120.71 E.28104
G1 F3600
G1 X145.277 Y120.71 E.00083
G1 X135.74 Y120.71 E.18383
G1 X135.74 Y135.29 E.28104
G1 X145.217 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.32 Y135.29 E-.03914
G1 X145.32 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.52 Y134.49 Z18.36 F60000
G1 Z17.96
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6462
M204 S4000
G1 X144.52 Y121.57 E.2259
M204 S10000
G1 X144.129 Y122.417 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6462
M204 S4000
G1 X144.129 Y121.482 E.01939
G1 X143.367 Y121.482 E.01581
G3 X142.781 Y123.903 I-2.131 J.766 E.05471
G2 X141.696 Y125.269 I2.458 J3.068 E.03649
G2 X142.351 Y127.545 I2.337 J.559 E.05137
G3 X143.437 Y128.91 I-2.458 J3.068 E.03649
G3 X142.781 Y131.186 I-2.337 J.559 E.05137
G2 X141.696 Y132.552 I2.458 J3.068 E.03649
G2 X142.102 Y134.518 I2.254 J.559 E.04306
G1 X138.124 Y134.518 E.0825
G3 X138.71 Y132.097 I2.131 J-.766 E.05471
G2 X139.795 Y130.731 I-2.458 J-3.068 E.03649
G2 X139.139 Y128.455 I-2.337 J-.559 E.05137
G3 X138.054 Y127.09 I2.458 J-3.068 E.03649
G3 X138.71 Y124.814 I2.337 J-.559 E.05137
G2 X139.795 Y123.448 I-2.458 J-3.068 E.03649
G2 X139.389 Y121.482 I-2.254 J-.559 E.04306
G1 X137.692 Y121.482 E.0352
M204 S10000
G1 X136.54 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6462
M204 S4000
G1 X136.54 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.54 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.989 Y122.461 Z18.36 F60000
G1 X119.851 Y121.119 Z18.36
G1 Z17.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6462
M204 S4000
G1 X111.089 Y121.119 E.18174
G1 X111.089 Y134.881 E.28545
G1 X119.851 Y134.881 E.18174
G1 X119.851 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.26 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.723 Y120.71 E.18383
G1 X110.68 Y120.71 E.00083
G1 F3480
G1 X110.68 Y135.29 E.28104
G1 F3600
G1 X110.723 Y135.29 E.00083
G1 X120.26 Y135.29 E.18383
G1 X120.26 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.26 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.924 Y128.361 Z18.36 F60000
G1 X119.46 Y134.49 Z18.36
G1 Z17.96
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6462
M204 S4000
G1 X119.46 Y121.57 E.2259
M204 S10000
G1 X117.972 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6462
M204 S4000
G1 X116.275 Y134.518 E.0352
G3 X116.128 Y133.918 I.961 J-.554 E.01299
G3 X117.329 Y131.642 I2.809 J.028 E.05545
G2 X118.023 Y130.276 I-1.41 J-1.576 E.03252
G2 X116.822 Y128 I-2.809 J.028 E.05545
G3 X116.128 Y126.634 I1.41 J-1.576 E.03252
G3 X117.329 Y124.358 I2.809 J.028 E.05545
G2 X117.54 Y121.482 I-1.418 J-1.55 E.06594
G1 X114.234 Y121.482 E.06857
G3 X114.382 Y122.082 I-.961 J.554 E.013
G3 X113.18 Y124.358 I-2.809 J-.028 E.05545
G2 X112.486 Y125.724 I1.41 J1.576 E.03252
G2 X113.688 Y128 I2.809 J-.028 E.05545
G3 X114.382 Y129.366 I-1.41 J1.576 E.03252
G3 X113.18 Y131.642 I-2.809 J-.028 E.05545
G2 X112.969 Y134.518 I1.418 J1.55 E.06593
G1 X111.871 Y134.518 E.02278
G1 X111.871 Y133.919 E.01242
M204 S10000
G1 X111.48 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6462
M204 S4000
G1 X111.48 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.08
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X111.48 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L150
M991 S0 P149 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.36 I-.389 J1.153 P1  F60000
G1 X144.995 Y134.881 Z18.36
G1 Z18.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X144.995 Y121.119 E.28545
G1 X136.233 Y121.119 E.18174
G1 X136.233 Y134.881 E.28545
G1 X144.935 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.361 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.404 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.404 Y120.71 E.28104
G1 F3600
G1 X145.361 Y120.71 E.00083
G1 X135.824 Y120.71 E.18383
G1 X135.824 Y135.29 E.28104
G1 X145.301 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.404 Y135.29 E-.03914
G1 X145.404 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.604 Y134.49 Z18.48 F60000
G1 Z18.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X144.604 Y121.57 E.2259
M204 S10000
G1 X144.213 Y122.242 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X144.213 Y121.482 E.01576
G1 X143.276 Y121.482 E.01944
G3 X142.438 Y124.358 I-2.239 J.908 E.06703
G2 X142.251 Y127.545 I1.417 J1.682 E.07409
G3 X143.357 Y128.91 I-3.465 J3.937 E.03662
G3 X142.438 Y131.642 I-2.365 J.724 E.06381
G2 X142.028 Y134.518 I1.381 J1.664 E.06608
G1 X138.215 Y134.518 E.07909
G3 X139.053 Y131.642 I2.239 J-.908 E.06703
G2 X139.24 Y128.455 I-1.417 J-1.682 E.07409
G3 X138.134 Y127.09 I3.465 J-3.937 E.03662
G3 X139.053 Y124.358 I2.365 J-.724 E.06381
G2 X139.463 Y121.482 I-1.381 J-1.664 E.06608
G1 X137.766 Y121.482 E.0352
M204 S10000
G1 X136.624 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X136.624 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.624 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.071 Y122.472 Z18.48 F60000
G1 X119.767 Y121.119 Z18.48
G1 Z18.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X111.005 Y121.119 E.18174
G1 X111.005 Y134.881 E.28545
G1 X119.767 Y134.881 E.18174
G1 X119.767 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.176 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.639 Y120.71 E.18383
G1 X110.596 Y120.71 E.00083
G1 F3480
G1 X110.596 Y135.29 E.28104
G1 F3600
G1 X110.639 Y135.29 E.00083
G1 X120.176 Y135.29 E.18383
G1 X120.176 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.176 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.84 Y128.361 Z18.48 F60000
G1 X119.376 Y134.49 Z18.48
G1 Z18.08
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X119.376 Y121.57 E.2259
M204 S10000
G1 X118.063 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X116.366 Y134.518 E.0352
G3 X117.204 Y131.642 I2.239 J-.908 E.06703
G2 X117.391 Y128.455 I-1.417 J-1.682 E.07409
G3 X116.285 Y127.09 I3.465 J-3.937 E.03662
G3 X117.204 Y124.358 I2.365 J-.724 E.06381
G2 X117.614 Y121.482 I-1.381 J-1.664 E.06608
G1 X114.144 Y121.482 E.07198
G3 X113.305 Y124.358 I-2.239 J.908 E.06703
G2 X113.119 Y127.545 I1.417 J1.682 E.07409
G3 X114.225 Y128.91 I-3.465 J3.937 E.03662
G3 X113.305 Y131.642 I-2.365 J.724 E.06381
G2 X112.896 Y134.518 I1.381 J1.664 E.06608
G1 X111.787 Y134.518 E.02299
G1 X111.787 Y133.929 E.01221
M204 S10000
G1 X111.396 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X111.396 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.2
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X111.396 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L151
M991 S0 P150 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.48 I-.387 J1.154 P1  F60000
G1 X145.079 Y134.881 Z18.48
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X145.079 Y121.119 E.28545
G1 X136.317 Y121.119 E.18174
G1 X136.317 Y134.881 E.28545
G1 X145.019 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.445 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.488 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.488 Y120.71 E.28104
G1 F3600
G1 X145.445 Y120.71 E.00083
G1 X135.908 Y120.71 E.18383
G1 X135.908 Y135.29 E.28104
G1 X145.385 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.488 Y135.29 E-.03914
G1 X145.488 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.688 Y134.49 Z18.6 F60000
G1 Z18.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X144.688 Y121.57 E.2259
M204 S10000
G1 X143.647 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X141.95 Y134.518 E.0352
G3 X142.558 Y131.642 I1.962 J-1.088 E.06649
G2 X142.574 Y128 I-1.384 J-1.827 E.0873
G3 X142.558 Y124.358 I1.384 J-1.827 E.0873
M73 P89 R2
G2 X143.192 Y121.482 I-1.351 J-1.806 E.06657
G1 X139.54 Y121.482 E.07575
G3 X138.932 Y124.358 I-1.962 J1.088 E.0665
G2 X138.917 Y128 I1.384 J1.827 E.0873
G3 X138.932 Y131.642 I-1.384 J1.827 E.0873
G2 X138.298 Y134.518 I1.351 J1.806 E.06657
G1 X137.099 Y134.518 E.02488
G1 X137.099 Y134.02 E.01032
M204 S10000
G1 X136.708 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X136.708 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.708 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.154 Y122.483 Z18.6 F60000
G1 X119.683 Y121.119 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X110.921 Y121.119 E.18174
G1 X110.921 Y134.881 E.28545
G1 X119.683 Y134.881 E.18174
G1 X119.683 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.092 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.555 Y120.71 E.18383
G1 X110.512 Y120.71 E.00083
G1 F3480
G1 X110.512 Y135.29 E.28104
G1 F3600
G1 X110.555 Y135.29 E.00083
G1 X120.092 Y135.29 E.18383
G1 X120.092 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.092 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.756 Y128.361 Z18.6 F60000
G1 X119.292 Y134.49 Z18.6
G1 Z18.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X119.292 Y121.57 E.2259
M204 S10000
G1 X118.146 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6448
M204 S4000
G1 X116.449 Y134.518 E.0352
G3 X117.083 Y131.642 I1.985 J-1.07 E.06657
G2 X117.068 Y128 I-1.399 J-1.815 E.0873
G3 X117.083 Y124.358 I1.399 J-1.815 E.0873
G2 X117.691 Y121.482 I-1.354 J-1.789 E.0665
G1 X114.06 Y121.482 E.07532
G3 X113.426 Y124.358 I-1.985 J1.07 E.06657
G2 X113.442 Y128 I1.399 J1.815 E.0873
G3 X113.426 Y131.642 I-1.399 J1.815 E.0873
G2 X112.818 Y134.518 I1.354 J1.789 E.06649
G1 X111.703 Y134.518 E.02313
G1 X111.703 Y133.936 E.01207
M204 S10000
G1 X111.312 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6448
M204 S4000
G1 X111.312 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.32
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X111.312 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L152
M991 S0 P151 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.6 I-.386 J1.154 P1  F60000
G1 X145.163 Y134.881 Z18.6
G1 Z18.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X145.163 Y121.119 E.28545
G1 X136.401 Y121.119 E.18174
G1 X136.401 Y134.881 E.28545
G1 X145.103 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.529 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.572 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.572 Y120.71 E.28104
G1 F3600
G1 X145.529 Y120.71 E.00083
G1 X135.992 Y120.71 E.18383
G1 X135.992 Y135.29 E.28104
G1 X145.469 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.572 Y135.29 E-.03914
G1 X145.572 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.772 Y134.49 Z18.72 F60000
G1 Z18.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X144.772 Y121.57 E.2259
M204 S10000
G1 X143.565 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X141.868 Y134.518 E.0352
G3 X142.679 Y131.642 I2.206 J-.93 E.06694
G2 X142.895 Y128.455 I-1.409 J-1.696 E.07408
G3 X141.785 Y127.09 I3.634 J-4.085 E.03665
G3 X142.679 Y124.358 I2.332 J-.749 E.0637
G2 X143.114 Y121.482 I-1.377 J-1.68 E.06612
G1 X139.623 Y121.482 E.07242
G3 X138.812 Y124.358 I-2.206 J.93 E.06694
G2 X138.596 Y127.545 I1.409 J1.696 E.07408
G3 X139.706 Y128.91 I-3.634 J4.085 E.03665
G3 X138.812 Y131.642 I-2.332 J.749 E.0637
G2 X138.376 Y134.518 I1.377 J1.68 E.06612
G1 X137.183 Y134.518 E.02476
G1 X137.183 Y134.014 E.01044
M204 S10000
G1 X136.792 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X136.792 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.792 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.236 Y122.493 Z18.72 F60000
G1 X119.599 Y121.119 Z18.72
G1 Z18.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X110.837 Y121.119 E.18174
G1 X110.837 Y134.881 E.28545
G1 X119.599 Y134.881 E.18174
G1 X119.599 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X120.008 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.471 Y120.71 E.18383
G1 X110.428 Y120.71 E.00083
G1 F3480
G1 X110.428 Y135.29 E.28104
G1 F3600
G1 X110.471 Y135.29 E.00083
G1 X120.008 Y135.29 E.18383
G1 X120.008 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X118.008 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.817 Y122.136 Z18.72 F60000
G1 Z18.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X118.817 Y121.482 E.01356
G1 X117.774 Y121.482 E.02164
G3 X116.963 Y124.358 I-2.206 J.93 E.06694
G2 X116.747 Y127.545 I1.409 J1.696 E.07408
G3 X117.856 Y128.91 I-3.634 J4.085 E.03665
G3 X116.963 Y131.642 I-2.332 J.749 E.0637
G2 X116.527 Y134.518 I1.377 J1.68 E.06612
G1 X112.735 Y134.518 E.07865
G3 X113.547 Y131.642 I2.206 J-.93 E.06694
G2 X113.762 Y128.455 I-1.409 J-1.696 E.07408
G3 X112.653 Y127.09 I3.634 J-4.085 E.03665
G3 X113.547 Y124.358 I2.332 J-.749 E.0637
G2 X113.982 Y121.482 I-1.377 J-1.68 E.06612
G1 X112.285 Y121.482 E.0352
M204 S10000
G1 X111.228 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X111.228 Y121.57 E.2259
M204 S10000
G1 X119.208 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6456
M204 S4000
G1 X119.208 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.44
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X119.208 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L153
M991 S0 P152 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.72 I-.485 J1.116 P1  F60000
G1 X145.247 Y134.881 Z18.72
G1 Z18.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X145.247 Y121.119 E.28545
G1 X136.485 Y121.119 E.18174
G1 X136.485 Y134.881 E.28545
G1 X145.187 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.613 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.656 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.656 Y120.71 E.28104
G1 F3600
G1 X145.613 Y120.71 E.00083
G1 X136.076 Y120.71 E.18383
G1 X136.076 Y135.29 E.28104
G1 X145.553 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.656 Y135.29 E-.03914
G1 X145.656 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.856 Y134.49 Z18.84 F60000
G1 Z18.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X144.856 Y121.57 E.2259
M204 S10000
G1 X143.475 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X141.778 Y134.518 E.0352
G3 X141.624 Y133.918 I.966 J-.567 E.01302
G3 X142.803 Y131.642 I2.778 J-.004 E.05526
G2 X143.508 Y130.276 I-1.436 J-1.606 E.03259
G2 X142.329 Y128 I-2.778 J-.004 E.05526
G3 X141.624 Y126.634 I1.436 J-1.606 E.03259
G3 X142.803 Y124.358 I2.778 J-.004 E.05526
G2 X143.04 Y121.482 I-1.413 J-1.564 E.06594
G1 X139.713 Y121.482 E.06902
G3 X139.866 Y122.082 I-.966 J.567 E.01303
G3 X138.688 Y124.358 I-2.778 J.004 E.05526
G2 X137.983 Y125.724 I1.437 J1.606 E.03259
G2 X139.162 Y128 I2.778 J.004 E.05526
G3 X139.866 Y129.366 I-1.436 J1.606 E.03259
G3 X138.688 Y131.642 I-2.778 J.004 E.05526
G2 X138.451 Y134.518 I1.413 J1.564 E.06594
G1 X137.267 Y134.518 E.02455
G1 X137.267 Y134.004 E.01065
M204 S10000
G1 X136.876 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X136.876 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.876 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.319 Y122.503 Z18.84 F60000
G1 X119.515 Y121.119 Z18.84
G1 Z18.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X110.753 Y121.119 E.18174
G1 X110.753 Y134.881 E.28545
G1 X119.515 Y134.881 E.18174
G1 X119.515 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.924 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.387 Y120.71 E.18383
G1 X110.344 Y120.71 E.00083
G1 F3480
G1 X110.344 Y135.29 E.28104
G1 F3600
G1 X110.387 Y135.29 E.00083
G1 X119.924 Y135.29 E.18383
G1 X119.924 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.924 Y120.757 E-.76
; WIPE_END
M73 P90 R2
G1 E-.04 F1800
M204 S10000
G1 X118.733 Y122.31 Z18.84 F60000
G1 Z18.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6456
M204 S4000
G1 X118.733 Y121.482 E.01716
G1 X117.863 Y121.482 E.01804
G3 X117.303 Y123.903 I-2.111 J.787 E.0546
G2 X116.216 Y125.269 I2.567 J3.161 E.0365
G2 X116.847 Y127.545 I2.317 J.583 E.05125
G3 X117.935 Y128.91 I-2.568 J3.161 E.0365
G3 X117.303 Y131.186 I-2.317 J.583 E.05125
G2 X116.216 Y132.552 I2.567 J3.161 E.0365
G2 X116.601 Y134.518 I2.236 J.582 E.04298
G1 X112.646 Y134.518 E.08205
G3 X113.206 Y132.097 I2.111 J-.787 E.0546
G2 X114.294 Y130.731 I-2.567 J-3.161 E.0365
G2 X113.662 Y128.455 I-2.317 J-.583 E.05125
G3 X112.574 Y127.09 I2.567 J-3.161 E.0365
G3 X113.206 Y124.814 I2.317 J-.583 E.05125
G2 X114.294 Y123.448 I-2.567 J-3.161 E.0365
G2 X113.908 Y121.482 I-2.236 J-.582 E.04298
G1 X112.211 Y121.482 E.0352
M204 S10000
G1 X111.144 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6456
M204 S4000
G1 X111.144 Y121.57 E.2259
M204 S10000
G1 X119.124 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6456
M204 S4000
G1 X119.124 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.56
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X119.124 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L154
M991 S0 P153 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.84 I-.482 J1.117 P1  F60000
G1 X145.331 Y134.881 Z18.84
G1 Z18.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6479
M204 S4000
G1 X145.331 Y121.119 E.28545
G1 X136.569 Y121.119 E.18174
G1 X136.569 Y134.881 E.28545
G1 X145.271 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.697 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.74 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.74 Y120.71 E.28104
G1 F3600
G1 X145.697 Y120.71 E.00083
G1 X136.16 Y120.71 E.18383
G1 X136.16 Y135.29 E.28104
G1 X145.637 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.74 Y135.29 E-.03914
G1 X145.74 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.94 Y134.49 Z18.96 F60000
G1 Z18.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6479
M204 S4000
G1 X144.94 Y121.57 E.2259
M204 S10000
G1 X143.377 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6479
M204 S4000
G1 X141.68 Y134.518 E.0352
G3 X141.629 Y133.462 I1.919 J-.622 E.02218
G3 X142.936 Y131.642 I3.675 J1.259 E.04716
G2 X143.504 Y129.821 I-1.215 J-1.378 E.0416
G2 X142.197 Y128 I-3.675 J1.259 E.04716
G3 X141.629 Y126.179 I1.215 J-1.378 E.0416
G3 X142.936 Y124.358 I3.675 J1.259 E.04716
G2 X142.969 Y121.482 I-1.419 J-1.455 E.06629
G1 X139.811 Y121.482 E.0655
G3 X139.862 Y122.538 I-1.92 J.622 E.02218
G3 X138.555 Y124.358 I-3.675 J-1.259 E.04716
G2 X137.987 Y126.179 I1.215 J1.378 E.0416
G2 X139.294 Y128 I3.675 J-1.259 E.04716
G3 X139.862 Y129.821 I-1.215 J1.378 E.0416
G3 X138.555 Y131.642 I-3.675 J-1.259 E.04716
G2 X138.522 Y134.518 I1.419 J1.455 E.06629
G1 X137.351 Y134.518 E.02429
G1 X137.351 Y133.992 E.01091
M204 S10000
G1 X136.96 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6479
M204 S4000
G1 X136.96 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X136.96 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.401 Y122.513 Z18.96 F60000
G1 X119.431 Y121.119 Z18.96
G1 Z18.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6479
M204 S4000
G1 X110.669 Y121.119 E.18174
G1 X110.669 Y134.881 E.28545
G1 X119.431 Y134.881 E.18174
G1 X119.431 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.84 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.303 Y120.71 E.18383
G1 X110.26 Y120.71 E.00083
G1 F3480
G1 X110.26 Y135.29 E.28104
G1 F3600
G1 X110.303 Y135.29 E.00083
G1 X119.84 Y135.29 E.18383
G1 X119.84 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.84 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.649 Y122.492 Z18.96 F60000
G1 Z18.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6479
M204 S4000
G1 X118.649 Y121.482 E.02095
G1 X117.962 Y121.482 E.01425
G3 X117.202 Y123.903 I-2.276 J.616 E.05558
G2 X116.129 Y125.269 I1.843 J2.553 E.0365
G2 X116.949 Y127.545 I2.477 J.393 E.05236
G3 X118.022 Y128.91 I-1.843 J2.553 E.0365
G3 X117.202 Y131.186 I-2.477 J.393 E.05236
G2 X116.129 Y132.552 I1.843 J2.553 E.0365
G2 X116.673 Y134.518 I2.377 J.4 E.04369
G1 X112.547 Y134.518 E.08557
G3 X113.307 Y132.097 I2.276 J-.615 E.05558
G2 X114.381 Y130.731 I-1.843 J-2.553 E.0365
G2 X113.56 Y128.455 I-2.477 J-.393 E.05236
G3 X112.487 Y127.09 I1.843 J-2.553 E.0365
G3 X113.307 Y124.814 I2.477 J-.393 E.05236
G2 X114.381 Y123.448 I-1.843 J-2.553 E.0365
G2 X113.836 Y121.482 I-2.377 J-.4 E.04369
G1 X112.139 Y121.482 E.0352
M204 S10000
G1 X111.06 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6479
M204 S4000
G1 X111.06 Y121.57 E.2259
M204 S10000
G1 X119.04 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6479
M204 S4000
G1 X119.04 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.68
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X119.04 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L155
M991 S0 P154 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z18.96 I-.48 J1.118 P1  F60000
G1 X145.415 Y134.881 Z18.96
G1 Z18.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6517
M204 S4000
G1 X145.415 Y121.119 E.28545
M73 P90 R1
G1 X136.653 Y121.119 E.18174
G1 X136.653 Y134.881 E.28545
G1 X145.355 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.781 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.824 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.824 Y120.71 E.28104
G1 F3600
G1 X145.781 Y120.71 E.00083
G1 X136.244 Y120.71 E.18383
G1 X136.244 Y135.29 E.28104
G1 X145.721 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.824 Y135.29 E-.03914
G1 X145.824 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.024 Y134.49 Z19.08 F60000
G1 Z18.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6517
M204 S4000
G1 X145.024 Y121.57 E.2259
M204 S10000
G1 X143.267 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6517
M204 S4000
G1 X141.57 Y134.518 E.0352
G3 X142.089 Y132.552 I2.327 J-.438 E.04359
G2 X143.461 Y131.186 I-4.249 J-5.642 E.04028
G2 X143.044 Y128.91 I-2.151 J-.782 E.05032
G3 X141.672 Y127.545 I4.249 J-5.642 E.04028
G3 X142.089 Y125.269 I2.151 J-.782 E.05032
G2 X143.461 Y123.903 I-4.249 J-5.642 E.04028
G2 X142.885 Y121.482 I-2.096 J-.781 E.05474
G1 X139.921 Y121.482 E.06149
G3 X139.402 Y123.448 I-2.327 J.438 E.04359
G2 X138.03 Y124.814 I4.249 J5.642 E.04028
G2 X138.447 Y127.09 I2.151 J.782 E.05032
G3 X139.819 Y128.455 I-4.249 J5.642 E.04028
G3 X139.402 Y130.731 I-2.151 J.782 E.05032
G2 X138.03 Y132.097 I4.249 J5.642 E.04028
G2 X138.606 Y134.518 I2.096 J.781 E.05474
G1 X137.435 Y134.518 E.02428
G1 X137.435 Y133.991 E.01092
M204 S10000
G1 X137.044 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6517
M204 S4000
G1 X137.044 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.044 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.484 Y122.523 Z19.08 F60000
G1 X119.347 Y121.119 Z19.08
G1 Z18.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6517
M204 S4000
G1 X110.585 Y121.119 E.18174
G1 X110.585 Y134.881 E.28545
G1 X119.347 Y134.881 E.18174
G1 X119.347 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.756 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.219 Y120.71 E.18383
G1 X110.176 Y120.71 E.00083
G1 F3480
G1 X110.176 Y135.29 E.28104
G1 F3600
G1 X110.219 Y135.29 E.00083
G1 X119.756 Y135.29 E.18383
G1 X119.756 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.756 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.565 Y122.686 Z19.08 F60000
G1 Z18.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6517
M204 S4000
G1 X118.565 Y121.482 E.02496
G1 X118.072 Y121.482 E.01024
G3 X117.553 Y123.448 I-2.327 J.438 E.04359
G2 X116.181 Y124.814 I4.249 J5.642 E.04028
G2 X116.598 Y127.09 I2.151 J.782 E.05032
G3 X117.97 Y128.455 I-4.249 J5.642 E.04028
G3 X117.553 Y130.731 I-2.151 J.782 E.05032
G2 X116.181 Y132.097 I4.25 J5.643 E.04028
G2 X116.756 Y134.518 I2.096 J.781 E.05474
G1 X112.438 Y134.518 E.08958
G3 X112.956 Y132.552 I2.327 J-.438 E.04359
G2 X114.328 Y131.186 I-4.249 J-5.642 E.04028
G2 X113.912 Y128.91 I-2.151 J-.782 E.05032
G3 X112.539 Y127.545 I4.249 J-5.642 E.04028
G3 X112.956 Y125.269 I2.151 J-.782 E.05032
G2 X114.328 Y123.903 I-4.249 J-5.642 E.04028
G2 X113.753 Y121.482 I-2.096 J-.781 E.05474
G1 X112.056 Y121.482 E.0352
M204 S10000
G1 X110.976 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6517
M204 S4000
G1 X110.976 Y121.57 E.2259
M204 S10000
G1 X118.956 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6517
M204 S4000
G1 X118.956 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.8
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X118.956 Y123.57 E-.76
; WIPE_END
M73 P91 R1
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L156
M991 S0 P155 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.08 I-.477 J1.12 P1  F60000
G1 X145.499 Y134.881 Z19.08
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6574
M204 S4000
G1 X145.499 Y121.119 E.28545
G1 X136.737 Y121.119 E.18174
G1 X136.737 Y134.881 E.28545
G1 X145.439 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.865 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.908 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.908 Y120.71 E.28104
G1 F3600
G1 X145.865 Y120.71 E.00083
G1 X136.328 Y120.71 E.18383
G1 X136.328 Y135.29 E.28104
G1 X145.805 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.908 Y135.29 E-.03914
G1 X145.908 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.108 Y134.49 Z19.2 F60000
G1 Z18.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6574
M204 S4000
G1 X145.108 Y121.57 E.2259
M204 S10000
G1 X143.143 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6574
M204 S4000
G1 X141.446 Y134.518 E.0352
G3 X142.139 Y132.552 I2.546 J-.207 E.04454
G1 X143.256 Y131.642 E.02988
G1 X143.618 Y131.186 E.01207
G2 X142.993 Y128.91 I-2.382 J-.57 E.05108
G1 X141.877 Y128 E.02988
G1 X141.514 Y127.545 E.01207
G3 X142.139 Y125.269 I2.382 J-.57 E.05108
G1 X143.256 Y124.358 E.02988
G1 X143.618 Y123.903 E.01207
G2 X142.815 Y121.482 I-2.312 J-.577 E.05583
G1 X140.045 Y121.482 E.05746
G3 X139.351 Y123.448 I-2.546 J.207 E.04454
G1 X138.235 Y124.358 E.02988
G1 X137.873 Y124.814 E.01207
G2 X138.498 Y127.09 I2.382 J.57 E.05108
G1 X139.614 Y128 E.02988
G1 X139.977 Y128.455 E.01207
G3 X139.351 Y130.731 I-2.382 J.57 E.05108
G1 X138.235 Y131.642 E.02988
G1 X137.873 Y132.097 E.01207
G2 X138.676 Y134.518 I2.312 J.577 E.05583
G1 X140.373 Y134.518 E.0352
M204 S10000
G1 X137.128 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6574
M204 S4000
G1 X137.128 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.128 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.567 Y122.533 Z19.2 F60000
G1 X119.263 Y121.119 Z19.2
G1 Z18.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6574
M204 S4000
G1 X110.501 Y121.119 E.18174
G1 X110.501 Y134.881 E.28545
G1 X119.263 Y134.881 E.18174
G1 X119.263 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.672 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.135 Y120.71 E.18383
G1 X110.092 Y120.71 E.00083
G1 F3480
G1 X110.092 Y135.29 E.28104
G1 F3600
G1 X110.135 Y135.29 E.00083
G1 X119.672 Y135.29 E.18383
G1 X119.672 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.672 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.499 Y121.482 Z19.2 F60000
G1 Z18.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6574
M204 S4000
G1 X118.196 Y121.482 E.0352
G3 X117.502 Y123.448 I-2.546 J.207 E.04454
G1 X116.386 Y124.358 E.02988
G2 X115.96 Y125.724 I.967 J1.05 E.03107
G2 X116.649 Y127.09 I2.948 J-.629 E.03207
G1 X117.765 Y128 E.02988
G3 X118.19 Y129.366 I-.967 J1.05 E.03107
G3 X117.502 Y130.731 I-2.948 J-.629 E.03207
G1 X116.386 Y131.642 E.02988
G2 X115.96 Y133.007 I.967 J1.05 E.03107
G2 X116.827 Y134.518 I2.552 J-.459 E.03684
G1 X112.314 Y134.518 E.09361
G3 X113.007 Y132.552 I2.546 J-.207 E.04454
G1 X114.124 Y131.642 E.02988
G2 X114.549 Y130.276 I-.967 J-1.05 E.03107
G2 X113.861 Y128.91 I-2.948 J.629 E.03207
G1 X112.744 Y128 E.02988
G3 X112.319 Y126.634 I.967 J-1.05 E.03107
G3 X113.007 Y125.269 I2.948 J.629 E.03207
G1 X114.124 Y124.358 E.02988
G2 X114.549 Y122.993 I-.967 J-1.05 E.03107
G2 X113.683 Y121.482 I-2.552 J.46 E.03684
G1 X111.986 Y121.482 E.0352
M204 S10000
G1 X110.892 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6574
M204 S4000
G1 X110.892 Y121.57 E.2259
M204 S10000
G1 X118.872 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6574
M204 S4000
G1 X118.872 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 18.92
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X118.872 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L157
M991 S0 P156 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.2 I-.475 J1.121 P1  F60000
G1 X145.583 Y134.881 Z19.2
G1 Z18.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6647
M204 S4000
G1 X145.583 Y121.119 E.28545
G1 X136.821 Y121.119 E.18174
G1 X136.821 Y134.881 E.28545
G1 X145.523 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X145.949 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X145.992 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X145.992 Y120.71 E.28104
G1 F3600
G1 X145.949 Y120.71 E.00083
G1 X136.412 Y120.71 E.18383
G1 X136.412 Y135.29 E.28104
G1 X145.889 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X145.992 Y135.29 E-.03914
G1 X145.992 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.192 Y134.49 Z19.32 F60000
G1 Z18.92
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6647
M204 S4000
G1 X145.192 Y121.57 E.2259
M204 S10000
G1 X142.999 Y134.518 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6647
M204 S4000
G1 X141.302 Y134.518 E.0352
G3 X142.188 Y132.552 I2.769 J.065 E.04594
G1 X143.474 Y131.642 E.03269
G1 X143.806 Y131.186 E.01168
G2 X142.945 Y128.91 I-2.71 J-.276 E.05232
G1 X141.659 Y128 E.03269
G1 X141.327 Y127.545 E.01168
G3 X142.188 Y125.269 I2.71 J-.276 E.05232
G1 X143.474 Y124.358 E.03269
G1 X143.806 Y123.903 E.01168
G2 X142.74 Y121.482 I-2.697 J-.258 E.05733
G1 X140.188 Y121.482 E.05292
G3 X139.303 Y123.448 I-2.769 J-.065 E.04594
G1 X138.017 Y124.358 E.03269
G1 X137.685 Y124.814 E.01168
G2 X138.546 Y127.09 I2.71 J.276 E.05232
G1 X139.832 Y128 E.03269
G1 X140.164 Y128.455 E.01168
G3 X139.303 Y130.731 I-2.71 J.276 E.05233
G1 X138.017 Y131.642 E.03269
G1 X137.685 Y132.097 E.01168
G2 X138.751 Y134.518 I2.697 J.258 E.05733
G1 X140.448 Y134.518 E.0352
M204 S10000
G1 X137.212 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F6647
M204 S4000
G1 X137.212 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.212 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.649 Y122.542 Z19.32 F60000
G1 X119.179 Y121.119 Z19.32
G1 Z18.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6647
M204 S4000
G1 X110.417 Y121.119 E.18174
G1 X110.417 Y134.881 E.28545
G1 X119.179 Y134.881 E.18174
G1 X119.179 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.588 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X110.051 Y120.71 E.18383
G1 X110.008 Y120.71 E.00083
G1 F3480
G1 X110.008 Y135.29 E.28104
G1 F3600
G1 X110.051 Y135.29 E.00083
G1 X119.588 Y135.29 E.18383
G1 X119.588 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.588 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.642 Y121.482 Z19.32 F60000
G1 Z18.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6647
M204 S4000
G1 X118.339 Y121.482 E.0352
G1 X118.351 Y121.627 E.00302
G3 X117.454 Y123.448 I-3.077 J-.384 E.04289
G1 X116.168 Y124.358 E.03269
G1 X115.836 Y124.814 E.01168
G1 X115.8 Y125.269 E.00947
G2 X116.697 Y127.09 I3.077 J-.384 E.04289
G1 X117.983 Y128 E.03269
G1 X118.315 Y128.455 E.01168
G1 X118.351 Y128.91 E.00947
G3 X117.454 Y130.731 I-3.077 J-.384 E.04289
G1 X116.168 Y131.642 E.03269
G1 X115.836 Y132.097 E.01168
G1 X115.8 Y132.552 E.00947
G2 X116.902 Y134.518 I2.792 J-.273 E.0481
G1 X112.17 Y134.518 E.09815
G1 X112.159 Y134.373 E.00302
G3 X113.055 Y132.552 I3.077 J.384 E.04289
G1 X114.342 Y131.642 E.03269
G1 X114.673 Y131.186 E.01168
G1 X114.709 Y130.731 E.00947
G2 X113.812 Y128.91 I-3.077 J.384 E.04289
G1 X112.526 Y128 E.03269
G1 X112.194 Y127.545 E.01168
G1 X112.159 Y127.09 E.00947
G3 X113.055 Y125.269 I3.077 J.384 E.04289
G1 X114.342 Y124.358 E.03269
G1 X114.673 Y123.903 E.01168
G1 X114.709 Y123.448 E.00947
G2 X113.607 Y121.482 I-2.792 J.273 E.04811
G1 X111.91 Y121.482 E.0352
M204 S10000
G1 X110.808 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F6647
M204 S4000
G1 X110.808 Y121.57 E.2259
M204 S10000
G1 X118.788 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F6647
M204 S4000
G1 X118.788 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 19.04
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F8640
G1 X118.788 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L158
M991 S0 P157 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.32 I-.472 J1.122 P1  F60000
G1 X145.667 Y134.881 Z19.32
G1 Z19.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7357
M204 S4000
G1 X145.667 Y121.119 E.28545
G1 X136.905 Y121.119 E.18174
G1 X136.905 Y134.881 E.28545
G1 X145.607 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.033 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.076 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.076 Y120.71 E.28104
G1 F3600
G1 X146.033 Y120.71 E.00083
G1 X136.496 Y120.71 E.18383
G1 X136.496 Y135.29 E.28104
G1 X145.973 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.076 Y135.29 E-.03914
G1 X146.076 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P92 R1
G1 X145.276 Y134.49 Z19.44 F60000
G1 Z19.04
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7357
M204 S4000
G1 X145.276 Y121.57 E.2259
M204 S10000
G1 X144.885 Y122.832 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7357
M204 S4000
G1 X144.885 Y124.529 E.0352
G1 X144.732 Y124.814 E.0067
G2 X144.885 Y125.514 I1.585 J.021 E.01501
G1 X144.885 Y131.812 E.13063
G1 X144.732 Y132.097 E.0067
G3 X144.885 Y134.518 I-7.555 J1.692 E.05053
G1 X141.132 Y134.518 E.07785
G1 X141.151 Y134.373 E.00304
G3 X142.952 Y132.097 I3.208 J.688 E.06236
G1 X143.797 Y131.642 E.01992
G1 X144.042 Y131.186 E.01072
G2 X142.18 Y128.455 I-3.289 J.242 E.07181
G1 X141.335 Y128 E.01992
G1 X141.091 Y127.545 E.01072
G3 X142.952 Y124.814 I3.289 J.242 E.07181
G1 X143.797 Y124.358 E.01992
G1 X144.042 Y123.903 E.01072
G2 X142.67 Y121.482 I-3.186 J.206 E.05973
G1 X140.359 Y121.482 E.04792
G1 X140.34 Y121.627 E.00304
G3 X138.539 Y123.903 I-3.208 J-.688 E.06236
G1 X137.687 Y124.371 E.02015
G1 X137.687 Y125.741 E.02842
G2 X139.31 Y127.545 I2.86 J-.94 E.05182
G1 X140.156 Y128 E.01992
G1 X140.4 Y128.455 E.01072
G3 X138.539 Y131.186 I-3.289 J-.242 E.07181
G1 X137.687 Y131.654 E.02016
G1 X137.687 Y133.024 E.02842
G2 X138.821 Y134.518 I2.423 J-.662 E.03988
G1 X140.518 Y134.518 E.0352
M204 S10000
G1 X137.296 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7357
M204 S4000
G1 X137.296 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.296 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.732 Y122.552 Z19.44 F60000
G1 X119.095 Y121.119 Z19.44
G1 Z19.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7357
M204 S4000
G1 X110.333 Y121.119 E.18174
G1 X110.333 Y134.881 E.28545
G1 X119.095 Y134.881 E.18174
G1 X119.095 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.504 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.967 Y120.71 E.18383
G1 X109.924 Y120.71 E.00083
G1 F3480
G1 X109.924 Y135.29 E.28104
G1 F3600
G1 X109.967 Y135.29 E.00083
G1 X119.504 Y135.29 E.18383
G1 X119.504 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.504 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.233 Y121.482 Z19.44 F60000
G1 Z19.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7357
M204 S4000
G1 X118.313 Y121.482 E.0224
G3 X117.857 Y122.993 I-1.977 J.227 E.03366
G3 X115.844 Y124.358 I-4.636 J-4.667 E.05074
G1 X115.6 Y124.814 E.01072
G2 X116.294 Y126.634 I4.402 J-.636 E.04075
G2 X118.307 Y128 I4.636 J-4.667 E.05074
G1 X118.313 Y129.382 E.02867
G3 X117.857 Y130.276 I-2.334 J-.628 E.02097
G3 X115.844 Y131.642 I-4.636 J-4.667 E.05074
G1 X115.6 Y132.097 E.01072
G2 X116.972 Y134.518 I3.186 J-.206 E.05973
G1 X111.999 Y134.518 E.10314
G3 X112.653 Y133.007 I4.929 J1.235 E.03429
G3 X114.665 Y131.642 I4.636 J4.667 E.05074
G1 X114.909 Y131.186 E.01072
G2 X114.215 Y129.366 I-4.402 J.636 E.04075
G2 X112.203 Y128 I-4.636 J4.667 E.05074
G1 X111.958 Y127.545 E.01072
G3 X112.653 Y125.724 I4.403 J.636 E.04075
G3 X114.665 Y124.358 I4.636 J4.667 E.05074
G1 X114.909 Y123.903 E.01072
G2 X113.537 Y121.482 I-3.186 J.206 E.05973
G1 X111.227 Y121.482 E.04792
G3 X111.115 Y121.873 I-.898 J-.045 E.00851
G1 X111.115 Y128.171 E.13063
G1 X111.268 Y128.455 E.0067
G3 X111.115 Y129.156 I-1.586 J.021 E.01501
G1 X111.115 Y130.853 E.0352
M204 S10000
G1 X110.724 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7357
M204 S4000
G1 X110.724 Y121.57 E.2259
M204 S10000
G1 X118.704 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7357
M204 S4000
G1 X118.704 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 19.16
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X118.704 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L159
M991 S0 P158 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.44 I-.47 J1.123 P1  F60000
G1 X145.751 Y134.881 Z19.44
G1 Z19.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7347
M204 S4000
G1 X145.751 Y121.119 E.28545
G1 X136.989 Y121.119 E.18174
G1 X136.989 Y134.881 E.28545
G1 X145.691 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.117 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.16 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.16 Y120.71 E.28104
G1 F3600
G1 X146.117 Y120.71 E.00083
G1 X136.58 Y120.71 E.18383
G1 X136.58 Y135.29 E.28104
G1 X146.057 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.16 Y135.29 E-.03914
G1 X146.16 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.36 Y134.49 Z19.56 F60000
G1 Z19.16
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7347
M204 S4000
G1 X145.36 Y121.57 E.2259
M204 S10000
G1 X144.969 Y122.375 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7347
M204 S4000
G1 X144.969 Y124.072 E.0352
G1 X144.842 Y124.1 E.00269
G1 X144.387 Y123.923 E.01013
G2 X143.021 Y121.752 I-6.019 J2.27 E.05356
G1 X142.615 Y121.482 E.01012
G1 X140.586 Y121.482 E.0421
G3 X139.38 Y123.323 I-5.33 J-2.175 E.04593
G3 X137.771 Y124.053 I-3.041 J-4.566 E.0368
G1 X137.771 Y126.09 E.04224
G2 X139.835 Y127.641 I2.833 J-1.621 E.05506
G2 X140.745 Y127.565 I.398 J-.722 E.02008
G3 X142.111 Y125.394 I6.019 J2.27 E.05356
G3 X143.932 Y124.617 I2.956 J4.408 E.0413
G1 X144.387 Y124.793 E.01013
G2 X144.969 Y125.947 I6.965 J-2.792 E.02683
G1 X144.969 Y131.355 E.11218
G1 X144.842 Y131.383 E.00269
G1 X144.387 Y131.207 E.01013
G2 X143.021 Y129.035 I-6.019 J2.27 E.05356
G2 X141.201 Y128.259 I-2.956 J4.408 E.0413
G1 X140.745 Y128.435 E.01013
G3 X139.38 Y130.606 I-6.019 J-2.27 E.05356
G3 X137.771 Y131.336 I-3.042 J-4.567 E.0368
G1 X137.771 Y133.373 E.04224
G2 X138.875 Y134.518 I2.649 J-1.45 E.0334
G1 X140.814 Y134.518 E.04022
G2 X141.656 Y133.144 I-24.531 J-15.965 E.03343
G3 X143.932 Y131.9 I2.879 J2.565 E.05486
G1 X144.387 Y132.077 E.01013
G2 X144.969 Y133.23 I6.967 J-2.793 E.02683
G1 X144.969 Y134.518 E.02672
G1 X144.56 Y134.518 E.00848
M204 S10000
G1 X137.38 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7347
M204 S4000
G1 X137.38 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.38 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.815 Y122.561 Z19.56 F60000
G1 X119.011 Y121.119 Z19.56
G1 Z19.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7347
M204 S4000
G1 X110.249 Y121.119 E.18174
G1 X110.249 Y134.881 E.28545
G1 X119.011 Y134.881 E.18174
G1 X119.011 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.42 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.883 Y120.71 E.18383
G1 X109.84 Y120.71 E.00083
G1 F3480
G1 X109.84 Y135.29 E.28104
G1 F3600
G1 X109.883 Y135.29 E.00083
G1 X119.42 Y135.29 E.18383
G1 X119.42 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.42 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.498 Y121.482 Z19.56 F60000
G1 Z19.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7347
M204 S4000
G1 X118.229 Y121.482 E.01516
G1 X118.229 Y122.448 E.02004
G3 X116.165 Y123.999 I-2.833 J-1.621 E.05506
G3 X115.255 Y123.923 I-.398 J-.722 E.02008
G1 X114.799 Y122.983 E.02167
G2 X113.483 Y121.482 I-3.09 J1.382 E.04204
G1 X111.453 Y121.482 E.0421
G3 X111.031 Y122.305 I-4.976 J-2.033 E.01921
G1 X111.031 Y127.713 E.11218
G1 X111.158 Y127.741 E.0027
G1 X111.613 Y127.565 E.01013
G1 X112.068 Y126.625 E.02167
G3 X114.344 Y124.718 I3.091 J1.377 E.06376
G3 X115.255 Y124.793 I.398 J.722 E.02008
G1 X115.71 Y125.734 E.02167
G2 X118.229 Y127.695 I3.118 J-1.407 E.06889
G1 X118.229 Y129.731 E.04225
G3 X116.165 Y131.282 I-2.833 J-1.621 E.05506
G3 X115.255 Y131.207 I-.398 J-.722 E.02008
G1 X114.799 Y130.266 E.02167
G2 X112.523 Y128.359 I-3.091 J1.377 E.06376
G2 X111.613 Y128.435 I-.398 J.722 E.02008
G3 X111.031 Y129.588 I-6.967 J-2.793 E.02683
G1 X111.031 Y134.518 E.10225
G1 X111.682 Y134.518 E.0135
G1 X112.068 Y133.908 E.01498
G3 X114.344 Y132.001 I3.091 J1.377 E.06376
G3 X115.255 Y132.077 I.398 J.722 E.02008
G1 X115.71 Y133.017 E.02167
G2 X117.026 Y134.518 I3.09 J-1.382 E.04204
G1 X118.229 Y134.518 E.02495
G1 X118.229 Y134.024 E.01025
M204 S10000
G1 X118.62 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7347
M204 S4000
G1 X118.62 Y121.57 E.2259
M204 S10000
G1 X110.64 Y134.49 F60000
; FEATURE: Internal solid infill
G1 F7347
M204 S4000
G1 X110.64 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 19.28
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X110.64 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L160
M991 S0 P159 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.56 I-.372 J1.159 P1  F60000
G1 X145.835 Y134.881 Z19.56
G1 Z19.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7270
M204 S4000
G1 X145.835 Y121.119 E.28545
G1 X137.073 Y121.119 E.18174
G1 X137.073 Y134.881 E.28545
G1 X145.775 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.201 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.244 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.244 Y120.71 E.28104
G1 F3600
G1 X146.201 Y120.71 E.00083
G1 X136.664 Y120.71 E.18383
G1 X136.664 Y135.29 E.28104
G1 X146.141 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.244 Y135.29 E-.03914
G1 X146.244 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.444 Y134.49 Z19.68 F60000
G1 Z19.28
M73 P93 R1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7270
M204 S4000
G1 X145.444 Y121.57 E.2259
M204 S10000
G1 X137.855 Y122.153 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7270
M204 S4000
G1 X137.855 Y123.85 E.0352
G2 X139.835 Y122.902 I-.147 J-2.85 E.04674
G1 X140.841 Y121.482 E.03609
G1 X142.514 Y121.482 E.0347
G3 X143.477 Y122.173 I-1.372 J2.927 E.02473
G1 X144.387 Y123.527 E.03384
G1 X144.842 Y123.843 E.01149
G1 X145.053 Y123.848 E.00437
G1 X145.053 Y126.18 E.04838
G1 X144.387 Y125.19 E.02476
G1 X143.932 Y124.874 E.01149
G2 X141.656 Y125.815 I-.165 J2.825 E.05285
G1 X140.745 Y127.169 E.03384
G1 X140.29 Y127.484 E.01149
G3 X137.855 Y126.307 I-.146 J-2.806 E.05854
G1 X137.855 Y131.133 E.1001
G2 X139.835 Y130.185 I-.147 J-2.85 E.04674
G1 X140.745 Y128.831 E.03384
G1 X141.201 Y128.516 E.01149
G3 X143.477 Y129.457 I.165 J2.825 E.05285
G1 X144.387 Y130.81 E.03384
G1 X144.842 Y131.126 E.01149
G1 X145.053 Y131.131 E.00437
G1 X145.053 Y133.463 E.04838
G1 X144.387 Y132.473 E.02476
G1 X143.932 Y132.157 E.01149
G2 X141.656 Y133.098 I-.165 J2.825 E.05285
G1 X140.745 Y134.452 E.03384
G1 X140.573 Y134.518 E.00382
G1 X139.041 Y134.518 E.0318
G3 X137.855 Y133.59 I.549 J-1.922 E.03202
G1 X137.855 Y131.893 E.0352
M204 S10000
G1 X137.464 Y134.49 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383372
G1 F7270
M204 S4000
G1 X137.464 Y121.57 E.2259
; COOLING_NODE: 0
; WIPE_START
G1 F8640
G1 X137.464 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.898 Y122.57 Z19.68 F60000
G1 X118.927 Y121.119 Z19.68
G1 Z19.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F7270
M204 S4000
G1 X110.165 Y121.119 E.18174
G1 X110.165 Y134.881 E.28545
G1 X118.927 Y134.881 E.18174
G1 X118.927 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.336 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.799 Y120.71 E.18383
G1 X109.756 Y120.71 E.00083
G1 F3480
G1 X109.756 Y135.29 E.28104
G1 F3600
G1 X109.799 Y135.29 E.00083
G1 X119.336 Y135.29 E.18383
G1 X119.336 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.336 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.947 Y124.236 Z19.68 F60000
G1 Z19.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7270
M204 S4000
G1 X110.947 Y122.539 E.0352
G1 X111.613 Y121.548 E.02476
G1 X111.709 Y121.482 E.00241
G1 X113.381 Y121.482 E.0347
G3 X114.344 Y122.173 I-1.372 J2.927 E.02473
G1 X115.255 Y123.527 E.03384
G1 X115.71 Y123.843 E.01149
G1 X116.165 Y123.853 E.00944
G2 X118.145 Y122.665 I-.371 J-2.862 E.04928
G1 X118.145 Y127.491 E.1001
G1 X117.986 Y127.495 E.0033
G3 X116.165 Y126.544 I.492 J-3.16 E.04338
G1 X115.255 Y125.19 E.03384
G1 X114.799 Y124.874 E.01149
G1 X114.344 Y124.863 E.00944
G2 X112.523 Y125.815 I.492 J3.16 E.04338
G1 X111.613 Y127.169 E.03384
G1 X111.158 Y127.484 E.01149
G1 X110.947 Y127.489 E.00438
G1 X110.947 Y129.822 E.04839
G1 X111.613 Y128.831 E.02476
G1 X112.068 Y128.516 E.01149
G1 X112.523 Y128.505 E.00944
G3 X114.344 Y129.457 I-.493 J3.16 E.04338
G1 X115.255 Y130.81 E.03384
G1 X115.71 Y131.126 E.01149
G1 X116.165 Y131.137 E.00944
G2 X118.145 Y129.948 I-.371 J-2.862 E.04928
G1 X118.145 Y134.518 E.09478
G3 X117.075 Y134.502 I-.477 J-3.915 E.02226
G3 X116.165 Y133.827 I1.158 J-2.513 E.02368
G1 X115.255 Y132.473 E.03384
G1 X114.799 Y132.157 E.01149
G1 X114.344 Y132.147 E.00944
G2 X112.523 Y133.098 I.493 J3.161 E.04338
G1 X111.613 Y134.452 E.03384
G3 X110.947 Y134.518 I-.419 J-.834 E.0142
G1 X110.947 Y133.315 E.02495
M204 S10000
G1 X110.556 Y134.49 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383372
G1 F7270
M204 S4000
G1 X110.556 Y121.57 E.2259
M204 S10000
G1 X118.536 Y134.49 F60000
; FEATURE: Floating vertical shell
G1 F7270
M204 S4000
G1 X118.536 Y121.57 E.2259
; CHANGE_LAYER
; Z_HEIGHT: 19.4
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F8640
G1 X118.536 Y123.57 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L161
M991 S0 P160 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.68 I-.465 J1.125 P1  F60000
G1 X145.919 Y134.881 Z19.68
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X145.919 Y121.119 E.28545
G1 X137.157 Y121.119 E.18174
G1 X137.157 Y134.881 E.28545
G1 X145.859 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.285 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.328 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.328 Y120.71 E.28104
G1 F3600
G1 X146.285 Y120.71 E.00083
G1 X136.748 Y120.71 E.18383
G1 X136.748 Y135.29 E.28104
G1 X146.225 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.328 Y135.29 E-.03914
G1 X146.328 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.787 Y132.214 Z19.8 F60000
G1 X137.939 Y132.081 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.939 Y133.778 E.0352
G2 X138.33 Y134.124 I.91 J-.636 E.01091
G1 X140.815 Y134.124 E.05155
G1 X141.656 Y133.051 E.02828
G3 X143.932 Y132.357 I1.791 J1.798 E.05136
G1 X144.387 Y132.713 E.01198
G1 X145.137 Y133.67 E.02522
G1 X145.137 Y130.98 E.0558
G1 X144.842 Y130.926 E.00621
G1 X144.387 Y130.57 E.01198
G1 X143.477 Y129.409 E.03061
G2 X141.201 Y128.716 I-1.791 J1.798 E.05136
G1 X140.745 Y129.071 E.01198
G1 X139.835 Y130.233 E.03061
G3 X137.939 Y130.995 I-1.859 J-1.883 E.04352
G1 X137.939 Y126.495 E.09334
G2 X138.925 Y127.179 I2.177 J-2.085 E.02505
G1 X139.835 Y127.367 E.01928
G2 X140.745 Y126.929 I.037 J-1.088 E.0218
G1 X141.656 Y125.767 E.03061
G3 X143.932 Y125.074 I1.791 J1.798 E.05136
G1 X144.387 Y125.43 E.01198
G1 X145.137 Y126.386 E.02522
G1 X145.137 Y123.696 E.0558
G1 X144.842 Y123.643 E.00621
G1 X144.387 Y123.287 E.01198
G1 X143.477 Y122.126 E.03061
G1 X143.161 Y121.876 E.00834
G1 X140.676 Y121.876 E.05155
G1 X139.835 Y122.95 E.02828
G3 X137.939 Y123.712 I-1.859 J-1.883 E.04352
G1 X137.939 Y122.015 E.0352
M204 S10000
G1 X145.349 Y121.498 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402417
G1 F8640
M204 S4000
G1 X145.504 Y121.534 E.00293
G1 X145.528 Y121.664 E.00244
; LINE_WIDTH: 0.40681
G1 X145.528 Y134.336 E.23607
G1 X145.504 Y134.466 E.00247
G1 X145.349 Y134.502 E.00297
; Slow Down Start
; LINE_WIDTH: 0.365752
G1 F1500;_EXTRUDE_SET_SPEED
G1 X145.265 Y134.502 E.00139
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.382067
;_EXTRUDE_SET_SPEED
G1 X141.496 Y134.502 E.06566
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.413997
;_EXTRUDE_SET_SPEED
G1 X137.727 Y134.502 E.07154
G1 X137.643 Y134.483 E.00164
; Slow Down End
; LINE_WIDTH: 0.401957
G1 F8640
G1 X137.572 Y134.466 E.00134
G1 X137.548 Y134.336 E.00244
; Slow Down Start
; LINE_WIDTH: 0.406956
G1 F1500;_EXTRUDE_SET_SPEED
G1 X137.548 Y121.664 E.23617
G1 X137.572 Y121.534 E.00247
G1 X137.643 Y121.517 E.00136
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.397868
;_EXTRUDE_SET_SPEED
G1 X137.727 Y121.498 E.00157
G1 X145.265 Y121.498 E.13714
; Slow Down End
; LINE_WIDTH: 0.430673
G1 F8640
G1 X145.289 Y121.498 E.00047
; COOLING_NODE: 0
; WIPE_START
G1 X145.265 Y121.498 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.633 Y121.389 Z19.8 F60000
G1 X118.843 Y121.119 Z19.8
G1 Z19.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X110.081 Y121.119 E.18174
G1 X110.081 Y134.881 E.28545
G1 X118.843 Y134.881 E.18174
G1 X118.843 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.252 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.715 Y120.71 E.18383
G1 X109.672 Y120.71 E.00083
G1 F3480
G1 X109.672 Y135.29 E.28104
G1 F3600
G1 X109.715 Y135.29 E.00083
G1 X119.252 Y135.29 E.18383
G1 X119.252 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.252 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.428 Y121.534 Z19.8 F60000
G1 Z19.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.407252
G1 F8640
M204 S4000
G1 X118.452 Y121.664 E.00247
G1 X118.452 Y134.336 E.23635
; Slow Down Start
; LINE_WIDTH: 0.389321
G1 F1500;_EXTRUDE_SET_SPEED
G1 X118.428 Y134.466 E.00236
G1 X118.357 Y134.483 E.00129
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.365953
;_EXTRUDE_SET_SPEED
G1 X118.273 Y134.502 E.00144
G1 X110.735 Y134.502 E.12538
; Slow Down End
; LINE_WIDTH: 0.382067
G1 F8640
G1 X110.693 Y134.502 E.00073
; LINE_WIDTH: 0.392608
G3 X110.496 Y134.466 I-.021 J-.441 E.00362
G1 X110.472 Y134.336 E.00238
; LINE_WIDTH: 0.4068
G1 X110.472 Y121.664 E.23607
G1 X110.496 Y121.534 E.00247
G1 X110.651 Y121.498 E.00297
; Slow Down Start
; LINE_WIDTH: 0.366111
G1 F1500;_EXTRUDE_SET_SPEED
G1 X110.735 Y121.498 E.00139
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.382611
;_EXTRUDE_SET_SPEED
G1 X114.504 Y121.498 E.06576
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.414187
;_EXTRUDE_SET_SPEED
G1 X118.273 Y121.498 E.07158
G1 X118.357 Y121.517 E.00164
; Slow Down End
; LINE_WIDTH: 0.416114
G1 F8640
G1 X118.37 Y121.52 E.00024
M204 S10000
G1 X110.863 Y124.442 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X110.863 Y122.745 E.0352
G1 X111.544 Y121.876 E.02289
G1 X114.029 Y121.876 E.05155
G1 X114.344 Y122.126 E.00834
G1 X115.255 Y123.287 E.03061
G2 X116.165 Y123.726 I.873 J-.649 E.0218
G2 X117.986 Y122.95 I-.162 J-2.905 E.04189
G1 X118.061 Y122.854 E.00252
G1 X118.061 Y127.354 E.09334
G1 X117.986 Y127.367 E.00158
G3 X116.165 Y126.591 I.162 J-2.905 E.04189
G1 X115.255 Y125.43 E.03061
G2 X114.344 Y124.991 I-.873 J.649 E.0218
G2 X112.523 Y125.767 I.162 J2.905 E.04189
G1 X111.613 Y126.929 E.03061
G1 X111.158 Y127.284 E.01198
G1 X110.863 Y127.338 E.00622
G1 X110.863 Y130.028 E.0558
G1 X111.613 Y129.071 E.02522
G3 X112.523 Y128.633 I.873 J.649 E.0218
G3 X114.344 Y129.409 I-.162 J2.905 E.04189
G1 X115.255 Y130.57 E.03061
G2 X116.165 Y131.009 I.873 J-.649 E.0218
G2 X117.986 Y130.233 I-.162 J-2.905 E.04189
G1 X118.061 Y130.137 E.00252
G1 X118.061 Y134.124 E.08269
G1 X116.48 Y134.124 E.03278
G1 X116.165 Y133.874 E.00834
G1 X115.255 Y132.713 E.03061
G2 X114.344 Y132.274 I-.873 J.649 E.0218
G2 X112.523 Y133.051 I.162 J2.905 E.04189
G1 X111.682 Y134.124 E.02828
G1 X110.863 Y134.124 E.01699
G1 X110.863 Y133.246 E.01821
; CHANGE_LAYER
; Z_HEIGHT: 19.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F9000
G1 X110.863 Y134.124 E-.33351
G1 X111.682 Y134.124 E-.31135
G1 X111.869 Y133.885 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L162
M991 S0 P161 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.8 I-.035 J1.216 P1  F60000
G1 X146.003 Y134.881 Z19.8
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X146.003 Y121.119 E.28545
G1 X137.241 Y121.119 E.18174
G1 X137.241 Y134.881 E.28545
G1 X145.943 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.369 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.412 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.412 Y120.71 E.28104
G1 F3600
G1 X146.369 Y120.71 E.00083
G1 X136.832 Y120.71 E.18383
G1 X136.832 Y135.29 E.28104
G1 X146.309 Y135.29 E.18268
; WIPE_START
M204 S4000
M73 P94 R1
G1 X146.412 Y135.29 E-.03914
G1 X146.412 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.832 Y134.284 Z19.92 F60000
G1 X137.419 Y134.45 Z19.92
G1 Z19.52
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.51084
; LAYER_HEIGHT: 0.489898
G1 F1500
M204 S4000
G1 X145.582 Y134.45 E.68169
G1 X145.582 Y133.889 E.04683
G1 X137.662 Y133.889 E.6614
G1 X137.662 Y133.328 E.04683
G1 X145.582 Y133.328 E.6614
G1 X145.582 Y132.767 E.04683
G1 X137.662 Y132.767 E.6614
G1 X137.662 Y132.206 E.04683
G1 X145.582 Y132.206 E.6614
G1 X145.582 Y131.645 E.04683
G1 X137.662 Y131.645 E.6614
G1 X137.662 Y131.085 E.04683
G1 X145.582 Y131.085 E.6614
G1 X145.582 Y130.524 E.04683
G1 X137.662 Y130.524 E.6614
G1 X137.662 Y129.963 E.04683
G1 X145.582 Y129.963 E.6614
G1 X145.582 Y129.402 E.04683
G1 X137.662 Y129.402 E.6614
G1 X137.662 Y128.841 E.04683
G1 X145.582 Y128.841 E.6614
G1 X145.582 Y128.28 E.04683
G1 X137.662 Y128.28 E.6614
G1 X137.662 Y127.72 E.04683
G1 X145.582 Y127.72 E.6614
G1 X145.582 Y127.159 E.04683
G1 X137.662 Y127.159 E.6614
G1 X137.662 Y126.598 E.04683
G1 X145.582 Y126.598 E.6614
G1 X145.582 Y126.037 E.04683
G1 X137.662 Y126.037 E.6614
G1 X137.662 Y125.476 E.04683
G1 X145.582 Y125.476 E.6614
G1 X145.582 Y124.915 E.04683
G1 X137.662 Y124.915 E.6614
G1 X137.662 Y124.355 E.04683
G1 X145.582 Y124.355 E.6614
G1 X145.582 Y123.794 E.04683
G1 X137.662 Y123.794 E.6614
G1 X137.662 Y123.233 E.04683
G1 X145.582 Y123.233 E.6614
G1 X145.582 Y122.672 E.04683
G1 X137.662 Y122.672 E.6614
G1 X137.662 Y122.111 E.04683
G1 X145.582 Y122.111 E.6614
G1 X145.582 Y121.55 E.04683
G1 X137.419 Y121.55 E.68169
; COOLING_NODE: 0
; WIPE_START
G1 X139.419 Y121.55 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.788 Y121.391 Z19.92 F60000
G1 X118.759 Y121.119 Z19.92
G1 Z19.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F9000
M204 S4000
G1 X109.997 Y121.119 E.18174
G1 X109.997 Y134.881 E.28545
G1 X118.759 Y134.881 E.18174
G1 X118.759 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.168 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.631 Y120.71 E.18383
G1 X109.588 Y120.71 E.00083
G1 F3480
G1 X109.588 Y135.29 E.28104
G1 F3600
G1 X109.631 Y135.29 E.00083
G1 X119.168 Y135.29 E.18383
G1 X119.168 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.168 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.175 Y121.55 Z19.92 F60000
G1 Z19.52
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.51084
; LAYER_HEIGHT: 0.489898
G1 F1500
M204 S4000
G1 X118.338 Y121.55 E.68169
G1 X118.338 Y122.111 E.04683
G1 X110.418 Y122.111 E.6614
G1 X110.418 Y122.672 E.04683
G1 X118.338 Y122.672 E.6614
G1 X118.338 Y123.233 E.04683
G1 X110.418 Y123.233 E.6614
G1 X110.418 Y123.794 E.04683
G1 X118.338 Y123.794 E.6614
G1 X118.338 Y124.355 E.04683
G1 X110.418 Y124.355 E.6614
G1 X110.418 Y124.915 E.04683
G1 X118.338 Y124.915 E.6614
G1 X118.338 Y125.476 E.04683
M73 P95 R1
G1 X110.418 Y125.476 E.6614
G1 X110.418 Y126.037 E.04683
G1 X118.338 Y126.037 E.6614
G1 X118.338 Y126.598 E.04683
G1 X110.418 Y126.598 E.6614
G1 X110.418 Y127.159 E.04683
G1 X118.338 Y127.159 E.6614
G1 X118.338 Y127.72 E.04683
G1 X110.418 Y127.72 E.6614
G1 X110.418 Y128.28 E.04683
G1 X118.338 Y128.28 E.6614
G1 X118.338 Y128.841 E.04683
G1 X110.418 Y128.841 E.6614
G1 X110.418 Y129.402 E.04683
G1 X118.338 Y129.402 E.6614
G1 X118.338 Y129.963 E.04683
G1 X110.418 Y129.963 E.6614
G1 X110.418 Y130.524 E.04683
G1 X118.338 Y130.524 E.6614
G1 X118.338 Y131.085 E.04683
G1 X110.418 Y131.085 E.6614
G1 X110.418 Y131.645 E.04683
M73 P95 R0
G1 X118.338 Y131.645 E.6614
G1 X118.338 Y132.206 E.04683
G1 X110.418 Y132.206 E.6614
G1 X110.418 Y132.767 E.04683
G1 X118.338 Y132.767 E.6614
G1 X118.338 Y133.328 E.04683
G1 X110.418 Y133.328 E.6614
G1 X110.418 Y133.889 E.04683
G1 X118.338 Y133.889 E.6614
G1 X118.338 Y134.45 E.04683
G1 X110.175 Y134.45 E.68169
; CHANGE_LAYER
; Z_HEIGHT: 19.64
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F1500
G1 X112.175 Y134.45 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L163
M991 S0 P162 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z19.92 I-.015 J1.217 P1  F60000
G1 X146.087 Y134.881 Z19.92
G1 Z19.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X146.087 Y121.119 E.28545
G1 X137.325 Y121.119 E.18174
G1 X137.325 Y134.881 E.28545
G1 X146.027 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.453 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.496 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.496 Y120.71 E.28104
G1 F3600
G1 X146.453 Y120.71 E.00083
G1 X136.916 Y120.71 E.18383
G1 X136.916 Y135.29 E.28104
G1 X146.393 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.496 Y135.29 E-.03914
G1 X146.496 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.876 Y133.828 Z20.04 F60000
G1 X137.496 Y133.906 Z20.04
G1 Z19.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X138.122 Y134.533 E.01722
G1 X138.684 Y134.533 E.01092
G1 X137.673 Y133.522 E.02779
G1 X137.673 Y132.96 E.01092
G1 X139.246 Y134.533 E.04324
G1 X139.808 Y134.533 E.01092
G1 X137.673 Y132.398 E.05868
G1 X137.673 Y131.836 E.01092
G1 X140.37 Y134.533 E.07413
G1 X140.933 Y134.533 E.01092
G1 X137.673 Y131.273 E.08957
G1 X137.673 Y130.711 E.01092
G1 X141.495 Y134.533 E.10502
G1 X142.057 Y134.533 E.01092
G1 X137.673 Y130.149 E.12046
G1 X137.673 Y129.587 E.01092
G1 X142.619 Y134.533 E.13591
G1 X143.181 Y134.533 E.01092
G1 X137.673 Y129.025 E.15135
G1 X137.673 Y128.463 E.01092
G1 X143.743 Y134.533 E.1668
G1 X144.305 Y134.533 E.01092
G1 X137.673 Y127.901 E.18224
G1 X137.673 Y127.339 E.01092
G1 X144.867 Y134.533 E.19769
G1 X145.429 Y134.533 E.01092
G1 X137.673 Y126.777 E.21313
G1 X137.673 Y126.215 E.01092
G1 X145.739 Y134.281 E.22165
G1 X145.739 Y133.719 E.01092
G1 X137.673 Y125.653 E.22165
G1 X137.673 Y125.091 E.01092
G1 X145.739 Y133.157 E.22165
G1 X145.739 Y132.595 E.01092
G1 X137.673 Y124.529 E.22165
G1 X137.673 Y123.967 E.01092
G1 X145.739 Y132.033 E.22165
G1 X145.739 Y131.471 E.01092
G1 X137.673 Y123.405 E.22165
G1 X137.673 Y122.843 E.01092
G1 X145.739 Y130.909 E.22165
G1 X145.739 Y130.347 E.01092
G1 X137.673 Y122.281 E.22165
G1 X137.673 Y121.719 E.01092
G1 X145.739 Y129.785 E.22165
G1 X145.739 Y129.223 E.01092
G1 X137.983 Y121.467 E.21312
G1 X138.546 Y121.467 E.01092
G1 X145.739 Y128.66 E.19768
G1 X145.739 Y128.098 E.01092
G1 X139.108 Y121.467 E.18223
G1 X139.67 Y121.467 E.01092
G1 X145.739 Y127.536 E.16679
G1 X145.739 Y126.974 E.01092
G1 X140.232 Y121.467 E.15134
G1 X140.794 Y121.467 E.01092
G1 X145.739 Y126.412 E.1359
G1 X145.739 Y125.85 E.01092
G1 X141.356 Y121.467 E.12045
G1 X141.918 Y121.467 E.01092
G1 X145.739 Y125.288 E.10501
G1 X145.739 Y124.726 E.01092
G1 X142.48 Y121.467 E.08956
G1 X143.042 Y121.467 E.01092
G1 X145.739 Y124.164 E.07412
G1 X145.739 Y123.602 E.01092
G1 X143.604 Y121.467 E.05867
G1 X144.166 Y121.467 E.01092
G1 X145.739 Y123.04 E.04323
G1 X145.739 Y122.478 E.01092
G1 X144.728 Y121.467 E.02778
G1 X145.29 Y121.467 E.01092
G1 X145.916 Y122.093 E.01721
; COOLING_NODE: 0
; WIPE_START
G1 X145.29 Y121.467 E-.33657
G1 X144.728 Y121.467 E-.21358
G1 X145.119 Y121.857 E-.20985
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.489 Y121.644 Z20.04 F60000
G1 X118.675 Y121.119 Z20.04
G1 Z19.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X109.913 Y121.119 E.18174
G1 X109.913 Y134.881 E.28545
G1 X118.675 Y134.881 E.18174
G1 X118.675 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119.084 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.547 Y120.71 E.18383
G1 X109.504 Y120.71 E.00083
M73 P96 R0
G1 F3480
G1 X109.504 Y135.29 E.28104
G1 F3600
G1 X109.547 Y135.29 E.00083
G1 X119.084 Y135.29 E.18383
G1 X119.084 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117.084 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.504 Y122.093 Z20.04 F60000
G1 Z19.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X117.878 Y121.467 E.01721
G1 X117.316 Y121.467 E.01092
G1 X118.327 Y122.478 E.02778
G1 X118.327 Y123.04 E.01092
G1 X116.754 Y121.467 E.04323
G1 X116.192 Y121.467 E.01092
G1 X118.327 Y123.602 E.05867
G1 X118.327 Y124.164 E.01092
G1 X115.63 Y121.467 E.07412
G1 X115.068 Y121.467 E.01092
G1 X118.327 Y124.726 E.08956
G1 X118.327 Y125.288 E.01092
G1 X114.506 Y121.467 E.10501
G1 X113.944 Y121.467 E.01092
G1 X118.327 Y125.85 E.12045
G1 X118.327 Y126.412 E.01092
G1 X113.382 Y121.467 E.1359
G1 X112.82 Y121.467 E.01092
G1 X118.327 Y126.974 E.15134
G1 X118.327 Y127.536 E.01092
G1 X112.258 Y121.467 E.16679
G1 X111.696 Y121.467 E.01092
G1 X118.327 Y128.098 E.18223
G1 X118.327 Y128.66 E.01092
G1 X111.133 Y121.467 E.19768
G1 X110.571 Y121.467 E.01092
G1 X118.327 Y129.223 E.21312
G1 X118.327 Y129.785 E.01092
G1 X110.261 Y121.719 E.22165
G1 X110.261 Y122.281 E.01092
G1 X118.327 Y130.347 E.22165
G1 X118.327 Y130.909 E.01092
G1 X110.261 Y122.843 E.22165
G1 X110.261 Y123.405 E.01092
G1 X118.327 Y131.471 E.22165
G1 X118.327 Y132.033 E.01092
G1 X110.261 Y123.967 E.22165
G1 X110.261 Y124.529 E.01092
G1 X118.327 Y132.595 E.22165
G1 X118.327 Y133.157 E.01092
G1 X110.261 Y125.091 E.22165
G1 X110.261 Y125.653 E.01092
G1 X118.327 Y133.719 E.22165
G1 X118.327 Y134.281 E.01092
G1 X110.261 Y126.215 E.22165
G1 X110.261 Y126.777 E.01092
G1 X118.017 Y134.533 E.21313
G1 X117.455 Y134.533 E.01092
G1 X110.261 Y127.339 E.19769
G1 X110.261 Y127.901 E.01092
G1 X116.893 Y134.533 E.18224
G1 X116.331 Y134.533 E.01092
G1 X110.261 Y128.463 E.1668
G1 X110.261 Y129.025 E.01092
G1 X115.769 Y134.533 E.15135
G1 X115.207 Y134.533 E.01092
G1 X110.261 Y129.587 E.13591
G1 X110.261 Y130.149 E.01092
G1 X114.645 Y134.533 E.12046
G1 X114.083 Y134.533 E.01092
G1 X110.261 Y130.711 E.10502
G1 X110.261 Y131.273 E.01092
G1 X113.521 Y134.533 E.08957
G1 X112.958 Y134.533 E.01092
G1 X110.261 Y131.836 E.07413
G1 X110.261 Y132.398 E.01092
G1 X112.396 Y134.533 E.05868
G1 X111.834 Y134.533 E.01092
G1 X110.261 Y132.96 E.04324
G1 X110.261 Y133.522 E.01092
G1 X111.272 Y134.533 E.02779
G1 X110.71 Y134.533 E.01092
G1 X110.084 Y133.906 E.01722
; CHANGE_LAYER
; Z_HEIGHT: 19.76
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X110.71 Y134.533 E-.33679
G1 X111.272 Y134.533 E-.21358
G1 X110.882 Y134.143 E-.20963
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L164
M991 S0 P163 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z20.04 I-.025 J1.217 P1  F60000
G1 X146.171 Y134.881 Z20.04
G1 Z19.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X146.171 Y121.119 E.28545
G1 X137.409 Y121.119 E.18174
G1 X137.409 Y134.881 E.28545
G1 X146.111 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.537 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.58 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.58 Y120.71 E.28104
G1 F3600
G1 X146.537 Y120.71 E.00083
G1 X137 Y120.71 E.18383
G1 X137 Y135.29 E.28104
G1 X146.477 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.58 Y135.29 E-.03914
G1 X146.58 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.197 Y134.71 Z20.16 F60000
G1 Z19.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X145.823 Y134.084 E.01721
G1 X145.823 Y133.522 E.01092
G1 X144.812 Y134.533 E.02778
G1 X144.25 Y134.533 E.01092
G1 X145.823 Y132.96 E.04323
G1 X145.823 Y132.398 E.01092
G1 X143.688 Y134.533 E.05867
G1 X143.126 Y134.533 E.01092
G1 X145.823 Y131.836 E.07412
G1 X145.823 Y131.274 E.01092
G1 X142.564 Y134.533 E.08956
G1 X142.002 Y134.533 E.01092
G1 X145.823 Y130.712 E.10501
G1 X145.823 Y130.15 E.01092
G1 X141.44 Y134.533 E.12045
G1 X140.878 Y134.533 E.01092
G1 X145.823 Y129.588 E.1359
G1 X145.823 Y129.026 E.01092
G1 X140.316 Y134.533 E.15134
G1 X139.754 Y134.533 E.01092
G1 X145.823 Y128.464 E.16679
G1 X145.823 Y127.902 E.01092
G1 X139.192 Y134.533 E.18223
G1 X138.63 Y134.533 E.01092
G1 X145.823 Y127.34 E.19768
G1 X145.823 Y126.777 E.01092
G1 X138.067 Y134.533 E.21312
G1 X137.757 Y134.533 E.00603
G1 X137.757 Y134.281 E.00489
G1 X145.823 Y126.215 E.22165
G1 X145.823 Y125.653 E.01092
G1 X137.757 Y133.719 E.22165
G1 X137.757 Y133.157 E.01092
G1 X145.823 Y125.091 E.22165
G1 X145.823 Y124.529 E.01092
G1 X137.757 Y132.595 E.22165
G1 X137.757 Y132.033 E.01092
G1 X145.823 Y123.967 E.22165
G1 X145.823 Y123.405 E.01092
G1 X137.757 Y131.471 E.22165
G1 X137.757 Y130.909 E.01092
G1 X145.823 Y122.843 E.22165
G1 X145.823 Y122.281 E.01092
G1 X137.757 Y130.347 E.22165
G1 X137.757 Y129.785 E.01092
G1 X145.823 Y121.719 E.22165
G1 X145.823 Y121.467 E.0049
G1 X145.513 Y121.467 E.00602
G1 X137.757 Y129.223 E.21313
G1 X137.757 Y128.661 E.01092
G1 X144.951 Y121.467 E.19769
G1 X144.389 Y121.467 E.01092
G1 X137.757 Y128.099 E.18224
G1 X137.757 Y127.537 E.01092
G1 X143.827 Y121.467 E.1668
G1 X143.265 Y121.467 E.01092
G1 X137.757 Y126.975 E.15135
G1 X137.757 Y126.413 E.01092
G1 X142.703 Y121.467 E.13591
G1 X142.141 Y121.467 E.01092
G1 X137.757 Y125.851 E.12046
G1 X137.757 Y125.289 E.01092
G1 X141.579 Y121.467 E.10502
G1 X141.017 Y121.467 E.01092
G1 X137.757 Y124.727 E.08957
G1 X137.757 Y124.164 E.01092
G1 X140.455 Y121.467 E.07413
G1 X139.892 Y121.467 E.01092
G1 X137.757 Y123.602 E.05868
G1 X137.757 Y123.04 E.01092
G1 X139.33 Y121.467 E.04324
G1 X138.768 Y121.467 E.01092
G1 X137.757 Y122.478 E.02779
G1 X137.757 Y121.916 E.01092
G1 X138.384 Y121.29 E.01722
; COOLING_NODE: 0
; WIPE_START
G1 X137.757 Y121.916 E-.3368
G1 X137.757 Y122.478 E-.21358
G1 X138.147 Y122.088 E-.20962
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.524 Y121.711 Z20.16 F60000
G1 X118.591 Y121.119 Z20.16
G1 Z19.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X109.829 Y121.119 E.18174
G1 X109.829 Y134.881 E.28545
G1 X118.591 Y134.881 E.18174
G1 X118.591 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X119 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.463 Y120.71 E.18383
G1 X109.42 Y120.71 E.00083
G1 F3480
G1 X109.42 Y135.29 E.28104
G1 F3600
G1 X109.463 Y135.29 E.00083
G1 X119 Y135.29 E.18383
G1 X119 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X117 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.804 Y121.29 Z20.16 F60000
G1 Z19.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X110.177 Y121.916 E.01722
G1 X110.177 Y122.478 E.01092
G1 X111.188 Y121.467 E.02779
G1 X111.75 Y121.467 E.01092
G1 X110.177 Y123.04 E.04324
G1 X110.177 Y123.602 E.01092
G1 X112.312 Y121.467 E.05868
G1 X112.874 Y121.467 E.01092
G1 X110.177 Y124.164 E.07413
G1 X110.177 Y124.727 E.01092
G1 X113.437 Y121.467 E.08957
G1 X113.999 Y121.467 E.01092
G1 X110.177 Y125.289 E.10502
G1 X110.177 Y125.851 E.01092
G1 X114.561 Y121.467 E.12046
G1 X115.123 Y121.467 E.01092
G1 X110.177 Y126.413 E.13591
G1 X110.177 Y126.975 E.01092
G1 X115.685 Y121.467 E.15135
G1 X116.247 Y121.467 E.01092
G1 X110.177 Y127.537 E.1668
G1 X110.177 Y128.099 E.01092
G1 X116.809 Y121.467 E.18224
G1 X117.371 Y121.467 E.01092
M73 P97 R0
G1 X110.177 Y128.661 E.19769
G1 X110.177 Y129.223 E.01092
G1 X117.933 Y121.467 E.21313
G1 X118.243 Y121.467 E.00602
G1 X118.243 Y121.719 E.0049
G1 X110.177 Y129.785 E.22165
G1 X110.177 Y130.347 E.01092
G1 X118.243 Y122.281 E.22165
G1 X118.243 Y122.843 E.01092
G1 X110.177 Y130.909 E.22165
G1 X110.177 Y131.471 E.01092
G1 X118.243 Y123.405 E.22165
G1 X118.243 Y123.967 E.01092
G1 X110.177 Y132.033 E.22165
G1 X110.177 Y132.595 E.01092
G1 X118.243 Y124.529 E.22165
G1 X118.243 Y125.091 E.01092
G1 X110.177 Y133.157 E.22165
G1 X110.177 Y133.719 E.01092
G1 X118.243 Y125.653 E.22165
G1 X118.243 Y126.215 E.01092
G1 X110.177 Y134.281 E.22165
G1 X110.177 Y134.533 E.00489
G1 X110.487 Y134.533 E.00603
G1 X118.243 Y126.777 E.21312
G1 X118.243 Y127.34 E.01092
G1 X111.049 Y134.533 E.19768
G1 X111.612 Y134.533 E.01092
G1 X118.243 Y127.902 E.18223
G1 X118.243 Y128.464 E.01092
G1 X112.174 Y134.533 E.16679
G1 X112.736 Y134.533 E.01092
G1 X118.243 Y129.026 E.15134
G1 X118.243 Y129.588 E.01092
G1 X113.298 Y134.533 E.1359
G1 X113.86 Y134.533 E.01092
G1 X118.243 Y130.15 E.12045
G1 X118.243 Y130.712 E.01092
G1 X114.422 Y134.533 E.10501
G1 X114.984 Y134.533 E.01092
G1 X118.243 Y131.274 E.08956
G1 X118.243 Y131.836 E.01092
G1 X115.546 Y134.533 E.07412
G1 X116.108 Y134.533 E.01092
G1 X118.243 Y132.398 E.05867
G1 X118.243 Y132.96 E.01092
G1 X116.67 Y134.533 E.04323
G1 X117.232 Y134.533 E.01092
G1 X118.243 Y133.522 E.02778
G1 X118.243 Y134.084 E.01092
G1 X117.617 Y134.71 E.01721
; CHANGE_LAYER
; Z_HEIGHT: 19.88
; LAYER_HEIGHT: 0.119999
; WIPE_START
G1 F10800
G1 X118.243 Y134.084 E-.33658
G1 X118.243 Y133.522 E-.21358
G1 X117.853 Y133.913 E-.20985
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L165
M991 S0 P164 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z20.16 I-.041 J1.216 P1  F60000
G1 X146.255 Y134.881 Z20.16
G1 Z19.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X146.255 Y121.119 E.28545
G1 X137.493 Y121.119 E.18174
G1 X137.493 Y134.881 E.28545
G1 X146.195 Y134.881 E.18049
; COOLING_NODE: 0
M204 S250
G1 X146.621 Y135.29 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.664 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.664 Y120.71 E.28104
G1 F3600
G1 X146.621 Y120.71 E.00083
G1 X137.084 Y120.71 E.18383
G1 X137.084 Y135.29 E.28104
G1 X146.561 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.664 Y135.29 E-.03914
G1 X146.664 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.044 Y133.828 Z20.28 F60000
G1 X137.664 Y133.906 Z20.28
G1 Z19.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X138.29 Y134.533 E.01722
G1 X138.852 Y134.533 E.01092
G1 X137.841 Y133.522 E.02779
G1 X137.841 Y132.96 E.01092
G1 X139.414 Y134.533 E.04324
G1 X139.976 Y134.533 E.01092
G1 X137.841 Y132.398 E.05868
G1 X137.841 Y131.836 E.01092
G1 X140.538 Y134.533 E.07413
G1 X141.101 Y134.533 E.01092
G1 X137.841 Y131.273 E.08957
G1 X137.841 Y130.711 E.01092
G1 X141.663 Y134.533 E.10502
G1 X142.225 Y134.533 E.01092
G1 X137.841 Y130.149 E.12046
G1 X137.841 Y129.587 E.01092
G1 X142.787 Y134.533 E.13591
G1 X143.349 Y134.533 E.01092
G1 X137.841 Y129.025 E.15135
G1 X137.841 Y128.463 E.01092
G1 X143.911 Y134.533 E.1668
G1 X144.473 Y134.533 E.01092
G1 X137.841 Y127.901 E.18224
G1 X137.841 Y127.339 E.01092
G1 X145.035 Y134.533 E.19769
G1 X145.597 Y134.533 E.01092
G1 X137.841 Y126.777 E.21313
G1 X137.841 Y126.215 E.01092
G1 X145.907 Y134.281 E.22165
G1 X145.907 Y133.719 E.01092
G1 X137.841 Y125.653 E.22165
G1 X137.841 Y125.091 E.01092
G1 X145.907 Y133.157 E.22165
G1 X145.907 Y132.595 E.01092
G1 X137.841 Y124.529 E.22165
G1 X137.841 Y123.967 E.01092
G1 X145.907 Y132.033 E.22165
G1 X145.907 Y131.471 E.01092
G1 X137.841 Y123.405 E.22165
G1 X137.841 Y122.843 E.01092
G1 X145.907 Y130.909 E.22165
G1 X145.907 Y130.347 E.01092
G1 X137.841 Y122.281 E.22165
G1 X137.841 Y121.719 E.01092
G1 X145.907 Y129.785 E.22165
G1 X145.907 Y129.223 E.01092
G1 X138.151 Y121.467 E.21312
G1 X138.713 Y121.467 E.01092
G1 X145.907 Y128.66 E.19768
G1 X145.907 Y128.098 E.01092
G1 X139.276 Y121.467 E.18223
G1 X139.838 Y121.467 E.01092
G1 X145.907 Y127.536 E.16679
G1 X145.907 Y126.974 E.01092
G1 X140.4 Y121.467 E.15134
G1 X140.962 Y121.467 E.01092
G1 X145.907 Y126.412 E.1359
G1 X145.907 Y125.85 E.01092
G1 X141.524 Y121.467 E.12045
G1 X142.086 Y121.467 E.01092
G1 X145.907 Y125.288 E.10501
G1 X145.907 Y124.726 E.01092
G1 X142.648 Y121.467 E.08956
G1 X143.21 Y121.467 E.01092
G1 X145.907 Y124.164 E.07412
G1 X145.907 Y123.602 E.01092
G1 X143.772 Y121.467 E.05867
G1 X144.334 Y121.467 E.01092
G1 X145.907 Y123.04 E.04323
G1 X145.907 Y122.478 E.01092
G1 X144.896 Y121.467 E.02778
G1 X145.458 Y121.467 E.01092
G1 X146.084 Y122.093 E.01721
; COOLING_NODE: 0
; WIPE_START
G1 X145.458 Y121.467 E-.33657
G1 X144.896 Y121.467 E-.21358
G1 X145.287 Y121.857 E-.20985
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.657 Y121.647 Z20.28 F60000
G1 X118.507 Y121.119 Z20.28
G1 Z19.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X109.745 Y121.119 E.18174
G1 X109.745 Y134.881 E.28545
G1 X118.507 Y134.881 E.18174
G1 X118.507 Y121.179 E.2842
; COOLING_NODE: 0
M204 S250
G1 X118.916 Y120.71 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X109.379 Y120.71 E.18383
G1 X109.336 Y120.71 E.00083
G1 F3480
G1 X109.336 Y135.29 E.28104
G1 F3600
G1 X109.379 Y135.29 E.00083
G1 X118.916 Y135.29 E.18383
G1 X118.916 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X116.916 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.336 Y122.093 Z20.28 F60000
G1 Z19.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423182
G1 F10800
M204 S4000
G1 X117.71 Y121.467 E.01721
G1 X117.148 Y121.467 E.01092
G1 X118.159 Y122.478 E.02778
G1 X118.159 Y123.04 E.01092
G1 X116.586 Y121.467 E.04323
G1 X116.024 Y121.467 E.01092
G1 X118.159 Y123.602 E.05867
G1 X118.159 Y124.164 E.01092
G1 X115.462 Y121.467 E.07412
G1 X114.9 Y121.467 E.01092
G1 X118.159 Y124.726 E.08956
G1 X118.159 Y125.288 E.01092
G1 X114.338 Y121.467 E.10501
G1 X113.776 Y121.467 E.01092
G1 X118.159 Y125.85 E.12045
G1 X118.159 Y126.412 E.01092
G1 X113.214 Y121.467 E.1359
G1 X112.652 Y121.467 E.01092
G1 X118.159 Y126.974 E.15134
G1 X118.159 Y127.536 E.01092
G1 X112.09 Y121.467 E.16679
G1 X111.528 Y121.467 E.01092
G1 X118.159 Y128.098 E.18223
G1 X118.159 Y128.66 E.01092
G1 X110.965 Y121.467 E.19768
G1 X110.403 Y121.467 E.01092
G1 X118.159 Y129.223 E.21312
G1 X118.159 Y129.785 E.01092
G1 X110.093 Y121.719 E.22165
G1 X110.093 Y122.281 E.01092
G1 X118.159 Y130.347 E.22165
G1 X118.159 Y130.909 E.01092
G1 X110.093 Y122.843 E.22165
G1 X110.093 Y123.405 E.01092
G1 X118.159 Y131.471 E.22165
G1 X118.159 Y132.033 E.01092
G1 X110.093 Y123.967 E.22165
G1 X110.093 Y124.529 E.01092
G1 X118.159 Y132.595 E.22165
G1 X118.159 Y133.157 E.01092
G1 X110.093 Y125.091 E.22165
G1 X110.093 Y125.653 E.01092
G1 X118.159 Y133.719 E.22165
G1 X118.159 Y134.281 E.01092
G1 X110.093 Y126.215 E.22165
G1 X110.093 Y126.777 E.01092
G1 X117.849 Y134.533 E.21313
G1 X117.287 Y134.533 E.01092
G1 X110.093 Y127.339 E.19769
G1 X110.093 Y127.901 E.01092
G1 X116.725 Y134.533 E.18224
G1 X116.163 Y134.533 E.01092
G1 X110.093 Y128.463 E.1668
G1 X110.093 Y129.025 E.01092
G1 X115.601 Y134.533 E.15135
G1 X115.039 Y134.533 E.01092
M73 P98 R0
G1 X110.093 Y129.587 E.13591
G1 X110.093 Y130.149 E.01092
G1 X114.477 Y134.533 E.12046
G1 X113.915 Y134.533 E.01092
G1 X110.093 Y130.711 E.10502
G1 X110.093 Y131.273 E.01092
G1 X113.353 Y134.533 E.08957
G1 X112.79 Y134.533 E.01092
G1 X110.093 Y131.836 E.07413
G1 X110.093 Y132.398 E.01092
G1 X112.228 Y134.533 E.05868
G1 X111.666 Y134.533 E.01092
G1 X110.093 Y132.96 E.04324
G1 X110.093 Y133.522 E.01092
G1 X111.104 Y134.533 E.02779
G1 X110.542 Y134.533 E.01092
G1 X109.916 Y133.906 E.01722
; CHANGE_LAYER
; Z_HEIGHT: 20
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F10800
G1 X110.542 Y134.533 E-.33678
G1 X111.104 Y134.533 E-.21358
G1 X110.714 Y134.143 E-.20964
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L166
M991 S0 P165 ;notify layer change

; OBJECT_ID: 258
; COOLING_NODE: 0
M204 S10000
G17
G3 Z20.28 I-.039 J1.216 P1  F60000
G1 X146.705 Y135.29 Z20.28
G1 Z20
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X146.748 Y135.29 E.00083
;======== X2D timelapse gcode ========
;======== 2026/06/03 ========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag

M622 J1
    
        
    

    
        M971 S11 C10 O0
        M1004 S5 P1  ; external shutter
    

    
        
    
M623
; SKIPPABLE_END

G1 F3480
G1 X146.748 Y120.71 E.28104
G1 F3600
G1 X146.705 Y120.71 E.00083
G1 X137.168 Y120.71 E.18383
G1 X137.168 Y135.29 E.28104
G1 X146.645 Y135.29 E.18268
; WIPE_START
M204 S4000
G1 X146.748 Y135.29 E-.03914
G1 X146.748 Y133.393 E-.72086
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.531 Y134.279 Z20.4 F60000
G1 Z20
G1 E.8 F1800
; FEATURE: Top surface
G1 F9000
M204 S2000
G1 X145.737 Y135.073 E.02164
G1 X145.604 Y135.207
G1 X145.046 Y135.207
G1 X145.18 Y135.073
G1 X146.531 Y133.722 E.03684
G1 X146.665 Y133.588
G1 X146.665 Y133.031
G1 X146.531 Y133.164
G1 X144.622 Y135.073 E.05204
G1 X144.489 Y135.207
G1 X143.931 Y135.207
G1 X144.065 Y135.073
G1 X146.531 Y132.607 E.06724
G1 X146.665 Y132.473
G1 X146.665 Y131.915
G1 X146.531 Y132.049
G1 X143.507 Y135.073 E.08244
G1 X143.373 Y135.207
G1 X142.816 Y135.207
G1 X142.95 Y135.073
G1 X146.531 Y131.492 E.09763
G1 X146.665 Y131.358
G1 X146.665 Y130.8
G1 X146.531 Y130.934
G1 X142.392 Y135.073 E.11283
G1 X142.258 Y135.207
G1 X141.701 Y135.207
G1 X141.834 Y135.073
G1 X146.531 Y130.376 E.12803
G1 X146.665 Y130.243
G1 X146.665 Y129.685
G1 X146.531 Y129.819
G1 X141.277 Y135.073 E.14323
G1 X141.143 Y135.207
G1 X140.586 Y135.207
G1 X140.719 Y135.073
G1 X146.531 Y129.261 E.15843
G1 X146.665 Y129.128
G1 X146.665 Y128.57
G1 X146.531 Y128.704
G1 X140.162 Y135.073 E.17363
G1 X140.028 Y135.207
G1 X139.471 Y135.207
G1 X139.604 Y135.073
G1 X146.531 Y128.146 E.18883
G1 X146.665 Y128.013
G1 X146.665 Y127.455
G1 X146.531 Y127.589
G1 X139.047 Y135.073 E.20402
G1 X138.913 Y135.207
G1 X138.356 Y135.207
G1 X138.489 Y135.073
G1 X146.531 Y127.031 E.21922
G1 X146.665 Y126.898
G1 X146.665 Y126.34
G1 X146.531 Y126.474
G1 X137.932 Y135.073 E.23442
G1 X137.798 Y135.207
G1 X137.251 Y135.196
G1 X137.385 Y135.063
G1 X146.531 Y125.916 E.24933
G1 X146.665 Y125.783
G1 X146.665 Y125.225
G1 X146.531 Y125.359
G1 X137.385 Y134.505 E.24933
G1 X137.251 Y134.639
G1 X137.251 Y134.081
G1 X137.385 Y133.947
G1 X146.531 Y124.801 E.24933
G1 X146.665 Y124.667
G1 X146.665 Y124.11
G1 X146.531 Y124.244
G1 X137.385 Y133.39 E.24933
G1 X137.251 Y133.524
G1 X137.251 Y132.966
G1 X137.385 Y132.832
G1 X146.531 Y123.686 E.24933
G1 X146.665 Y123.552
G1 X146.665 Y122.995
G1 X146.531 Y123.128
G1 X137.385 Y132.275 E.24933
G1 X137.251 Y132.408
G1 X137.251 Y131.851
G1 X137.385 Y131.717
G1 X146.531 Y122.571 E.24933
G1 X146.665 Y122.437
G1 X146.665 Y121.88
G1 X146.531 Y122.013
G1 X137.385 Y131.16 E.24933
G1 X137.251 Y131.293
G1 X137.251 Y130.736
G1 X137.385 Y130.602
G1 X146.531 Y121.456 E.24933
G1 X146.665 Y121.322
G1 X146.636 Y120.793
G1 X146.503 Y120.927
G1 X137.385 Y130.045 E.24855
G1 X137.251 Y130.178
G1 X137.251 Y129.621
G1 X137.385 Y129.487
G1 X145.945 Y120.927 E.23335
G1 X146.079 Y120.793
G1 X145.521 Y120.793
G1 X145.388 Y120.927
G1 X137.385 Y128.93 E.21815
G1 X137.251 Y129.063
G1 X137.251 Y128.506
G1 X137.385 Y128.372
G1 X144.83 Y120.927 E.20296
G1 X144.964 Y120.793
G1 X144.406 Y120.793
G1 X144.273 Y120.927
G1 X137.385 Y127.814 E.18776
G1 X137.251 Y127.948
G1 X137.251 Y127.391
G1 X137.385 Y127.257
G1 X143.715 Y120.927 E.17256
G1 X143.849 Y120.793
G1 X143.291 Y120.793
G1 X143.157 Y120.927
G1 X137.385 Y126.699 E.15736
G1 X137.251 Y126.833
G1 X137.251 Y126.276
G1 X137.385 Y126.142
G1 X142.6 Y120.927 E.14216
G1 X142.734 Y120.793
G1 X142.176 Y120.793
G1 X142.042 Y120.927
G1 X137.385 Y125.584 E.12696
G1 X137.251 Y125.718
G1 X137.251 Y125.16
G1 X137.385 Y125.027
G1 X141.485 Y120.927 E.11177
G1 X141.618 Y120.793
G1 X141.061 Y120.793
G1 X140.927 Y120.927
G1 X137.385 Y124.469 E.09657
G1 X137.251 Y124.603
G1 X137.251 Y124.045
G1 X137.385 Y123.912
G1 X140.37 Y120.927 E.08137
G1 X140.503 Y120.793
G1 X139.946 Y120.793
G1 X139.812 Y120.927
G1 X137.385 Y123.354 E.06617
G1 X137.251 Y123.488
G1 X137.251 Y122.93
G1 X137.385 Y122.797
G1 X139.255 Y120.927 E.05097
G1 X139.388 Y120.793
G1 X138.831 Y120.793
G1 X138.697 Y120.927
G1 X137.385 Y122.239 E.03577
G1 X137.251 Y122.373
G1 X137.251 Y121.815
G1 X137.385 Y121.682
G1 X138.14 Y120.927 E.02057
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X137.385 Y121.682 E-.40559
G1 X137.251 Y121.815 E-.07182
G1 X137.251 Y122.373 E-.21187
G1 X137.383 Y122.241 E-.07072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.776 Y121.613 Z20.4 F60000
G1 X118.832 Y120.71 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3600
M204 S2000
G1 X109.295 Y120.71 E.18383
G1 X109.252 Y120.71 E.00083
G1 F3480
G1 X109.252 Y135.29 E.28104
G1 F3600
G1 X109.295 Y135.29 E.00083
G1 X118.832 Y135.29 E.18383
G1 X118.832 Y120.77 E.27988
; WIPE_START
M204 S4000
G1 X116.832 Y120.757 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.379 Y128.37 Z20.4 F60000
G1 X117.86 Y135.073 Z20.4
G1 Z20
G1 E.8 F1800
; FEATURE: Top surface
G1 F9000
M204 S2000
G1 X118.615 Y134.318 E.02058
G1 X118.749 Y134.185
G1 X118.749 Y133.627
G1 X118.615 Y133.761
G1 X117.303 Y135.073 E.03578
G1 X117.169 Y135.207
G1 X116.612 Y135.207
G1 X116.745 Y135.073
G1 X118.615 Y133.203 E.05097
G1 X118.749 Y133.07
G1 X118.749 Y132.512
G1 X118.615 Y132.646
G1 X116.188 Y135.073 E.06617
G1 X116.054 Y135.207
G1 X115.496 Y135.207
G1 X115.63 Y135.073
G1 X118.615 Y132.088 E.08137
G1 X118.749 Y131.954
G1 X118.749 Y131.397
G1 X118.615 Y131.531
G1 X115.073 Y135.073 E.09657
G1 X114.939 Y135.207
G1 X114.381 Y135.207
G1 X114.515 Y135.073
G1 X118.615 Y130.973 E.11177
G1 X118.749 Y130.839
G1 X118.749 Y130.282
G1 X118.615 Y130.416
G1 X113.958 Y135.073 E.12697
G1 X113.824 Y135.207
G1 X113.266 Y135.207
G1 X113.4 Y135.073
G1 X118.615 Y129.858 E.14217
G1 X118.749 Y129.724
G1 X118.749 Y129.167
G1 X118.615 Y129.3
G1 X112.842 Y135.073 E.15736
G1 X112.709 Y135.207
G1 X112.151 Y135.207
G1 X112.285 Y135.073
G1 X118.615 Y128.743 E.17256
G1 X118.749 Y128.609
G1 X118.749 Y128.052
G1 X118.615 Y128.185
G1 X111.727 Y135.073 E.18776
G1 X111.594 Y135.207
G1 X111.036 Y135.207
G1 X111.17 Y135.073
G1 X118.615 Y127.628 E.20296
G1 X118.749 Y127.494
G1 X118.749 Y126.937
G1 X118.615 Y127.07
G1 X110.612 Y135.073 E.21816
G1 X110.479 Y135.207
G1 X109.921 Y135.207
G1 X110.055 Y135.073
G1 X118.615 Y126.513 E.23336
G1 X118.749 Y126.379
G1 X118.749 Y125.822
G1 X118.615 Y125.955
G1 X109.497 Y135.073 E.24856
G1 X109.364 Y135.207
G1 X109.335 Y134.678
G1 X109.469 Y134.544
G1 X118.615 Y125.398 E.24933
G1 X118.749 Y125.264
M73 P99 R0
G1 X118.749 Y124.706
G1 X118.615 Y124.84
G1 X109.469 Y133.986 E.24933
G1 X109.335 Y134.12
G1 X109.335 Y133.563
G1 X109.469 Y133.429
G1 X118.615 Y124.283 E.24933
G1 X118.749 Y124.149
G1 X118.749 Y123.591
G1 X118.615 Y123.725
G1 X109.469 Y132.871 E.24933
G1 X109.335 Y133.005
G1 X109.335 Y132.447
G1 X109.469 Y132.314
G1 X118.615 Y123.167 E.24933
G1 X118.749 Y123.034
G1 X118.749 Y122.476
G1 X118.615 Y122.61
G1 X109.469 Y131.756 E.24933
G1 X109.335 Y131.89
G1 X109.335 Y131.332
G1 X109.469 Y131.199
G1 X118.615 Y122.052 E.24933
G1 X118.749 Y121.919
G1 X118.749 Y121.361
G1 X118.615 Y121.495
G1 X109.469 Y130.641 E.24933
G1 X109.335 Y130.775
G1 X109.335 Y130.217
G1 X109.469 Y130.084
G1 X118.615 Y120.937 E.24933
G1 X118.749 Y120.804
G1 X118.202 Y120.793
G1 X118.068 Y120.927
G1 X109.469 Y129.526 E.23442
G1 X109.335 Y129.66
G1 X109.335 Y129.102
G1 X109.469 Y128.969
G1 X117.511 Y120.927 E.21922
G1 X117.644 Y120.793
G1 X117.087 Y120.793
G1 X116.953 Y120.927
G1 X109.469 Y128.411 E.20402
G1 X109.335 Y128.545
G1 X109.335 Y127.987
G1 X109.469 Y127.854
G1 X116.396 Y120.927 E.18882
G1 X116.529 Y120.793
G1 X115.972 Y120.793
G1 X115.838 Y120.927
G1 X109.469 Y127.296 E.17362
G1 X109.335 Y127.43
G1 X109.335 Y126.872
G1 X109.469 Y126.738
G1 X115.28 Y120.927 E.15842
G1 X115.414 Y120.793
G1 X114.857 Y120.793
G1 X114.723 Y120.927
G1 X109.469 Y126.181 E.14323
G1 X109.335 Y126.315
G1 X109.335 Y125.757
G1 X109.469 Y125.623
G1 X114.165 Y120.927 E.12803
G1 X114.299 Y120.793
G1 X113.741 Y120.793
G1 X113.608 Y120.927
G1 X109.469 Y125.066 E.11283
G1 X109.335 Y125.199
G1 X109.335 Y124.642
G1 X109.469 Y124.508
G1 X113.05 Y120.927 E.09763
G1 X113.184 Y120.793
G1 X112.626 Y120.793
G1 X112.493 Y120.927
G1 X109.469 Y123.951 E.08243
G1 X109.335 Y124.084
G1 X109.335 Y123.527
G1 X109.469 Y123.393
G1 X111.935 Y120.927 E.06723
G1 X112.069 Y120.793
G1 X111.511 Y120.793
G1 X111.378 Y120.927
G1 X109.469 Y122.836 E.05204
G1 X109.335 Y122.969
G1 X109.335 Y122.412
G1 X109.469 Y122.278
G1 X110.82 Y120.927 E.03684
G1 X110.954 Y120.793
G1 X110.396 Y120.793
G1 X110.263 Y120.927
G1 X109.469 Y121.721 E.02164
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9000
M204 S4000
G1 X110.263 Y120.927 E-.42657
G1 X110.396 Y120.793 E-.07182
G1 X110.954 Y120.793 E-.21186
G1 X110.861 Y120.886 E-.04975
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z20.4 I1.217 J0 P1  F60000
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;======== X2D end gcode ==========
;===== 2026/05/18 =====

M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
M211 Z1

G90
G1 Z20.4 F900 ; lower z a little
M1002 judge_flag timelapse_record_flag
M622 J1
    G150.3
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S5 ;wait for last picture to be taken
M623  ;end of "timelapse_record_flag"

G90
G1 Z30 F900 ; lower z a little

M140 S0 ; turn off bed
M141 S0 ; turn off chamber heating
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan
M106 P10 S0 ; turn off remote part1 cooling fan

; pull back filament to AMS
M620 S65279 B
; M620.11 P1 L0 I65279 E-3
T65279
G150.1 F8000
M621 S65279 B

M620 S65535 B
; M620.11 P1 L0 I65535 E-4
T65535
G150.1 F8000
M621 S65535 B

G150.3

M104 S0 T0; turn off hotend
M104 S0 T1; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    
        G1 Z90 F600
        G1 Z88
    

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2 R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M1015.3 S0 ;disable clog detect
M1015.4 S0 K0 ;disable air printing detect

;=====printer finish air purification=========
M622.1 S0
M1002 judge_flag print_finish_air_filt_flag

M622 J1
M1002 gcode_claim_action : 66
M145 P1
M106 P10 S255
M400 S180
M106 P10 S0
M623

M622 J2
M1002 gcode_claim_action : 66
M145 P0
M106 P3 S255
M400 S180
M106 P3 S0
M623
;=====printer finish air purification=========

;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 
M1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 
M1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A48 B10 L50 C48 D10 M50 E48 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A60 B10 L50 C60 D10 M50 E60 F10 N50 
M1006 W
;=====printer finish  sound=========
M400
M18

M73 P100 R0
; EXECUTABLE_BLOCK_END

