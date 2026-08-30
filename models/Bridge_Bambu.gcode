; HEADER_BLOCK_START
; BambuStudio 02.08.02.60
; model printing time: 8m 28s; total estimated time: 13m 36s
; total layer number: 66
; total filament length [mm] : 529.94
; total filament volume [cm^3] : 1274.65
; total filament weight [g] : 1.61
; filament_density: 1.26,1.26,1.26
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 8.00
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
M73 P0 R13
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
M73 P3 R13
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
    
      G29 A1 X103 Y123 I50 J10 R
    
    M400
  M623

  M622 J2
    M1002 gcode_claim_action : 1
    
      G29 A2 X103 Y123 I50 J10 R
    
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
M73 P5 R12
  G1 X128 Y128 F20000
M73 P36 R8
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
M73 P37 R8
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
; OBJECT_ID: 338
G1 X152.143 Y132.143 F60000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X152.143 Y123.857 E.30862
G1 X148.857 Y123.857 E.12239
G1 X148.857 Y132.143 E.30862
G1 X152.083 Y132.143 E.12015
M204 S6000
G1 X152.6 Y132.6 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X152.6 Y123.4 E.34267
G1 X148.4 Y123.4 E.15643
G1 X148.4 Y132.6 E.34267
G1 X152.54 Y132.6 E.1542
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
G1 X152.553 Y130.6 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X151.96 Y125.019 Z.6 F60000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52606
G1 F4023
M204 S500
G1 X151.187 Y124.245 E.04307
G1 X150.503 Y124.245 E.0269
G1 X151.755 Y125.497 E.06966
G1 X151.755 Y126.18 E.0269
G1 X149.82 Y124.245 E.1077
G1 X149.245 Y124.245 E.02262
M73 P38 R8
G1 X149.245 Y124.354 E.00428
G1 X151.755 Y126.863 E.1397
G1 X151.755 Y127.546 E.0269
G1 X149.245 Y125.037 E.1397
G1 X149.245 Y125.721 E.0269
G1 X151.755 Y128.23 E.1397
G1 X151.755 Y128.913 E.0269
G1 X149.245 Y126.404 E.1397
G1 X149.245 Y127.087 E.0269
G1 X151.755 Y129.596 E.1397
G1 X151.755 Y130.279 E.0269
G1 X149.245 Y127.77 E.1397
G1 X149.245 Y128.454 E.0269
G1 X151.755 Y130.963 E.1397
G1 X151.755 Y131.646 E.0269
G1 X149.245 Y129.137 E.1397
G1 X149.245 Y129.82 E.0269
G1 X151.18 Y131.755 E.1077
G1 X150.497 Y131.755 E.0269
G1 X149.245 Y130.503 E.06965
G1 X149.245 Y131.187 E.0269
G1 X150.019 Y131.96 E.04306
; WIPE_START
G1 F6300
G1 X149.245 Y131.187 E-.41565
G1 X149.245 Y130.503 E-.25964
G1 X149.403 Y130.661 E-.08471
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X141.868 Y129.448 Z.6 F60000
G1 X107.143 Y123.857 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X103.857 Y123.857 E.12239
G1 X103.857 Y132.143 E.30862
G1 X107.143 Y132.143 E.12239
G1 X107.143 Y123.917 E.30638
M204 S6000
G1 X107.6 Y123.4 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X103.4 Y123.4 E.15643
G1 X103.4 Y132.6 E.34267
G1 X107.6 Y132.6 E.15643
G1 X107.6 Y123.46 E.34043
; WIPE_START
G1 X105.6 Y123.431 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X105.981 Y124.04 Z.6 F60000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52606
G1 F4023
M204 S500
G1 X106.755 Y124.813 E.04307
G1 X106.755 Y125.497 E.0269
G1 X105.503 Y124.245 E.06966
G1 X104.82 Y124.245 E.0269
G1 X106.755 Y126.18 E.1077
G1 X106.755 Y126.863 E.0269
G1 X104.245 Y124.354 E.1397
G1 X104.245 Y125.037 E.0269
G1 X106.755 Y127.546 E.1397
G1 X106.755 Y128.23 E.0269
G1 X104.245 Y125.721 E.1397
G1 X104.245 Y126.404 E.0269
G1 X106.755 Y128.913 E.1397
G1 X106.755 Y129.596 E.0269
G1 X104.245 Y127.087 E.1397
G1 X104.245 Y127.77 E.0269
G1 X106.755 Y130.279 E.1397
G1 X106.755 Y130.963 E.0269
G1 X104.245 Y128.454 E.1397
G1 X104.245 Y129.137 E.0269
G1 X106.755 Y131.646 E.1397
G1 X106.755 Y131.755 E.00427
G1 X106.18 Y131.755 E.02263
G1 X104.245 Y129.82 E.1077
G1 X104.245 Y130.503 E.0269
G1 X105.496 Y131.755 E.06965
G1 X104.813 Y131.755 E.0269
G1 X104.04 Y130.981 E.04306
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6300
G1 X104.813 Y131.755 E-.41565
G1 X105.496 Y131.755 E-.25964
G1 X105.339 Y131.597 E-.08471
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
; OBJECT_ID: 338
M204 S10000
G17
G3 Z.6 I-.02 J1.217 P1  F60000
G1 X152.381 Y132.381 Z.6
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4146
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.257 Y130.743 Z.72 F60000
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511672
G1 F4146
M204 S4000
G1 X150.743 Y130.743 E.01154
G1 X150.743 Y125.257 E.13033
G1 X150.257 Y125.257 E.01154
M73 P39 R8
G1 X150.257 Y130.683 E.12891
M204 S10000
G1 X149.817 Y131.183 F60000
; LINE_WIDTH: 0.419992
G1 F4146
M204 S4000
G1 X151.183 Y131.183 E.02633
G1 X151.183 Y124.817 E.12271
G1 X149.817 Y124.817 E.02633
G1 X149.817 Y131.123 E.12155
M204 S10000
G1 X149.423 Y131.577 F60000
G1 F4146
M204 S4000
G1 X151.577 Y131.577 E.04153
G1 X151.577 Y124.423 E.13791
G1 X149.423 Y124.423 E.04153
G1 X149.423 Y131.517 E.13675
M204 S10000
G1 X149.028 Y131.972 F60000
G1 F4146
M204 S4000
G1 X151.972 Y131.972 E.05673
G1 X151.972 Y124.028 E.15311
G1 X149.028 Y124.028 E.05673
G1 X149.028 Y131.912 E.15195
; WIPE_START
G1 F10800
G1 X149.028 Y129.912 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.482 Y128.771 Z.72 F60000
G1 X107.381 Y123.619 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4146
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.743 Y125.5 Z.72 F60000
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511682
G1 F4146
M204 S4000
G1 X105.743 Y125.257 E.00577
G1 X105.257 Y125.257 E.01154
G1 X105.257 Y130.743 E.13034
G1 X105.743 Y130.743 E.01154
G1 X105.743 Y125.56 E.12314
M204 S10000
G1 X106.183 Y125.5 F60000
; LINE_WIDTH: 0.419992
G1 F4146
M204 S4000
G1 X106.183 Y124.817 E.01317
G1 X104.817 Y124.817 E.02633
G1 X104.817 Y131.183 E.12271
G1 X106.183 Y131.183 E.02633
G1 X106.183 Y125.56 E.10839
M204 S10000
G1 X106.577 Y125.5 F60000
G1 F4146
M204 S4000
G1 X106.577 Y124.423 E.02076
G1 X104.423 Y124.423 E.04153
G1 X104.423 Y131.577 E.13791
G1 X106.577 Y131.577 E.04153
G1 X106.577 Y125.56 E.11599
M204 S10000
G1 X106.972 Y125.5 F60000
G1 F4146
M204 S4000
G1 X106.972 Y124.028 E.02836
G1 X104.028 Y124.028 E.05673
G1 X104.028 Y131.972 E.15311
G1 X106.972 Y131.972 E.05673
G1 X106.972 Y125.56 E.12358
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X106.972 Y127.56 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L3
M991 S0 P2 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.72 I-.128 J1.21 P1  F60000
G1 X152.381 Y132.381 Z.72
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2481
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.257 Y130.743 Z.84 F60000
G1 Z.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511672
G1 F4132
M204 S4000
G1 X150.743 Y130.743 E.01154
G1 X150.743 Y125.257 E.13033
G1 X150.257 Y125.257 E.01154
G1 X150.257 Y130.683 E.12891
M204 S10000
G1 X149.817 Y131.183 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X151.183 Y131.183 E.02633
G1 X151.183 Y124.817 E.12271
G1 X149.817 Y124.817 E.02633
G1 X149.817 Y131.123 E.12155
M204 S10000
G1 X149.423 Y131.577 F60000
G1 F4132
M204 S4000
G1 X151.577 Y131.577 E.04153
G1 X151.577 Y124.423 E.13791
G1 X149.423 Y124.423 E.04153
G1 X149.423 Y131.517 E.13675
M204 S10000
G1 X149.028 Y131.972 F60000
G1 F4132
M204 S4000
G1 X151.972 Y131.972 E.05673
G1 X151.972 Y124.028 E.15311
G1 X149.028 Y124.028 E.05673
G1 X149.028 Y131.912 E.15195
; COOLING_NODE: 0
; WIPE_START
G1 F10800
G1 X149.028 Y129.912 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.482 Y128.771 Z.84 F60000
G1 X107.381 Y123.619 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2481
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.743 Y125.5 Z.84 F60000
G1 Z.44
M73 P40 R8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511682
G1 F4132
M204 S4000
G1 X105.743 Y125.257 E.00577
G1 X105.257 Y125.257 E.01154
G1 X105.257 Y130.743 E.13034
G1 X105.743 Y130.743 E.01154
G1 X105.743 Y125.56 E.12314
M204 S10000
G1 X106.183 Y125.5 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X106.183 Y124.817 E.01317
G1 X104.817 Y124.817 E.02633
G1 X104.817 Y131.183 E.12271
G1 X106.183 Y131.183 E.02633
G1 X106.183 Y125.56 E.10839
M204 S10000
G1 X106.577 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.577 Y124.423 E.02076
G1 X104.423 Y124.423 E.04153
G1 X104.423 Y131.577 E.13791
G1 X106.577 Y131.577 E.04153
G1 X106.577 Y125.56 E.11599
M204 S10000
G1 X106.972 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.972 Y124.028 E.02836
G1 X104.028 Y124.028 E.05673
G1 X104.028 Y131.972 E.15311
G1 X106.972 Y131.972 E.05673
G1 X106.972 Y125.56 E.12358
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X106.972 Y127.56 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L4
M991 S0 P3 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.84 I-.128 J1.21 P1  F60000
G1 X152.381 Y132.381 Z.84
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2407
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.257 Y130.743 Z.96 F60000
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511672
G1 F4132
M204 S4000
G1 X150.743 Y130.743 E.01154
G1 X150.743 Y125.257 E.13033
G1 X150.257 Y125.257 E.01154
G1 X150.257 Y130.683 E.12891
M204 S10000
G1 X149.817 Y131.183 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X151.183 Y131.183 E.02633
G1 X151.183 Y124.817 E.12271
G1 X149.817 Y124.817 E.02633
G1 X149.817 Y131.123 E.12155
M204 S10000
G1 X149.423 Y131.577 F60000
G1 F4132
M204 S4000
G1 X151.577 Y131.577 E.04153
G1 X151.577 Y124.423 E.13791
G1 X149.423 Y124.423 E.04153
G1 X149.423 Y131.517 E.13675
M204 S10000
G1 X149.028 Y131.972 F60000
G1 F4132
M204 S4000
G1 X151.972 Y131.972 E.05673
G1 X151.972 Y124.028 E.15311
G1 X149.028 Y124.028 E.05673
G1 X149.028 Y131.912 E.15195
; COOLING_NODE: 0
; WIPE_START
G1 F10800
G1 X149.028 Y129.912 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.482 Y128.771 Z.96 F60000
G1 X107.381 Y123.619 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2407
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.743 Y125.5 Z.96 F60000
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511682
G1 F4132
M204 S4000
G1 X105.743 Y125.257 E.00577
G1 X105.257 Y125.257 E.01154
G1 X105.257 Y130.743 E.13034
G1 X105.743 Y130.743 E.01154
G1 X105.743 Y125.56 E.12314
M204 S10000
G1 X106.183 Y125.5 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X106.183 Y124.817 E.01317
G1 X104.817 Y124.817 E.02633
G1 X104.817 Y131.183 E.12271
G1 X106.183 Y131.183 E.02633
G1 X106.183 Y125.56 E.10839
M204 S10000
G1 X106.577 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.577 Y124.423 E.02076
G1 X104.423 Y124.423 E.04153
G1 X104.423 Y131.577 E.13791
G1 X106.577 Y131.577 E.04153
G1 X106.577 Y125.56 E.11599
M204 S10000
G1 X106.972 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.972 Y124.028 E.02836
G1 X104.028 Y124.028 E.05673
G1 X104.028 Y131.972 E.15311
G1 X106.972 Y131.972 E.05673
G1 X106.972 Y125.56 E.12358
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X106.972 Y127.56 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L5
M991 S0 P4 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.96 I-.128 J1.21 P1  F60000
G1 X152.381 Y132.381 Z.96
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2356
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
M73 P41 R8
G1 E-.04 F1800
M204 S10000
G1 X150.257 Y130.743 Z1.08 F60000
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511672
G1 F4132
M204 S4000
G1 X150.743 Y130.743 E.01154
G1 X150.743 Y125.257 E.13033
G1 X150.257 Y125.257 E.01154
G1 X150.257 Y130.683 E.12891
M204 S10000
G1 X149.817 Y131.183 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X151.183 Y131.183 E.02633
G1 X151.183 Y124.817 E.12271
G1 X149.817 Y124.817 E.02633
G1 X149.817 Y131.123 E.12155
M204 S10000
G1 X149.423 Y131.577 F60000
G1 F4132
M204 S4000
G1 X151.577 Y131.577 E.04153
G1 X151.577 Y124.423 E.13791
G1 X149.423 Y124.423 E.04153
G1 X149.423 Y131.517 E.13675
M204 S10000
G1 X149.028 Y131.972 F60000
G1 F4132
M204 S4000
G1 X151.972 Y131.972 E.05673
G1 X151.972 Y124.028 E.15311
G1 X149.028 Y124.028 E.05673
G1 X149.028 Y131.912 E.15195
; COOLING_NODE: 0
; WIPE_START
G1 F10800
G1 X149.028 Y129.912 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.482 Y128.771 Z1.08 F60000
G1 X107.381 Y123.619 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4132
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
M73 P41 R7
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2356
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.743 Y125.5 Z1.08 F60000
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.511682
G1 F4132
M204 S4000
G1 X105.743 Y125.257 E.00577
G1 X105.257 Y125.257 E.01154
G1 X105.257 Y130.743 E.13034
G1 X105.743 Y130.743 E.01154
G1 X105.743 Y125.56 E.12314
M204 S10000
G1 X106.183 Y125.5 F60000
; LINE_WIDTH: 0.419992
G1 F4132
M204 S4000
G1 X106.183 Y124.817 E.01317
G1 X104.817 Y124.817 E.02633
G1 X104.817 Y131.183 E.12271
G1 X106.183 Y131.183 E.02633
G1 X106.183 Y125.56 E.10839
M204 S10000
G1 X106.577 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.577 Y124.423 E.02076
G1 X104.423 Y124.423 E.04153
G1 X104.423 Y131.577 E.13791
G1 X106.577 Y131.577 E.04153
G1 X106.577 Y125.56 E.11599
M204 S10000
G1 X106.972 Y125.5 F60000
G1 F4132
M204 S4000
G1 X106.972 Y124.028 E.02836
G1 X104.028 Y124.028 E.05673
G1 X104.028 Y131.972 E.15311
G1 X106.972 Y131.972 E.05673
G1 X106.972 Y125.56 E.12358
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X106.972 Y127.56 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L6
M991 S0 P5 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.08 I-.128 J1.21 P1  F60000
G1 X152.381 Y132.381 Z1.08
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.132 Z1.2 F60000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X152.018 Y132.018 E.01837
G1 X151.207 Y132.018 E.01683
G1 X150.975 Y131.642 E.00917
G3 X149.071 Y130.276 I2.834 J-5.962 E.04886
G1 X148.982 Y130.132 E.00352
G1 X148.982 Y127.851 E.04732
G2 X150.628 Y126.634 I-2.665 J-5.328 E.04266
G2 X151.255 Y124.814 I-3.318 J-2.162 E.04035
G1 X150.975 Y124.358 E.01109
G1 X150.324 Y123.982 E.01561
G1 X152.018 Y123.984 E.03515
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X150.324 Y123.982 E-.64391
G1 X150.588 Y124.135 E-.11609
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.956 Y124.044 Z1.2 F60000
G1 X107.381 Y123.619 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
M73 P42 R7
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.928 Y123.982 Z1.2 F60000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X106.625 Y123.982 E.0352
G1 X107.018 Y124.209 E.00941
G1 X107.018 Y126.49 E.04732
G3 X105.813 Y127.545 I-2.824 J-2.012 E.03352
G1 X105.025 Y128 E.01887
G1 X104.745 Y128.455 E.01109
G1 X104.775 Y128.91 E.00946
G2 X106.489 Y131.186 I3.14 J-.581 E.06126
G1 X107.018 Y131.492 E.01268
G1 X107.018 Y132.018 E.01091
G1 X105.847 Y132.018 E.02429
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.44505
G1 X107.018 Y131.492 E-.19981
G1 X106.756 Y131.341 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L7
M991 S0 P6 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.2 I-.028 J1.217 P1  F60000
G1 X152.381 Y132.381 Z1.2
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2380
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2277
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.717 Y132.018 Z1.32 F60000
G1 Z.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2380
M204 S4000
G1 X152.018 Y132.018 E.00625
G1 X152.018 Y131.824 E.00403
G2 X151.505 Y132.018 I-.143 J.398 E.01239
G1 X149.808 Y132.018 E.0352
M204 S10000
G1 X152.018 Y128.889 F60000
G1 F2380
M204 S4000
G1 X152.018 Y130.586 E.0352
G1 X151.67 Y131.431 E.01895
G3 X150.76 Y131.325 I-.324 J-1.177 E.01949
G3 X148.982 Y130.174 I1.024 J-3.529 E.04457
G1 X148.982 Y127.665 E.05204
G2 X151.215 Y125.674 I-.936 J-3.298 E.0642
G1 X151.67 Y124.569 E.02479
G1 X152.018 Y124.541 E.00724
G1 X152.018 Y123.982 E.01159
G1 X151.738 Y123.982 E.0058
G1 X151.67 Y124.148 E.00372
G3 X150.624 Y123.982 I-.251 J-1.798 E.0223
G1 X148.982 Y123.982 E.03405
G1 X148.982 Y124.037 E.00115
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y123.982 E-.02102
G1 X150.624 Y123.982 E-.62384
G1 X150.91 Y124.08 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.278 Y123.999 Z1.32 F60000
G1 X107.381 Y123.619 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2380
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2277
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.982 Y125.248 Z1.32 F60000
G1 Z.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2380
M204 S4000
G1 X103.982 Y126.945 E.0352
G1 X104.33 Y127.79 E.01895
G2 X105.24 Y127.684 I.324 J-1.177 E.01949
G2 X107.018 Y126.532 I-1.024 J-3.529 E.04456
G1 X107.018 Y131.306 E.09903
G3 X104.785 Y129.316 I.936 J-3.298 E.0642
G1 X104.33 Y128.211 E.02479
G1 X103.982 Y128.182 E.00724
G1 X103.982 Y129.879 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y128.182 E-.64486
G1 X104.284 Y128.207 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L8
M991 S0 P7 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.32 I-.105 J1.212 P1  F60000
G1 X152.381 Y132.381 Z1.32
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2231
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2231
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y132.008 Z1.44 F60000
M73 P43 R7
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2231
M204 S4000
G1 X152.018 Y130.311 E.0352
G1 X151.67 Y130.892 E.01405
G1 X151.215 Y131.188 E.01126
G1 X150.76 Y131.174 E.00945
G3 X148.982 Y130.213 I.578 J-3.194 E.04262
G1 X148.982 Y127.518 E.0559
G2 X151.215 Y125.868 I-.538 J-3.064 E.05969
G1 X151.67 Y125.108 E.01838
G1 X152.018 Y124.882 E.0086
G1 X152.018 Y123.982 E.01867
G1 X151.221 Y123.982 E.01653
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.3028
G1 X152.018 Y124.882 E-.34206
G1 X151.764 Y125.047 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.135 Y124.802 Z1.44 F60000
G1 X107.381 Y123.619 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2231
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2231
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y124.874 Z1.44 F60000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2231
M204 S4000
G1 X107.018 Y126.571 E.0352
G3 X105.24 Y127.532 I-2.355 J-2.233 E.04262
G1 X104.785 Y127.546 E.00945
G1 X104.33 Y127.25 E.01126
G1 X103.982 Y126.669 E.01405
G1 X103.982 Y128.524 E.03846
G1 X104.33 Y128.75 E.00861
G1 X104.785 Y129.51 E.01838
G2 X107.018 Y131.159 I2.771 J-1.414 E.05969
G1 X107.018 Y132.018 E.01781
G1 X106.18 Y132.018 E.01739
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.31862
G1 X107.018 Y131.159 E-.32624
G1 X106.73 Y131.064 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L9
M991 S0 P8 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.44 I-.035 J1.216 P1  F60000
G1 X152.381 Y132.381 Z1.44
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.864 Z1.56 F60000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X152.018 Y130.167 E.0352
G3 X151.215 Y130.975 I-1.856 J-1.04 E.02393
G1 X150.76 Y131.042 E.00954
G3 X148.982 Y130.255 I.231 J-2.925 E.0411
G1 X148.982 Y127.39 E.05943
G2 X150.76 Y126.578 I-.259 J-2.919 E.04133
G1 X151.67 Y125.373 E.03133
G1 X152.018 Y125.107 E.00908
G1 X152.018 Y123.982 E.02333
G1 X151.446 Y123.982 E.01187
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.21749
G1 X152.018 Y125.107 E-.42737
G1 X151.777 Y125.291 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.15 Y125.004 Z1.56 F60000
G1 X107.381 Y123.619 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y124.917 Z1.56 F60000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X107.018 Y126.614 E.0352
G3 X105.24 Y127.4 I-2.009 J-2.139 E.0411
G1 X104.785 Y127.334 E.00954
G3 X103.982 Y126.525 I1.053 J-1.848 E.02394
G1 X103.982 Y128.748 E.04611
G1 X104.33 Y129.014 E.00909
G1 X105.24 Y130.22 E.03133
G2 X107.018 Y131.032 I2.037 J-2.108 E.04133
G1 X107.018 Y132.018 E.02046
G1 X106.307 Y132.018 E.01474
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.26999
G1 X107.018 Y131.032 E-.37487
G1 X106.723 Y130.963 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L10
M991 S0 P9 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.56 I-.038 J1.216 P1  F60000
G1 X152.381 Y132.381 Z1.56
M73 P44 R7
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.724 Z1.68 F60000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X152.018 Y130.027 E.0352
G3 X151.215 Y130.802 I-2.542 J-1.831 E.02327
G3 X148.982 Y130.3 I-.667 J-2.247 E.0496
G1 X148.982 Y127.282 E.0626
G2 X150.76 Y126.628 I.066 J-2.564 E.04024
G1 X151.67 Y125.567 E.02898
G1 X152.018 Y125.285 E.0093
G1 X152.018 Y123.982 E.02703
G1 X151.624 Y123.982 E.00817
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.14975
G1 X152.018 Y125.285 E-.49511
G1 X151.783 Y125.476 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.157 Y125.157 Z1.68 F60000
G1 X107.381 Y123.619 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y124.961 Z1.68 F60000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X107.018 Y126.658 E.0352
G3 X104.785 Y127.161 I-1.565 J-1.745 E.04959
G3 X103.982 Y126.386 I1.739 J-2.606 E.02327
G1 X103.982 Y128.926 E.0527
G1 X104.33 Y129.209 E.0093
G1 X105.24 Y130.269 E.02898
G2 X107.018 Y130.923 I1.712 J-1.91 E.04024
G1 X107.018 Y132.018 E.02271
G1 X106.416 Y132.018 E.01249
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.22887
G1 X107.018 Y130.923 E-.41599
G1 X106.715 Y130.911 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L11
M991 S0 P10 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.68 I-.039 J1.216 P1  F60000
G1 X152.381 Y132.381 Z1.68
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.606 Z1.8 F60000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X152.018 Y129.909 E.0352
G3 X150.76 Y130.822 I-2.193 J-1.698 E.03269
G3 X148.982 Y130.348 I-.326 J-2.348 E.03919
G1 X148.982 Y127.182 E.06566
G2 X150.76 Y126.68 I.281 J-2.402 E.03932
G3 X152.018 Y125.436 I6.294 J5.107 E.03678
G1 X152.018 Y123.982 E.03015
G1 X151.775 Y123.982 E.00505
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.09251
G1 X152.018 Y125.436 E-.55235
G1 X151.803 Y125.649 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.178 Y125.3 Z1.8 F60000
G1 X107.381 Y123.619 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
M73 P45 R7
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y125.01 Z1.8 F60000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X107.018 Y126.706 E.0352
G3 X105.24 Y127.18 I-1.451 J-1.874 E.03919
G3 X103.982 Y126.267 I.935 J-2.612 E.03269
G1 X103.982 Y129.077 E.05829
G3 X105.24 Y130.321 I-5.037 J6.353 E.03678
G2 X107.018 Y130.824 I1.497 J-1.899 E.03932
G1 X107.018 Y132.018 E.02477
G1 X106.515 Y132.018 E.01043
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.19108
G1 X107.018 Y130.824 E-.45377
G1 X106.715 Y130.839 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L12
M991 S0 P11 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.8 I-.041 J1.216 P1  F60000
G1 X152.381 Y132.381 Z1.8
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2231
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.461 Z1.92 F60000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2231
M204 S4000
G1 X152.018 Y129.764 E.0352
G3 X150.76 Y130.729 I-2.562 J-2.037 E.03323
G3 X148.982 Y130.4 I-.511 J-2.206 E.03858
G1 X148.982 Y127.093 E.06858
G2 X151.215 Y126.35 I.44 J-2.404 E.05094
G3 X152.018 Y125.568 I4.198 J3.511 E.02329
G1 X152.018 Y123.982 E.0329
G1 X151.907 Y123.982 E.0023
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.04217
G1 X152.018 Y125.568 E-.60269
G1 X151.801 Y125.779 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.177 Y125.409 Z1.92 F60000
G1 X107.381 Y123.619 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2231
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y125.061 Z1.92 F60000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2231
M204 S4000
G1 X107.018 Y126.758 E.0352
G3 X105.24 Y127.088 I-1.267 J-1.876 E.03858
G3 X103.982 Y126.122 I1.304 J-3.002 E.03323
G1 X103.982 Y129.21 E.06403
G3 X104.785 Y129.991 I-3.396 J4.293 E.02329
G2 X107.018 Y130.735 I1.793 J-1.66 E.05093
G1 X107.018 Y132.018 E.02661
G1 X106.604 Y132.018 E.00859
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.15733
G1 X107.018 Y130.735 E-.48753
G1 X106.718 Y130.775 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L13
M991 S0 P12 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.92 I-.043 J1.216 P1  F60000
G1 X152.381 Y132.381 Z1.92
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2235
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.354 Z2.04 F60000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2235
M204 S4000
G1 X152.018 Y129.657 E.0352
G3 X150.76 Y130.646 I-3.225 J-2.809 E.03339
M73 P46 R7
G3 X148.982 Y130.455 I-.676 J-2.081 E.0382
G1 X148.982 Y127.014 E.07139
G2 X151.67 Y125.996 I.596 J-2.485 E.06331
G1 X152.018 Y125.688 E.00964
G1 X152.018 Y123.991 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y125.688 E-.64486
G1 X151.791 Y125.889 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.169 Y125.5 Z2.04 F60000
G1 X107.381 Y123.619 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2235
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y125.117 Z2.04 F60000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2235
M204 S4000
G1 X107.018 Y126.814 E.0352
G3 X105.24 Y127.004 I-1.102 J-1.891 E.0382
G3 X103.982 Y126.015 I1.967 J-3.798 E.0334
G1 X103.982 Y129.33 E.06875
G1 X104.33 Y129.638 E.00964
G2 X107.018 Y130.655 I2.092 J-1.468 E.06331
G1 X107.018 Y132.018 E.02827
G1 X106.684 Y132.018 E.00693
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.12696
G1 X107.018 Y130.655 E-.5179
G1 X106.722 Y130.719 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L14
M991 S0 P13 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.04 I-.044 J1.216 P1  F60000
G1 X152.381 Y132.381 Z2.04
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2239
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.248 Z2.16 F60000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2239
M204 S4000
G1 X152.018 Y129.551 E.0352
G3 X150.76 Y130.57 I-4.272 J-3.989 E.03369
G3 X148.982 Y130.516 I-.829 J-1.99 E.03803
G1 X148.982 Y126.941 E.07415
G2 X151.67 Y126.118 I.787 J-2.232 E.06243
G1 X152.018 Y125.801 E.00977
G1 X152.018 Y124.104 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y125.801 E-.64486
G1 X151.794 Y126.005 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.173 Y125.596 Z2.16 F60000
G1 X107.381 Y123.619 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2239
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y125.177 Z2.16 F60000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2239
M204 S4000
G1 X107.018 Y126.874 E.0352
G3 X105.24 Y126.929 I-.949 J-1.935 E.03803
G3 X103.982 Y125.909 I3.014 J-5.008 E.0337
G1 X103.982 Y129.442 E.07328
G1 X104.33 Y129.76 E.00978
G2 X107.018 Y130.583 I1.901 J-1.409 E.06243
G1 X107.018 Y132.018 E.02977
G1 X106.756 Y132.018 E.00543
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y132.018 E-.09945
G1 X107.018 Y130.583 E-.5454
G1 X106.727 Y130.668 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L15
M991 S0 P14 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.16 I-.046 J1.216 P1  F60000
G1 X152.381 Y132.381 Z2.16
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2240
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
M73 P47 R7
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.243 Y132.018 Z2.28 F60000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2240
M204 S4000
G1 X148.982 Y132.018 E.00541
G1 X148.982 Y130.582 E.02979
G2 X150.76 Y130.501 I.798 J-2.025 E.03803
G2 X152.018 Y129.444 I-4.955 J-7.175 E.03414
G1 X152.018 Y125.908 E.07333
G1 X151.67 Y126.239 E.00995
G3 X148.982 Y126.875 I-1.74 J-1.353 E.06193
G1 X148.982 Y125.178 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.875 E-.64486
G1 X149.266 Y126.98 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.658 Y126.37 Z2.28 F60000
G1 X107.381 Y123.619 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2240
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2228
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.982 Y124.105 Z2.28 F60000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2240
M204 S4000
G1 X103.982 Y125.802 E.0352
G2 X105.24 Y126.859 I6.213 J-6.117 E.03414
G2 X107.018 Y126.94 I.979 J-1.944 E.03802
G1 X107.018 Y130.517 E.07419
G3 X104.33 Y129.88 I-.948 J-1.989 E.06193
G1 X103.982 Y129.55 E.00995
G1 X103.982 Y131.247 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y129.55 E-.64486
G1 X104.202 Y129.758 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L16
M991 S0 P15 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.28 I-.066 J1.215 P1  F60000
G1 X152.381 Y132.381 Z2.28
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2236
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.315 Y132.018 Z2.4 F60000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2236
M204 S4000
G1 X148.982 Y132.018 E.00691
G1 X148.982 Y130.654 E.02829
G2 X150.76 Y130.437 I.641 J-2.132 E.03823
G2 X152.018 Y129.331 I-9.852 J-12.483 E.03476
G1 X152.018 Y126.014 E.06881
G1 X151.67 Y126.361 E.01019
G3 X148.982 Y126.815 I-1.615 J-1.378 E.0614
G1 X148.982 Y125.118 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.815 E-.64486
G1 X149.258 Y126.939 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.65 Y126.336 Z2.4 F60000
G1 X107.381 Y123.619 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2236
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.982 Y123.993 Z2.4 F60000
M73 P48 R7
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2236
M204 S4000
G1 X103.982 Y125.69 E.0352
G2 X105.24 Y126.795 I11.112 J-11.379 E.03476
G2 X107.018 Y127.013 I1.136 J-1.915 E.03823
G1 X107.018 Y130.456 E.07143
G3 X104.33 Y130.002 I-1.073 J-1.832 E.0614
G1 X103.982 Y129.655 E.01019
G1 X103.982 Y131.352 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y129.655 E-.64486
G1 X104.197 Y129.869 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L17
M991 S0 P16 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.4 I-.063 J1.215 P1  F60000
G1 X152.381 Y132.381 Z2.4
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2232
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.395 Y132.018 Z2.52 F60000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2232
M204 S4000
G1 X148.982 Y132.018 E.00856
G1 X148.982 Y130.734 E.02664
G2 X150.76 Y130.377 I.472 J-2.258 E.03865
G2 X152.018 Y129.211 I-46.567 J-51.507 E.03559
G1 X152.018 Y126.121 E.0641
G1 X151.67 Y126.489 E.0105
G3 X148.982 Y126.759 I-1.5 J-1.422 E.06107
G1 X148.982 Y125.062 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.759 E-.64486
G1 X149.249 Y126.901 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.64 Y126.305 Z2.52 F60000
G1 X107.381 Y123.619 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2232
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.091 Y123.982 Z2.52 F60000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2232
M204 S4000
M73 P48 R6
G1 X103.982 Y123.982 E.00227
G1 X103.982 Y125.57 E.03293
G2 X105.24 Y126.736 I47.882 J-50.402 E.03559
G2 X107.018 Y127.092 I1.306 J-1.901 E.03865
G1 X107.018 Y130.4 E.06862
G3 X104.33 Y130.131 I-1.188 J-1.692 E.06107
G1 X103.982 Y129.763 E.01051
G1 X103.982 Y131.46 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y129.763 E-.64486
G1 X104.19 Y129.983 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L18
M991 S0 P17 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.52 I-.06 J1.215 P1  F60000
G1 X152.381 Y132.381 Z2.52
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2229
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.484 Y132.018 Z2.64 F60000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2229
M204 S4000
G1 X148.982 Y132.018 E.0104
G1 X148.982 Y130.823 E.02479
G2 X150.76 Y130.322 I.283 J-2.4 E.03931
G3 X152.018 Y129.079 I6.333 J5.152 E.03676
G1 X152.018 Y126.266 E.05836
G3 X151.215 Y127.011 I-3.824 J-3.313 E.02278
G3 X148.982 Y126.707 I-.857 J-2.054 E.04901
G1 X148.982 Y125.01 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.707 E-.64486
G1 X149.239 Y126.867 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.63 Y126.276 Z2.64 F60000
G1 X107.381 Y123.619 Z2.64
G1 Z2.24
M73 P49 R6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2229
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.224 Y123.982 Z2.64 F60000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2229
M204 S4000
G1 X103.982 Y123.982 E.00501
G1 X103.982 Y125.437 E.03019
G3 X105.24 Y126.68 I-5.075 J6.396 E.03676
G2 X107.018 Y127.181 I1.494 J-1.899 E.03931
G1 X107.018 Y130.349 E.0657
G3 X104.785 Y130.653 I-1.375 J-1.75 E.04901
G3 X103.982 Y129.907 I3.021 J-4.059 E.02278
G1 X103.982 Y131.604 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y129.907 E-.64486
G1 X104.204 Y130.113 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L19
M991 S0 P18 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.64 I-.057 J1.216 P1  F60000
G1 X152.381 Y132.381 Z2.64
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2225
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.583 Y132.018 Z2.76 F60000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X148.982 Y132.018 E.01246
G1 X148.982 Y130.922 E.02274
G2 X150.76 Y130.27 I.069 J-2.562 E.04023
G1 X151.67 Y129.211 E.02896
G1 X152.018 Y128.929 E.0093
G1 X152.018 Y126.384 E.05278
G3 X151.215 Y127.159 I-2.553 J-1.844 E.02326
G3 X148.982 Y126.659 I-.67 J-2.244 E.04959
G1 X148.982 Y124.962 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.659 E-.64486
G1 X149.228 Y126.835 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.618 Y126.25 Z2.76 F60000
G1 X107.381 Y123.619 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2225
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.374 Y123.982 Z2.76 F60000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X103.982 Y123.982 E.00813
G1 X103.982 Y125.287 E.02707
G1 X104.33 Y125.57 E.0093
G1 X105.24 Y126.628 E.02896
G2 X107.018 Y127.28 I1.709 J-1.909 E.04023
G1 X107.018 Y130.301 E.06265
G3 X104.785 Y130.8 I-1.563 J-1.745 E.04958
G3 X103.982 Y130.026 I1.751 J-2.619 E.02327
G1 X103.982 Y131.723 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y130.026 E-.64486
G1 X104.18 Y130.255 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L20
M991 S0 P19 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.76 I-.054 J1.216 P1  F60000
G1 X152.381 Y132.381 Z2.76
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2223
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
M73 P50 R6
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.691 Y132.018 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X148.982 Y132.018 E.01471
G1 X148.982 Y131.03 E.02049
G2 X150.76 Y130.22 I-.255 J-2.916 E.04131
G1 X151.67 Y129.017 E.0313
G1 X152.018 Y128.751 E.00909
G1 X152.018 Y126.523 E.04621
G3 X151.215 Y127.331 I-1.863 J-1.048 E.02392
G3 X148.982 Y126.614 I-.427 J-2.506 E.05056
G1 X148.982 Y124.917 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.614 E-.64486
G1 X149.217 Y126.806 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.606 Y126.226 Z2.88 F60000
G1 X107.381 Y123.619 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2223
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.552 Y123.982 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X103.982 Y123.982 E.01182
G1 X103.982 Y125.109 E.02338
G1 X104.33 Y125.376 E.00909
G1 X105.24 Y126.579 E.0313
G2 X107.018 Y127.388 I2.033 J-2.107 E.04131
G1 X107.018 Y130.256 E.05947
G3 X104.785 Y130.973 I-1.806 J-1.788 E.05056
G3 X103.982 Y130.165 I1.06 J-1.856 E.02393
G1 X103.982 Y131.862 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y130.165 E-.64486
G1 X104.165 Y130.406 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L21
M991 S0 P20 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.88 I-.05 J1.216 P1  F60000
G1 X152.381 Y132.381 Z2.88
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2230
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2222
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.819 Y132.018 Z3 F60000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2230
M204 S4000
G1 X148.982 Y132.018 E.01736
G1 X148.982 Y131.158 E.01784
G2 X150.305 Y130.597 I-.565 J-3.175 E.03004
G2 X151.67 Y128.754 I-4.526 J-4.78 E.04783
G1 X152.018 Y128.527 E.00861
G1 X152.018 Y126.667 E.03858
G1 X151.67 Y127.246 E.01402
G1 X151.215 Y127.543 E.01127
G3 X148.982 Y126.572 I-.08 J-2.869 E.05216
G1 X148.982 Y124.875 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X148.982 Y126.572 E-.64486
G1 X149.204 Y126.778 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.593 Y126.204 Z3 F60000
G1 X107.381 Y123.619 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2230
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2222
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.775 Y123.982 Z3 F60000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2230
M204 S4000
G1 X103.982 Y123.982 E.01646
G1 X103.982 Y124.885 E.01874
G1 X104.33 Y125.112 E.00862
M73 P51 R6
G2 X105.696 Y126.956 I5.891 J-2.936 E.04783
G2 X107.018 Y127.516 I1.888 J-2.615 E.03004
G1 X107.018 Y130.214 E.05595
G3 X104.785 Y131.184 I-2.153 J-1.898 E.05216
G1 X104.33 Y130.888 E.01127
G1 X103.982 Y130.308 E.01402
G1 X103.982 Y132.005 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y130.308 E-.64486
G1 X104.138 Y130.568 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L22
M991 S0 P21 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3 I-.046 J1.216 P1  F60000
G1 X152.381 Y132.381 Z3
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2380
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2220
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y129.887 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2380
M204 S4000
G1 X152.018 Y128.19 E.0352
G1 X151.67 Y128.227 E.00726
G3 X150.76 Y130.128 I-8.528 J-2.914 E.04383
G3 X148.982 Y131.304 I-2.819 J-2.331 E.04486
G1 X148.982 Y126.532 E.09897
G2 X150.76 Y127.681 I2.795 J-2.375 E.04454
G2 X151.67 Y127.773 I.562 J-1.011 E.01951
G1 X152.018 Y126.939 E.01875
G1 X152.018 Y125.242 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y126.939 E-.64486
G1 X151.901 Y127.218 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.294 Y126.603 Z3.12 F60000
G1 X107.381 Y123.619 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2380
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2220
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.018 Y124.033 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2380
M204 S4000
G1 X107.018 Y123.982 E.00106
G1 X105.372 Y123.982 E.03414
G3 X104.33 Y124.132 I-.753 J-1.544 E.02219
G1 X104.268 Y123.982 E.00336
G1 X103.982 Y123.982 E.00592
G1 X103.982 Y124.548 E.01174
G1 X104.33 Y124.585 E.00726
G2 X105.24 Y126.487 I8.527 J-2.914 E.04383
G2 X107.018 Y127.662 I2.819 J-2.331 E.04486
G1 X107.018 Y130.174 E.0521
G3 X105.24 Y131.323 I-2.795 J-2.375 E.04454
G3 X104.33 Y131.415 I-.562 J-1.011 E.01951
G1 X103.982 Y130.58 E.01876
G1 X103.982 Y128.883 E.0352
M204 S10000
G1 X104.273 Y132.018 F60000
G1 F2380
M204 S4000
G1 X103.982 Y132.018 E.00603
G1 X103.982 Y131.831 E.00388
G3 X104.485 Y132.018 I.131 J.416 E.01198
G1 X106.182 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X104.485 Y132.018 E-.64486
G1 X104.33 Y131.869 E-.08175
G1 X104.243 Y131.859 E-.03338
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L23
M991 S0 P22 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.12 I-.013 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.12
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2230
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2218
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.151 Y132.018 Z3.24 F60000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2230
M204 S4000
G1 X148.982 Y132.018 E.02425
G1 X148.982 Y131.49 E.01095
G2 X150.628 Y130.276 I-2.656 J-5.323 E.04263
G2 X151.258 Y128.455 I-3.333 J-2.174 E.04037
G1 X150.98 Y128 E.01107
G3 X149.071 Y126.634 I2.825 J-5.966 E.04894
G1 X148.982 Y126.491 E.00351
G1 X148.982 Y124.207 E.04737
G1 X149.372 Y123.982 E.00935
G1 X151.069 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X149.372 Y123.982 E-.64486
G1 X149.11 Y124.133 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.478 Y124.039 Z3.24 F60000
G1 X107.381 Y123.619 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2230
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2218
M204 S2000
M73 P52 R6
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.982 Y123.987 Z3.24 F60000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2230
M204 S4000
G1 X105.674 Y123.982 E.03509
G1 X105.02 Y124.358 E.01565
G1 X104.742 Y124.814 E.01107
G1 X104.773 Y125.269 E.00946
G2 X106.491 Y127.545 I3.144 J-.586 E.06131
G1 X107.018 Y127.848 E.01262
G1 X107.018 Y130.132 E.04738
G3 X105.811 Y131.186 I-2.823 J-2.016 E.03355
G1 X105.02 Y131.642 E.01892
G1 X104.79 Y132.018 E.00915
G1 X103.982 Y132.018 E.01676
G1 X103.982 Y131.129 E.01844
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.33788
G1 X104.79 Y132.018 E-.30698
G1 X104.948 Y131.76 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L24
M991 S0 P23 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.24 I-.016 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.24
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2222
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2216
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.331 Y132.018 Z3.36 F60000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2222
M204 S4000
G1 X148.982 Y132.018 E.02798
G1 X149.003 Y131.642 E.00782
G1 X150.24 Y130.731 E.03185
G2 X151.037 Y128.455 I-1.826 J-1.917 E.05194
G1 X150.695 Y128 E.01181
G1 X149.459 Y127.09 E.03185
G3 X148.982 Y126.457 I1.283 J-1.463 E.01655
G1 X149.003 Y124.358 E.04353
G1 X149.515 Y123.982 E.01317
G1 X151.212 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X149.515 Y123.982 E-.64486
G1 X149.271 Y124.162 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.639 Y124.063 Z3.36 F60000
G1 X107.381 Y123.619 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2222
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2216
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.119 Y123.982 Z3.36 F60000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2222
M204 S4000
G1 X105.816 Y123.982 E.0352
G2 X104.963 Y124.814 I.959 J1.838 E.02507
G1 X104.908 Y125.269 E.00951
G2 X105.76 Y127.09 I3.011 J-.299 E.0425
G1 X107.018 Y128.029 E.03256
G1 X107.018 Y130.099 E.04294
G3 X106.541 Y130.731 I-1.759 J-.83 E.01654
G1 X105.305 Y131.642 E.03185
G1 X105.022 Y132.018 E.00977
G1 X103.982 Y132.018 E.02157
G1 X103.982 Y131.361 E.01363
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.24967
G1 X105.022 Y132.018 E-.39519
G1 X105.204 Y131.776 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L25
M991 S0 P24 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.36 I-.016 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.36
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2217
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2213
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
M73 P53 R6
G1 E-.04 F1800
M204 S10000
G1 X150.582 Y132.018 Z3.48 F60000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2217
M204 S4000
G1 X148.982 Y132.018 E.03318
G1 X148.982 Y131.921 E.00202
G1 X149.207 Y131.642 E.00743
G1 X150.289 Y130.731 E.02933
G2 X150.859 Y128.455 I-1.744 J-1.646 E.05085
G1 X150.492 Y128 E.01213
G1 X149.41 Y127.09 E.02933
G3 X148.982 Y126.429 I1.379 J-1.361 E.01645
G1 X148.982 Y124.637 E.03715
G3 X149.654 Y123.982 I2.014 J1.393 E.0196
G1 X151.351 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X149.654 Y123.982 E-.64486
G1 X149.422 Y124.177 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.791 Y124.076 Z3.48 F60000
G1 X107.381 Y123.619 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2217
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2213
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.259 Y123.982 Z3.48 F60000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2217
M204 S4000
G1 X105.956 Y123.982 E.0352
G2 X105.141 Y124.814 I1.722 J2.501 E.02429
G2 X105.711 Y127.09 I2.314 J.63 E.05085
G1 X106.793 Y128 E.02933
G1 X107.018 Y128.279 E.00743
G1 X107.018 Y130.07 E.03716
G3 X106.59 Y130.731 I-1.806 J-.7 E.01644
G1 X105.508 Y131.642 E.02933
G1 X105.205 Y132.018 E.01003
G1 X103.982 Y132.018 E.02537
G1 X103.982 Y131.544 E.00983
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.18015
G1 X105.205 Y132.018 E-.46471
G1 X105.395 Y131.782 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L26
M991 S0 P25 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.48 I-.016 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.48
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2213
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2211
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.754 Y132.018 Z3.6 F60000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2213
M204 S4000
G1 X149.057 Y132.018 E.0352
G3 X150.34 Y130.731 I5.956 J4.656 E.03779
G2 X150.707 Y128.455 I-1.739 J-1.448 E.05017
G2 X149.358 Y127.09 I-6.314 J4.888 E.03991
G3 X148.982 Y126.407 I1.442 J-1.24 E.01628
G1 X148.991 Y124.814 E.03305
G3 X149.772 Y123.982 I3.825 J2.809 E.02372
G1 X151.469 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X149.772 Y123.982 E-.64486
G1 X149.565 Y124.203 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.933 Y124.097 Z3.6 F60000
G1 X107.381 Y123.619 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2213
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2211
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.377 Y123.982 Z3.6 F60000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2213
M204 S4000
G1 X106.074 Y123.982 E.0352
G2 X105.133 Y125.269 I1.607 J2.162 E.03357
G2 X105.66 Y127.09 I2.44 J.281 E.04036
G3 X107.018 Y128.482 I-4.688 J5.934 E.04046
G1 X107.018 Y130.049 E.03251
G3 X106.642 Y130.731 I-1.817 J-.557 E.01627
G2 X105.359 Y132.018 I4.672 J5.943 E.03779
G1 X103.982 Y132.018 E.02856
G1 X103.982 Y131.698 E.00664
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.12173
G1 X105.359 Y132.018 E-.52313
M73 P54 R6
G1 X105.553 Y131.785 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L27
M991 S0 P26 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.6 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.6
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2209
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2209
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.889 Y132.018 Z3.72 F60000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2209
M204 S4000
G1 X149.192 Y132.018 E.0352
G2 X150.395 Y130.731 I-231.848 J-218.067 E.03655
G2 X150.575 Y128.455 I-1.786 J-1.286 E.04979
G2 X149.303 Y127.09 I-312.611 J289.728 E.0387
G3 X148.982 Y126.397 I1.466 J-1.101 E.01595
G1 X148.982 Y125.139 E.02609
G3 X149.918 Y123.982 I2.904 J1.391 E.03115
G1 X151.615 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X149.918 Y123.982 E-.64486
G1 X149.709 Y124.201 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.077 Y124.096 Z3.72 F60000
G1 X107.381 Y123.619 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2209
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2209
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.522 Y123.982 Z3.72 F60000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2209
M204 S4000
G1 X106.219 Y123.982 E.0352
G2 X105.227 Y125.269 I1.947 J2.527 E.03408
G2 X105.998 Y127.545 I2.435 J.444 E.05204
G3 X107.018 Y128.781 I-2.04 J2.722 E.03356
G1 X107.018 Y130.039 E.0261
G3 X105.816 Y131.642 I-3.582 J-1.435 E.04203
G1 X105.493 Y132.018 E.01029
G1 X103.982 Y132.018 E.03135
G1 X103.982 Y131.832 E.00385
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.07062
G1 X105.493 Y132.018 E-.57424
G1 X105.69 Y131.788 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L28
M991 S0 P27 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.72 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.72
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2205
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2205
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.01 Y132.018 Z3.84 F60000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2205
M204 S4000
G1 X149.313 Y132.018 E.0352
G2 X150.454 Y130.731 I-14.092 J-13.642 E.03568
G2 X150.054 Y128 I-1.799 J-1.131 E.06231
G3 X148.982 Y126.409 I2.098 J-2.571 E.04037
G1 X148.982 Y125.41 E.02072
G3 X149.645 Y124.358 I2.201 J.652 E.02611
G1 X150.024 Y123.982 E.01108
G1 X151.721 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X150.024 Y123.982 E-.64486
G1 X149.809 Y124.196 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.177 Y124.092 Z3.84 F60000
G1 X107.381 Y123.619 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2205
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2205
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
M73 P55 R6
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.628 Y123.982 Z3.84 F60000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2205
M204 S4000
G1 X106.325 Y123.982 E.0352
G2 X105.312 Y125.269 I2.69 J3.161 E.0342
G2 X106.355 Y128 I2.524 J.601 E.06443
G3 X107.018 Y129.052 I-1.539 J1.704 E.02611
G1 X107.018 Y130.051 E.02073
G3 X105.946 Y131.642 I-3.171 J-.98 E.04036
G1 X105.615 Y132.018 E.0104
G1 X103.982 Y132.018 E.03386
G1 X103.982 Y131.954 E.00134
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y132.018 E-.02448
G1 X105.615 Y132.018 E-.62038
G1 X105.815 Y131.791 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L29
M991 S0 P28 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.84 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.84
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.123 Y132.018 Z3.96 F60000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X149.426 Y132.018 E.0352
G2 X150.517 Y130.731 I-6.921 J-6.975 E.03504
G2 X149.931 Y128 I-1.948 J-1.011 E.0628
G3 X149.768 Y124.358 I1.363 J-1.886 E.08687
G1 X150.128 Y123.982 E.01081
G1 X151.825 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X150.128 Y123.982 E-.64486
G1 X149.918 Y124.201 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.287 Y124.096 Z3.96 F60000
G1 X107.381 Y123.619 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.733 Y123.982 Z3.96 F60000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X106.429 Y123.982 E.0352
G2 X105.389 Y125.269 I3.808 J4.143 E.03445
G2 X106.233 Y128 I2.268 J.795 E.0635
G3 X106.069 Y131.642 I-1.527 J1.756 E.08687
G1 X105.727 Y132.018 E.01055
G1 X104.03 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.727 Y132.018 E-.64486
G1 X105.931 Y131.794 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L30
M991 S0 P29 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.96 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z3.96
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.23 Y132.018 Z4.08 F60000
G1 Z3.68
M73 P55 R5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X149.533 Y132.018 E.0352
G2 X150.585 Y130.731 I-4.373 J-4.65 E.03458
M73 P56 R5
G2 X149.811 Y128 I-2.178 J-.858 E.06327
G3 X149.888 Y124.358 I1.452 J-1.791 E.0871
G1 X150.234 Y123.982 E.01061
G1 X151.931 Y123.982 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X150.234 Y123.982 E-.64486
G1 X150.029 Y124.205 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.397 Y124.1 Z4.08 F60000
G1 X107.381 Y123.619 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.838 Y123.982 Z4.08 F60000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X106.535 Y123.982 E.0352
G2 X105.459 Y125.269 I5.771 J5.92 E.03486
G2 X106.112 Y128 I2.022 J.96 E.06296
G3 X106.189 Y131.642 I-1.375 J1.851 E.0871
G1 X105.834 Y132.018 E.01073
G1 X104.137 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.834 Y132.018 E-.64486
G1 X106.042 Y131.798 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L31
M991 S0 P30 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.08 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.08
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.335 Y132.018 Z4.2 F60000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X149.638 Y132.018 E.0352
G2 X150.66 Y130.731 I-3.034 J-3.46 E.03427
G2 X149.689 Y128 I-2.43 J-.674 E.06405
G3 X148.982 Y126.841 I1.537 J-1.733 E.02858
G3 X149.024 Y125.724 I2.831 J-.453 E.02334
G3 X150.009 Y124.358 I3.256 J1.311 E.03527
G1 X150.344 Y123.982 E.01045
G1 X152.018 Y124.005 E.03472
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X150.344 Y123.982 E-.63608
G1 X150.127 Y124.226 E-.12392
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.496 Y124.117 Z4.2 F60000
G1 X107.381 Y123.619 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2204
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2204
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.949 Y123.982 Z4.2 F60000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2204
M204 S4000
G1 X106.646 Y123.982 E.0352
G2 X105.524 Y125.269 I10.372 J10.173 E.03543
G2 X105.991 Y128 I1.868 J1.086 E.06239
G3 X106.961 Y130.731 I-1.565 J2.094 E.06372
G3 X105.939 Y132.018 I-4.056 J-2.173 E.03427
G1 X104.242 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.939 Y132.018 E-.64486
G1 X106.146 Y131.797 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L32
M991 S0 P31 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.2 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.2
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2207
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2207
M204 S2000
G1 X152.79 Y123.21 E.18466
M73 P57 R5
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.44 Y132.018 Z4.32 F60000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2207
M204 S4000
G1 X149.743 Y132.018 E.0352
G2 X150.742 Y130.731 I-2.185 J-2.728 E.0341
G2 X150.038 Y128.455 I-2.377 J-.512 E.05164
G3 X148.982 Y127.143 I2.263 J-2.904 E.03525
G1 X148.982 Y125.96 E.02454
G3 X150.136 Y124.358 I3.43 J1.255 E.04147
G1 X150.462 Y123.982 E.01033
G1 X152.018 Y123.982 E.03227
G1 X152.018 Y124.123 E.00293
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.05361
G1 X150.462 Y123.982 E-.59125
G1 X150.264 Y124.211 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.632 Y124.106 Z4.32 F60000
G1 X107.381 Y123.619 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2207
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2207
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.067 Y123.982 Z4.32 F60000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2207
M204 S4000
G1 X106.764 Y123.982 E.0352
G2 X105.584 Y125.269 I36.165 J34.328 E.03621
G2 X105.864 Y128 I1.711 J1.205 E.06211
G3 X107.018 Y129.602 I-2.277 J2.857 E.04146
G1 X107.018 Y130.785 E.02455
G3 X106.044 Y132.018 I-3.158 J-1.494 E.03287
G1 X104.347 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.044 Y132.018 E-.64486
G1 X106.252 Y131.798 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L33
M991 S0 P32 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.32 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.32
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2210
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2210
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.584 Y132.018 Z4.44 F60000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2210
M204 S4000
G1 X149.887 Y132.018 E.0352
G2 X150.832 Y130.731 I-1.842 J-2.343 E.03353
G2 X150.36 Y128.91 I-2.384 J-.353 E.04008
G3 X148.982 Y127.391 I3.747 J-4.782 E.04275
G1 X148.982 Y125.956 E.02976
G3 X149.339 Y125.269 I1.812 J.504 E.01619
G2 X150.591 Y123.982 I-5.936 J-7.03 E.03731
G1 X152.018 Y123.982 E.02959
G1 X152.018 Y124.252 E.00561
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.10271
G1 X150.591 Y123.982 E-.54215
G1 X150.38 Y124.199 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.748 Y124.096 Z4.44 F60000
G1 X107.381 Y123.619 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2210
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2210
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.196 Y123.982 Z4.44 F60000
G1 Z4.04
M73 P58 R5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2210
M204 S4000
G1 X106.893 Y123.982 E.0352
G3 X105.64 Y125.269 I-7.189 J-5.743 E.03731
G2 X105.342 Y127.545 I1.751 J1.387 E.05
G2 X106.661 Y128.91 I7.623 J-6.042 E.03944
G3 X107.018 Y129.598 I-1.455 J1.191 E.01618
G1 X107.018 Y131.033 E.02977
G3 X106.189 Y132.018 I-3.096 J-1.765 E.02686
G1 X104.492 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.189 Y132.018 E-.64486
G1 X106.395 Y131.796 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L34
M991 S0 P33 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.44 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.44
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2215
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2215
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.697 Y132.018 Z4.56 F60000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2215
M204 S4000
G1 X150 Y132.018 E.0352
G2 X150.802 Y131.186 I-2.098 J-2.824 E.02407
G2 X150.307 Y128.91 I-2.229 J-.707 E.05057
G1 X149.269 Y128 E.02863
G1 X148.982 Y127.649 E.00941
G1 X148.982 Y125.939 E.03547
G3 X149.392 Y125.269 I1.815 J.65 E.0164
G1 X150.429 Y124.358 E.02863
G1 X150.737 Y123.982 E.01009
G1 X152.018 Y123.982 E.02657
G1 X152.018 Y124.398 E.00863
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.15817
G1 X150.737 Y123.982 E-.48669
G1 X150.545 Y124.216 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.914 Y124.111 Z4.56 F60000
G1 X107.381 Y123.619 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2215
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2215
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.346 Y123.982 Z4.56 F60000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2215
M204 S4000
G1 X107.018 Y123.982 E.03468
G1 X106.731 Y124.358 E.00982
G1 X105.693 Y125.269 E.02863
G2 X105.198 Y127.545 I1.734 J1.569 E.05057
G2 X106.609 Y128.91 I4.808 J-3.554 E.0409
G3 X107.018 Y129.58 I-1.405 J1.319 E.01639
G1 X107.018 Y131.29 E.03548
G3 X106.302 Y132.018 I-2.544 J-1.788 E.02128
G1 X104.605 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.302 Y132.018 E-.64486
G1 X106.529 Y131.818 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L35
M991 S0 P34 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.56 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.56
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2219
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2219
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.827 Y132.018 Z4.68 F60000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2219
M204 S4000
G1 X150.13 Y132.018 E.0352
G2 X150.969 Y131.186 I-1.2 J-2.05 E.02476
G1 X151.047 Y130.731 E.00958
G2 X150.257 Y128.91 I-2.924 J.187 E.042
G1 X148.982 Y127.87 E.03413
G1 X148.982 Y125.912 E.04061
G3 X149.441 Y125.269 I1.781 J.785 E.01652
G1 X150.616 Y124.358 E.03082
G1 X150.908 Y123.982 E.00989
G1 X152.018 Y123.982 E.02302
G1 X152.018 Y124.569 E.01218
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.22311
G1 X150.908 Y123.982 E-.42175
G1 X150.722 Y124.221 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.091 Y124.115 Z4.68 F60000
G1 X107.381 Y123.619 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2219
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
M73 P59 R5
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2219
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.568 Y123.982 Z4.68 F60000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2219
M204 S4000
G1 X107.018 Y123.982 E.03008
G3 X106.917 Y124.358 I-.293 J.123 E.0087
G1 X105.743 Y125.269 E.03082
G2 X105.031 Y127.545 I1.802 J1.813 E.05146
G1 X105.384 Y128 E.01195
G1 X106.559 Y128.91 E.03082
G3 X107.018 Y129.554 I-1.321 J1.429 E.01651
G1 X107.018 Y131.512 E.04062
G3 X106.432 Y132.018 I-1.279 J-.889 E.01623
G1 X104.735 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.432 Y132.018 E-.64486
G1 X106.661 Y131.82 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L36
M991 S0 P35 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.68 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.68
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2225
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2222
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.954 Y132.018 Z4.8 F60000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2225
M204 S4000
G1 X150.257 Y132.018 E.0352
G1 X150.863 Y131.642 E.01478
G1 X151.173 Y131.186 E.01142
G1 X151.176 Y130.731 E.00944
G2 X149.568 Y128.455 I-3.066 J.461 E.05996
G1 X148.982 Y128.091 E.01431
G1 X148.982 Y125.88 E.04585
G3 X150.131 Y124.814 I2.838 J1.904 E.03281
G1 X150.863 Y124.358 E.01788
G1 X151.119 Y123.982 E.00945
G1 X152.018 Y123.982 E.01865
G1 X152.018 Y124.78 E.01655
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.30324
G1 X151.119 Y123.982 E-.34162
G1 X150.948 Y124.232 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X143.317 Y124.125 Z4.8 F60000
G1 X107.381 Y123.619 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2225
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2222
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.788 Y123.982 Z4.8 F60000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2225
M204 S4000
G1 X107.018 Y123.982 E.02551
G1 X107.018 Y124.449 E.00969
G2 X105.376 Y125.724 I2.897 J5.429 E.04333
G2 X104.827 Y127.545 I2.384 J1.71 E.04017
G1 X105.137 Y128 E.01142
G3 X106.926 Y129.366 I-3.018 J5.807 E.04691
G1 X107.018 Y129.522 E.00376
G1 X107.018 Y131.732 E.04585
G1 X106.559 Y132.018 E.01121
G1 X104.862 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.559 Y132.018 E-.64486
G1 X106.816 Y131.858 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L37
M991 S0 P36 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.8 I-.014 J1.217 P1  F60000
G1 X152.381 Y132.381 Z4.8
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2372
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
M73 P60 R5
G1 E-.04 F1800
M204 S10000
G1 X148.982 Y131.82 Z4.92 F60000
G1 Z4.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2372
M204 S4000
G1 X148.982 Y132.018 E.0041
G1 X150.481 Y132.018 E.0311
G1 X151.289 Y131.642 E.01848
G2 X151.324 Y130.731 I-.714 J-.483 E.01991
G2 X148.982 Y128.267 I-3.456 J.939 E.07348
G1 X148.982 Y125.844 E.05026
G3 X150.312 Y124.814 I2.773 J2.207 E.03524
G1 X151.289 Y124.358 E.02234
G1 X151.411 Y123.982 E.00821
G1 X152.018 Y123.982 E.01259
G3 X151.904 Y124.814 I-1.337 J.24 E.0177
G2 X152.018 Y125.273 I1.533 J-.138 E.00985
G1 X152.018 Y126.97 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y125.273 E-.64486
G1 X151.945 Y124.979 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.316 Y124.746 Z4.92 F60000
G1 X107.381 Y123.619 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2372
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.957 Y130.787 Z4.92 F60000
G1 X107.018 Y131.182 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2372
M204 S4000
G1 X107.018 Y129.485 E.0352
G2 X106.466 Y128.91 I-1.614 J.997 E.01666
G2 X104.711 Y128 I-5.76 J8.955 E.04106
G1 X104.564 Y127.545 E.00993
G3 X105.364 Y125.724 I5.474 J1.32 E.04147
G3 X107.018 Y124.625 I3.721 J3.807 E.04143
G1 X107.018 Y123.982 E.01334
G1 X103.982 Y123.982 E.06297
G1 X103.982 Y128.103 E.08548
G3 X103.982 Y128.914 I-.963 J.406 E.01728
G1 X103.982 Y130.611 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y128.914 E-.64486
G1 X104.055 Y128.62 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L38
M991 S0 P37 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.92 I-.094 J1.213 P1  F60000
G1 X152.381 Y132.381 Z4.92
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2232
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2232
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.125 Y132.018 Z5.04 F60000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2232
M204 S4000
G1 X152.018 Y132.018 E.01852
G1 X152.018 Y131.214 E.01668
G1 X151.67 Y131.018 E.00829
G2 X150.305 Y129.041 I-6.017 J2.696 E.05012
G2 X148.982 Y128.434 I-2.071 J2.768 E.03041
G1 X148.982 Y125.801 E.05461
G3 X150.76 Y124.776 I2.497 J2.277 E.04325
G1 X151.215 Y124.726 E.0095
G1 X151.67 Y124.982 E.01084
G1 X152.018 Y125.614 E.01495
G1 X152.018 Y123.982 E.03385
G1 X151.953 Y123.982 E.00135
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y123.982 E-.02476
G1 X152.018 Y125.614 E-.6201
G1 X151.872 Y125.348 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.245 Y125.052 Z5.04 F60000
G1 X107.381 Y123.619 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2232
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2232
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.131 Y123.982 Z5.04 F60000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2232
M204 S4000
G1 X107.018 Y123.982 E.0184
G1 X107.018 Y124.792 E.0168
G2 X105.696 Y125.399 I.748 J3.374 E.03041
G2 X104.33 Y127.376 I4.652 J4.673 E.05012
G1 X103.982 Y127.572 E.00829
G1 X103.982 Y129.256 E.03491
M73 P61 R5
G1 X104.33 Y128.624 E.01496
G1 X104.785 Y128.367 E.01084
G1 X105.24 Y128.418 E.0095
G3 X107.018 Y129.443 I-.719 J3.301 E.04324
G1 X107.018 Y131.14 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y129.443 E-.64486
G1 X106.801 Y129.231 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L39
M991 S0 P38 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.04 I-.084 J1.214 P1  F60000
G1 X152.381 Y132.381 Z5.04
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.375 Y132.018 Z5.16 F60000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X152.018 Y132.018 E.01335
G1 X152.018 Y130.964 E.02185
G1 X151.67 Y130.708 E.00896
G1 X150.76 Y129.438 E.03241
G2 X148.982 Y128.568 I-2.147 J2.134 E.04183
G1 X148.982 Y125.76 E.05824
G3 X151.215 Y124.957 I1.914 J1.816 E.05105
G3 X152.018 Y125.777 I-.863 J1.648 E.02421
G1 X152.018 Y124.08 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y125.777 E-.64486
G1 X151.841 Y125.531 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.216 Y125.203 Z5.16 F60000
G1 X107.381 Y123.619 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.265 Y123.982 Z5.16 F60000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X107.018 Y123.982 E.01562
G1 X107.018 Y124.926 E.01958
G2 X105.24 Y125.797 I.37 J3.005 E.04183
G1 X104.33 Y127.067 E.03241
G1 X103.982 Y127.323 E.00897
G1 X103.982 Y129.419 E.04347
G3 X104.785 Y128.598 I1.667 J.828 E.02422
G3 X107.018 Y129.401 I.318 J2.619 E.05105
G1 X107.018 Y131.098 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y129.401 E-.64486
G1 X106.788 Y129.204 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L40
M991 S0 P39 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.16 I-.085 J1.214 P1  F60000
G1 X152.381 Y132.381 Z5.16
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.566 Y132.018 Z5.28 F60000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X152.018 Y132.018 E.00938
G1 X152.018 Y130.773 E.02582
G1 X151.67 Y130.495 E.00924
G1 X150.76 Y129.39 E.0297
G2 X148.982 Y128.681 I-1.794 J1.916 E.04063
G1 X148.982 Y125.716 E.0615
G3 X151.215 Y125.141 I1.644 J1.76 E.04987
G3 X152.018 Y125.927 I-1.466 J2.301 E.02348
G1 X152.018 Y124.23 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y125.927 E-.64486
G1 X151.825 Y125.693 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.201 Y125.338 Z5.28 F60000
G1 X107.381 Y123.619 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2226
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2226
M204 S2000
G1 X103.21 Y123.21 E.08828
M73 P62 R5
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.379 Y123.982 Z5.28 F60000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2226
M204 S4000
G1 X107.018 Y123.982 E.01326
G1 X107.018 Y125.039 E.02194
G2 X105.24 Y125.748 I.016 J2.624 E.04063
G1 X104.33 Y126.853 E.0297
G1 X103.982 Y127.132 E.00924
G1 X103.982 Y129.569 E.05056
G3 X104.785 Y128.783 I2.27 J1.515 E.02348
G3 X107.018 Y129.358 I.589 J2.335 E.04987
G1 X107.018 Y131.055 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y129.358 E-.64486
G1 X106.776 Y129.176 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L41
M991 S0 P40 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.28 I-.085 J1.214 P1  F60000
G1 X152.381 Y132.381 Z5.28
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X148.619 Y123.619 E.07802
G1 X148.619 Y132.381 E.18174
G1 X152.321 Y132.381 E.07678
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X148.21 Y123.21 E.08828
G1 X148.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.08713
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.725 Y132.018 Z5.4 F60000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X152.018 Y132.018 E.00608
G1 X152.018 Y130.614 E.02912
G3 X150.76 Y129.339 I4.176 J-5.378 E.03727
G2 X148.982 Y128.785 I-1.568 J1.902 E.03961
G1 X148.982 Y125.669 E.06462
G3 X151.215 Y125.297 I1.438 J1.741 E.04918
G3 X152.018 Y126.052 I-2.444 J3.404 E.02293
G1 X152.018 Y124.355 E.0352
; COOLING_NODE: 0
; WIPE_START
G1 F9000
G1 X152.018 Y126.052 E-.64486
G1 X151.797 Y125.844 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.174 Y125.462 Z5.4 F60000
G1 X107.381 Y123.619 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F2227
M204 S4000
G1 X103.619 Y123.619 E.07802
G1 X103.619 Y132.381 E.18174
G1 X107.381 Y132.381 E.07802
G1 X107.381 Y123.679 E.18049
; COOLING_NODE: 0
M204 S250
G1 X107.79 Y123.21 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2227
M204 S2000
G1 X103.21 Y123.21 E.08828
G1 X103.21 Y132.79 E.18466
G1 X107.79 Y132.79 E.08828
G1 X107.79 Y123.27 E.18351
; WIPE_START
G1 F3600
M204 S4000
G1 X105.79 Y123.244 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.482 Y123.982 Z5.4 F60000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2227
M204 S4000
G1 X107.018 Y123.982 E.01112
G1 X107.018 Y125.143 E.02408
G2 X105.24 Y125.697 I-.21 J2.456 E.03961
G3 X103.982 Y126.973 I-5.435 J-4.104 E.03727
G1 X103.982 Y129.694 E.05643
G3 X104.785 Y128.938 I3.248 J2.649 E.02294
G3 X107.018 Y129.311 I.795 J2.114 E.04918
G1 X107.018 Y131.008 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X107.018 Y129.311 E-.64486
G1 X106.764 Y129.145 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L42
M991 S0 P41 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.4 I-.086 J1.214 P1  F60000
G1 X152.381 Y132.381 Z5.4
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X151.782 Y123.619 E.01241
G1 X151.382 Y123.619 E.0083
G1 F8464.109
G1 X150.982 Y123.619 E.0083
G1 F7362.296
G1 X150.582 Y123.619 E.0083
G1 F6337.282
G1 X150.182 Y123.619 E.0083
G1 F5389.068
G1 X149.782 Y123.619 E.0083
G1 F4517.655
G1 X149.382 Y123.619 E.0083
G1 F3723.041
G1 X148.982 Y123.619 E.0083
G1 F3005.227
G1 X148.582 Y123.619 E.0083
G1 F2364.214
G1 X148.182 Y123.619 E.0083
G1 F1800
G1 X147.8 Y123.619 E.00793
; FEATURE: Overhang wall
; LINE_WIDTH: 0.462876
; LAYER_HEIGHT: 0.18
G1 F1500
M204 S2000
G1 X108.2 Y123.619 E1.2321
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1800
M204 S4000
G1 X107.817 Y123.619 E.00793
G1 F2364.214
G1 X107.417 Y123.619 E.0083
G1 F3005.227
M73 P63 R5
G1 X107.017 Y123.619 E.0083
G1 F3723.041
G1 X106.617 Y123.619 E.0083
G1 F4517.655
G1 X106.217 Y123.619 E.0083
G1 F5389.068
G1 X105.817 Y123.619 E.0083
G1 F6337.282
G1 X105.417 Y123.619 E.0083
G1 F7362.296
G1 X105.017 Y123.619 E.0083
G1 F8464.109
G1 X104.617 Y123.619 E.0083
G1 F9000
G1 X104.217 Y123.619 E.0083
G1 X103.619 Y123.619 E.01241
G1 X103.619 Y132.381 E.18174
G1 X104.217 Y132.381 E.01241
G1 X104.617 Y132.381 E.0083
G1 F8464.109
G1 X105.017 Y132.381 E.0083
G1 F7362.296
G1 X105.417 Y132.381 E.0083
G1 F6337.282
G1 X105.817 Y132.381 E.0083
G1 F5389.068
G1 X106.217 Y132.381 E.0083
G1 F4517.655
G1 X106.617 Y132.381 E.0083
G1 F3723.041
G1 X107.017 Y132.381 E.0083
G1 F3005.227
G1 X107.417 Y132.381 E.0083
G1 F2364.214
G1 X107.817 Y132.381 E.0083
G1 F1800
G1 X108.2 Y132.381 E.00793
; FEATURE: Overhang wall
; LINE_WIDTH: 0.462876
; LAYER_HEIGHT: 0.18
G1 F1500
M204 S2000
G1 X147.8 Y132.381 E1.2321
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1800
M204 S4000
G1 X148.182 Y132.381 E.00793
G1 F2364.214
G1 X148.582 Y132.381 E.0083
G1 F3005.227
G1 X148.982 Y132.381 E.0083
G1 F3723.041
G1 X149.382 Y132.381 E.0083
G1 F4517.655
G1 X149.782 Y132.381 E.0083
G1 F5389.068
G1 X150.182 Y132.381 E.0083
G1 F6337.282
G1 X150.582 Y132.381 E.0083
G1 F7362.296
G1 X150.982 Y132.381 E.0083
G1 F8464.109
G1 X151.382 Y132.381 E.0083
G1 F9000
G1 X151.782 Y132.381 E.0083
G1 X152.321 Y132.381 E.01117
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2509
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X149.369 Y123.21 E.06594
G1 X148.969 Y123.21 E.00771
G1 X148.569 Y123.21 E.00771
G1 F2364.214
G1 X148.169 Y123.21 E.00771
G1 F1800
M73 P63 R4
G1 X147.8 Y123.21 E.00711
; FEATURE: Overhang wall
; LINE_WIDTH: 0.462876
; LAYER_HEIGHT: 0.18
G1 F1500
G1 X108.2 Y123.21 E1.2321
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.12
G1 F1800
G1 X107.831 Y123.21 E.00711
G1 F2364.214
G1 X107.431 Y123.21 E.00771
G1 F2509
G1 X107.031 Y123.21 E.00771
G1 X106.631 Y123.21 E.00771
G1 X103.21 Y123.21 E.06594
G1 X103.21 Y132.79 E.18466
G1 X106.631 Y132.79 E.06594
G1 X107.031 Y132.79 E.00771
G1 X107.431 Y132.79 E.00771
G1 F2364.214
G1 X107.831 Y132.79 E.00771
G1 F1800
G1 X108.2 Y132.79 E.00711
; FEATURE: Overhang wall
; LINE_WIDTH: 0.462876
; LAYER_HEIGHT: 0.18
G1 F1500
G1 X147.8 Y132.79 E1.2321
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.12
G1 F1800
G1 X148.169 Y132.79 E.00711
G1 F2364.214
G1 X148.569 Y132.79 E.00771
G1 F2509
G1 X148.969 Y132.79 E.00771
G1 X149.369 Y132.79 E.00771
G1 X152.73 Y132.79 E.06479
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.863 Y132.018 Z5.52 F60000
G1 Z5.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.018 Y132.018 E.00322
G1 X152.018 Y130.476 E.03198
G3 X150.76 Y129.285 I286.276 J-303.526 E.03595
G2 X149.065 Y128.868 I-1.361 J1.88 E.03711
G1 X149.065 Y125.572 E.06837
G3 X151.215 Y125.432 I1.196 J1.794 E.04679
G3 X152.018 Y126.198 I-2.808 J3.749 E.02307
G1 X152.018 Y124.501 E.0352
M204 S10000
G1 X148.833 Y123.972 F60000
; FEATURE: Bridge
; LINE_WIDTH: 0.441478
; LAYER_HEIGHT: 0.18
G1 F1500
M204 S4000
G1 X107.344 Y123.972 E1.22576
G1 X107.344 Y124.374 E.0119
G1 X148.656 Y124.374 E1.22052
G1 X148.656 Y124.777 E.0119
G1 X107.344 Y124.777 E1.22052
G1 X107.344 Y125.18 E.0119
M73 P64 R4
G1 X148.656 Y125.18 E1.22052
G1 X148.656 Y125.583 E.0119
G1 X107.344 Y125.583 E1.22052
G1 X107.344 Y125.986 E.0119
G1 X148.656 Y125.986 E1.22052
G1 X148.656 Y126.389 E.0119
G1 X107.344 Y126.389 E1.22052
G1 X107.344 Y126.792 E.0119
G1 X148.656 Y126.792 E1.22052
G1 X148.656 Y127.194 E.0119
M73 P65 R4
G1 X107.344 Y127.194 E1.22052
G1 X107.344 Y127.597 E.0119
G1 X148.656 Y127.597 E1.22052
G1 X148.656 Y128 E.0119
G1 X107.344 Y128 E1.22052
G1 X107.344 Y128.403 E.0119
G1 X148.656 Y128.403 E1.22052
G1 X148.656 Y128.806 E.0119
G1 X107.344 Y128.806 E1.22052
G1 X107.344 Y129.209 E.0119
M73 P66 R4
G1 X148.656 Y129.209 E1.22052
G1 X148.656 Y129.611 E.0119
G1 X107.344 Y129.611 E1.22052
G1 X107.344 Y130.014 E.0119
G1 X148.656 Y130.014 E1.22052
G1 X148.656 Y130.417 E.0119
G1 X107.344 Y130.417 E1.22052
G1 X107.344 Y130.82 E.0119
G1 X148.656 Y130.82 E1.22052
G1 X148.656 Y131.223 E.0119
M73 P67 R4
G1 X107.344 Y131.223 E1.22052
G1 X107.344 Y131.626 E.0119
G1 X148.656 Y131.626 E1.22052
G1 X148.656 Y132.029 E.0119
G1 X107.167 Y132.029 E1.22576
M204 S10000
G1 X106.935 Y130.91 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F9000
M204 S4000
G1 X106.935 Y129.213 E.0352
G2 X104.785 Y129.074 I-1.196 J1.794 E.04679
G2 X103.982 Y129.84 I2.808 J3.749 E.02307
M73 P68 R4
G1 X103.982 Y126.835 E.06233
G2 X105.24 Y125.643 I-283.281 J-300.366 E.03595
G3 X106.935 Y125.227 I1.361 J1.88 E.03711
G1 X106.935 Y123.982 E.02581
G1 X106.483 Y123.982 E.00939
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.935 Y123.982 E-.17194
G1 X106.935 Y125.227 E-.47292
G1 X106.634 Y125.195 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L43
M991 S0 P42 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.52 I-.189 J1.202 P1  F60000
G1 X152.381 Y132.381 Z5.52
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2635
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.987 Y132.018 Z5.64 F60000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.018 Y130.352 E.03456
G2 X150.76 Y129.227 I-15.387 J15.934 E.03503
G2 X149.065 Y128.944 I-1.185 J1.888 E.03658
G1 X149.065 Y125.525 E.07093
G3 X151.67 Y125.953 I1.044 J1.786 E.05939
G1 X152.018 Y126.306 E.01029
G1 X152.018 Y124.609 E.0352
M204 S10000
G1 X148.833 Y124.639 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423602
G1 F10800
M204 S4000
G1 X148.161 Y123.967 E.01848
G1 X147.599 Y123.967 E.01094
G1 X148.656 Y125.024 E.02908
G1 X148.656 Y125.587 E.01094
G1 X147.036 Y123.967 E.04455
G1 X146.473 Y123.967 E.01094
G1 X148.656 Y126.149 E.06003
G1 X148.656 Y126.712 E.01094
G1 X145.911 Y123.967 E.07551
G1 X145.348 Y123.967 E.01094
G1 X148.656 Y127.275 E.09099
G1 X148.656 Y127.837 E.01094
G1 X144.785 Y123.967 E.10646
G1 X144.223 Y123.967 E.01094
G1 X148.656 Y128.4 E.12194
G1 X148.656 Y128.963 E.01094
G1 X143.66 Y123.967 E.13742
G1 X143.098 Y123.967 E.01094
G1 X148.656 Y129.525 E.1529
G1 X148.656 Y130.088 E.01094
G1 X142.535 Y123.967 E.16838
G1 X141.972 Y123.967 E.01094
G1 X148.656 Y130.65 E.18385
G1 X148.656 Y131.213 E.01094
G1 X141.41 Y123.967 E.19933
G1 X140.847 Y123.967 E.01094
G1 X148.656 Y131.776 E.21481
G1 X148.656 Y132.033 E.005
G1 X148.35 Y132.033 E.00594
G1 X140.284 Y123.967 E.22188
G1 X139.722 Y123.967 E.01094
G1 X147.787 Y132.033 E.22188
G1 X147.225 Y132.033 E.01094
G1 X139.159 Y123.967 E.22188
G1 X138.596 Y123.967 E.01094
G1 X146.662 Y132.033 E.22188
G1 X146.1 Y132.033 E.01094
G1 X138.034 Y123.967 E.22188
G1 X137.471 Y123.967 E.01094
G1 X145.537 Y132.033 E.22188
G1 X144.974 Y132.033 E.01094
G1 X136.908 Y123.967 E.22188
G1 X136.346 Y123.967 E.01094
G1 X144.412 Y132.033 E.22188
G1 X143.849 Y132.033 E.01094
G1 X135.783 Y123.967 E.22188
G1 X135.221 Y123.967 E.01094
G1 X143.286 Y132.033 E.22188
G1 X142.724 Y132.033 E.01094
M73 P69 R4
G1 X134.658 Y123.967 E.22188
G1 X134.095 Y123.967 E.01094
G1 X142.161 Y132.033 E.22188
G1 X141.598 Y132.033 E.01094
G1 X133.533 Y123.967 E.22188
G1 X132.97 Y123.967 E.01094
G1 X141.036 Y132.033 E.22188
G1 X140.473 Y132.033 E.01094
G1 X132.407 Y123.967 E.22188
G1 X131.845 Y123.967 E.01094
G1 X139.91 Y132.033 E.22188
G1 X139.348 Y132.033 E.01094
G1 X131.282 Y123.967 E.22188
G1 X130.719 Y123.967 E.01094
G1 X138.785 Y132.033 E.22188
G1 X138.223 Y132.033 E.01094
G1 X130.157 Y123.967 E.22188
G1 X129.594 Y123.967 E.01094
G1 X137.66 Y132.033 E.22188
G1 X137.097 Y132.033 E.01094
G1 X129.031 Y123.967 E.22188
G1 X128.469 Y123.967 E.01094
G1 X136.535 Y132.033 E.22188
G1 X135.972 Y132.033 E.01094
G1 X127.906 Y123.967 E.22188
G1 X127.344 Y123.967 E.01094
G1 X135.409 Y132.033 E.22188
G1 X134.847 Y132.033 E.01094
G1 X126.781 Y123.967 E.22188
G1 X126.218 Y123.967 E.01094
G1 X134.284 Y132.033 E.22188
G1 X133.721 Y132.033 E.01094
G1 X125.656 Y123.967 E.22188
G1 X125.093 Y123.967 E.01094
G1 X133.159 Y132.033 E.22188
G1 X132.596 Y132.033 E.01094
G1 X124.53 Y123.967 E.22188
G1 X123.968 Y123.967 E.01094
G1 X132.033 Y132.033 E.22188
G1 X131.471 Y132.033 E.01094
G1 X123.405 Y123.967 E.22188
G1 X122.842 Y123.967 E.01094
G1 X130.908 Y132.033 E.22188
G1 X130.345 Y132.033 E.01094
G1 X122.28 Y123.967 E.22188
G1 X121.717 Y123.967 E.01094
G1 X129.783 Y132.033 E.22188
G1 X129.22 Y132.033 E.01094
G1 X121.154 Y123.967 E.22188
G1 X120.592 Y123.967 E.01094
G1 X128.658 Y132.033 E.22188
G1 X128.095 Y132.033 E.01094
G1 X120.029 Y123.967 E.22188
G1 X119.466 Y123.967 E.01094
G1 X127.532 Y132.033 E.22188
G1 X126.97 Y132.033 E.01094
G1 X118.904 Y123.967 E.22188
G1 X118.341 Y123.967 E.01094
G1 X126.407 Y132.033 E.22188
G1 X125.844 Y132.033 E.01094
G1 X117.779 Y123.967 E.22188
G1 X117.216 Y123.967 E.01094
G1 X125.282 Y132.033 E.22188
G1 X124.719 Y132.033 E.01094
G1 X116.653 Y123.967 E.22188
G1 X116.091 Y123.967 E.01094
G1 X124.156 Y132.033 E.22188
G1 X123.594 Y132.033 E.01094
G1 X115.528 Y123.967 E.22188
G1 X114.965 Y123.967 E.01094
G1 X123.031 Y132.033 E.22188
G1 X122.468 Y132.033 E.01094
G1 X114.403 Y123.967 E.22188
G1 X113.84 Y123.967 E.01094
G1 X121.906 Y132.033 E.22188
G1 X121.343 Y132.033 E.01094
G1 X113.277 Y123.967 E.22188
G1 X112.715 Y123.967 E.01094
G1 X120.781 Y132.033 E.22188
G1 X120.218 Y132.033 E.01094
G1 X112.152 Y123.967 E.22188
G1 X111.589 Y123.967 E.01094
G1 X119.655 Y132.033 E.22188
G1 X119.093 Y132.033 E.01094
G1 X111.027 Y123.967 E.22188
G1 X110.464 Y123.967 E.01094
G1 X118.53 Y132.033 E.22188
G1 X117.967 Y132.033 E.01094
G1 X109.902 Y123.967 E.22188
G1 X109.339 Y123.967 E.01094
G1 X117.405 Y132.033 E.22188
G1 X116.842 Y132.033 E.01094
G1 X108.776 Y123.967 E.22188
G1 X108.214 Y123.967 E.01094
G1 X116.279 Y132.033 E.22188
G1 X115.717 Y132.033 E.01094
G1 X107.651 Y123.967 E.22188
G1 X107.344 Y123.967 E.00596
G1 X107.344 Y124.223 E.00498
G1 X115.154 Y132.033 E.21484
G1 X114.591 Y132.033 E.01094
G1 X107.344 Y124.786 E.19936
G1 X107.344 Y125.348 E.01094
G1 X114.029 Y132.033 E.18388
G1 X113.466 Y132.033 E.01094
G1 X107.344 Y125.911 E.16841
G1 X107.344 Y126.474 E.01094
G1 X112.904 Y132.033 E.15293
G1 X112.341 Y132.033 E.01094
G1 X107.344 Y127.036 E.13745
G1 X107.344 Y127.599 E.01094
G1 X111.778 Y132.033 E.12197
G1 X111.216 Y132.033 E.01094
G1 X107.344 Y128.162 E.10649
G1 X107.344 Y128.724 E.01094
G1 X110.653 Y132.033 E.09102
G1 X110.09 Y132.033 E.01094
G1 X107.344 Y129.287 E.07554
G1 X107.344 Y129.85 E.01094
G1 X109.528 Y132.033 E.06006
G1 X108.965 Y132.033 E.01094
G1 X107.344 Y130.412 E.04458
G1 X107.344 Y130.975 E.01094
G1 X108.402 Y132.033 E.02911
G1 X107.84 Y132.033 E.01094
G1 X107.167 Y131.36 E.01851
M204 S10000
G1 X106.935 Y130.863 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X106.935 Y129.166 E.0352
G2 X104.33 Y129.594 I-1.044 J1.786 E.05939
G1 X103.982 Y129.948 E.01029
G1 X103.982 Y126.711 E.06715
G3 X105.24 Y125.585 I15.393 J15.941 E.03503
G3 X106.935 Y125.303 I1.185 J1.888 E.03658
G1 X106.935 Y123.982 E.02739
G1 X106.559 Y123.982 E.00781
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.935 Y123.982 E-.14303
G1 X106.935 Y125.303 E-.50183
G1 X106.637 Y125.247 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L44
M991 S0 P43 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.64 I-.188 J1.202 P1  F60000
G1 X152.381 Y132.381 Z5.64
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
M73 P70 R4
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2764
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.018 Y131.935 Z5.76 F60000
G1 Z5.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.018 Y130.238 E.0352
G2 X150.76 Y129.164 I-7.394 J7.395 E.03434
G2 X149.065 Y129.013 I-1.025 J1.908 E.03627
G1 X149.065 Y125.473 E.07343
G3 X151.67 Y126.076 I.926 J1.928 E.05992
G1 X152.018 Y126.412 E.01003
G1 X152.018 Y124.715 E.0352
M204 S10000
G1 X147.984 Y132.21 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423602
G1 F10800
M204 S4000
G1 X148.656 Y131.539 E.01848
G1 X148.656 Y130.976 E.01094
G1 X147.599 Y132.033 E.02908
G1 X147.036 Y132.033 E.01094
G1 X148.656 Y130.413 E.04455
G1 X148.656 Y129.851 E.01094
G1 X146.473 Y132.033 E.06003
G1 X145.911 Y132.033 E.01094
G1 X148.656 Y129.288 E.07551
G1 X148.656 Y128.725 E.01094
G1 X145.348 Y132.033 E.09099
G1 X144.785 Y132.033 E.01094
G1 X148.656 Y128.163 E.10646
G1 X148.656 Y127.6 E.01094
G1 X144.223 Y132.033 E.12194
G1 X143.66 Y132.033 E.01094
G1 X148.656 Y127.037 E.13742
G1 X148.656 Y126.475 E.01094
G1 X143.098 Y132.033 E.1529
G1 X142.535 Y132.033 E.01094
G1 X148.656 Y125.912 E.16838
G1 X148.656 Y125.35 E.01094
G1 X141.972 Y132.033 E.18385
G1 X141.41 Y132.033 E.01094
G1 X148.656 Y124.787 E.19933
G1 X148.656 Y124.224 E.01094
G1 X140.847 Y132.033 E.21481
G1 X140.284 Y132.033 E.01094
G1 X148.35 Y123.967 E.22188
G1 X147.787 Y123.967 E.01094
G1 X139.722 Y132.033 E.22188
G1 X139.159 Y132.033 E.01094
G1 X147.225 Y123.967 E.22188
G1 X146.662 Y123.967 E.01094
G1 X138.596 Y132.033 E.22188
G1 X138.034 Y132.033 E.01094
G1 X146.1 Y123.967 E.22188
M73 P70 R3
G1 X145.537 Y123.967 E.01094
G1 X137.471 Y132.033 E.22188
G1 X136.908 Y132.033 E.01094
G1 X144.974 Y123.967 E.22188
G1 X144.412 Y123.967 E.01094
G1 X136.346 Y132.033 E.22188
G1 X135.783 Y132.033 E.01094
G1 X143.849 Y123.967 E.22188
G1 X143.286 Y123.967 E.01094
G1 X135.221 Y132.033 E.22188
G1 X134.658 Y132.033 E.01094
G1 X142.724 Y123.967 E.22188
G1 X142.161 Y123.967 E.01094
G1 X134.095 Y132.033 E.22188
G1 X133.533 Y132.033 E.01094
G1 X141.598 Y123.967 E.22188
G1 X141.036 Y123.967 E.01094
G1 X132.97 Y132.033 E.22188
G1 X132.407 Y132.033 E.01094
G1 X140.473 Y123.967 E.22188
G1 X139.91 Y123.967 E.01094
G1 X131.845 Y132.033 E.22188
G1 X131.282 Y132.033 E.01094
G1 X139.348 Y123.967 E.22188
G1 X138.785 Y123.967 E.01094
G1 X130.719 Y132.033 E.22188
G1 X130.157 Y132.033 E.01094
G1 X138.223 Y123.967 E.22188
G1 X137.66 Y123.967 E.01094
G1 X129.594 Y132.033 E.22188
G1 X129.031 Y132.033 E.01094
G1 X137.097 Y123.967 E.22188
G1 X136.535 Y123.967 E.01094
G1 X128.469 Y132.033 E.22188
G1 X127.906 Y132.033 E.01094
G1 X135.972 Y123.967 E.22188
G1 X135.409 Y123.967 E.01094
G1 X127.343 Y132.033 E.22188
G1 X126.781 Y132.033 E.01094
G1 X134.847 Y123.967 E.22188
G1 X134.284 Y123.967 E.01094
G1 X126.218 Y132.033 E.22188
G1 X125.656 Y132.033 E.01094
M73 P71 R3
G1 X133.721 Y123.967 E.22188
G1 X133.159 Y123.967 E.01094
G1 X125.093 Y132.033 E.22188
G1 X124.53 Y132.033 E.01094
G1 X132.596 Y123.967 E.22188
G1 X132.033 Y123.967 E.01094
G1 X123.968 Y132.033 E.22188
G1 X123.405 Y132.033 E.01094
G1 X131.471 Y123.967 E.22188
G1 X130.908 Y123.967 E.01094
G1 X122.842 Y132.033 E.22188
G1 X122.28 Y132.033 E.01094
G1 X130.346 Y123.967 E.22188
G1 X129.783 Y123.967 E.01094
G1 X121.717 Y132.033 E.22188
G1 X121.154 Y132.033 E.01094
G1 X129.22 Y123.967 E.22188
G1 X128.658 Y123.967 E.01094
G1 X120.592 Y132.033 E.22188
G1 X120.029 Y132.033 E.01094
G1 X128.095 Y123.967 E.22188
G1 X127.532 Y123.967 E.01094
G1 X119.466 Y132.033 E.22188
G1 X118.904 Y132.033 E.01094
G1 X126.97 Y123.967 E.22188
G1 X126.407 Y123.967 E.01094
G1 X118.341 Y132.033 E.22188
G1 X117.779 Y132.033 E.01094
G1 X125.844 Y123.967 E.22188
G1 X125.282 Y123.967 E.01094
G1 X117.216 Y132.033 E.22188
G1 X116.653 Y132.033 E.01094
G1 X124.719 Y123.967 E.22188
G1 X124.156 Y123.967 E.01094
G1 X116.091 Y132.033 E.22188
G1 X115.528 Y132.033 E.01094
G1 X123.594 Y123.967 E.22188
G1 X123.031 Y123.967 E.01094
G1 X114.965 Y132.033 E.22188
G1 X114.403 Y132.033 E.01094
G1 X122.468 Y123.967 E.22188
G1 X121.906 Y123.967 E.01094
G1 X113.84 Y132.033 E.22188
G1 X113.277 Y132.033 E.01094
G1 X121.343 Y123.967 E.22188
G1 X120.781 Y123.967 E.01094
G1 X112.715 Y132.033 E.22188
G1 X112.152 Y132.033 E.01094
G1 X120.218 Y123.967 E.22188
G1 X119.655 Y123.967 E.01094
G1 X111.589 Y132.033 E.22188
G1 X111.027 Y132.033 E.01094
G1 X119.093 Y123.967 E.22188
G1 X118.53 Y123.967 E.01094
G1 X110.464 Y132.033 E.22188
G1 X109.902 Y132.033 E.01094
G1 X117.967 Y123.967 E.22188
G1 X117.405 Y123.967 E.01094
G1 X109.339 Y132.033 E.22188
G1 X108.776 Y132.033 E.01094
G1 X116.842 Y123.967 E.22188
G1 X116.279 Y123.967 E.01094
G1 X108.214 Y132.033 E.22188
G1 X107.651 Y132.033 E.01094
G1 X115.717 Y123.967 E.22188
G1 X115.154 Y123.967 E.01094
G1 X107.344 Y131.777 E.21484
G1 X107.344 Y131.214 E.01094
G1 X114.591 Y123.967 E.19936
G1 X114.029 Y123.967 E.01094
G1 X107.344 Y130.652 E.18388
G1 X107.344 Y130.089 E.01094
G1 X113.466 Y123.967 E.16841
G1 X112.904 Y123.967 E.01094
G1 X107.344 Y129.526 E.15293
G1 X107.344 Y128.964 E.01094
G1 X112.341 Y123.967 E.13745
G1 X111.778 Y123.967 E.01094
G1 X107.344 Y128.401 E.12197
G1 X107.344 Y127.838 E.01094
G1 X111.216 Y123.967 E.10649
G1 X110.653 Y123.967 E.01094
G1 X107.344 Y127.276 E.09102
G1 X107.344 Y126.713 E.01094
G1 X110.09 Y123.967 E.07554
G1 X109.528 Y123.967 E.01094
G1 X107.344 Y126.15 E.06006
G1 X107.344 Y125.588 E.01094
G1 X108.965 Y123.967 E.04458
G1 X108.402 Y123.967 E.01094
G1 X107.344 Y125.025 E.0291
G1 X107.344 Y124.462 E.01094
G1 X108.017 Y123.79 E.01851
M204 S10000
G1 X106.627 Y123.982 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X106.935 Y123.982 E.00639
G1 X106.935 Y125.371 E.02881
G2 X105.24 Y125.523 I-.67 J2.059 E.03627
G2 X103.982 Y126.596 I6.136 J8.468 E.03434
G1 X103.982 Y130.054 E.07172
G1 X104.33 Y129.718 E.01003
G3 X106.935 Y129.114 I1.68 J1.324 E.05992
G1 X106.935 Y130.811 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.935 Y129.114 E-.64486
G1 X106.654 Y129.002 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L45
M991 S0 P44 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.76 I-.09 J1.214 P1  F60000
G1 X152.381 Y132.381 Z5.76
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2885
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P72 R3
G1 X149.065 Y130.771 Z5.88 F60000
G1 Z5.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.065 Y129.074 E.0352
G3 X150.76 Y129.097 I.821 J1.966 E.03616
G3 X152.018 Y130.129 I-3.56 J5.625 E.03383
G1 X152.018 Y126.519 E.07488
G1 X151.67 Y126.197 E.00983
G2 X149.065 Y125.415 I-1.834 J1.381 E.06038
G1 X149.065 Y123.982 E.02973
G1 X149.329 Y123.982 E.00547
M204 S10000
G1 X148.833 Y124.639 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.423602
G1 F10800
M204 S4000
G1 X148.161 Y123.967 E.01848
G1 X147.599 Y123.967 E.01094
G1 X148.656 Y125.024 E.02908
G1 X148.656 Y125.587 E.01094
G1 X147.036 Y123.967 E.04455
G1 X146.473 Y123.967 E.01094
G1 X148.656 Y126.149 E.06003
G1 X148.656 Y126.712 E.01094
G1 X145.911 Y123.967 E.07551
G1 X145.348 Y123.967 E.01094
G1 X148.656 Y127.275 E.09099
G1 X148.656 Y127.837 E.01094
G1 X144.785 Y123.967 E.10646
G1 X144.223 Y123.967 E.01094
G1 X148.656 Y128.4 E.12194
G1 X148.656 Y128.963 E.01094
G1 X143.66 Y123.967 E.13742
G1 X143.098 Y123.967 E.01094
G1 X148.656 Y129.525 E.1529
G1 X148.656 Y130.088 E.01094
G1 X142.535 Y123.967 E.16838
G1 X141.972 Y123.967 E.01094
G1 X148.656 Y130.65 E.18385
G1 X148.656 Y131.213 E.01094
G1 X141.41 Y123.967 E.19933
G1 X140.847 Y123.967 E.01094
G1 X148.656 Y131.776 E.21481
G1 X148.656 Y132.033 E.005
G1 X148.35 Y132.033 E.00594
G1 X140.284 Y123.967 E.22188
G1 X139.722 Y123.967 E.01094
G1 X147.787 Y132.033 E.22188
G1 X147.225 Y132.033 E.01094
G1 X139.159 Y123.967 E.22188
G1 X138.596 Y123.967 E.01094
G1 X146.662 Y132.033 E.22188
G1 X146.1 Y132.033 E.01094
G1 X138.034 Y123.967 E.22188
G1 X137.471 Y123.967 E.01094
G1 X145.537 Y132.033 E.22188
G1 X144.974 Y132.033 E.01094
G1 X136.908 Y123.967 E.22188
G1 X136.346 Y123.967 E.01094
G1 X144.412 Y132.033 E.22188
G1 X143.849 Y132.033 E.01094
G1 X135.783 Y123.967 E.22188
G1 X135.221 Y123.967 E.01094
G1 X143.286 Y132.033 E.22188
G1 X142.724 Y132.033 E.01094
G1 X134.658 Y123.967 E.22188
G1 X134.095 Y123.967 E.01094
G1 X142.161 Y132.033 E.22188
G1 X141.598 Y132.033 E.01094
G1 X133.533 Y123.967 E.22188
G1 X132.97 Y123.967 E.01094
G1 X141.036 Y132.033 E.22188
G1 X140.473 Y132.033 E.01094
G1 X132.407 Y123.967 E.22188
G1 X131.845 Y123.967 E.01094
G1 X139.91 Y132.033 E.22188
G1 X139.348 Y132.033 E.01094
G1 X131.282 Y123.967 E.22188
G1 X130.719 Y123.967 E.01094
G1 X138.785 Y132.033 E.22188
G1 X138.223 Y132.033 E.01094
G1 X130.157 Y123.967 E.22188
G1 X129.594 Y123.967 E.01094
G1 X137.66 Y132.033 E.22188
G1 X137.097 Y132.033 E.01094
G1 X129.031 Y123.967 E.22188
G1 X128.469 Y123.967 E.01094
G1 X136.535 Y132.033 E.22188
G1 X135.972 Y132.033 E.01094
G1 X127.906 Y123.967 E.22188
G1 X127.344 Y123.967 E.01094
G1 X135.409 Y132.033 E.22188
G1 X134.847 Y132.033 E.01094
G1 X126.781 Y123.967 E.22188
G1 X126.218 Y123.967 E.01094
G1 X134.284 Y132.033 E.22188
G1 X133.721 Y132.033 E.01094
G1 X125.656 Y123.967 E.22188
G1 X125.093 Y123.967 E.01094
G1 X133.159 Y132.033 E.22188
G1 X132.596 Y132.033 E.01094
G1 X124.53 Y123.967 E.22188
G1 X123.968 Y123.967 E.01094
G1 X132.033 Y132.033 E.22188
G1 X131.471 Y132.033 E.01094
G1 X123.405 Y123.967 E.22188
G1 X122.842 Y123.967 E.01094
G1 X130.908 Y132.033 E.22188
G1 X130.345 Y132.033 E.01094
G1 X122.28 Y123.967 E.22188
G1 X121.717 Y123.967 E.01094
G1 X129.783 Y132.033 E.22188
G1 X129.22 Y132.033 E.01094
G1 X121.154 Y123.967 E.22188
G1 X120.592 Y123.967 E.01094
G1 X128.658 Y132.033 E.22188
G1 X128.095 Y132.033 E.01094
G1 X120.029 Y123.967 E.22188
G1 X119.466 Y123.967 E.01094
G1 X127.532 Y132.033 E.22188
G1 X126.97 Y132.033 E.01094
G1 X118.904 Y123.967 E.22188
G1 X118.341 Y123.967 E.01094
G1 X126.407 Y132.033 E.22188
G1 X125.844 Y132.033 E.01094
G1 X117.779 Y123.967 E.22188
G1 X117.216 Y123.967 E.01094
G1 X125.282 Y132.033 E.22188
G1 X124.719 Y132.033 E.01094
G1 X116.653 Y123.967 E.22188
G1 X116.091 Y123.967 E.01094
M73 P73 R3
G1 X124.156 Y132.033 E.22188
G1 X123.594 Y132.033 E.01094
G1 X115.528 Y123.967 E.22188
G1 X114.965 Y123.967 E.01094
G1 X123.031 Y132.033 E.22188
G1 X122.468 Y132.033 E.01094
G1 X114.403 Y123.967 E.22188
G1 X113.84 Y123.967 E.01094
G1 X121.906 Y132.033 E.22188
G1 X121.343 Y132.033 E.01094
G1 X113.277 Y123.967 E.22188
G1 X112.715 Y123.967 E.01094
G1 X120.781 Y132.033 E.22188
G1 X120.218 Y132.033 E.01094
G1 X112.152 Y123.967 E.22188
G1 X111.589 Y123.967 E.01094
G1 X119.655 Y132.033 E.22188
G1 X119.093 Y132.033 E.01094
G1 X111.027 Y123.967 E.22188
G1 X110.464 Y123.967 E.01094
G1 X118.53 Y132.033 E.22188
G1 X117.967 Y132.033 E.01094
G1 X109.902 Y123.967 E.22188
G1 X109.339 Y123.967 E.01094
G1 X117.405 Y132.033 E.22188
G1 X116.842 Y132.033 E.01094
G1 X108.776 Y123.967 E.22188
G1 X108.214 Y123.967 E.01094
G1 X116.279 Y132.033 E.22188
G1 X115.717 Y132.033 E.01094
G1 X107.651 Y123.967 E.22188
G1 X107.344 Y123.967 E.00596
G1 X107.344 Y124.223 E.00498
G1 X115.154 Y132.033 E.21484
G1 X114.591 Y132.033 E.01094
G1 X107.344 Y124.786 E.19936
G1 X107.344 Y125.348 E.01094
G1 X114.029 Y132.033 E.18388
G1 X113.466 Y132.033 E.01094
G1 X107.344 Y125.911 E.16841
G1 X107.344 Y126.474 E.01094
G1 X112.904 Y132.033 E.15293
G1 X112.341 Y132.033 E.01094
G1 X107.344 Y127.036 E.13745
G1 X107.344 Y127.599 E.01094
G1 X111.778 Y132.033 E.12197
G1 X111.216 Y132.033 E.01094
G1 X107.344 Y128.162 E.10649
G1 X107.344 Y128.724 E.01094
G1 X110.653 Y132.033 E.09102
G1 X110.09 Y132.033 E.01094
G1 X107.344 Y129.287 E.07554
G1 X107.344 Y129.85 E.01094
G1 X109.528 Y132.033 E.06006
G1 X108.965 Y132.033 E.01094
G1 X107.344 Y130.412 E.04458
G1 X107.344 Y130.975 E.01094
G1 X108.402 Y132.033 E.02911
G1 X107.84 Y132.033 E.01094
G1 X107.167 Y131.36 E.01851
M204 S10000
G1 X103.982 Y131.857 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X103.982 Y130.16 E.0352
G1 X104.33 Y129.838 E.00983
G3 X106.935 Y129.057 I1.834 J1.381 E.06038
G1 X106.935 Y125.433 E.07517
G2 X105.24 Y125.456 I-.821 J1.966 E.03615
G2 X103.982 Y126.487 I3.56 J5.625 E.03384
G1 X103.982 Y124.79 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y126.487 E-.64486
G1 X104.204 Y126.281 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L46
M991 S0 P45 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.88 I-.153 J1.207 P1  F60000
G1 X152.381 Y132.381 Z5.88
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2994
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X148.315 Y131.376 Z6 F60000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X148.315 Y129.679 E.0352
G3 X150.76 Y129.024 I1.718 J1.521 E.05562
G3 X152.018 Y130.023 I-2.284 J4.168 E.03348
G1 X152.018 Y126.629 E.07039
G3 X151.215 Y125.872 I8.008 J-9.303 E.02289
G2 X148.315 Y125.785 I-1.498 J1.549 E.06603
G1 X148.315 Y124.088 E.0352
M204 S10000
G1 X147.24 Y132.21 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420552
G1 F10800
M204 S4000
G1 X147.905 Y131.545 E.01816
G1 X147.905 Y130.987 E.01078
G1 X146.859 Y132.033 E.02856
G1 X146.301 Y132.033 E.01078
G1 X147.905 Y130.429 E.0438
G1 X147.905 Y129.87 E.01078
G1 X145.743 Y132.033 E.05904
G1 X145.184 Y132.033 E.01078
G1 X147.905 Y129.312 E.07428
G1 X147.905 Y128.754 E.01078
G1 X144.626 Y132.033 E.08952
M73 P74 R3
G1 X144.068 Y132.033 E.01078
G1 X147.905 Y128.195 E.10476
G1 X147.905 Y127.637 E.01078
G1 X143.509 Y132.033 E.12
G1 X142.951 Y132.033 E.01078
G1 X147.905 Y127.079 E.13525
G1 X147.905 Y126.52 E.01078
G1 X142.393 Y132.033 E.15049
G1 X141.834 Y132.033 E.01078
G1 X147.905 Y125.962 E.16573
G1 X147.905 Y125.404 E.01078
G1 X141.276 Y132.033 E.18097
G1 X140.718 Y132.033 E.01078
G1 X147.905 Y124.845 E.19621
G1 X147.905 Y124.287 E.01078
G1 X140.159 Y132.033 E.21145
G1 X139.601 Y132.033 E.01078
G1 X147.667 Y123.967 E.22018
G1 X147.108 Y123.967 E.01078
G1 X139.043 Y132.033 E.22018
G1 X138.484 Y132.033 E.01078
G1 X146.55 Y123.967 E.22018
G1 X145.992 Y123.967 E.01078
G1 X137.926 Y132.033 E.22018
G1 X137.368 Y132.033 E.01078
G1 X145.433 Y123.967 E.22018
G1 X144.875 Y123.967 E.01078
G1 X136.809 Y132.033 E.22018
G1 X136.251 Y132.033 E.01078
G1 X144.317 Y123.967 E.22018
G1 X143.758 Y123.967 E.01078
G1 X135.693 Y132.033 E.22018
G1 X135.134 Y132.033 E.01078
G1 X143.2 Y123.967 E.22018
G1 X142.642 Y123.967 E.01078
G1 X134.576 Y132.033 E.22018
G1 X134.018 Y132.033 E.01078
G1 X142.083 Y123.967 E.22018
G1 X141.525 Y123.967 E.01078
G1 X133.459 Y132.033 E.22018
G1 X132.901 Y132.033 E.01078
G1 X140.967 Y123.967 E.22018
G1 X140.408 Y123.967 E.01078
G1 X132.343 Y132.033 E.22018
G1 X131.784 Y132.033 E.01078
G1 X139.85 Y123.967 E.22018
G1 X139.292 Y123.967 E.01078
G1 X131.226 Y132.033 E.22018
G1 X130.668 Y132.033 E.01078
G1 X138.733 Y123.967 E.22018
G1 X138.175 Y123.967 E.01078
G1 X130.109 Y132.033 E.22018
G1 X129.551 Y132.033 E.01078
G1 X137.617 Y123.967 E.22018
G1 X137.058 Y123.967 E.01078
G1 X128.993 Y132.033 E.22018
G1 X128.434 Y132.033 E.01078
G1 X136.5 Y123.967 E.22018
G1 X135.942 Y123.967 E.01078
G1 X127.876 Y132.033 E.22018
G1 X127.318 Y132.033 E.01078
G1 X135.383 Y123.967 E.22018
G1 X134.825 Y123.967 E.01078
G1 X126.759 Y132.033 E.22018
G1 X126.201 Y132.033 E.01078
G1 X134.267 Y123.967 E.22018
G1 X133.708 Y123.967 E.01078
G1 X125.643 Y132.033 E.22018
G1 X125.084 Y132.033 E.01078
G1 X133.15 Y123.967 E.22018
G1 X132.592 Y123.967 E.01078
G1 X124.526 Y132.033 E.22018
G1 X123.968 Y132.033 E.01078
G1 X132.033 Y123.967 E.22018
G1 X131.475 Y123.967 E.01078
G1 X123.409 Y132.033 E.22018
G1 X122.851 Y132.033 E.01078
G1 X130.917 Y123.967 E.22018
G1 X130.358 Y123.967 E.01078
G1 X122.293 Y132.033 E.22018
G1 X121.734 Y132.033 E.01078
G1 X129.8 Y123.967 E.22018
G1 X129.242 Y123.967 E.01078
G1 X121.176 Y132.033 E.22018
G1 X120.618 Y132.033 E.01078
G1 X128.683 Y123.967 E.22018
G1 X128.125 Y123.967 E.01078
G1 X120.059 Y132.033 E.22018
G1 X119.501 Y132.033 E.01078
G1 X127.567 Y123.967 E.22018
G1 X127.008 Y123.967 E.01078
G1 X118.943 Y132.033 E.22018
G1 X118.384 Y132.033 E.01078
G1 X126.45 Y123.967 E.22018
G1 X125.892 Y123.967 E.01078
G1 X117.826 Y132.033 E.22018
G1 X117.268 Y132.033 E.01078
G1 X125.333 Y123.967 E.22018
G1 X124.775 Y123.967 E.01078
G1 X116.709 Y132.033 E.22018
G1 X116.151 Y132.033 E.01078
G1 X124.217 Y123.967 E.22018
G1 X123.658 Y123.967 E.01078
G1 X115.593 Y132.033 E.22018
G1 X115.034 Y132.033 E.01078
G1 X123.1 Y123.967 E.22018
G1 X122.542 Y123.967 E.01078
G1 X114.476 Y132.033 E.22018
G1 X113.918 Y132.033 E.01078
G1 X121.983 Y123.967 E.22018
G1 X121.425 Y123.967 E.01078
G1 X113.359 Y132.033 E.22018
G1 X112.801 Y132.033 E.01078
G1 X120.867 Y123.967 E.22018
G1 X120.308 Y123.967 E.01078
G1 X112.243 Y132.033 E.22018
G1 X111.684 Y132.033 E.01078
G1 X119.75 Y123.967 E.22018
G1 X119.192 Y123.967 E.01078
G1 X111.126 Y132.033 E.22018
G1 X110.568 Y132.033 E.01078
G1 X118.633 Y123.967 E.22018
G1 X118.075 Y123.967 E.01078
G1 X110.009 Y132.033 E.22018
G1 X109.451 Y132.033 E.01078
G1 X117.517 Y123.967 E.22018
G1 X116.958 Y123.967 E.01078
G1 X108.893 Y132.033 E.22018
G1 X108.334 Y132.033 E.01078
G1 X116.4 Y123.967 E.22018
G1 X115.842 Y123.967 E.01078
G1 X108.095 Y131.714 E.21148
G1 X108.095 Y131.156 E.01078
G1 X115.283 Y123.967 E.19624
G1 X114.725 Y123.967 E.01078
G1 X108.095 Y130.598 E.181
G1 X108.095 Y130.039 E.01078
M73 P75 R3
G1 X114.167 Y123.967 E.16576
G1 X113.608 Y123.967 E.01078
G1 X108.095 Y129.481 E.15052
G1 X108.095 Y128.923 E.01078
G1 X113.05 Y123.967 E.13527
G1 X112.492 Y123.967 E.01078
G1 X108.095 Y128.364 E.12003
G1 X108.095 Y127.806 E.01078
G1 X111.933 Y123.967 E.10479
G1 X111.375 Y123.967 E.01078
G1 X108.095 Y127.248 E.08955
G1 X108.095 Y126.689 E.01078
G1 X110.817 Y123.967 E.07431
G1 X110.259 Y123.967 E.01078
G1 X108.095 Y126.131 E.05907
G1 X108.095 Y125.573 E.01078
G1 X109.7 Y123.967 E.04383
G1 X109.142 Y123.967 E.01078
G1 X108.095 Y125.014 E.02858
G1 X108.095 Y124.456 E.01078
G1 X108.761 Y123.79 E.01819
M204 S10000
G1 X103.982 Y124.684 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X103.982 Y126.381 E.0352
G3 X105.24 Y125.382 I3.542 J3.17 E.03349
G3 X107.685 Y126.038 I.727 J2.177 E.05562
G1 X107.685 Y129.426 E.07028
G2 X104.785 Y129.514 I-1.402 J1.637 E.06603
G3 X103.982 Y130.271 I-8.817 J-8.552 E.0229
G1 X103.982 Y131.968 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y130.271 E-.64486
G1 X104.203 Y130.063 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L47
M991 S0 P46 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6 I-.058 J1.216 P1  F60000
G1 X152.381 Y132.381 Z6
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F7881
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3091
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.112 Y130.982 Z6.12 F60000
G1 X104.049 Y132.018 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7881
M204 S4000
G1 X103.982 Y132.018 E.00138
G1 X103.982 Y130.388 E.03382
G2 X104.785 Y129.614 I-4.057 J-5.016 E.02316
G3 X107.061 Y128.943 I1.732 J1.679 E.05146
G3 X108.427 Y130.027 I-1.647 J3.476 E.03648
G2 X110.703 Y130.698 I1.732 J-1.679 E.05146
G2 X112.068 Y129.614 I-1.647 J-3.477 E.03648
G3 X114.344 Y128.943 I1.732 J1.679 E.05146
G3 X115.71 Y130.027 I-1.647 J3.476 E.03648
G2 X117.986 Y130.698 I1.732 J-1.679 E.05146
G2 X119.351 Y129.614 I-1.647 J-3.477 E.03648
G3 X121.627 Y128.943 I1.732 J1.679 E.05146
G3 X122.993 Y130.027 I-1.647 J3.476 E.03648
G2 X125.269 Y130.698 I1.732 J-1.679 E.05146
G2 X126.635 Y129.614 I-1.647 J-3.477 E.03648
G3 X128.911 Y128.943 I1.732 J1.679 E.05146
G3 X130.276 Y130.027 I-1.647 J3.476 E.03648
G2 X132.552 Y130.698 I1.732 J-1.679 E.05146
G2 X133.918 Y129.614 I-1.647 J-3.477 E.03648
G3 X136.194 Y128.943 I1.732 J1.679 E.05146
G3 X137.559 Y130.027 I-1.647 J3.477 E.03648
G2 X139.835 Y130.698 I1.732 J-1.679 E.05146
G2 X141.201 Y129.614 I-1.647 J-3.477 E.03648
G3 X143.477 Y128.943 I1.732 J1.679 E.05146
G3 X144.842 Y130.027 I-1.647 J3.476 E.03648
G2 X147.118 Y130.698 I1.732 J-1.679 E.05146
G2 X148.484 Y129.614 I-1.647 J-3.477 E.03648
G3 X150.76 Y128.943 I1.732 J1.679 E.05146
G3 X152.018 Y129.916 I-1.513 J3.256 E.03326
G1 X152.018 Y126.746 E.06576
G3 X151.215 Y125.973 I4.055 J-5.014 E.02315
G2 X148.939 Y125.302 I-1.732 J1.679 E.05146
G2 X147.574 Y126.386 I1.647 J3.476 E.03648
G3 X145.298 Y127.057 I-1.732 J-1.679 E.05146
G3 X143.932 Y125.973 I1.647 J-3.476 E.03648
G2 X141.656 Y125.302 I-1.732 J1.679 E.05146
G2 X140.29 Y126.386 I1.647 J3.476 E.03648
G3 X138.014 Y127.057 I-1.732 J-1.679 E.05146
G3 X136.649 Y125.973 I1.647 J-3.477 E.03648
G2 X134.373 Y125.302 I-1.732 J1.679 E.05146
G2 X133.007 Y126.386 I1.647 J3.476 E.03648
G3 X130.731 Y127.057 I-1.732 J-1.679 E.05146
G3 X129.366 Y125.973 I1.647 J-3.476 E.03648
G2 X127.09 Y125.302 I-1.732 J1.679 E.05146
G2 X125.724 Y126.386 I1.647 J3.477 E.03648
G3 X123.448 Y127.057 I-1.732 J-1.679 E.05146
G3 X122.083 Y125.973 I1.647 J-3.477 E.03648
G2 X119.807 Y125.302 I-1.732 J1.679 E.05146
G2 X118.441 Y126.386 I1.647 J3.477 E.03648
G3 X116.165 Y127.057 I-1.732 J-1.679 E.05146
G3 X114.799 Y125.973 I1.647 J-3.477 E.03648
G2 X112.524 Y125.302 I-1.732 J1.679 E.05146
G2 X111.158 Y126.386 I1.647 J3.477 E.03648
G3 X108.882 Y127.057 I-1.732 J-1.679 E.05146
G3 X107.516 Y125.973 I1.647 J-3.476 E.03648
G2 X105.24 Y125.302 I-1.732 J1.679 E.05146
G2 X103.982 Y126.275 I1.513 J3.256 E.03327
G1 X103.982 Y124.578 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y126.275 E-.64486
G1 X104.203 Y126.067 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L48
M991 S0 P47 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.12 I-.158 J1.207 P1  F60000
G1 X152.381 Y132.381 Z6.12
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F7927
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3175
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
M73 P76 R3
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.113 Y130.983 Z6.24 F60000
G1 X104.176 Y132.018 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7927
M204 S4000
G1 X103.982 Y132.018 E.00403
G1 X103.982 Y130.515 E.03117
G2 X104.785 Y129.716 I-2.579 J-3.396 E.02357
G3 X107.061 Y128.854 I1.927 J1.651 E.05265
G3 X108.427 Y129.925 I-1.083 J2.787 E.03653
G2 X110.703 Y130.787 I1.927 J-1.652 E.05265
G2 X112.068 Y129.716 I-1.083 J-2.787 E.03653
G3 X114.344 Y128.854 I1.927 J1.651 E.05265
G3 X115.71 Y129.925 I-1.083 J2.787 E.03653
G2 X117.986 Y130.787 I1.927 J-1.652 E.05265
G2 X119.351 Y129.716 I-1.083 J-2.787 E.03653
G3 X121.627 Y128.854 I1.927 J1.651 E.05265
G3 X122.993 Y129.925 I-1.083 J2.787 E.03653
G2 X125.269 Y130.787 I1.927 J-1.652 E.05265
G2 X126.635 Y129.716 I-1.083 J-2.787 E.03653
G3 X128.911 Y128.854 I1.927 J1.651 E.05265
G3 X130.276 Y129.925 I-1.083 J2.787 E.03653
G2 X132.552 Y130.787 I1.927 J-1.652 E.05265
G2 X133.918 Y129.716 I-1.083 J-2.787 E.03653
G3 X136.194 Y128.854 I1.927 J1.651 E.05265
G3 X137.559 Y129.925 I-1.083 J2.787 E.03653
G2 X139.835 Y130.787 I1.927 J-1.652 E.05265
G2 X141.201 Y129.716 I-1.083 J-2.787 E.03653
G3 X143.477 Y128.854 I1.927 J1.651 E.05265
G3 X144.842 Y129.925 I-1.083 J2.787 E.03653
G2 X147.118 Y130.787 I1.927 J-1.652 E.05265
G2 X148.484 Y129.716 I-1.083 J-2.787 E.03653
G3 X150.76 Y128.854 I1.927 J1.651 E.05265
G3 X152.018 Y129.806 I-.987 J2.611 E.03317
G1 X152.018 Y126.873 E.06084
G3 X151.215 Y126.075 I2.579 J-3.394 E.02356
G2 X148.939 Y125.213 I-1.927 J1.652 E.05265
G2 X147.574 Y126.284 I1.083 J2.787 E.03653
G3 X145.298 Y127.146 I-1.927 J-1.652 E.05265
G3 X143.932 Y126.075 I1.083 J-2.787 E.03653
G2 X141.656 Y125.213 I-1.927 J1.652 E.05265
G2 X140.29 Y126.284 I1.083 J2.787 E.03653
G3 X138.014 Y127.146 I-1.927 J-1.652 E.05265
G3 X136.649 Y126.075 I1.083 J-2.787 E.03653
G2 X134.373 Y125.213 I-1.927 J1.652 E.05265
G2 X133.007 Y126.284 I1.083 J2.787 E.03653
G3 X130.731 Y127.146 I-1.927 J-1.652 E.05265
G3 X129.366 Y126.075 I1.083 J-2.787 E.03653
G2 X127.09 Y125.213 I-1.927 J1.652 E.05265
G2 X125.724 Y126.284 I1.083 J2.787 E.03653
G3 X123.448 Y127.146 I-1.927 J-1.651 E.05265
G3 X122.083 Y126.075 I1.083 J-2.787 E.03653
G2 X119.807 Y125.213 I-1.927 J1.652 E.05265
G2 X118.441 Y126.284 I1.083 J2.787 E.03653
G3 X116.165 Y127.146 I-1.927 J-1.652 E.05265
G3 X114.799 Y126.075 I1.083 J-2.787 E.03653
G2 X112.524 Y125.213 I-1.927 J1.652 E.05265
G2 X111.158 Y126.284 I1.083 J2.787 E.03653
G3 X108.882 Y127.146 I-1.927 J-1.651 E.05265
G3 X107.516 Y126.075 I1.083 J-2.787 E.03653
G2 X105.24 Y125.213 I-1.927 J1.652 E.05265
G2 X103.982 Y126.165 I.987 J2.612 E.03318
G1 X103.982 Y124.468 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y126.165 E-.64486
G1 X104.201 Y125.955 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L49
M991 S0 P48 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.24 I-.161 J1.206 P1  F60000
G1 X152.381 Y132.381 Z6.24
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F7996
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3248
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.113 Y130.984 Z6.36 F60000
G1 X104.32 Y132.018 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7996
M204 S4000
G1 X103.982 Y132.018 E.007
G1 X103.982 Y130.658 E.0282
G2 X105.24 Y129.354 I-3.62 J-4.751 E.03774
G3 X107.516 Y128.895 I1.534 J1.733 E.05045
G3 X108.882 Y130.287 I-3.854 J5.145 E.04061
G2 X111.158 Y130.747 I1.534 J-1.733 E.05045
G2 X112.524 Y129.354 I-3.854 J-5.145 E.04061
G3 X114.799 Y128.895 I1.534 J1.733 E.05045
G3 X116.165 Y130.287 I-3.854 J5.145 E.04061
M73 P77 R3
G2 X118.441 Y130.747 I1.534 J-1.733 E.05045
G2 X119.807 Y129.354 I-3.854 J-5.145 E.04061
G3 X122.083 Y128.895 I1.534 J1.733 E.05045
G3 X123.448 Y130.287 I-3.854 J5.145 E.04061
G2 X125.724 Y130.747 I1.534 J-1.733 E.05045
G2 X127.09 Y129.354 I-3.854 J-5.145 E.04061
G3 X129.366 Y128.895 I1.534 J1.733 E.05045
G3 X130.731 Y130.287 I-3.854 J5.145 E.04061
G2 X133.007 Y130.747 I1.534 J-1.733 E.05045
G2 X134.373 Y129.354 I-3.855 J-5.146 E.04061
G3 X136.649 Y128.895 I1.534 J1.733 E.05045
G3 X138.014 Y130.287 I-3.854 J5.145 E.04061
G2 X140.29 Y130.747 I1.534 J-1.733 E.05045
G2 X141.656 Y129.354 I-3.854 J-5.145 E.04061
G3 X143.932 Y128.895 I1.534 J1.733 E.05045
G3 X145.298 Y130.287 I-3.854 J5.145 E.04061
G2 X147.574 Y130.747 I1.534 J-1.733 E.05045
G2 X148.939 Y129.354 I-3.855 J-5.146 E.04061
G3 X151.215 Y128.895 I1.534 J1.733 E.05045
G3 X152.018 Y129.658 I-2.085 J2.997 E.02307
G1 X152.018 Y127.017 E.05479
G3 X150.76 Y125.713 I3.619 J-4.75 E.03773
G2 X148.484 Y125.253 I-1.534 J1.733 E.05045
G2 X147.118 Y126.646 I3.854 J5.145 E.04061
G3 X144.842 Y127.105 I-1.534 J-1.733 E.05045
G3 X143.477 Y125.713 I3.854 J-5.145 E.04061
G2 X141.201 Y125.253 I-1.534 J1.733 E.05045
G2 X139.835 Y126.646 I3.854 J5.145 E.04061
G3 X137.559 Y127.105 I-1.534 J-1.733 E.05045
G3 X136.194 Y125.713 I3.854 J-5.145 E.04061
G2 X133.918 Y125.253 I-1.534 J1.733 E.05045
G2 X132.552 Y126.646 I3.854 J5.145 E.04061
G3 X130.276 Y127.105 I-1.534 J-1.733 E.05045
G3 X128.911 Y125.713 I3.854 J-5.145 E.04061
G2 X126.635 Y125.253 I-1.534 J1.733 E.05045
G2 X125.269 Y126.646 I3.854 J5.145 E.04061
G3 X122.993 Y127.105 I-1.534 J-1.733 E.05045
G3 X121.627 Y125.713 I3.854 J-5.145 E.04061
G2 X119.351 Y125.253 I-1.534 J1.733 E.05045
G2 X117.986 Y126.646 I3.855 J5.146 E.04061
G3 X115.71 Y127.105 I-1.534 J-1.733 E.05045
G3 X114.344 Y125.713 I3.854 J-5.145 E.04061
G2 X112.068 Y125.253 I-1.534 J1.733 E.05045
G2 X110.703 Y126.646 I3.854 J5.145 E.04061
G3 X108.427 Y127.105 I-1.534 J-1.733 E.05045
G3 X107.061 Y125.713 I3.854 J-5.145 E.04061
G2 X104.785 Y125.253 I-1.534 J1.733 E.05045
G2 X103.982 Y126.017 I2.087 J2.998 E.02308
G1 X103.982 Y124.32 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y126.017 E-.64486
G1 X104.184 Y125.791 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L50
M991 S0 P49 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.36 I-.165 J1.206 P1  F60000
G1 X152.381 Y132.381 Z6.36
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8110
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3310
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.113 Y130.984 Z6.48 F60000
G1 X104.486 Y132.018 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8110
M204 S4000
G1 X103.982 Y132.018 E.01046
G1 X103.982 Y130.825 E.02474
G1 X104.33 Y130.552 E.00918
G1 X105.24 Y129.404 E.03038
G3 X107.061 Y128.644 I1.956 J2.123 E.04177
G3 X107.972 Y129.09 I.021 J1.11 E.02184
G1 X108.882 Y130.237 E.03038
G2 X110.703 Y130.998 I1.957 J-2.123 E.04177
G2 X111.613 Y130.552 I.021 J-1.11 E.02184
G1 X112.524 Y129.404 E.03038
G3 X114.344 Y128.644 I1.956 J2.123 E.04177
G3 X115.255 Y129.09 I.021 J1.11 E.02184
G1 X116.165 Y130.237 E.03038
G2 X117.986 Y130.998 I1.957 J-2.123 E.04177
G2 X118.896 Y130.552 I.021 J-1.11 E.02184
G1 X119.807 Y129.404 E.03038
G3 X121.627 Y128.644 I1.956 J2.123 E.04177
G3 X122.538 Y129.09 I.021 J1.11 E.02184
G1 X123.448 Y130.237 E.03038
G2 X125.269 Y130.998 I1.957 J-2.123 E.04177
G2 X126.179 Y130.552 I.021 J-1.11 E.02184
G1 X127.09 Y129.404 E.03038
G3 X128.911 Y128.644 I1.957 J2.123 E.04177
G3 X129.821 Y129.09 I.021 J1.11 E.02184
G1 X130.731 Y130.237 E.03038
G2 X132.552 Y130.998 I1.957 J-2.123 E.04177
G2 X133.463 Y130.552 I.021 J-1.11 E.02184
G1 X134.373 Y129.404 E.03038
G3 X136.194 Y128.644 I1.956 J2.123 E.04177
G3 X137.104 Y129.09 I.021 J1.11 E.02184
G1 X138.014 Y130.237 E.03038
G2 X139.835 Y130.998 I1.957 J-2.123 E.04177
G2 X140.746 Y130.552 I.021 J-1.11 E.02184
G1 X141.656 Y129.404 E.03038
G3 X143.477 Y128.644 I1.956 J2.123 E.04177
G3 X144.387 Y129.09 I.021 J1.11 E.02184
G1 X145.298 Y130.237 E.03038
G2 X147.118 Y130.998 I1.957 J-2.123 E.04177
G2 X148.029 Y130.552 I.021 J-1.11 E.02184
G1 X148.939 Y129.404 E.03038
G3 X150.76 Y128.644 I1.956 J2.123 E.04177
G1 X151.215 Y128.732 E.00962
G3 X152.018 Y129.528 I-1.267 J2.081 E.02366
G1 X152.018 Y127.183 E.04863
G1 X151.67 Y126.91 E.00917
G1 X150.76 Y125.763 E.03038
G2 X148.939 Y125.002 I-1.957 J2.123 E.04177
G2 X148.029 Y125.448 I-.021 J1.11 E.02184
G1 X147.118 Y126.596 E.03038
G3 X145.298 Y127.356 I-1.956 J-2.123 E.04177
G3 X144.387 Y126.91 I-.021 J-1.11 E.02184
G1 X143.477 Y125.763 E.03038
G2 X141.656 Y125.002 I-1.957 J2.123 E.04177
G2 X140.746 Y125.448 I-.021 J1.11 E.02184
G1 X139.835 Y126.596 E.03038
G3 X138.014 Y127.356 I-1.956 J-2.123 E.04177
G3 X137.104 Y126.91 I-.021 J-1.11 E.02184
G1 X136.194 Y125.763 E.03038
G2 X134.373 Y125.002 I-1.957 J2.123 E.04177
G2 X133.463 Y125.448 I-.021 J1.11 E.02184
G1 X132.552 Y126.596 E.03038
G3 X130.731 Y127.356 I-1.956 J-2.123 E.04177
G3 X129.821 Y126.91 I-.021 J-1.11 E.02184
G1 X128.911 Y125.763 E.03038
G2 X127.09 Y125.002 I-1.957 J2.123 E.04177
G2 X126.179 Y125.448 I-.021 J1.11 E.02184
G1 X125.269 Y126.596 E.03038
G3 X123.448 Y127.356 I-1.956 J-2.123 E.04177
G3 X122.538 Y126.91 I-.021 J-1.11 E.02184
G1 X121.627 Y125.763 E.03038
G2 X119.807 Y125.002 I-1.957 J2.123 E.04177
G2 X118.896 Y125.448 I-.021 J1.11 E.02184
G1 X117.986 Y126.596 E.03038
G3 X116.165 Y127.356 I-1.956 J-2.123 E.04177
G3 X115.255 Y126.91 I-.021 J-1.11 E.02184
G1 X114.344 Y125.763 E.03038
G2 X112.524 Y125.002 I-1.957 J2.123 E.04177
G2 X111.613 Y125.448 I-.021 J1.11 E.02184
G1 X110.703 Y126.596 E.03038
G3 X108.882 Y127.356 I-1.956 J-2.123 E.04177
G3 X107.972 Y126.91 I-.021 J-1.11 E.02184
G1 X107.061 Y125.763 E.03038
G2 X105.24 Y125.002 I-1.957 J2.123 E.04177
G1 X104.785 Y125.09 E.00962
G2 X103.982 Y125.887 I1.268 J2.082 E.02367
G1 X103.982 Y124.19 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y125.887 E-.64486
G1 X104.17 Y125.649 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L51
M991 S0 P50 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.48 I-.168 J1.205 P1  F60000
G1 X152.381 Y132.381 Z6.48
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8256
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3363
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
M73 P78 R3
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
M73 P78 R2
G1 E-.04 F1800
M204 S10000
G1 X145.113 Y130.985 Z6.6 F60000
G1 X104.691 Y132.018 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8256
M204 S4000
G1 X103.982 Y132.018 E.01471
G1 X103.982 Y131.03 E.02049
G1 X104.33 Y130.785 E.00883
G1 X105.24 Y129.452 E.03347
G3 X107.061 Y128.517 I2.28 J2.2 E.04323
G1 X107.516 Y128.536 E.00945
G1 X107.972 Y128.857 E.01155
G1 X108.882 Y130.189 E.03347
G2 X110.703 Y131.124 I2.28 J-2.2 E.04323
G1 X111.158 Y131.106 E.00945
G1 X111.613 Y130.785 E.01155
G1 X112.524 Y129.452 E.03347
G3 X114.344 Y128.517 I2.28 J2.2 E.04323
G1 X114.799 Y128.536 E.00945
G1 X115.255 Y128.857 E.01155
G1 X116.165 Y130.189 E.03347
G2 X117.986 Y131.124 I2.28 J-2.2 E.04323
G1 X118.441 Y131.106 E.00945
G1 X118.896 Y130.785 E.01155
G1 X119.807 Y129.452 E.03347
G3 X121.627 Y128.517 I2.28 J2.2 E.04323
G1 X122.083 Y128.536 E.00945
G1 X122.538 Y128.857 E.01155
G1 X123.448 Y130.189 E.03347
G2 X125.269 Y131.124 I2.28 J-2.2 E.04323
G1 X125.724 Y131.106 E.00945
G1 X126.179 Y130.785 E.01155
G1 X127.09 Y129.452 E.03347
G3 X128.911 Y128.517 I2.28 J2.2 E.04323
G1 X129.366 Y128.536 E.00945
G1 X129.821 Y128.857 E.01155
G1 X130.731 Y130.189 E.03347
G2 X132.552 Y131.124 I2.28 J-2.2 E.04323
G1 X133.007 Y131.106 E.00945
G1 X133.463 Y130.785 E.01155
G1 X134.373 Y129.452 E.03347
G3 X136.194 Y128.517 I2.28 J2.2 E.04323
G1 X136.649 Y128.536 E.00945
G1 X137.104 Y128.857 E.01155
G1 X138.014 Y130.189 E.03347
G2 X139.835 Y131.124 I2.28 J-2.2 E.04323
G1 X140.29 Y131.106 E.00945
G1 X140.746 Y130.785 E.01155
G1 X141.656 Y129.452 E.03347
G3 X143.477 Y128.517 I2.28 J2.2 E.04323
G1 X143.932 Y128.536 E.00945
G1 X144.387 Y128.857 E.01155
G1 X145.298 Y130.189 E.03347
G2 X147.118 Y131.124 I2.28 J-2.2 E.04323
G1 X147.574 Y131.106 E.00945
G1 X148.029 Y130.785 E.01155
G1 X148.939 Y129.452 E.03347
G3 X150.76 Y128.517 I2.28 J2.2 E.04323
G1 X151.215 Y128.536 E.00945
G3 X152.018 Y129.366 I-.71 J1.49 E.02446
G1 X152.018 Y127.388 E.04102
G1 X151.67 Y127.143 E.00882
G1 X150.76 Y125.811 E.03347
G2 X148.939 Y124.876 I-2.28 J2.2 E.04323
G1 X148.484 Y124.895 E.00945
G1 X148.029 Y125.215 E.01155
G1 X147.118 Y126.548 E.03347
G3 X145.298 Y127.483 I-2.28 J-2.2 E.04323
G1 X144.842 Y127.464 E.00945
G1 X144.387 Y127.143 E.01155
G1 X143.477 Y125.811 E.03347
G2 X141.656 Y124.876 I-2.28 J2.2 E.04323
G1 X141.201 Y124.895 E.00945
G1 X140.746 Y125.215 E.01155
G1 X139.835 Y126.548 E.03347
G3 X138.014 Y127.483 I-2.28 J-2.2 E.04323
G1 X137.559 Y127.464 E.00945
G1 X137.104 Y127.143 E.01155
G1 X136.194 Y125.811 E.03347
G2 X134.373 Y124.876 I-2.28 J2.2 E.04323
G1 X133.918 Y124.895 E.00945
G1 X133.463 Y125.215 E.01155
G1 X132.552 Y126.548 E.03347
G3 X130.731 Y127.483 I-2.28 J-2.2 E.04323
G1 X130.276 Y127.464 E.00945
G1 X129.821 Y127.143 E.01155
G1 X128.911 Y125.811 E.03347
G2 X127.09 Y124.876 I-2.28 J2.2 E.04323
G1 X126.635 Y124.895 E.00945
G1 X126.179 Y125.215 E.01155
G1 X125.269 Y126.548 E.03347
G3 X123.448 Y127.483 I-2.28 J-2.2 E.04323
G1 X122.993 Y127.464 E.00945
G1 X122.538 Y127.143 E.01155
G1 X121.627 Y125.811 E.03347
G2 X119.807 Y124.876 I-2.28 J2.2 E.04323
G1 X119.351 Y124.895 E.00945
G1 X118.896 Y125.215 E.01155
G1 X117.986 Y126.548 E.03347
G3 X116.165 Y127.483 I-2.28 J-2.2 E.04323
G1 X115.71 Y127.464 E.00945
G1 X115.255 Y127.143 E.01155
G1 X114.344 Y125.811 E.03347
G2 X112.524 Y124.876 I-2.28 J2.2 E.04323
G1 X112.068 Y124.895 E.00945
G1 X111.613 Y125.215 E.01155
G1 X110.703 Y126.548 E.03347
G3 X108.882 Y127.483 I-2.28 J-2.2 E.04323
G1 X108.427 Y127.464 E.00945
G1 X107.972 Y127.143 E.01155
G1 X107.061 Y125.811 E.03347
G2 X105.24 Y124.876 I-2.28 J2.2 E.04323
G1 X104.785 Y124.895 E.00945
G2 X103.982 Y125.725 I.71 J1.491 E.02447
G1 X103.982 Y124.028 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y125.725 E-.64486
G1 X104.153 Y125.474 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L52
M991 S0 P51 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.6 I-.173 J1.205 P1  F60000
G1 X152.381 Y132.381 Z6.6
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3407
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.582 Y132.018 Z6.72 F60000
G1 Z6.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X148.279 Y132.018 E.0352
G1 X148.484 Y131.927 E.00464
M73 P79 R2
G3 X148.948 Y132.018 I-.139 J1.946 E.00984
G1 X152.018 Y132.018 E.06367
G1 X152.018 Y129.18 E.05887
G1 X151.67 Y128.487 E.01607
G1 X151.215 Y128.286 E.01033
G2 X149.394 Y129.037 I.959 J4.908 E.04112
G2 X148.029 Y131.154 I4.672 J4.512 E.0526
G1 X147.574 Y131.356 E.01033
G3 X145.753 Y130.605 I.959 J-4.907 E.04112
G3 X144.387 Y128.487 I4.672 J-4.512 E.0526
G1 X143.932 Y128.286 E.01033
G2 X142.111 Y129.037 I.959 J4.907 E.04112
G2 X140.746 Y131.154 I4.672 J4.512 E.0526
G1 X140.29 Y131.356 E.01033
G3 X138.47 Y130.605 I.959 J-4.908 E.04112
G3 X137.104 Y128.487 I4.672 J-4.512 E.0526
G1 X136.649 Y128.286 E.01033
G2 X134.828 Y129.037 I.959 J4.907 E.04112
G2 X133.463 Y131.154 I4.672 J4.512 E.0526
G1 X133.007 Y131.356 E.01033
G3 X131.187 Y130.605 I.959 J-4.907 E.04112
G3 X129.821 Y128.487 I4.672 J-4.512 E.0526
G1 X129.366 Y128.286 E.01033
G2 X127.545 Y129.037 I.959 J4.908 E.04112
G2 X126.179 Y131.154 I4.672 J4.512 E.0526
G1 X125.724 Y131.356 E.01033
G3 X123.903 Y130.605 I.959 J-4.908 E.04112
G3 X122.538 Y128.487 I4.672 J-4.512 E.0526
G1 X122.083 Y128.286 E.01033
G2 X120.262 Y129.037 I.959 J4.908 E.04112
G2 X118.896 Y131.154 I4.672 J4.512 E.0526
G1 X118.441 Y131.356 E.01033
G3 X116.62 Y130.605 I.959 J-4.908 E.04112
G3 X115.255 Y128.487 I4.672 J-4.512 E.0526
G1 X114.799 Y128.286 E.01033
G2 X112.979 Y129.037 I.959 J4.908 E.04112
G2 X111.613 Y131.154 I4.672 J4.512 E.0526
G1 X111.158 Y131.356 E.01033
G3 X109.337 Y130.605 I.959 J-4.908 E.04112
G3 X107.972 Y128.487 I4.672 J-4.512 E.0526
G1 X107.516 Y128.286 E.01033
G2 X105.696 Y129.037 I.959 J4.908 E.04112
G2 X104.33 Y131.154 I4.672 J4.512 E.0526
G1 X103.982 Y131.308 E.00789
G1 X103.982 Y132.018 E.01472
G1 X104.581 Y132.018 E.01241
G1 X104.785 Y131.927 E.00464
G3 X105.25 Y132.018 I-.139 J1.946 E.00984
G1 X111.864 Y132.018 E.13719
G1 X112.068 Y131.927 E.00464
G3 X112.533 Y132.018 I-.139 J1.946 E.00984
G1 X119.147 Y132.018 E.13719
G1 X119.351 Y131.927 E.00464
G3 X119.816 Y132.018 I-.139 J1.946 E.00984
G1 X126.43 Y132.018 E.13719
G1 X126.635 Y131.927 E.00464
G3 X127.099 Y132.018 I-.139 J1.946 E.00984
G1 X133.713 Y132.018 E.13719
G1 X133.918 Y131.927 E.00464
G3 X134.382 Y132.018 I-.139 J1.946 E.00984
G1 X140.996 Y132.018 E.13719
G1 X141.201 Y131.927 E.00464
G3 X141.665 Y132.018 I-.139 J1.946 E.00984
G1 X143.362 Y132.018 E.0352
M204 S10000
G1 X108.998 Y123.982 F60000
G1 F9000
M204 S4000
G1 X110.695 Y123.982 E.0352
G2 X111.363 Y123.982 I.334 J-.824 E.0142
G1 X117.978 Y123.982 E.13722
G2 X118.646 Y123.982 I.334 J-.824 E.0142
G1 X125.261 Y123.982 E.13722
G2 X125.929 Y123.982 I.334 J-.824 E.0142
G1 X132.544 Y123.982 E.13722
G2 X133.212 Y123.982 I.334 J-.824 E.0142
G1 X139.828 Y123.982 E.13722
G2 X140.495 Y123.982 I.334 J-.824 E.0142
G1 X147.111 Y123.982 E.13722
G2 X147.778 Y123.982 I.334 J-.824 E.0142
G1 X152.018 Y123.982 E.08794
G1 X152.018 Y127.667 E.07643
G1 X151.67 Y127.513 E.00789
G2 X150.305 Y125.395 I-6.038 J2.395 E.0526
G2 X148.484 Y124.644 I-2.78 J4.157 E.04112
G1 X148.029 Y124.846 E.01033
G3 X146.663 Y126.963 I-6.038 J-2.394 E.0526
G3 X144.842 Y127.714 I-2.78 J-4.157 E.04112
G1 X144.387 Y127.513 E.01033
G2 X143.022 Y125.395 I-6.038 J2.395 E.0526
G2 X141.201 Y124.644 I-2.78 J4.157 E.04112
G1 X140.746 Y124.846 E.01033
G3 X139.38 Y126.963 I-6.038 J-2.394 E.0526
G3 X137.559 Y127.714 I-2.78 J-4.157 E.04112
G1 X137.104 Y127.513 E.01033
G2 X135.738 Y125.395 I-6.037 J2.394 E.0526
G2 X133.918 Y124.644 I-2.78 J4.157 E.04112
G1 X133.463 Y124.846 E.01033
G3 X132.097 Y126.963 I-6.038 J-2.394 E.0526
G3 X130.276 Y127.714 I-2.78 J-4.157 E.04112
G1 X129.821 Y127.513 E.01033
G2 X128.455 Y125.395 I-6.038 J2.395 E.0526
G2 X126.635 Y124.644 I-2.78 J4.157 E.04112
G1 X126.179 Y124.846 E.01033
G3 X124.814 Y126.963 I-6.037 J-2.394 E.0526
G3 X122.993 Y127.714 I-2.78 J-4.157 E.04112
G1 X122.538 Y127.513 E.01033
G2 X121.172 Y125.395 I-6.037 J2.394 E.0526
G2 X119.351 Y124.644 I-2.78 J4.156 E.04112
G1 X118.896 Y124.846 E.01033
G3 X117.531 Y126.963 I-6.038 J-2.394 E.0526
G3 X115.71 Y127.714 I-2.78 J-4.157 E.04112
G1 X115.255 Y127.513 E.01033
G2 X113.889 Y125.395 I-6.037 J2.394 E.0526
G2 X112.068 Y124.644 I-2.78 J4.157 E.04112
G1 X111.613 Y124.846 E.01033
G3 X110.248 Y126.963 I-6.037 J-2.394 E.0526
G3 X108.427 Y127.714 I-2.78 J-4.156 E.04112
G1 X107.972 Y127.513 E.01033
G2 X106.606 Y125.395 I-6.038 J2.394 E.0526
G2 X104.785 Y124.644 I-2.78 J4.157 E.04112
G1 X104.33 Y124.846 E.01033
G1 X103.982 Y125.539 E.01608
G1 X103.982 Y127.236 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X103.982 Y125.539 E-.64486
G1 X104.118 Y125.268 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L53
M991 S0 P52 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.72 I-.177 J1.204 P1  F60000
G1 X152.381 Y132.381 Z6.72
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3445
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.993 Y132.018 Z6.84 F60000
G1 Z6.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.296 Y132.018 E.0352
G1 X148.577 Y131.642 E.01683
G1 X148.349 Y131.186 E.01056
G3 X150.253 Y128.455 I3.337 J.297 E.07227
G1 X151.122 Y128 E.02036
G1 X151.35 Y127.545 E.01056
G2 X149.447 Y124.814 I-3.337 J.297 E.07227
G1 X148.577 Y124.358 E.02036
G1 X148.388 Y123.982 E.00873
G1 X150.085 Y123.982 E.0352
M204 S10000
G1 X145.972 Y132.018 F60000
G1 F9000
M204 S4000
G1 X147.669 Y132.018 E.0352
G1 X147.481 Y131.642 E.00873
G1 X146.611 Y131.186 E.02036
G3 X144.707 Y128.455 I1.433 J-3.028 E.07227
G1 X144.936 Y128 E.01056
G1 X145.805 Y127.545 E.02036
G2 X147.709 Y124.814 I-1.433 J-3.028 E.07227
G1 X147.481 Y124.358 E.01056
G1 X146.762 Y123.982 E.01683
G1 X141.105 Y123.982 E.11733
G1 X141.294 Y124.358 E.00873
G1 X142.163 Y124.814 E.02036
G3 X144.067 Y127.545 I-1.433 J3.028 E.07227
G1 X143.839 Y128 E.01056
G1 X142.969 Y128.455 E.02036
G2 X141.066 Y131.186 I1.433 J3.028 E.07227
G1 X141.294 Y131.642 E.01056
G1 X142.013 Y132.018 E.01683
G1 X143.71 Y132.018 E.0352
M204 S10000
G1 X138.689 Y132.018 F60000
G1 F9000
M204 S4000
G1 X140.386 Y132.018 E.0352
G1 X140.197 Y131.642 E.00873
G1 X139.328 Y131.186 E.02036
M73 P80 R2
G3 X137.424 Y128.455 I1.433 J-3.028 E.07227
G1 X137.652 Y128 E.01056
G1 X138.522 Y127.545 E.02036
G2 X140.426 Y124.814 I-1.433 J-3.028 E.07227
G1 X140.197 Y124.358 E.01056
G1 X139.478 Y123.982 E.01683
G1 X133.822 Y123.982 E.11733
G1 X134.011 Y124.358 E.00873
G1 X134.88 Y124.814 E.02036
G3 X136.784 Y127.545 I-1.433 J3.028 E.07227
G1 X136.556 Y128 E.01056
G1 X135.686 Y128.455 E.02036
G2 X133.783 Y131.186 I1.433 J3.028 E.07227
G1 X134.011 Y131.642 E.01056
G1 X134.73 Y132.018 E.01683
G1 X136.427 Y132.018 E.0352
M204 S10000
G1 X131.406 Y132.018 F60000
G1 F9000
M204 S4000
G1 X133.103 Y132.018 E.0352
G1 X132.914 Y131.642 E.00873
G1 X132.045 Y131.186 E.02036
G3 X130.141 Y128.455 I1.433 J-3.028 E.07227
G1 X130.369 Y128 E.01056
G1 X131.239 Y127.545 E.02036
G2 X133.142 Y124.814 I-1.433 J-3.028 E.07227
G1 X132.914 Y124.358 E.01056
G1 X132.195 Y123.982 E.01683
G1 X126.539 Y123.982 E.11733
G1 X126.728 Y124.358 E.00873
G1 X127.597 Y124.814 E.02036
G3 X129.501 Y127.545 I-1.433 J3.028 E.07227
G1 X129.273 Y128 E.01056
G1 X128.403 Y128.455 E.02036
G2 X126.499 Y131.186 I1.433 J3.028 E.07227
G1 X126.728 Y131.642 E.01056
G1 X127.446 Y132.018 E.01683
G1 X129.143 Y132.018 E.0352
M204 S10000
G1 X124.123 Y132.018 F60000
G1 F9000
M204 S4000
G1 X125.82 Y132.018 E.0352
G1 X125.631 Y131.642 E.00873
G1 X124.762 Y131.186 E.02036
G3 X122.858 Y128.455 I1.433 J-3.028 E.07227
G1 X123.086 Y128 E.01056
G1 X123.956 Y127.545 E.02036
G2 X125.859 Y124.814 I-1.433 J-3.028 E.07227
G1 X125.631 Y124.358 E.01056
G1 X124.912 Y123.982 E.01683
G1 X119.256 Y123.982 E.11733
G1 X119.445 Y124.358 E.00873
G1 X120.314 Y124.814 E.02036
G3 X122.218 Y127.545 I-1.433 J3.028 E.07227
G1 X121.99 Y128 E.01056
G1 X121.12 Y128.455 E.02036
G2 X119.216 Y131.186 I1.433 J3.028 E.07227
G1 X119.445 Y131.642 E.01056
G1 X120.163 Y132.018 E.01683
G1 X121.86 Y132.018 E.0352
M204 S10000
G1 X116.84 Y132.018 F60000
G1 F9000
M204 S4000
G1 X118.537 Y132.018 E.0352
G1 X118.348 Y131.642 E.00873
G1 X117.479 Y131.186 E.02036
G3 X115.575 Y128.455 I1.433 J-3.028 E.07227
G1 X115.803 Y128 E.01056
G1 X116.672 Y127.545 E.02036
G2 X118.576 Y124.814 I-1.433 J-3.028 E.07227
G1 X118.348 Y124.358 E.01056
G1 X117.629 Y123.982 E.01683
G1 X111.973 Y123.982 E.11733
G1 X112.161 Y124.358 E.00873
G1 X113.031 Y124.814 E.02036
G3 X114.935 Y127.545 I-1.433 J3.028 E.07227
G1 X114.706 Y128 E.01056
G1 X113.837 Y128.455 E.02036
G2 X111.933 Y131.186 I1.433 J3.028 E.07227
G1 X112.161 Y131.642 E.01056
G1 X112.88 Y132.018 E.01683
G1 X114.577 Y132.018 E.0352
M204 S10000
G1 X109.557 Y132.018 F60000
G1 F9000
M204 S4000
G1 X111.253 Y132.018 E.0352
G1 X111.065 Y131.642 E.00873
G1 X110.195 Y131.186 E.02036
G3 X108.292 Y128.455 I1.433 J-3.028 E.07227
G1 X108.52 Y128 E.01056
G1 X109.389 Y127.545 E.02036
G2 X111.293 Y124.814 I-1.433 J-3.028 E.07227
G1 X111.065 Y124.358 E.01056
G1 X110.346 Y123.982 E.01683
G1 X104.69 Y123.982 E.11733
G1 X104.878 Y124.358 E.00873
G1 X105.748 Y124.814 E.02036
G3 X107.651 Y127.545 I-1.433 J3.028 E.07227
G1 X107.423 Y128 E.01056
G1 X106.554 Y128.455 E.02036
G2 X104.65 Y131.186 I1.433 J3.028 E.07227
G1 X104.878 Y131.642 E.01056
G1 X105.597 Y132.018 E.01683
G1 X107.294 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.597 Y132.018 E-.64486
G1 X105.329 Y131.877 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L54
M991 S0 P53 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.84 I-.013 J1.217 P1  F60000
G1 X152.381 Y132.381 Z6.84
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3475
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.345 Y123.982 Z6.96 F60000
G1 Z6.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X148.648 Y123.982 E.0352
G1 X148.918 Y124.358 E.00962
G1 X150.224 Y125.269 E.03301
G3 X151.137 Y127.09 I-2.189 J2.237 E.04303
G1 X151.108 Y127.545 E.00946
G1 X150.781 Y128 E.01163
G1 X149.475 Y128.91 E.03301
G2 X148.562 Y130.731 I2.189 J2.237 E.04303
G1 X148.591 Y131.186 E.00946
G2 X149.458 Y132.018 I1.615 J-.817 E.0254
G1 X147.41 Y132.018 E.04248
G1 X147.139 Y131.642 E.00961
G1 X145.834 Y130.731 E.03301
G3 X144.921 Y128.91 I2.189 J-2.237 E.04303
G1 X144.949 Y128.455 E.00946
G1 X145.277 Y128 E.01163
G1 X146.582 Y127.09 E.03301
G2 X147.495 Y125.269 I-2.189 J-2.237 E.04303
G1 X147.467 Y124.814 E.00946
G2 X146.6 Y123.982 I-1.615 J.817 E.0254
G1 X141.364 Y123.982 E.10859
G1 X141.635 Y124.358 E.00962
G1 X142.941 Y125.269 E.03301
G3 X143.854 Y127.09 I-2.189 J2.237 E.04303
G1 X143.825 Y127.545 E.00946
G1 X143.498 Y128 E.01163
G1 X142.192 Y128.91 E.03301
G2 X141.279 Y130.731 I2.189 J2.237 E.04303
G1 X141.308 Y131.186 E.00946
G2 X142.175 Y132.018 I1.615 J-.817 E.0254
G1 X140.127 Y132.018 E.04248
G1 X139.856 Y131.642 E.00961
G1 X138.551 Y130.731 E.03301
G3 X137.638 Y128.91 I2.189 J-2.237 E.04303
G1 X137.666 Y128.455 E.00946
G1 X137.994 Y128 E.01163
G1 X139.299 Y127.09 E.03301
G2 X140.212 Y125.269 I-2.189 J-2.237 E.04303
G1 X140.184 Y124.814 E.00946
G2 X139.316 Y123.982 I-1.615 J.817 E.0254
G1 X134.081 Y123.982 E.10859
G1 X134.352 Y124.358 E.00962
G1 X135.658 Y125.269 E.03301
G3 X136.571 Y127.09 I-2.189 J2.237 E.04303
G1 X136.542 Y127.545 E.00946
G1 X136.215 Y128 E.01163
G1 X134.909 Y128.91 E.03301
G2 X133.996 Y130.731 I2.189 J2.237 E.04303
G1 X134.025 Y131.186 E.00946
G2 X134.892 Y132.018 I1.615 J-.817 E.0254
G1 X132.844 Y132.018 E.04248
G1 X132.573 Y131.642 E.00961
G1 X131.268 Y130.731 E.03301
G3 X130.354 Y128.91 I2.189 J-2.237 E.04303
G1 X130.383 Y128.455 E.00946
G1 X130.71 Y128 E.01163
G1 X132.016 Y127.09 E.03301
G2 X132.929 Y125.269 I-2.189 J-2.237 E.04303
G1 X132.9 Y124.814 E.00946
G2 X132.033 Y123.982 I-1.615 J.817 E.0254
G1 X126.798 Y123.982 E.10859
G1 X127.069 Y124.358 E.00962
G1 X128.374 Y125.269 E.03301
G3 X129.287 Y127.09 I-2.189 J2.237 E.04303
G1 X129.259 Y127.545 E.00946
G1 X128.931 Y128 E.01163
G1 X127.626 Y128.91 E.03301
G2 X126.713 Y130.731 I2.189 J2.237 E.04303
G1 X126.741 Y131.186 E.00946
G2 X127.609 Y132.018 I1.615 J-.817 E.0254
G1 X125.561 Y132.018 E.04248
G1 X125.29 Y131.642 E.00961
G1 X123.984 Y130.731 E.03301
G3 X123.071 Y128.91 I2.189 J-2.237 E.04303
G1 X123.1 Y128.455 E.00946
G1 X123.427 Y128 E.01163
G1 X124.733 Y127.09 E.03301
G2 X125.646 Y125.269 I-2.189 J-2.237 E.04303
G1 X125.617 Y124.814 E.00946
G2 X124.75 Y123.982 I-1.615 J.817 E.0254
G1 X119.515 Y123.982 E.10859
G1 X119.786 Y124.358 E.00962
G1 X121.091 Y125.269 E.03301
G3 X122.004 Y127.09 I-2.189 J2.237 E.04303
G1 X121.976 Y127.545 E.00946
G1 X121.648 Y128 E.01163
G1 X120.343 Y128.91 E.03301
G2 X119.43 Y130.731 I2.189 J2.237 E.04303
G1 X119.458 Y131.186 E.00946
M73 P81 R2
G2 X120.325 Y132.018 I1.615 J-.817 E.0254
G1 X118.277 Y132.018 E.04248
G1 X118.007 Y131.642 E.00961
G1 X116.701 Y130.731 E.03301
G3 X115.788 Y128.91 I2.189 J-2.237 E.04303
G1 X115.817 Y128.455 E.00946
G1 X116.144 Y128 E.01163
G1 X117.45 Y127.09 E.03301
G2 X118.363 Y125.269 I-2.189 J-2.237 E.04303
G1 X118.334 Y124.814 E.00946
G2 X117.467 Y123.982 I-1.615 J.817 E.0254
G1 X112.232 Y123.982 E.10859
G1 X112.503 Y124.358 E.00962
G1 X113.808 Y125.269 E.03301
G3 X114.721 Y127.09 I-2.189 J2.237 E.04303
G1 X114.693 Y127.545 E.00946
G1 X114.365 Y128 E.01163
G1 X113.06 Y128.91 E.03301
G2 X112.147 Y130.731 I2.189 J2.237 E.04303
G1 X112.175 Y131.186 E.00946
G2 X113.042 Y132.018 I1.615 J-.817 E.0254
G1 X110.994 Y132.018 E.04248
G1 X110.724 Y131.642 E.00962
G1 X109.418 Y130.731 E.03301
G3 X108.505 Y128.91 I2.189 J-2.237 E.04303
G1 X108.534 Y128.455 E.00946
G1 X108.861 Y128 E.01163
G1 X110.167 Y127.09 E.03301
G2 X111.08 Y125.269 I-2.189 J-2.237 E.04303
G1 X111.051 Y124.814 E.00946
G2 X110.184 Y123.982 I-1.616 J.817 E.0254
G1 X104.949 Y123.982 E.10859
G1 X105.219 Y124.358 E.00962
G1 X106.525 Y125.269 E.03301
G3 X107.438 Y127.09 I-2.189 J2.237 E.04303
G1 X107.409 Y127.545 E.00946
G1 X107.082 Y128 E.01163
G1 X105.777 Y128.91 E.03301
G2 X104.864 Y130.731 I2.189 J2.237 E.04303
G1 X104.892 Y131.186 E.00946
G2 X105.759 Y132.018 I1.615 J-.817 E.0254
G1 X104.062 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.759 Y132.018 E-.64486
G1 X105.511 Y131.845 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L55
M991 S0 P54 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.96 I-.014 J1.217 P1  F60000
G1 X152.381 Y132.381 Z6.96
G1 Z6.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3500
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.541 Y123.982 Z7.08 F60000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X148.844 Y123.982 E.0352
G1 X149.142 Y124.358 E.00996
G1 X150.272 Y125.269 E.03009
G3 X151.013 Y127.09 I-2.116 J1.922 E.04162
G3 X150.557 Y128 I-1.139 J-.001 E.02189
G1 X149.427 Y128.91 E.03009
G2 X148.687 Y130.731 I2.116 J1.922 E.04162
G1 X148.782 Y131.186 E.00965
G2 X149.609 Y132.018 I2.248 J-1.41 E.02453
G1 X147.213 Y132.018 E.0497
G1 X146.915 Y131.642 E.00996
G1 X145.786 Y130.731 E.03009
G3 X145.045 Y128.91 I2.116 J-1.922 E.04162
G3 X145.501 Y128 I1.139 J.001 E.02189
G1 X146.63 Y127.09 E.03009
G2 X147.371 Y125.269 I-2.116 J-1.922 E.04162
G1 X147.276 Y124.814 E.00965
G2 X146.448 Y123.982 I-2.249 J1.41 E.02453
G1 X141.561 Y123.982 E.10137
G1 X141.859 Y124.358 E.00996
G1 X142.989 Y125.269 E.03009
G3 X143.729 Y127.09 I-2.116 J1.922 E.04162
G3 X143.274 Y128 I-1.139 J-.001 E.02189
G1 X142.144 Y128.91 E.03009
G2 X141.403 Y130.731 I2.116 J1.922 E.04162
G1 X141.499 Y131.186 E.00965
G2 X142.326 Y132.018 I2.248 J-1.41 E.02453
G1 X139.93 Y132.018 E.0497
G1 X139.632 Y131.642 E.00995
G1 X138.503 Y130.731 E.03009
G3 X137.762 Y128.91 I2.116 J-1.922 E.04162
G3 X138.218 Y128 I1.139 J.001 E.02189
G1 X139.347 Y127.09 E.03009
G2 X140.088 Y125.269 I-2.116 J-1.922 E.04162
G1 X139.992 Y124.814 E.00965
G2 X139.165 Y123.982 I-2.249 J1.41 E.02453
G1 X134.278 Y123.982 E.10137
G1 X134.576 Y124.358 E.00996
G1 X135.706 Y125.269 E.03009
G3 X136.446 Y127.09 I-2.116 J1.922 E.04162
G3 X135.991 Y128 I-1.139 J-.001 E.02189
G1 X134.861 Y128.91 E.03009
G2 X134.12 Y130.731 I2.116 J1.922 E.04162
G1 X134.216 Y131.186 E.00965
G2 X135.043 Y132.018 I2.248 J-1.41 E.02453
G1 X132.647 Y132.018 E.0497
G1 X132.349 Y131.642 E.00996
G1 X131.219 Y130.731 E.03009
G3 X130.479 Y128.91 I2.116 J-1.922 E.04162
G3 X130.934 Y128 I1.139 J.001 E.02189
G1 X132.064 Y127.09 E.03009
G2 X132.805 Y125.269 I-2.116 J-1.922 E.04162
G1 X132.709 Y124.814 E.00965
G2 X131.882 Y123.982 I-2.249 J1.41 E.02453
G1 X126.995 Y123.982 E.10137
G1 X127.293 Y124.358 E.00996
G1 X128.422 Y125.269 E.03009
G3 X129.163 Y127.09 I-2.116 J1.922 E.04162
G3 X128.707 Y128 I-1.139 J-.001 E.02189
G1 X127.578 Y128.91 E.03009
G2 X126.837 Y130.731 I2.116 J1.922 E.04162
G1 X126.933 Y131.186 E.00965
G2 X127.76 Y132.018 I2.248 J-1.41 E.02453
G1 X125.364 Y132.018 E.0497
G1 X125.066 Y131.642 E.00995
G1 X123.936 Y130.731 E.03009
G3 X123.196 Y128.91 I2.116 J-1.922 E.04162
G3 X123.651 Y128 I1.139 J.001 E.02189
G1 X124.781 Y127.09 E.03009
G2 X125.522 Y125.269 I-2.116 J-1.922 E.04162
G1 X125.426 Y124.814 E.00965
G2 X124.599 Y123.982 I-2.249 J1.41 E.02453
G1 X119.712 Y123.982 E.10137
G1 X120.01 Y124.358 E.00996
G1 X121.139 Y125.269 E.03009
G3 X121.88 Y127.09 I-2.116 J1.922 E.04162
G3 X121.424 Y128 I-1.139 J-.001 E.02189
G1 X120.295 Y128.91 E.03009
G2 X119.554 Y130.731 I2.116 J1.922 E.04162
G1 X119.649 Y131.186 E.00965
G2 X120.477 Y132.018 I2.248 J-1.41 E.02453
G1 X118.081 Y132.018 E.0497
G1 X117.783 Y131.642 E.00996
G1 X116.653 Y130.731 E.03009
G3 X115.913 Y128.91 I2.116 J-1.922 E.04162
G3 X116.368 Y128 I1.139 J.001 E.02189
G1 X117.498 Y127.09 E.03009
G2 X118.238 Y125.269 I-2.116 J-1.922 E.04162
G1 X118.143 Y124.814 E.00965
G2 X117.316 Y123.982 I-2.249 J1.41 E.02453
G1 X112.429 Y123.982 E.10137
G1 X112.727 Y124.358 E.00996
G1 X113.856 Y125.269 E.03009
G3 X114.597 Y127.09 I-2.116 J1.922 E.04162
G3 X114.141 Y128 I-1.14 J-.001 E.02189
G1 X113.012 Y128.91 E.03009
G2 X112.271 Y130.731 I2.116 J1.922 E.04162
G1 X112.366 Y131.186 E.00965
G2 X113.194 Y132.018 I2.248 J-1.41 E.02453
G1 X110.797 Y132.018 E.0497
G1 X110.5 Y131.642 E.00996
G1 X109.37 Y130.731 E.03009
G3 X108.629 Y128.91 I2.116 J-1.922 E.04162
G3 X109.085 Y128 I1.139 J.001 E.02189
G1 X110.215 Y127.09 E.03009
G2 X110.955 Y125.269 I-2.116 J-1.922 E.04162
G1 X110.86 Y124.814 E.00965
G2 X110.033 Y123.982 I-2.249 J1.41 E.02453
G1 X105.146 Y123.982 E.10137
G1 X105.444 Y124.358 E.00996
G1 X106.573 Y125.269 E.03009
G3 X107.314 Y127.09 I-2.116 J1.922 E.04162
G3 X106.858 Y128 I-1.139 J-.001 E.02189
G1 X105.728 Y128.91 E.03009
G2 X104.988 Y130.731 I2.116 J1.922 E.04162
G1 X105.083 Y131.186 E.00965
G2 X105.91 Y132.018 I2.248 J-1.41 E.02453
G1 X104.213 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.91 Y132.018 E-.64486
G1 X105.674 Y131.828 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L56
M991 S0 P55 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.08 I-.014 J1.217 P1  F60000
G1 X152.381 Y132.381 Z7.08
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3521
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
M73 P82 R2
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.704 Y123.982 Z7.2 F60000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.007 Y123.982 E.0352
G2 X150.322 Y125.269 I5.102 J-3.901 E.03831
G3 X150.757 Y127.545 I-1.733 J1.511 E.05037
G3 X149.377 Y128.91 I-5.406 J-4.086 E.04042
G2 X148.942 Y131.186 I1.733 J1.511 E.05037
G2 X149.733 Y132.018 I3.267 J-2.318 E.02389
G1 X147.051 Y132.018 E.05564
G2 X145.735 Y130.731 I-5.102 J3.901 E.0383
G3 X145.3 Y128.455 I1.733 J-1.511 E.05037
G3 X146.681 Y127.09 I5.407 J4.086 E.04042
G2 X147.116 Y124.814 I-1.733 J-1.511 E.05037
G2 X146.324 Y123.982 I-3.268 J2.318 E.0239
G1 X141.724 Y123.982 E.09543
G2 X143.039 Y125.269 I5.102 J-3.901 E.03831
G3 X143.474 Y127.545 I-1.733 J1.511 E.05037
G3 X142.094 Y128.91 I-5.407 J-4.086 E.04042
G2 X141.659 Y131.186 I1.733 J1.511 E.05037
G2 X142.45 Y132.018 I3.267 J-2.318 E.02389
G1 X139.768 Y132.018 E.05564
G2 X138.452 Y130.731 I-5.102 J3.901 E.0383
G3 X138.017 Y128.455 I1.733 J-1.511 E.05037
G3 X139.398 Y127.09 I5.407 J4.086 E.04042
G2 X139.833 Y124.814 I-1.733 J-1.511 E.05037
G2 X139.041 Y123.982 I-3.268 J2.318 E.0239
G1 X134.441 Y123.982 E.09543
G2 X135.756 Y125.269 I5.102 J-3.901 E.03831
G3 X136.191 Y127.545 I-1.733 J1.511 E.05037
G3 X134.81 Y128.91 I-5.407 J-4.086 E.04042
G2 X134.375 Y131.186 I1.733 J1.511 E.05037
G2 X135.167 Y132.018 I3.267 J-2.318 E.02389
G1 X132.484 Y132.018 E.05564
G2 X131.169 Y130.731 I-5.102 J3.901 E.0383
G3 X130.734 Y128.455 I1.733 J-1.511 E.05037
G3 X132.115 Y127.09 I5.407 J4.086 E.04042
G2 X132.55 Y124.814 I-1.733 J-1.511 E.05037
G2 X131.758 Y123.982 I-3.268 J2.318 E.0239
G1 X127.157 Y123.982 E.09543
G2 X128.473 Y125.269 I5.102 J-3.901 E.03831
G3 X128.908 Y127.545 I-1.733 J1.511 E.05037
G3 X127.527 Y128.91 I-5.407 J-4.086 E.04042
G2 X127.092 Y131.186 I1.733 J1.511 E.05037
G2 X127.884 Y132.018 I3.267 J-2.318 E.02389
G1 X125.201 Y132.018 E.05564
G2 X123.886 Y130.731 I-5.102 J3.901 E.0383
G3 X123.451 Y128.455 I1.733 J-1.511 E.05037
G3 X124.832 Y127.09 I5.407 J4.086 E.04042
G2 X125.267 Y124.814 I-1.733 J-1.511 E.05037
G2 X124.475 Y123.982 I-3.268 J2.318 E.0239
G1 X119.874 Y123.982 E.09543
G2 X121.19 Y125.269 I5.102 J-3.901 E.03831
G3 X121.625 Y127.545 I-1.733 J1.511 E.05037
G3 X120.244 Y128.91 I-5.407 J-4.086 E.04042
G2 X119.809 Y131.186 I1.733 J1.511 E.05037
G2 X120.601 Y132.018 I3.267 J-2.318 E.02389
G1 X117.918 Y132.018 E.05564
G2 X116.603 Y130.731 I-5.102 J3.901 E.0383
G3 X116.168 Y128.455 I1.733 J-1.511 E.05037
G3 X117.548 Y127.09 I5.407 J4.086 E.04042
G2 X117.983 Y124.814 I-1.733 J-1.511 E.05037
G2 X117.192 Y123.982 I-3.268 J2.318 E.0239
G1 X112.591 Y123.982 E.09543
G2 X113.907 Y125.269 I5.102 J-3.901 E.03831
G3 X114.342 Y127.545 I-1.733 J1.511 E.05037
G3 X112.961 Y128.91 I-5.407 J-4.086 E.04042
G2 X112.526 Y131.186 I1.733 J1.511 E.05037
G2 X113.317 Y132.018 I3.267 J-2.318 E.02389
G1 X110.635 Y132.018 E.05564
G2 X109.319 Y130.731 I-5.102 J3.901 E.0383
G3 X108.884 Y128.455 I1.733 J-1.511 E.05037
G3 X110.265 Y127.09 I5.407 J4.086 E.04042
G2 X110.7 Y124.814 I-1.733 J-1.511 E.05037
G2 X109.909 Y123.982 I-3.268 J2.318 E.0239
G1 X105.308 Y123.982 E.09543
G2 X106.624 Y125.269 I5.102 J-3.901 E.03831
G3 X107.059 Y127.545 I-1.733 J1.511 E.05037
G3 X105.678 Y128.91 I-5.407 J-4.086 E.04042
G2 X105.243 Y131.186 I1.733 J1.511 E.05037
G2 X106.034 Y132.018 I3.267 J-2.318 E.02389
G1 X104.337 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.034 Y132.018 E-.64486
G1 X105.81 Y131.814 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L57
M991 S0 P56 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.2 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z7.2
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3537
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.844 Y123.982 Z7.32 F60000
G1 Z6.92
M73 P83 R2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.147 Y123.982 E.0352
G2 X149.967 Y124.814 I3.662 J-2.79 E.02428
G3 X150.805 Y127.09 I-1.655 J1.902 E.05248
G3 X149.732 Y128.455 I-2.86 J-1.142 E.03651
G2 X148.894 Y130.731 I1.655 J1.902 E.05248
G2 X149.88 Y132.018 I2.726 J-1.068 E.03407
G1 X146.91 Y132.018 E.0616
G2 X146.091 Y131.186 I-3.662 J2.789 E.02428
G3 X145.253 Y128.91 I1.655 J-1.902 E.05248
G3 X146.325 Y127.545 I2.86 J1.142 E.03651
G2 X147.163 Y125.269 I-1.655 J-1.902 E.05248
G2 X146.177 Y123.982 I-2.726 J1.068 E.03407
G1 X141.864 Y123.982 E.08947
G2 X142.684 Y124.814 I3.662 J-2.79 E.02428
G3 X143.522 Y127.09 I-1.655 J1.902 E.05248
G3 X142.449 Y128.455 I-2.86 J-1.142 E.03651
G2 X141.611 Y130.731 I1.655 J1.902 E.05248
G2 X142.597 Y132.018 I2.726 J-1.068 E.03407
G1 X139.627 Y132.018 E.0616
G2 X138.808 Y131.186 I-3.662 J2.79 E.02428
G3 X137.97 Y128.91 I1.655 J-1.902 E.05248
G3 X139.042 Y127.545 I2.86 J1.142 E.03651
G2 X139.88 Y125.269 I-1.655 J-1.902 E.05248
G2 X138.894 Y123.982 I-2.726 J1.068 E.03407
G1 X134.581 Y123.982 E.08947
G2 X135.4 Y124.814 I3.662 J-2.79 E.02428
G3 X136.239 Y127.09 I-1.655 J1.902 E.05248
G3 X135.166 Y128.455 I-2.86 J-1.142 E.03651
G2 X134.328 Y130.731 I1.655 J1.902 E.05248
G2 X135.314 Y132.018 I2.726 J-1.068 E.03407
G1 X132.344 Y132.018 E.0616
G2 X131.525 Y131.186 I-3.662 J2.789 E.02428
G3 X130.687 Y128.91 I1.655 J-1.902 E.05248
G3 X131.759 Y127.545 I2.86 J1.142 E.03651
G2 X132.597 Y125.269 I-1.655 J-1.902 E.05248
G2 X131.611 Y123.982 I-2.726 J1.068 E.03407
G1 X127.298 Y123.982 E.08947
G2 X128.117 Y124.814 I3.662 J-2.79 E.02428
G3 X128.955 Y127.09 I-1.655 J1.902 E.05248
G3 X127.883 Y128.455 I-2.86 J-1.142 E.03651
G2 X127.045 Y130.731 I1.655 J1.902 E.05248
G2 X128.031 Y132.018 I2.726 J-1.068 E.03407
G1 X125.061 Y132.018 E.0616
G2 X124.241 Y131.186 I-3.662 J2.79 E.02428
G3 X123.403 Y128.91 I1.655 J-1.902 E.05248
G3 X124.476 Y127.545 I2.86 J1.142 E.03651
G2 X125.314 Y125.269 I-1.655 J-1.902 E.05248
G2 X124.328 Y123.982 I-2.726 J1.068 E.03407
G1 X120.015 Y123.982 E.08947
G2 X120.834 Y124.814 I3.662 J-2.79 E.02428
G3 X121.672 Y127.09 I-1.655 J1.902 E.05248
G3 X120.6 Y128.455 I-2.86 J-1.142 E.03651
G2 X119.762 Y130.731 I1.655 J1.902 E.05248
G2 X120.748 Y132.018 I2.726 J-1.068 E.03407
G1 X117.778 Y132.018 E.0616
G2 X116.958 Y131.186 I-3.662 J2.789 E.02428
G3 X116.12 Y128.91 I1.655 J-1.902 E.05248
G3 X117.193 Y127.545 I2.86 J1.142 E.03651
G2 X118.031 Y125.269 I-1.655 J-1.902 E.05248
G2 X117.045 Y123.982 I-2.726 J1.068 E.03407
G1 X112.731 Y123.982 E.08947
G2 X113.551 Y124.814 I3.662 J-2.79 E.02428
G3 X114.389 Y127.09 I-1.655 J1.902 E.05248
G3 X113.317 Y128.455 I-2.86 J-1.142 E.03651
G2 X112.479 Y130.731 I1.655 J1.902 E.05248
G2 X113.465 Y132.018 I2.726 J-1.068 E.03407
G1 X110.495 Y132.018 E.0616
G2 X109.675 Y131.186 I-3.661 J2.789 E.02428
G3 X108.837 Y128.91 I1.655 J-1.902 E.05248
G3 X109.91 Y127.545 I2.86 J1.142 E.03651
G2 X110.748 Y125.269 I-1.655 J-1.902 E.05248
G2 X109.762 Y123.982 I-2.726 J1.068 E.03407
G1 X105.448 Y123.982 E.08947
G2 X106.268 Y124.814 I3.662 J-2.79 E.02428
G3 X107.106 Y127.09 I-1.655 J1.902 E.05248
G3 X106.034 Y128.455 I-2.86 J-1.142 E.03651
G2 X105.196 Y130.731 I1.655 J1.902 E.05248
G2 X106.181 Y132.018 I2.726 J-1.068 E.03407
G1 X104.484 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.181 Y132.018 E-.64486
G1 X105.971 Y131.8 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L58
M991 S0 P57 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.32 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z7.32
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3551
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.97 Y123.982 Z7.44 F60000
G1 Z7.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.273 Y123.982 E.0352
G2 X150.068 Y124.814 I5.502 J-4.469 E.0239
G3 X150.717 Y127.09 I-1.683 J1.71 E.05134
G3 X149.631 Y128.455 I-3.577 J-1.73 E.03649
G2 X148.982 Y130.731 I1.682 J1.71 E.05134
G2 X149.987 Y132.018 I3.407 J-1.626 E.03414
G1 X146.785 Y132.018 E.06642
G2 X145.989 Y131.186 I-5.502 J4.469 E.0239
G3 X145.341 Y128.91 I1.682 J-1.71 E.05134
G3 X146.427 Y127.545 I3.576 J1.73 E.03649
G2 X147.075 Y125.269 I-1.682 J-1.71 E.05134
G2 X146.07 Y123.982 I-3.408 J1.626 E.03414
G1 X141.989 Y123.982 E.08465
G2 X142.785 Y124.814 I5.503 J-4.47 E.0239
G3 X143.434 Y127.09 I-1.682 J1.71 E.05134
G3 X142.348 Y128.455 I-3.577 J-1.73 E.03649
G2 X141.699 Y130.731 I1.682 J1.71 E.05134
G2 X142.704 Y132.018 I3.407 J-1.626 E.03414
G1 X139.502 Y132.018 E.06642
G2 X138.706 Y131.186 I-5.503 J4.47 E.0239
G3 X138.058 Y128.91 I1.682 J-1.71 E.05134
G3 X139.144 Y127.545 I3.577 J1.73 E.03649
G2 X139.792 Y125.269 I-1.682 J-1.71 E.05134
G2 X138.787 Y123.982 I-3.408 J1.626 E.03414
G1 X134.706 Y123.982 E.08465
G2 X135.502 Y124.814 I5.502 J-4.469 E.0239
G3 X136.151 Y127.09 I-1.683 J1.71 E.05134
G3 X135.065 Y128.455 I-3.577 J-1.73 E.03649
G2 X134.416 Y130.731 I1.682 J1.71 E.05134
G2 X135.421 Y132.018 I3.407 J-1.626 E.03414
G1 X132.219 Y132.018 E.06642
G2 X131.423 Y131.186 I-5.502 J4.469 E.0239
G3 X130.774 Y128.91 I1.682 J-1.71 E.05134
G3 X131.861 Y127.545 I3.577 J1.73 E.03649
G2 X132.509 Y125.269 I-1.682 J-1.71 E.05134
G2 X131.504 Y123.982 I-3.408 J1.626 E.03414
G1 X127.423 Y123.982 E.08465
G2 X128.219 Y124.814 I5.503 J-4.47 E.0239
G3 X128.868 Y127.09 I-1.682 J1.71 E.05134
G3 X127.781 Y128.455 I-3.577 J-1.73 E.03649
G2 X127.133 Y130.731 I1.682 J1.71 E.05134
G2 X128.138 Y132.018 I3.408 J-1.626 E.03414
G1 X124.936 Y132.018 E.06642
G2 X124.14 Y131.186 I-5.503 J4.47 E.0239
G3 X123.491 Y128.91 I1.682 J-1.71 E.05134
G3 X124.577 Y127.545 I3.577 J1.73 E.03649
G2 X125.226 Y125.269 I-1.682 J-1.71 E.05134
G2 X124.221 Y123.982 I-3.408 J1.626 E.03414
G1 X120.14 Y123.982 E.08465
G2 X120.936 Y124.814 I5.502 J-4.469 E.0239
G3 X121.584 Y127.09 I-1.682 J1.71 E.05134
G3 X120.498 Y128.455 I-3.577 J-1.73 E.03649
G2 X119.85 Y130.731 I1.682 J1.71 E.05134
G2 X120.855 Y132.018 I3.408 J-1.626 E.03414
G1 X117.652 Y132.018 E.06642
G2 X116.857 Y131.186 I-5.502 J4.469 E.0239
G3 X116.208 Y128.91 I1.683 J-1.71 E.05134
G3 X117.294 Y127.545 I3.577 J1.73 E.03649
G2 X117.943 Y125.269 I-1.682 J-1.71 E.05134
G2 X116.938 Y123.982 I-3.407 J1.626 E.03414
M73 P84 R2
G1 X112.857 Y123.982 E.08465
G2 X113.653 Y124.814 I5.503 J-4.47 E.0239
G3 X114.301 Y127.09 I-1.682 J1.71 E.05134
G3 X113.215 Y128.455 I-3.577 J-1.73 E.03649
G2 X112.567 Y130.731 I1.682 J1.71 E.05134
G2 X113.572 Y132.018 I3.408 J-1.626 E.03414
G1 X110.369 Y132.018 E.06642
G2 X109.574 Y131.186 I-5.503 J4.47 E.0239
G3 X108.925 Y128.91 I1.682 J-1.71 E.05134
G3 X110.011 Y127.545 I3.577 J1.73 E.03649
G2 X110.66 Y125.269 I-1.682 J-1.71 E.05134
G2 X109.654 Y123.982 I-3.408 J1.626 E.03414
G1 X105.574 Y123.982 E.08465
G2 X106.37 Y124.814 I5.502 J-4.469 E.0239
G3 X107.018 Y127.09 I-1.682 J1.71 E.05134
G3 X105.932 Y128.455 I-3.576 J-1.73 E.03649
G2 X105.283 Y130.731 I1.682 J1.71 E.05134
G2 X106.289 Y132.018 I3.408 J-1.626 E.03414
G1 X104.592 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.289 Y132.018 E-.64486
G1 X106.081 Y131.797 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L59
M991 S0 P58 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.44 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z7.44
G1 Z7.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3561
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.085 Y123.982 Z7.56 F60000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X149.388 Y123.982 E.0352
G2 X150.169 Y124.814 I10.752 J-9.315 E.02367
G3 X149.973 Y128 I-1.61 J1.501 E.07409
G2 X149.062 Y130.731 I1.444 J2 E.06377
G2 X150.092 Y132.018 I4.389 J-2.458 E.03434
G1 X146.67 Y132.018 E.07098
G2 X145.889 Y131.186 I-10.749 J9.312 E.02367
G3 X146.084 Y128 I1.61 J-1.501 E.07409
G2 X146.996 Y125.269 I-1.444 J-2 E.06377
G2 X145.966 Y123.982 I-4.389 J2.458 E.03435
G1 X142.105 Y123.982 E.08009
G2 X142.886 Y124.814 I10.756 J-9.319 E.02367
G3 X142.69 Y128 I-1.61 J1.501 E.07408
G2 X141.779 Y130.731 I1.444 J2 E.06377
G2 X142.809 Y132.018 I4.389 J-2.458 E.03434
G1 X139.387 Y132.018 E.07098
G2 X138.606 Y131.186 I-10.756 J9.318 E.02367
G3 X138.801 Y128 I1.61 J-1.501 E.07409
G2 X139.713 Y125.269 I-1.444 J-2 E.06377
G2 X138.682 Y123.982 I-4.389 J2.458 E.03435
G1 X134.822 Y123.982 E.08009
G2 X135.602 Y124.814 I10.752 J-9.315 E.02367
G3 X135.407 Y128 I-1.61 J1.501 E.07409
G2 X134.496 Y130.731 I1.444 J2 E.06377
G2 X135.526 Y132.018 I4.389 J-2.458 E.03434
G1 X132.103 Y132.018 E.07098
G2 X131.323 Y131.186 I-10.749 J9.312 E.02367
G3 X131.518 Y128 I1.61 J-1.501 E.07409
G2 X132.43 Y125.269 I-1.444 J-2 E.06377
G2 X131.399 Y123.982 I-4.389 J2.458 E.03435
G1 X127.538 Y123.982 E.08009
G2 X128.319 Y124.814 I10.756 J-9.319 E.02367
G3 X128.124 Y128 I-1.61 J1.501 E.07408
G2 X127.212 Y130.731 I1.444 J2 E.06377
G2 X128.243 Y132.018 I4.389 J-2.458 E.03434
G1 X124.82 Y132.018 E.07098
G2 X124.039 Y131.186 I-10.756 J9.318 E.02367
G3 X124.235 Y128 I1.61 J-1.501 E.07408
G2 X125.146 Y125.269 I-1.444 J-2 E.06377
G2 X124.116 Y123.982 I-4.389 J2.458 E.03435
G1 X120.255 Y123.982 E.08009
G2 X121.036 Y124.814 I10.752 J-9.315 E.02367
G3 X120.841 Y128 I-1.61 J1.501 E.07409
G2 X119.929 Y130.731 I1.444 J2 E.06377
G2 X120.959 Y132.018 I4.389 J-2.458 E.03434
G1 X117.537 Y132.018 E.07098
G2 X116.756 Y131.186 I-10.752 J9.315 E.02367
G3 X116.952 Y128 I1.61 J-1.501 E.07409
G2 X117.863 Y125.269 I-1.444 J-2 E.06377
G2 X116.833 Y123.982 I-4.389 J2.458 E.03435
G1 X112.972 Y123.982 E.08009
G2 X113.753 Y124.814 I10.756 J-9.319 E.02367
G3 X113.558 Y128 I-1.61 J1.501 E.07409
G2 X112.646 Y130.731 I1.444 J2 E.06377
G2 X113.676 Y132.018 I4.389 J-2.458 E.03434
G1 X110.254 Y132.018 E.07098
G2 X109.473 Y131.186 I-10.756 J9.318 E.02367
G3 X109.668 Y128 I1.61 J-1.501 E.07408
G2 X110.58 Y125.269 I-1.444 J-2 E.06377
G2 X109.55 Y123.982 I-4.389 J2.458 E.03435
G1 X105.689 Y123.982 E.08009
G2 X106.47 Y124.814 I10.749 J-9.312 E.02367
G3 X106.275 Y128 I-1.61 J1.501 E.07409
G2 X105.363 Y130.731 I1.444 J2 E.06377
G2 X106.393 Y132.018 I4.389 J-2.458 E.03434
G1 X104.696 Y132.018 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X106.393 Y132.018 E-.64486
G1 X106.187 Y131.796 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L60
M991 S0 P59 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.56 I-.015 J1.217 P1  F60000
G1 X152.381 Y132.381 Z7.56
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3570
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P85 R2
G1 X151.894 Y132.018 Z7.68 F60000
G1 Z7.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X150.197 Y132.018 E.0352
G3 X149.134 Y130.731 I4.936 J-5.159 E.03469
G3 X149.853 Y128 I2.106 J-.906 E.06311
G2 X149.846 Y124.358 I-1.391 J-1.818 E.08733
G1 X149.496 Y123.982 E.01066
G1 X145.86 Y123.982 E.07542
G3 X146.923 Y125.269 I-4.938 J5.16 E.0347
G3 X146.205 Y128 I-2.106 J.906 E.06311
G2 X146.211 Y131.642 I1.391 J1.818 E.08733
G1 X146.561 Y132.018 E.01066
G1 X142.914 Y132.018 E.07565
G3 X141.851 Y130.731 I4.936 J-5.159 E.03469
G3 X142.57 Y128 I2.106 J-.906 E.06311
G2 X142.563 Y124.358 I-1.391 J-1.818 E.08733
G1 X142.213 Y123.982 E.01066
G1 X138.577 Y123.982 E.07542
G3 X139.64 Y125.269 I-4.938 J5.16 E.0347
G3 X138.922 Y128 I-2.106 J.906 E.06311
G2 X138.928 Y131.642 I1.391 J1.818 E.08733
G1 X139.278 Y132.018 E.01066
G1 X135.631 Y132.018 E.07565
G3 X134.568 Y130.731 I4.937 J-5.16 E.03469
G3 X135.286 Y128 I2.106 J-.906 E.06311
G2 X135.28 Y124.358 I-1.391 J-1.818 E.08733
G1 X134.93 Y123.982 E.01066
G1 X131.294 Y123.982 E.07542
G3 X132.357 Y125.269 I-4.937 J5.16 E.0347
G3 X131.639 Y128 I-2.106 J.906 E.06311
G2 X131.645 Y131.642 I1.391 J1.818 E.08733
G1 X131.995 Y132.018 E.01066
G1 X128.348 Y132.018 E.07565
G3 X127.285 Y130.731 I4.937 J-5.16 E.03469
G3 X128.003 Y128 I2.106 J-.906 E.06311
G2 X127.997 Y124.358 I-1.391 J-1.818 E.08733
G1 X127.647 Y123.982 E.01066
G1 X124.011 Y123.982 E.07542
G3 X125.074 Y125.269 I-4.937 J5.16 E.0347
M73 P85 R1
G3 X124.355 Y128 I-2.106 J.906 E.06311
G2 X124.362 Y131.642 I1.391 J1.818 E.08733
G1 X124.712 Y132.018 E.01066
G1 X121.064 Y132.018 E.07565
G3 X120.002 Y130.731 I4.937 J-5.159 E.03469
G3 X120.72 Y128 I2.106 J-.906 E.06311
G2 X120.714 Y124.358 I-1.391 J-1.818 E.08733
G1 X120.364 Y123.982 E.01066
G1 X116.728 Y123.982 E.07542
G3 X117.791 Y125.269 I-4.937 J5.16 E.0347
G3 X117.072 Y128 I-2.106 J.906 E.06311
G2 X117.079 Y131.642 I1.391 J1.818 E.08733
G1 X117.428 Y132.018 E.01066
G1 X113.781 Y132.018 E.07565
G3 X112.719 Y130.731 I4.937 J-5.16 E.03469
G3 X113.437 Y128 I2.106 J-.906 E.06311
G2 X113.431 Y124.358 I-1.391 J-1.818 E.08733
G1 X113.081 Y123.982 E.01066
G1 X109.445 Y123.982 E.07542
G3 X110.508 Y125.269 I-4.937 J5.16 E.0347
G3 X109.789 Y128 I-2.106 J.906 E.06311
G2 X109.795 Y131.642 I1.391 J1.818 E.08733
G1 X110.145 Y132.018 E.01066
G1 X106.498 Y132.018 E.07565
G3 X105.436 Y130.731 I4.937 J-5.159 E.03469
G3 X106.154 Y128 I2.106 J-.906 E.06311
G2 X106.148 Y124.358 I-1.391 J-1.818 E.08733
G1 X105.798 Y123.982 E.01066
G1 X104.101 Y123.982 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X105.798 Y123.982 E-.64486
G1 X106.004 Y124.204 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L61
M991 S0 P60 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.68 I-.211 J1.198 P1  F60000
G1 X152.381 Y132.381 Z7.68
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3576
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.624 Y124.433 Z7.8 F60000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X151.624 Y124.376 E.00117
G1 X149.983 Y124.376 E.03403
G3 X150.174 Y127.545 I-1.422 J1.676 E.07357
G2 X149.066 Y128.91 I3.582 J4.039 E.03664
G2 X149.95 Y131.624 I2.327 J.743 E.06321
G1 X146.074 Y131.624 E.08038
G3 X145.884 Y128.455 I1.422 J-1.676 E.07356
G2 X146.992 Y127.09 I-3.583 J-4.04 E.03664
G2 X146.108 Y124.376 I-2.327 J-.743 E.06321
G1 X142.7 Y124.376 E.07069
G3 X142.891 Y127.545 I-1.422 J1.676 E.07357
G2 X141.783 Y128.91 I3.582 J4.039 E.03664
G2 X142.666 Y131.624 I2.327 J.743 E.06321
G1 X138.791 Y131.624 E.08038
G3 X138.6 Y128.455 I1.422 J-1.676 E.07356
G2 X139.709 Y127.09 I-3.583 J-4.04 E.03664
G2 X138.825 Y124.376 I-2.327 J-.743 E.06321
G1 X135.417 Y124.376 E.07069
M73 P86 R1
G3 X135.608 Y127.545 I-1.422 J1.676 E.07357
G2 X134.499 Y128.91 I3.582 J4.039 E.03664
G2 X135.383 Y131.624 I2.327 J.743 E.06321
G1 X131.508 Y131.624 E.08038
G3 X131.317 Y128.455 I1.422 J-1.676 E.07356
G2 X132.426 Y127.09 I-3.583 J-4.04 E.03664
G2 X131.542 Y124.376 I-2.327 J-.743 E.06321
G1 X128.134 Y124.376 E.07069
G3 X128.325 Y127.545 I-1.422 J1.676 E.07357
G2 X127.216 Y128.91 I3.583 J4.04 E.03664
G2 X128.1 Y131.624 I2.327 J.743 E.06321
G1 X124.225 Y131.624 E.08038
G3 X124.034 Y128.455 I1.422 J-1.676 E.07356
G2 X125.142 Y127.09 I-3.582 J-4.039 E.03664
G2 X124.259 Y124.376 I-2.327 J-.743 E.06321
G1 X120.851 Y124.376 E.07069
G3 X121.041 Y127.545 I-1.422 J1.676 E.07357
G2 X119.933 Y128.91 I3.582 J4.04 E.03664
G2 X120.817 Y131.624 I2.327 J.743 E.06321
G1 X116.942 Y131.624 E.08038
G3 X116.751 Y128.455 I1.422 J-1.676 E.07356
G2 X117.859 Y127.09 I-3.582 J-4.039 E.03664
G2 X116.975 Y124.376 I-2.327 J-.743 E.06321
G1 X113.568 Y124.376 E.07069
G3 X113.758 Y127.545 I-1.422 J1.676 E.07357
G2 X112.65 Y128.91 I3.583 J4.04 E.03664
G2 X113.534 Y131.624 I2.327 J.743 E.06321
G1 X109.659 Y131.624 E.08038
G3 X109.468 Y128.455 I1.422 J-1.676 E.07356
G2 X110.576 Y127.09 I-3.582 J-4.039 E.03664
G2 X109.692 Y124.376 I-2.327 J-.743 E.06321
G1 X106.284 Y124.376 E.07069
G3 X106.475 Y127.545 I-1.422 J1.676 E.07357
G2 X105.367 Y128.91 I3.583 J4.04 E.03664
G2 X106.251 Y131.624 I2.327 J.743 E.06321
G1 X104.554 Y131.624 E.0352
M204 S10000
G1 X152.002 Y124.164 F60000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378272
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X152.002 Y128 E.06611
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.401599
;_EXTRUDE_SET_SPEED
G1 X152.002 Y131.836 E.07048
G1 X151.974 Y131.974 E.00259
G1 X151.836 Y132.002 E.00259
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378272
;_EXTRUDE_SET_SPEED
G1 X128 Y132.002 E.41082
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40302
;_EXTRUDE_SET_SPEED
G1 X104.164 Y132.002 E.43966
G1 X104.026 Y131.974 E.0026
G1 X103.998 Y131.836 E.0026
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378272
;_EXTRUDE_SET_SPEED
G1 X103.998 Y128 E.06611
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.401599
;_EXTRUDE_SET_SPEED
G1 X103.998 Y124.164 E.07048
G1 X104.026 Y124.026 E.00259
G1 X104.164 Y123.998 E.00259
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378272
;_EXTRUDE_SET_SPEED
G1 X128 Y123.998 E.41082
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.403239
;_EXTRUDE_SET_SPEED
G1 X151.836 Y123.998 E.43992
G1 X151.974 Y124.026 E.0026
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.403312
;_EXTRUDE_SET_SPEED
G1 X151.982 Y124.066 E.00075
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378272
;_EXTRUDE_SET_SPEED
G1 X151.99 Y124.106 E.0007
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X151.982 Y124.066 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L62
M991 S0 P61 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.8 I-1.216 J.058 P1  F60000
G1 X152.381 Y132.381 Z7.8
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3582
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P87 R1
G1 X151.058 Y132.203 Z7.92 F60000
G1 Z7.52
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.49195
; LAYER_HEIGHT: 0.489898
G1 F1500
M204 S4000
G1 X151.96 Y131.374 E.09489
G1 X151.96 Y130.638 E.057
G1 X150.521 Y131.96 E.15132
G1 X149.721 Y131.96 E.06203
G1 X151.96 Y129.902 E.23557
G1 X151.96 Y129.166 E.057
G1 X148.92 Y131.96 E.31981
G1 X148.119 Y131.96 E.06203
G1 X151.96 Y128.43 E.40405
G1 X151.96 Y127.694 E.057
G1 X147.318 Y131.96 E.48829
G1 X146.517 Y131.96 E.06203
G1 X151.96 Y126.958 E.57253
G1 X151.96 Y126.221 E.057
G1 X145.716 Y131.96 E.65677
G1 X144.915 Y131.96 E.06202
G1 X151.96 Y125.485 E.74102
G1 X151.96 Y124.749 E.057
G1 X144.114 Y131.96 E.82526
G1 X143.313 Y131.96 E.06202
G1 X151.931 Y124.04 E.90645
G1 X151.13 Y124.04 E.06203
G1 X142.512 Y131.96 E.90645
G1 X141.712 Y131.96 E.06203
G1 X150.329 Y124.04 E.90645
G1 X149.528 Y124.04 E.06203
G1 X140.911 Y131.96 E.90645
G1 X140.11 Y131.96 E.06203
G1 X148.728 Y124.04 E.90645
G1 X147.927 Y124.04 E.06203
G1 X139.309 Y131.96 E.90645
G1 X138.508 Y131.96 E.06203
G1 X147.126 Y124.04 E.90645
G1 X146.325 Y124.04 E.06202
G1 X137.707 Y131.96 E.90645
G1 X136.906 Y131.96 E.06202
G1 X145.524 Y124.04 E.90645
G1 X144.723 Y124.04 E.06203
G1 X136.105 Y131.96 E.90645
G1 X135.304 Y131.96 E.06202
M73 P88 R1
G1 X143.922 Y124.04 E.90645
G1 X143.121 Y124.04 E.06202
G1 X134.504 Y131.96 E.90645
G1 X133.703 Y131.96 E.06203
G1 X142.32 Y124.04 E.90645
G1 X141.519 Y124.04 E.06202
G1 X132.902 Y131.96 E.90645
G1 X132.101 Y131.96 E.06203
G1 X140.719 Y124.04 E.90645
G1 X139.918 Y124.04 E.06203
G1 X131.3 Y131.96 E.90645
G1 X130.499 Y131.96 E.06203
G1 X139.117 Y124.04 E.90645
G1 X138.316 Y124.04 E.06203
G1 X129.698 Y131.96 E.90645
G1 X128.897 Y131.96 E.06203
G1 X137.515 Y124.04 E.90645
G1 X136.714 Y124.04 E.06202
G1 X128.096 Y131.96 E.90645
G1 X127.295 Y131.96 E.06203
G1 X135.913 Y124.04 E.90645
G1 X135.112 Y124.04 E.06202
G1 X126.495 Y131.96 E.90645
G1 X125.694 Y131.96 E.06202
G1 X134.311 Y124.04 E.90645
G1 X133.511 Y124.04 E.06203
G1 X124.893 Y131.96 E.90645
G1 X124.092 Y131.96 E.06202
G1 X132.71 Y124.04 E.90645
G1 X131.909 Y124.04 E.06203
G1 X123.291 Y131.96 E.90645
G1 X122.49 Y131.96 E.06203
G1 X131.108 Y124.04 E.90645
M73 P89 R1
G1 X130.307 Y124.04 E.06203
G1 X121.689 Y131.96 E.90645
G1 X120.888 Y131.96 E.06203
G1 X129.506 Y124.04 E.90645
G1 X128.705 Y124.04 E.06202
G1 X120.087 Y131.96 E.90645
G1 X119.286 Y131.96 E.06202
G1 X127.904 Y124.04 E.90645
G1 X127.103 Y124.04 E.06202
G1 X118.486 Y131.96 E.90645
G1 X117.685 Y131.96 E.06202
G1 X126.302 Y124.04 E.90645
G1 X125.502 Y124.04 E.06202
G1 X116.884 Y131.96 E.90645
G1 X116.083 Y131.96 E.06203
G1 X124.701 Y124.04 E.90645
G1 X123.9 Y124.04 E.06202
G1 X115.282 Y131.96 E.90645
G1 X114.481 Y131.96 E.06203
G1 X123.099 Y124.04 E.90645
G1 X122.298 Y124.04 E.06203
G1 X113.68 Y131.96 E.90645
G1 X112.879 Y131.96 E.06203
G1 X121.497 Y124.04 E.90645
G1 X120.696 Y124.04 E.06203
G1 X112.078 Y131.96 E.90645
G1 X111.278 Y131.96 E.06203
G1 X119.895 Y124.04 E.90645
G1 X119.094 Y124.04 E.06203
G1 X110.477 Y131.96 E.90645
G1 X109.676 Y131.96 E.06202
G1 X118.293 Y124.04 E.90645
G1 X117.493 Y124.04 E.06202
M73 P90 R1
G1 X108.875 Y131.96 E.90645
G1 X108.074 Y131.96 E.06202
G1 X116.692 Y124.04 E.90645
G1 X115.891 Y124.04 E.06203
G1 X107.273 Y131.96 E.90645
G1 X106.472 Y131.96 E.06202
G1 X115.09 Y124.04 E.90645
G1 X114.289 Y124.04 E.06203
G1 X105.671 Y131.96 E.90645
G1 X104.87 Y131.96 E.06203
G1 X113.488 Y124.04 E.90645
G1 X112.687 Y124.04 E.06203
G1 X104.069 Y131.96 E.90645
G1 X104.04 Y131.96 E.00229
G1 X104.04 Y131.251 E.0549
G1 X111.886 Y124.04 E.82532
G1 X111.085 Y124.04 E.06202
G1 X104.04 Y130.515 E.74108
G1 X104.04 Y129.779 E.057
G1 X110.285 Y124.04 E.65683
G1 X109.484 Y124.04 E.06202
G1 X104.04 Y129.043 E.57259
G1 X104.04 Y128.307 E.057
G1 X108.683 Y124.04 E.48835
G1 X107.882 Y124.04 E.06202
G1 X104.04 Y127.571 E.40411
G1 X104.04 Y126.835 E.057
G1 X107.081 Y124.04 E.31987
G1 X106.28 Y124.04 E.06202
G1 X104.04 Y126.099 E.23563
G1 X104.04 Y125.363 E.057
G1 X105.479 Y124.04 E.15138
G1 X104.678 Y124.04 E.06203
G1 X103.797 Y124.85 E.0927
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X104.678 Y124.04 E-.45484
G1 X105.479 Y124.04 E-.30434
G1 X105.478 Y124.041 E-.00082
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L63
M991 S0 P62 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.92 I-.213 J1.198 P1  F60000
G1 X152.381 Y132.381 Z7.92
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3586
M204 S2000
G1 X152.79 Y123.21 E.18466
M73 P91 R1
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.21 Y124.587 Z8.04 F60000
G1 Z7.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420342
G1 F10800
M204 S4000
G1 X151.59 Y123.967 E.01692
G1 X151.032 Y123.967 E.01077
G1 X152.033 Y124.968 E.02731
G1 X152.033 Y125.526 E.01077
G1 X150.474 Y123.967 E.04253
G1 X149.916 Y123.967 E.01077
G1 X152.033 Y126.084 E.05776
G1 X152.033 Y126.642 E.01077
G1 X149.358 Y123.967 E.07298
G1 X148.8 Y123.967 E.01077
G1 X152.033 Y127.2 E.08821
G1 X152.033 Y127.758 E.01077
G1 X148.242 Y123.967 E.10343
G1 X147.684 Y123.967 E.01077
G1 X152.033 Y128.316 E.11866
G1 X152.033 Y128.874 E.01077
G1 X147.126 Y123.967 E.13388
G1 X146.568 Y123.967 E.01077
G1 X152.033 Y129.432 E.14911
G1 X152.033 Y129.99 E.01077
G1 X146.01 Y123.967 E.16433
G1 X145.452 Y123.967 E.01077
G1 X152.033 Y130.548 E.17956
G1 X152.033 Y131.106 E.01077
G1 X144.894 Y123.967 E.19479
G1 X144.336 Y123.967 E.01077
G1 X152.033 Y131.664 E.21001
G1 X152.033 Y132.033 E.00711
G1 X151.843 Y132.033 E.00366
G1 X143.778 Y123.967 E.22006
G1 X143.22 Y123.967 E.01077
G1 X151.285 Y132.033 E.22006
G1 X150.727 Y132.033 E.01077
G1 X142.661 Y123.967 E.22006
G1 X142.103 Y123.967 E.01077
G1 X150.169 Y132.033 E.22006
G1 X149.611 Y132.033 E.01077
G1 X141.545 Y123.967 E.22006
G1 X140.987 Y123.967 E.01077
G1 X149.053 Y132.033 E.22006
G1 X148.495 Y132.033 E.01077
G1 X140.429 Y123.967 E.22006
G1 X139.871 Y123.967 E.01077
G1 X147.937 Y132.033 E.22006
G1 X147.379 Y132.033 E.01077
G1 X139.313 Y123.967 E.22006
G1 X138.755 Y123.967 E.01077
G1 X146.821 Y132.033 E.22006
G1 X146.263 Y132.033 E.01077
G1 X138.197 Y123.967 E.22006
G1 X137.639 Y123.967 E.01077
G1 X145.705 Y132.033 E.22006
G1 X145.147 Y132.033 E.01077
G1 X137.081 Y123.967 E.22006
G1 X136.523 Y123.967 E.01077
G1 X144.589 Y132.033 E.22006
G1 X144.031 Y132.033 E.01077
G1 X135.965 Y123.967 E.22006
G1 X135.407 Y123.967 E.01077
G1 X143.473 Y132.033 E.22006
G1 X142.915 Y132.033 E.01077
G1 X134.849 Y123.967 E.22006
G1 X134.291 Y123.967 E.01077
G1 X142.357 Y132.033 E.22006
G1 X141.799 Y132.033 E.01077
G1 X133.733 Y123.967 E.22006
G1 X133.175 Y123.967 E.01077
G1 X141.241 Y132.033 E.22006
G1 X140.683 Y132.033 E.01077
G1 X132.617 Y123.967 E.22006
G1 X132.059 Y123.967 E.01077
G1 X140.125 Y132.033 E.22006
G1 X139.567 Y132.033 E.01077
G1 X131.501 Y123.967 E.22006
G1 X130.943 Y123.967 E.01077
G1 X139.009 Y132.033 E.22006
G1 X138.451 Y132.033 E.01077
G1 X130.385 Y123.967 E.22006
G1 X129.827 Y123.967 E.01077
G1 X137.892 Y132.033 E.22006
G1 X137.334 Y132.033 E.01077
G1 X129.269 Y123.967 E.22006
G1 X128.711 Y123.967 E.01077
G1 X136.776 Y132.033 E.22006
G1 X136.218 Y132.033 E.01077
G1 X128.153 Y123.967 E.22006
G1 X127.595 Y123.967 E.01077
G1 X135.66 Y132.033 E.22006
G1 X135.102 Y132.033 E.01077
G1 X127.037 Y123.967 E.22006
G1 X126.478 Y123.967 E.01077
G1 X134.544 Y132.033 E.22006
G1 X133.986 Y132.033 E.01077
G1 X125.92 Y123.967 E.22006
G1 X125.362 Y123.967 E.01077
G1 X133.428 Y132.033 E.22006
G1 X132.87 Y132.033 E.01077
G1 X124.804 Y123.967 E.22006
G1 X124.246 Y123.967 E.01077
M73 P92 R1
G1 X132.312 Y132.033 E.22006
G1 X131.754 Y132.033 E.01077
G1 X123.688 Y123.967 E.22006
G1 X123.13 Y123.967 E.01077
G1 X131.196 Y132.033 E.22006
G1 X130.638 Y132.033 E.01077
G1 X122.572 Y123.967 E.22006
G1 X122.014 Y123.967 E.01077
G1 X130.08 Y132.033 E.22006
G1 X129.522 Y132.033 E.01077
G1 X121.456 Y123.967 E.22006
G1 X120.898 Y123.967 E.01077
G1 X128.964 Y132.033 E.22006
G1 X128.406 Y132.033 E.01077
G1 X120.34 Y123.967 E.22006
G1 X119.782 Y123.967 E.01077
G1 X127.848 Y132.033 E.22006
G1 X127.29 Y132.033 E.01077
G1 X119.224 Y123.967 E.22006
G1 X118.666 Y123.967 E.01077
G1 X126.732 Y132.033 E.22006
G1 X126.174 Y132.033 E.01077
G1 X118.108 Y123.967 E.22006
G1 X117.55 Y123.967 E.01077
G1 X125.616 Y132.033 E.22006
G1 X125.058 Y132.033 E.01077
G1 X116.992 Y123.967 E.22006
G1 X116.434 Y123.967 E.01077
G1 X124.5 Y132.033 E.22006
G1 X123.942 Y132.033 E.01077
G1 X115.876 Y123.967 E.22006
G1 X115.318 Y123.967 E.01077
G1 X123.384 Y132.033 E.22006
G1 X122.826 Y132.033 E.01077
G1 X114.76 Y123.967 E.22006
G1 X114.202 Y123.967 E.01077
G1 X122.268 Y132.033 E.22006
G1 X121.709 Y132.033 E.01077
G1 X113.644 Y123.967 E.22006
G1 X113.086 Y123.967 E.01077
G1 X121.151 Y132.033 E.22006
G1 X120.593 Y132.033 E.01077
G1 X112.528 Y123.967 E.22006
G1 X111.97 Y123.967 E.01077
G1 X120.035 Y132.033 E.22006
G1 X119.477 Y132.033 E.01077
G1 X111.412 Y123.967 E.22006
G1 X110.854 Y123.967 E.01077
G1 X118.919 Y132.033 E.22006
G1 X118.361 Y132.033 E.01077
G1 X110.295 Y123.967 E.22006
G1 X109.737 Y123.967 E.01077
G1 X117.803 Y132.033 E.22006
G1 X117.245 Y132.033 E.01077
G1 X109.179 Y123.967 E.22006
G1 X108.621 Y123.967 E.01077
G1 X116.687 Y132.033 E.22006
G1 X116.129 Y132.033 E.01077
G1 X108.063 Y123.967 E.22006
G1 X107.505 Y123.967 E.01077
G1 X115.571 Y132.033 E.22006
G1 X115.013 Y132.033 E.01077
G1 X106.947 Y123.967 E.22006
G1 X106.389 Y123.967 E.01077
G1 X114.455 Y132.033 E.22006
G1 X113.897 Y132.033 E.01077
G1 X105.831 Y123.967 E.22006
G1 X105.273 Y123.967 E.01077
G1 X113.339 Y132.033 E.22006
G1 X112.781 Y132.033 E.01077
G1 X104.715 Y123.967 E.22006
G1 X104.157 Y123.967 E.01077
G1 X112.223 Y132.033 E.22006
G1 X111.665 Y132.033 E.01077
G1 X103.967 Y124.335 E.21002
G1 X103.967 Y124.893 E.01077
G1 X111.107 Y132.033 E.1948
G1 X110.549 Y132.033 E.01077
G1 X103.967 Y125.451 E.17957
G1 X103.967 Y126.009 E.01077
G1 X109.991 Y132.033 E.16435
G1 X109.433 Y132.033 E.01077
G1 X103.967 Y126.567 E.14912
G1 X103.967 Y127.125 E.01077
G1 X108.875 Y132.033 E.1339
G1 X108.317 Y132.033 E.01077
G1 X103.967 Y127.683 E.11867
G1 X103.967 Y128.241 E.01077
G1 X107.759 Y132.033 E.10345
G1 X107.201 Y132.033 E.01077
G1 X103.967 Y128.799 E.08822
G1 X103.967 Y129.357 E.01077
G1 X106.643 Y132.033 E.073
G1 X106.085 Y132.033 E.01077
G1 X103.967 Y129.915 E.05777
G1 X103.967 Y130.473 E.01077
G1 X105.526 Y132.033 E.04255
G1 X104.968 Y132.033 E.01077
M73 P92 R0
G1 X103.967 Y131.032 E.02732
G1 X103.967 Y131.59 E.01077
G1 X104.588 Y132.21 E.01694
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X103.967 Y131.59 E-.33359
G1 X103.967 Y131.032 E-.21205
G1 X104.366 Y131.43 E-.21436
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L64
M991 S0 P63 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.04 I-.024 J1.217 P1  F60000
G1 X152.381 Y132.381 Z8.04
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3589
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P93 R0
G1 X151.413 Y132.21 Z8.16 F60000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420342
G1 F10800
M204 S4000
G1 X152.033 Y131.59 E.01692
G1 X152.033 Y131.032 E.01077
G1 X151.032 Y132.033 E.02731
G1 X150.474 Y132.033 E.01077
G1 X152.033 Y130.474 E.04253
G1 X152.033 Y129.916 E.01077
G1 X149.916 Y132.033 E.05776
G1 X149.358 Y132.033 E.01077
G1 X152.033 Y129.358 E.07298
G1 X152.033 Y128.8 E.01077
G1 X148.8 Y132.033 E.08821
G1 X148.242 Y132.033 E.01077
G1 X152.033 Y128.242 E.10343
G1 X152.033 Y127.684 E.01077
G1 X147.684 Y132.033 E.11866
G1 X147.126 Y132.033 E.01077
G1 X152.033 Y127.126 E.13388
G1 X152.033 Y126.568 E.01077
G1 X146.568 Y132.033 E.14911
G1 X146.01 Y132.033 E.01077
G1 X152.033 Y126.01 E.16433
G1 X152.033 Y125.452 E.01077
G1 X145.452 Y132.033 E.17956
G1 X144.894 Y132.033 E.01077
G1 X152.033 Y124.894 E.19479
G1 X152.033 Y124.336 E.01077
G1 X144.336 Y132.033 E.21001
G1 X143.778 Y132.033 E.01077
G1 X151.843 Y123.967 E.22006
G1 X151.285 Y123.967 E.01077
G1 X143.22 Y132.033 E.22006
G1 X142.661 Y132.033 E.01077
G1 X150.727 Y123.967 E.22006
G1 X150.169 Y123.967 E.01077
G1 X142.103 Y132.033 E.22006
G1 X141.545 Y132.033 E.01077
G1 X149.611 Y123.967 E.22006
G1 X149.053 Y123.967 E.01077
G1 X140.987 Y132.033 E.22006
G1 X140.429 Y132.033 E.01077
G1 X148.495 Y123.967 E.22006
G1 X147.937 Y123.967 E.01077
G1 X139.871 Y132.033 E.22006
G1 X139.313 Y132.033 E.01077
G1 X147.379 Y123.967 E.22006
G1 X146.821 Y123.967 E.01077
G1 X138.755 Y132.033 E.22006
G1 X138.197 Y132.033 E.01077
G1 X146.263 Y123.967 E.22006
G1 X145.705 Y123.967 E.01077
G1 X137.639 Y132.033 E.22006
G1 X137.081 Y132.033 E.01077
G1 X145.147 Y123.967 E.22006
G1 X144.589 Y123.967 E.01077
G1 X136.523 Y132.033 E.22006
G1 X135.965 Y132.033 E.01077
G1 X144.031 Y123.967 E.22006
G1 X143.473 Y123.967 E.01077
G1 X135.407 Y132.033 E.22006
G1 X134.849 Y132.033 E.01077
G1 X142.915 Y123.967 E.22006
G1 X142.357 Y123.967 E.01077
G1 X134.291 Y132.033 E.22006
G1 X133.733 Y132.033 E.01077
G1 X141.799 Y123.967 E.22006
G1 X141.241 Y123.967 E.01077
G1 X133.175 Y132.033 E.22006
G1 X132.617 Y132.033 E.01077
G1 X140.683 Y123.967 E.22006
G1 X140.125 Y123.967 E.01077
G1 X132.059 Y132.033 E.22006
G1 X131.501 Y132.033 E.01077
G1 X139.567 Y123.967 E.22006
G1 X139.009 Y123.967 E.01077
G1 X130.943 Y132.033 E.22006
G1 X130.385 Y132.033 E.01077
G1 X138.451 Y123.967 E.22006
G1 X137.892 Y123.967 E.01077
G1 X129.827 Y132.033 E.22006
G1 X129.269 Y132.033 E.01077
G1 X137.334 Y123.967 E.22006
G1 X136.776 Y123.967 E.01077
G1 X128.711 Y132.033 E.22006
G1 X128.153 Y132.033 E.01077
G1 X136.218 Y123.967 E.22006
G1 X135.66 Y123.967 E.01077
G1 X127.595 Y132.033 E.22006
G1 X127.037 Y132.033 E.01077
G1 X135.102 Y123.967 E.22006
G1 X134.544 Y123.967 E.01077
G1 X126.478 Y132.033 E.22006
G1 X125.92 Y132.033 E.01077
G1 X133.986 Y123.967 E.22006
G1 X133.428 Y123.967 E.01077
G1 X125.362 Y132.033 E.22006
G1 X124.804 Y132.033 E.01077
G1 X132.87 Y123.967 E.22006
G1 X132.312 Y123.967 E.01077
G1 X124.246 Y132.033 E.22006
G1 X123.688 Y132.033 E.01077
G1 X131.754 Y123.967 E.22006
G1 X131.196 Y123.967 E.01077
G1 X123.13 Y132.033 E.22006
G1 X122.572 Y132.033 E.01077
G1 X130.638 Y123.967 E.22006
G1 X130.08 Y123.967 E.01077
G1 X122.014 Y132.033 E.22006
G1 X121.456 Y132.033 E.01077
G1 X129.522 Y123.967 E.22006
G1 X128.964 Y123.967 E.01077
G1 X120.898 Y132.033 E.22006
G1 X120.34 Y132.033 E.01077
G1 X128.406 Y123.967 E.22006
G1 X127.848 Y123.967 E.01077
G1 X119.782 Y132.033 E.22006
G1 X119.224 Y132.033 E.01077
G1 X127.29 Y123.967 E.22006
G1 X126.732 Y123.967 E.01077
G1 X118.666 Y132.033 E.22006
G1 X118.108 Y132.033 E.01077
G1 X126.174 Y123.967 E.22006
G1 X125.616 Y123.967 E.01077
M73 P94 R0
G1 X117.55 Y132.033 E.22006
G1 X116.992 Y132.033 E.01077
G1 X125.058 Y123.967 E.22006
G1 X124.5 Y123.967 E.01077
G1 X116.434 Y132.033 E.22006
G1 X115.876 Y132.033 E.01077
G1 X123.942 Y123.967 E.22006
G1 X123.384 Y123.967 E.01077
G1 X115.318 Y132.033 E.22006
G1 X114.76 Y132.033 E.01077
G1 X122.826 Y123.967 E.22006
G1 X122.268 Y123.967 E.01077
G1 X114.202 Y132.033 E.22006
G1 X113.644 Y132.033 E.01077
G1 X121.709 Y123.967 E.22006
G1 X121.151 Y123.967 E.01077
G1 X113.086 Y132.033 E.22006
G1 X112.528 Y132.033 E.01077
G1 X120.593 Y123.967 E.22006
G1 X120.035 Y123.967 E.01077
G1 X111.97 Y132.033 E.22006
G1 X111.412 Y132.033 E.01077
G1 X119.477 Y123.967 E.22006
G1 X118.919 Y123.967 E.01077
G1 X110.854 Y132.033 E.22006
G1 X110.295 Y132.033 E.01077
G1 X118.361 Y123.967 E.22006
G1 X117.803 Y123.967 E.01077
G1 X109.737 Y132.033 E.22006
G1 X109.179 Y132.033 E.01077
G1 X117.245 Y123.967 E.22006
G1 X116.687 Y123.967 E.01077
G1 X108.621 Y132.033 E.22006
G1 X108.063 Y132.033 E.01077
G1 X116.129 Y123.967 E.22006
G1 X115.571 Y123.967 E.01077
G1 X107.505 Y132.033 E.22006
G1 X106.947 Y132.033 E.01077
G1 X115.013 Y123.967 E.22006
G1 X114.455 Y123.967 E.01077
G1 X106.389 Y132.033 E.22006
G1 X105.831 Y132.033 E.01077
G1 X113.897 Y123.967 E.22006
G1 X113.339 Y123.967 E.01077
G1 X105.273 Y132.033 E.22006
G1 X104.715 Y132.033 E.01077
G1 X112.781 Y123.967 E.22006
G1 X112.223 Y123.967 E.01077
G1 X104.157 Y132.033 E.22006
G1 X103.967 Y132.033 E.00367
G1 X103.967 Y131.665 E.0071
G1 X111.665 Y123.967 E.21002
G1 X111.107 Y123.967 E.01077
G1 X103.967 Y131.107 E.1948
G1 X103.967 Y130.549 E.01077
G1 X110.549 Y123.967 E.17957
G1 X109.991 Y123.967 E.01077
G1 X103.967 Y129.991 E.16435
G1 X103.967 Y129.433 E.01077
G1 X109.433 Y123.967 E.14912
G1 X108.875 Y123.967 E.01077
G1 X103.967 Y128.875 E.1339
G1 X103.967 Y128.317 E.01077
G1 X108.317 Y123.967 E.11867
G1 X107.759 Y123.967 E.01077
G1 X103.967 Y127.759 E.10345
G1 X103.967 Y127.201 E.01077
G1 X107.201 Y123.967 E.08822
G1 X106.643 Y123.967 E.01077
G1 X103.967 Y126.643 E.073
G1 X103.967 Y126.085 E.01077
G1 X106.085 Y123.967 E.05777
G1 X105.526 Y123.967 E.01077
G1 X103.967 Y125.526 E.04255
G1 X103.967 Y124.968 E.01077
G1 X104.968 Y123.967 E.02732
G1 X104.41 Y123.967 E.01077
G1 X103.79 Y124.588 E.01694
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X104.41 Y123.967 E-.33359
G1 X104.968 Y123.967 E-.21206
G1 X104.57 Y124.366 E-.21436
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L65
M991 S0 P64 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.16 I-.201 J1.2 P1  F60000
G1 X152.381 Y132.381 Z8.16
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X152.381 Y123.619 E.18174
G1 X103.619 Y123.619 E1.01144
G1 X103.619 Y132.381 E.18174
G1 X152.321 Y132.381 E1.01019
; COOLING_NODE: 0
M204 S250
G1 X152.79 Y132.79 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3591
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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
G1 X152.743 Y130.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.21 Y124.587 Z8.28 F60000
G1 Z7.88
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420342
G1 F10800
M204 S4000
G1 X151.59 Y123.967 E.01692
G1 X151.032 Y123.967 E.01077
G1 X152.033 Y124.968 E.02731
G1 X152.033 Y125.526 E.01077
G1 X150.474 Y123.967 E.04253
G1 X149.916 Y123.967 E.01077
G1 X152.033 Y126.084 E.05776
G1 X152.033 Y126.642 E.01077
G1 X149.358 Y123.967 E.07298
G1 X148.8 Y123.967 E.01077
M73 P95 R0
G1 X152.033 Y127.2 E.08821
G1 X152.033 Y127.758 E.01077
G1 X148.242 Y123.967 E.10343
G1 X147.684 Y123.967 E.01077
G1 X152.033 Y128.316 E.11866
G1 X152.033 Y128.874 E.01077
G1 X147.126 Y123.967 E.13388
G1 X146.568 Y123.967 E.01077
G1 X152.033 Y129.432 E.14911
G1 X152.033 Y129.99 E.01077
G1 X146.01 Y123.967 E.16433
G1 X145.452 Y123.967 E.01077
G1 X152.033 Y130.548 E.17956
G1 X152.033 Y131.106 E.01077
G1 X144.894 Y123.967 E.19479
G1 X144.336 Y123.967 E.01077
G1 X152.033 Y131.664 E.21001
G1 X152.033 Y132.033 E.00711
G1 X151.843 Y132.033 E.00366
G1 X143.778 Y123.967 E.22006
G1 X143.22 Y123.967 E.01077
G1 X151.285 Y132.033 E.22006
G1 X150.727 Y132.033 E.01077
G1 X142.661 Y123.967 E.22006
G1 X142.103 Y123.967 E.01077
G1 X150.169 Y132.033 E.22006
G1 X149.611 Y132.033 E.01077
G1 X141.545 Y123.967 E.22006
G1 X140.987 Y123.967 E.01077
G1 X149.053 Y132.033 E.22006
G1 X148.495 Y132.033 E.01077
G1 X140.429 Y123.967 E.22006
G1 X139.871 Y123.967 E.01077
G1 X147.937 Y132.033 E.22006
G1 X147.379 Y132.033 E.01077
G1 X139.313 Y123.967 E.22006
G1 X138.755 Y123.967 E.01077
G1 X146.821 Y132.033 E.22006
G1 X146.263 Y132.033 E.01077
G1 X138.197 Y123.967 E.22006
G1 X137.639 Y123.967 E.01077
G1 X145.705 Y132.033 E.22006
G1 X145.147 Y132.033 E.01077
G1 X137.081 Y123.967 E.22006
G1 X136.523 Y123.967 E.01077
G1 X144.589 Y132.033 E.22006
G1 X144.031 Y132.033 E.01077
G1 X135.965 Y123.967 E.22006
G1 X135.407 Y123.967 E.01077
G1 X143.473 Y132.033 E.22006
G1 X142.915 Y132.033 E.01077
G1 X134.849 Y123.967 E.22006
G1 X134.291 Y123.967 E.01077
G1 X142.357 Y132.033 E.22006
G1 X141.799 Y132.033 E.01077
G1 X133.733 Y123.967 E.22006
G1 X133.175 Y123.967 E.01077
G1 X141.241 Y132.033 E.22006
G1 X140.683 Y132.033 E.01077
G1 X132.617 Y123.967 E.22006
G1 X132.059 Y123.967 E.01077
G1 X140.125 Y132.033 E.22006
G1 X139.567 Y132.033 E.01077
G1 X131.501 Y123.967 E.22006
G1 X130.943 Y123.967 E.01077
G1 X139.009 Y132.033 E.22006
G1 X138.451 Y132.033 E.01077
G1 X130.385 Y123.967 E.22006
G1 X129.827 Y123.967 E.01077
G1 X137.892 Y132.033 E.22006
G1 X137.334 Y132.033 E.01077
G1 X129.269 Y123.967 E.22006
G1 X128.711 Y123.967 E.01077
G1 X136.776 Y132.033 E.22006
G1 X136.218 Y132.033 E.01077
G1 X128.153 Y123.967 E.22006
G1 X127.595 Y123.967 E.01077
G1 X135.66 Y132.033 E.22006
G1 X135.102 Y132.033 E.01077
G1 X127.037 Y123.967 E.22006
G1 X126.478 Y123.967 E.01077
G1 X134.544 Y132.033 E.22006
G1 X133.986 Y132.033 E.01077
G1 X125.92 Y123.967 E.22006
G1 X125.362 Y123.967 E.01077
G1 X133.428 Y132.033 E.22006
G1 X132.87 Y132.033 E.01077
G1 X124.804 Y123.967 E.22006
G1 X124.246 Y123.967 E.01077
G1 X132.312 Y132.033 E.22006
G1 X131.754 Y132.033 E.01077
G1 X123.688 Y123.967 E.22006
G1 X123.13 Y123.967 E.01077
G1 X131.196 Y132.033 E.22006
G1 X130.638 Y132.033 E.01077
G1 X122.572 Y123.967 E.22006
G1 X122.014 Y123.967 E.01077
G1 X130.08 Y132.033 E.22006
G1 X129.522 Y132.033 E.01077
G1 X121.456 Y123.967 E.22006
G1 X120.898 Y123.967 E.01077
G1 X128.964 Y132.033 E.22006
G1 X128.406 Y132.033 E.01077
G1 X120.34 Y123.967 E.22006
G1 X119.782 Y123.967 E.01077
G1 X127.848 Y132.033 E.22006
G1 X127.29 Y132.033 E.01077
G1 X119.224 Y123.967 E.22006
G1 X118.666 Y123.967 E.01077
G1 X126.732 Y132.033 E.22006
G1 X126.174 Y132.033 E.01077
G1 X118.108 Y123.967 E.22006
G1 X117.55 Y123.967 E.01077
G1 X125.616 Y132.033 E.22006
G1 X125.058 Y132.033 E.01077
G1 X116.992 Y123.967 E.22006
G1 X116.434 Y123.967 E.01077
G1 X124.5 Y132.033 E.22006
G1 X123.942 Y132.033 E.01077
G1 X115.876 Y123.967 E.22006
G1 X115.318 Y123.967 E.01077
G1 X123.384 Y132.033 E.22006
G1 X122.826 Y132.033 E.01077
G1 X114.76 Y123.967 E.22006
G1 X114.202 Y123.967 E.01077
G1 X122.268 Y132.033 E.22006
G1 X121.709 Y132.033 E.01077
G1 X113.644 Y123.967 E.22006
G1 X113.086 Y123.967 E.01077
G1 X121.151 Y132.033 E.22006
G1 X120.593 Y132.033 E.01077
G1 X112.528 Y123.967 E.22006
G1 X111.97 Y123.967 E.01077
G1 X120.035 Y132.033 E.22006
G1 X119.477 Y132.033 E.01077
G1 X111.412 Y123.967 E.22006
G1 X110.854 Y123.967 E.01077
G1 X118.919 Y132.033 E.22006
M73 P96 R0
G1 X118.361 Y132.033 E.01077
G1 X110.295 Y123.967 E.22006
G1 X109.737 Y123.967 E.01077
G1 X117.803 Y132.033 E.22006
G1 X117.245 Y132.033 E.01077
G1 X109.179 Y123.967 E.22006
G1 X108.621 Y123.967 E.01077
G1 X116.687 Y132.033 E.22006
G1 X116.129 Y132.033 E.01077
G1 X108.063 Y123.967 E.22006
G1 X107.505 Y123.967 E.01077
G1 X115.571 Y132.033 E.22006
G1 X115.013 Y132.033 E.01077
G1 X106.947 Y123.967 E.22006
G1 X106.389 Y123.967 E.01077
G1 X114.455 Y132.033 E.22006
G1 X113.897 Y132.033 E.01077
G1 X105.831 Y123.967 E.22006
G1 X105.273 Y123.967 E.01077
G1 X113.339 Y132.033 E.22006
G1 X112.781 Y132.033 E.01077
G1 X104.715 Y123.967 E.22006
G1 X104.157 Y123.967 E.01077
G1 X112.223 Y132.033 E.22006
G1 X111.665 Y132.033 E.01077
G1 X103.967 Y124.335 E.21002
G1 X103.967 Y124.893 E.01077
G1 X111.107 Y132.033 E.1948
G1 X110.549 Y132.033 E.01077
G1 X103.967 Y125.451 E.17957
G1 X103.967 Y126.009 E.01077
G1 X109.991 Y132.033 E.16435
G1 X109.433 Y132.033 E.01077
G1 X103.967 Y126.567 E.14912
G1 X103.967 Y127.125 E.01077
G1 X108.875 Y132.033 E.1339
G1 X108.317 Y132.033 E.01077
G1 X103.967 Y127.683 E.11867
G1 X103.967 Y128.241 E.01077
G1 X107.759 Y132.033 E.10345
G1 X107.201 Y132.033 E.01077
G1 X103.967 Y128.799 E.08822
G1 X103.967 Y129.357 E.01077
G1 X106.643 Y132.033 E.073
G1 X106.085 Y132.033 E.01077
G1 X103.967 Y129.915 E.05777
G1 X103.967 Y130.473 E.01077
G1 X105.526 Y132.033 E.04255
G1 X104.968 Y132.033 E.01077
G1 X103.967 Y131.032 E.02732
G1 X103.967 Y131.59 E.01077
G1 X104.588 Y132.21 E.01694
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X103.967 Y131.59 E-.33359
G1 X103.967 Y131.032 E-.21205
G1 X104.366 Y131.43 E-.21436
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L66
M991 S0 P65 ;notify layer change

; OBJECT_ID: 338
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.28 I-.034 J1.216 P1  F60000
G1 X152.79 Y132.79 Z8.28
G1 Z8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3592
M204 S2000
G1 X152.79 Y123.21 E.18466
G1 X103.21 Y123.21 E.95569
G1 X103.21 Y132.79 E.18466
G1 X152.73 Y132.79 E.95453
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

M204 S10000
G1 X152.573 Y132.14 F60000
; FEATURE: Top surface
G1 F9000
M204 S2000
G1 X152.14 Y132.573 E.01181
G1 X152.006 Y132.707
G1 X151.449 Y132.707
G1 X151.583 Y132.573
G1 X152.573 Y131.582 E.02701
G1 X152.707 Y131.449
G1 X152.707 Y130.891
G1 X152.573 Y131.025
G1 X151.025 Y132.573 E.0422
G1 X150.891 Y132.707
G1 X150.334 Y132.707
G1 X150.467 Y132.573
G1 X152.573 Y130.467 E.0574
G1 X152.707 Y130.334
G1 X152.707 Y129.776
G1 X152.573 Y129.91
G1 X149.91 Y132.573 E.0726
G1 X149.776 Y132.707
G1 X149.219 Y132.707
G1 X149.352 Y132.573
G1 X152.573 Y129.352 E.0878
G1 X152.707 Y129.219
G1 X152.707 Y128.661
G1 X152.573 Y128.795
G1 X148.795 Y132.573 E.103
G1 X148.661 Y132.707
G1 X148.104 Y132.707
G1 X148.237 Y132.573
G1 X152.573 Y128.237 E.1182
G1 X152.707 Y128.104
G1 X152.707 Y127.546
G1 X152.573 Y127.68
G1 X147.68 Y132.573 E.1334
G1 X147.546 Y132.707
G1 X146.989 Y132.707
G1 X147.122 Y132.573
G1 X152.573 Y127.122 E.14859
G1 X152.707 Y126.989
G1 X152.707 Y126.431
G1 X152.573 Y126.565
G1 X146.565 Y132.573 E.16379
G1 X146.431 Y132.707
G1 X145.873 Y132.707
G1 X146.007 Y132.573
G1 X152.573 Y126.007 E.17899
G1 X152.707 Y125.873
G1 X152.707 Y125.316
G1 X152.573 Y125.45
G1 X145.45 Y132.573 E.19419
G1 X145.316 Y132.707
G1 X144.758 Y132.707
G1 X144.892 Y132.573
G1 X152.573 Y124.892 E.20939
G1 X152.707 Y124.758
G1 X152.707 Y124.201
G1 X152.573 Y124.334
G1 X144.334 Y132.573 E.22459
G1 X144.201 Y132.707
G1 X143.643 Y132.707
G1 X143.777 Y132.573
G1 X152.573 Y123.777 E.23978
G1 X152.707 Y123.643
G1 X152.499 Y123.293
G1 X152.366 Y123.427
G1 X143.219 Y132.573 E.24933
G1 X143.086 Y132.707
G1 X142.528 Y132.707
G1 X142.662 Y132.573
G1 X151.808 Y123.427 E.24933
G1 X151.942 Y123.293
G1 X151.384 Y123.293
G1 X151.251 Y123.427
G1 X142.104 Y132.573 E.24933
G1 X141.971 Y132.707
G1 X141.413 Y132.707
G1 X141.547 Y132.573
G1 X150.693 Y123.427 E.24933
G1 X150.827 Y123.293
G1 X150.269 Y123.293
G1 X150.136 Y123.427
G1 X140.989 Y132.573 E.24933
G1 X140.856 Y132.707
G1 X140.298 Y132.707
G1 X140.432 Y132.573
G1 X149.578 Y123.427 E.24933
G1 X149.712 Y123.293
G1 X149.154 Y123.293
G1 X149.021 Y123.427
G1 X139.874 Y132.573 E.24933
G1 X139.741 Y132.707
G1 X139.183 Y132.707
G1 X139.317 Y132.573
G1 X148.463 Y123.427 E.24933
G1 X148.597 Y123.293
M73 P97 R0
G1 X148.039 Y123.293
G1 X147.905 Y123.427
G1 X138.759 Y132.573 E.24933
G1 X138.625 Y132.707
G1 X138.068 Y132.707
G1 X138.202 Y132.573
G1 X147.348 Y123.427 E.24933
G1 X147.482 Y123.293
G1 X146.924 Y123.293
G1 X146.79 Y123.427
G1 X137.644 Y132.573 E.24933
G1 X137.51 Y132.707
G1 X136.953 Y132.707
G1 X137.086 Y132.573
G1 X146.233 Y123.427 E.24933
G1 X146.366 Y123.293
G1 X145.809 Y123.293
G1 X145.675 Y123.427
G1 X136.529 Y132.573 E.24933
G1 X136.395 Y132.707
G1 X135.838 Y132.707
G1 X135.971 Y132.573
G1 X145.118 Y123.427 E.24933
G1 X145.251 Y123.293
G1 X144.694 Y123.293
G1 X144.56 Y123.427
G1 X135.414 Y132.573 E.24933
G1 X135.28 Y132.707
G1 X134.723 Y132.707
G1 X134.856 Y132.573
G1 X144.003 Y123.427 E.24933
G1 X144.136 Y123.293
G1 X143.579 Y123.293
G1 X143.445 Y123.427
G1 X134.299 Y132.573 E.24933
G1 X134.165 Y132.707
G1 X133.608 Y132.707
G1 X133.741 Y132.573
G1 X142.888 Y123.427 E.24933
G1 X143.021 Y123.293
G1 X142.464 Y123.293
G1 X142.33 Y123.427
G1 X133.184 Y132.573 E.24933
G1 X133.05 Y132.707
G1 X132.493 Y132.707
G1 X132.626 Y132.573
G1 X141.773 Y123.427 E.24933
G1 X141.906 Y123.293
G1 X141.349 Y123.293
G1 X141.215 Y123.427
G1 X132.069 Y132.573 E.24933
G1 X131.935 Y132.707
G1 X131.377 Y132.707
G1 X131.511 Y132.573
G1 X140.657 Y123.427 E.24933
G1 X140.791 Y123.293
G1 X140.234 Y123.293
G1 X140.1 Y123.427
G1 X130.954 Y132.573 E.24933
G1 X130.82 Y132.707
G1 X130.262 Y132.707
G1 X130.396 Y132.573
G1 X139.542 Y123.427 E.24933
G1 X139.676 Y123.293
G1 X139.118 Y123.293
G1 X138.985 Y123.427
G1 X129.838 Y132.573 E.24933
G1 X129.705 Y132.707
G1 X129.147 Y132.707
G1 X129.281 Y132.573
G1 X138.427 Y123.427 E.24933
G1 X138.561 Y123.293
G1 X138.003 Y123.293
G1 X137.87 Y123.427
G1 X128.723 Y132.573 E.24933
G1 X128.59 Y132.707
G1 X128.032 Y132.707
G1 X128.166 Y132.573
G1 X137.312 Y123.427 E.24933
G1 X137.446 Y123.293
G1 X136.888 Y123.293
G1 X136.755 Y123.427
G1 X127.608 Y132.573 E.24933
G1 X127.475 Y132.707
G1 X126.917 Y132.707
G1 X127.051 Y132.573
G1 X136.197 Y123.427 E.24933
G1 X136.331 Y123.293
G1 X135.773 Y123.293
G1 X135.64 Y123.427
G1 X126.493 Y132.573 E.24933
G1 X126.36 Y132.707
G1 X125.802 Y132.707
G1 X125.936 Y132.573
G1 X135.082 Y123.427 E.24933
G1 X135.216 Y123.293
G1 X134.658 Y123.293
G1 X134.524 Y123.427
G1 X125.378 Y132.573 E.24933
G1 X125.244 Y132.707
G1 X124.687 Y132.707
G1 X124.821 Y132.573
G1 X133.967 Y123.427 E.24933
G1 X134.101 Y123.293
G1 X133.543 Y123.293
G1 X133.409 Y123.427
G1 X124.263 Y132.573 E.24933
G1 X124.129 Y132.707
G1 X123.572 Y132.707
G1 X123.706 Y132.573
G1 X132.852 Y123.427 E.24933
G1 X132.986 Y123.293
G1 X132.428 Y123.293
G1 X132.294 Y123.427
G1 X123.148 Y132.573 E.24933
G1 X123.014 Y132.707
G1 X122.457 Y132.707
G1 X122.59 Y132.573
G1 X131.737 Y123.427 E.24933
G1 X131.87 Y123.293
G1 X131.313 Y123.293
G1 X131.179 Y123.427
G1 X122.033 Y132.573 E.24933
G1 X121.899 Y132.707
G1 X121.342 Y132.707
G1 X121.475 Y132.573
G1 X130.622 Y123.427 E.24933
G1 X130.755 Y123.293
G1 X130.198 Y123.293
G1 X130.064 Y123.427
G1 X120.918 Y132.573 E.24933
G1 X120.784 Y132.707
G1 X120.227 Y132.707
G1 X120.36 Y132.573
G1 X129.507 Y123.427 E.24933
G1 X129.64 Y123.293
G1 X129.083 Y123.293
G1 X128.949 Y123.427
G1 X119.803 Y132.573 E.24933
G1 X119.669 Y132.707
G1 X119.112 Y132.707
G1 X119.245 Y132.573
G1 X128.392 Y123.427 E.24933
G1 X128.525 Y123.293
G1 X127.968 Y123.293
G1 X127.834 Y123.427
G1 X118.688 Y132.573 E.24933
G1 X118.554 Y132.707
G1 X117.996 Y132.707
G1 X118.13 Y132.573
G1 X127.276 Y123.427 E.24933
G1 X127.41 Y123.293
G1 X126.853 Y123.293
G1 X126.719 Y123.427
G1 X117.573 Y132.573 E.24933
G1 X117.439 Y132.707
G1 X116.881 Y132.707
G1 X117.015 Y132.573
G1 X126.161 Y123.427 E.24933
G1 X126.295 Y123.293
G1 X125.737 Y123.293
G1 X125.604 Y123.427
G1 X116.458 Y132.573 E.24933
G1 X116.324 Y132.707
G1 X115.766 Y132.707
G1 X115.9 Y132.573
G1 X125.046 Y123.427 E.24933
G1 X125.18 Y123.293
G1 X124.622 Y123.293
G1 X124.489 Y123.427
G1 X115.342 Y132.573 E.24933
G1 X115.209 Y132.707
G1 X114.651 Y132.707
G1 X114.785 Y132.573
G1 X123.931 Y123.427 E.24933
G1 X124.065 Y123.293
G1 X123.507 Y123.293
G1 X123.374 Y123.427
G1 X114.227 Y132.573 E.24933
G1 X114.094 Y132.707
G1 X113.536 Y132.707
G1 X113.67 Y132.573
G1 X122.816 Y123.427 E.24933
G1 X122.95 Y123.293
M73 P98 R0
G1 X122.392 Y123.293
G1 X122.259 Y123.427
G1 X113.112 Y132.573 E.24933
G1 X112.979 Y132.707
G1 X112.421 Y132.707
G1 X112.555 Y132.573
G1 X121.701 Y123.427 E.24933
G1 X121.835 Y123.293
G1 X121.277 Y123.293
G1 X121.144 Y123.427
G1 X111.997 Y132.573 E.24933
G1 X111.864 Y132.707
G1 X111.306 Y132.707
G1 X111.44 Y132.573
G1 X120.586 Y123.427 E.24933
G1 X120.72 Y123.293
G1 X120.162 Y123.293
G1 X120.028 Y123.427
G1 X110.882 Y132.573 E.24933
G1 X110.748 Y132.707
G1 X110.191 Y132.707
G1 X110.325 Y132.573
G1 X119.471 Y123.427 E.24933
G1 X119.605 Y123.293
G1 X119.047 Y123.293
G1 X118.913 Y123.427
G1 X109.767 Y132.573 E.24933
G1 X109.633 Y132.707
G1 X109.076 Y132.707
G1 X109.209 Y132.573
G1 X118.356 Y123.427 E.24933
G1 X118.489 Y123.293
G1 X117.932 Y123.293
G1 X117.798 Y123.427
G1 X108.652 Y132.573 E.24933
G1 X108.518 Y132.707
G1 X107.961 Y132.707
G1 X108.094 Y132.573
G1 X117.241 Y123.427 E.24933
G1 X117.374 Y123.293
G1 X116.817 Y123.293
G1 X116.683 Y123.427
G1 X107.537 Y132.573 E.24933
G1 X107.403 Y132.707
G1 X106.846 Y132.707
G1 X106.979 Y132.573
G1 X116.126 Y123.427 E.24933
G1 X116.259 Y123.293
G1 X115.702 Y123.293
G1 X115.568 Y123.427
G1 X106.422 Y132.573 E.24933
G1 X106.288 Y132.707
G1 X105.731 Y132.707
G1 X105.864 Y132.573
G1 X115.011 Y123.427 E.24933
G1 X115.144 Y123.293
G1 X114.587 Y123.293
G1 X114.453 Y123.427
G1 X105.307 Y132.573 E.24933
G1 X105.173 Y132.707
G1 X104.616 Y132.707
G1 X104.749 Y132.573
G1 X113.896 Y123.427 E.24933
G1 X114.029 Y123.293
G1 X113.472 Y123.293
G1 X113.338 Y123.427
G1 X104.192 Y132.573 E.24933
G1 X104.058 Y132.707
G1 X103.5 Y132.707
G1 X103.634 Y132.573
G1 X112.78 Y123.427 E.24933
G1 X112.914 Y123.293
G1 X112.357 Y123.293
G1 X112.223 Y123.427
G1 X103.427 Y132.223 E.23978
G1 X103.293 Y132.357
G1 X103.293 Y131.799
G1 X103.427 Y131.665
G1 X111.665 Y123.427 E.22458
G1 X111.799 Y123.293
G1 X111.241 Y123.293
G1 X111.108 Y123.427
G1 X103.427 Y131.108 E.20938
G1 X103.293 Y131.241
G1 X103.293 Y130.684
G1 X103.427 Y130.55
G1 X110.55 Y123.427 E.19419
G1 X110.684 Y123.293
G1 X110.126 Y123.293
G1 X109.993 Y123.427
G1 X103.427 Y129.993 E.17899
G1 X103.293 Y130.126
G1 X103.293 Y129.569
G1 X103.427 Y129.435
G1 X109.435 Y123.427 E.16379
G1 X109.569 Y123.293
G1 X109.011 Y123.293
G1 X108.878 Y123.427
G1 X103.427 Y128.878 E.14859
G1 X103.293 Y129.011
G1 X103.293 Y128.454
G1 X103.427 Y128.32
G1 X108.32 Y123.427 E.13339
G1 X108.454 Y123.293
G1 X107.896 Y123.293
G1 X107.763 Y123.427
G1 X103.427 Y127.763 E.11819
G1 X103.293 Y127.896
G1 X103.293 Y127.339
G1 X103.427 Y127.205
G1 X107.205 Y123.427 E.10299
G1 X107.339 Y123.293
G1 X106.781 Y123.293
G1 X106.648 Y123.427
G1 X103.427 Y126.648 E.0878
G1 X103.293 Y126.781
G1 X103.293 Y126.224
G1 X103.427 Y126.09
M73 P99 R0
G1 X106.09 Y123.427 E.0726
G1 X106.224 Y123.293
G1 X105.666 Y123.293
G1 X105.532 Y123.427
G1 X103.427 Y125.532 E.0574
G1 X103.293 Y125.666
G1 X103.293 Y125.109
G1 X103.427 Y124.975
G1 X104.975 Y123.427 E.0422
G1 X105.109 Y123.293
G1 X104.551 Y123.293
G1 X104.417 Y123.427
G1 X103.427 Y124.417 E.027
G1 X103.293 Y124.551
G1 X103.293 Y123.993
G1 X103.427 Y123.86
G1 X103.86 Y123.427 E.0118
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9000
M204 S4000
G1 X103.427 Y123.86 E-.23269
G1 X103.293 Y123.993 E-.07182
G1 X103.293 Y124.551 E-.21187
G1 X103.427 Y124.417 E-.07182
G1 X103.747 Y124.098 E-.17181
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.4 I1.217 J0 P1  F60000
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
G1 Z8.4 F900 ; lower z a little
M1002 judge_flag timelapse_record_flag
M622 J1
    G150.3
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S5 ;wait for last picture to be taken
M623  ;end of "timelapse_record_flag"

G90
G1 Z18 F900 ; lower z a little

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

    
        G1 Z84 F600
        G1 Z82
    

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

