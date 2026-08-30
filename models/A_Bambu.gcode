; HEADER_BLOCK_START
; BambuStudio 02.08.02.60
; model printing time: 17m 37s; total estimated time: 22m 46s
; total layer number: 99
; total filament length [mm] : 1288.75
; total filament volume [cm^3] : 3099.81
; total filament weight [g] : 3.91
; filament_density: 1.26,1.26,1.26
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 11.96
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
M73 P0 R22
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
M73 P2 R22
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
    
      G29 A1 X113.722 Y111.067 I28.5558 J33.8668 R
    
    M400
  M623

  M622 J2
    M1002 gcode_claim_action : 1
    
      G29 A2 X113.722 Y111.067 I28.5558 J33.8668 R
    
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
M73 P3 R22
  G1 X128 Y128 F20000
M73 P22 R17
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
; OBJECT_ID: 218
G1 X123.017 Y125.904 F60000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X127.245 Y138.617 E.49902
G1 X128.552 Y138.617 E.04868
G1 X132.98 Y125.303 E.52262
G1 X122.817 Y125.303 E.37854
G1 X122.998 Y125.847 E.02137
M204 S6000
G1 X123.45 Y125.76 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X127.574 Y138.16 E.48674
G1 X128.222 Y138.16 E.02412
G1 X132.346 Y125.76 E.48674
G1 X123.51 Y125.76 E.3291
; WIPE_START
G1 X124.133 Y127.661 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X121.444 Y120.518 Z.6 F60000
G1 X119.296 Y114.812 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X121.668 Y121.897 E.2783
G1 X134.092 Y121.897 E.46275
G1 X136.615 Y114.21 E.30135
G1 X119.094 Y114.21 E.65258
G1 X119.277 Y114.755 E.02142
M204 S6000
G1 X119.729 Y114.667 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X121.997 Y121.44 E.26605
G1 X133.761 Y121.44 E.43816
G1 X135.984 Y114.667 E.26552
G1 X119.789 Y114.667 E.60319
; WIPE_START
G1 X120.409 Y116.568 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X127.995 Y115.724 Z.6 F60000
G1 X141.109 Y114.265 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X141.128 Y114.21 E.00218
G1 X141.421 Y114.21 E.01092
G1 X141.421 Y111.924 E.08514
G1 X114.579 Y111.924 E.99975
G1 X114.579 Y114.21 E.08514
G1 X114.623 Y114.21 E.00165
G1 X125.223 Y144.076 E1.18041
G1 X130.807 Y144.076 E.20799
G1 X141.089 Y114.321 E1.17255
M204 S6000
M73 P23 R17
G1 X141.453 Y114.667 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X141.878 Y114.667 E.01582
G1 X141.878 Y111.467 E.11919
G1 X114.122 Y111.467 E1.0338
G1 X114.122 Y114.667 E.11919
G1 X114.301 Y114.667 E.00665
G1 X124.901 Y144.533 E1.18041
G1 X131.133 Y144.533 E.23214
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

G1 X141.434 Y114.723 E1.17473
; WIPE_START
G1 X141.878 Y114.667 E-.17017
G1 X141.878 Y113.114 E-.58983
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X141.238 Y113.042 Z.6 F60000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50551
G1 F6300
M204 S500
G1 X140.508 Y112.312 E.03891
G1 X139.854 Y112.312 E.02466
G1 X141.032 Y113.491 E.06282
G1 X141.032 Y113.821 E.01245
G1 X140.851 Y113.821 E.00684
G1 X140.814 Y113.927 E.00422
G1 X139.2 Y112.312 E.08608
G1 X138.545 Y112.312 E.02466
G1 X140.646 Y114.413 E.11199
G1 X140.478 Y114.899 E.01939
G1 X137.891 Y112.312 E.13791
G1 X137.237 Y112.312 E.02466
G1 X140.31 Y115.385 E.16383
G1 X140.142 Y115.872 E.01939
G1 X136.583 Y112.312 E.18975
G1 X135.929 Y112.312 E.02466
G1 X139.974 Y116.358 E.21567
G1 X139.806 Y116.844 E.01939
G1 X135.274 Y112.312 E.24159
G1 X134.62 Y112.312 E.02466
G1 X136.129 Y113.821 E.08044
G1 X135.475 Y113.821 E.02466
G1 X133.966 Y112.312 E.08044
G1 X133.312 Y112.312 E.02466
G1 X134.821 Y113.821 E.08044
G1 X134.166 Y113.821 E.02466
G1 X132.658 Y112.312 E.08044
G1 X132.003 Y112.312 E.02466
G1 X133.512 Y113.821 E.08044
G1 X132.858 Y113.821 E.02466
G1 X131.349 Y112.312 E.08044
G1 X130.695 Y112.312 E.02466
G1 X132.204 Y113.821 E.08044
G1 X131.55 Y113.821 E.02466
G1 X130.041 Y112.312 E.08044
G1 X129.387 Y112.312 E.02466
G1 X130.895 Y113.821 E.08044
G1 X130.241 Y113.821 E.02466
G1 X128.732 Y112.312 E.08044
G1 X128.078 Y112.312 E.02466
G1 X129.587 Y113.821 E.08044
G1 X128.933 Y113.821 E.02466
G1 X127.424 Y112.312 E.08043
G1 X126.77 Y112.312 E.02466
G1 X128.279 Y113.821 E.08043
G1 X127.624 Y113.821 E.02466
G1 X126.116 Y112.312 E.08043
G1 X125.461 Y112.312 E.02466
G1 X126.97 Y113.821 E.08043
G1 X126.316 Y113.821 E.02466
G1 X124.807 Y112.312 E.08043
G1 X124.153 Y112.312 E.02466
G1 X125.662 Y113.821 E.08043
G1 X125.008 Y113.821 E.02466
G1 X123.499 Y112.312 E.08043
G1 X122.845 Y112.312 E.02466
G1 X124.353 Y113.821 E.08043
G1 X123.699 Y113.821 E.02466
G1 X122.19 Y112.312 E.08043
G1 X121.536 Y112.312 E.02466
G1 X123.045 Y113.821 E.08043
G1 X122.391 Y113.821 E.02466
G1 X120.882 Y112.312 E.08043
G1 X120.228 Y112.312 E.02466
G1 X121.737 Y113.821 E.08043
G1 X121.082 Y113.821 E.02466
G1 X119.574 Y112.312 E.08043
G1 X118.919 Y112.312 E.02466
G1 X120.428 Y113.821 E.08043
G1 X119.774 Y113.821 E.02466
G1 X118.265 Y112.312 E.08043
G1 X117.611 Y112.312 E.02466
G1 X119.12 Y113.821 E.08043
G1 X118.554 Y113.821 E.02132
G1 X118.599 Y113.954 E.0053
G1 X116.957 Y112.312 E.08754
G1 X116.303 Y112.312 E.02466
G1 X118.928 Y114.938 E.13997
G1 X119.258 Y115.921 E.0391
G1 X115.648 Y112.312 E.1924
G1 X114.994 Y112.312 E.02466
G1 X119.587 Y116.905 E.24483
G1 X119.916 Y117.888 E.0391
G1 X114.968 Y112.94 E.2638
G1 X114.968 Y113.594 E.02466
G1 X120.245 Y118.872 E.28135
G1 X120.575 Y119.855 E.0391
G1 X115.094 Y114.375 E.29215
G1 X115.454 Y115.389 E.04056
G1 X121.23 Y121.165 E.30791
; WIPE_START
G1 X119.816 Y119.751 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X127.096 Y117.46 Z.6 F60000
G1 X136.736 Y114.428 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X139.638 Y117.33 E.15474
G1 X139.47 Y117.816 E.01939
G1 X136.737 Y115.083 E.14571
G1 X136.575 Y115.576 E.01954
G1 X139.302 Y118.303 E.14537
G1 X139.134 Y118.789 E.01939
G1 X136.414 Y116.068 E.14503
G1 X136.252 Y116.561 E.01954
G1 X138.966 Y119.275 E.14469
G1 X138.798 Y119.761 E.01939
G1 X136.09 Y117.053 E.14435
G1 X135.929 Y117.546 E.01954
G1 X138.63 Y120.247 E.14401
G1 X138.462 Y120.734 E.01939
G1 X135.767 Y118.039 E.14367
G1 X135.606 Y118.531 E.01954
G1 X138.294 Y121.22 E.14333
G1 X138.126 Y121.706 E.01939
G1 X135.444 Y119.024 E.14299
G1 X135.282 Y119.516 E.01954
M73 P24 R17
G1 X137.958 Y122.192 E.14266
G1 X137.79 Y122.678 E.01939
G1 X135.121 Y120.009 E.14232
G1 X134.959 Y120.501 E.01954
G1 X137.622 Y123.165 E.14198
G1 X137.454 Y123.651 E.01939
G1 X134.797 Y120.994 E.14164
G1 X134.636 Y121.486 E.01954
G1 X137.286 Y124.137 E.1413
G1 X137.118 Y124.623 E.01939
G1 X134.474 Y121.979 E.14096
G1 X134.373 Y122.286 E.01216
G1 X134.126 Y122.286 E.00931
G1 X136.95 Y125.109 E.15054
G1 X136.782 Y125.596 E.01939
G1 X133.472 Y122.286 E.17645
G1 X132.818 Y122.286 E.02466
G1 X136.614 Y126.082 E.20237
G1 X136.446 Y126.568 E.01939
G1 X132.164 Y122.286 E.22829
G1 X131.51 Y122.286 E.02466
G1 X136.278 Y127.054 E.25421
G1 X136.11 Y127.54 E.01939
G1 X130.855 Y122.286 E.28013
G1 X130.201 Y122.286 E.02466
G1 X132.83 Y124.914 E.14014
G1 X132.176 Y124.914 E.02466
G1 X129.547 Y122.286 E.14014
G1 X128.893 Y122.286 E.02466
G1 X131.522 Y124.914 E.14014
G1 X130.867 Y124.914 E.02466
G1 X128.239 Y122.286 E.14014
G1 X127.584 Y122.286 E.02466
G1 X130.213 Y124.914 E.14014
G1 X129.559 Y124.914 E.02466
G1 X126.93 Y122.286 E.14014
G1 X126.276 Y122.286 E.02466
G1 X128.905 Y124.914 E.14014
G1 X128.251 Y124.914 E.02466
G1 X125.622 Y122.286 E.14014
G1 X124.968 Y122.286 E.02466
G1 X127.596 Y124.914 E.14014
G1 X126.942 Y124.914 E.02466
G1 X124.313 Y122.286 E.14014
G1 X123.659 Y122.286 E.02466
G1 X126.288 Y124.914 E.14014
G1 X125.634 Y124.914 E.02466
G1 X123.005 Y122.286 E.14014
G1 X122.351 Y122.286 E.02466
G1 X124.98 Y124.914 E.14014
G1 X124.325 Y124.914 E.02466
G1 X115.814 Y116.403 E.45373
G1 X116.174 Y117.417 E.04056
G1 X123.671 Y124.914 E.39967
G1 X123.017 Y124.914 E.02466
G1 X116.534 Y118.431 E.34561
G1 X116.894 Y119.445 E.04056
G1 X122.363 Y124.914 E.29154
G1 X122.278 Y124.914 E.0032
G1 X122.562 Y125.767 E.03389
G1 X117.254 Y120.46 E.28296
G1 X117.614 Y121.474 E.04056
G1 X122.888 Y126.748 E.28115
G1 X123.214 Y127.728 E.03894
G1 X117.974 Y122.488 E.27934
G1 X118.334 Y123.502 E.04056
G1 X123.54 Y128.708 E.27753
G1 X123.866 Y129.688 E.03894
G1 X118.693 Y124.516 E.27572
G1 X119.053 Y125.53 E.04056
G1 X124.192 Y130.668 E.27392
G1 X124.518 Y131.649 E.03894
G1 X119.413 Y126.544 E.27211
G1 X119.773 Y127.558 E.04056
G1 X124.844 Y132.629 E.2703
G1 X125.17 Y133.609 E.03894
G1 X120.133 Y128.573 E.26849
G1 X120.493 Y129.587 E.04056
G1 X125.496 Y134.589 E.26668
G1 X125.822 Y135.569 E.03894
G1 X120.853 Y130.601 E.26487
G1 X121.213 Y131.615 E.04056
G1 X126.148 Y136.55 E.26306
G1 X126.474 Y137.53 E.03894
G1 X121.235 Y132.291 E.27929
; WIPE_START
G1 X122.649 Y133.705 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X129.711 Y130.81 Z.6 F60000
G1 X136.104 Y128.188 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X133.347 Y125.431 E.14699
G1 X133.183 Y125.922 E.0195
G1 X135.774 Y128.513 E.13812
G1 X135.606 Y128.999 E.01939
G1 X133.02 Y126.413 E.13787
G1 X132.857 Y126.904 E.0195
G1 X135.438 Y129.485 E.13762
G1 X135.27 Y129.971 E.01939
G1 X132.694 Y127.395 E.13736
G1 X132.53 Y127.886 E.0195
G1 X135.102 Y130.458 E.13711
G1 X134.934 Y130.944 E.01939
G1 X132.367 Y128.377 E.13686
G1 X132.204 Y128.867 E.0195
G1 X134.766 Y131.43 E.13661
G1 X134.598 Y131.916 E.01939
G1 X132.04 Y129.358 E.13635
G1 X131.877 Y129.849 E.0195
G1 X134.43 Y132.402 E.1361
G1 X134.262 Y132.889 E.01939
G1 X131.714 Y130.34 E.13585
G1 X131.551 Y130.831 E.0195
G1 X134.094 Y133.375 E.1356
G1 X133.926 Y133.861 E.01939
G1 X131.387 Y131.322 E.13534
G1 X131.224 Y131.813 E.0195
G1 X133.758 Y134.347 E.13509
G1 X133.59 Y134.833 E.01939
G1 X131.061 Y132.304 E.13484
G1 X130.898 Y132.795 E.0195
G1 X133.422 Y135.32 E.13459
G1 X133.254 Y135.806 E.01939
G1 X130.734 Y133.286 E.13433
G1 X130.571 Y133.777 E.0195
G1 X133.086 Y136.292 E.13408
G1 X132.918 Y136.778 E.01939
G1 X130.408 Y134.268 E.13383
G1 X130.245 Y134.759 E.0195
G1 X132.75 Y137.264 E.13358
G1 X132.582 Y137.751 E.01939
G1 X130.081 Y135.25 E.13332
G1 X129.918 Y135.741 E.0195
G1 X132.414 Y138.237 E.13307
G1 X132.246 Y138.723 E.01939
M73 P25 R17
G1 X129.755 Y136.231 E.13282
G1 X129.591 Y136.722 E.0195
G1 X132.078 Y139.209 E.13257
G1 X131.91 Y139.695 E.01939
G1 X129.428 Y137.213 E.13231
G1 X129.265 Y137.704 E.0195
G1 X131.742 Y140.182 E.13206
G1 X131.574 Y140.668 E.01939
G1 X129.102 Y138.195 E.13181
G1 X128.938 Y138.686 E.0195
G1 X131.406 Y141.154 E.13156
G1 X131.238 Y141.64 E.01939
G1 X128.604 Y139.006 E.14043
G1 X127.95 Y139.006 E.02466
G1 X131.07 Y142.126 E.16635
G1 X130.902 Y142.613 E.01939
G1 X121.933 Y133.643 E.47815
G1 X122.293 Y134.657 E.04056
G1 X130.734 Y143.099 E.45001
G1 X130.566 Y143.585 E.01939
G1 X122.653 Y135.671 E.42187
G1 X123.013 Y136.686 E.04056
G1 X130.015 Y143.688 E.37329
G1 X129.361 Y143.688 E.02466
G1 X123.372 Y137.7 E.31922
G1 X123.732 Y138.714 E.04056
G1 X128.706 Y143.688 E.26516
G1 X128.052 Y143.688 E.02466
G1 X124.092 Y139.728 E.2111
G1 X124.452 Y140.742 E.04056
G1 X127.398 Y143.688 E.15704
G1 X126.744 Y143.688 E.02466
G1 X124.812 Y141.756 E.10298
G1 X125.172 Y142.77 E.04056
G1 X126.295 Y143.894 E.05988
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6300
G1 X125.172 Y142.77 E-.60363
G1 X125.034 Y142.382 E-.15637
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
; OBJECT_ID: 218
M204 S10000
G17
G3 Z.6 I1.21 J-.127 P1  F60000
G1 X123.325 Y126.079 Z.6
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P25 R16
G1 X121.732 Y120.698 Z.72 F60000
G1 X119.605 Y114.987 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z.72 F60000
G1 X141.28 Y114.497 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z.72 F60000
G1 X117.069 Y114.752 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506712
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.839 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.451 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.49307
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451825
G1 X130.222 Y139.153 E.14559
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421212
G1 X129.846 Y139.785 E.00795
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363552
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410072
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455639
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434957
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.464887
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456592
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410072
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366153
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420583
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-255.938 J-89.602 E.06213
; LINE_WIDTH: 0.452405
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.49307
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
M73 P26 R16
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.213 J-13.875 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.572 J-200.681 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L3
M991 S0 P2 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.72 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z.72
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z.84 F60000
G1 X119.605 Y114.987 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z.84 F60000
G1 X141.28 Y114.497 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z.84 F60000
G1 X117.069 Y114.752 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506702
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.839 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.451 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
M73 P27 R16
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.49307
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451825
G1 X130.222 Y139.153 E.14559
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421212
G1 X129.846 Y139.785 E.00795
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363551
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410067
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455631
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434955
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.46488
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456584
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410067
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366152
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420583
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-255.938 J-89.602 E.06213
; LINE_WIDTH: 0.452405
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.49307
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.214 J-13.881 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.572 J-200.681 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L4
M991 S0 P3 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.84 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z.84
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z.96 F60000
G1 X119.605 Y114.987 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z.96 F60000
G1 X141.28 Y114.497 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z.96 F60000
G1 X117.069 Y114.752 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506702
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.84 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
M73 P28 R16
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.45 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.493067
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451817
G1 X130.222 Y139.153 E.14558
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421211
G1 X129.846 Y139.785 E.00796
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363551
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410067
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455631
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434955
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.46488
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456584
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410067
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366152
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420582
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-254.477 J-89.1 E.06213
; LINE_WIDTH: 0.452397
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.493067
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.214 J-13.881 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.57 J-201.139 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L5
M991 S0 P4 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z.96 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z.96
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.08 F60000
G1 X119.605 Y114.987 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.08 F60000
G1 X141.28 Y114.497 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z1.08 F60000
G1 X117.069 Y114.752 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
M73 P29 R16
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506702
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.839 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.451 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.493067
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451817
G1 X130.222 Y139.153 E.14558
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421212
G1 X129.846 Y139.785 E.00795
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363551
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410067
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455631
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434955
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.46488
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456584
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410067
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366152
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420583
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-254.939 J-89.259 E.06213
; LINE_WIDTH: 0.452397
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.493067
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.214 J-13.881 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.57 J-201.14 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L6
M991 S0 P5 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.08 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z1.08
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.2 F60000
G1 X119.605 Y114.987 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
M73 P29 R15
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.2 F60000
G1 X141.28 Y114.497 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P30 R15
G1 X140.528 Y115.561 Z1.2 F60000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.039 Y114.084 E.0324
G1 X141.173 Y114.084 E.0028
G3 X141.296 Y113.669 I.354 J-.122 E.00958
G1 X141.296 Y112.049 E.03361
G1 X140.136 Y112.049 E.02407
G3 X140.331 Y112.979 I-1.592 J.819 E.01995
G1 X140.051 Y113.434 E.01109
G2 X138.147 Y114.799 I2.834 J5.962 E.04886
G2 X137.519 Y116.62 I3.318 J2.162 E.04035
G1 X137.799 Y117.075 E.01109
G3 X139.578 Y118.31 I-2.938 J6.133 E.04512
G1 X138.348 Y121.871 E.07815
G2 X137.549 Y123.448 I2.344 J2.178 E.03715
G1 X137.519 Y123.903 E.00946
G1 X137.6 Y124.035 E.00322
G1 X135.221 Y130.92 E.15108
G3 X133.877 Y128.455 I1.693 J-2.522 E.06053
G1 X134.157 Y128 E.01109
G2 X136.061 Y126.635 I-2.834 J-5.962 E.04886
G2 X136.689 Y124.814 I-3.318 J-2.162 E.04035
G1 X136.409 Y124.359 E.01109
G3 X134.505 Y122.993 I2.834 J-5.962 E.04886
G3 X134.045 Y122.022 I1.954 J-1.521 E.02247
G1 X134.183 Y122.022 E.00286
G1 X134.717 Y120.394 E.03555
G2 X136.061 Y119.351 I-2.572 J-4.706 E.03544
G2 X136.689 Y117.531 I-3.318 J-2.162 E.04035
G2 X135.902 Y116.782 I-1.086 J.354 E.02347
G1 X136.431 Y115.17 E.0352
M204 S10000
G1 X137.771 Y112.049 F60000
G1 F9000
M204 S4000
G1 X136.061 Y112.068 E.03545
G3 X134.157 Y113.434 I-4.738 J-4.596 E.04886
G1 X133.877 Y113.889 E.01109
G1 X133.89 Y114.084 E.00406
G1 X131.687 Y114.084 E.04571
G3 X132.768 Y113.434 I5.597 J8.075 E.02619
G1 X133.048 Y112.979 E.01109
G2 X132.852 Y112.049 I-1.787 J-.11 E.01995
G1 X128.778 Y112.068 E.08451
G3 X126.874 Y113.434 I-4.738 J-4.596 E.04886
G1 X126.594 Y113.889 E.01109
G1 X126.607 Y114.084 E.00406
G1 X124.403 Y114.084 E.04571
G3 X125.484 Y113.434 I5.598 J8.078 E.02619
G1 X125.764 Y112.979 E.01109
G2 X125.569 Y112.049 I-1.787 J-.11 E.01995
G1 X123.872 Y112.049 E.0352
; WIPE_START
G1 X125.569 Y112.049 E-.64486
G1 X125.669 Y112.335 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.298 Y119.5 Z1.2 F60000
G1 X129.224 Y122.022 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.921 Y122.022 E.0352
G2 X130.266 Y123.448 I2.851 J2.173 E.03282
G1 X130.236 Y123.903 E.00946
G1 X130.516 Y124.359 E.01109
G3 X131.85 Y125.178 I-5.701 J10.777 E.03249
G1 X129.382 Y125.178 E.05119
G1 X129.406 Y124.814 E.00757
G1 X129.126 Y124.359 E.01109
G3 X127.222 Y122.993 I2.834 J-5.962 E.04886
G3 X126.761 Y122.022 I1.954 J-1.521 E.02247
G1 X123.638 Y122.022 E.06479
G2 X122.983 Y123.448 I2.851 J2.173 E.03282
G1 X122.953 Y123.903 E.00946
G1 X123.233 Y124.359 E.01109
G3 X124.567 Y125.178 I-5.701 J10.777 E.03249
G1 X122.643 Y125.178 E.03989
G1 X123.918 Y129.011 E.08379
G2 X122.983 Y130.731 I2.256 J2.341 E.04126
G1 X122.953 Y131.186 E.00946
G1 X123.233 Y131.642 E.01109
G3 X125.137 Y133.007 I-2.834 J5.962 E.04886
G1 X125.376 Y133.395 E.00945
G1 X125.742 Y134.497 E.02408
G1 X125.764 Y134.828 E.00689
G1 X125.484 Y135.283 E.01109
G2 X123.58 Y136.649 I2.834 J5.962 E.04886
G2 X123.093 Y137.699 I2.118 J1.622 E.0242
G1 X123.604 Y139.139 E.03171
G3 X125.137 Y140.29 I-2.61 J5.072 E.03995
G3 X125.764 Y142.111 I-3.318 J2.162 E.04035
G1 X125.484 Y142.566 E.01109
G1 X124.933 Y142.885 E.0132
G1 X125.312 Y143.951 E.02347
G1 X126.789 Y143.951 E.03065
G3 X126.594 Y143.022 I1.592 J-.819 E.01994
G1 X126.874 Y142.566 E.01109
G2 X128.778 Y141.201 I-2.834 J-5.962 E.04886
G2 X129.406 Y139.38 I-3.318 J-2.162 E.04035
G2 X128.669 Y138.661 I-1.034 J.322 E.02226
G1 X129.205 Y137.051 E.0352
M204 S10000
G1 X132.654 Y138.35 F60000
G1 F9000
M204 S4000
G1 X132.1 Y139.954 E.0352
G2 X130.516 Y138.925 I-5.562 J6.825 E.03926
G1 X130.236 Y138.47 E.01109
G1 X130.266 Y138.014 E.00946
G3 X131.98 Y135.738 I3.14 J.581 E.06126
G1 X132.768 Y135.283 E.01887
G1 X133.048 Y134.828 E.01109
G1 X133.017 Y134.373 E.00946
G2 X131.304 Y132.097 I-3.14 J.581 E.06126
G1 X130.925 Y131.878 E.00907
G1 X132.083 Y128.396 E.07612
G1 X132.768 Y128 E.0164
G1 X133.048 Y127.545 E.01109
G2 X132.762 Y126.354 I-2.306 J-.076 E.0257
G1 X133.153 Y125.178 E.02572
G1 X132.696 Y125.178 E.00948
; WIPE_START
G1 X133.153 Y125.178 E-.17373
G1 X132.762 Y126.354 E-.47113
G1 X132.861 Y126.641 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.93 Y131.444 Z1.2 F60000
G1 X122.225 Y135.254 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X121.657 Y133.655 E.0352
G1 X122.093 Y132.552 E.02459
G1 X122.123 Y132.097 E.00946
G1 X121.843 Y131.642 E.01109
G3 X120.696 Y130.947 I4.822 J-9.256 E.02782
G1 X119.64 Y127.972 E.0655
G1 X120.379 Y127.545 E.01769
G2 X122.093 Y125.269 I-1.427 J-2.857 E.06126
G1 X122.123 Y124.814 E.00946
G1 X121.843 Y124.359 E.01109
G1 X121.055 Y123.903 E.01887
G3 X119.341 Y121.627 I1.427 J-2.857 E.06126
G1 X119.311 Y121.172 E.00946
G1 X119.591 Y120.717 E.01109
G2 X120.877 Y119.929 I-5.475 J-10.387 E.03131
G1 X118.92 Y114.084 E.12785
G1 X119.324 Y114.084 E.00837
G1 X119.311 Y113.889 E.00406
G1 X119.591 Y113.434 E.01109
G1 X120.379 Y112.979 E.01887
G2 X121.507 Y112.049 I-2.075 J-3.667 E.03048
G1 X118.286 Y112.049 E.06681
G3 X118.481 Y112.979 I-1.592 J.819 E.01995
G1 X118.201 Y113.434 E.01109
G1 X117.413 Y113.889 E.01887
G2 X115.7 Y116.165 I1.427 J2.857 E.06126
G1 X115.669 Y116.62 E.00946
G1 X115.95 Y117.075 E.01109
G1 X116.737 Y117.531 E.01887
G3 X118.451 Y119.807 I-1.427 J2.857 E.06126
G1 X118.481 Y120.262 E.00946
G1 X118.201 Y120.717 E.01109
G2 X117.263 Y121.273 I3.848 J7.57 E.02264
G1 X117.83 Y122.872 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X117.263 Y121.273 E-.64486
G1 X117.524 Y121.118 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L7
M991 S0 P6 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.2 I-.791 J.925 P1  F60000
G1 X123.325 Y126.079 Z1.2
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.32 F60000
G1 X119.605 Y114.987 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.32 F60000
G1 X141.28 Y114.497 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.131 Y116.711 Z1.32 F60000
G1 Z.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.577 Y118.315 E.0352
G2 X138.014 Y117.392 I-2.553 J2.537 E.03805
G2 X137.104 Y117.286 I-.586 J1.071 E.01949
G1 X136.649 Y118.391 E.02479
G3 X134.773 Y120.224 I-2.901 J-1.092 E.05618
G1 X134.183 Y122.022 E.03925
G1 X133.913 Y122.022 E.00559
G2 X136.194 Y124.042 I3.194 J-1.308 E.06544
G2 X137.104 Y124.148 I.586 J-1.071 E.01949
G3 X138.345 Y121.88 I5.912 J1.761 E.05402
G1 X138.899 Y120.276 E.0352
M204 S10000
G1 X137.935 Y123.067 F60000
G1 F9000
M204 S4000
G1 X137.425 Y124.543 E.0324
G1 X137.104 Y124.569 E.00667
G1 X136.649 Y125.674 E.02479
G3 X134.373 Y127.684 I-3.21 J-1.342 E.06517
G3 X133.462 Y127.79 I-.586 J-1.071 E.01949
G2 X132.784 Y126.287 I-6.56 J2.056 E.03428
G1 X132.033 Y128.545 E.04937
G3 X133.462 Y128.211 I1.201 J1.907 E.03102
G1 X133.918 Y129.316 E.02479
G2 X135.232 Y130.889 I3.131 J-1.281 E.0432
G1 X135.786 Y129.285 E.0352
M204 S10000
G1 X133.048 Y125.494 F60000
G1 F9000
M204 S4000
G1 X133.153 Y125.178 E.00691
G1 X131.789 Y125.178 E.02829
G2 X130.276 Y124.532 I-3.857 J6.943 E.03419
G1 X129.821 Y124.569 E.00947
G1 X129.57 Y125.178 E.01366
G1 X124.506 Y125.178 E.10504
G2 X122.993 Y124.532 I-3.857 J6.942 E.03419
G1 X122.538 Y124.569 E.00947
G3 X121.627 Y126.486 I-8.391 J-2.81 E.04413
G3 X119.565 Y127.759 I-3.265 J-2.983 E.05092
G1 X117.287 Y121.342 E.14126
G3 X118.896 Y120.927 I1.393 J2.08 E.03513
G2 X119.807 Y122.845 I8.391 J-2.81 E.04413
G2 X121.627 Y124.042 I2.867 J-2.377 E.04587
G2 X122.538 Y124.148 I.586 J-1.071 E.01949
G3 X123.645 Y122.022 I6.404 J1.983 E.04999
G1 X126.63 Y122.022 E.06192
G2 X128.91 Y124.042 I3.194 J-1.308 E.06544
G2 X129.821 Y124.148 I.586 J-1.071 E.01949
G3 X130.928 Y122.022 I6.404 J1.983 E.04999
G1 X129.231 Y122.022 E.0352
; WIPE_START
G1 X130.928 Y122.022 E-.64486
G1 X130.731 Y122.231 E-.10897
G1 X130.723 Y122.245 E-.00617
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.481 Y126.637 Z1.32 F60000
G1 X123.385 Y127.409 Z1.32
G1 Z.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.921 Y129.019 E.0352
G2 X122.993 Y130.326 I2.873 J3.022 E.03346
G1 X122.538 Y131.431 E.02479
G3 X121.627 Y131.325 I-.324 J-1.177 E.01949
G1 X120.679 Y130.898 E.02158
G1 X121.671 Y133.692 E.06151
G2 X122.538 Y131.852 I-7.183 J-4.509 E.04229
G3 X123.448 Y131.958 I.324 J1.177 E.01949
G3 X125.337 Y133.277 I-.932 J3.348 E.04869
G1 X126.071 Y135.485 E.04828
G2 X125.269 Y135.6 I-.26 J1.048 E.01723
G2 X123.034 Y137.535 I.92 J3.32 E.06337
G1 X123.676 Y139.342 E.03976
G3 X125.724 Y141.251 I-.944 J3.067 E.0601
G1 X126.179 Y142.356 E.02479
G2 X127.09 Y142.25 I.324 J-1.177 E.01949
G2 X129.366 Y140.241 I-.934 J-3.352 E.06517
G1 X129.821 Y139.135 E.02479
G3 X130.731 Y139.241 I.324 J1.177 E.01949
G3 X132.098 Y139.957 I-1.715 J4.938 E.03213
G1 X130.718 Y143.951 E.08765
G1 X126.695 Y143.951 E.08345
G1 X126.179 Y142.777 E.02661
G2 X124.978 Y143.011 I-.244 J1.948 E.02582
G1 X124.41 Y141.412 E.0352
; WIPE_START
G1 X124.978 Y143.011 E-.64486
G1 X125.263 Y142.908 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.251 Y136.912 Z1.32 F60000
G1 Z.92
G1 E.8 F1800
G1 F9000
M204 S4000
M73 P31 R15
G1 X128.715 Y138.522 E.0352
G2 X129.821 Y138.714 I.857 J-1.654 E.02364
G1 X130.276 Y137.609 E.02479
G3 X132.552 Y135.6 I3.21 J1.342 E.06517
G3 X133.462 Y135.494 I.586 J1.071 E.01949
G1 X133.559 Y135.729 E.00528
G1 X133.777 Y135.098 E.01385
G1 X133.462 Y135.073 E.00656
G1 X133.007 Y133.968 E.02479
G2 X130.877 Y132.022 I-3.071 J1.225 E.06192
G1 X130.341 Y133.633 E.0352
; WIPE_START
G1 X130.877 Y132.022 E-.64486
G1 X131.154 Y132.145 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.455 Y126.13 Z1.32 F60000
G1 X120.328 Y118.287 Z1.32
G1 Z.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.866 Y119.896 E.0352
G3 X119.807 Y120.4 I-1.863 J-2.55 E.02448
G3 X118.896 Y120.507 I-.586 J-1.071 E.01949
G1 X118.441 Y119.401 E.02479
G2 X117.531 Y118.106 I-3.047 J1.174 E.03317
G2 X115.85 Y117.293 I-3.671 J5.444 E.03885
G1 X115.493 Y116.286 E.02217
G1 X115.71 Y115.76 E.01181
G3 X117.986 Y113.75 I3.21 J1.343 E.06517
G3 X118.896 Y113.644 I.586 J1.071 E.01949
G1 X119.077 Y114.084 E.00987
G1 X124.511 Y114.084 E.11271
G1 X125.269 Y113.75 E.01718
G3 X126.179 Y113.644 I.586 J1.071 E.01949
G1 X126.361 Y114.084 E.00987
G1 X131.794 Y114.084 E.11271
G1 X132.552 Y113.75 E.01718
G3 X133.462 Y113.644 I.586 J1.071 E.01949
G1 X133.644 Y114.084 E.00987
G1 X136.787 Y114.084 E.06521
G1 X135.946 Y116.65 E.056
G2 X137.104 Y116.865 I.912 J-1.684 E.02484
G1 X137.559 Y115.76 E.02479
G3 X139.835 Y113.75 I3.21 J1.343 E.06517
G3 X140.746 Y113.644 I.586 J1.071 E.01949
G1 X140.988 Y114.232 E.01318
G1 X141.039 Y114.084 E.00324
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y113.23 E.01772
G3 X140.746 Y113.223 I-.266 J-.683 E.0117
G2 X140.251 Y112.049 I-5.11 J1.458 E.0265
G1 X136.072 Y112.049 E.08668
G3 X134.373 Y113.117 I-2.692 J-2.395 E.0422
G3 X133.462 Y113.223 I-.586 J-1.071 E.01949
G2 X132.968 Y112.049 I-5.11 J1.458 E.0265
G1 X128.789 Y112.049 E.08668
G3 X127.09 Y113.117 I-2.692 J-2.395 E.0422
G3 X126.179 Y113.223 I-.586 J-1.071 E.01949
G2 X125.685 Y112.049 I-5.11 J1.458 E.0265
G1 X121.506 Y112.049 E.08668
G3 X119.807 Y113.117 I-2.692 J-2.395 E.0422
G3 X118.896 Y113.223 I-.586 J-1.071 E.01949
G2 X118.402 Y112.049 I-5.11 J1.458 E.0265
G1 X116.705 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X118.402 Y112.049 E-.64486
G1 X118.52 Y112.328 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L8
M991 S0 P7 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.32 I-1.149 J.402 P1  F60000
G1 X123.325 Y126.079 Z1.32
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.44 F60000
G1 X119.605 Y114.987 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.44 F60000
G1 X141.28 Y114.497 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.134 Y116.702 Z1.44 F60000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.58 Y118.306 E.0352
G2 X138.014 Y117.543 I-2.106 J2.333 E.0366
G1 X137.559 Y117.529 E.00945
G1 X137.104 Y117.825 E.01126
G1 X136.649 Y118.585 E.01838
G3 X134.812 Y120.104 I-2.643 J-1.327 E.05088
G1 X134.183 Y122.022 E.04188
G1 X133.795 Y122.022 E.00804
G2 X136.194 Y123.891 I3.036 J-1.424 E.06545
G1 X136.649 Y123.905 E.00945
G1 X137.104 Y123.609 E.01126
G3 X138.346 Y121.876 I6.044 J3.021 E.04441
G1 X138.9 Y120.272 E.0352
M204 S10000
G1 X137.82 Y123.399 F60000
G1 F9000
M204 S4000
G1 X137.266 Y125.003 E.0352
G1 X137.104 Y125.108 E.004
G3 X135.738 Y126.956 I-5.897 J-2.929 E.04791
G3 X133.918 Y127.546 I-2.025 J-3.145 E.04015
G1 X133.462 Y127.251 E.01126
G2 X132.811 Y126.205 I-8.757 J4.728 E.02556
G1 X133.153 Y125.178 E.02246
G1 X131.725 Y125.178 E.02962
G1 X130.731 Y124.826 E.02186
G1 X130.276 Y124.813 E.00945
G1 X129.779 Y125.178 E.01279
G1 X124.442 Y125.178 E.11071
G1 X123.448 Y124.826 E.02186
G1 X122.993 Y124.813 E.00945
G1 X122.538 Y125.108 E.01126
G3 X121.172 Y126.956 I-5.897 J-2.93 E.04791
G3 X119.488 Y127.542 I-2.076 J-3.253 E.03733
G1 X117.311 Y121.408 E.13501
G3 X118.441 Y121.171 I.964 J1.781 E.02429
G1 X118.896 Y121.467 E.01126
G2 X120.262 Y123.314 I5.897 J-2.93 E.04791
G2 X122.083 Y123.905 I2.025 J-3.145 E.04015
G1 X122.538 Y123.609 E.01126
G3 X123.624 Y122.022 I6.903 J3.559 E.03999
G1 X126.512 Y122.022 E.05991
G2 X127.545 Y123.314 I4.63 J-2.641 E.03446
G2 X129.366 Y123.905 I2.025 J-3.145 E.04015
G1 X129.821 Y123.609 E.01126
G3 X130.907 Y122.022 I6.903 J3.559 E.03999
G1 X129.21 Y122.022 E.0352
; WIPE_START
G1 X130.907 Y122.022 E-.64486
G1 X130.731 Y122.186 E-.09121
G1 X130.696 Y122.238 E-.02394
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.47 Y126.654 Z1.44 F60000
G1 X123.389 Y127.421 Z1.44
G1 Z1.04
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.903 Y129.044 E.03532
G2 X122.538 Y130.892 I4.532 J4.778 E.04791
G1 X122.083 Y131.188 E.01126
G1 X121.627 Y131.174 E.00945
G1 X120.657 Y130.837 E.02131
G1 X121.684 Y133.731 E.06371
G2 X122.538 Y132.391 I-10.382 J-7.553 E.03297
G1 X122.993 Y132.096 E.01126
G3 X125.293 Y133.146 I-.01 J3.066 E.05407
G1 X124.758 Y131.536 E.0352
M204 S10000
G1 X124.448 Y141.519 F60000
G1 F9000
M204 S4000
G1 X125.016 Y143.118 E.0352
G3 X125.724 Y143.02 I.518 J1.142 E.01504
G1 X126.179 Y143.316 E.01126
G1 X126.56 Y143.951 E.01536
G1 X130.718 Y143.951 E.08626
G1 X132.095 Y139.968 E.08742
G2 X130.731 Y139.393 I-1.943 J2.704 E.03096
G1 X130.276 Y139.379 E.00945
G1 X129.821 Y139.674 E.01126
G1 X129.366 Y140.434 E.01838
G3 X127.09 Y142.099 I-2.797 J-1.436 E.06065
G1 X126.634 Y142.112 E.00945
G1 X126.179 Y141.817 E.01126
G1 X125.724 Y141.057 E.01838
G2 X123.726 Y139.485 I-2.683 J1.354 E.05444
G1 X122.992 Y137.416 E.04553
G3 X125.269 Y135.751 I2.867 J1.53 E.06052
G3 X126.346 Y136.311 I.226 J.881 E.02757
G1 X127.155 Y138.742 E.05315
G1 X128.642 Y138.742 E.03085
G1 X128.754 Y138.405 E.00737
G2 X129.366 Y138.471 I.416 J-.995 E.01294
G1 X129.821 Y138.175 E.01126
G1 X130.276 Y137.415 E.01838
G3 X132.552 Y135.751 I2.797 J1.436 E.06065
G1 X133.007 Y135.737 E.00945
G1 X133.456 Y136.029 E.0111
G1 X133.879 Y134.804 E.02687
G1 X133.462 Y134.534 E.0103
G1 X133.007 Y133.774 E.01838
G2 X130.836 Y132.144 I-2.745 J1.396 E.05831
G1 X131.998 Y128.651 E.07636
G3 X133.007 Y128.454 I.836 J1.598 E.02163
G1 X133.462 Y128.75 E.01126
G1 X133.918 Y129.51 E.01838
G2 X135.245 Y130.85 I2.958 J-1.603 E.03966
G1 X135.8 Y129.246 E.0352
; WIPE_START
G1 X135.245 Y130.85 E-.64486
G1 X134.986 Y130.693 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.165 Y125.757 Z1.44 F60000
G1 X120.317 Y118.255 Z1.44
G1 Z1.04
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.856 Y119.864 E.0352
G1 X120.717 Y119.948 E.00336
G1 X119.807 Y120.249 E.01989
G1 X119.351 Y120.263 E.00945
G1 X118.896 Y119.967 E.01126
G1 X118.441 Y119.207 E.01838
G2 X116.165 Y117.543 I-2.797 J1.436 E.06065
G1 X115.937 Y117.536 E.00474
G1 X115.413 Y116.061 E.03247
G1 X115.71 Y115.566 E.01197
G3 X117.986 Y113.902 I2.797 J1.436 E.06065
G1 X118.441 Y113.888 E.00945
G1 X118.896 Y114.183 E.01126
G1 X119.026 Y114.401 E.00525
G1 X118.92 Y114.084 E.00691
G1 X124.716 Y114.084 E.12022
G1 X125.269 Y113.902 E.01207
G3 X126.027 Y114.084 I.247 J.638 E.01721
G1 X131.999 Y114.084 E.12388
G1 X132.552 Y113.902 E.01207
G3 X133.31 Y114.084 I.247 J.638 E.01721
G1 X136.787 Y114.084 E.07213
G1 X135.982 Y116.538 E.05356
G2 X136.649 Y116.621 I.474 J-1.078 E.01413
G1 X137.104 Y116.326 E.01126
G1 X137.559 Y115.566 E.01838
G3 X139.835 Y113.902 I2.797 J1.436 E.06065
G3 X140.91 Y114.457 I.227 J.877 E.02748
G1 X141.039 Y114.084 E.00818
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.977 E.02297
G1 X141.201 Y112.98 E.00197
G1 X140.746 Y112.684 E.01126
G1 X140.365 Y112.049 E.01537
G1 X136.104 Y112.049 E.08838
G3 X134.373 Y112.966 I-2.292 J-2.234 E.0413
G1 X133.918 Y112.98 E.00945
G1 X133.462 Y112.684 E.01126
G1 X133.082 Y112.049 E.01537
G1 X128.821 Y112.049 E.08838
G3 X127.09 Y112.966 I-2.292 J-2.234 E.0413
G1 X126.634 Y112.98 E.00945
G1 X126.179 Y112.684 E.01126
G1 X125.799 Y112.049 E.01537
G1 X121.538 Y112.049 E.08838
G3 X119.807 Y112.966 I-2.292 J-2.234 E.0413
G1 X119.351 Y112.98 E.00945
G1 X118.896 Y112.684 E.01126
G1 X118.515 Y112.049 E.01537
G1 X116.818 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X118.515 Y112.049 E-.64486
G1 X118.671 Y112.309 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L9
M991 S0 P8 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.44 I-1.153 J.39 P1  F60000
G1 X123.325 Y126.079 Z1.44
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.56 F60000
G1 X119.605 Y114.987 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
M73 P32 R15
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.56 F60000
G1 X141.28 Y114.497 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.139 Y116.688 Z1.56 F60000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.585 Y118.292 E.0352
G2 X138.014 Y117.676 I-1.77 J2.201 E.03553
G1 X137.559 Y117.742 E.00954
G1 X137.104 Y118.09 E.01188
G1 X136.194 Y119.295 E.03133
G3 X134.844 Y120.008 I-1.808 J-1.791 E.03216
G1 X134.183 Y122.022 E.04397
G1 X133.682 Y122.022 E.01038
G1 X134.373 Y122.937 E.02377
G2 X136.194 Y123.758 I2.065 J-2.146 E.04226
G1 X136.649 Y123.692 E.00954
G1 X137.104 Y123.344 E.01188
G1 X138.014 Y122.139 E.03133
G1 X138.351 Y121.863 E.00902
G1 X138.905 Y120.26 E.0352
M204 S10000
G1 X137.704 Y123.733 F60000
G1 F9000
M204 S4000
G1 X137.15 Y125.337 E.0352
G1 X136.194 Y126.578 E.0325
G3 X133.918 Y127.334 I-1.865 J-1.813 E.0517
G1 X133.462 Y126.986 E.01188
G1 X132.83 Y126.149 E.02176
G1 X133.153 Y125.178 E.02122
G1 X131.657 Y125.178 E.03102
G1 X130.731 Y124.959 E.01974
G2 X130.076 Y125.178 I-.131 J.698 E.01498
G1 X124.374 Y125.178 E.11826
G1 X123.448 Y124.959 E.01974
G2 X122.793 Y125.178 I-.131 J.698 E.01498
G1 X122.643 Y125.178 E.0031
G1 X122.674 Y125.269 E.00199
G1 X122.538 Y125.373 E.00355
G1 X121.627 Y126.578 E.03133
G3 X119.417 Y127.344 I-1.865 J-1.813 E.05031
G1 X117.332 Y121.469 E.12931
G3 X118.441 Y121.383 I.664 J1.378 E.0236
G1 X118.896 Y121.731 E.01189
G1 X119.807 Y122.937 E.03133
G2 X122.083 Y123.692 I1.865 J-1.813 E.0517
G1 X122.538 Y123.344 E.01188
G1 X123.591 Y122.022 E.03506
G1 X126.399 Y122.022 E.05825
G1 X127.09 Y122.937 E.02377
G2 X129.366 Y123.692 I1.865 J-1.813 E.0517
G1 X129.821 Y123.344 E.01189
G1 X130.874 Y122.022 E.03506
G1 X129.177 Y122.022 E.0352
; WIPE_START
G1 X130.874 Y122.022 E-.64486
G1 X130.685 Y122.259 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.457 Y126.671 Z1.56 F60000
G1 X123.391 Y127.427 Z1.56
G1 Z1.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.927 Y129.037 E.0352
G2 X123.448 Y129.422 I.688 J1.345 E.01283
G1 X122.538 Y130.628 E.03133
G1 X122.083 Y130.976 E.01188
G1 X121.627 Y131.042 E.00954
G1 X120.641 Y130.791 E.02111
G1 X121.698 Y133.768 E.06554
G1 X122.538 Y132.656 E.02892
G1 X122.993 Y132.308 E.01189
G3 X125.265 Y133.06 I.412 J2.563 E.05159
G1 X124.729 Y131.45 E.0352
M204 S10000
G1 X124.483 Y141.618 F60000
G1 F9000
M204 S4000
G1 X125.051 Y143.217 E.0352
G3 X125.724 Y143.233 I.317 J.87 E.01429
G3 X126.59 Y143.951 I-3.956 J5.646 E.02337
G1 X130.718 Y143.951 E.08563
G1 X132.093 Y139.972 E.08733
G2 X130.731 Y139.525 I-1.543 J2.402 E.03006
G1 X130.276 Y139.591 E.00954
G1 X129.821 Y139.939 E.01188
G1 X128.91 Y141.145 E.03133
G3 X127.09 Y141.966 I-2.065 J-2.147 E.04226
G1 X126.634 Y141.9 E.00954
G1 X126.179 Y141.552 E.01189
G1 X125.269 Y140.347 E.03133
G2 X123.767 Y139.599 I-1.875 J1.883 E.03541
G1 X122.966 Y137.343 E.04965
G3 X125.269 Y135.883 I2.487 J1.377 E.05898
G1 X125.724 Y135.949 E.00954
G3 X126.469 Y136.681 I-.943 J1.705 E.02193
G1 X127.155 Y138.742 E.04506
G1 X128.642 Y138.742 E.03085
G1 X128.79 Y138.297 E.00974
G2 X129.366 Y138.259 I.239 J-.757 E.01224
G1 X129.821 Y137.911 E.01189
G1 X130.731 Y136.705 E.03133
G3 X132.552 Y135.883 I2.065 J2.146 E.04226
G3 X133.384 Y136.237 I.098 J.923 E.01958
G1 X133.942 Y134.621 E.03548
G1 X133.462 Y134.269 E.01234
G1 X132.552 Y133.064 E.03134
G2 X130.799 Y132.257 I-2.021 J2.086 E.0408
G1 X131.97 Y128.735 E.077
G3 X133.007 Y128.666 I.607 J1.295 E.02207
G1 X133.462 Y129.014 E.01189
G1 X134.373 Y130.22 E.03133
G2 X135.257 Y130.817 I1.88 J-1.83 E.02228
G1 X135.811 Y129.213 E.0352
; WIPE_START
G1 X135.257 Y130.817 E-.64486
G1 X134.988 Y130.676 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.167 Y125.74 Z1.56 F60000
G1 X120.308 Y118.229 Z1.56
G1 Z1.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.847 Y119.838 E.0352
G1 X119.807 Y120.117 E.02234
G1 X119.351 Y120.051 E.00954
G1 X118.896 Y119.703 E.01188
G1 X117.986 Y118.497 E.03134
G2 X115.995 Y117.7 I-1.896 J1.85 E.0458
G1 X115.362 Y115.918 E.03922
G1 X116.165 Y114.856 E.02762
G3 X118.441 Y114.1 I1.865 J1.813 E.0517
G3 X119.158 Y114.795 I-.891 J1.637 E.02098
G1 X119.697 Y116.404 E.0352
; WIPE_START
G1 X119.158 Y114.795 E-.64486
G1 X118.976 Y114.553 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.354 Y114.084 Z1.56 F60000
G1 Z1.16
G1 E.8 F1800
G1 F9000
M204 S4000
G3 X125.617 Y114.084 I1.132 J16.327 E.04698
G1 X132.334 Y114.084 E.13932
G3 X132.9 Y114.084 I.283 J.726 E.01202
G1 X136.787 Y114.084 E.08063
G1 X136.016 Y116.434 E.0513
G2 X136.649 Y116.409 I.284 J-.823 E.01344
G1 X137.104 Y116.061 E.01188
G1 X138.014 Y114.856 E.03133
G3 X139.835 Y114.034 I2.065 J2.146 E.04226
G3 X140.86 Y114.6 I-.009 J1.228 E.02532
G1 X141.039 Y114.084 E.01132
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.781 E.02703
G3 X140.465 Y112.049 I.797 J-1.74 E.02331
G1 X136.149 Y112.049 E.08954
G3 X134.373 Y112.834 I-2.007 J-2.139 E.04105
G1 X133.918 Y112.768 E.00954
G3 X133.182 Y112.049 I.925 J-1.682 E.0216
G1 X128.866 Y112.049 E.08954
G3 X127.09 Y112.834 I-2.007 J-2.139 E.04105
G1 X126.634 Y112.768 E.00954
G3 X125.899 Y112.049 I.925 J-1.681 E.0216
G1 X121.583 Y112.049 E.08954
G3 X119.807 Y112.834 I-2.007 J-2.139 E.04105
G1 X119.351 Y112.768 E.00954
G3 X118.616 Y112.049 I.925 J-1.682 E.0216
G1 X116.919 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X118.616 Y112.049 E-.64486
G1 X118.799 Y112.29 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L10
M991 S0 P9 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.56 I-1.156 J.38 P1  F60000
G1 X123.325 Y126.079 Z1.56
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.68 F60000
G1 X119.605 Y114.987 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.68 F60000
G1 X141.28 Y114.497 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P33 R15
G1 X139.121 Y120.399 Z1.68 F60000
G1 X137.603 Y124.028 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.048 Y125.632 E.0352
G1 X136.194 Y126.628 E.02721
G3 X133.918 Y127.161 I-1.608 J-1.738 E.05071
G3 X132.853 Y126.081 I2.45 J-3.482 E.03162
G1 X133.153 Y125.178 E.01974
G1 X131.535 Y125.178 E.03356
G2 X130.35 Y125.178 I-.593 J1.829 E.02499
G1 X124.252 Y125.178 E.12649
G2 X123.067 Y125.178 I-.593 J1.829 E.02499
G1 X122.643 Y125.178 E.00879
G1 X122.723 Y125.417 E.00523
G1 X121.627 Y126.628 E.03386
G3 X119.353 Y127.161 I-1.608 J-1.738 E.05068
G1 X117.343 Y121.497 E.12466
G3 X118.896 Y121.926 I.443 J1.423 E.03532
G1 X119.807 Y122.986 E.02898
G2 X122.083 Y123.519 I1.608 J-1.738 E.05071
G1 X122.538 Y123.15 E.01216
G1 X123.542 Y122.022 E.03132
G1 X126.262 Y122.022 E.05641
G1 X127.09 Y122.986 E.02636
G2 X129.366 Y123.519 I1.608 J-1.738 E.05071
G1 X129.821 Y123.15 E.01216
G1 X130.825 Y122.022 E.03132
G1 X133.545 Y122.022 E.05641
G1 X134.373 Y122.986 E.02636
G2 X136.649 Y123.519 I1.608 J-1.738 E.05071
G1 X137.104 Y123.15 E.01216
G1 X138.014 Y122.09 E.02898
G1 X138.357 Y121.844 E.00875
G1 X139.591 Y118.273 E.07836
G2 X137.559 Y117.915 I-1.368 J1.815 E.04443
G1 X137.104 Y118.284 E.01216
G1 X136.194 Y119.344 E.02898
G3 X134.854 Y119.976 I-1.871 J-2.234 E.03105
G1 X136.043 Y116.353 E.07909
G2 X137.104 Y115.866 I-.017 J-1.437 E.02493
G1 X138.014 Y114.806 E.02898
G3 X140.29 Y114.273 I1.608 J1.738 E.05071
G3 X140.817 Y114.726 I-.988 J1.681 E.01448
G1 X141.039 Y114.084 E.01408
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.62 E.03037
G1 X141.201 Y112.595 E.00204
G3 X140.594 Y112.049 I1.205 J-1.948 E.01702
G1 X136.204 Y112.049 E.09106
G3 X133.918 Y112.595 I-1.626 J-1.747 E.05099
G3 X133.311 Y112.049 I1.205 J-1.948 E.01702
G1 X128.921 Y112.049 E.09106
G3 X126.634 Y112.595 I-1.626 J-1.747 E.05099
G3 X126.028 Y112.049 I1.205 J-1.948 E.01702
G1 X121.638 Y112.049 E.09106
G3 X119.351 Y112.595 I-1.626 J-1.747 E.05099
G3 X118.745 Y112.049 I1.205 J-1.948 E.01702
G1 X117.048 Y112.049 E.0352
M204 S10000
G1 X119.781 Y116.655 F60000
G1 F9000
M204 S4000
G1 X119.242 Y115.046 E.0352
G2 X118.441 Y114.273 I-2.535 J1.827 E.02321
G2 X116.165 Y114.806 I-.668 J2.271 E.05071
G1 X115.318 Y115.793 E.02697
G1 X116.039 Y117.826 E.04475
G3 X117.986 Y118.448 I.284 J2.466 E.04368
G1 X118.896 Y119.508 E.02898
G1 X119.351 Y119.878 E.01216
G2 X120.84 Y119.818 I.676 J-1.731 E.0318
G1 X120.301 Y118.208 E.0352
M204 S10000
G1 X123.391 Y127.426 F60000
G1 F9000
M204 S4000
G1 X123.927 Y129.036 E.0352
G2 X123.448 Y129.373 I.57 J1.319 E.01222
G1 X122.538 Y130.433 E.02898
G1 X122.083 Y130.802 E.01216
G3 X120.629 Y130.758 I-.676 J-1.683 E.03103
G1 X121.713 Y133.811 E.06721
G3 X122.993 Y132.481 I4.315 J2.871 E.0385
G3 X125.243 Y132.996 I.668 J2.257 E.05005
G1 X124.708 Y131.386 E.0352
M204 S10000
G1 X124.51 Y141.691 F60000
G1 F9000
M204 S4000
G1 X125.077 Y143.291 E.0352
G3 X125.724 Y143.406 I.14 J1.088 E.01384
G2 X126.435 Y143.951 I3.806 J-4.22 E.0186
G1 X130.718 Y143.951 E.08886
G1 X132.094 Y139.97 E.08737
G2 X131.186 Y139.66 I-1.308 J2.344 E.02
G2 X129.821 Y140.134 I-.249 J1.486 E.03127
G1 X128.91 Y141.194 E.02898
G3 X127.545 Y141.831 I-1.885 J-2.256 E.03161
G3 X126.179 Y141.357 I-.249 J-1.486 E.03127
G1 X125.269 Y140.297 E.02898
G2 X123.787 Y139.655 I-1.701 J1.894 E.03409
G1 X122.935 Y137.254 E.05286
G1 X123.448 Y136.656 E.01635
G3 X125.724 Y136.123 I1.608 J1.738 E.05071
G3 X126.55 Y136.924 I-1.8 J2.681 E.02399
G1 X127.155 Y138.742 E.03976
G1 X128.642 Y138.742 E.03085
G1 X128.821 Y138.205 E.01176
G2 X129.821 Y137.716 I-.106 J-1.485 E.02366
G1 X130.731 Y136.656 E.02898
G3 X132.097 Y136.018 I1.885 J2.256 E.03161
G3 X133.332 Y136.387 I.255 J1.402 E.02775
G1 X133.996 Y134.465 E.04217
G1 X133.462 Y134.074 E.01372
G1 X132.552 Y133.014 E.02898
G2 X130.765 Y132.36 I-1.714 J1.912 E.04045
G1 X131.959 Y128.768 E.0785
G3 X133.462 Y129.209 I.409 J1.39 E.03433
G1 X134.373 Y130.269 E.02898
G2 X135.266 Y130.789 I1.699 J-1.891 E.0216
G1 X135.821 Y129.185 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X135.266 Y130.789 E-.64486
G1 X134.989 Y130.667 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L11
M991 S0 P10 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.68 I.445 J-1.133 P1  F60000
G1 X123.325 Y126.079 Z1.68
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.8 F60000
G1 X119.605 Y114.987 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.8 F60000
G1 X141.28 Y114.497 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.131 Y120.403 Z1.8 F60000
G1 X137.519 Y124.269 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.965 Y125.873 E.0352
G1 X136.194 Y126.68 E.02316
G3 X133.918 Y127.013 I-1.418 J-1.744 E.05009
G3 X132.874 Y126.016 I4.02 J-5.25 E.02999
G1 X133.153 Y125.178 E.01832
G1 X131.322 Y125.178 E.03797
G2 X130.742 Y125.178 I-.29 J1.351 E.01212
G1 X124.039 Y125.178 E.13904
G2 X122.643 Y125.178 I-.698 J16.764 E.02897
G1 X122.763 Y125.538 E.00788
G2 X121.627 Y126.68 I4.63 J5.744 E.03347
G3 X119.351 Y127.013 I-1.418 J-1.744 E.05009
G1 X119.278 Y126.952 E.00198
G1 X117.358 Y121.542 E.11907
G3 X118.896 Y122.086 I.325 J1.526 E.0356
G1 X119.807 Y123.038 E.02732
G2 X122.083 Y123.372 I1.418 J-1.744 E.05009
G2 X123.473 Y122.022 I-15.6 J-17.461 E.0402
G1 X126.103 Y122.022 E.05456
G3 X127.09 Y123.038 I-4.134 J5.001 E.02944
G2 X129.366 Y123.372 I1.418 J-1.744 E.05009
G2 X130.756 Y122.022 I-15.6 J-17.461 E.0402
G1 X133.386 Y122.022 E.05456
G3 X134.373 Y123.038 I-4.134 J5.001 E.02944
G2 X136.649 Y123.372 I1.418 J-1.744 E.05009
G2 X138.014 Y122.037 I-5.394 J-6.887 E.03968
G1 X138.366 Y121.819 E.00859
G1 X139.599 Y118.249 E.07833
G2 X137.559 Y118.062 I-1.194 J1.804 E.04427
G2 X136.194 Y119.397 I5.393 J6.885 E.03968
G3 X134.875 Y119.912 I-1.624 J-2.209 E.0297
G1 X136.073 Y116.262 E.0797
G2 X137.104 Y115.706 I-.253 J-1.704 E.02478
G1 X138.014 Y114.754 E.02732
G3 X140.29 Y114.421 I1.418 J1.744 E.05009
G3 X140.778 Y114.837 I-1.654 J2.432 E.01334
G1 X141.039 Y114.084 E.01652
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.482 E.03324
G1 X141.201 Y112.447 E.0021
G3 X140.73 Y112.049 I1.578 J-2.342 E.01281
G1 X136.256 Y112.049 E.09282
G3 X133.918 Y112.447 I-1.483 J-1.647 E.05191
G3 X133.447 Y112.049 I1.579 J-2.342 E.01281
G1 X128.972 Y112.049 E.09282
G3 X126.634 Y112.447 I-1.483 J-1.647 E.05191
G3 X126.164 Y112.049 I1.578 J-2.342 E.01281
G1 X121.689 Y112.049 E.09282
G3 X119.351 Y112.447 I-1.483 J-1.647 E.05191
G3 X118.881 Y112.049 I1.579 J-2.342 E.01281
G1 X117.184 Y112.049 E.0352
M204 S10000
G1 X119.842 Y116.838 F60000
G1 F9000
M204 S4000
G1 X119.304 Y115.229 E.0352
G2 X118.441 Y114.421 I-4.112 J3.524 E.02457
G2 X116.165 Y114.754 I-.858 J2.078 E.05009
G1 X115.278 Y115.681 E.02661
G1 X116.076 Y117.928 E.04945
G3 X117.986 Y118.396 I.442 J2.33 E.04206
G1 X118.896 Y119.348 E.02732
G2 X120.835 Y119.803 I1.31 J-1.223 E.0438
G1 X120.296 Y118.193 E.0352
M204 S10000
G1 X123.389 Y127.419 F60000
G1 F9000
M204 S4000
G1 X123.924 Y129.03 E.0352
G2 X123.448 Y129.321 I.454 J1.28 E.01166
G1 X122.538 Y130.273 E.02732
G3 X120.621 Y130.735 I-1.31 J-1.223 E.0433
G1 X121.729 Y133.857 E.0687
G3 X122.993 Y132.629 I6.223 J5.142 E.03663
G3 X125.223 Y132.933 I.855 J2.055 E.04894
G1 X124.687 Y131.323 E.0352
M204 S10000
G1 X124.541 Y141.779 F60000
G1 F9000
M204 S4000
G1 X125.108 Y143.378 E.0352
G1 X125.269 Y143.386 E.00334
G3 X126.21 Y143.951 I-.982 J2.703 E.02291
G1 X130.718 Y143.951 E.09351
G1 X132.097 Y139.962 E.08755
G2 X130.276 Y139.912 I-.965 J1.939 E.03899
G2 X128.91 Y141.246 I5.393 J6.886 E.03968
G3 X126.634 Y141.579 I-1.418 J-1.744 E.05009
G3 X125.269 Y140.245 I5.393 J-6.885 E.03968
G2 X123.812 Y139.727 I-1.497 J1.9 E.03265
G1 X122.905 Y137.171 E.05624
G3 X125.269 Y136.103 I2.086 J1.467 E.05644
G3 X126.609 Y137.102 I-1.007 J2.75 E.03515
G1 X127.155 Y138.742 E.03587
G1 X128.642 Y138.742 E.03085
G1 X128.853 Y138.108 E.01387
G2 X129.366 Y137.938 I-.017 J-.908 E.01137
G2 X130.731 Y136.604 I-5.393 J-6.886 E.03968
G1 X131.186 Y136.321 E.01112
G3 X133.29 Y136.508 I.917 J1.614 E.04661
G1 X134.039 Y134.341 E.04756
G3 X132.552 Y132.962 I3.256 J-5.003 E.04227
G2 X130.731 Y132.462 I-1.505 J1.912 E.04022
G1 X131.941 Y128.823 E.07954
G3 X133.007 Y128.987 I.26 J1.854 E.0227
G3 X134.373 Y130.321 I-5.394 J6.886 E.03968
G2 X135.274 Y130.767 I1.512 J-1.924 E.021
G1 X135.828 Y129.163 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X135.274 Y130.767 E-.64486
G1 X134.989 Y130.663 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L12
M991 S0 P11 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.8 I.445 J-1.133 P1  F60000
G1 X123.325 Y126.079 Z1.8
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
M73 P34 R15
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z1.92 F60000
G1 X119.605 Y114.987 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z1.92 F60000
G1 X141.28 Y114.497 Z1.92
M73 P34 R14
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.14 Y120.407 Z1.92 F60000
G1 X137.442 Y124.493 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.888 Y126.097 E.0352
G1 X136.649 Y126.35 E.00722
G3 X133.918 Y126.883 I-1.712 J-1.505 E.06209
G3 X132.905 Y125.923 I13.514 J-15.259 E.02895
G1 X131.926 Y128.866 E.06434
G3 X133.462 Y129.509 I.155 J1.786 E.03592
G2 X135.28 Y130.75 I2.875 J-2.261 E.04636
G1 X135.834 Y129.146 E.0352
; WIPE_START
G1 X135.28 Y130.75 E-.64486
G1 X134.989 Y130.666 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.789 Y136.254 Z1.92 F60000
G1 X124.57 Y141.862 Z1.92
G1 Z1.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.138 Y143.461 E.0352
G3 X126.035 Y143.951 I-.405 J1.807 E.02149
G1 X130.718 Y143.951 E.09715
G1 X132.101 Y139.949 E.08783
G2 X130.731 Y139.837 I-.854 J2.012 E.02901
G2 X129.366 Y140.916 I1.422 J3.203 E.03648
G3 X127.09 Y141.654 I-1.799 J-1.669 E.05184
G3 X125.724 Y140.575 I1.422 J-3.203 E.03648
G2 X123.833 Y139.786 I-1.826 J1.713 E.04379
G1 X122.868 Y137.066 E.05986
G3 X125.724 Y136.4 I1.839 J1.433 E.06579
G3 X126.679 Y137.312 I-8.71 J10.078 E.02739
G1 X127.155 Y138.742 E.03127
G1 X128.642 Y138.742 E.03085
G1 X128.884 Y138.016 E.01588
G2 X129.821 Y137.415 I-.801 J-2.281 E.0233
G3 X131.186 Y136.305 I3.274 J2.631 E.03678
G3 X133.254 Y136.613 I.794 J1.762 E.04581
G1 X134.075 Y134.237 E.05214
G3 X133.007 Y133.292 I2.128 J-3.481 E.02973
G2 X130.695 Y132.571 I-1.781 J1.641 E.05262
G1 X130.159 Y134.181 E.0352
; WIPE_START
G1 X130.695 Y132.571 E-.64486
G1 X130.994 Y132.523 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.666 Y131.26 Z1.92 F60000
G1 Z1.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.202 Y132.871 E.0352
G2 X122.538 Y133.151 I-1.169 J1.692 E.06051
G3 X121.75 Y133.915 I-3.819 J-3.152 E.02281
G1 X120.616 Y130.722 E.07027
G2 X122.538 Y130.132 I.482 J-1.854 E.04388
G3 X123.92 Y129.017 I3.253 J2.618 E.03713
G1 X122.798 Y125.644 E.07374
G3 X121.627 Y126.735 I-29.003 J-29.931 E.03321
G3 X119.211 Y126.762 I-1.227 J-1.691 E.05345
G1 X117.373 Y121.582 E.11402
G3 X118.896 Y122.226 I.142 J1.787 E.03566
G2 X121.172 Y123.507 I2.417 J-1.632 E.05617
G2 X122.538 Y122.849 I-.113 J-1.981 E.03226
G3 X123.401 Y122.022 I4.141 J3.457 E.02485
G1 X125.942 Y122.022 E.05272
G2 X127.09 Y123.094 I25.376 J-26.022 E.03257
G2 X129.821 Y122.849 I1.226 J-1.687 E.06207
G3 X130.684 Y122.022 I4.141 J3.456 E.02485
G1 X133.225 Y122.022 E.05272
G2 X134.373 Y123.094 I25.355 J-26 E.03257
G2 X137.104 Y122.849 I1.226 J-1.687 E.06207
G3 X138.377 Y121.788 I3.26 J2.617 E.03459
G1 X139.61 Y118.22 E.07832
G2 X137.104 Y118.585 I-1.037 J1.665 E.05709
G3 X134.892 Y119.86 I-2.41 J-1.624 E.05483
G1 X136.101 Y116.175 E.08044
G2 X137.104 Y115.566 I-.548 J-2.032 E.02467
G3 X139.38 Y114.285 I2.417 J1.632 E.05617
G3 X140.743 Y114.941 I-.112 J1.978 E.03218
G1 X141.039 Y114.084 E.01879
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.36 E.03578
G3 X140.89 Y112.049 I.321 J-.84 E.01076
G1 X136.336 Y112.049 E.09446
G3 X133.607 Y112.049 I-1.365 J-1.467 E.06227
G1 X129.052 Y112.049 E.09446
G3 X126.323 Y112.049 I-1.365 J-1.467 E.06227
G1 X121.769 Y112.049 E.09446
G3 X119.04 Y112.049 I-1.365 J-1.467 E.06227
G1 X117.343 Y112.049 E.0352
M204 S10000
G1 X119.915 Y117.055 F60000
G1 F9000
M204 S4000
G1 X119.376 Y115.446 E.0352
G3 X118.896 Y114.943 I2.015 J-2.405 E.01445
G2 X117.075 Y114.325 I-1.432 J1.226 E.04186
G2 X115.241 Y115.577 I1 J3.432 E.04684
G1 X116.106 Y118.014 E.05363
G3 X116.62 Y117.927 I.404 J.819 E.01096
G3 X118.896 Y119.208 I-.141 J2.913 E.05617
G2 X120.832 Y119.793 I1.439 J-1.263 E.04419
G1 X120.293 Y118.184 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.832 Y119.793 E-.64485
G1 X120.531 Y119.831 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L13
M991 S0 P12 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z1.92 I-1.111 J.497 P1  F60000
G1 X123.325 Y126.079 Z1.92
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.04 F60000
G1 X119.605 Y114.987 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.04 F60000
G1 X141.28 Y114.497 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
M73 P35 R14
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.128 Y112.049 Z2.04 F60000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.431 Y112.049 E.0352
G3 X133.748 Y112.049 I-1.342 J-1.614 E.06038
G1 X129.148 Y112.049 E.09541
G3 X126.465 Y112.049 I-1.342 J-1.614 E.06038
G1 X121.865 Y112.049 E.09541
G3 X119.182 Y112.049 I-1.342 J-1.614 E.06038
G1 X117.485 Y112.049 E.0352
M204 S10000
G1 X119.959 Y117.187 F60000
G1 F9000
M204 S4000
G1 X119.42 Y115.578 E.0352
G3 X118.896 Y115.072 I1.581 J-2.161 E.01516
G2 X117.075 Y114.337 I-1.605 J1.355 E.04238
G2 X115.207 Y115.48 I.651 J3.163 E.04635
G1 X116.133 Y118.088 E.05741
G3 X118.896 Y119.079 I.682 J2.447 E.06493
G2 X120.831 Y119.79 I1.586 J-1.33 E.04474
G1 X120.292 Y118.18 E.0352
; WIPE_START
G1 X120.831 Y119.79 E-.64486
G1 X120.528 Y119.805 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.776 Y117.413 Z2.04 F60000
G1 X136.657 Y114.481 Z2.04
G1 Z1.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.128 Y116.094 E.0352
G2 X137.104 Y115.438 I-.942 J-2.455 E.0246
G3 X139.835 Y114.43 I2.094 J1.471 E.06424
G3 X140.709 Y115.039 I-.804 J2.084 E.02231
G1 X139.622 Y118.185 E.06903
G2 X137.104 Y118.713 I-.921 J1.874 E.05749
G3 X134.906 Y119.818 I-2.161 J-1.56 E.05304
G1 X135.435 Y118.206 E.0352
M204 S10000
G1 X135.838 Y129.134 F60000
G1 F9000
M204 S4000
G1 X135.284 Y130.738 E.0352
G3 X133.462 Y129.638 I.445 J-2.794 E.04526
G2 X131.915 Y128.9 I-1.584 J1.331 E.03666
G1 X132.93 Y125.85 E.06668
G3 X133.462 Y126.362 I-1.6 J2.196 E.01538
G2 X136.827 Y126.272 I1.644 J-1.487 E.07928
G1 X138.389 Y121.754 E.09917
G2 X137.104 Y122.721 I1.456 J3.271 E.03364
G3 X134.373 Y123.153 I-1.62 J-1.392 E.06238
G3 X133.087 Y122.022 I10.417 J-13.146 E.03554
G1 X130.6 Y122.022 E.05158
G2 X129.821 Y122.721 I2.155 J3.185 E.02177
G3 X127.09 Y123.153 I-1.62 J-1.392 E.06238
G3 X125.803 Y122.022 I10.421 J-13.149 E.03554
G1 X123.317 Y122.022 E.05158
G1 X122.993 Y122.267 E.00842
G3 X121.627 Y123.363 I-3.504 J-2.967 E.03654
G3 X118.896 Y122.355 I-.637 J-2.479 E.06424
G2 X117.385 Y121.617 I-1.588 J1.335 E.03592
G1 X119.148 Y126.586 E.10936
G2 X121.627 Y126.795 I1.381 J-1.576 E.05525
G2 X122.83 Y125.738 I-9.043 J-11.503 E.03321
G1 X123.914 Y128.998 E.07126
G2 X122.538 Y130.004 I1.332 J3.266 E.03571
G3 X120.615 Y130.717 I-1.587 J-1.332 E.0445
G1 X121.769 Y133.97 E.07161
G2 X122.538 Y133.279 I-2.131 J-3.143 E.0215
G3 X125.181 Y132.808 I1.606 J1.357 E.0604
G1 X125.716 Y134.418 E.0352
; WIPE_START
G1 X125.181 Y132.808 E-.64485
G1 X124.905 Y132.683 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.124 Y134.285 Z2.04 F60000
G1 Z1.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.66 Y132.675 E.0352
G3 X133.462 Y133.645 I.734 J2.411 E.06577
G2 X134.106 Y134.147 I1.344 J-1.06 E.01709
G1 X133.221 Y136.708 E.05619
G2 X130.276 Y136.833 I-1.406 J1.623 E.06739
G3 X128.913 Y137.928 I-3.504 J-2.967 E.03649
G1 X128.642 Y138.742 E.01781
G1 X127.155 Y138.742 E.03085
G1 X126.722 Y137.441 E.02845
G2 X125.724 Y136.518 I-107.144 J114.834 E.02819
G2 X122.84 Y136.986 I-1.166 J1.937 E.0659
G1 X123.851 Y139.834 E.06269
G3 X126.179 Y140.929 I.195 J2.609 E.0558
G2 X129.366 Y141.017 I1.634 J-1.442 E.07416
G3 X130.731 Y139.921 I3.504 J2.967 E.03654
G3 X132.108 Y139.93 I.674 J2.037 E.02907
G1 X130.789 Y143.746 E.08374
G2 X130.494 Y143.951 I.305 J.752 E.00752
G1 X125.894 Y143.951 E.09543
G2 X125.166 Y143.54 I-1.423 J1.669 E.01745
G1 X124.598 Y141.941 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.166 Y143.54 E-.64486
G1 X125.44 Y143.668 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L14
M991 S0 P13 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.04 I1.208 J-.145 P1  F60000
G1 X123.325 Y126.079 Z2.04
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.16 F60000
G1 X119.605 Y114.987 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.16 F60000
G1 X141.28 Y114.497 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.251 Y112.049 Z2.16 F60000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.554 Y112.049 E.0352
G3 X133.873 Y112.049 I-1.341 J-1.691 E.06002
G1 X129.271 Y112.049 E.09545
G3 X126.59 Y112.049 I-1.341 J-1.691 E.06001
G1 X121.988 Y112.049 E.09545
G3 X119.306 Y112.049 I-1.341 J-1.691 E.06002
G1 X117.609 Y112.049 E.0352
M204 S10000
G1 X118.923 Y114.092 F60000
G1 F9000
M204 S4000
G1 X119.462 Y115.701 E.0352
G3 X118.896 Y115.194 I1.23 J-1.941 E.01582
G2 X116.165 Y114.576 I-1.743 J1.359 E.0629
G2 X115.174 Y115.389 I3.534 J5.315 E.02663
G1 X116.155 Y118.153 E.06083
G3 X118.896 Y118.957 I.843 J2.2 E.06365
G2 X120.831 Y119.792 I1.757 J-1.413 E.04548
G1 X120.292 Y118.182 E.0352
; WIPE_START
G1 X120.831 Y119.792 E-.64486
G1 X120.528 Y119.785 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.77 Y117.372 Z2.16 F60000
G1 X136.683 Y114.403 Z2.16
G1 Z1.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.154 Y116.016 E.0352
G2 X137.104 Y115.316 I-1.508 J-3.042 E.02461
G3 X140.677 Y115.131 I1.861 J1.36 E.08495
G1 X139.636 Y118.143 E.0661
G2 X137.104 Y118.835 I-.806 J2.028 E.05842
G3 X134.917 Y119.784 I-1.944 J-1.485 E.05165
G1 X135.446 Y118.172 E.0352
M204 S10000
G1 X135.84 Y129.128 F60000
G1 F9000
M204 S4000
G1 X135.286 Y130.732 E.0352
G3 X133.462 Y129.76 I.19 J-2.553 E.04412
G2 X131.906 Y128.926 I-1.829 J1.545 E.0375
G1 X132.955 Y125.773 E.06894
G3 X133.462 Y126.24 I-1.143 J1.748 E.01437
G2 X136.771 Y126.435 I1.74 J-1.354 E.07779
G1 X138.402 Y121.715 E.10359
G2 X137.104 Y122.599 I1.021 J2.894 E.03294
G3 X134.373 Y123.217 I-1.743 J-1.359 E.0629
G3 X132.942 Y122.022 I11.113 J-14.761 E.03868
G1 X130.489 Y122.022 E.05088
G2 X129.821 Y122.599 I1.387 J2.283 E.01839
G3 X127.09 Y123.217 I-1.743 J-1.359 E.0629
G3 X125.659 Y122.022 I11.116 J-14.765 E.03868
G1 X123.206 Y122.022 E.05088
G2 X122.538 Y122.599 I1.387 J2.284 E.01839
G3 X118.896 Y122.477 I-1.773 J-1.484 E.08704
G2 X117.396 Y121.647 I-1.843 J1.561 E.03636
G1 X119.088 Y126.415 E.10496
G2 X121.627 Y126.858 I1.566 J-1.478 E.05732
G2 X122.859 Y125.825 I-4.849 J-7.03 E.03339
G1 X123.905 Y128.972 E.06879
G2 X122.538 Y129.882 I.908 J2.848 E.03451
G3 X120.615 Y130.718 I-1.759 J-1.417 E.04523
G1 X120.047 Y129.119 E.0352
M204 S10000
G1 X125.695 Y134.353 F60000
G1 F9000
M204 S4000
G1 X125.159 Y132.743 E.0352
G2 X122.538 Y133.402 I-.89 J2.002 E.06042
G3 X121.791 Y134.031 I-2.252 J-1.914 E.02035
G1 X122.811 Y136.905 E.06326
G3 X126.179 Y137.043 I1.624 J1.527 E.07928
G2 X126.762 Y137.562 I1.839 J-1.48 E.01625
G1 X127.155 Y138.742 E.02581
G1 X128.642 Y138.742 E.03085
G1 X128.944 Y137.833 E.01988
G2 X130.276 Y136.732 I-3.341 J-5.398 E.03595
G3 X133.191 Y136.795 I1.423 J1.637 E.06632
G1 X134.133 Y134.068 E.05984
G3 X133.007 Y133.091 I4.152 J-5.921 E.03099
G2 X130.626 Y132.776 I-1.425 J1.62 E.05283
G1 X130.091 Y134.386 E.0352
M204 S10000
G1 X128.674 Y143.951 F60000
G1 F9000
M204 S4000
G1 X130.371 Y143.951 E.0352
G3 X130.813 Y143.678 I.784 J.773 E.01088
G1 X132.117 Y139.905 E.0828
G2 X129.821 Y140.685 I-.504 J2.284 E.05287
G3 X126.179 Y140.806 I-1.868 J-1.362 E.08704
G2 X123.865 Y139.874 I-1.923 J1.436 E.05442
G1 X125.193 Y143.616 E.08234
G3 X125.769 Y143.951 I-1.46 J3.168 E.01386
G1 X127.466 Y143.951 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.769 Y143.951 E-.64486
M73 P36 R14
G1 X125.507 Y143.799 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L15
M991 S0 P14 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.16 I1.208 J-.149 P1  F60000
G1 X123.325 Y126.079 Z2.16
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.28 F60000
G1 X119.605 Y114.987 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.28 F60000
G1 X141.28 Y114.497 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.389 Y112.049 Z2.28 F60000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.692 Y112.049 E.0352
G3 X134.01 Y112.049 I-1.341 J-1.692 E.06002
G1 X129.409 Y112.049 E.09544
G3 X126.727 Y112.049 I-1.341 J-1.692 E.06002
G1 X122.126 Y112.049 E.09544
G3 X119.444 Y112.049 I-1.341 J-1.692 E.06002
G1 X117.747 Y112.049 E.0352
M204 S10000
G1 X118.963 Y114.211 F60000
G1 F9000
M204 S4000
G1 X119.501 Y115.82 E.0352
G3 X118.896 Y115.314 I.945 J-1.745 E.01648
G2 X116.165 Y114.506 I-1.903 J1.413 E.06337
G2 X115.143 Y115.301 I2.458 J4.214 E.02693
G1 X116.177 Y118.212 E.06407
G3 X118.896 Y118.837 I.976 J1.983 E.06265
G2 X120.834 Y119.8 I1.956 J-1.504 E.04646
G1 X120.295 Y118.191 E.0352
; WIPE_START
G1 X120.834 Y119.8 E-.64485
G1 X120.532 Y119.771 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.766 Y117.337 Z2.28 F60000
G1 X136.708 Y114.328 Z2.28
G1 Z1.88
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.178 Y115.94 E.0352
G2 X137.559 Y114.779 I-8.537 J-11.555 E.03744
G3 X140.646 Y115.22 I1.313 J1.833 E.07142
G1 X139.653 Y118.094 E.06309
G2 X137.104 Y118.955 I-.656 J2.263 E.0594
G3 X134.926 Y119.758 I-1.757 J-1.411 E.05059
G1 X135.455 Y118.146 E.0352
M204 S10000
G1 X135.841 Y129.128 F60000
G1 F9000
M204 S4000
G1 X135.286 Y130.732 E.0352
G3 X133.462 Y129.88 I-.026 J-2.324 E.04318
G2 X131.9 Y128.945 I-2.131 J1.788 E.03847
G1 X132.983 Y125.689 E.07117
G3 X133.462 Y126.12 I-.822 J1.397 E.01346
G2 X136.716 Y126.593 I1.859 J-1.359 E.07596
G1 X138.417 Y121.671 E.10801
G2 X137.104 Y122.478 I.666 J2.554 E.03244
G3 X133.918 Y123.013 I-1.868 J-1.37 E.07416
G2 X132.796 Y122.022 I-8.556 J8.556 E.03107
G1 X130.343 Y122.022 E.05087
G2 X129.821 Y122.478 I.863 J1.516 E.01449
G3 X126.634 Y123.013 I-1.868 J-1.37 E.07416
G2 X125.513 Y122.022 I-8.559 J8.559 E.03107
G1 X123.06 Y122.022 E.05087
G2 X122.538 Y122.478 I.864 J1.516 E.01449
G3 X118.896 Y122.597 I-1.867 J-1.366 E.08702
G2 X117.404 Y121.672 I-2.162 J1.821 E.03702
G1 X119.027 Y126.245 E.10065
G2 X121.627 Y126.928 I1.768 J-1.44 E.05963
G2 X122.886 Y125.908 I-3.032 J-5.029 E.03371
G1 X123.895 Y128.941 E.06631
G2 X122.538 Y129.762 I.635 J2.584 E.0334
G3 X120.618 Y130.726 I-1.961 J-1.512 E.04609
G1 X120.05 Y129.126 E.0352
M204 S10000
G1 X125.672 Y134.286 F60000
G1 F9000
M204 S4000
G1 X125.137 Y132.675 E.0352
G2 X122.538 Y133.522 I-.705 J2.249 E.06048
G3 X121.815 Y134.098 I-1.782 J-1.493 E.01931
G1 X122.781 Y136.822 E.05995
G3 X126.179 Y137.163 I1.546 J1.692 E.07992
G2 X126.801 Y137.679 I1.583 J-1.275 E.01687
G1 X127.155 Y138.742 E.02324
G1 X128.642 Y138.742 E.03085
G1 X128.975 Y137.74 E.02191
G2 X130.276 Y136.629 I-5.71 J-7.999 E.03554
G3 X133.162 Y136.878 I1.3 J1.78 E.06557
G1 X134.158 Y133.997 E.06322
G3 X133.007 Y132.987 I6.936 J-9.059 E.03178
G2 X130.593 Y132.876 I-1.286 J1.657 E.05342
G1 X130.058 Y134.486 E.0352
M204 S10000
G1 X128.536 Y143.951 F60000
G1 F9000
M204 S4000
G1 X130.233 Y143.951 E.0352
G3 X130.837 Y143.608 I1.849 J2.549 E.01445
G1 X132.128 Y139.873 E.08197
G2 X129.821 Y140.805 I-.384 J2.37 E.05425
G3 X126.179 Y140.686 I-1.774 J-1.484 E.08702
G2 X123.876 Y139.907 I-1.792 J1.504 E.05303
G1 X125.218 Y143.689 E.08323
G3 X125.631 Y143.951 I-.335 J.981 E.01024
G1 X127.328 Y143.951 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.631 Y143.951 E-.64486
G1 X125.375 Y143.788 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L16
M991 S0 P15 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.28 I1.209 J-.14 P1  F60000
G1 X123.325 Y126.079 Z2.28
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.4 F60000
G1 X119.605 Y114.987 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.4 F60000
G1 X141.28 Y114.497 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
M73 P37 R14
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.514 Y112.049 Z2.4 F60000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.817 Y112.049 E.0352
G3 X134.134 Y112.049 I-1.341 J-1.615 E.06037
G1 X129.534 Y112.049 E.09542
G3 X126.851 Y112.049 I-1.341 J-1.615 E.06037
G1 X122.251 Y112.049 E.09542
G3 X119.568 Y112.049 I-1.341 J-1.615 E.06037
G1 X117.871 Y112.049 E.0352
M204 S10000
G1 X119.003 Y114.33 F60000
G1 F9000
M204 S4000
G1 X119.541 Y115.939 E.0352
G3 X118.896 Y115.436 I.704 J-1.569 E.01713
G2 X116.165 Y114.431 I-2.092 J1.47 E.06422
G2 X115.113 Y115.215 I1.697 J3.376 E.02736
G1 X116.196 Y118.266 E.06717
G3 X118.896 Y118.715 I1.084 J1.827 E.0617
G2 X120.839 Y119.815 I2.185 J-1.594 E.04774
G1 X120.3 Y118.206 E.0352
M204 S10000
G1 X120.055 Y129.14 F60000
G1 F9000
M204 S4000
G1 X120.623 Y130.739 E.0352
G2 X122.538 Y129.64 I-.282 J-2.709 E.04717
G3 X123.882 Y128.903 I1.707 J1.522 E.03242
G1 X122.912 Y125.987 E.06375
G3 X121.627 Y127.003 I-3.305 J-2.859 E.03418
G3 X118.964 Y126.065 I-.646 J-2.416 E.06224
G1 X117.411 Y121.692 E.09627
G3 X118.896 Y122.719 I-1.078 J3.144 E.03793
G2 X122.083 Y122.81 I1.636 J-1.441 E.07415
G3 X122.915 Y122.022 I7.089 J6.658 E.02379
G1 X125.402 Y122.022 E.05157
G3 X126.634 Y123.122 I-13.996 J16.925 E.03428
G2 X129.366 Y122.81 I1.169 J-1.874 E.06154
G3 X130.198 Y122.022 I7.092 J6.661 E.02379
G1 X132.685 Y122.022 E.05157
G3 X133.918 Y123.122 I-13.99 J16.918 E.03428
G2 X136.649 Y122.81 I1.169 J-1.874 E.06154
G3 X138.014 Y121.714 I3.516 J2.981 E.03655
G1 X138.434 Y121.624 E.00889
G1 X136.661 Y126.753 E.11257
G3 X133.918 Y126.452 I-1.185 J-1.853 E.06189
G2 X133.013 Y125.6 I-7.668 J7.239 E.02579
G1 X131.896 Y128.957 E.0734
G3 X133.462 Y130.002 I-.938 J3.103 E.03963
G2 X135.284 Y130.738 I1.615 J-1.375 E.04237
G1 X134.18 Y133.933 E.07011
G3 X133.007 Y132.878 I16.625 J-19.664 E.03273
G2 X130.56 Y132.976 I-1.155 J1.765 E.05421
G1 X130.024 Y134.586 E.0352
; WIPE_START
G1 X130.56 Y132.976 E-.64485
G1 X130.827 Y132.833 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.649 Y134.215 Z2.4 F60000
G1 Z2
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.113 Y132.605 E.0352
G2 X122.993 Y133.19 I-.518 J2.257 E.04755
G3 X121.842 Y134.174 I-3.754 J-3.23 E.03153
G1 X122.75 Y136.734 E.05636
G3 X125.724 Y136.832 I1.436 J1.597 E.06818
G2 X126.84 Y137.797 I3.885 J-3.366 E.03071
G1 X127.155 Y138.742 E.02067
G1 X128.642 Y138.742 E.03085
G1 X129.006 Y137.648 E.02393
G2 X129.821 Y136.923 I-2.227 J-3.323 E.0227
G3 X133.135 Y136.959 I1.641 J1.47 E.0778
G1 X132.141 Y139.833 E.06308
G2 X130.276 Y140.473 I-.223 J2.388 E.04216
G3 X128.91 Y141.57 I-3.515 J-2.981 E.03655
G3 X126.179 Y140.564 I-.639 J-2.475 E.06422
G2 X123.885 Y139.933 I-1.607 J1.357 E.05245
G1 X125.312 Y143.951 E.08845
G1 X130.108 Y143.951 E.09949
G3 X130.862 Y143.535 I1.379 J1.606 E.01799
G1 X131.416 Y141.931 E.0352
M204 S10000
G1 X135.461 Y118.127 F60000
G1 F9000
M204 S4000
G1 X134.932 Y119.739 E.0352
G2 X137.104 Y119.078 I.576 J-2.006 E.0498
G3 X139.673 Y118.037 I2.089 J1.467 E.06077
G1 X140.616 Y115.307 E.05992
G2 X137.559 Y114.67 I-1.878 J1.36 E.07106
G3 X136.204 Y115.863 I-13.028 J-13.438 E.03746
G1 X136.733 Y114.251 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.204 Y115.863 E-.64486
G1 X136.446 Y115.68 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L17
M991 S0 P16 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.4 I-.756 J-.954 P1  F60000
G1 X123.325 Y126.079 Z2.4
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.52 F60000
G1 X119.605 Y114.987 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.52 F60000
G1 X141.28 Y114.497 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.655 Y112.049 Z2.52 F60000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.958 Y112.049 E.0352
G3 X134.828 Y112.412 I-1.336 J-1.408 E.04753
G3 X134.23 Y112.049 I.545 J-1.571 E.01463
G1 X129.675 Y112.049 E.09448
G3 X127.545 Y112.412 I-1.336 J-1.408 E.04753
G3 X126.947 Y112.049 I.545 J-1.57 E.01463
G1 X122.392 Y112.049 E.09448
G3 X120.262 Y112.412 I-1.336 J-1.408 E.04753
G3 X119.663 Y112.049 I.545 J-1.571 E.01463
G1 X115.109 Y112.049 E.09448
G3 X114.704 Y112.358 I-.725 J-.528 E.01071
G1 X114.704 Y114.084 E.03581
G1 X115.082 Y115.128 E.02301
G3 X116.165 Y114.347 I2.235 J1.961 E.02793
G3 X118.441 Y115.083 I.48 J2.405 E.05183
G2 X119.582 Y116.061 I2.962 J-2.302 E.03138
G1 X120.846 Y119.837 E.08261
G3 X118.896 Y118.586 I.497 J-2.921 E.04938
G2 X116.213 Y118.314 I-1.5 J1.42 E.06096
G1 X117.416 Y121.706 E.07465
G3 X118.896 Y122.847 I-1.585 J3.584 E.03914
G2 X121.627 Y123.094 I1.507 J-1.442 E.06207
G2 X122.777 Y122.022 I-23.937 J-26.809 E.03261
G1 X125.317 Y122.022 E.0527
G3 X126.634 Y123.24 I-206.039 J224.188 E.03721
G2 X129.366 Y122.709 I1.022 J-2.036 E.06208
G3 X130.06 Y122.022 I3.707 J3.049 E.0203
G1 X132.6 Y122.022 E.0527
G3 X133.918 Y123.24 I-205.528 J223.634 E.03721
G2 X136.649 Y122.709 I1.022 J-2.036 E.06208
G3 X138.014 Y121.63 I2.795 J2.134 E.03648
G1 X138.452 Y121.571 E.00915
G1 X136.611 Y126.899 E.11691
G3 X133.918 Y126.351 I-.985 J-2.051 E.06121
G2 X133.043 Y125.508 I-4.556 J3.852 E.02523
G1 X131.894 Y128.963 E.07553
G3 X133.462 Y130.131 I-1.4 J3.518 E.04102
G2 X135.28 Y130.751 I1.432 J-1.223 E.04179
G1 X134.201 Y133.873 E.06852
G2 X133.007 Y132.76 I-81.005 J85.657 E.03385
G2 X130.525 Y133.08 I-1.015 J1.913 E.05535
G1 X129.989 Y134.691 E.0352
; WIPE_START
G1 X130.525 Y133.08 E-.64485
G1 X130.781 Y132.919 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.624 Y134.141 Z2.52 F60000
G1 Z2.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.089 Y132.531 E.0352
G2 X122.993 Y133.291 I-.313 J2.407 E.04804
G3 X121.872 Y134.259 I-3.011 J-2.352 E.03093
G1 X122.717 Y136.64 E.05239
G1 X122.993 Y136.402 E.00756
G3 X125.724 Y136.932 I1.022 J2.036 E.06208
G2 X126.88 Y137.917 I2.932 J-2.272 E.03172
G1 X127.155 Y138.742 E.01805
G1 X128.642 Y138.742 E.03085
G1 X129.037 Y137.553 E.02599
G3 X130.276 Y136.402 I202.513 J216.63 E.03508
G3 X133.107 Y137.038 I1.018 J2.088 E.06501
G1 X132.158 Y139.785 E.06029
G1 X132.097 Y139.777 E.00128
G2 X129.821 Y141.055 I.138 J2.91 E.05615
G3 X128.455 Y141.714 I-1.481 J-1.325 E.03227
G3 X126.179 Y140.436 I.138 J-2.91 E.05615
G2 X123.892 Y139.952 I-1.487 J1.384 E.05166
G1 X125.312 Y143.951 E.08802
G1 X129.967 Y143.951 E.09657
G3 X130.889 Y143.459 I1.283 J1.292 E.02198
G1 X131.443 Y141.855 E.0352
; WIPE_START
G1 X130.889 Y143.459 E-.64486
G1 X130.604 Y143.564 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.097 Y137.405 Z2.52 F60000
G1 X120.062 Y129.159 Z2.52
G1 Z2.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.629 Y130.758 E.0352
G2 X122.538 Y129.511 I-.563 J-2.945 E.04851
G3 X123.867 Y128.857 I1.47 J1.309 E.0315
G1 X122.938 Y126.065 E.06103
G1 X122.538 Y126.489 E.0121
G3 X120.717 Y127.109 I-1.434 J-1.226 E.04187
G3 X118.893 Y125.867 I.98 J-3.399 E.04654
G1 X118.326 Y124.268 E.0352
; WIPE_START
G1 X118.893 Y125.867 E-.64485
G1 X119.113 Y126.076 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.975 Y122.735 Z2.52 F60000
G1 X135.465 Y118.114 Z2.52
G1 Z2.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.936 Y119.726 E.0352
M73 P38 R14
G2 X136.194 Y119.803 I.77 J-2.271 E.02645
G2 X137.559 Y118.725 I-1.429 J-3.213 E.03648
G3 X139.696 Y117.97 I1.783 J1.648 E.0489
G1 X140.586 Y115.395 E.05651
G1 X140.29 Y115.083 E.00891
G2 X137.559 Y114.553 I-1.709 J1.505 E.06208
G3 X136.231 Y115.779 I-169.706 J-182.361 E.0375
G1 X136.76 Y114.167 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.231 Y115.779 E-.64486
G1 X136.454 Y115.574 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L18
M991 S0 P17 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.52 I-.76 J-.95 P1  F60000
G1 X123.325 Y126.079 Z2.52
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.64 F60000
G1 X119.605 Y114.987 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.64 F60000
G1 X141.28 Y114.497 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.814 Y112.049 Z2.64 F60000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.117 Y112.049 E.0352
G3 X134.828 Y112.397 I-1.368 J-1.297 E.05173
G3 X134.31 Y112.049 I.418 J-1.182 E.01308
G1 X129.834 Y112.049 E.09284
G3 X127.545 Y112.397 I-1.368 J-1.297 E.05173
G3 X127.027 Y112.049 I.418 J-1.182 E.01308
G1 X122.551 Y112.049 E.09284
G3 X120.262 Y112.397 I-1.368 J-1.297 E.05173
G3 X119.744 Y112.049 I.418 J-1.182 E.01308
G1 X115.268 Y112.049 E.09284
G3 X114.704 Y112.48 I-2.569 J-2.774 E.01475
G1 X114.704 Y114.084 E.03328
G1 X115.045 Y115.024 E.02073
G3 X116.165 Y114.255 I1.951 J1.642 E.02852
G3 X117.986 Y114.754 I.319 J2.41 E.04021
G2 X119.351 Y116.087 I6.801 J-5.601 E.03966
G1 X119.624 Y116.187 E.00604
G1 X120.857 Y119.868 E.08051
G3 X119.807 Y119.397 I.568 J-2.675 E.02405
G2 X118.441 Y118.064 I-6.8 J5.6 E.03966
G2 X116.228 Y118.356 I-.856 J2.045 E.04853
G1 X117.419 Y121.714 E.0739
G3 X117.986 Y122.037 I-.486 J1.511 E.01362
G2 X119.351 Y123.37 I6.801 J-5.6 E.03966
G2 X121.627 Y123.039 I.86 J-2.076 E.05008
G3 X122.616 Y122.022 I5.161 J4.031 E.02948
G1 X125.269 Y122.037 E.05502
G2 X126.634 Y123.37 I6.8 J-5.599 E.03966
G2 X128.91 Y123.039 I.86 J-2.076 E.05008
G3 X129.899 Y122.022 I5.161 J4.031 E.02948
G1 X132.552 Y122.037 E.05502
G2 X133.918 Y123.37 I6.801 J-5.6 E.03966
G2 X136.194 Y123.039 I.86 J-2.076 E.05008
G3 X137.559 Y121.706 I6.8 J5.6 E.03966
G3 X138.471 Y121.515 I.91 J2.075 E.01946
G1 X136.561 Y127.044 E.12133
G3 X134.373 Y126.68 I-.775 J-2.101 E.04813
G2 X133.077 Y125.406 I-6.495 J5.308 E.03777
G1 X133.153 Y125.178 E.00499
G2 X131.965 Y125.178 I-.594 J13.507 E.02466
G1 X125.233 Y125.178 E.13963
M73 P38 R13
G2 X122.984 Y125.178 I-1.124 J39.955 E.04665
M204 S10000
G1 X118.255 Y124.069 F60000
G1 F9000
M204 S4000
G1 X118.823 Y125.668 E.0352
G3 X119.807 Y126.68 I-4.155 J5.021 E.02934
G2 X122.083 Y127.011 I1.416 J-1.745 E.05008
G2 X122.974 Y126.173 I-3.401 J-4.512 E.02544
G1 X123.848 Y128.801 E.05744
G2 X122.538 Y129.371 I-.041 J1.697 E.0306
G1 X121.627 Y130.322 E.0273
G3 X120.638 Y130.783 I-1.698 J-2.353 E.02277
G1 X120.07 Y129.184 E.0352
; WIPE_START
G1 X120.638 Y130.783 E-.64486
G1 X120.925 Y130.687 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.186 Y136.217 Z2.64 F60000
G1 X131.471 Y141.774 Z2.64
G1 Z2.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.916 Y143.378 E.0352
G2 X129.821 Y143.937 I.159 J1.664 E.02613
G1 X125.312 Y143.951 E.09353
G1 X123.897 Y139.966 E.08772
G3 X125.724 Y139.914 I.971 J1.991 E.03908
G3 X127.09 Y141.247 I-5.434 J6.933 E.03966
G2 X129.366 Y141.578 I1.416 J-1.745 E.05008
G2 X130.731 Y140.245 I-5.434 J-6.933 E.03966
G3 X132.178 Y139.727 I1.497 J1.904 E.03243
G1 X133.07 Y137.144 E.05668
G2 X130.731 Y136.104 I-2.057 J1.476 E.05567
G2 X129.821 Y136.654 I.308 J1.539 E.02251
G1 X129.079 Y137.43 E.02226
G1 X128.642 Y138.742 E.0287
G1 X127.155 Y138.742 E.03085
G1 X126.922 Y138.042 E.01532
G3 X126.179 Y137.554 I.306 J-1.274 E.0188
G1 X125.269 Y136.603 E.0273
G2 X122.993 Y136.272 I-1.416 J1.745 E.05008
G1 X122.68 Y136.535 E.00849
G1 X121.907 Y134.359 E.0479
G2 X122.538 Y133.912 I-.305 J-1.099 E.01635
G1 X123.448 Y132.961 E.0273
G3 X125.063 Y132.452 I1.478 J1.873 E.0359
G1 X125.598 Y134.063 E.0352
; WIPE_START
G1 X125.063 Y132.452 E-.64486
G1 X124.761 Y132.478 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.011 Y131.618 Z2.64 F60000
G1 Z2.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.476 Y133.228 E.0352
G3 X133.007 Y132.63 I1.674 J1.432 E.05771
G3 X134.223 Y133.808 I-4.793 J6.169 E.03518
G1 X135.272 Y130.772 E.06662
G3 X133.918 Y130.653 I-.513 J-1.937 E.02878
G3 X132.552 Y129.32 I5.435 J-6.934 E.03966
G2 X131.894 Y128.964 I-1.178 J1.389 E.01563
G1 X132.43 Y127.353 E.0352
M204 S10000
G1 X135.467 Y118.107 F60000
G1 F9000
M204 S4000
G1 X134.938 Y119.72 E.0352
G2 X136.649 Y119.728 I.864 J-1.84 E.03662
G2 X138.014 Y118.395 I-5.435 J-6.933 E.03966
G3 X139.723 Y117.891 I1.485 J1.884 E.03787
G1 X140.55 Y115.5 E.05248
G1 X139.835 Y114.754 E.02143
G2 X137.559 Y114.423 I-1.416 J1.745 E.05008
G2 X136.263 Y115.684 I5.138 J6.58 E.03759
G1 X135.733 Y117.296 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.263 Y115.684 E-.64486
G1 X136.472 Y115.465 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L19
M991 S0 P18 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.64 I-.764 J-.947 P1  F60000
G1 X123.325 Y126.079 Z2.64
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.76 F60000
G1 X119.605 Y114.987 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.76 F60000
G1 X141.28 Y114.497 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
M73 P39 R13
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.951 Y112.049 Z2.76 F60000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.254 Y112.049 E.0352
G3 X135.283 Y112.588 I-1.314 J-.932 E.0459
G3 X134.361 Y112.049 I1.384 J-3.42 E.02224
G1 X129.97 Y112.049 E.09108
G3 X128 Y112.588 I-1.314 J-.932 E.0459
G3 X127.078 Y112.049 I1.384 J-3.421 E.02224
G1 X122.687 Y112.049 E.09108
G3 X120.717 Y112.588 I-1.314 J-.932 E.0459
G3 X119.795 Y112.049 I1.384 J-3.421 E.02224
G1 X115.404 Y112.049 E.09108
G3 X114.704 Y112.618 I-1.896 J-1.616 E.01882
G1 X114.704 Y114.084 E.03041
G1 X115.011 Y114.928 E.01862
G3 X116.165 Y114.152 I1.596 J1.127 E.0295
G3 X117.986 Y114.806 I.103 J2.576 E.04114
G1 X118.896 Y115.864 E.02896
G2 X119.669 Y116.32 I.9 J-.643 E.01916
G1 X120.87 Y119.908 E.07849
G3 X119.807 Y119.345 I.779 J-2.758 E.02516
G1 X118.896 Y118.287 E.02896
G2 X117.531 Y117.811 I-1.118 J1.013 E.03128
G2 X116.241 Y118.393 I.489 J2.805 E.02966
G1 X117.42 Y121.714 E.0731
G3 X117.986 Y122.089 I-.618 J1.55 E.01418
G1 X118.896 Y123.147 E.02896
G2 X120.262 Y123.623 I1.118 J-1.013 E.03128
G2 X121.627 Y122.987 I-.516 J-2.892 E.0316
G1 X122.457 Y122.022 E.02639
G1 X125.176 Y122.022 E.05639
G1 X126.179 Y123.147 E.03128
G2 X127.545 Y123.623 I1.118 J-1.013 E.03128
G2 X128.91 Y122.987 I-.516 J-2.892 E.0316
G1 X129.74 Y122.022 E.02639
G1 X132.459 Y122.022 E.05639
G1 X133.462 Y123.147 E.03128
G2 X134.828 Y123.623 I1.118 J-1.013 E.03128
G2 X136.194 Y122.987 I-.516 J-2.892 E.0316
G1 X137.104 Y121.928 E.02896
G3 X138.491 Y121.458 I1.059 J.844 E.03209
G1 X136.508 Y127.197 E.12595
G3 X134.373 Y126.628 I-.527 J-2.311 E.04767
G1 X133.462 Y125.57 E.02896
G1 X133.116 Y125.289 E.00925
G1 X133.153 Y125.178 E.00242
G2 X132.097 Y125.094 I-1.116 J7.402 E.022
G1 X131.75 Y125.178 E.0074
G1 X125.643 Y125.178 E.12668
G2 X124.467 Y125.178 I-.588 J1.824 E.02479
G1 X122.77 Y125.178 E.0352
M204 S10000
G1 X118.176 Y123.847 F60000
G1 F9000
M204 S4000
G1 X118.744 Y125.446 E.0352
G1 X119.807 Y126.628 E.03297
G2 X122.083 Y127.159 I1.605 J-1.737 E.0507
G2 X123 Y126.251 I-2.063 J-3.004 E.02691
G1 X123.826 Y128.733 E.05425
G2 X122.538 Y129.211 I-.192 J1.457 E.02965
G1 X121.627 Y130.27 E.02896
G3 X120.649 Y130.813 I-1.969 J-2.397 E.02334
G1 X120.081 Y129.213 E.0352
; WIPE_START
G1 X120.649 Y130.813 E-.64486
G1 X120.928 Y130.696 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.56 Y130.603 Z2.76 F60000
G1 X131.36 Y130.568 Z2.76
G1 Z2.36
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X131.896 Y128.958 E.0352
G3 X132.552 Y129.372 I-.669 J1.786 E.01621
G1 X133.462 Y130.43 E.02896
G2 X134.828 Y130.906 I1.118 J-1.013 E.03128
G1 X135.262 Y130.801 E.00926
G1 X134.241 Y133.758 E.06488
G2 X133.007 Y132.483 I-4.158 J2.79 E.03699
G2 X130.431 Y133.362 I-.668 J2.257 E.0602
G1 X129.896 Y134.973 E.0352
; WIPE_START
G1 X130.431 Y133.362 E-.64485
G1 X130.629 Y133.133 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.57 Y133.979 Z2.76 F60000
G1 Z2.36
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.035 Y132.369 E.0352
G2 X123.448 Y133.014 I.102 J2.525 E.03624
G1 X122.538 Y134.072 E.02896
G1 X122.083 Y134.442 E.01217
G1 X121.949 Y134.478 E.00286
G1 X122.637 Y136.414 E.04262
G1 X122.993 Y136.125 E.00952
G3 X125.269 Y136.655 I.671 J2.268 E.0507
G1 X126.179 Y137.714 E.02896
G2 X126.965 Y138.173 I.911 J-.656 E.01945
G1 X127.155 Y138.742 E.01244
G1 X128.642 Y138.742 E.03085
G1 X129.118 Y137.312 E.03127
G1 X129.821 Y136.495 E.02237
G3 X130.731 Y136.001 I1.011 J.779 E.02212
G3 X133.042 Y137.225 I.052 J2.696 E.05664
G1 X132.202 Y139.657 E.05336
G2 X130.731 Y140.297 I.229 J2.538 E.03385
G1 X129.821 Y141.355 E.02896
G1 X129.366 Y141.725 E.01217
G3 X127.09 Y141.195 I-.671 J-2.268 E.0507
G1 X126.179 Y140.136 E.02896
G1 X125.724 Y139.766 E.01217
G2 X123.9 Y139.974 I-.67 J2.235 E.03914
G1 X125.312 Y143.951 E.08755
G1 X129.568 Y143.951 E.08828
G1 X129.821 Y143.778 E.00636
G3 X130.946 Y143.293 I1.072 J.94 E.02627
G1 X131.5 Y141.689 E.0352
M204 S10000
G1 X135.467 Y118.107 F60000
G1 F9000
M204 S4000
G1 X134.938 Y119.719 E.0352
G2 X135.738 Y119.981 I1.12 J-2.071 E.01756
G2 X137.104 Y119.506 I.247 J-1.488 E.03128
G1 X138.014 Y118.447 E.02896
G3 X139.756 Y117.797 I1.702 J1.9 E.03947
G1 X140.516 Y115.597 E.04827
G1 X139.835 Y114.806 E.02165
G2 X137.559 Y114.275 I-1.605 J1.738 E.0507
G2 X136.295 Y115.586 I3.01 J4.169 E.03798
G1 X135.766 Y117.198 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.295 Y115.586 E-.64486
G1 X136.492 Y115.356 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L20
M991 S0 P19 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.76 I-.768 J-.944 P1  F60000
G1 X123.325 Y126.079 Z2.76
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z2.88 F60000
G1 X119.605 Y114.987 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z2.88 F60000
G1 X141.28 Y114.497 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.08 Y112.049 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.383 Y112.049 E.0352
G3 X136.649 Y112.765 I-1.662 J-.968 E.02153
G1 X136.194 Y112.832 E.00954
G3 X134.417 Y112.049 I.227 J-2.921 E.04105
G1 X130.099 Y112.049 E.08956
G3 X129.366 Y112.765 I-1.662 J-.968 E.02153
G1 X128.91 Y112.832 E.00954
G3 X127.134 Y112.049 I.227 J-2.921 E.04105
G1 X122.816 Y112.049 E.08956
G3 X122.083 Y112.765 I-1.662 J-.968 E.02153
G1 X121.627 Y112.832 E.00954
G3 X119.851 Y112.049 I.227 J-2.921 E.04105
G1 X115.533 Y112.049 E.08956
G3 X114.704 Y112.779 I-1.629 J-1.013 E.02325
G1 X114.704 Y114.084 E.02707
G1 X114.974 Y114.822 E.01629
G3 X115.71 Y114.102 I1.67 J.971 E.02162
G1 X116.165 Y114.036 E.00954
G3 X117.986 Y114.855 I-.24 J2.965 E.04224
G1 X118.896 Y116.058 E.0313
G1 X119.351 Y116.407 E.01189
G1 X119.716 Y116.46 E.00764
G1 X120.882 Y119.943 E.07619
G3 X119.807 Y119.296 I.765 J-2.488 E.0263
G1 X118.896 Y118.092 E.0313
G1 X118.441 Y117.744 E.01189
G1 X117.986 Y117.677 E.00954
G2 X116.252 Y118.425 I.216 J2.883 E.0399
G1 X117.417 Y121.707 E.07222
G3 X117.986 Y122.138 I-.755 J1.586 E.01492
G1 X118.896 Y123.342 E.0313
G1 X119.351 Y123.69 E.01189
G1 X119.807 Y123.757 E.00954
G2 X121.627 Y122.937 I-.24 J-2.965 E.04224
G1 X122.32 Y122.022 E.02381
G1 X125.127 Y122.022 E.05823
G1 X126.179 Y123.342 E.03501
G1 X126.634 Y123.69 E.01189
G1 X127.09 Y123.757 E.00954
G2 X128.91 Y122.937 I-.24 J-2.965 E.04224
G1 X129.603 Y122.022 E.02381
G1 X132.41 Y122.022 E.05823
G1 X133.462 Y123.342 E.03501
G1 X133.918 Y123.69 E.01189
G1 X134.373 Y123.757 E.00954
G2 X136.194 Y122.937 I-.24 J-2.965 E.04224
G1 X137.104 Y121.734 E.0313
G1 X137.559 Y121.386 E.01189
G3 X138.5 Y121.431 I.413 J1.226 E.02
G1 X136.451 Y127.361 E.13014
G1 X136.194 Y127.398 E.0054
G3 X134.373 Y126.579 I.24 J-2.965 E.04224
G1 X133.462 Y125.376 E.0313
G1 X133.007 Y125.027 E.01189
G1 X132.552 Y124.96 E.00954
G1 X131.627 Y125.178 E.01971
G1 X125.921 Y125.178 E.11835
G2 X125.269 Y124.96 I-.522 J.478 E.01489
G1 X124.344 Y125.178 E.01971
G1 X122.647 Y125.178 E.0352
M204 S10000
G1 X120.092 Y129.244 F60000
G1 F9000
M204 S4000
G1 X120.66 Y130.843 E.0352
G2 X121.627 Y130.22 I-1.137 J-2.83 E.02402
G1 X122.538 Y129.017 E.0313
G3 X123.81 Y128.685 I.882 J.775 E.02894
G1 X123.028 Y126.335 E.05138
G3 X122.083 Y127.331 I-2.275 J-1.211 E.02884
G3 X119.807 Y126.579 I-.414 J-2.565 E.05168
G1 X118.896 Y125.376 E.0313
G1 X118.653 Y125.189 E.00636
G1 X118.085 Y123.59 E.0352
; WIPE_START
G1 X118.653 Y125.189 E-.64485
G1 X118.893 Y125.374 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.559 Y117.925 Z2.88 F60000
G1 X121.418 Y114.084 Z2.88
G1 Z2.48
M73 P40 R13
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.115 Y114.084 E.0352
G3 X123.66 Y114.084 I.273 J.697 E.01157
G1 X130.398 Y114.084 E.13977
G3 X130.943 Y114.084 I.273 J.697 E.01157
G1 X132.64 Y114.084 E.0352
; WIPE_START
G1 X130.943 Y114.084 E-.64486
G1 X130.731 Y114.036 E-.08276
G1 X130.647 Y114.048 E-.03239
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.803 Y117.083 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.333 Y115.471 E.0352
G1 X137.104 Y114.451 E.02652
G1 X137.559 Y114.102 E.01189
G1 X138.014 Y114.036 E.00954
G3 X139.835 Y114.855 I-.24 J2.965 E.04224
G1 X140.478 Y115.705 E.02212
G1 X139.794 Y117.687 E.04348
G2 X138.014 Y118.497 I.254 J2.919 E.04135
G1 X137.104 Y119.7 E.0313
G1 X136.649 Y120.048 E.01189
G1 X136.194 Y120.115 E.00954
G1 X135.283 Y119.905 E.01938
G1 X134.937 Y119.725 E.00811
G1 X135.466 Y118.112 E.0352
M204 S10000
G1 X131.364 Y130.557 F60000
G1 F9000
M204 S4000
G1 X131.9 Y128.946 E.0352
G3 X132.552 Y129.421 I-.818 J1.808 E.01685
G1 X133.462 Y130.625 E.0313
G1 X133.918 Y130.973 E.01189
G1 X134.373 Y131.04 E.00954
G1 X135.25 Y130.838 E.01866
G1 X134.257 Y133.709 E.06302
G1 X133.462 Y132.659 E.02733
G1 X133.007 Y132.31 E.01189
G1 X132.552 Y132.243 E.00954
G2 X130.731 Y133.063 I.24 J2.965 E.04224
G1 X130.374 Y133.536 E.0123
G1 X129.838 Y135.146 E.0352
; WIPE_START
G1 X130.374 Y133.536 E-.64485
G1 X130.556 Y133.294 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.548 Y133.913 Z2.88 F60000
G1 Z2.48
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.013 Y132.302 E.0352
G2 X123.448 Y133.063 I.34 J2.689 E.03674
G1 X122.538 Y134.266 E.0313
G1 X122.002 Y134.626 E.01339
G1 X122.584 Y136.265 E.03607
G1 X122.993 Y135.952 E.01069
G3 X125.269 Y136.705 I.414 J2.565 E.05168
G1 X126.179 Y137.908 E.0313
G1 X126.634 Y138.256 E.01189
G1 X127.011 Y138.312 E.0079
G1 X127.155 Y138.742 E.00942
G1 X128.642 Y138.742 E.03085
G1 X129.167 Y137.165 E.03448
G1 X129.821 Y136.3 E.02249
G1 X130.276 Y135.952 E.01189
G3 X133.012 Y137.313 I.402 J2.622 E.06755
G1 X132.221 Y139.603 E.05026
G2 X130.731 Y140.346 I.375 J2.616 E.03513
G1 X129.821 Y141.549 E.0313
G1 X129.366 Y141.898 E.01189
G3 X127.09 Y141.145 I-.414 J-2.565 E.05168
G1 X126.179 Y139.942 E.0313
G1 X125.724 Y139.593 E.01189
G1 X125.269 Y139.527 E.00954
G2 X123.901 Y139.976 I.412 J3.561 E.03007
G1 X125.312 Y143.951 E.0875
G1 X129.412 Y143.951 E.08505
G1 X129.821 Y143.583 E.01141
G3 X130.97 Y143.223 I.864 J.744 E.02632
G1 X131.524 Y141.619 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.97 Y143.223 E-.64486
G1 X130.731 Y143.168 E-.0931
G1 X130.674 Y143.177 E-.02205
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L21
M991 S0 P20 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z2.88 I1.118 J-.481 P1  F60000
G1 X123.325 Y126.079 Z2.88
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3 F60000
G1 X119.605 Y114.987 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3 F60000
G1 X141.28 Y114.497 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.18 Y112.049 Z3 F60000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.483 Y112.049 E.0352
G1 X137.104 Y112.68 E.01528
G1 X136.649 Y112.977 E.01127
G1 X136.194 Y112.964 E.00945
G3 X134.462 Y112.049 I.556 J-3.148 E.04129
G1 X130.2 Y112.049 E.0884
G1 X129.821 Y112.68 E.01528
G1 X129.366 Y112.977 E.01127
G1 X128.91 Y112.964 E.00945
G3 X127.179 Y112.049 I.556 J-3.148 E.04129
G1 X122.917 Y112.049 E.0884
G1 X122.538 Y112.68 E.01528
G1 X122.083 Y112.977 E.01127
G1 X121.627 Y112.964 E.00945
G3 X119.896 Y112.049 I.556 J-3.148 E.04129
G1 X115.634 Y112.049 E.0884
G1 X115.255 Y112.68 E.01528
G1 X114.799 Y112.977 E.01127
G1 X114.704 Y112.974 E.00198
G1 X114.704 Y114.084 E.02303
G1 X114.936 Y114.718 E.01399
G3 X115.71 Y113.891 I1.237 J.383 E.0243
G3 X117.531 Y114.478 I-.194 J3.72 E.04013
G3 X118.896 Y116.322 I-4.526 J4.78 E.04783
G1 X119.351 Y116.618 E.01127
G1 X119.765 Y116.607 E.00858
G1 X118.92 Y114.084 E.05518
G1 X122.696 Y114.084 E.07832
G1 X122.993 Y113.891 E.00735
G3 X123.997 Y114.084 I.179 J1.775 E.02152
G1 X129.979 Y114.084 E.12408
G1 X130.276 Y113.891 E.00735
G3 X131.281 Y114.084 I.179 J1.775 E.02152
G1 X132.978 Y114.084 E.0352
; WIPE_START
G1 X131.281 Y114.084 E-.64486
G1 X130.993 Y113.99 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.844 Y116.958 Z3 F60000
G1 Z2.6
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.374 Y115.346 E.0352
G2 X137.104 Y114.188 I-8.997 J-6.485 E.02842
G1 X137.559 Y113.891 E.01127
G1 X138.014 Y113.904 E.00945
G3 X140.441 Y115.814 I-.647 J3.318 E.06653
G1 X139.835 Y117.545 E.03804
G2 X137.559 Y119.205 I.516 J3.097 E.0606
G1 X137.104 Y119.963 E.01834
G1 X136.649 Y120.26 E.01127
G1 X136.194 Y120.247 E.00945
G3 X134.933 Y119.736 I.489 J-3.016 E.02846
G1 X135.462 Y118.124 E.0352
; WIPE_START
G1 X134.933 Y119.736 E-.64485
G1 X135.192 Y119.893 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.794 Y121.768 Z3 F60000
G1 X126.791 Y122.022 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.094 Y122.022 E.0352
G3 X126.179 Y123.605 I-5.814 J5.151 E.03991
G1 X126.634 Y123.901 E.01127
G1 X127.09 Y123.889 E.00945
G2 X129.49 Y122.022 I-.634 J-3.292 E.06546
G1 X132.377 Y122.022 E.05989
G3 X133.462 Y123.605 I-5.814 J5.151 E.03991
G1 X133.918 Y123.901 E.01127
G1 X134.373 Y123.889 E.00945
G2 X136.649 Y122.229 I-.516 J-3.097 E.0606
G1 X137.104 Y121.471 E.01834
G1 X137.559 Y121.174 E.01127
G3 X138.526 Y121.355 I.181 J1.707 E.0207
G1 X136.391 Y127.536 E.13564
G1 X136.194 Y127.53 E.00409
G3 X133.918 Y125.87 I.516 J-3.097 E.0606
G1 X133.462 Y125.112 E.01834
G1 X133.007 Y124.816 E.01127
G1 X132.552 Y124.828 E.00945
G1 X131.559 Y125.178 E.02183
G1 X126.219 Y125.178 E.11078
G1 X125.724 Y124.816 E.01272
G1 X125.269 Y124.828 E.00945
G1 X124.276 Y125.178 E.02183
G1 X122.643 Y125.178 E.03387
G1 X122.664 Y125.239 E.00133
M204 S10000
G1 X120.107 Y129.287 F60000
G1 F9000
M204 S4000
G1 X120.675 Y130.886 E.0352
G2 X122.083 Y129.512 I-1.329 J-2.77 E.04154
G1 X122.538 Y128.754 E.01834
G1 X122.993 Y128.457 E.01127
G3 X123.774 Y128.577 I.19 J1.365 E.01662
G1 X123.051 Y126.404 E.0475
G2 X122.538 Y127.246 I6.557 J4.573 E.02047
G1 X122.083 Y127.543 E.01127
G1 X121.627 Y127.53 E.00945
G3 X119.351 Y125.87 I.516 J-3.097 E.0606
G1 X118.896 Y125.112 E.01834
G1 X118.544 Y124.883 E.00872
G1 X117.41 Y121.689 E.0703
G3 X118.441 Y122.847 I-2.054 J2.865 E.03242
G1 X118.896 Y123.605 E.01834
G1 X119.351 Y123.901 E.01127
G1 X119.807 Y123.889 E.00945
G2 X122.207 Y122.022 I-.634 J-3.292 E.06546
G1 X121.578 Y122.022 E.01304
G1 X120.904 Y120.009 E.04403
G3 X119.351 Y118.587 I1.099 J-2.759 E.04464
G1 X118.896 Y117.829 E.01834
G1 X118.441 Y117.533 E.01127
G1 X117.986 Y117.545 E.00945
G2 X116.262 Y118.453 I.554 J3.141 E.04107
G1 X115.695 Y116.854 E.0352
; WIPE_START
G1 X116.262 Y118.453 E-.64485
G1 X116.484 Y118.247 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.369 Y123.106 Z3 F60000
G1 X131.37 Y130.539 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X131.906 Y128.929 E.0352
G3 X133.007 Y130.13 I-1.862 J2.813 E.03414
G1 X133.462 Y130.888 E.01834
G1 X133.918 Y131.185 E.01127
G1 X134.373 Y131.172 E.00945
G1 X135.232 Y130.889 E.01876
G1 X134.272 Y133.668 E.06099
G3 X133.462 Y132.395 I9.884 J-7.179 E.0313
G1 X133.007 Y132.099 E.01127
G1 X132.552 Y132.111 E.00945
G2 X130.313 Y133.718 I.507 J3.07 E.05922
G1 X129.777 Y135.328 E.0352
; WIPE_START
G1 X130.313 Y133.718 E-.64485
G1 X130.485 Y133.468 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.516 Y133.817 Z3 F60000
G1 Z2.6
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X124.981 Y132.206 E.0352
G2 X123.903 Y132.686 I.511 J2.599 E.02467
G2 X122.538 Y134.529 I4.526 J4.78 E.04783
G1 X122.073 Y134.826 E.01143
G1 X122.516 Y136.074 E.02746
G1 X122.993 Y135.74 E.01207
G3 X124.814 Y136.327 I-.194 J3.719 E.04013
G3 X126.179 Y138.171 I-4.526 J4.78 E.04783
G1 X126.634 Y138.468 E.01127
G1 X127.059 Y138.456 E.00882
G1 X127.155 Y138.742 E.00626
G1 X128.642 Y138.742 E.03085
G3 X129.821 Y136.037 I7.814 J1.796 E.06156
G1 X130.276 Y135.74 E.01127
G3 X132.987 Y137.384 I-.006 J3.068 E.06912
G1 X132.26 Y139.491 E.04623
G2 X131.186 Y139.969 I.51 J2.588 E.02458
G2 X129.821 Y141.813 I4.526 J4.78 E.04783
G1 X129.366 Y142.109 E.01127
G3 X127.545 Y141.522 I.194 J-3.72 E.04013
G3 X126.179 Y139.679 I4.526 J-4.78 E.04783
G1 X125.724 Y139.382 E.01127
G1 X125.269 Y139.395 E.00945
G2 X123.9 Y139.973 I.904 J4.054 E.031
G1 X125.312 Y143.951 E.08757
G1 X129.442 Y143.951 E.08567
G1 X129.821 Y143.32 E.01527
G3 X131.004 Y143.126 I.727 J.73 E.02653
G1 X131.558 Y141.522 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X131.004 Y143.126 E-.64486
G1 X130.731 Y143.036 E-.10897
G1 X130.715 Y143.036 E-.00617
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L22
M991 S0 P21 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3 I1.116 J-.486 P1  F60000
G1 X123.325 Y126.079 Z3
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P41 R13
G1 X121.732 Y120.698 Z3.12 F60000
G1 X119.605 Y114.987 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.12 F60000
G1 X141.28 Y114.497 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.294 Y112.049 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.597 Y112.049 E.0352
G2 X137.104 Y113.207 I4.671 J2.67 E.02617
G3 X136.194 Y113.115 I-.349 J-1.103 E.01951
G3 X134.494 Y112.049 I.986 J-3.459 E.04219
G1 X130.313 Y112.049 E.08671
G2 X129.821 Y113.207 I4.671 J2.67 E.02617
G3 X128.91 Y113.115 I-.349 J-1.103 E.01951
G3 X127.211 Y112.049 I.986 J-3.459 E.04219
G1 X123.03 Y112.049 E.08671
G2 X122.538 Y113.207 I4.671 J2.67 E.02617
G3 X121.627 Y113.115 I-.349 J-1.103 E.01951
G3 X119.927 Y112.049 I.986 J-3.459 E.04219
G1 X115.747 Y112.049 E.08671
G2 X115.255 Y113.207 I4.671 J2.67 E.02617
G3 X114.704 Y113.226 I-.298 J-.629 E.01175
G1 X114.704 Y114.084 E.0178
G1 X114.88 Y114.559 E.0105
G1 X115.255 Y113.661 E.02019
G3 X116.165 Y113.752 I.349 J1.103 E.01951
G3 X117.986 Y114.947 I-1.04 J3.57 E.04584
G3 X118.896 Y116.849 I-7.618 J4.816 E.04383
G2 X119.814 Y116.754 I.289 J-1.693 E.01938
G1 X118.92 Y114.084 E.05838
G1 X122.361 Y114.084 E.07137
G1 X122.538 Y113.661 E.00952
G1 X122.993 Y113.612 E.0095
G3 X124.204 Y114.084 I-1.451 J5.506 E.02702
G1 X129.644 Y114.084 E.11285
G1 X129.821 Y113.661 E.00952
G1 X130.276 Y113.612 E.0095
G3 X131.487 Y114.084 I-1.451 J5.506 E.02702
G1 X133.184 Y114.084 E.0352
; WIPE_START
G1 X131.487 Y114.084 E-.64486
G1 X131.205 Y113.974 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.926 Y116.71 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.455 Y115.097 E.0352
G2 X137.104 Y113.661 I-5.774 J-3.473 E.03277
G3 X138.014 Y113.752 I.349 J1.103 E.01951
G3 X140.384 Y115.98 I-.932 J3.364 E.07017
G1 X139.902 Y117.373 E.03058
G2 X137.559 Y119.398 I.881 J3.388 E.06654
G1 X137.104 Y120.49 E.02454
G3 X136.194 Y120.398 I-.349 J-1.103 E.01951
G3 X134.927 Y119.754 I1.066 J-3.662 E.02965
G1 X135.456 Y118.141 E.0352
; WIPE_START
G1 X134.927 Y119.754 E-.64486
G1 X135.177 Y119.925 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.636 Y118.745 Z3.12 F60000
G1 X115.703 Y116.878 Z3.12
G1 Z2.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X116.271 Y118.477 E.0352
G3 X117.986 Y117.394 I2.706 J2.387 E.04265
G3 X118.896 Y117.302 I.562 J1.011 E.01951
G2 X119.807 Y119.204 I8.527 J-2.914 E.04383
G2 X120.932 Y120.093 I2.407 J-1.89 E.03003
G1 X121.578 Y122.022 E.0422
G1 X122.088 Y122.022 E.01058
G3 X119.807 Y124.04 I-3.191 J-1.309 E.06544
G3 X118.896 Y124.132 I-.562 J-1.011 E.01951
G2 X117.986 Y122.23 I-8.528 J2.915 E.04383
G2 X117.4 Y121.658 I-1.617 J1.07 E.01712
G1 X116.832 Y120.059 E.0352
M204 S10000
G1 X120.124 Y129.335 F60000
G1 F9000
M204 S4000
G1 X120.692 Y130.934 E.0352
G2 X121.627 Y130.128 I-1.917 J-3.173 E.02573
G2 X122.538 Y128.227 I-7.617 J-4.816 E.04383
G3 X123.729 Y128.442 I.284 J1.831 E.02558
G1 X123.087 Y126.513 E.04216
G2 X122.538 Y127.773 I5.074 J2.964 E.02858
G3 X121.627 Y127.681 I-.349 J-1.103 E.01951
G3 X119.807 Y126.487 I1.04 J-3.57 E.04584
G3 X118.896 Y124.585 I7.617 J-4.816 E.04383
G1 X118.423 Y124.542 E.00985
G1 X118.991 Y126.141 E.0352
M204 S10000
G1 X122.684 Y125.3 F60000
G1 F9000
M204 S4000
G1 X122.643 Y125.178 E.00267
G1 X124.212 Y125.178 E.03253
G3 X125.269 Y124.677 I1.849 J2.537 E.02441
G3 X126.179 Y124.585 I.562 J1.011 E.01951
G1 X126.426 Y125.178 E.01331
G1 X131.495 Y125.178 E.10514
G3 X132.552 Y124.677 I1.849 J2.537 E.02441
G3 X133.462 Y124.585 I.562 J1.011 E.01951
G1 X133.918 Y125.677 E.02454
G2 X136.326 Y127.722 I3.241 J-1.376 E.06796
G1 X138.555 Y121.273 E.14154
G2 X137.104 Y120.944 I-1.176 J1.824 E.03149
G1 X136.649 Y122.036 E.02454
G3 X134.373 Y124.04 I-3.204 J-1.344 E.06509
G3 X133.462 Y124.132 I-.562 J-1.011 E.01951
G2 X132.552 Y122.23 I-8.528 J2.915 E.04383
G1 X132.356 Y122.022 E.00594
G1 X129.371 Y122.022 E.0619
G3 X127.09 Y124.04 I-3.191 J-1.309 E.06544
G3 X126.179 Y124.132 I-.562 J-1.011 E.01951
G2 X125.269 Y122.23 I-8.529 J2.915 E.04383
G1 X125.072 Y122.022 E.00594
G1 X126.769 Y122.022 E.0352
; WIPE_START
G1 X125.072 Y122.022 E-.64486
G1 X125.269 Y122.23 E-.10876
G1 X125.277 Y122.245 E-.00638
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.518 Y126.639 Z3.12 F60000
G1 X132.449 Y127.295 Z3.12
G1 Z2.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X131.913 Y128.905 E.0352
G3 X133.007 Y130.323 I-2.058 J2.719 E.03758
G1 X133.462 Y131.415 E.02454
G2 X134.373 Y131.323 I.349 J-1.103 E.01951
G1 X135.209 Y130.956 E.01894
G1 X134.288 Y133.62 E.05847
G3 X133.462 Y131.869 I7.022 J-4.382 E.04025
G2 X132.552 Y131.96 I-.349 J1.103 E.01951
G2 X130.276 Y133.964 I.928 J3.349 E.06509
G2 X129.831 Y135.168 I7.903 J3.608 E.02664
; WIPE_START
G1 X130.276 Y133.964 E-.48754
G1 X130.627 Y133.34 E-.27246
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.482 Y133.712 Z3.12 F60000
G1 Z2.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X124.946 Y132.102 E.0352
G2 X123.448 Y133.155 I1.071 J3.116 E.03849
G2 X122.538 Y135.056 I7.618 J4.816 E.04383
G1 X122.169 Y135.096 E.0077
G1 X122.418 Y135.798 E.01544
G1 X122.538 Y135.51 E.00646
G3 X123.448 Y135.602 I.349 J1.103 E.01951
G3 X125.269 Y136.796 I-1.04 J3.57 E.04584
G3 X126.179 Y138.698 I-7.618 J4.816 E.04383
G2 X127.107 Y138.599 I.289 J-1.683 E.0196
G1 X127.155 Y138.742 E.00314
G1 X128.642 Y138.742 E.03085
G3 X129.821 Y135.51 I22.31 J6.306 E.07143
G3 X130.731 Y135.602 I.349 J1.103 E.01951
G3 X132.948 Y137.5 I-.909 J3.304 E.06252
G1 X132.308 Y139.351 E.04061
G2 X130.731 Y140.438 I1.058 J3.221 E.04028
G2 X129.821 Y142.339 I7.617 J4.816 E.04383
G3 X128.91 Y142.248 I-.349 J-1.103 E.01951
G3 X127.09 Y141.053 I1.04 J-3.57 E.04584
G3 X126.179 Y139.152 I7.618 J-4.816 E.04383
G1 X125.724 Y139.103 E.0095
G2 X123.896 Y139.963 I1.406 J5.358 E.04214
G1 X125.312 Y143.951 E.08778
G1 X129.307 Y143.951 E.08288
G1 X129.821 Y142.793 E.02627
G3 X131.04 Y143.021 I.283 J1.863 E.02621
G1 X131.594 Y141.417 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X131.04 Y143.021 E-.64486
G1 X130.755 Y142.918 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L23
M991 S0 P22 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.12 I1.113 J-.491 P1  F60000
G1 X123.325 Y126.079 Z3.12
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.24 F60000
G1 X119.605 Y114.987 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.24 F60000
G1 X141.28 Y114.497 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
M73 P42 R13
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.064 Y120.375 Z3.24 F60000
G1 X138.034 Y122.779 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.589 Y121.175 E.0352
G2 X137.794 Y120.717 I-3.953 J5.94 E.01903
G1 X137.516 Y120.262 E.01107
G3 X138.146 Y118.441 I3.964 J.354 E.04037
G3 X139.993 Y117.112 I4.628 J4.48 E.04744
G1 X140.305 Y116.206 E.01986
G2 X139.703 Y114.799 I-5.449 J1.5 E.03184
G2 X137.794 Y113.434 I-4.735 J4.601 E.04894
G1 X137.516 Y112.979 E.01107
G3 X137.713 Y112.049 I1.8 J-.104 E.01995
G1 X134.505 Y112.068 E.06654
G2 X136.414 Y113.434 I4.734 J-4.601 E.04894
G1 X136.692 Y113.889 E.01107
G1 X136.679 Y114.084 E.00406
G1 X136.787 Y114.084 E.00225
G1 X134.917 Y119.784 E.12441
G2 X136.414 Y120.717 I8.475 J-11.921 E.03661
G1 X136.692 Y121.172 E.01107
G3 X136.062 Y122.993 I-3.964 J-.354 E.04037
G3 X134.153 Y124.359 I-4.734 J-4.601 E.04894
G1 X133.874 Y124.814 E.01107
G2 X134.505 Y126.635 I3.964 J-.354 E.04037
G2 X136.261 Y127.912 I4.477 J-4.308 E.04527
G1 X135.185 Y131.026 E.06833
G3 X134.153 Y131.642 I-5.286 J-7.683 E.02495
G1 X133.874 Y132.097 E.01107
G1 X133.906 Y132.552 E.00946
G1 X134.3 Y133.586 E.02296
G1 X133.746 Y135.19 E.0352
; WIPE_START
G1 X134.3 Y133.586 E-.64485
G1 X134.192 Y133.303 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.976 Y128.875 Z3.24 F60000
G1 X122.787 Y125.178 Z3.24
G1 Z2.84
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X122.643 Y125.178 E.00298
G1 X123.134 Y126.652 E.03222
G2 X122.949 Y127.545 I1.541 J.783 E.01914
G2 X123.666 Y128.252 I1.007 J-.304 E.02178
G1 X124.905 Y131.978 E.08145
G2 X123.58 Y133.007 I2.57 J4.675 E.03494
G2 X122.949 Y134.828 I3.334 J2.174 E.04037
G1 X123.228 Y135.283 E.01107
G3 X125.137 Y136.649 I-2.825 J5.967 E.04894
G3 X125.768 Y138.47 I-3.333 J2.174 E.04037
G1 X125.489 Y138.925 E.01107
G2 X123.895 Y139.96 I3.891 J7.734 E.0395
G1 X123.328 Y138.361 E.0352
M204 S10000
G1 X126.629 Y137.162 F60000
G1 F9000
M204 S4000
G1 X127.186 Y138.742 E.03476
G2 X126.622 Y139.835 I.267 J.83 E.02831
G2 X128.34 Y142.111 I3.144 J-.586 E.06131
G1 X129.131 Y142.566 E.01892
G1 X129.409 Y143.022 E.01107
G3 X129.212 Y143.951 I-1.8 J.104 E.01995
G1 X130.718 Y143.951 E.03124
G1 X131.083 Y142.896 E.02316
G1 X130.511 Y142.566 E.01369
G1 X130.232 Y142.111 E.01107
G1 X130.264 Y141.656 E.00946
G3 X131.982 Y139.38 I3.144 J.586 E.06131
G1 X132.376 Y139.153 E.00945
G1 X132.894 Y137.655 E.03287
G2 X131.301 Y135.738 I-2.899 J.788 E.0533
G1 X130.511 Y135.283 E.01892
G1 X130.232 Y134.828 E.01107
G1 X130.264 Y134.373 E.00946
G3 X131.982 Y132.097 I3.144 J.586 E.06131
G1 X132.772 Y131.642 E.01892
G1 X133.051 Y131.186 E.01107
G1 X133.019 Y130.731 E.00946
G2 X131.925 Y128.87 I-3.103 J.572 E.0457
G1 X133.153 Y125.178 E.08071
G1 X131.434 Y125.178 E.03565
G3 X132.772 Y124.359 I7.014 J9.95 E.03256
G1 X133.051 Y123.903 E.01107
G1 X133.019 Y123.448 E.00946
G2 X132.362 Y122.022 I-3.512 J.754 E.03283
G1 X129.24 Y122.022 E.06476
G3 X127.66 Y123.903 I-2.881 J-.815 E.05251
G1 X126.87 Y124.359 E.01892
G1 X126.591 Y124.814 E.01107
G1 X126.616 Y125.178 E.00757
G1 X124.151 Y125.178 E.05112
G3 X125.489 Y124.359 I7.013 J9.948 E.03256
G1 X125.768 Y123.903 E.01107
G1 X125.736 Y123.448 E.00946
G2 X125.079 Y122.022 I-3.512 J.754 E.03283
G1 X126.776 Y122.022 E.0352
; WIPE_START
G1 X125.079 Y122.022 E-.64486
G1 X125.246 Y122.275 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.507 Y115.943 Z3.24 F60000
G1 X132.127 Y112.049 Z3.24
G1 Z2.84
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.43 Y112.049 E.0352
G2 X130.232 Y112.979 I1.603 J.826 E.01995
G1 X130.511 Y113.434 E.01107
G3 X131.595 Y114.084 I-4.496 J8.72 E.02624
G1 X129.396 Y114.084 E.04562
G1 X129.409 Y113.889 E.00406
G1 X129.131 Y113.434 E.01107
G1 X128.34 Y112.979 E.01892
G3 X127.21 Y112.049 I2.07 J-3.669 E.03052
G1 X123.147 Y112.049 E.08428
G2 X122.949 Y112.979 I1.603 J.826 E.01995
G1 X123.228 Y113.434 E.01107
G3 X124.312 Y114.084 I-4.497 J8.721 E.02624
G1 X122.113 Y114.084 E.04562
G1 X122.126 Y113.889 E.00406
G1 X121.847 Y113.434 E.01107
G1 X121.057 Y112.979 E.01892
G3 X119.926 Y112.049 I2.07 J-3.669 E.03052
G1 X118.229 Y112.049 E.0352
M204 S10000
G1 X119.329 Y115.304 F60000
G1 F9000
M204 S4000
G1 X119.868 Y116.913 E.0352
G1 X119.586 Y117.075 E.00673
G1 X119.308 Y117.531 E.01107
G1 X119.339 Y117.986 E.00946
G2 X120.969 Y120.203 I3.101 J-.572 E.05907
G1 X121.578 Y122.022 E.03979
G1 X121.957 Y122.022 E.00786
G3 X120.377 Y123.903 I-2.88 J-.815 E.05251
G1 X119.586 Y124.359 E.01892
G1 X119.308 Y124.814 E.01107
G1 X119.339 Y125.269 E.00946
G2 X121.057 Y127.545 I3.144 J-.586 E.06131
G1 X121.847 Y128 E.01892
G1 X122.126 Y128.455 E.01107
G1 X122.095 Y128.911 E.00946
G3 X120.704 Y130.969 I-3.026 J-.545 E.05304
G1 X118.302 Y124.201 E.14895
G1 X118.485 Y123.903 E.00725
G1 X118.453 Y123.448 E.00946
G2 X117.379 Y121.601 I-3.123 J.579 E.04521
G1 X116.272 Y118.481 E.06866
G3 X117.416 Y117.531 I3.076 J2.537 E.03103
G1 X118.206 Y117.075 E.01892
G1 X118.485 Y116.62 E.01107
G1 X118.453 Y116.165 E.00946
G2 X116.735 Y113.889 I-3.144 J.586 E.06131
G1 X115.945 Y113.434 E.01892
G1 X115.666 Y112.979 E.01107
G3 X115.863 Y112.049 I1.8 J-.104 E.01995
G1 X114.704 Y112.049 E.02404
G1 X114.704 Y113.662 E.03347
G1 X114.843 Y113.889 E.00551
G3 X114.808 Y114.355 I-.872 J.168 E.00981
G1 X115.375 Y115.954 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X114.808 Y114.355 E-.64486
G1 X114.831 Y114.053 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L24
M991 S0 P23 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.24 I-.994 J.702 P1  F60000
G1 X123.325 Y126.079 Z3.24
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.36 F60000
G1 X119.605 Y114.987 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.36 F60000
G1 X141.28 Y114.497 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.06 Y120.373 Z3.36 F60000
G1 X138.057 Y122.713 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.611 Y121.109 E.0352
G3 X137.737 Y120.262 I.975 J-1.881 E.02562
G3 X138.534 Y117.986 I2.623 J-.359 E.05194
G1 X139.771 Y117.075 E.03185
G1 X140.113 Y116.62 E.01181
G2 X139.315 Y114.344 I-2.623 J-.359 E.05194
G1 X138.079 Y113.434 E.03185
G3 X137.8 Y112.049 I.822 J-.886 E.0313
G1 X134.501 Y112.049 E.06844
G2 X134.893 Y112.523 I1.338 J-.706 E.01286
G1 X136.129 Y113.434 E.03185
G1 X136.471 Y113.889 E.01181
G1 X136.495 Y114.084 E.00408
G1 X136.787 Y114.084 E.00607
G1 X134.906 Y119.817 E.12514
G1 X136.129 Y120.717 E.0315
G1 X136.471 Y121.172 E.01181
G3 X135.674 Y123.448 I-2.623 J.359 E.05194
G1 X134.437 Y124.359 E.03185
G1 X134.095 Y124.814 E.01181
G2 X134.893 Y127.09 I2.623 J.359 E.05194
G1 X136.198 Y128.092 E.03415
G1 X135.154 Y131.114 E.06631
G2 X134.095 Y132.097 I1.109 J2.256 E.0304
G1 X134.041 Y132.552 E.00951
G1 X134.313 Y133.548 E.02142
G1 X133.759 Y135.152 E.0352
; WIPE_START
G1 X134.313 Y133.548 E-.64485
M73 P42 R12
G1 X134.233 Y133.256 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.968 Y128.898 Z3.36 F60000
G1 X122.65 Y125.199 Z3.36
G1 Z2.96
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.186 Y126.809 E.0352
G2 X123.604 Y128.068 I1.006 J.364 E.02967
G1 X124.874 Y131.885 E.08345
G1 X123.968 Y132.552 E.02334
G2 X123.17 Y134.828 I1.826 J1.917 E.05194
G1 X123.513 Y135.283 E.01181
G1 X124.749 Y136.194 E.03185
G3 X125.547 Y138.47 I-1.825 J1.917 E.05194
G1 X125.204 Y138.925 E.01181
G1 X123.886 Y139.933 E.03444
G1 X123.318 Y138.334 E.0352
M204 S10000
G1 X126.697 Y137.367 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.03007
G1 X127.402 Y138.742 E.00513
G2 X126.758 Y139.835 I.62 J1.102 E.02756
M73 P43 R12
G2 X127.609 Y141.656 I3.011 J-.299 E.0425
G1 X128.846 Y142.566 E.03185
G1 X129.188 Y143.022 E.01181
G3 X129.125 Y143.951 I-1.259 J.381 E.01976
G1 X130.718 Y143.951 E.03306
G1 X131.116 Y142.802 E.02523
G3 X130.399 Y141.656 I.63 J-1.191 E.02936
G3 X131.251 Y139.835 I3.011 J.299 E.0425
G1 X132.444 Y138.957 E.03073
G1 X132.836 Y137.822 E.0249
G2 X132.032 Y136.194 I-2.795 J.368 E.03835
G1 X130.796 Y135.283 E.03185
G1 X130.454 Y134.828 E.01181
G1 X130.399 Y134.373 E.00951
G3 X131.251 Y132.552 I3.011 J.299 E.0425
G1 X132.487 Y131.642 E.03185
G1 X132.83 Y131.186 E.01181
G1 X132.884 Y130.731 E.00951
G2 X131.935 Y128.839 I-2.768 J.204 E.04504
G1 X133.153 Y125.178 E.08003
G1 X131.375 Y125.178 E.03689
G1 X132.487 Y124.359 E.02866
G1 X132.83 Y123.903 E.01181
G1 X132.884 Y123.448 E.00951
G2 X132.363 Y122.022 I-3.131 J.336 E.03181
G1 X129.144 Y122.022 E.06676
G3 X128.391 Y123.448 I-2.596 J-.46 E.034
G1 X127.154 Y124.359 E.03185
G1 X126.812 Y124.814 E.01181
G1 X126.769 Y125.178 E.00761
G1 X124.092 Y125.178 E.05553
G1 X125.204 Y124.359 E.02866
G1 X125.547 Y123.903 E.01181
G1 X125.601 Y123.448 E.00951
G2 X125.08 Y122.022 I-3.131 J.336 E.03181
G1 X126.777 Y122.022 E.0352
; WIPE_START
G1 X125.08 Y122.022 E-.64486
G1 X125.23 Y122.285 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.27 Y116.485 Z3.36 F60000
G1 X119.373 Y115.436 Z3.36
G1 Z2.96
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X119.912 Y117.045 E.0352
G2 X119.475 Y117.986 I.593 J.847 E.02253
G2 X121.003 Y120.305 I2.894 J-.244 E.06007
G1 X121.578 Y122.022 E.03756
G1 X121.861 Y122.022 E.00588
G3 X121.108 Y123.448 I-2.596 J-.46 E.034
G1 X119.871 Y124.359 E.03185
G1 X119.529 Y124.814 E.01181
G1 X119.475 Y125.269 E.00951
G2 X120.326 Y127.09 I3.011 J-.299 E.0425
G1 X121.563 Y128 E.03185
G1 X121.905 Y128.455 E.01181
G1 X121.959 Y128.911 E.00951
G3 X121.108 Y130.731 I-3.011 J-.299 E.0425
G1 X120.721 Y131.016 E.00996
G1 X118.218 Y123.964 E.15522
G1 X118.318 Y123.448 E.0109
G2 X117.361 Y121.55 I-2.764 J.203 E.04524
G1 X116.276 Y118.492 E.06731
G3 X116.685 Y117.986 I1.422 J.731 E.01359
G1 X117.921 Y117.075 E.03185
G1 X118.263 Y116.62 E.01181
G1 X118.318 Y116.165 E.00951
G2 X117.466 Y114.344 I-3.011 J.299 E.0425
G1 X116.23 Y113.434 E.03185
G1 X115.887 Y112.979 E.01181
G3 X115.951 Y112.049 I1.259 J-.381 E.01976
G1 X119.934 Y112.049 E.08263
G2 X120.326 Y112.523 I1.338 J-.706 E.01286
G1 X121.563 Y113.434 E.03185
G1 X121.905 Y113.889 E.01181
G1 X121.928 Y114.084 E.00408
G1 X124.396 Y114.084 E.05119
G1 X123.513 Y113.434 E.02276
G1 X123.17 Y112.979 E.01181
G3 X123.234 Y112.049 I1.259 J-.381 E.01976
G1 X127.217 Y112.049 E.08263
G2 X127.609 Y112.523 I1.339 J-.706 E.01286
G1 X128.846 Y113.434 E.03185
G1 X129.188 Y113.889 E.01181
G1 X129.211 Y114.084 E.00408
G1 X131.679 Y114.084 E.05119
G1 X130.796 Y113.434 E.02276
G1 X130.454 Y112.979 E.01181
G3 X130.517 Y112.049 I1.259 J-.381 E.01976
G1 X132.214 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.517 Y112.049 E-.64486
G1 X130.444 Y112.343 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L25
M991 S0 P24 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.36 I-1.08 J-.56 P1  F60000
G1 X123.325 Y126.079 Z3.36
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.48 F60000
G1 X119.605 Y114.987 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.48 F60000
G1 X141.28 Y114.497 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.055 Y120.371 Z3.48 F60000
G1 X138.088 Y122.624 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.642 Y121.02 E.0352
G3 X137.915 Y120.262 I1.577 J-2.24 E.02192
G3 X138.485 Y117.986 I2.314 J-.63 E.05085
G1 X139.567 Y117.075 E.02933
G1 X139.934 Y116.62 E.01213
G2 X139.364 Y114.344 I-2.314 J-.63 E.05085
G1 X138.282 Y113.434 E.02933
G3 X137.832 Y112.049 I.852 J-1.042 E.03192
G1 X134.501 Y112.049 E.0691
G2 X134.844 Y112.523 I1.316 J-.589 E.01223
G1 X135.926 Y113.434 E.02933
G1 X136.293 Y113.889 E.01213
G1 X136.342 Y114.084 E.00418
G1 X136.787 Y114.084 E.00925
G1 X134.895 Y119.85 E.12587
G1 X135.926 Y120.717 E.02793
G1 X136.293 Y121.172 E.01213
G3 X135.723 Y123.448 I-2.314 J.63 E.05085
G1 X134.641 Y124.359 E.02933
G1 X134.274 Y124.814 E.01213
G2 X134.844 Y127.09 I2.314 J.63 E.05085
G1 X135.926 Y128 E.02933
G1 X136.139 Y128.265 E.00704
G1 X135.108 Y131.249 E.06549
G2 X134.274 Y132.097 I1.754 J2.559 E.02482
G2 X134.325 Y133.513 I1.666 J.649 E.03022
G1 X133.771 Y135.117 E.0352
; WIPE_START
G1 X134.325 Y133.513 E-.64485
G1 X134.245 Y133.221 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.935 Y128.926 Z3.48 F60000
G1 X122.706 Y125.366 Z3.48
G1 Z3.08
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.242 Y126.977 E.0352
G2 X123.488 Y127.717 I1.287 J-.017 E.01644
G1 X124.839 Y131.778 E.08878
G1 X123.919 Y132.552 E.02493
G2 X123.349 Y134.828 I1.744 J1.646 E.05085
G1 X123.716 Y135.283 E.01213
G1 X124.798 Y136.194 E.02933
G3 X125.368 Y138.47 I-1.744 J1.646 E.05085
G1 X125.001 Y138.925 E.01213
G1 X123.873 Y139.898 E.0309
G1 X123.305 Y138.299 E.0352
M204 S10000
G1 X126.752 Y137.531 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.02649
G1 X127.574 Y138.742 E.00871
G2 X127.019 Y140.746 I.882 J1.323 E.04699
G2 X127.561 Y141.656 I2.464 J-.85 E.02213
G1 X128.643 Y142.566 E.02933
G3 X129.093 Y143.951 I-.851 J1.042 E.03192
G1 X130.718 Y143.951 E.03372
G1 X131.152 Y142.695 E.02756
G3 X130.661 Y140.746 I.928 J-1.271 E.04524
G3 X131.202 Y139.835 I2.464 J.85 E.02213
G1 X132.284 Y138.925 E.02933
G2 X132.623 Y137.104 I-1.062 J-1.139 E.04114
G2 X132.081 Y136.194 I-2.464 J.849 E.02213
G1 X130.999 Y135.283 E.02933
G3 X130.544 Y133.918 I.992 J-1.089 E.03119
G3 X131.202 Y132.552 I2.915 J.563 E.03179
G1 X132.284 Y131.642 E.02933
G2 X132.739 Y130.276 I-.992 J-1.089 E.03119
G2 X131.949 Y128.799 I-2.531 J.404 E.0354
G1 X133.153 Y125.178 E.07916
G1 X131.31 Y125.178 E.03822
G1 X132.284 Y124.359 E.0264
G2 X132.739 Y122.993 I-.992 J-1.089 E.03119
G2 X132.371 Y122.022 I-3.131 J.633 E.02164
G1 X129.101 Y122.022 E.06782
G3 X128.44 Y123.448 I-2.576 J-.328 E.03313
G1 X127.358 Y124.359 E.02933
G2 X126.899 Y125.178 I.657 J.905 E.02009
G1 X124.027 Y125.178 E.05958
G1 X125.001 Y124.359 E.0264
G2 X125.456 Y122.993 I-.992 J-1.089 E.03119
G2 X125.087 Y122.022 I-3.131 J.633 E.02164
G1 X126.784 Y122.022 E.0352
; WIPE_START
G1 X125.087 Y122.022 E-.64486
G1 X125.221 Y122.294 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.226 Y116.523 Z3.48 F60000
G1 X119.428 Y115.6 Z3.48
G1 Z3.08
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X119.967 Y117.209 E.0352
G2 X119.62 Y118.441 I1.018 J.952 E.02758
G2 X120.277 Y119.807 I2.915 J-.563 E.03179
G1 X121.055 Y120.461 E.02109
G1 X121.578 Y122.022 E.03414
G1 X121.818 Y122.022 E.00497
G3 X121.156 Y123.448 I-2.576 J-.328 E.03313
G1 X120.074 Y124.359 E.02933
G2 X119.62 Y125.724 I.992 J1.089 E.03119
G2 X120.277 Y127.09 I2.915 J-.563 E.03179
G1 X121.359 Y128 E.02933
G3 X121.814 Y129.366 I-.992 J1.089 E.03119
G3 X120.743 Y131.079 I-2.567 J-.413 E.04305
G1 X118.131 Y123.719 E.162
G2 X117.335 Y121.476 I-2.304 J-.445 E.05177
G1 X116.277 Y118.496 E.0656
G3 X116.636 Y117.986 I1.407 J.609 E.01302
G1 X117.718 Y117.075 E.02933
G2 X118.173 Y115.71 I-.992 J-1.089 E.03119
G2 X117.515 Y114.344 I-2.915 J.563 E.03179
G1 X116.433 Y113.434 E.02933
G3 X115.983 Y112.049 I.852 J-1.042 E.03192
G1 X119.935 Y112.049 E.08197
G2 X120.277 Y112.523 I1.316 J-.589 E.01223
G1 X121.359 Y113.434 E.02933
G1 X121.726 Y113.889 E.01213
G1 X121.775 Y114.084 E.00418
G1 X124.489 Y114.084 E.0563
G3 X123.349 Y112.979 I2.261 J-3.472 E.03315
G3 X123.266 Y112.049 I2.042 J-.651 E.01952
G1 X127.218 Y112.049 E.08197
G2 X127.561 Y112.523 I1.316 J-.589 E.01223
G1 X128.643 Y113.434 E.02933
G1 X129.009 Y113.889 E.01213
G1 X129.058 Y114.084 E.00418
G1 X131.772 Y114.084 E.0563
G3 X130.632 Y112.979 I2.261 J-3.472 E.03315
G3 X130.549 Y112.049 I2.041 J-.651 E.01952
G1 X132.246 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.549 Y112.049 E-.64486
G1 X130.53 Y112.351 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L26
M991 S0 P25 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.48 I-1.078 J-.565 P1  F60000
G1 X123.325 Y126.079 Z3.48
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.6 F60000
G1 X119.605 Y114.987 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
M73 P44 R12
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.6 F60000
G1 X141.28 Y114.497 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.228 Y119.326 Z3.6 F60000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.673 Y120.93 E.0352
G3 X138.067 Y120.262 I2.455 J-2.839 E.01876
G3 X138.434 Y117.986 I2.106 J-.828 E.05017
G2 X139.783 Y116.62 I-4.966 J-6.255 E.03991
G2 X139.416 Y114.344 I-2.106 J-.828 E.05017
G1 X138.447 Y113.434 E.02758
G3 X137.894 Y112.049 I.954 J-1.184 E.03233
G1 X134.494 Y112.049 E.07053
G2 X134.792 Y112.523 I1.283 J-.474 E.01171
G1 X135.761 Y113.434 E.02758
G3 X136.21 Y114.084 I-.645 J.925 E.01675
G1 X136.787 Y114.084 E.01198
G1 X134.882 Y119.891 E.12676
G3 X136.141 Y121.172 I-4.661 J5.841 E.03735
G3 X135.774 Y123.448 I-2.106 J.828 E.05017
G2 X134.425 Y124.814 I4.965 J6.254 E.03991
G2 X134.792 Y127.09 I2.106 J.828 E.05017
G3 X136.093 Y128.397 I-4.75 J6.026 E.03835
G1 X135.052 Y131.41 E.06612
G2 X134.337 Y133.48 I1.011 J1.508 E.04877
G1 X133.782 Y135.084 E.0352
; WIPE_START
G1 X134.337 Y133.48 E-.64485
G1 X134.282 Y133.182 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.351 Y136.379 Z3.6 F60000
G1 X123.289 Y138.253 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.867 Y139.835 E.03495
G2 X125.216 Y138.47 I-4.966 J-6.255 E.03991
G2 X124.85 Y136.194 I-2.106 J-.828 E.05017
G3 X123.501 Y134.828 I4.966 J-6.255 E.03991
G3 X123.867 Y132.552 I2.106 J-.828 E.05017
G1 X124.803 Y131.673 E.02664
G1 X127.155 Y138.742 E.15454
G1 X127.717 Y138.742 E.01166
G2 X126.982 Y139.835 I1.539 J1.828 E.02767
G2 X127.509 Y141.656 I2.44 J.281 E.04036
G3 X128.858 Y143.022 I-4.966 J6.255 E.03991
G3 X129.03 Y143.951 I-1.965 J.845 E.01978
G1 X130.718 Y143.951 E.03501
G1 X131.189 Y142.59 E.02988
G3 X130.86 Y140.29 I1.246 J-1.351 E.05215
G1 X131.15 Y139.835 E.0112
G2 X132.5 Y138.47 I-4.965 J-6.254 E.03991
G2 X132.133 Y136.194 I-2.106 J-.828 E.05017
G3 X130.784 Y134.828 I4.965 J-6.255 E.03991
G3 X131.15 Y132.552 I2.106 J-.828 E.05017
G2 X132.5 Y131.186 I-4.965 J-6.254 E.03991
G2 X131.964 Y128.752 I-2.046 J-.826 E.05494
G1 X133.153 Y125.178 E.07813
G1 X131.247 Y125.178 E.03953
G2 X132.5 Y123.903 I-4.638 J-5.809 E.03715
G2 X132.385 Y122.022 I-2.035 J-.82 E.04041
G1 X129.032 Y122.022 E.06954
G3 X128.491 Y123.448 I-2.455 J-.115 E.03216
G2 X127.142 Y124.814 I4.966 J6.255 E.03991
G1 X127.014 Y125.178 E.00801
G1 X123.964 Y125.178 E.06326
G2 X125.216 Y123.903 I-4.638 J-5.809 E.03715
G2 X125.101 Y122.022 I-2.035 J-.82 E.04041
G1 X126.798 Y122.022 E.0352
; WIPE_START
G1 X125.101 Y122.022 E-.64486
G1 X125.216 Y122.303 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.191 Y116.558 Z3.6 F60000
G1 X119.474 Y115.738 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.013 Y117.347 E.0352
G2 X119.936 Y119.351 I1.536 J1.063 E.04393
G1 X120.226 Y119.807 E.0112
G1 X121.116 Y120.644 E.02535
G1 X121.578 Y122.022 E.03015
G1 X121.749 Y122.022 E.00354
G3 X121.208 Y123.448 I-2.455 J-.115 E.03216
G2 X119.859 Y124.814 I4.965 J6.254 E.03991
G2 X120.226 Y127.09 I2.106 J.828 E.05017
G3 X121.575 Y128.455 I-4.965 J6.254 E.03991
G3 X120.767 Y131.146 I-2.147 J.822 E.06269
G1 X118.064 Y123.531 E.16761
G2 X117.3 Y121.377 I-2.238 J-.418 E.04967
G1 X116.275 Y118.49 E.06353
G3 X116.584 Y117.986 I1.36 J.486 E.01236
G2 X117.933 Y116.62 I-4.965 J-6.255 E.03991
G2 X117.567 Y114.344 I-2.106 J-.828 E.05017
G3 X116.217 Y112.979 I4.966 J-6.255 E.03991
G3 X116.045 Y112.049 I1.963 J-.845 E.01978
G1 X119.928 Y112.049 E.08054
G2 X120.226 Y112.523 I1.283 J-.474 E.01171
G3 X121.575 Y113.889 I-4.965 J6.254 E.03991
G1 X121.644 Y114.084 E.0043
G1 X124.573 Y114.084 E.06077
G3 X123.501 Y112.979 I4.031 J-4.983 E.03203
G3 X123.328 Y112.049 I1.964 J-.845 E.01978
G1 X127.211 Y112.049 E.08054
G2 X127.509 Y112.523 I1.283 J-.474 E.01171
G3 X128.858 Y113.889 I-4.966 J6.255 E.03991
G1 X128.927 Y114.084 E.0043
G1 X131.856 Y114.084 E.06077
G3 X130.784 Y112.979 I4.03 J-4.983 E.03203
G3 X130.611 Y112.049 I1.963 J-.845 E.01978
G1 X132.308 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.611 Y112.049 E-.64486
G1 X130.619 Y112.352 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L27
M991 S0 P26 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.6 I-1.075 J-.571 P1  F60000
G1 X123.325 Y126.079 Z3.6
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.72 F60000
G1 X119.605 Y114.987 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.72 F60000
G1 X141.28 Y114.497 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.263 Y119.224 Z3.72 F60000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.709 Y120.828 E.0352
G3 X137.946 Y119.351 I1.014 J-1.458 E.03586
G3 X139.259 Y117.075 I2.954 J.187 E.05647
G2 X139.903 Y115.71 I-1.29 J-1.443 E.03217
G2 X138.59 Y113.434 I-2.954 J.187 E.05647
G3 X137.948 Y112.049 I1.13 J-1.365 E.03274
G1 X134.481 Y112.049 E.07192
G2 X135.131 Y112.979 I3.163 J-1.517 E.02363
G3 X136.094 Y114.084 I-2.249 J2.931 E.03062
G1 X136.787 Y114.084 E.01439
G1 X134.862 Y119.951 E.12808
G3 X136.008 Y121.172 I-50.323 J48.392 E.03474
G3 X135.829 Y123.448 I-1.965 J.99 E.04979
G2 X134.558 Y124.814 I314.571 J294.1 E.0387
G2 X134.737 Y127.09 I1.965 J.99 E.04979
M73 P45 R12
G3 X136.044 Y128.538 I-41.8 J39.048 E.04047
G1 X134.983 Y131.61 E.06741
G2 X134.349 Y133.446 I1.233 J1.454 E.04228
G1 X133.794 Y135.049 E.0352
; WIPE_START
G1 X134.349 Y133.446 E-.64485
G1 X134.319 Y133.144 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.38 Y136.323 Z3.72 F60000
G1 X123.272 Y138.205 Z3.72
G1 Z3.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.84 Y139.804 E.0352
G2 X125.084 Y138.47 I-167.147 J-157.103 E.03784
G2 X124.511 Y135.738 I-2.068 J-.992 E.06222
G3 X123.435 Y134.373 I2.006 J-2.689 E.03648
G3 X124.206 Y132.097 I2.435 J-.444 E.05204
G2 X124.765 Y131.558 I-2.148 J-2.789 E.01615
G1 X127.155 Y138.742 E.15705
G1 X127.861 Y138.742 E.01465
G2 X127.076 Y139.835 I1.86 J2.163 E.02817
G2 X127.847 Y142.111 I2.435 J.444 E.05204
G3 X128.924 Y143.477 I-2.006 J2.688 E.03648
G3 X128.976 Y143.951 I-1.043 J.356 E.00998
G1 X130.718 Y143.951 E.03613
G1 X131.229 Y142.475 E.0324
G3 X130.846 Y140.29 I1.371 J-1.366 E.04899
G3 X131.976 Y138.925 I3.814 J2.007 E.03704
G2 X132.438 Y136.649 I-1.324 J-1.453 E.05153
G2 X131.307 Y135.283 I-3.815 J2.008 E.03704
G3 X130.846 Y133.007 I1.324 J-1.453 E.05153
G3 X131.976 Y131.642 I3.814 J2.007 E.03704
G2 X132.438 Y129.366 I-1.324 J-1.453 E.05153
G2 X131.988 Y128.68 I-1.83 J.709 E.01713
G1 X133.153 Y125.178 E.07655
G1 X131.174 Y125.178 E.04104
G2 X132.367 Y123.903 I-80.905 J-76.894 E.03621
G2 X132.404 Y122.022 I-1.91 J-.979 E.0404
G1 X128.971 Y122.022 E.07121
G3 X128.153 Y123.903 I-2.536 J.016 E.04381
G2 X127.116 Y125.178 I2.019 J2.701 E.03443
G1 X123.891 Y125.178 E.06689
G2 X125.084 Y123.903 I-80.73 J-76.731 E.03621
G2 X125.121 Y122.022 I-1.91 J-.979 E.0404
G1 X126.818 Y122.022 E.0352
; WIPE_START
G1 X125.121 Y122.022 E-.64486
G1 X125.216 Y122.31 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.163 Y116.589 Z3.72 F60000
G1 X119.512 Y115.852 Z3.72
G1 Z3.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.051 Y117.461 E.0352
G2 X120.564 Y120.262 I1.911 J1.097 E.0642
G3 X121.198 Y120.888 I-2.504 J3.17 E.01852
G1 X121.578 Y122.022 E.02481
G1 X121.688 Y122.022 E.00228
G3 X120.87 Y123.903 I-2.536 J.016 E.04381
G2 X119.793 Y125.269 I2.006 J2.689 E.03648
G2 X120.564 Y127.545 I2.435 J.444 E.05204
G3 X121.641 Y128.911 I-2.006 J2.688 E.03648
G3 X120.803 Y131.248 I-2.451 J.441 E.05393
G1 X118.008 Y123.373 E.17334
G2 X117.227 Y121.171 I-2.431 J-.377 E.0505
G1 X116.27 Y118.474 E.05936
G3 X117.41 Y117.075 I3.788 J1.924 E.03772
G2 X117.871 Y114.799 I-1.324 J-1.453 E.05153
G2 X116.741 Y113.434 I-3.815 J2.008 E.03704
G3 X116.099 Y112.049 I1.13 J-1.365 E.03274
G1 X119.915 Y112.049 E.07916
G2 X121.052 Y113.434 I3.815 J-1.971 E.03744
G3 X121.527 Y114.084 I-.822 J1.1 E.01697
G1 X124.68 Y114.084 E.06539
G3 X123.633 Y112.979 I22.192 J-22.055 E.03159
G3 X123.382 Y112.049 I1.981 J-1.034 E.02014
G1 X127.198 Y112.049 E.07916
G2 X128.335 Y113.434 I3.815 J-1.971 E.03744
G3 X128.811 Y114.084 I-.822 J1.1 E.01697
G1 X131.963 Y114.084 E.06539
G3 X130.916 Y112.979 I22.181 J-22.045 E.03159
G3 X130.665 Y112.049 I1.98 J-1.034 E.02014
G1 X132.362 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.665 Y112.049 E-.64486
G1 X130.699 Y112.35 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L28
M991 S0 P27 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.72 I-1.072 J-.576 P1  F60000
G1 X123.325 Y126.079 Z3.72
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.84 F60000
G1 X119.605 Y114.987 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.84 F60000
G1 X141.28 Y114.497 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.294 Y119.133 Z3.84 F60000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.74 Y120.737 E.0352
G3 X138.671 Y117.531 I1.422 J-1.634 E.07489
G2 X139.764 Y116.165 I-2.797 J-3.358 E.03652
G2 X138.72 Y113.434 I-2.524 J-.601 E.06443
G3 X137.995 Y112.049 I1.338 J-1.583 E.03325
G1 X134.462 Y112.049 E.07328
G2 X135.03 Y112.979 I2.994 J-1.188 E.02271
G3 X135.989 Y114.084 I-3.189 J3.736 E.03048
G1 X136.787 Y114.084 E.01656
G1 X134.841 Y120.017 E.12951
G1 X135.03 Y120.262 E.00642
G3 X136.122 Y121.627 I-2.797 J3.357 E.03652
G3 X135.079 Y124.359 I-2.524 J.601 E.06443
G2 X135.03 Y127.545 I1.453 J1.616 E.0742
G3 X135.999 Y128.67 I-3.108 J3.658 E.03092
G1 X134.903 Y131.841 E.0696
G2 X134.363 Y133.405 I1.289 J1.321 E.03559
G1 X133.808 Y135.009 E.0352
; WIPE_START
G1 X134.363 Y133.405 E-.64485
G1 X134.355 Y133.102 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.407 Y136.261 Z3.84 F60000
G1 X123.253 Y138.15 Z3.84
G1 Z3.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.82 Y139.749 E.0352
G3 X124.964 Y138.47 I19.186 J16 E.03561
G2 X124.612 Y135.738 I-1.903 J-1.143 E.06162
G3 X123.52 Y134.373 I2.797 J-3.358 E.03652
G3 X124.563 Y131.642 I2.524 J-.601 E.06443
G1 X124.73 Y131.452 E.00524
G1 X127.155 Y138.742 E.15936
G1 X127.979 Y138.742 E.0171
G2 X127.161 Y139.835 I2.483 J2.71 E.02848
G2 X128.205 Y142.566 I2.524 J.601 E.06443
G3 X128.93 Y143.951 I-1.338 J1.583 E.03325
G1 X130.718 Y143.951 E.0371
G1 X131.265 Y142.371 E.03469
G3 X131.388 Y139.38 I1.597 J-1.432 E.06871
G2 X132.481 Y138.014 I-2.797 J-3.358 E.03652
G2 X131.437 Y135.283 I-2.524 J-.601 E.06443
G3 X131.388 Y132.097 I1.453 J-1.616 E.0742
G2 X132.481 Y130.731 I-2.797 J-3.357 E.03652
G2 X132.013 Y128.607 I-2.214 J-.626 E.04699
G1 X133.153 Y125.178 E.07497
G1 X131.107 Y125.178 E.04243
G3 X132.247 Y123.903 I19.335 J16.146 E.03548
G2 X132.43 Y122.022 I-1.832 J-1.127 E.04059
G1 X128.918 Y122.022 E.07284
G3 X127.795 Y124.359 I-2.648 J.165 E.05618
G2 X127.208 Y125.178 I1.321 J1.568 E.02113
G1 X123.824 Y125.178 E.07019
G3 X124.964 Y123.903 I19.345 J16.155 E.03548
G2 X125.147 Y122.022 I-1.832 J-1.127 E.04059
G1 X126.844 Y122.022 E.0352
; WIPE_START
G1 X125.147 Y122.022 E-.64486
G1 X125.221 Y122.316 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.137 Y116.623 Z3.84 F60000
G1 X119.55 Y115.965 Z3.84
G1 Z3.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.089 Y117.574 E.0352
G2 X120.463 Y120.262 I1.921 J1.102 E.06058
G3 X121.276 Y121.119 I-6.013 J6.512 E.02451
G1 X121.578 Y122.022 E.01976
G1 X121.635 Y122.022 E.00118
G3 X120.512 Y124.359 I-2.648 J.165 E.05618
G2 X120.463 Y127.545 I1.453 J1.616 E.0742
G3 X121.556 Y128.911 I-2.797 J3.357 E.03652
G3 X120.831 Y131.325 I-2.278 J.632 E.05517
G1 X117.958 Y123.231 E.17816
G2 X117.172 Y121.016 I-2.318 J-.424 E.05104
G1 X116.258 Y118.443 E.05663
G3 X117.28 Y117.075 I3.36 J1.445 E.03574
G2 X117.329 Y113.889 I-1.453 J-1.616 E.0742
G3 X116.236 Y112.523 I2.797 J-3.358 E.03652
G3 X116.146 Y112.049 I1.007 J-.439 E.01011
G1 X119.896 Y112.049 E.07779
G2 X120.922 Y113.434 I3.332 J-1.395 E.0361
G3 X121.423 Y114.084 I-1.032 J1.313 E.01721
G1 X124.763 Y114.084 E.06928
G2 X123.753 Y112.979 I-41.217 J36.626 E.03106
G3 X123.429 Y112.049 I2.051 J-1.236 E.02057
G1 X127.179 Y112.049 E.07779
G2 X128.205 Y113.434 I3.332 J-1.395 E.0361
G3 X128.706 Y114.084 I-1.032 J1.313 E.01721
G1 X132.046 Y114.084 E.06928
G2 X131.036 Y112.979 I-41.217 J36.626 E.03106
G3 X130.712 Y112.049 I2.05 J-1.236 E.02057
G1 X132.409 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.712 Y112.049 E-.64486
G1 X130.769 Y112.346 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L29
M991 S0 P28 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.84 I-1.07 J-.58 P1  F60000
G1 X123.325 Y126.079 Z3.84
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z3.96 F60000
G1 X119.605 Y114.987 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
M73 P46 R12
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z3.96 F60000
G1 X141.28 Y114.497 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.328 Y119.036 Z3.96 F60000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.773 Y120.64 E.0352
G1 X138.43 Y120.262 E.0106
G3 X139.007 Y117.075 I1.95 J-1.292 E.07418
G2 X138.843 Y113.434 I-1.527 J-1.756 E.08687
G3 X138.035 Y112.049 I1.58 J-1.85 E.0339
G1 X134.437 Y112.049 E.07462
G2 X134.929 Y112.979 I2.805 J-.889 E.02194
G3 X135.893 Y114.084 I-4.735 J5.1 E.03048
G1 X136.787 Y114.084 E.01855
G1 X134.815 Y120.096 E.13123
G2 X135.365 Y120.717 I2.193 J-1.388 E.01729
G3 X135.201 Y124.359 I-1.527 J1.756 E.08687
G2 X134.929 Y127.545 I1.396 J1.724 E.07408
G3 X135.964 Y128.771 I-4.158 J4.556 E.03338
G1 X134.831 Y132.05 E.07195
G2 X134.376 Y133.365 I1.431 J1.231 E.02957
G1 X133.822 Y134.969 E.0352
; WIPE_START
G1 X134.376 Y133.365 E-.64485
G1 X134.391 Y133.063 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.431 Y136.193 Z3.96 F60000
G1 X123.229 Y138.083 Z3.96
G1 Z3.56
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.796 Y139.682 E.0352
G3 X124.854 Y138.47 I9.32 J7.06 E.03339
G2 X124.277 Y135.283 I-1.95 J-1.292 E.07418
G3 X124.44 Y131.642 I1.527 J-1.756 E.08687
G1 X124.698 Y131.357 E.00797
G1 X127.155 Y138.742 E.16143
G1 X128.093 Y138.742 E.01946
G2 X127.238 Y139.835 I3.371 J3.518 E.02888
G2 X128.082 Y142.566 I2.268 J.795 E.0635
G3 X128.89 Y143.951 I-1.58 J1.85 E.03389
G1 X130.718 Y143.951 E.03793
G1 X131.297 Y142.277 E.03675
G3 X131.288 Y139.38 I1.603 J-1.454 E.06583
G2 X132.404 Y138.014 I-3.999 J-4.407 E.03672
G2 X131.56 Y135.283 I-2.268 J-.795 E.0635
G3 X131.723 Y131.642 I1.527 J-1.756 E.08687
G2 X132.041 Y128.521 I-1.382 J-1.717 E.07238
G1 X133.153 Y125.178 E.07308
G1 X131.037 Y125.178 E.0439
G3 X132.137 Y123.903 I8.886 J6.557 E.03496
G2 X132.461 Y122.022 I-1.784 J-1.276 E.04097
G1 X128.872 Y122.022 E.07445
G3 X127.918 Y124.359 I-2.398 J.384 E.05505
G2 X127.292 Y125.178 I1.636 J1.901 E.02155
G1 X123.754 Y125.178 E.07339
G3 X124.854 Y123.903 I8.888 J6.56 E.03496
G2 X125.178 Y122.022 I-1.784 J-1.276 E.04097
G1 X126.875 Y122.022 E.0352
; WIPE_START
G1 X125.178 Y122.022 E-.64486
G1 X125.232 Y122.32 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.112 Y116.66 Z3.96 F60000
G1 X119.589 Y116.082 Z3.96
G1 Z3.56
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.128 Y117.691 E.0352
G2 X120.799 Y120.717 I2.04 J1.135 E.07031
G3 X120.635 Y124.359 I-1.527 J1.756 E.08687
G2 X120.799 Y128 I1.527 J1.756 E.08687
G3 X120.86 Y131.407 I-1.402 J1.729 E.0805
G1 X117.924 Y123.136 E.18204
G2 X117.108 Y120.836 I-2.255 J-.495 E.05334
G1 X116.246 Y118.407 E.05348
G3 X117.157 Y117.075 I2.981 J1.064 E.03384
G2 X116.994 Y113.434 I-1.527 J-1.756 E.08687
G3 X116.185 Y112.049 I1.58 J-1.85 E.0339
G1 X119.871 Y112.049 E.07645
G2 X120.799 Y113.434 I2.898 J-.938 E.03503
G3 X121.327 Y114.084 I-1.284 J1.581 E.0175
G1 X124.847 Y114.084 E.07303
G2 X123.863 Y112.979 I-11.229 J9 E.03072
G3 X123.469 Y112.049 I2.153 J-1.463 E.02109
G1 X127.154 Y112.049 E.07645
G2 X128.082 Y113.434 I2.898 J-.938 E.03503
G3 X128.61 Y114.084 I-1.284 J1.581 E.0175
G1 X132.13 Y114.084 E.07303
G2 X131.147 Y112.979 I-11.23 J9.001 E.03072
G3 X130.752 Y112.049 I2.152 J-1.462 E.02109
G1 X132.449 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.752 Y112.049 E-.64486
G1 X130.831 Y112.341 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L30
M991 S0 P29 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z3.96 I-1.068 J-.583 P1  F60000
G1 X123.325 Y126.079 Z3.96
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.08 F60000
G1 X119.605 Y114.987 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.08 F60000
G1 X141.28 Y114.497 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.359 Y118.945 Z4.08 F60000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.805 Y120.549 E.0352
G3 X138.886 Y117.075 I1.449 J-1.704 E.08253
G2 X138.963 Y113.434 I-1.375 J-1.851 E.0871
G3 X138.068 Y112.049 I1.86 J-2.183 E.0347
G1 X134.406 Y112.049 E.07596
G2 X134.826 Y112.979 I2.613 J-.621 E.0213
G3 X135.803 Y114.084 I-7.962 J8.018 E.03063
G1 X132.218 Y114.084 E.07435
G2 X131.68 Y113.434 I-1.926 J1.046 E.01763
G3 X130.785 Y112.049 I1.86 J-2.183 E.0347
G1 X127.123 Y112.049 E.07596
G2 X127.543 Y112.979 I2.614 J-.621 E.0213
G3 X128.52 Y114.084 I-7.962 J8.018 E.03063
M73 P47 R12
G1 X124.935 Y114.084 E.07435
G2 X124.397 Y113.434 I-1.926 J1.046 E.01763
G3 X123.502 Y112.049 I1.86 J-2.183 E.0347
G1 X121.805 Y112.049 E.0352
; WIPE_START
G1 X123.502 Y112.049 E-.64486
G1 X123.601 Y112.335 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.67 Y119.382 Z4.08 F60000
G1 X118.469 Y124.671 Z4.08
G1 Z3.68
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.901 Y123.072 E.0352
G2 X117.036 Y120.635 I-2.256 J-.571 E.05687
G1 X116.227 Y118.353 E.05022
G3 X117.037 Y117.075 I2.592 J.748 E.03181
G2 X117.114 Y113.434 I-1.375 J-1.851 E.0871
G3 X116.219 Y112.049 I1.86 J-2.183 E.0347
G1 X119.84 Y112.049 E.07511
G2 X120.26 Y112.979 I2.614 J-.621 E.0213
G3 X121.237 Y114.084 I-7.959 J8.016 E.03063
G1 X118.92 Y114.084 E.04805
G1 X120.159 Y117.784 E.08092
G2 X120.678 Y120.717 I1.874 J1.181 E.06777
G3 X120.755 Y124.359 I-1.375 J1.851 E.0871
G2 X120.678 Y128 I1.375 J1.851 E.0871
G3 X120.891 Y131.495 I-1.357 J1.836 E.08275
G1 X123.767 Y139.599 E.17839
G3 X124.32 Y138.925 I1.995 J1.071 E.01821
G2 X124.397 Y135.283 I-1.375 J-1.851 E.0871
G3 X123.623 Y132.552 I1.404 J-1.873 E.06327
G3 X124.67 Y131.271 I5.402 J3.346 E.03442
G1 X122.643 Y125.178 E.13319
G1 X123.678 Y125.178 E.02147
G3 X124.32 Y124.359 I2.408 J1.225 E.02172
G2 X125.216 Y122.022 I-1.414 J-1.882 E.05472
G1 X128.833 Y122.022 E.07502
G3 X128.457 Y123.903 I-2.147 J.55 E.04115
G2 X127.369 Y125.178 I6.367 J6.539 E.03481
G1 X130.962 Y125.178 E.07452
G3 X131.603 Y124.359 I2.408 J1.225 E.02172
G2 X132.499 Y122.022 I-1.414 J-1.882 E.05472
G1 X134.183 Y122.022 E.03493
G1 X134.783 Y120.192 E.03996
G2 X135.245 Y120.717 I1.568 J-.913 E.01459
G3 X135.322 Y124.359 I-1.375 J1.851 E.0871
G2 X134.826 Y127.545 I1.347 J1.841 E.07428
G3 X135.936 Y128.852 I-6.268 J6.447 E.03562
G1 X134.729 Y132.344 E.07664
G2 X134.389 Y133.328 I1.774 J1.163 E.02181
G1 X133.835 Y134.932 E.0352
; WIPE_START
G1 X134.389 Y133.328 E-.64485
G1 X134.427 Y133.027 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.123 Y137.33 Z4.08 F60000
G1 X126.951 Y138.13 Z4.08
G1 Z3.68
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.01339
G1 X128.206 Y138.742 E.02181
G1 X128.039 Y138.925 E.00514
G2 X127.962 Y142.566 I1.375 J1.851 E.0871
G3 X128.857 Y143.951 I-1.86 J2.184 E.03469
G1 X130.718 Y143.951 E.03862
G1 X131.327 Y142.191 E.03862
G3 X131.603 Y138.925 I1.631 J-1.507 E.07649
G2 X131.68 Y135.283 I-1.375 J-1.851 E.0871
G3 X131.603 Y131.642 I1.375 J-1.851 E.0871
G2 X132.073 Y128.427 I-1.363 J-1.841 E.07491
G1 X132.608 Y126.817 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.073 Y128.427 E-.64486
G1 X132.234 Y128.683 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L31
M991 S0 P30 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.08 I.341 J-1.168 P1  F60000
G1 X123.325 Y126.079 Z4.08
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.2 F60000
G1 X119.605 Y114.987 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
M73 P47 R11
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.2 F60000
G1 X141.28 Y114.497 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.389 Y118.86 Z4.2 F60000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.834 Y120.463 E.0352
G3 X138.114 Y117.986 I1.514 J-1.783 E.05669
G3 X139.214 Y116.62 I4.265 J2.31 E.03657
G2 X139.085 Y113.434 I-1.561 J-1.532 E.07412
G3 X138.096 Y112.049 I2.181 J-2.603 E.03569
G1 X134.369 Y112.049 E.07731
G2 X134.718 Y112.979 I2.434 J-.384 E.02075
G3 X135.718 Y114.084 I-19.877 J18.967 E.03092
G1 X132.312 Y114.084 E.07064
G2 X131.802 Y113.434 I-1.627 J.751 E.01731
G3 X130.812 Y112.049 I2.181 J-2.603 E.03569
G1 X127.085 Y112.049 E.07731
G2 X127.435 Y112.979 I2.434 J-.384 E.02075
G3 X128.434 Y114.084 I-19.893 J18.982 E.03092
G1 X125.029 Y114.084 E.07064
G2 X124.518 Y113.434 I-1.627 J.751 E.01731
G3 X123.529 Y112.049 I2.181 J-2.603 E.03569
G1 X121.832 Y112.049 E.0352
; WIPE_START
G1 X123.529 Y112.049 E-.64486
G1 X123.648 Y112.327 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.678 Y119.358 Z4.2 F60000
G1 X118.453 Y124.627 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.886 Y123.028 E.0352
G2 X117.235 Y120.717 I-2.029 J-.676 E.05286
G1 X116.97 Y120.449 E.00782
G1 X116.199 Y118.275 E.04785
G3 X116.915 Y117.075 I2.246 J.528 E.02944
G2 X117.886 Y114.344 I-1.46 J-2.057 E.06405
G2 X116.786 Y112.979 I-4.265 J2.31 E.03657
G3 X116.246 Y112.049 I2.388 J-2.007 E.02241
G1 X119.802 Y112.049 E.07376
G2 X120.557 Y113.434 I2.176 J-.287 E.03347
G3 X121.151 Y114.084 I-1.985 J2.409 E.01834
G1 X118.92 Y114.084 E.04627
G1 X120.184 Y117.859 E.08256
G2 X120.557 Y120.717 I1.763 J1.223 E.06555
G3 X121.527 Y123.448 I-1.46 J2.057 E.06404
G3 X120.427 Y124.814 I-4.265 J-2.31 E.03657
G2 X120.557 Y128 I1.561 J1.532 E.07412
G3 X121.527 Y130.731 I-1.46 J2.057 E.06404
G3 X120.924 Y131.589 I-2.11 J-.844 E.02194
G1 X120.356 Y129.989 E.0352
M204 S10000
G1 X126.988 Y138.24 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.01098
G1 X128.322 Y138.742 E.02422
G2 X127.373 Y139.835 I7.54 J7.506 E.03004
G2 X127.84 Y142.566 I1.868 J1.086 E.06239
G3 X128.829 Y143.951 I-2.181 J2.603 E.03568
G1 X125.312 Y143.951 E.07296
G2 X125.094 Y143.337 I-4.068 J1.098 E.01352
G1 X123.731 Y139.497 E.08454
G2 X124.985 Y138.014 I-71.908 J-62.138 E.04028
G2 X124.518 Y135.283 I-1.868 J-1.086 E.06239
G3 X123.548 Y132.552 I1.46 J-2.057 E.06404
G3 X124.643 Y131.191 I4.252 J2.301 E.03643
G1 X122.643 Y125.178 E.13145
G1 X123.597 Y125.178 E.01979
G3 X124.648 Y123.903 I4.254 J2.437 E.03443
G2 X125.259 Y122.022 I-1.737 J-1.604 E.04233
G1 X128.799 Y122.022 E.07342
G3 X128.16 Y124.359 I-2.014 J.705 E.05343
G2 X127.441 Y125.178 I2.514 J2.932 E.02269
G1 X130.88 Y125.178 E.07134
G3 X131.931 Y123.903 I4.254 J2.437 E.03443
G2 X132.542 Y122.022 I-1.737 J-1.604 E.04233
G1 X134.183 Y122.022 E.03402
G1 X134.749 Y120.296 E.03767
G3 X135.91 Y121.627 I-10.989 J10.757 E.03666
G3 X135.443 Y124.359 I-1.868 J1.086 E.06239
G2 X134.473 Y127.09 I1.46 J2.057 E.06405
G2 X135.573 Y128.455 I4.265 J-2.31 E.03657
G3 X135.913 Y128.918 I-.838 J.973 E.01201
G1 X134.658 Y132.55 E.07972
G2 X134.401 Y133.294 I2.993 J1.451 E.01637
G1 X131.354 Y142.113 E.19353
G3 X131.482 Y138.925 I1.552 J-1.534 E.07422
G2 X132.452 Y136.194 I-1.46 J-2.057 E.06404
G2 X131.352 Y134.828 I-4.265 J2.309 E.03657
G3 X131.482 Y131.642 I1.561 J-1.532 E.07412
G2 X132.452 Y128.911 I-1.46 J-2.057 E.06404
G2 X132.102 Y128.338 I-1.383 J.452 E.01405
G1 X132.638 Y126.728 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.102 Y128.338 E-.64485
G1 X132.26 Y128.596 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L32
M991 S0 P31 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.2 I.33 J-1.171 P1  F60000
G1 X123.325 Y126.079 Z4.2
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.32 F60000
G1 X119.605 Y114.987 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P48 R11
G1 X128.259 Y115.926 Z4.32 F60000
G1 X141.28 Y114.497 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.814 Y112.049 Z4.32 F60000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.117 Y112.049 E.0352
G2 X139.212 Y113.434 I3.636 J-1.748 E.03692
G3 X139.491 Y116.165 I-1.432 J1.527 E.06211
G3 X138.244 Y117.531 I-51.895 J-46.156 E.03837
G2 X138.862 Y120.383 I2.064 J1.046 E.0655
G1 X139.416 Y118.779 E.0352
M204 S10000
G1 X135.421 Y118.249 F60000
G1 F9000
M204 S4000
G1 X135.95 Y116.637 E.0352
G2 X136.235 Y115.769 I-2.015 J-1.142 E.01906
G1 X136.787 Y114.084 E.03678
G1 X135.634 Y114.084 E.02392
G2 X134.996 Y113.434 I-3.124 J2.425 E.01894
G3 X134.324 Y112.049 I1.201 J-1.438 E.03291
G1 X130.834 Y112.049 E.07241
G2 X131.452 Y112.979 I3.106 J-1.396 E.02328
G3 X132.413 Y114.084 I-2.544 J3.181 E.03055
G1 X130.716 Y114.084 E.0352
M204 S10000
G1 X128.738 Y112.049 F60000
G1 F9000
M204 S4000
G1 X127.041 Y112.049 E.0352
G2 X127.713 Y113.434 I1.873 J-.053 E.03291
G3 X128.351 Y114.084 I-2.486 J3.076 E.01894
G1 X125.13 Y114.084 E.06681
G2 X124.169 Y112.979 I-3.505 J2.075 E.03055
G3 X123.551 Y112.049 I2.488 J-2.326 E.02328
G1 X121.854 Y112.049 E.0352
; WIPE_START
G1 X123.551 Y112.049 E-.64486
G1 X123.688 Y112.319 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.69 Y119.338 Z4.32 F60000
G1 X118.443 Y124.598 Z4.32
G1 Z3.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.875 Y122.998 E.0352
G2 X117.362 Y120.717 I-1.895 J-.772 E.05163
G1 X116.913 Y120.288 E.01289
G1 X116.157 Y118.158 E.04687
G3 X116.789 Y117.075 I1.98 J.429 E.02643
G2 X118.036 Y114.799 I-1.622 J-2.368 E.05586
G2 X117.362 Y113.434 I-2.032 J.153 E.03237
G3 X116.267 Y112.049 I2.541 J-3.134 E.03692
G1 X119.758 Y112.049 E.07241
G2 X120.43 Y113.434 I1.873 J-.053 E.03291
G3 X121.068 Y114.084 I-2.486 J3.076 E.01894
G1 X118.92 Y114.084 E.04455
G1 X120.205 Y117.92 E.08391
G2 X120.43 Y120.717 I1.659 J1.274 E.06379
G3 X121.677 Y122.993 I-1.622 J2.368 E.05586
G3 X121.004 Y124.359 I-2.032 J-.153 E.03237
G2 X119.757 Y126.635 I1.622 J2.368 E.05586
G2 X120.43 Y128 I2.032 J-.153 E.03237
G3 X121.677 Y130.276 I-1.622 J2.368 E.05586
G3 X120.958 Y131.685 I-1.815 J-.038 E.03395
G1 X120.391 Y130.086 E.0352
M204 S10000
G1 X127.026 Y138.356 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.00844
G1 X128.445 Y138.742 E.02676
G2 X127.433 Y139.835 I15.381 J15.249 E.03089
G2 X127.713 Y142.566 I1.711 J1.205 E.06211
G3 X128.808 Y143.951 I-2.541 J3.134 E.03692
G1 X125.317 Y143.951 E.07241
G2 X124.942 Y142.909 I-1.345 J-.104 E.02369
G1 X123.686 Y139.37 E.07787
G2 X124.925 Y138.014 I-48.611 J-45.669 E.0381
G2 X124.645 Y135.283 I-1.711 J-1.205 E.06211
G3 X123.398 Y133.007 I1.622 J-2.368 E.05586
G3 X124.072 Y131.642 I2.032 J.153 E.03237
G2 X124.615 Y131.106 I-2.039 J-2.609 E.01586
G1 X122.643 Y125.178 E.12958
G1 X123.509 Y125.178 E.01795
G3 X124.548 Y123.903 I3.315 J1.642 E.0344
G2 X125.31 Y122.022 I-1.723 J-1.793 E.04337
G1 X128.771 Y122.022 E.0718
G3 X128.287 Y124.359 I-1.838 J.837 E.05295
G2 X127.509 Y125.178 I3.143 J3.763 E.02349
G1 X130.792 Y125.178 E.06809
G3 X131.831 Y123.903 I3.315 J1.642 E.0344
G2 X132.593 Y122.022 I-1.723 J-1.793 E.04337
G1 X134.183 Y122.022 E.03298
G1 X134.717 Y120.394 E.03554
G3 X135.85 Y121.627 I-28.735 J27.535 E.03474
G3 X135.57 Y124.359 I-1.711 J1.205 E.06211
G2 X134.323 Y126.635 I1.622 J2.368 E.05586
G2 X134.996 Y128 I2.032 J-.153 E.03237
G3 X135.889 Y128.987 I-3.396 J3.971 E.02767
G1 X134.539 Y132.895 E.08578
G2 X134.407 Y133.278 I.826 J.5 E.00846
G1 X131.383 Y142.028 E.19202
G3 X131.355 Y138.925 I1.436 J-1.565 E.07216
G2 X132.602 Y136.649 I-1.622 J-2.368 E.05586
G2 X131.928 Y135.283 I-2.032 J.153 E.03237
G3 X130.681 Y133.007 I1.622 J-2.368 E.05586
G3 X131.355 Y131.642 I2.032 J.153 E.03237
G2 X132.602 Y129.366 I-1.622 J-2.369 E.05586
G2 X132.135 Y128.239 I-1.855 J.108 E.02578
G1 X132.671 Y126.629 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.135 Y128.239 E-.64485
G1 X132.323 Y128.455 E-.10883
G1 X132.33 Y128.47 E-.00632
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L33
M991 S0 P32 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.32 I.312 J-1.176 P1  F60000
G1 X123.325 Y126.079 Z4.32
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.44 F60000
G1 X119.605 Y114.987 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.44 F60000
G1 X141.28 Y114.497 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.829 Y112.049 Z4.44 F60000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.132 Y112.049 E.0352
G2 X138.414 Y112.523 I1.27 J-.434 E.01154
G3 X139.733 Y113.889 I-6.305 J7.409 E.03944
G3 X139.435 Y116.165 I-2.049 J.889 E.05
G2 X138.116 Y117.531 I6.306 J7.41 E.03944
G2 X138.898 Y120.278 I2.11 J.884 E.06399
G1 X139.453 Y118.674 E.0352
M204 S10000
G1 X135.339 Y118.497 F60000
G1 F9000
M204 S4000
G1 X135.869 Y116.885 E.0352
G2 X136.283 Y115.621 I-.958 J-1.014 E.02874
G1 X136.787 Y114.084 E.03355
G1 X135.527 Y114.084 E.02614
G1 X134.859 Y113.434 E.01934
G3 X134.273 Y112.049 I1.014 J-1.245 E.03247
G1 X130.849 Y112.049 E.07103
G2 X131.131 Y112.523 I1.27 J-.434 E.01154
G1 X132.066 Y113.434 E.02707
G3 X132.525 Y114.084 I-.705 J.985 E.01683
G1 X130.828 Y114.084 E.0352
M204 S10000
G1 X128.687 Y112.049 F60000
G1 F9000
M204 S4000
G1 X126.99 Y112.049 E.0352
G2 X127.576 Y113.434 I1.6 J.14 E.03247
G1 X128.244 Y114.084 E.01934
G1 X125.242 Y114.084 E.06227
M73 P49 R11
G2 X124.783 Y113.434 I-1.165 J.334 E.01683
G1 X123.848 Y112.523 E.02707
G3 X123.566 Y112.049 I.988 J-.909 E.01154
G1 X121.869 Y112.049 E.0352
; WIPE_START
G1 X123.566 Y112.049 E-.64486
G1 X123.721 Y112.309 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.7 Y119.318 Z4.44 F60000
G1 X118.435 Y124.575 Z4.44
G1 Z4.04
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.867 Y122.976 E.0352
G2 X117.5 Y120.717 I-1.674 J-.887 E.05097
G1 X116.836 Y120.071 E.01921
G1 X116.094 Y117.981 E.046
G3 X116.651 Y117.075 I1.579 J.347 E.02246
G1 X117.586 Y116.165 E.02707
G2 X117.884 Y113.889 I-1.751 J-1.387 E.05
G2 X116.565 Y112.523 I-7.624 J6.043 E.03944
G3 X116.283 Y112.049 I.988 J-.909 E.01154
G1 X119.707 Y112.049 E.07103
G2 X120.293 Y113.434 I1.6 J.14 E.03247
G1 X120.961 Y114.084 E.01934
G1 X118.92 Y114.084 E.04232
G1 X120.222 Y117.971 E.08502
G2 X119.909 Y120.262 I1.748 J1.406 E.05038
G2 X121.227 Y121.627 I7.624 J-6.044 E.03944
G3 X121.525 Y123.903 I-1.751 J1.387 E.05
G3 X120.206 Y125.269 I-7.624 J-6.043 E.03944
G2 X119.909 Y127.545 I1.751 J1.387 E.05
G2 X121.227 Y128.911 I7.623 J-6.042 E.03944
G3 X121.525 Y131.186 I-1.751 J1.387 E.05
G3 X120.994 Y131.785 I-3.319 J-2.411 E.01663
G1 X120.426 Y130.186 E.0352
; WIPE_START
G1 X120.994 Y131.785 E-.64486
G1 X121.195 Y131.559 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.922 Y135.164 Z4.44 F60000
G1 X129.543 Y136.033 Z4.44
G1 Z4.04
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X129.007 Y137.643 E.0352
G3 X128.683 Y138.618 I-1.586 J.014 E.02169
G1 X128.642 Y138.742 E.00272
G1 X128.578 Y138.742 E.00132
G3 X127.49 Y139.835 I-6.118 J-5.006 E.03205
G2 X127.192 Y142.111 I1.751 J1.387 E.05
G2 X128.511 Y143.477 I7.624 J-6.043 E.03944
G3 X128.793 Y143.951 I-.985 J.907 E.01153
G1 X125.369 Y143.951 E.07103
G2 X124.847 Y142.643 I-1.495 J-.162 E.03041
G1 X123.648 Y139.264 E.07437
G3 X124.869 Y138.014 I6.983 J5.602 E.03629
G2 X125.167 Y135.738 I-1.751 J-1.387 E.05
G2 X123.848 Y134.373 I-7.624 J6.043 E.03944
G3 X123.55 Y132.097 I1.751 J-1.387 E.05
G3 X124.583 Y131.01 I6.061 J4.725 E.03115
G1 X122.643 Y125.178 E.12749
G1 X123.411 Y125.178 E.01591
G3 X123.934 Y124.359 I1.439 J.343 E.02055
G1 X124.869 Y123.448 E.02707
G2 X125.367 Y122.022 I-1.914 J-1.469 E.03187
G1 X128.749 Y122.022 E.07015
G3 X128.424 Y124.359 I-1.544 J.976 E.05319
G1 X127.583 Y125.178 E.02436
G1 X130.694 Y125.178 E.06452
G3 X131.217 Y124.359 I1.439 J.343 E.02055
G1 X132.152 Y123.448 E.02707
G2 X132.651 Y122.022 I-1.914 J-1.469 E.03187
G1 X134.183 Y122.022 E.03178
G1 X134.68 Y120.505 E.03311
G2 X135.794 Y121.627 I6.279 J-5.117 E.03284
G3 X136.092 Y123.903 I-1.751 J1.387 E.05
G3 X134.773 Y125.269 I-7.625 J-6.044 E.03944
G2 X134.475 Y127.545 I1.751 J1.387 E.05
G3 X135.871 Y129.039 I-1176.635 J1101.363 E.04242
G1 X134.504 Y132.997 E.08686
G2 X131.416 Y141.933 I896.468 J314.768 E.19611
G3 X130.833 Y139.38 I1.421 J-1.667 E.05822
G3 X132.152 Y138.014 I7.624 J6.043 E.03944
G2 X132.45 Y135.738 I-1.751 J-1.387 E.05
G2 X131.131 Y134.373 I-7.624 J6.043 E.03944
G3 X130.864 Y132.06 I1.708 J-1.369 E.05092
G3 X132.152 Y130.731 I7.421 J5.904 E.03844
G2 X132.45 Y128.455 I-1.751 J-1.387 E.05
G1 X132.173 Y128.126 E.00893
G1 X132.708 Y126.516 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.173 Y128.126 E-.64486
G1 X132.368 Y128.358 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L34
M991 S0 P33 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.44 I.297 J-1.18 P1  F60000
G1 X123.325 Y126.079 Z4.44
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.56 F60000
G1 X119.605 Y114.987 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.56 F60000
G1 X141.28 Y114.497 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.477 Y118.603 Z4.56 F60000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.923 Y120.207 E.0352
G3 X137.972 Y117.531 I1.327 J-1.978 E.06311
G3 X139.383 Y116.165 I4.809 J3.554 E.0409
G2 X139.877 Y113.889 I-1.734 J-1.569 E.05057
G2 X138.467 Y112.523 I-4.808 J3.554 E.0409
G3 X138.141 Y112.049 I.979 J-1.022 E.01203
G1 X134.214 Y112.049 E.08145
G2 X134.331 Y112.979 I2.114 J.207 E.0196
G2 X135.445 Y114.084 I3.88 J-2.794 E.03271
G1 X132.651 Y114.084 E.05796
G1 X132.594 Y113.889 E.00422
G2 X131.184 Y112.523 I-4.808 J3.554 E.0409
G3 X130.858 Y112.049 I.979 J-1.022 E.01203
G1 X126.931 Y112.049 E.08145
G2 X127.048 Y112.979 I2.115 J.207 E.0196
G2 X128.162 Y114.084 I3.88 J-2.794 E.03271
G1 X125.367 Y114.084 E.05796
G1 X125.311 Y113.889 E.00422
G2 X123.901 Y112.523 I-4.808 J3.554 E.0409
G3 X123.575 Y112.049 I.978 J-1.022 E.01203
G1 X121.878 Y112.049 E.0352
; WIPE_START
G1 X123.575 Y112.049 E-.64486
G1 X123.746 Y112.298 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.711 Y119.302 Z4.56 F60000
G1 X118.431 Y124.564 Z4.56
G1 Z4.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.863 Y122.964 E.0352
G2 X118.028 Y121.172 I-1.938 J-1.082 E.03844
G2 X116.799 Y119.966 I-4.24 J3.089 E.03588
G1 X116.038 Y117.823 E.04716
G3 X116.495 Y117.075 I1.103 J.161 E.01868
G1 X117.533 Y116.165 E.02863
G2 X118.028 Y113.889 I-1.734 J-1.569 E.05057
G2 X116.618 Y112.523 I-4.808 J3.554 E.0409
G3 X116.292 Y112.049 I.979 J-1.022 E.01203
G1 X119.648 Y112.049 E.06962
G2 X120.137 Y113.434 I1.347 J.303 E.03213
G1 X120.879 Y114.084 E.02046
G1 X118.92 Y114.084 E.04062
G1 X120.237 Y118.017 E.08603
G2 X119.765 Y120.262 I1.739 J1.538 E.04976
G2 X121.175 Y121.627 I4.808 J-3.554 E.0409
G3 X121.669 Y123.903 I-1.734 J1.569 E.05057
G3 X120.259 Y125.269 I-4.808 J-3.554 E.0409
G2 X119.765 Y127.545 I1.734 J1.569 E.05057
G2 X121.175 Y128.911 I4.808 J-3.554 E.0409
G3 X121.669 Y131.186 I-1.734 J1.569 E.05057
G3 X121.027 Y131.879 I-2.4 J-1.584 E.01967
G1 X121.595 Y133.478 E.0352
; WIPE_START
G1 X121.027 Y131.879 E-.64486
G1 X121.233 Y131.656 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.045 Y135.098 Z4.56 F60000
G1 X129.594 Y135.881 Z4.56
G1 Z4.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X129.058 Y137.491 E.0352
G3 X128.58 Y138.925 I-1.358 J.344 E.03311
G1 X127.542 Y139.835 E.02863
G2 X127.048 Y142.111 I1.734 J1.569 E.05057
G2 X128.458 Y143.477 I4.808 J-3.554 E.0409
G3 X128.784 Y143.951 I-.978 J1.021 E.01203
G1 X125.428 Y143.951 E.06962
G2 X124.767 Y142.416 I-1.557 J-.24 E.03655
G1 X123.604 Y139.139 E.07213
G1 X124.816 Y138.014 E.0343
G2 X125.311 Y135.738 I-1.734 J-1.569 E.05057
G2 X123.901 Y134.373 I-4.808 J3.554 E.0409
G3 X123.406 Y132.097 I1.734 J-1.569 E.05057
G3 X124.564 Y130.953 I4.017 J2.907 E.03392
G1 X122.643 Y125.178 E.12624
G1 X123.301 Y125.178 E.01364
G3 X123.779 Y124.359 I1.197 J.149 E.02022
G1 X124.816 Y123.448 E.02863
G2 X125.433 Y122.022 I-1.915 J-1.676 E.03275
G1 X128.733 Y122.022 E.06845
G3 X128.952 Y123.903 I-1.933 J1.179 E.04053
G3 X127.646 Y125.178 I-4.483 J-3.288 E.03803
G1 X130.584 Y125.178 E.06094
G3 X131.062 Y124.359 I1.197 J.149 E.02022
G1 X132.099 Y123.448 E.02863
G2 X132.717 Y122.022 I-1.916 J-1.676 E.03275
G1 X134.183 Y122.022 E.03041
G1 X134.637 Y120.636 E.03025
G1 X135.741 Y121.627 E.03077
G3 X136.236 Y123.903 I-1.734 J1.569 E.05057
G3 X134.825 Y125.269 I-4.808 J-3.554 E.0409
G2 X134.331 Y127.545 I1.734 J1.569 E.05057
G2 X135.741 Y128.911 I4.808 J-3.554 E.0409
G1 X135.858 Y129.078 E.00423
G1 X134.468 Y133.101 E.0883
G2 X134.256 Y133.713 I1.563 J.883 E.01351
G1 X131.435 Y141.877 E.17915
G3 X130.689 Y139.38 I1.439 J-1.79 E.05747
G3 X132.099 Y138.014 I4.808 J3.554 E.0409
G2 X132.594 Y135.738 I-1.734 J-1.569 E.05057
G2 X131.184 Y134.373 I-4.808 J3.554 E.0409
G3 X130.567 Y132.954 I1.919 J-1.678 E.0326
G1 X130.964 Y131.762 E.02607
G1 X132.099 Y130.731 E.03181
G2 X132.594 Y128.455 I-1.734 J-1.569 E.05057
G2 X132.216 Y127.995 I-1.57 J.904 E.0124
G1 X132.752 Y126.385 E.0352
M204 S10000
G1 X135.254 Y118.758 F60000
G1 F9000
M204 S4000
G1 X135.783 Y117.146 E.0352
G2 X136.315 Y115.525 I-.951 J-1.21 E.03751
G1 X136.787 Y114.084 E.03144
G1 X136.606 Y114.084 E.00376
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.787 Y114.084 E-.06885
G1 X136.315 Y115.525 E-.57601
G1 X136.34 Y115.827 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L35
M991 S0 P34 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.56 I-.753 J-.956 P1  F60000
G1 X123.325 Y126.079 Z4.56
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.68 F60000
G1 X119.605 Y114.987 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
M73 P50 R11
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.68 F60000
G1 X141.28 Y114.497 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.501 Y118.536 Z4.68 F60000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.946 Y120.139 E.0352
G1 X138.517 Y119.807 E.01127
G3 X137.727 Y117.986 I2.134 J-2.008 E.042
G3 X138.158 Y117.075 I1.068 J-.051 E.02176
G1 X139.333 Y116.165 E.03082
G2 X140.123 Y114.344 I-2.134 J-2.008 E.042
G2 X139.691 Y113.434 I-1.068 J-.051 E.02176
G1 X138.517 Y112.523 E.03082
G3 X138.143 Y112.049 I.958 J-1.138 E.01262
G1 X134.187 Y112.049 E.08206
G2 X134.517 Y113.434 I1.154 J.457 E.03145
G1 X135.356 Y114.084 E.02203
G1 X132.795 Y114.084 E.05312
G1 X132.762 Y113.889 E.00411
G1 X132.408 Y113.434 E.01195
G1 X131.234 Y112.523 E.03082
G3 X130.86 Y112.049 I.958 J-1.138 E.01262
G1 X126.904 Y112.049 E.08206
G2 X127.233 Y113.434 I1.154 J.457 E.03145
G1 X128.073 Y114.084 E.02203
G1 X125.512 Y114.084 E.05312
G1 X125.478 Y113.889 E.00411
G1 X125.125 Y113.434 E.01195
G1 X123.951 Y112.523 E.03082
G3 X123.577 Y112.049 I.958 J-1.138 E.01262
G1 X121.88 Y112.049 E.0352
; WIPE_START
G1 X123.577 Y112.049 E-.64486
G1 X123.764 Y112.287 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.722 Y119.287 Z4.68 F60000
G1 X118.43 Y124.562 Z4.68
G1 Z4.28
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.863 Y122.963 E.0352
G2 X118.195 Y121.172 I-2.049 J-1.307 E.03872
G1 X117.842 Y120.717 E.01195
G1 X116.771 Y119.887 E.02811
G1 X115.949 Y117.57 E.05099
G1 X116.309 Y117.075 E.01269
G1 X117.483 Y116.165 E.03082
G2 X118.195 Y113.889 I-1.802 J-1.813 E.05146
G1 X117.842 Y113.434 E.01195
G1 X116.667 Y112.523 E.03082
G3 X116.294 Y112.049 I.958 J-1.138 E.01262
G1 X119.621 Y112.049 E.06901
G2 X119.95 Y113.434 I1.154 J.457 E.03145
G1 X120.79 Y114.084 E.02203
G1 X118.92 Y114.084 E.03878
G1 X120.251 Y118.059 E.08693
G2 X119.597 Y120.262 I1.762 J1.722 E.0496
G1 X119.95 Y120.717 E.01195
G1 X121.125 Y121.627 E.03082
G3 X121.837 Y123.903 I-1.802 J1.813 E.05146
G1 X121.484 Y124.359 E.01195
G1 X120.309 Y125.269 E.03082
G2 X119.597 Y127.545 I1.802 J1.813 E.05146
G1 X119.95 Y128 E.01195
G1 X121.125 Y128.911 E.03082
G3 X121.837 Y131.186 I-1.802 J1.813 E.05146
G3 X121.06 Y131.97 I-1.915 J-1.122 E.02314
G1 X121.627 Y133.57 E.0352
; WIPE_START
G1 X121.06 Y131.97 E-.64486
G1 X121.299 Y131.785 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.162 Y135.125 Z4.68 F60000
G1 X129.61 Y135.83 Z4.68
G1 Z4.28
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X129.075 Y137.441 E.0352
G3 X128.767 Y138.925 I-1.181 J.529 E.0336
G1 X127.592 Y139.835 E.03082
G2 X126.88 Y142.111 I1.802 J1.813 E.05146
G1 X127.233 Y142.566 E.01195
G1 X128.408 Y143.477 E.03082
G3 X128.782 Y143.951 I-.958 J1.138 E.01262
G1 X125.455 Y143.951 E.06901
G2 X125.125 Y142.566 I-1.154 J-.457 E.03145
G1 X124.704 Y142.24 E.01104
G1 X123.548 Y138.982 E.07173
G1 X124.766 Y138.014 E.03227
G2 X125.478 Y135.738 I-1.802 J-1.813 E.05146
G1 X125.125 Y135.283 E.01195
G1 X123.951 Y134.373 E.03082
G3 X123.239 Y132.097 I1.802 J-1.813 E.05146
G1 X123.592 Y131.642 E.01195
G1 X124.547 Y130.901 E.02506
G1 X122.643 Y125.178 E.12512
G1 X123.176 Y125.178 E.01105
G1 X123.239 Y124.814 E.00766
G1 X123.592 Y124.359 E.01195
G1 X124.766 Y123.448 E.03082
G2 X125.472 Y122.022 I-1.822 J-1.789 E.03356
G1 X128.723 Y122.022 E.06745
G3 X129.198 Y123.448 I-2.547 J1.64 E.0315
G3 X128.767 Y124.359 I-1.068 J.051 E.02176
G1 X127.71 Y125.178 E.02774
G1 X130.459 Y125.178 E.05704
G1 X130.522 Y124.814 E.00766
G1 X130.875 Y124.359 E.01195
G1 X132.05 Y123.448 E.03082
G2 X132.755 Y122.022 I-1.822 J-1.789 E.03356
G1 X134.183 Y122.022 E.02961
G1 X134.592 Y120.775 E.02722
G1 X135.691 Y121.627 E.02885
G3 X136.403 Y123.903 I-1.802 J1.813 E.05146
G1 X136.05 Y124.359 E.01195
G1 X134.875 Y125.269 E.03082
G2 X134.163 Y127.545 I1.802 J1.813 E.05146
G1 X134.517 Y128 E.01195
G1 X135.691 Y128.911 E.03082
G1 X135.848 Y129.107 E.00521
G1 X134.475 Y133.078 E.08717
G2 X134.179 Y133.937 I1.474 J.99 E.01905
G1 X131.453 Y141.826 E.17313
G3 X130.639 Y140.746 I1.745 J-2.161 E.02834
G1 X130.444 Y139.835 E.01931
G3 X130.875 Y138.925 I1.068 J-.051 E.02176
G1 X132.05 Y138.014 E.03082
G2 X132.762 Y135.738 I-1.802 J-1.813 E.05146
G1 X132.408 Y135.283 E.01195
G1 X131.234 Y134.373 E.03082
G3 X130.544 Y133.022 I1.782 J-1.76 E.03196
G1 X131.048 Y131.508 E.0331
G1 X132.05 Y130.731 E.02628
G2 X132.762 Y128.455 I-1.802 J-1.813 E.05146
G2 X132.254 Y127.881 I-1.373 J.701 E.01607
G1 X132.79 Y126.27 E.0352
M204 S10000
G1 X135.194 Y118.941 F60000
G1 F9000
M204 S4000
G1 X135.723 Y117.329 E.0352
G1 X136.05 Y117.075 E.00858
G2 X136.481 Y116.165 I-.637 J-.859 E.02176
G1 X136.332 Y115.471 E.01472
G1 X136.787 Y114.084 E.03027
G1 X136.55 Y114.084 E.00493
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.787 Y114.084 E-.0903
G1 X136.332 Y115.471 E-.55456
G1 X136.396 Y115.767 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L36
M991 S0 P35 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.68 I-.754 J-.955 P1  F60000
G1 X123.325 Y126.079 Z4.68
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.8 F60000
G1 X119.605 Y114.987 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.8 F60000
G1 X141.28 Y114.497 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
M204 S10000
G1 X140.904 Y114.473 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.039 Y114.084 E.00853
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y113.056 E.02133
M73 P51 R11
G1 X141.243 Y112.979 E.00195
G3 X141.296 Y112.049 I16.438 J.467 E.01932
G1 X138.15 Y112.068 E.06526
G2 X139.938 Y113.434 I4.807 J-4.442 E.04691
G1 X140.248 Y113.889 E.01142
G3 X139.7 Y115.71 I-2.932 J.11 E.04017
G3 X137.911 Y117.075 I-4.807 J-4.442 E.04691
G1 X137.601 Y117.531 E.01142
G2 X138.964 Y120.09 I2.907 J.095 E.06295
G1 X138.409 Y121.694 E.0352
M204 S10000
G1 X135.151 Y119.071 F60000
G1 F9000
M204 S4000
G1 X135.68 Y117.459 E.0352
G1 X136.297 Y117.075 E.01506
G1 X136.607 Y116.62 E.01142
G1 X136.61 Y116.165 E.00944
G1 X136.364 Y115.375 E.01717
G1 X136.787 Y114.084 E.02817
G1 X136.448 Y114.084 E.00703
M204 S10000
G1 X135.801 Y112.049 F60000
G1 F9000
M204 S4000
G1 X134.104 Y112.049 E.0352
G2 X133.96 Y112.979 I1.379 J.69 E.01984
G1 X134.27 Y113.434 E.01142
G3 X135.277 Y114.084 I-4.89 J8.677 E.02489
G1 X132.967 Y114.084 E.04793
G1 X132.965 Y113.889 E.00405
G1 X132.655 Y113.434 E.01142
G1 X131.923 Y112.979 E.01788
G3 X130.855 Y112.049 I2.191 J-3.595 E.02952
G1 X126.821 Y112.049 E.08367
G2 X126.677 Y112.979 I1.379 J.69 E.01984
G1 X126.987 Y113.434 E.01142
G3 X127.994 Y114.084 I-4.89 J8.677 E.02489
G1 X125.683 Y114.084 E.04793
G1 X125.682 Y113.889 E.00405
G1 X125.372 Y113.434 E.01142
G1 X124.64 Y112.979 E.01788
G3 X123.572 Y112.049 I2.191 J-3.595 E.02952
G1 X121.875 Y112.049 E.0352
; WIPE_START
G1 X123.572 Y112.049 E-.64486
G1 X123.774 Y112.274 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.733 Y119.274 Z4.8 F60000
G1 X118.432 Y124.568 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.865 Y122.969 E.0352
G2 X118.399 Y121.172 I-2.356 J-1.678 E.03959
G1 X118.089 Y120.717 E.01142
G3 X116.752 Y119.833 I6.659 J-11.521 E.03327
G1 X115.872 Y117.354 E.05455
G1 X116.062 Y117.075 E.007
G2 X117.851 Y115.71 I-3.018 J-5.807 E.04691
G2 X118.399 Y113.889 I-2.384 J-1.71 E.04017
G1 X118.089 Y113.434 E.01142
G3 X116.3 Y112.068 I3.019 J-5.807 E.04691
G1 X119.538 Y112.049 E.06716
G2 X119.394 Y112.979 I1.379 J.69 E.01984
G1 X119.704 Y113.434 E.01142
G3 X120.711 Y114.084 I-4.89 J8.677 E.02489
G1 X118.92 Y114.084 E.03714
G1 X120.262 Y118.09 E.08762
G2 X119.39 Y119.807 I2.214 J2.203 E.04059
G1 X119.394 Y120.262 E.00944
G1 X119.704 Y120.717 E.01142
G3 X121.492 Y122.083 I-3.019 J5.807 E.04691
G3 X122.04 Y123.903 I-2.384 J1.71 E.04017
G1 X121.73 Y124.359 E.01142
G2 X119.942 Y125.724 I3.019 J5.808 E.04691
G2 X119.391 Y127.27 I3.429 J2.092 E.03428
G2 X119.704 Y128 I1.545 J-.229 E.01665
G3 X121.492 Y129.366 I-3.018 J5.807 E.04691
G3 X122.04 Y131.186 I-2.384 J1.71 E.04017
G1 X121.73 Y131.642 E.01142
G1 X121.085 Y132.043 E.01576
G1 X121.653 Y133.642 E.0352
; WIPE_START
G1 X121.085 Y132.043 E-.64486
G1 X121.343 Y131.883 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.83 Y137.188 Z4.8 F60000
G1 X128.437 Y138.742 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.642 Y138.742 E.00426
G1 X129.113 Y137.327 E.03094
G3 X129.323 Y138.47 I-1.678 J.9 E.02449
G1 X129.013 Y138.925 E.01142
G2 X127.225 Y140.29 I3.019 J5.807 E.04691
G2 X126.677 Y142.111 I2.384 J1.711 E.04017
G1 X126.987 Y142.566 E.01142
G3 X128.775 Y143.932 I-3.018 J5.807 E.04691
G1 X125.538 Y143.951 E.06716
G2 X125.682 Y143.022 I-1.379 J-.69 E.01983
G1 X125.372 Y142.566 E.01142
G1 X124.664 Y142.126 E.01729
G1 X123.495 Y138.832 E.07251
G2 X125.134 Y137.559 I-2.894 J-5.419 E.04325
G2 X125.682 Y135.738 I-2.384 J-1.711 E.04017
G1 X125.372 Y135.283 E.01142
G3 X123.583 Y133.918 I3.018 J-5.807 E.04691
G3 X123.035 Y132.097 I2.384 J-1.711 E.04017
G1 X123.345 Y131.642 E.01142
G2 X124.534 Y130.863 I-5.864 J-10.242 E.0295
G1 X122.643 Y125.178 E.12426
G1 X123.032 Y125.178 E.00807
G1 X123.035 Y124.814 E.00755
G1 X123.345 Y124.359 E.01142
G2 X125.134 Y122.993 I-3.018 J-5.807 E.04691
G2 X125.562 Y122.022 I-1.857 J-1.4 E.02221
G1 X128.72 Y122.022 E.0655
G3 X129.327 Y123.448 I-2.753 J2.014 E.03243
G1 X129.323 Y123.903 E.00944
G1 X129.013 Y124.359 E.01142
G2 X127.768 Y125.178 I6.17 J10.734 E.03094
G1 X130.315 Y125.178 E.05284
G1 X130.318 Y124.814 E.00755
G1 X130.628 Y124.359 E.01142
G2 X132.417 Y122.993 I-3.018 J-5.807 E.04691
G2 X132.846 Y122.022 I-1.857 J-1.4 E.02221
G1 X134.183 Y122.022 E.02773
G1 X134.553 Y120.893 E.02465
G3 X136.058 Y122.083 I-2.799 J5.089 E.03998
G3 X136.607 Y123.903 I-2.384 J1.71 E.04017
G1 X136.297 Y124.359 E.01142
G2 X134.508 Y125.724 I3.019 J5.807 E.04691
G2 X133.96 Y127.545 I2.384 J1.71 E.04017
G1 X134.27 Y128 E.01142
G3 X135.841 Y129.127 I-3.422 J6.43 E.04022
G1 X134.489 Y133.04 E.08588
G2 X133.958 Y134.576 I3.356 J2.019 E.03395
G1 X131.466 Y141.787 E.15825
G3 X130.318 Y139.38 I1.742 J-2.308 E.05749
G1 X130.628 Y138.925 E.01142
G2 X132.417 Y137.559 I-3.019 J-5.807 E.04691
G2 X132.965 Y135.738 I-2.384 J-1.71 E.04017
G1 X132.655 Y135.283 E.01142
G3 X130.866 Y133.918 I3.018 J-5.807 E.04691
G3 X130.501 Y133.151 I1.453 J-1.162 E.01776
G1 X131.101 Y131.348 E.03943
G2 X132.417 Y130.276 I-2.711 J-4.672 E.03534
G2 X132.965 Y128.455 I-2.384 J-1.71 E.04017
G2 X132.29 Y127.773 I-1.109 J.422 E.02049
G1 X132.826 Y126.163 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.29 Y127.773 E-.64485
G1 X132.547 Y127.933 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L37
M991 S0 P36 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.8 I.24 J-1.193 P1  F60000
G1 X123.325 Y126.079 Z4.8
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z4.92 F60000
G1 X119.605 Y114.987 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z4.92 F60000
G1 X141.28 Y114.497 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
M204 S10000
G1 X140.755 Y114.905 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.039 Y114.084 E.018
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y113.513 E.01186
M73 P51 R10
G1 X141.127 Y113.434 E.00386
G1 X140.979 Y112.979 E.00993
G3 X141.291 Y112.049 I3.143 J.536 E.02043
G1 X138.125 Y112.049 E.06568
G2 X138.61 Y112.523 I1.347 J-.89 E.01418
G2 X140.364 Y113.434 I5.76 J-8.955 E.04106
G1 X140.512 Y113.889 E.00993
G3 X139.24 Y116.165 I-4.022 J-.754 E.05504
G3 X137.486 Y117.075 I-5.76 J-8.955 E.04106
G2 X137.45 Y117.986 I.714 J.483 E.01991
G2 X138.985 Y120.026 I3.192 J-.804 E.05439
G1 X138.431 Y121.63 E.0352
M204 S10000
G1 X135.106 Y119.208 F60000
G1 F9000
M204 S4000
G1 X135.635 Y117.596 E.0352
G3 X136.722 Y117.075 I3.334 J5.572 E.02504
G2 X136.758 Y116.165 I-.714 J-.483 E.01991
G1 X136.391 Y115.292 E.01965
G1 X136.787 Y114.084 E.02635
G1 X135.154 Y114.084 E.03387
G2 X133.844 Y113.434 I-4.145 J6.703 E.03039
G3 X133.809 Y112.523 I.714 J-.483 E.01991
G1 X134.008 Y112.049 E.01068
G1 X130.842 Y112.049 E.06568
G2 X132.105 Y112.979 I3.06 J-2.833 E.03273
G1 X133.081 Y113.434 E.02234
G1 X133.229 Y113.889 E.00993
G1 X133.18 Y114.084 E.00418
G1 X127.871 Y114.084 E.11013
G2 X126.561 Y113.434 I-4.145 J6.703 E.03039
G3 X126.526 Y112.523 I.714 J-.483 E.01991
G1 X126.725 Y112.049 E.01068
G1 X123.559 Y112.049 E.06568
G2 X124.822 Y112.979 I3.06 J-2.833 E.03273
G1 X125.798 Y113.434 E.02234
G1 X125.946 Y113.889 E.00993
G1 X125.897 Y114.084 E.00418
G1 X120.588 Y114.084 E.11013
G2 X119.278 Y113.434 I-4.145 J6.703 E.03039
G3 X119.242 Y112.523 I.714 J-.483 E.01991
G1 X119.442 Y112.049 E.01068
G1 X116.275 Y112.049 E.06568
G2 X117.538 Y112.979 I3.06 J-2.833 E.03273
G1 X118.515 Y113.434 E.02234
G3 X118.55 Y114.344 I-.714 J.483 E.01991
G3 X116.612 Y116.62 I-3.305 J-.851 E.06417
G1 X115.754 Y117.021 E.01965
G1 X116.76 Y119.807 E.06144
G2 X118.515 Y120.717 I5.759 J-8.953 E.04106
G3 X118.55 Y121.627 I-.714 J.483 E.01991
G3 X117.869 Y122.982 I-3.781 J-1.05 E.03164
G1 X118.437 Y124.581 E.0352
M204 S10000
G1 X119.731 Y116.504 F60000
G1 F9000
M204 S4000
G1 X120.269 Y118.114 E.0352
G2 X119.242 Y119.807 I2.364 J2.592 E.04164
G2 X119.278 Y120.717 I.749 J.427 E.01991
G1 X120.254 Y121.172 E.02234
G3 X122.191 Y123.448 I-1.368 J3.127 E.06417
G3 X122.156 Y124.359 I-.749 J.427 E.01991
G1 X121.18 Y124.814 E.02234
G2 X119.288 Y126.98 I1.278 J3.025 E.06175
G1 X119.724 Y128.208 E.02703
G1 X120.254 Y128.455 E.01212
G3 X122.191 Y130.731 I-1.368 J3.127 E.06417
G3 X122.156 Y131.642 I-.749 J.427 E.01991
G2 X121.117 Y132.133 I2.118 J5.817 E.02387
G1 X121.685 Y133.733 E.0352
; WIPE_START
G1 X121.117 Y132.133 E-.64486
G1 X121.391 Y132.004 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.693 Y134.225 Z4.92 F60000
G1 X133.567 Y135.708 Z4.92
G1 Z4.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X133.781 Y135.089 E.01359
G1 X133.696 Y134.828 E.00569
G3 X134.502 Y133.002 I4.385 J.844 E.04175
G1 X135.836 Y129.14 E.08475
G2 X133.844 Y128 I-4.391 J5.364 E.04783
G3 X133.809 Y127.09 I.714 J-.483 E.01991
G3 X135.746 Y124.814 I3.305 J.851 E.06417
G1 X136.722 Y124.359 E.02234
G2 X136.758 Y123.448 I-.714 J-.483 E.01991
G2 X134.509 Y121.027 I-3.41 J.912 E.07132
G1 X134.183 Y122.022 E.02172
G1 X132.951 Y122.022 E.02556
G3 X131.179 Y123.903 I-2.921 J-.976 E.05532
G1 X130.202 Y124.359 E.02234
G2 X130.145 Y125.178 I.629 J.456 E.01795
G1 X127.841 Y125.178 E.04779
G3 X129.439 Y124.359 I5.194 J8.166 E.03732
G2 X129.475 Y123.448 I-.714 J-.483 E.01991
G2 X128.724 Y122.022 I-3.838 J1.109 E.03366
G1 X125.667 Y122.022 E.06341
G3 X123.896 Y123.903 I-2.921 J-.976 E.05532
G1 X122.919 Y124.359 E.02234
G2 X122.861 Y125.178 I.629 J.456 E.01795
G1 X122.643 Y125.178 E.00453
G1 X124.52 Y130.821 E.12336
G3 X122.919 Y131.642 I-5.201 J-8.175 E.03737
G2 X122.884 Y132.552 I.714 J.483 E.01991
G2 X124.822 Y134.828 I3.305 J-.851 E.06417
G1 X125.798 Y135.283 E.02234
G3 X125.833 Y136.194 I-.714 J.483 E.01991
G3 X123.896 Y138.47 I-3.305 J-.851 E.06417
G1 X123.441 Y138.681 E.01039
G1 X124.616 Y141.991 E.07284
G2 X125.798 Y142.566 I3.677 J-6.05 E.02731
G3 X125.833 Y143.477 I-.714 J.483 E.01991
G1 X125.634 Y143.951 E.01067
G1 X128.8 Y143.951 E.06567
G2 X127.537 Y143.022 I-3.062 J2.836 E.03272
G1 X126.561 Y142.566 E.02234
G3 X126.526 Y141.656 I.714 J-.483 E.01991
G3 X128.463 Y139.38 I3.305 J.851 E.06417
G1 X129.439 Y138.925 E.02234
G2 X129.475 Y138.014 I-.714 J-.483 E.01991
G1 X129.145 Y137.229 E.01766
G1 X128.642 Y138.742 E.03308
G1 X128.54 Y138.742 E.00212
M204 S10000
G1 X132.035 Y140.142 F60000
M73 P52 R10
G1 F9000
M204 S4000
G1 X131.48 Y141.746 E.0352
G3 X130.167 Y139.835 I1.941 J-2.74 E.0491
G3 X130.202 Y138.925 I.749 J-.427 E.01991
G2 X131.957 Y138.014 I-4.005 J-9.864 E.04106
G2 X133.229 Y135.738 I-2.75 J-3.03 E.05504
G1 X133.081 Y135.283 E.00993
G3 X131.326 Y134.373 I4.005 J-9.864 E.04106
G3 X130.465 Y133.262 I1.886 J-2.352 E.02944
G1 X131.15 Y131.2 E.04507
G2 X133.229 Y128.455 I-1.53 J-3.318 E.07435
G1 X133.081 Y128 E.00993
G1 X132.331 Y127.65 E.01717
G1 X132.866 Y126.04 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.331 Y127.65 E-.64485
G1 X132.605 Y127.778 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L38
M991 S0 P37 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z4.92 I.219 J-1.197 P1  F60000
G1 X123.325 Y126.079 Z4.92
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.04 F60000
G1 X119.605 Y114.987 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.04 F60000
G1 X141.28 Y114.497 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.552 Y118.387 Z5.04 F60000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.998 Y119.991 E.0352
G3 X138.47 Y119.677 I.467 J-1.383 E.01285
G3 X137.104 Y117.699 I4.651 J-4.673 E.05012
G1 X136.649 Y117.442 E.01084
G2 X135.597 Y117.713 I.023 J2.272 E.02275
G1 X136.406 Y115.248 E.05381
G3 X137.104 Y116.451 I-8.428 J5.694 E.02889
G1 X137.559 Y116.708 E.01084
G2 X139.38 Y116.035 I-.535 J-4.246 E.04062
G2 X140.746 Y114.058 I-4.651 J-4.673 E.05012
G1 X141.201 Y113.801 E.01084
G1 X141.296 Y113.812 E.00198
G1 X141.296 Y112.049 E.03657
G1 X141.165 Y112.049 E.00271
G1 X140.746 Y112.81 E.01803
G1 X140.29 Y113.067 E.01084
G1 X139.835 Y113.016 E.0095
G3 X138.116 Y112.049 I.697 J-3.249 E.04154
G1 X133.882 Y112.049 E.08783
G1 X133.462 Y112.81 E.01803
G1 X133.007 Y113.067 E.01084
G1 X132.552 Y113.016 E.0095
G3 X130.833 Y112.049 I.697 J-3.249 E.04154
G1 X126.599 Y112.049 E.08783
G1 X126.179 Y112.81 E.01803
G1 X125.724 Y113.067 E.01084
G1 X125.269 Y113.016 E.0095
G3 X123.55 Y112.049 I.697 J-3.249 E.04154
G1 X119.316 Y112.049 E.08783
G1 X118.896 Y112.81 E.01803
G1 X118.441 Y113.067 E.01084
G1 X117.986 Y113.016 E.0095
G3 X116.267 Y112.049 I.697 J-3.249 E.04154
G1 X114.704 Y112.049 E.03242
G1 X114.704 Y112.183 E.00278
M204 S10000
G1 X119.73 Y116.502 F60000
G1 F9000
M204 S4000
G1 X120.262 Y118.116 E.03524
G2 X118.896 Y120.093 I4.651 J4.673 E.05012
G1 X118.441 Y120.35 E.01084
G3 X116.718 Y119.739 I.532 J-4.232 E.03821
G1 X115.626 Y116.661 E.06774
G1 X115.71 Y116.708 E.00199
G2 X117.531 Y116.035 I-.535 J-4.246 E.04062
G2 X118.896 Y114.058 I-4.651 J-4.673 E.05012
G1 X119.351 Y113.801 E.01084
G3 X120.44 Y114.084 I-.032 J2.354 E.02357
G1 X126.165 Y114.084 E.11874
G1 X126.634 Y113.801 E.01138
G3 X127.723 Y114.084 I-.032 J2.354 E.02357
G1 X133.448 Y114.084 E.11874
G1 X133.918 Y113.801 E.01138
G3 X135.006 Y114.084 I-.032 J2.354 E.02357
G1 X136.703 Y114.084 E.0352
M204 S10000
G1 X136.392 Y127.533 F60000
G1 F9000
M204 S4000
G1 X135.837 Y129.137 E.0352
G1 X135.738 Y129.041 E.00287
G2 X133.918 Y128.367 I-2.356 J3.572 E.04062
G1 X133.462 Y128.624 E.01084
G1 X133.007 Y129.45 E.01956
G3 X131.2 Y131.052 I-2.725 J-1.255 E.05156
G1 X130.438 Y133.343 E.05008
G2 X131.186 Y134.243 I2.335 J-1.181 E.02449
G2 X133.007 Y134.916 I2.356 J-3.572 E.04062
G1 X133.462 Y134.659 E.01084
G3 X134.503 Y133 I7.694 J3.666 E.04072
G1 X135.057 Y131.396 E.0352
M204 S10000
G1 X134.061 Y134.278 F60000
G1 F9000
M204 S4000
G1 X133.462 Y135.907 E.03599
G3 X132.097 Y137.884 I-6.017 J-2.696 E.05012
G3 X130.276 Y138.558 I-2.356 J-3.572 E.04062
G1 X129.821 Y138.301 E.01084
G2 X129.166 Y137.165 I-8.61 J4.206 E.0272
G1 X128.607 Y138.742 E.03471
M204 S10000
G1 X132.044 Y140.114 F60000
G1 F9000
M204 S4000
G1 X131.49 Y141.718 E.0352
G1 X131.186 Y141.526 E.00745
G3 X129.821 Y139.549 I4.651 J-4.673 E.05012
G1 X129.366 Y139.292 E.01084
G2 X127.545 Y139.965 I.535 J4.246 E.04062
G2 X126.179 Y141.942 I4.651 J4.673 E.05012
G1 X125.724 Y142.199 E.01084
G3 X124.582 Y141.896 I.045 J-2.471 E.02474
G1 X125.312 Y143.951 E.04523
G1 X125.76 Y143.951 E.0093
G1 X126.179 Y143.19 E.01802
G1 X126.634 Y142.933 E.01084
G1 X127.09 Y142.984 E.0095
G3 X128.808 Y143.951 I-.697 J3.249 E.04153
G1 X130.505 Y143.951 E.0352
M204 S10000
G1 X122.814 Y136.915 F60000
G1 F9000
M204 S4000
G1 X123.382 Y138.514 E.0352
G2 X124.814 Y137.884 I-1.511 J-5.375 E.03255
G2 X126.179 Y135.907 I-4.651 J-4.673 E.05012
G1 X125.857 Y134.841 E.0231
G1 X125.724 Y134.916 E.00317
G3 X123.903 Y134.243 I.535 J-4.246 E.04062
G3 X122.538 Y132.266 I4.651 J-4.673 E.05012
G1 X122.083 Y132.009 E.01084
G2 X121.153 Y132.234 I-.008 J2.001 E.02003
G1 X121.721 Y133.833 E.0352
M204 S10000
G1 X123.975 Y129.183 F60000
G1 F9000
M204 S4000
G1 X124.511 Y130.793 E.0352
G3 X122.993 Y131.275 I-2.125 J-4.064 E.0332
G1 X122.538 Y131.018 E.01084
G1 X122.083 Y130.192 E.01956
G2 X119.807 Y128.418 I-2.931 J1.413 E.06201
G1 X119.22 Y126.788 E.03593
G3 X120.262 Y125.399 I4.75 J2.477 E.03617
G3 X122.083 Y124.726 I2.356 J3.572 E.04062
G1 X122.538 Y124.983 E.01084
G1 X122.645 Y125.178 E.00463
G1 X127.894 Y125.178 E.10888
G3 X129.366 Y124.726 I2.132 J4.317 E.03207
G1 X129.821 Y124.983 E.01084
G1 X129.929 Y125.178 E.00463
G1 X133.153 Y125.178 E.06689
G1 X132.375 Y127.517 E.05114
G2 X133.007 Y127.633 I.551 J-1.227 E.01346
G1 X133.462 Y127.376 E.01084
G3 X134.828 Y125.399 I6.017 J2.696 E.05012
G3 X136.649 Y124.726 I2.356 J3.572 E.04062
G1 X137.104 Y124.983 E.01084
G1 X137.208 Y125.171 E.00446
G1 X137.618 Y123.985 E.02603
G1 X137.104 Y123.735 E.01185
G1 X136.649 Y122.909 E.01956
G2 X134.463 Y121.168 I-2.852 J1.339 E.06005
G1 X134.183 Y122.022 E.01865
G1 X133.087 Y122.022 E.02272
G3 X132.097 Y123.318 I-4.636 J-2.516 E.03397
G3 X130.276 Y123.991 I-2.356 J-3.572 E.04062
G1 X129.821 Y123.735 E.01084
G2 X128.726 Y122.022 I-6.956 J3.24 E.04228
G1 X125.804 Y122.022 E.06062
G3 X124.814 Y123.318 I-4.636 J-2.516 E.03397
G3 X122.993 Y123.991 I-2.356 J-3.572 E.04062
G1 X122.538 Y123.735 E.01084
G2 X121.172 Y121.757 I-6.017 J2.696 E.05012
G2 X119.351 Y121.084 I-2.356 J3.572 E.04062
G1 X118.896 Y121.341 E.01084
G3 X117.871 Y122.986 I-7.994 J-3.84 E.04029
G1 X118.438 Y124.585 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X117.871 Y122.986 E-.64486
G1 X118.044 Y122.737 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L39
M991 S0 P38 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.04 I-.651 J1.028 P1  F60000
G1 X123.325 Y126.079 Z5.04
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.16 F60000
G1 X119.605 Y114.987 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.16 F60000
G1 X141.28 Y114.497 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
M73 P53 R10
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.568 Y118.339 Z5.16 F60000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.014 Y119.943 E.0352
G3 X138.014 Y119.279 I1.08 J-2.71 E.02508
G1 X137.104 Y118.009 E.03241
G1 X136.649 Y117.673 E.01173
G2 X135.569 Y117.797 I-.371 J1.537 E.02301
G1 X136.424 Y115.193 E.05685
G1 X137.104 Y116.142 E.02422
G1 X137.559 Y116.477 E.01173
G2 X139.835 Y115.637 I.303 J-2.681 E.0522
G3 X141.039 Y114.084 I12.637 J8.553 E.04077
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X141.069 Y112.049 E.0047
G3 X140.29 Y112.836 I-1.603 J-.807 E.02335
G3 X138.076 Y112.049 I-.325 J-2.593 E.05055
G1 X133.786 Y112.049 E.08899
G3 X133.007 Y112.836 I-1.603 J-.807 E.02335
G3 X130.793 Y112.049 I-.325 J-2.593 E.05055
G1 X126.503 Y112.049 E.08899
G3 X125.724 Y112.836 I-1.603 J-.807 E.02335
G3 X123.51 Y112.049 I-.325 J-2.593 E.05055
G1 X119.22 Y112.049 E.08899
G3 X118.441 Y112.836 I-1.603 J-.807 E.02335
G3 X116.227 Y112.049 I-.325 J-2.593 E.05055
G1 X114.704 Y112.049 E.03159
G1 X114.704 Y114.084 E.04223
G1 X115.508 Y116.329 E.04945
G1 X115.71 Y116.477 E.0052
G2 X117.986 Y115.637 I.303 J-2.681 E.0522
G1 X118.992 Y114.297 E.03475
G1 X118.92 Y114.084 E.00465
G1 X119.28 Y114.084 E.00746
G3 X120.163 Y114.084 I.441 J1.151 E.01873
G1 X126.563 Y114.084 E.13276
G3 X127.446 Y114.084 I.441 J1.151 E.01873
G1 X133.846 Y114.084 E.13276
G3 X134.729 Y114.084 I.441 J1.151 E.01873
G1 X136.426 Y114.084 E.0352
M204 S10000
G1 X136.393 Y127.53 F60000
G1 F9000
M204 S4000
G1 X135.838 Y129.134 E.0352
G2 X134.373 Y128.556 I-1.816 J2.458 E.03305
G1 X133.918 Y128.598 E.00948
G1 X133.462 Y128.934 E.01173
G1 X132.552 Y130.203 E.03241
G3 X131.233 Y130.953 I-1.893 J-1.798 E.03193
G1 X130.417 Y133.406 E.05363
G2 X132.552 Y134.727 I2.39 J-1.476 E.05399
G1 X133.007 Y134.685 E.00948
G1 X133.462 Y134.35 E.01173
G1 X134.373 Y133.08 E.03241
G1 X134.518 Y132.956 E.00396
G1 X135.072 Y131.352 E.0352
M204 S10000
G1 X133.879 Y134.805 F60000
G1 F9000
M204 S4000
G1 X133.325 Y136.409 E.0352
G1 X132.552 Y137.486 E.0275
G3 X130.276 Y138.327 I-1.973 J-1.841 E.0522
G1 X129.821 Y137.991 E.01173
G1 X129.186 Y137.106 E.02259
G1 X128.651 Y138.716 E.0352
M204 S10000
G1 X132.054 Y140.087 F60000
G1 F9000
M204 S4000
G1 X131.5 Y141.691 E.0352
G3 X130.731 Y141.128 I.967 J-2.126 E.01989
G1 X129.821 Y139.858 E.03241
G1 X129.366 Y139.523 E.01173
G2 X127.09 Y140.363 I-.303 J2.681 E.0522
G1 X126.179 Y141.633 E.03241
G1 X125.724 Y141.968 E.01173
G1 X125.269 Y142.01 E.00948
G1 X124.556 Y141.821 E.01531
G1 X125.312 Y143.951 E.04688
G1 X125.724 Y143.951 E.00855
G3 X126.634 Y143.164 I3.13 J2.701 E.02505
G3 X128.848 Y143.951 I.325 J2.592 E.05054
G1 X130.545 Y143.951 E.0352
M204 S10000
G1 X122.759 Y136.758 F60000
G1 F9000
M204 S4000
G1 X123.326 Y138.357 E.0352
G2 X125.269 Y137.486 I-.07 J-2.758 E.04533
G1 X126.288 Y136.137 E.03508
G1 X125.789 Y134.637 E.03278
G1 X125.724 Y134.685 E.00168
G3 X123.448 Y133.845 I-.303 J-2.681 E.0522
G1 X122.538 Y132.575 E.03241
G2 X121.182 Y132.316 I-.858 J.811 E.03058
G1 X121.75 Y133.915 E.0352
M204 S10000
G1 X123.966 Y129.155 F60000
G1 F9000
M204 S4000
G1 X124.502 Y130.765 E.0352
G1 X123.448 Y131.085 E.02284
G1 X122.993 Y131.044 E.00948
G1 X122.538 Y130.708 E.01173
G1 X121.627 Y129.439 E.03241
G2 X119.852 Y128.568 I-2.146 J2.132 E.04177
G1 X119.179 Y126.672 E.04174
G1 X119.807 Y125.797 E.02234
G3 X122.083 Y124.957 I1.973 J1.84 E.0522
G3 X122.805 Y125.665 I-.731 J1.469 E.02135
G1 X123.341 Y127.276 E.0352
; WIPE_START
G1 X122.805 Y125.665 E-.64486
G1 X122.629 Y125.419 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.263 Y125.178 Z5.16 F60000
G1 Z4.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X127.96 Y125.178 E.0352
G1 X128.91 Y124.915 E.02045
G3 X129.666 Y125.178 I.16 J.757 E.01744
G1 X133.153 Y125.178 E.07233
G1 X132.412 Y127.407 E.04872
G2 X133.007 Y127.402 I.291 J-.816 E.01261
G1 X133.462 Y127.067 E.01173
G1 X134.373 Y125.797 E.03241
G3 X136.194 Y124.915 I2.177 J2.173 E.04276
G3 X137.146 Y125.35 I.125 J.984 E.02288
G1 X137.691 Y123.773 E.03462
G1 X137.559 Y123.76 E.00274
G1 X137.104 Y123.425 E.01173
G1 X136.194 Y122.155 E.03241
G2 X134.424 Y121.287 I-2.142 J2.127 E.04165
G1 X134.183 Y122.022 E.01605
G1 X133.196 Y122.022 E.02047
G1 X132.552 Y122.92 E.02292
G3 X130.731 Y123.802 I-2.177 J-2.173 E.04276
G1 X130.276 Y123.76 E.00948
G1 X129.821 Y123.425 E.01173
G1 X128.91 Y122.155 E.03241
G1 X128.755 Y122.022 E.00425
G1 X125.913 Y122.022 E.05895
G1 X125.269 Y122.92 E.02292
G3 X123.448 Y123.802 I-2.177 J-2.173 E.04276
G1 X122.993 Y123.76 E.00948
G1 X122.538 Y123.425 E.01173
G1 X121.627 Y122.155 E.03241
G2 X119.807 Y121.273 I-2.177 J2.173 E.04276
G1 X119.351 Y121.315 E.00948
G1 X118.896 Y121.651 E.01173
G1 X117.88 Y123.011 E.03523
G1 X116.711 Y119.719 E.07246
G1 X117.075 Y119.919 E.00862
G1 X117.986 Y120.161 E.01954
G1 X118.441 Y120.119 E.00948
G1 X118.896 Y119.783 E.01173
G1 X119.807 Y118.514 E.03241
G3 X120.271 Y118.118 I1.179 J.915 E.01274
G1 X119.732 Y116.509 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.271 Y118.118 E-.64485
G1 X120.04 Y118.315 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L40
M991 S0 P39 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.16 I-1.121 J.474 P1  F60000
G1 X123.325 Y126.079 Z5.16
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.28 F60000
G1 X119.605 Y114.987 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.28 F60000
G1 X141.28 Y114.497 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.58 Y118.306 Z5.28 F60000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.026 Y119.91 E.0352
G3 X138.014 Y119.327 I.981 J-2.87 E.02436
G1 X137.104 Y118.222 E.0297
G2 X135.556 Y117.836 I-1.074 J1.01 E.03496
G1 X136.445 Y115.129 E.0591
G2 X137.559 Y116.293 I3.323 J-2.066 E.03367
G2 X139.835 Y115.686 I.59 J-2.359 E.05101
G1 X140.746 Y114.58 E.0297
G2 X141.039 Y114.084 I-.246 J-.48 E.01261
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.942 Y112.049 E.00734
G3 X138.925 Y112.6 I-1.316 J-.849 E.0475
G3 X138.021 Y112.049 I.876 J-2.455 E.02211
G1 X133.659 Y112.049 E.09047
G3 X131.642 Y112.6 I-1.316 J-.849 E.0475
G3 X130.738 Y112.049 I.876 J-2.455 E.02211
G1 X126.376 Y112.049 E.09047
G3 X124.359 Y112.6 I-1.316 J-.849 E.0475
G3 X123.454 Y112.049 I.876 J-2.455 E.02211
G1 X119.093 Y112.049 E.09047
G3 X117.075 Y112.6 I-1.316 J-.849 E.0475
G3 X116.171 Y112.049 I.876 J-2.455 E.02211
G1 X114.704 Y112.049 E.03043
G1 X114.704 Y114.084 E.04223
G1 X115.41 Y116.053 E.04339
G2 X116.62 Y116.364 I.904 J-1.012 E.02692
G2 X117.986 Y115.686 I-.608 J-2.937 E.03198
G1 X119.046 Y114.46 E.03361
M73 P54 R10
G1 X120.271 Y118.119 E.08003
G2 X119.807 Y118.465 I.604 J1.295 E.0121
G1 X118.896 Y119.57 E.0297
G3 X117.531 Y120.005 I-1.063 J-.975 E.03111
G3 X116.708 Y119.71 I.417 J-2.455 E.01822
G1 X117.89 Y123.04 E.0733
G1 X118.896 Y121.864 E.03211
G3 X120.262 Y121.429 I1.063 J.975 E.03111
G3 X121.627 Y122.107 I-.608 J2.937 E.03198
G1 X122.538 Y123.212 E.0297
G2 X123.903 Y123.647 I1.063 J-.975 E.03111
G2 X125.269 Y122.969 I-.608 J-2.937 E.03198
G1 X126.049 Y122.022 E.02544
G1 X128.797 Y122.022 E.05702
G1 X129.821 Y123.212 E.03255
G2 X131.186 Y123.647 I1.063 J-.975 E.03111
G2 X132.552 Y122.969 I-.608 J-2.937 E.03198
G1 X133.332 Y122.022 E.02544
G1 X134.183 Y122.022 E.01765
G1 X134.388 Y121.396 E.01367
G3 X136.194 Y122.107 I.005 J2.635 E.04122
G1 X137.104 Y123.212 E.0297
G1 X137.559 Y123.576 E.01209
G1 X137.744 Y123.618 E.00394
G1 X137.095 Y125.498 E.04124
G2 X135.738 Y125.07 I-1.053 J.976 E.03086
G2 X134.373 Y125.748 I.608 J2.937 E.03198
G1 X133.462 Y126.854 E.0297
G3 X132.443 Y127.314 I-1.03 J-.922 E.0239
G1 X133.153 Y125.178 E.0467
G1 X129.366 Y125.141 E.07856
G2 X128.055 Y125.178 I-.601 J1.968 E.02768
G1 X126.358 Y125.178 E.0352
; WIPE_START
G1 X128.055 Y125.178 E-.64486
G1 X128.348 Y125.099 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.433 Y127.552 Z5.28 F60000
G1 Z4.88
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X122.897 Y125.942 E.0352
G2 X122.083 Y125.141 I-2.309 J1.536 E.02386
G2 X119.807 Y125.748 I-.59 J2.359 E.05101
G1 X119.139 Y126.559 E.02178
G1 X119.893 Y128.684 E.04678
G3 X121.627 Y129.39 I-.051 J2.61 E.03972
G1 X122.538 Y130.495 E.0297
G1 X122.993 Y130.859 E.01209
G2 X124.494 Y130.744 I.615 J-1.824 E.03209
G1 X123.959 Y129.133 E.0352
M204 S10000
G1 X121.762 Y133.951 F60000
G1 F9000
M204 S4000
G1 X121.195 Y132.352 E.0352
G3 X122.538 Y132.788 I.287 J1.401 E.03064
G1 X123.448 Y133.893 E.0297
G2 X125.74 Y134.488 I1.665 J-1.704 E.05139
G1 X126.342 Y136.3 E.0396
G1 X125.269 Y137.535 E.03394
G3 X123.273 Y138.207 I-1.724 J-1.822 E.04508
G1 X122.705 Y136.607 E.0352
M204 S10000
G1 X130.601 Y143.951 F60000
G1 F9000
M204 S4000
G1 X128.904 Y143.951 E.0352
G2 X126.634 Y143.349 I-1.68 J1.753 E.05083
G3 X125.865 Y143.951 I-11.968 J-14.508 E.02028
G1 X125.312 Y143.951 E.01147
G1 X124.542 Y141.782 E.04776
G2 X125.724 Y141.784 I.595 J-1.866 E.02492
G1 X126.179 Y141.42 E.01209
G1 X127.09 Y140.315 E.0297
G3 X129.366 Y139.708 I1.686 J1.752 E.05101
G1 X129.821 Y140.071 E.01209
G1 X130.731 Y141.176 E.0297
G2 X131.507 Y141.669 I1.575 J-1.624 E.01919
G1 X132.061 Y140.065 E.0352
M204 S10000
G1 X128.674 Y138.646 F60000
G1 F9000
M204 S4000
G1 X129.209 Y137.036 E.0352
G2 X130.276 Y138.142 I3.161 J-1.981 E.0321
G2 X132.552 Y137.535 I.59 J-2.359 E.05101
G1 X133.213 Y136.733 E.02155
G1 X133.767 Y135.129 E.0352
M204 S10000
G1 X135.087 Y131.307 F60000
G1 F9000
M204 S4000
G1 X134.533 Y132.911 E.0352
G1 X134.373 Y133.032 E.00416
G1 X133.462 Y134.137 E.0297
G3 X132.097 Y134.572 I-1.063 J-.975 E.03111
G3 X130.392 Y133.481 I.453 J-2.586 E.0431
G1 X131.245 Y130.914 E.05611
G2 X132.552 Y130.252 I-.637 J-2.876 E.03071
G1 X133.462 Y129.147 E.0297
G3 X134.828 Y128.712 I1.063 J.975 E.03111
G3 X135.841 Y129.126 I-.605 J2.927 E.02283
G1 X136.396 Y127.522 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X135.841 Y129.126 E-.64485
G1 X135.573 Y128.985 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L41
M991 S0 P40 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.28 I.281 J-1.184 P1  F60000
G1 X123.325 Y126.079 Z5.28
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.4 F60000
G1 X119.605 Y114.987 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.4 F60000
G1 X141.28 Y114.497 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.592 Y118.271 Z5.4 F60000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.038 Y119.875 E.0352
G3 X138.014 Y119.378 I.706 J-2.755 E.02376
G2 X136.649 Y118.014 I-5.824 J4.463 E.04016
G2 X135.539 Y117.89 I-.752 J1.705 E.02353
G1 X136.465 Y115.067 E.06163
G2 X137.559 Y116.137 I4.58 J-3.587 E.03184
G2 X139.835 Y115.737 I.797 J-2.136 E.05027
G1 X140.834 Y114.677 E.0302
G1 X141.039 Y114.084 E.013
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.809 Y112.049 E.0101
G3 X138.47 Y112.393 I-1.372 J-1.203 E.05336
G3 X137.972 Y112.049 I.435 J-1.162 E.01268
G1 X133.526 Y112.049 E.09222
G3 X131.186 Y112.393 I-1.372 J-1.203 E.05336
G3 X130.688 Y112.049 I.435 J-1.162 E.01268
G1 X126.243 Y112.049 E.09222
G3 X123.903 Y112.393 I-1.372 J-1.203 E.05336
G3 X123.405 Y112.049 I.435 J-1.162 E.01268
G1 X118.96 Y112.049 E.09222
G3 X116.62 Y112.393 I-1.372 J-1.203 E.05336
G3 X116.122 Y112.049 I.435 J-1.162 E.01268
G1 X114.704 Y112.049 E.02941
G1 X114.704 Y114.084 E.04223
G1 X115.327 Y115.819 E.03824
G2 X117.075 Y116.212 I1.2 J-1.252 E.03905
G2 X117.986 Y115.737 I-.683 J-2.416 E.02146
G3 X119.09 Y114.59 I4.874 J3.586 E.03311
G1 X120.269 Y118.114 E.07708
G2 X119.807 Y118.414 I.489 J1.259 E.01153
G3 X118.441 Y119.779 I-5.824 J-4.462 E.04016
G3 X116.708 Y119.71 I-.791 J-1.933 E.03709
G1 X117.902 Y123.074 E.07404
G1 X117.986 Y123.02 E.00207
G3 X119.351 Y121.655 I5.825 J4.463 E.04016
G3 X121.627 Y122.056 I.797 J2.136 E.05027
G2 X122.993 Y123.42 I5.824 J-4.462 E.04016
G2 X125.269 Y123.02 I.797 J-2.136 E.05027
G1 X126.193 Y122.022 E.02821
G1 X128.91 Y122.056 E.05637
G2 X130.276 Y123.42 I5.824 J-4.463 E.04016
G2 X132.552 Y123.02 I.797 J-2.136 E.05027
G1 X133.476 Y122.022 E.02821
G1 X134.183 Y122.022 E.01465
G1 X134.351 Y121.51 E.01118
G3 X136.194 Y122.056 I.257 J2.517 E.04089
G2 X137.559 Y123.42 I5.824 J-4.462 E.04016
G1 X137.786 Y123.497 E.00497
G1 X137.049 Y125.63 E.04681
G2 X135.283 Y125.222 I-1.217 J1.241 E.03955
G2 X134.373 Y125.697 I.683 J2.417 E.02146
G3 X133.007 Y127.062 I-5.825 J-4.463 E.04016
G3 X132.475 Y127.216 I-.512 J-.77 E.01167
G1 X133.153 Y125.178 E.04456
G1 X129.012 Y125.178 E.08591
G2 X126.533 Y125.178 I-1.239 J26.505 E.05143
; WIPE_START
G1 X128.455 Y125.135 E-.73057
G1 X128.533 Y125.141 E-.02943
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.497 Y127.744 Z5.4 F60000
G1 Z5
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X122.961 Y126.134 E.0352
G2 X122.083 Y125.297 I-3.594 J2.893 E.02525
G2 X119.807 Y125.697 I-.797 J2.136 E.05027
G1 X119.103 Y126.459 E.0215
G1 X119.928 Y128.783 E.05115
G3 X121.627 Y129.339 I.142 J2.44 E.03796
G1 X122.538 Y130.325 E.02784
G2 X124.489 Y130.728 I1.268 J-1.219 E.04393
G1 X123.953 Y129.117 E.0352
M204 S10000
G1 X121.786 Y134.018 F60000
G1 F9000
M204 S4000
G1 X121.219 Y132.419 E.0352
G3 X122.538 Y132.958 I.11 J1.615 E.0306
G1 X123.448 Y133.944 E.02784
G2 X125.695 Y134.355 I1.477 J-1.732 E.04964
G1 X126.385 Y136.429 E.04534
G2 X125.269 Y137.586 I3.802 J4.784 E.03345
G3 X123.222 Y138.064 I-1.489 J-1.759 E.04527
G1 X122.654 Y136.464 E.0352
M204 S10000
G1 X130.692 Y143.951 F60000
G1 F9000
M204 S4000
G1 X128.995 Y143.951 E.0352
G2 X127.09 Y143.352 I-1.73 J2.17 E.04238
G2 X126.179 Y143.883 I.23 J1.44 E.02237
G1 X126.059 Y143.951 E.00286
G1 X125.312 Y143.951 E.01551
G1 X124.525 Y141.735 E.04878
G2 X126.179 Y141.25 I.444 J-1.549 E.03773
G1 X127.09 Y140.264 E.02784
G3 X129.366 Y139.863 I1.479 J1.735 E.05027
G3 X130.731 Y141.228 I-4.459 J5.828 E.04016
G2 X131.513 Y141.653 I1.408 J-1.657 E.01858
G1 X132.067 Y140.049 E.0352
M204 S10000
G1 X128.696 Y138.58 F60000
G1 F9000
M204 S4000
G1 X129.231 Y136.97 E.0352
G1 X129.821 Y137.608 E.01802
G2 X130.731 Y138.139 I1.14 J-.909 E.02237
G2 X133.137 Y136.953 I.195 J-2.636 E.05835
G1 X133.691 Y135.349 E.0352
M204 S10000
G1 X135.103 Y131.261 F60000
G1 F9000
M204 S4000
G1 X134.549 Y132.865 E.0352
G1 X134.373 Y132.98 E.00437
G3 X133.007 Y134.345 I-5.824 J-4.462 E.04016
G3 X130.368 Y133.551 I-.799 J-2.128 E.06141
G1 X131.267 Y130.85 E.05905
G2 X132.552 Y130.303 I-.406 J-2.737 E.02929
G3 X133.918 Y128.938 I5.825 J4.464 E.04016
G3 X135.846 Y129.112 I.788 J2.047 E.0416
G1 X136.4 Y127.508 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X135.846 Y129.112 E-.64485
G1 X135.569 Y128.989 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L42
M991 S0 P41 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.4 I.281 J-1.184 P1  F60000
G1 X123.325 Y126.079 Z5.4
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.52 F60000
G1 X119.605 Y114.987 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
M73 P55 R10
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.52 F60000
G1 X141.28 Y114.497 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.602 Y118.242 Z5.52 F60000
G1 Z5.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.048 Y119.846 E.0352
G3 X137.104 Y118.538 I.611 J-3.006 E.04987
G2 X135.524 Y117.933 I-1.322 J1.087 E.0367
G1 X136.493 Y114.982 E.06442
G3 X137.104 Y115.613 I-2.742 J3.268 E.01825
G2 X138.925 Y116.191 I1.388 J-1.217 E.04165
G2 X140.763 Y114.881 I-1.153 J-3.565 E.04756
G1 X141.039 Y114.084 E.01748
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.655 Y112.049 E.01329
G3 X137.9 Y112.049 I-1.377 J-1.448 E.06305
G1 X133.372 Y112.049 E.09393
G3 X130.617 Y112.049 I-1.377 J-1.448 E.06305
G1 X126.089 Y112.049 E.09393
G3 X123.334 Y112.049 I-1.377 J-1.448 E.06305
G1 X118.806 Y112.049 E.09393
G3 X116.051 Y112.049 I-1.377 J-1.448 E.06305
G1 X114.704 Y112.049 E.02793
G1 X114.704 Y114.084 E.04223
G1 X115.254 Y115.612 E.03368
G1 X115.71 Y116.002 E.01244
G2 X117.986 Y115.791 I.964 J-1.986 E.04983
G2 X119.126 Y114.7 I-53.343 J-56.9 E.03274
G1 X120.266 Y118.102 E.07442
G2 X118.896 Y119.255 I2.145 J3.938 E.03738
G3 X116.711 Y119.718 I-1.415 J-1.288 E.04948
G1 X117.916 Y123.113 E.07474
G3 X119.351 Y121.791 I141.93 J152.575 E.04049
G3 X121.558 Y121.962 I.958 J1.955 E.04816
G1 X121.651 Y122.022 E.00228
G2 X122.993 Y123.285 I58.419 J-60.751 E.03823
G2 X125.269 Y123.074 I.964 J-1.986 E.04983
G2 X126.364 Y122.022 I-31.033 J-33.388 E.03149
G1 X128.934 Y122.022 E.05331
G2 X130.276 Y123.285 I58.379 J-60.708 E.03823
G2 X132.552 Y123.074 I.964 J-1.986 E.04983
G2 X133.647 Y122.022 I-31.019 J-33.374 E.03149
G1 X134.183 Y122.022 E.01112
G1 X134.313 Y121.624 E.0087
G3 X136.649 Y122.403 I.519 J2.334 E.05365
G2 X137.821 Y123.396 I2.689 J-1.987 E.03215
G1 X137.011 Y125.741 E.05148
G2 X135.283 Y125.243 I-1.299 J1.26 E.03903
G2 X133.462 Y126.538 I1.219 J3.642 E.04702
G3 X132.506 Y127.124 I-1.562 J-1.476 E.02354
G1 X133.042 Y125.513 E.0352
M204 S10000
G1 X135.298 Y130.696 F60000
G1 F9000
M204 S4000
G1 X135.853 Y129.092 E.0352
G2 X133.462 Y129.463 I-.955 J1.736 E.05397
G3 X131.642 Y130.757 I-3.039 J-2.348 E.04702
G1 X131.284 Y130.797 E.00746
G1 X130.336 Y133.65 E.06236
G2 X133.007 Y134.21 I1.709 J-1.501 E.06073
G2 X134.373 Y132.926 I-65.638 J-71.211 E.03887
G1 X134.566 Y132.818 E.00459
G1 X133.056 Y137.186 E.09587
G3 X130.276 Y137.851 I-1.816 J-1.448 E.06387
G3 X129.262 Y136.878 I10.054 J-11.488 E.02917
G1 X128.727 Y138.488 E.0352
M204 S10000
G1 X132.07 Y140.038 F60000
G1 F9000
M204 S4000
G1 X131.516 Y141.642 E.0352
G3 X129.821 Y140.387 I1.377 J-3.633 E.04431
G2 X128 Y139.81 I-1.388 J1.217 E.04165
G2 X126.179 Y141.104 I1.219 J3.642 E.04702
G3 X124.512 Y141.699 I-1.332 J-1.098 E.03855
G1 X125.312 Y143.951 E.04957
G1 X126.27 Y143.951 E.01988
G3 X129.024 Y143.951 I1.377 J1.448 E.06303
G1 X130.719 Y143.949 E.03516
M204 S10000
G1 X122.606 Y136.328 F60000
G1 F9000
M204 S4000
G1 X123.174 Y137.928 E.0352
G2 X125.269 Y137.64 I.785 J-2.056 E.04576
G2 X126.422 Y136.539 I-63.764 J-67.881 E.03307
G1 X125.657 Y134.238 E.05029
G3 X124.359 Y134.399 I-.879 J-1.778 E.02765
G3 X122.538 Y133.104 I1.219 J-3.642 E.04702
G2 X121.241 Y132.482 I-1.387 J1.23 E.03063
G1 X121.809 Y134.082 E.0352
M204 S10000
G1 X123.95 Y129.107 F60000
G1 F9000
M204 S4000
G1 X124.486 Y130.717 E.0352
G3 X122.538 Y130.179 I-.556 J-1.783 E.04428
G2 X120.717 Y128.885 I-3.039 J2.348 E.04702
G2 X119.958 Y128.866 I-.423 J1.71 E.01588
G1 X119.066 Y126.354 E.05529
G3 X121.627 Y125.24 I2.195 J1.547 E.06092
G3 X122.993 Y126.314 I-1.23 J2.968 E.0365
G1 X123.569 Y127.96 E.03616
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X122.993 Y126.314 E-.66248
G1 X122.809 Y126.136 E-.09752
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L43
M991 S0 P42 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.52 I.133 J1.21 P1  F60000
G1 X123.325 Y126.079 Z5.52
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.64 F60000
G1 X119.605 Y114.987 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.64 F60000
G1 X141.28 Y114.497 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.61 Y118.218 Z5.64 F60000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.056 Y119.822 E.0352
G3 X137.104 Y118.67 I.321 J-2.773 E.04842
G2 X135.513 Y117.967 I-1.508 J1.262 E.03736
G1 X136.515 Y114.914 E.06665
G1 X136.649 Y115.018 E.00352
G2 X138.014 Y116.108 I3.222 J-2.639 E.0365
G2 X140.695 Y115.08 I.57 J-2.521 E.06313
G1 X141.039 Y114.084 E.02184
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.507 Y112.049 E.01636
G3 X137.813 Y112.049 I-1.347 J-1.59 E.06077
G1 X133.224 Y112.049 E.09518
G3 X130.53 Y112.049 I-1.347 J-1.59 E.06077
G1 X125.941 Y112.049 E.09518
M73 P56 R10
G3 X123.247 Y112.049 I-1.347 J-1.59 E.06077
G1 X118.658 Y112.049 E.09518
G3 X115.963 Y112.049 I-1.347 J-1.59 E.06077
G1 X114.704 Y112.049 E.02612
G1 X114.704 Y114.084 E.04223
G1 X115.181 Y115.406 E.02914
G2 X117.986 Y115.849 I1.646 J-1.322 E.06461
G2 X119.159 Y114.798 I-11.567 J-14.091 E.03269
G1 X120.26 Y118.085 E.0719
G2 X118.896 Y119.123 I1.564 J3.469 E.03585
G3 X116.716 Y119.732 I-1.546 J-1.327 E.04979
G1 X117.932 Y123.158 E.07541
G2 X118.896 Y122.311 I-2.877 J-4.249 E.02669
G3 X121.537 Y121.9 I1.565 J1.365 E.06023
G1 X121.578 Y122.022 E.00266
G1 X121.727 Y122.022 E.00309
G3 X122.538 Y122.764 I-2.496 J3.54 E.02286
G2 X125.269 Y123.132 I1.58 J-1.407 E.06225
G2 X126.509 Y122.022 I-13.575 J-16.418 E.03453
G1 X129.01 Y122.022 E.05188
G3 X129.821 Y122.764 I-2.496 J3.54 E.02286
G2 X132.552 Y123.132 I1.58 J-1.407 E.06225
G2 X133.792 Y122.022 I-13.573 J-16.415 E.03453
G1 X134.183 Y122.022 E.0081
G1 X134.278 Y121.732 E.00633
G3 X136.649 Y122.302 I.741 J2.138 E.05342
G2 X137.851 Y123.309 I3.317 J-2.737 E.03272
G1 X136.976 Y125.841 E.05556
G2 X133.918 Y125.943 I-1.479 J1.555 E.07067
G3 X132.535 Y127.035 I-3.426 J-2.915 E.03678
G1 X133.071 Y125.425 E.0352
M204 S10000
G1 X135.307 Y130.671 F60000
G1 F9000
M204 S4000
G1 X135.861 Y129.067 E.0352
G2 X133.462 Y129.594 I-.85 J1.853 E.05468
G3 X131.298 Y130.755 I-2.241 J-1.582 E.05281
G1 X130.31 Y133.726 E.06494
G2 X133.462 Y133.689 I1.559 J-1.49 E.07332
G3 X134.583 Y132.768 I3.013 J2.522 E.03026
G1 X134.029 Y134.372 E.0352
M204 S10000
G1 X130.748 Y143.866 F60000
G1 F9000
M204 S4000
G1 X130.718 Y143.951 E.00187
G1 X129.112 Y143.951 E.03333
G2 X126.418 Y143.951 I-1.347 J1.59 E.06075
G1 X125.312 Y143.951 E.02295
G1 X124.503 Y141.672 E.05017
G2 X125.269 Y141.599 I.22 J-1.736 E.0161
G2 X126.634 Y140.509 I-1.856 J-3.728 E.0365
G3 X129.821 Y140.519 I1.589 J1.473 E.07426
M73 P56 R9
G2 X131.518 Y141.637 I2.606 J-2.108 E.04283
G1 X133.001 Y137.345 E.0942
G3 X130.276 Y137.73 I-1.607 J-1.542 E.06153
G3 X129.286 Y136.805 I25.291 J-28.079 E.02809
G1 X128.751 Y138.416 E.0352
; WIPE_START
G1 X129.286 Y136.805 E-.64486
G1 X129.508 Y137.012 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.56 Y136.198 Z5.64 F60000
G1 Z5.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.127 Y137.797 E.0352
G2 X125.269 Y137.698 I.984 J-1.926 E.04652
G2 X126.454 Y136.637 I-11.929 J-14.51 E.03302
G1 X125.623 Y134.138 E.05461
G3 X124.814 Y134.4 I-.863 J-1.283 E.01788
G3 X122.538 Y133.236 I-.024 J-2.759 E.05514
G2 X121.262 Y132.541 I-1.6 J1.42 E.03074
G1 X121.83 Y134.141 E.0352
M204 S10000
G1 X123.948 Y129.102 F60000
G1 F9000
M204 S4000
G1 X124.484 Y130.712 E.0352
G3 X122.538 Y130.047 I-.415 J-1.968 E.04478
G2 X120.262 Y128.883 I-2.252 J1.594 E.05514
G1 X119.982 Y128.935 E.0059
G1 X119.035 Y126.265 E.05877
G3 X121.627 Y125.326 I2.011 J1.505 E.06054
G3 X122.993 Y126.416 I-1.856 J3.728 E.0365
G1 X123.077 Y126.482 E.00221
G1 X123.612 Y128.092 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X123.077 Y126.482 E-.64486
G1 X122.993 Y126.416 E-.04057
G1 X122.85 Y126.281 E-.07457
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L44
M991 S0 P43 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.64 I.475 J1.12 P1  F60000
G1 X123.325 Y126.079 Z5.64
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.76 F60000
G1 X119.605 Y114.987 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z5.76 F60000
G1 X141.28 Y114.497 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.617 Y118.2 Z5.76 F60000
G1 Z5.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.062 Y119.804 E.0352
G3 X137.104 Y118.793 I.07 J-2.54 E.04728
G2 X135.505 Y117.992 I-1.734 J1.462 E.03813
G1 X136.539 Y114.841 E.06879
G3 X137.104 Y115.357 I-1.367 J2.062 E.01594
G2 X140.632 Y115.262 I1.726 J-1.454 E.08405
G1 X141.039 Y114.084 E.02583
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.377 Y112.049 E.01906
G3 X137.7 Y112.049 I-1.338 J-1.664 E.06001
G1 X133.094 Y112.049 E.09555
G3 X130.417 Y112.049 I-1.338 J-1.664 E.06001
G1 X125.811 Y112.049 E.09555
G3 X123.134 Y112.049 I-1.338 J-1.664 E.06001
G1 X118.528 Y112.049 E.09555
G3 X115.851 Y112.049 I-1.338 J-1.664 E.06001
G1 X114.704 Y112.049 E.02378
G1 X114.704 Y114.084 E.04223
G1 X115.116 Y115.224 E.02512
G2 X117.986 Y115.911 I1.86 J-1.431 E.06619
G2 X119.189 Y114.887 I-5.738 J-7.965 E.03281
G1 X120.252 Y118.062 E.06944
G2 X118.896 Y118.999 I1.117 J3.066 E.03456
G3 X116.723 Y119.751 I-1.696 J-1.385 E.05023
G1 X117.95 Y123.208 E.0761
G2 X118.896 Y122.435 I-2.35 J-3.84 E.02543
G3 X121.516 Y121.837 I1.681 J1.328 E.06025
G1 X121.578 Y122.022 E.00405
G1 X121.828 Y122.022 E.00518
G3 X122.538 Y122.641 I-1.621 J2.578 E.01961
G2 X125.269 Y123.194 I1.7 J-1.371 E.06269
G2 X126.638 Y122.022 I-8.447 J-11.252 E.03741
G1 X129.111 Y122.022 E.05129
G3 X129.821 Y122.641 I-1.621 J2.578 E.01961
G2 X132.552 Y123.194 I1.7 J-1.371 E.06269
G2 X133.918 Y122.024 I-6.891 J-9.424 E.03734
G3 X134.183 Y122.022 I.134 J.23 E.00575
G1 X134.243 Y121.837 E.00403
G3 X136.649 Y122.201 I.931 J1.979 E.05351
G2 X137.877 Y123.234 I4.309 J-3.879 E.03339
G1 X136.945 Y125.933 E.05923
G2 X133.918 Y125.843 I-1.56 J1.509 E.06952
G3 X132.565 Y126.947 I-4.186 J-3.748 E.03637
G1 X131.31 Y130.721 E.08251
G2 X133.462 Y129.718 I.14 J-2.511 E.05131
G3 X135.872 Y129.036 I1.707 J1.433 E.05516
G1 X134.601 Y132.715 E.08073
G2 X133.462 Y133.565 I1.359 J3.007 E.02971
G3 X130.284 Y133.805 I-1.704 J-1.403 E.07387
G1 X129.311 Y136.729 E.06393
G3 X129.821 Y137.207 I-1.271 J1.866 E.01454
G2 X132.956 Y137.477 I1.699 J-1.394 E.07274
G1 X131.518 Y141.638 E.09132
G3 X130.731 Y141.402 I.142 J-1.9 E.01717
G3 X129.366 Y140.232 I6.892 J-9.426 E.03734
G2 X126.179 Y140.848 I-1.267 J1.992 E.07422
G3 X124.496 Y141.653 I-1.733 J-1.461 E.03989
G1 X125.312 Y143.951 E.05058
G1 X126.548 Y143.951 E.02565
G3 X129.224 Y143.951 I1.338 J1.664 E.05999
G1 X130.718 Y143.951 E.03099
G1 X130.785 Y143.759 E.00421
M204 S10000
G1 X122.514 Y136.07 F60000
G1 F9000
M204 S4000
G1 X123.082 Y137.669 E.0352
G2 X125.269 Y137.76 I1.172 J-1.832 E.04758
G2 X126.484 Y136.726 I-5.825 J-8.074 E.03313
G1 X125.594 Y134.051 E.05848
G1 X125.269 Y134.237 E.00778
G3 X122.538 Y133.36 I-.764 J-2.311 E.06363
G2 X121.282 Y132.596 I-1.86 J1.644 E.03096
G1 X120.714 Y130.997 E.0352
M204 S10000
G1 X123.949 Y129.103 F60000
G1 F9000
M204 S4000
G1 X124.484 Y130.713 E.0352
G3 X122.538 Y129.924 I-.254 J-2.169 E.04545
G2 X120.003 Y128.994 I-1.961 J1.426 E.05939
G1 X119.004 Y126.178 E.06198
G3 X122.538 Y126.077 I1.807 J1.353 E.08424
G2 X123.117 Y126.603 I1.973 J-1.588 E.01631
G1 X122.643 Y125.178 E.03116
G1 X122.838 Y125.178 E.00404
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X122.643 Y125.178 E-.07402
G1 X123.117 Y126.603 E-.57085
G1 X122.893 Y126.4 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L45
M991 S0 P44 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.76 I.725 J.978 P1  F60000
G1 X123.325 Y126.079 Z5.76
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z5.88 F60000
G1 X119.605 Y114.987 Z5.88
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P57 R9
G1 X128.259 Y115.926 Z5.88 F60000
G1 X141.28 Y114.497 Z5.88
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.621 Y118.187 Z5.88 F60000
G1 Z5.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.067 Y119.791 E.0352
G3 X137.104 Y118.914 I-.143 J-2.314 E.04637
G2 X135.499 Y118.01 I-2.009 J1.69 E.03903
G1 X136.565 Y114.763 E.07088
G3 X137.104 Y115.237 I-.978 J1.656 E.01498
G2 X140.573 Y115.432 I1.816 J-1.358 E.0821
G1 X141.039 Y114.084 E.02957
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.248 Y112.049 E.02172
G3 X137.556 Y112.049 I-1.346 J-1.721 E.06018
G1 X132.965 Y112.049 E.09521
G3 X130.272 Y112.049 I-1.346 J-1.721 E.06018
G1 X125.682 Y112.049 E.09521
G3 X122.989 Y112.049 I-1.346 J-1.721 E.06018
G1 X118.399 Y112.049 E.09521
G3 X115.706 Y112.049 I-1.346 J-1.721 E.06018
G1 X114.704 Y112.049 E.02078
G1 X114.704 Y114.084 E.04223
G1 X115.055 Y115.052 E.02136
G1 X115.255 Y115.237 E.00564
G2 X117.986 Y115.978 I1.845 J-1.394 E.06317
G2 X119.217 Y114.972 I-3.476 J-5.51 E.03308
G1 X120.242 Y118.033 E.06696
G2 X118.896 Y118.879 I.754 J2.694 E.03344
G3 X116.732 Y119.776 I-1.871 J-1.455 E.05084
G1 X116.164 Y118.177 E.0352
; WIPE_START
G1 X116.732 Y119.776 E-.64485
G1 X117.034 Y119.768 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.465 Y125.132 Z5.88 F60000
G1 X133.466 Y135.999 Z5.88
G1 Z5.48
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X132.912 Y137.602 E.0352
G3 X130.731 Y137.807 I-1.269 J-1.794 E.04757
G3 X129.338 Y136.648 I7.323 J-10.215 E.03762
G1 X130.258 Y133.884 E.06041
G2 X133.462 Y133.445 I1.385 J-1.802 E.07466
G3 X134.62 Y132.66 I2.095 J1.842 E.02933
G1 X135.885 Y128.998 E.08035
G2 X133.462 Y129.839 I-.585 J2.225 E.05642
G3 X131.318 Y130.695 I-1.815 J-1.43 E.05015
G1 X132.595 Y126.854 E.08396
G2 X133.462 Y126.162 I-1.496 J-2.76 E.02314
G3 X136.915 Y126.02 I1.785 J1.372 E.08169
G1 X137.9 Y123.167 E.0626
G3 X137.104 Y122.52 I1.404 J-2.541 E.02139
G2 X134.373 Y121.834 I-1.798 J1.378 E.06303
G2 X134.183 Y122.022 I.021 J.212 E.00599
G2 X133.462 Y122.555 I.332 J1.201 E.01902
G3 X130.276 Y122.946 I-1.785 J-1.369 E.07415
G2 X129.243 Y122.022 I-7.789 J7.668 E.02877
G1 X126.8 Y122.022 E.05067
G2 X126.179 Y122.555 I1.175 J1.995 E.01706
G3 X123.448 Y123.241 I-1.798 J-1.378 E.06303
G3 X122.083 Y122.099 I4.532 J-6.805 E.037
G2 X121.578 Y122.022 I-.314 J.365 E.01116
G1 X121.494 Y121.771 E.00548
G2 X119.351 Y122.129 I-.755 J2.076 E.04711
G3 X117.97 Y123.266 I-6.501 J-6.488 E.03716
G1 X118.973 Y126.091 E.06217
G3 X122.083 Y125.771 I1.717 J1.413 E.07191
G2 X123.156 Y126.72 I6.796 J-6.602 E.02976
G1 X124.486 Y130.72 E.08742
G3 X122.538 Y129.803 I-.068 J-2.385 E.04635
G2 X120.021 Y129.044 I-1.783 J1.359 E.05827
G1 X121.3 Y132.647 E.07929
G3 X122.538 Y133.48 I-.942 J2.736 E.03132
G2 X125.568 Y133.972 I1.774 J-1.349 E.07025
G1 X126.512 Y136.81 E.06204
G1 X126.179 Y137.122 E.00945
G3 X123.036 Y137.541 I-1.781 J-1.361 E.07305
G1 X124.492 Y141.641 E.09025
G2 X126.179 Y140.728 I-.313 J-2.594 E.04075
G3 X129.821 Y140.763 I1.807 J1.416 E.08723
G2 X131.515 Y141.645 I1.916 J-1.613 E.04065
G1 X130.718 Y143.951 E.05062
G1 X129.369 Y143.951 E.02799
G2 X126.677 Y143.951 I-1.346 J1.722 E.06016
G1 X125.312 Y143.951 E.02832
G1 X125.201 Y143.639 E.00688
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.312 Y143.951 E-.12611
G1 X126.677 Y143.951 E-.51875
G1 X126.931 Y143.787 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L46
M991 S0 P45 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z5.88 I1.192 J-.243 P1  F60000
G1 X123.325 Y126.079 Z5.88
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6 F60000
G1 X119.605 Y114.987 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6 F60000
G1 X141.28 Y114.497 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.463 Y119.446 Z6 F60000
G1 X133.127 Y125.178 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.626 Y126.763 E.03449
G2 X133.918 Y125.634 I-9.084 J-11.69 E.03562
G3 X136.885 Y126.104 I1.22 J1.902 E.06818
G1 X135.901 Y128.953 E.06252
G2 X133.462 Y129.96 I-.41 J2.464 E.05765
G3 X131.324 Y130.676 I-1.645 J-1.359 E.04928
G1 X131.86 Y129.066 E.0352
M204 S10000
G1 X135.195 Y130.997 F60000
G1 F9000
M204 S4000
G1 X134.641 Y132.601 E.0352
G1 X134.373 Y132.665 E.00571
G2 X133.007 Y133.769 I2.484 J4.469 E.03661
G3 X130.23 Y133.967 I-1.508 J-1.574 E.06264
G1 X129.368 Y136.56 E.05668
G3 X130.276 Y137.411 I-9.008 J10.526 E.02583
G2 X132.87 Y137.726 I1.506 J-1.568 E.05813
G1 X133.424 Y136.122 E.0352
M204 S10000
G1 X125.246 Y143.766 F60000
G1 F9000
M204 S4000
G1 X125.312 Y143.951 E.00408
G1 X126.812 Y143.951 E.03112
G3 X129.489 Y143.951 I1.338 J1.641 E.0601
M73 P58 R9
G1 X130.718 Y143.951 E.02551
G1 X131.511 Y141.658 E.05033
G3 X130.731 Y141.543 I-.134 J-1.782 E.01648
G3 X129.366 Y140.439 I2.484 J-4.469 E.03661
G2 X126.179 Y140.607 I-1.514 J1.589 E.0741
G3 X124.49 Y141.636 I-2.33 J-1.925 E.0418
G1 X122.989 Y137.407 E.09307
G2 X125.269 Y137.901 I1.55 J-1.645 E.05084
G2 X126.539 Y136.891 I-2.305 J-4.2 E.03382
G1 X125.544 Y133.9 E.06537
G3 X122.538 Y133.601 I-1.35 J-1.686 E.0694
G2 X121.316 Y132.693 I-2.581 J2.198 E.03184
G1 X120.036 Y129.086 E.07939
G3 X122.538 Y129.682 I.849 J1.985 E.05714
G2 X124.491 Y130.733 I2.098 J-1.558 E.04751
G1 X123.195 Y126.837 E.08518
G3 X122.083 Y125.872 I3.207 J-4.824 E.03062
G2 X118.941 Y126.001 I-1.509 J1.577 E.07282
G1 X117.993 Y123.331 E.05877
G2 X118.896 Y122.676 I-.974 J-2.295 E.02333
G3 X121.471 Y121.703 I2.018 J1.444 E.06053
G1 X121.578 Y122.022 E.00698
G1 X122.116 Y122.022 E.01116
G3 X122.993 Y122.845 I-8.714 J10.165 E.02495
G2 X125.724 Y123.084 I1.514 J-1.583 E.06144
G3 X126.922 Y122.022 I11.712 J12.009 E.03321
G1 X129.399 Y122.022 E.05139
G1 X129.821 Y122.399 E.01173
G2 X132.552 Y123.335 I2.023 J-1.45 E.06388
G2 X133.918 Y122.231 I-2.484 J-4.469 E.03661
G3 X136.649 Y121.992 I1.514 J1.583 E.06144
G2 X137.921 Y123.107 I10.569 J-10.769 E.03511
G1 X139.069 Y119.784 E.07294
G3 X137.104 Y119.035 I-.324 J-2.102 E.04563
G2 X135.496 Y118.021 I-2.349 J1.944 E.0401
G1 X136.593 Y114.678 E.07299
G3 X137.559 Y115.562 I-5.882 J7.403 E.02719
G2 X140.515 Y115.599 I1.498 J-1.548 E.06758
G1 X141.039 Y114.084 E.03325
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.113 Y112.049 E.02453
G3 X137.436 Y112.049 I-1.339 J-1.641 E.06012
G1 X132.83 Y112.049 E.09554
G3 X130.153 Y112.049 I-1.339 J-1.641 E.06012
G1 X125.547 Y112.049 E.09554
G3 X122.87 Y112.049 I-1.339 J-1.641 E.06012
G1 X118.264 Y112.049 E.09554
G3 X115.587 Y112.049 I-1.339 J-1.641 E.06012
G1 X114.704 Y112.049 E.0183
G1 X114.704 Y114.084 E.04223
G1 X114.995 Y114.884 E.01765
G1 X115.255 Y115.116 E.00721
G2 X117.986 Y116.052 I2.023 J-1.45 E.06388
G2 X119.244 Y115.052 I-2.284 J-4.169 E.0335
G1 X120.23 Y117.996 E.0644
G2 X118.896 Y118.758 I.461 J2.357 E.03243
G3 X116.742 Y119.805 I-2.076 J-1.53 E.05167
G1 X116.174 Y118.206 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X116.742 Y119.805 E-.64485
G1 X117.044 Y119.775 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L47
M991 S0 P46 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6 I-.862 J.859 P1  F60000
G1 X123.325 Y126.079 Z6
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.12 F60000
G1 X119.605 Y114.987 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.12 F60000
G1 X141.28 Y114.497 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.908 Y119.758 Z6.12 F60000
G1 X131.864 Y129.054 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X131.329 Y130.664 E.0352
G2 X133.462 Y130.085 I.635 J-1.88 E.04864
G3 X135.738 Y128.869 I2.324 J1.612 E.05558
G1 X135.92 Y128.899 E.00381
G1 X136.856 Y126.188 E.0595
G2 X133.918 Y125.519 I-1.863 J1.396 E.06799
G3 X132.656 Y126.671 I-43.731 J-46.61 E.03543
G1 X133.153 Y125.178 E.03264
G1 X122.643 Y125.178 E.218
G1 X123.234 Y126.955 E.03884
G3 X122.083 Y125.973 I2.03 J-3.547 E.03158
G2 X118.907 Y125.906 I-1.619 J1.424 E.07406
G1 X118.018 Y123.4 E.05515
G2 X119.351 Y122.331 I-1.68 J-3.462 E.03575
G3 X121.447 Y121.631 I1.718 J1.655 E.04765
G1 X121.578 Y122.022 E.00856
G1 X122.249 Y122.022 E.01391
G2 X123.448 Y123.114 I18.676 J-19.303 E.03366
G2 X126.179 Y122.802 I1.185 J-1.735 E.06216
G3 X127.015 Y122.022 I3.659 J3.082 E.02376
G1 X129.532 Y122.022 E.05221
G2 X130.731 Y123.114 I18.676 J-19.303 E.03366
G2 X133.462 Y122.802 I1.185 J-1.735 E.06216
G3 X135.738 Y121.586 I2.324 J1.612 E.05558
G3 X137.104 Y122.274 I-.192 J2.081 E.03247
G2 X137.939 Y123.054 I3.66 J-3.083 E.02376
G1 X139.069 Y119.783 E.07177
G3 X137.104 Y119.16 I-.478 J-1.905 E.04502
G2 X135.494 Y118.026 I-2.769 J2.222 E.04139
G1 X136.624 Y114.583 E.07518
G2 X138.014 Y115.831 I25.93 J-27.474 E.03877
G2 X140.456 Y115.771 I1.179 J-1.719 E.05412
G1 X141.039 Y114.084 E.03701
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X140.009 Y112.049 E.0267
G3 X137.301 Y112.049 I-1.354 J-1.57 E.0612
G1 X132.726 Y112.049 E.09491
G3 X130.018 Y112.049 I-1.354 J-1.57 E.0612
G1 X125.442 Y112.049 E.09491
G3 X122.735 Y112.049 I-1.354 J-1.57 E.0612
G1 X118.159 Y112.049 E.09491
G3 X115.452 Y112.049 I-1.354 J-1.57 E.0612
G1 X114.704 Y112.049 E.0155
G1 X114.704 Y114.084 E.04223
G1 X114.934 Y114.712 E.01386
G2 X116.165 Y115.831 I20.6 J-21.409 E.03451
G2 X118.896 Y115.519 I1.185 J-1.735 E.06216
G1 X119.271 Y115.131 E.01118
G1 X120.215 Y117.952 E.0617
G2 X118.896 Y118.632 I.224 J2.053 E.03149
G3 X116.754 Y119.84 I-2.314 J-1.601 E.05279
G1 X116.187 Y118.241 E.0352
M204 S10000
G1 X120.616 Y130.721 F60000
G1 F9000
M204 S4000
G1 X120.049 Y129.122 E.0352
G3 X122.538 Y129.557 I.973 J1.774 E.0566
G2 X124.498 Y130.754 I2.348 J-1.64 E.04902
G1 X125.522 Y133.833 E.06732
G3 X122.538 Y133.727 I-1.439 J-1.539 E.06884
G2 X121.331 Y132.737 I-3.081 J2.524 E.03258
G1 X121.899 Y134.336 E.0352
M204 S10000
G1 X125.281 Y143.864 F60000
G1 F9000
M204 S4000
G1 X125.312 Y143.951 E.00191
G1 X126.916 Y143.951 E.03329
G3 X129.624 Y143.951 I1.354 J1.57 E.06118
G1 X130.718 Y143.951 E.02271
G1 X131.504 Y141.679 E.04988
G3 X129.821 Y141.01 I-.225 J-1.885 E.03915
G2 X127.545 Y139.794 I-2.324 J1.612 E.05558
G2 X126.179 Y140.481 I.192 J2.081 E.03247
G3 X124.49 Y141.636 I-2.736 J-2.189 E.04307
G1 X122.933 Y137.248 E.09657
G2 X125.724 Y137.764 I1.721 J-1.504 E.06353
G2 X126.565 Y136.969 I-4.16 J-5.243 E.02403
G1 X127.1 Y138.58 E.0352
; WIPE_START
G1 X126.565 Y136.969 E-.64486
G1 X126.345 Y137.178 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.381 Y136.247 Z6.12 F60000
G1 Z5.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X132.826 Y137.851 E.0352
G3 X130.276 Y137.311 I-.896 J-2.061 E.05768
G2 X129.397 Y136.471 I-5.278 J4.647 E.02524
G1 X130.2 Y134.057 E.05278
G2 X133.007 Y133.669 I1.176 J-1.837 E.06397
G3 X134.373 Y132.585 I3.012 J2.392 E.03648
G1 X134.662 Y132.538 E.00608
G1 X134.108 Y134.142 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X134.662 Y132.538 E-.64485
G1 X134.373 Y132.585 E-.11143
G1 X134.364 Y132.589 E-.00372
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L48
M991 S0 P47 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.12 I.618 J-1.048 P1  F60000
G1 X123.325 Y126.079 Z6.12
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.24 F60000
G1 X119.605 Y114.987 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P59 R9
G1 X128.259 Y115.926 Z6.24 F60000
G1 X141.28 Y114.497 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.825 Y119.703 Z6.24 F60000
G1 X132.153 Y128.185 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.689 Y126.575 E.0352
G3 X133.918 Y125.394 I19.804 J19.385 E.03536
G3 X136.649 Y126.075 I.914 J2.152 E.06265
G1 X136.827 Y126.272 E.00552
G1 X135.942 Y128.834 E.05622
G2 X133.918 Y129.716 I-.105 J2.523 E.04741
G3 X132.552 Y130.787 I-2.449 J-1.716 E.03653
G3 X131.331 Y130.658 I-.362 J-2.405 E.02576
G1 X131.866 Y129.048 E.0352
M204 S10000
G1 X134.131 Y134.075 F60000
G1 F9000
M204 S4000
G1 X134.685 Y132.471 E.0352
G2 X133.462 Y133.063 I.093 J1.751 E.02894
G3 X132.097 Y134.251 I-3.654 J-2.822 E.03779
G3 X130.167 Y134.156 I-.882 J-1.717 E.04197
G1 X129.43 Y136.373 E.04847
G3 X130.276 Y137.209 I-2.694 J3.574 E.02474
G2 X132.782 Y137.979 I1.828 J-1.486 E.05767
G1 X133.336 Y136.375 E.0352
M204 S10000
G1 X125.308 Y143.941 F60000
G1 F9000
M204 S4000
G1 X126.998 Y143.951 E.03505
G3 X127.545 Y143.599 I1.114 J1.129 E.0136
G3 X129.778 Y143.951 I.878 J1.689 E.05021
G1 X130.718 Y143.951 E.01951
G1 X131.494 Y141.707 E.04925
G3 X129.821 Y141.145 I-.379 J-1.643 E.03853
G2 X128.455 Y139.957 I-3.654 J2.822 E.03779
G2 X126.179 Y140.346 I-.88 J1.704 E.0514
G3 X124.492 Y141.642 I-3.232 J-2.461 E.04465
G1 X123.925 Y140.043 E.0352
M204 S10000
G1 X127.126 Y138.658 F60000
G1 F9000
M204 S4000
G1 X126.591 Y137.048 E.0352
G3 X125.269 Y138.071 I-2.365 J-1.691 E.03517
G3 X122.871 Y137.073 I-.331 J-2.587 E.0564
G1 X121.346 Y132.776 E.09457
G3 X122.538 Y133.862 I-2.509 J3.952 E.03361
G2 X124.814 Y134.251 I1.396 J-1.315 E.0514
G2 X125.501 Y133.771 I-.801 J-1.879 E.01752
G1 X124.507 Y130.783 E.06531
G3 X122.993 Y129.926 I.438 J-2.54 E.03682
G2 X121.627 Y128.854 I-2.449 J1.715 E.03653
G2 X120.059 Y129.152 I-.403 J2.156 E.03388
G1 X120.627 Y130.751 E.0352
M204 S10000
G1 X122.739 Y125.467 F60000
G1 F9000
M204 S4000
G1 X123.275 Y127.077 E.0352
G3 X122.538 Y126.579 I.372 J-1.345 E.01878
G2 X121.172 Y125.391 I-3.655 J2.822 E.03779
G2 X118.872 Y125.807 I-.881 J1.697 E.05217
G1 X118.046 Y123.48 E.05121
G2 X119.351 Y122.433 I-1.145 J-2.764 E.03518
G3 X121.422 Y121.555 I1.915 J1.634 E.04836
G1 X121.578 Y122.022 E.01022
G1 X122.401 Y122.022 E.01706
G3 X122.993 Y122.642 I-2.018 J2.52 E.01784
G2 X125.724 Y123.323 I1.817 J-1.472 E.06265
G2 X127.085 Y122.022 I-27.901 J-30.549 E.03906
G1 X129.684 Y122.022 E.0539
G3 X130.276 Y122.642 I-2.018 J2.52 E.01784
G2 X132.552 Y123.504 I1.927 J-1.651 E.05265
G2 X133.918 Y122.433 I-1.083 J-2.787 E.03653
G3 X136.649 Y121.752 I1.817 J1.472 E.06265
G3 X137.956 Y123.005 I-23.799 J26.158 E.03756
G1 X139.067 Y119.79 E.07055
G3 X137.104 Y119.296 I-.609 J-1.729 E.04449
G2 X135.494 Y118.026 I-3.285 J2.509 E.04298
G1 X136.658 Y114.477 E.07746
G1 X137.104 Y114.855 E.01212
G2 X138.47 Y116.043 I3.654 J-2.822 E.03779
G2 X140.393 Y115.953 I.883 J-1.722 E.0418
G1 X141.039 Y114.084 E.04101
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X139.928 Y112.049 E.02838
G3 X139.38 Y112.401 I-1.115 J-1.129 E.01361
G3 X137.147 Y112.049 I-.878 J-1.689 E.05021
G1 X132.644 Y112.049 E.09339
G3 X132.097 Y112.401 I-1.115 J-1.13 E.01361
G3 X129.864 Y112.049 I-.878 J-1.689 E.05021
G1 X125.361 Y112.049 E.09339
G3 X124.814 Y112.401 I-1.115 J-1.129 E.01361
G3 X122.58 Y112.049 I-.878 J-1.689 E.05021
G1 X118.078 Y112.049 E.09339
G3 X117.531 Y112.401 I-1.115 J-1.13 E.01361
G3 X115.297 Y112.049 I-.878 J-1.689 E.05021
G1 X114.704 Y112.049 E.0123
G1 X114.704 Y114.084 E.04223
G1 X114.869 Y114.529 E.00983
G3 X115.71 Y115.359 I-2.679 J3.551 E.02459
G2 X117.986 Y116.221 I1.927 J-1.652 E.05265
G2 X119.297 Y115.21 I-1.033 J-2.696 E.03484
G1 X120.197 Y117.898 E.0588
G1 X119.807 Y117.93 E.00813
G2 X118.441 Y119.001 I1.083 J2.787 E.03653
G3 X116.768 Y119.879 I-1.949 J-1.68 E.04013
G1 X116.201 Y118.28 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X116.768 Y119.879 E-.64485
G1 X117.062 Y119.804 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L49
M991 S0 P48 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.24 I-.861 J.86 P1  F60000
G1 X123.325 Y126.079 Z6.24
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.36 F60000
G1 X119.605 Y114.987 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.36 F60000
G1 X141.28 Y114.497 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.514 Y118.594 Z6.36 F60000
G1 X129.528 Y125.178 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.831 Y125.178 E.0352
G2 X126.88 Y125.178 I-.475 J1.761 E.01995
G1 X122.643 Y125.178 E.08789
G1 X123.317 Y127.205 E.04431
G3 X122.538 Y126.731 I.186 J-1.183 E.01942
G1 X121.627 Y125.713 E.02833
G2 X119.351 Y125.253 I-1.534 J1.733 E.05045
G2 X118.833 Y125.698 I1.19 J1.91 E.01422
G1 X118.08 Y123.575 E.04674
G2 X118.896 Y123.089 I-.181 J-1.233 E.02021
G1 X119.807 Y122.071 E.02833
G3 X121.394 Y121.474 I1.613 J1.877 E.03592
G1 X121.578 Y122.022 E.01199
G1 X122.569 Y122.022 E.02057
G1 X123.448 Y123.004 E.02734
G2 X125.724 Y123.464 I1.534 J-1.733 E.05045
G2 X127.162 Y122.022 I-15.924 J-17.317 E.04224
G1 X129.853 Y122.022 E.05582
G1 X130.731 Y123.004 E.02734
G2 X133.007 Y123.464 I1.534 J-1.733 E.05045
G2 X134.373 Y122.071 I-3.854 J-5.145 E.04061
G3 X136.649 Y121.612 I1.534 J1.733 E.05045
G3 X137.973 Y122.958 I-3.723 J4.986 E.03931
G1 X139.062 Y119.805 E.06919
M73 P60 R9
G3 X137.104 Y119.447 I-.724 J-1.577 E.04397
G1 X136.194 Y118.43 E.02833
G2 X135.496 Y118.019 I-1.334 J1.469 E.0169
G1 X136.695 Y114.367 E.07974
G3 X138.014 Y115.721 I-3.754 J4.976 E.03938
G2 X140.29 Y116.181 I1.534 J-1.733 E.05045
G1 X141.039 Y114.084 E.04617
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X139.863 Y112.049 E.02972
G3 X137.559 Y112.539 I-1.567 J-1.706 E.05125
G3 X137.001 Y112.049 I1.318 J-2.065 E.01548
G1 X132.58 Y112.049 E.0917
G3 X130.276 Y112.539 I-1.567 J-1.706 E.05125
G3 X129.717 Y112.049 I1.318 J-2.065 E.01548
G1 X125.297 Y112.049 E.0917
G3 X122.993 Y112.539 I-1.567 J-1.706 E.05125
G3 X122.434 Y112.049 I1.318 J-2.065 E.01548
G1 X118.014 Y112.049 E.0917
G3 X115.71 Y112.539 I-1.567 J-1.706 E.05125
G3 X115.151 Y112.049 I1.318 J-2.065 E.01548
G1 X114.704 Y112.049 E.00927
G1 X114.704 Y114.084 E.04223
G1 X114.799 Y114.329 E.00544
G3 X116.165 Y115.721 I-3.854 J5.145 E.04061
G2 X118.441 Y116.181 I1.534 J-1.733 E.05045
G2 X119.333 Y115.317 I-2.366 J-3.338 E.02585
G1 X120.175 Y117.833 E.05503
G2 X118.896 Y118.345 I-.129 J1.531 E.02964
G1 X117.986 Y119.363 E.02833
G3 X116.784 Y119.924 I-1.736 J-2.152 E.02778
G1 X116.216 Y118.324 E.0352
M204 S10000
G1 X120.635 Y130.775 F60000
G1 F9000
M204 S4000
G1 X120.068 Y129.176 E.0352
G3 X122.083 Y128.895 I1.28 J1.814 E.04383
G3 X123.448 Y130.288 I-3.854 J5.145 E.04061
G2 X124.52 Y130.821 I1.755 J-2.184 E.02503
G1 X125.477 Y133.697 E.06287
G3 X122.993 Y134.388 I-1.743 J-1.454 E.05687
G3 X121.627 Y132.996 I3.854 J-5.145 E.04061
G1 X121.358 Y132.813 E.00675
G1 X122.783 Y136.827 E.08837
G1 X123.448 Y137.571 E.02068
G2 X125.724 Y138.03 I1.534 J-1.733 E.05045
G2 X126.627 Y137.155 I-2.399 J-3.378 E.02618
G1 X127.179 Y138.742 E.03486
M204 S10000
G1 X123.929 Y140.055 F60000
G1 F9000
M204 S4000
G1 X124.496 Y141.654 E.0352
G2 X125.269 Y141.212 I-.674 J-2.076 E.01859
G3 X126.634 Y139.82 I5.219 J3.752 E.04061
G3 X128.91 Y140.279 I.742 J2.192 E.05045
G2 X130.276 Y141.672 I5.22 J-3.753 E.04061
G2 X131.481 Y141.745 I.713 J-1.767 E.02547
G1 X130.718 Y143.951 E.04841
G1 X130.006 Y143.951 E.01477
G3 X129.366 Y143.461 I1.524 J-2.656 E.01678
G2 X127.09 Y143.921 I-.742 J2.192 E.05045
G1 X125.335 Y143.951 E.03641
M204 S10000
G1 X133.29 Y136.509 F60000
G1 F9000
M204 S4000
G1 X132.736 Y138.113 E.0352
G3 X130.731 Y137.571 I-.446 J-2.327 E.04459
G2 X129.467 Y136.262 I-4.897 J3.464 E.0379
G1 X130.13 Y134.268 E.04357
G2 X132.097 Y134.239 I.96 J-1.621 E.04293
G1 X132.552 Y133.929 E.01143
G3 X133.918 Y132.537 I5.22 J3.753 E.04061
G3 X134.71 Y132.399 I.614 J1.19 E.01694
G1 X134.156 Y134.003 E.0352
M204 S10000
G1 X131.866 Y129.047 F60000
G1 F9000
M204 S4000
G1 X131.331 Y130.658 E.0352
G2 X133.007 Y130.747 I.938 J-1.824 E.03588
G2 X134.373 Y129.354 I-3.854 J-5.145 E.04061
G3 X135.969 Y128.757 I1.613 J1.877 E.03608
G1 X136.79 Y126.38 E.05217
G1 X136.194 Y125.713 E.01856
G2 X133.918 Y125.253 I-1.534 J1.733 E.05045
G2 X132.732 Y126.445 I3.29 J4.46 E.03501
G1 X132.196 Y128.056 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.732 Y126.445 E-.64486
G1 X132.934 Y126.219 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L50
M991 S0 P49 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.36 I.018 J-1.217 P1  F60000
G1 X123.325 Y126.079 Z6.36
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.48 F60000
G1 X119.605 Y114.987 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.48 F60000
G1 X141.28 Y114.497 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
M73 P60 R8
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.544 Y118.626 Z6.48 F60000
G1 X129.672 Y125.178 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.975 Y125.178 E.0352
G1 X127.09 Y125.002 E.01873
G1 X126.634 Y125.091 E.00962
G1 X126.523 Y125.178 E.00293
G1 X122.643 Y125.178 E.08048
G1 X123.362 Y127.34 E.04726
G1 X122.993 Y127.268 E.0078
G1 X122.538 Y126.91 E.01201
G1 X121.627 Y125.763 E.03038
G2 X119.807 Y125.002 I-1.957 J2.123 E.04177
G2 X118.792 Y125.58 I.099 J1.354 E.02504
G1 X118.12 Y123.689 E.04163
G1 X118.441 Y123.627 E.00678
G1 X118.896 Y123.269 E.01201
G1 X119.807 Y122.121 E.03038
G3 X121.373 Y121.411 I1.811 J1.91 E.03635
G1 X121.578 Y122.022 E.01337
G1 X122.709 Y122.022 E.02345
G1 X123.448 Y122.954 E.02468
G2 X125.269 Y123.715 I1.956 J-2.123 E.04177
G2 X126.179 Y123.269 I.021 J-1.11 E.02184
G1 X127.217 Y122.022 E.03365
G1 X129.992 Y122.022 E.05756
G1 X130.731 Y122.954 E.02468
G2 X132.552 Y123.715 I1.956 J-2.123 E.04177
G2 X133.462 Y123.269 I.021 J-1.11 E.02184
G1 X134.373 Y122.121 E.03038
G3 X136.194 Y121.361 I1.957 J2.123 E.04177
G3 X137.104 Y121.807 I.021 J1.11 E.02184
G1 X137.986 Y122.918 E.02944
G1 X139.054 Y119.829 E.0678
G1 X138.014 Y120.073 E.02214
G3 X137.104 Y119.627 I-.021 J-1.11 E.02184
G1 X136.194 Y118.48 E.03038
G2 X135.5 Y118.007 I-1.487 J1.435 E.01753
G1 X136.738 Y114.236 E.08232
G1 X137.104 Y114.524 E.00966
G1 X138.014 Y115.671 E.03038
G2 X139.835 Y116.432 I1.956 J-2.123 E.04177
G1 X140.256 Y116.35 E.00889
G1 X141.039 Y114.084 E.04972
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.049 E.04223
G1 X139.811 Y112.049 E.03081
G3 X138.014 Y112.79 I-1.925 J-2.118 E.04112
G3 X136.87 Y112.049 I.206 J-1.572 E.02925
G1 X132.527 Y112.049 E.09007
G3 X130.731 Y112.79 I-1.925 J-2.118 E.04112
G3 X129.586 Y112.049 I.206 J-1.572 E.02925
G1 X125.244 Y112.049 E.09007
G3 X123.448 Y112.79 I-1.925 J-2.118 E.04112
G3 X122.303 Y112.049 I.206 J-1.572 E.02925
G1 X117.961 Y112.049 E.09007
G3 X116.165 Y112.79 I-1.925 J-2.118 E.04112
G3 X115.02 Y112.049 I.206 J-1.572 E.02925
G1 X114.704 Y112.049 E.00655
G1 X114.712 Y114.084 E.04223
G2 X114.799 Y114.166 I.068 J.015 E.00299
G1 X115.255 Y114.524 E.01201
G1 X116.165 Y115.671 E.03038
G2 X117.986 Y116.432 I1.956 J-2.123 E.04177
G1 X118.441 Y116.343 E.00962
G2 X119.361 Y115.4 I-1.518 J-2.4 E.02758
G1 X120.161 Y117.789 E.05226
G2 X118.896 Y118.165 I-.344 J1.16 E.02894
G1 X117.986 Y119.313 E.03038
G3 X116.793 Y119.949 I-1.695 J-1.741 E.02842
G1 X116.225 Y118.35 E.0352
M204 S10000
G1 X119.507 Y127.596 F60000
G1 F9000
M204 S4000
G1 X120.075 Y129.195 E.0352
G3 X121.627 Y128.644 I1.651 J2.187 E.03472
G3 X122.538 Y129.09 I.021 J1.11 E.02184
G1 X123.448 Y130.237 E.03038
G2 X124.53 Y130.852 I1.748 J-1.818 E.02608
G1 X125.458 Y133.641 E.06097
G3 X124.359 Y134.459 I-2.139 J-1.726 E.02873
G1 X123.448 Y134.64 E.01925
G3 X122.538 Y134.194 I-.021 J-1.11 E.02184
G1 X121.627 Y133.046 E.03038
G1 X121.37 Y132.845 E.00677
G1 X120.802 Y131.246 E.0352
M204 S10000
G1 X122.123 Y134.966 F60000
G1 F9000
M204 S4000
G1 X122.69 Y136.565 E.0352
G1 X123.448 Y137.52 E.02529
G2 X125.269 Y138.281 I1.956 J-2.123 E.04177
G1 X125.724 Y138.193 E.00962
G2 X126.654 Y137.237 I-1.539 J-2.427 E.02791
G1 X127.155 Y138.742 E.03291
G1 X127.265 Y138.742 E.00229
M204 S10000
G1 X123.935 Y140.072 F60000
G1 F9000
M204 S4000
G1 X124.502 Y141.671 E.0352
G2 X125.269 Y141.162 I-.844 J-2.103 E.01922
G1 X126.179 Y140.014 E.03038
G3 X127.09 Y139.568 I.89 J.664 E.02184
G3 X128.91 Y140.329 I-.136 J2.884 E.04177
G1 X129.821 Y141.477 E.03038
G2 X130.731 Y141.923 I.89 J-.664 E.02184
G1 X131.47 Y141.776 E.01562
G1 X130.718 Y143.951 E.04773
G1 X130.181 Y143.951 E.01115
G2 X129.366 Y143.298 I-16.053 J19.21 E.02167
G1 X128.91 Y143.21 E.00962
G2 X127.115 Y143.951 I.129 J2.859 E.04112
G1 X125.418 Y143.951 E.0352
M204 S10000
G1 X133.241 Y136.651 F60000
G1 F9000
M204 S4000
G1 X132.687 Y138.255 E.0352
G1 X132.552 Y138.281 E.00284
G3 X130.731 Y137.52 I.136 J-2.884 E.04177
G1 X129.821 Y136.373 E.03038
G1 X129.511 Y136.129 E.00817
G1 X130.086 Y134.402 E.03777
G2 X130.731 Y134.64 I.555 J-.51 E.01482
G2 X132.552 Y133.879 I-.136 J-2.884 E.04177
G1 X133.462 Y132.731 E.03038
G3 X134.725 Y132.355 I.921 J.784 E.02891
G1 X134.171 Y133.959 E.0352
M204 S10000
G1 X131.864 Y129.053 F60000
G1 F9000
M204 S4000
G1 X131.329 Y130.663 E.0352
G1 X131.642 Y130.817 E.00723
G1 X132.552 Y130.998 E.01925
G2 X133.462 Y130.552 I.021 J-1.11 E.02184
G1 X134.373 Y129.405 E.03038
G3 X135.994 Y128.683 I1.84 J1.953 E.03751
G1 X136.758 Y126.474 E.04849
G2 X134.373 Y125.002 I-2.526 J1.425 E.06066
G2 X133.462 Y125.448 I-.021 J1.11 E.02184
G1 X132.775 Y126.315 E.02294
G1 X132.24 Y127.925 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.775 Y126.315 E-.64486
G1 X132.963 Y126.077 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L51
M991 S0 P50 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.48 I0 J-1.217 P1  F60000
G1 X123.325 Y126.079 Z6.48
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.6 F60000
G1 X119.605 Y114.987 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P61 R8
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.6 F60000
G1 X141.28 Y114.497 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.339 Y118.402 Z6.6 F60000
G1 X134.977 Y119.601 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.506 Y117.989 E.0352
G3 X136.194 Y118.528 I-.946 J1.914 E.01825
G1 X137.104 Y119.86 E.03347
G1 X137.559 Y120.181 E.01155
G1 X138.014 Y120.2 E.00945
G1 X139.041 Y119.865 E.0224
G1 X137.998 Y122.883 E.06623
G1 X137.104 Y121.574 E.03288
G1 X136.649 Y121.253 E.01155
G2 X134.373 Y122.169 I-.2 J2.789 E.05268
G1 X133.462 Y123.502 E.03347
G1 X133.007 Y123.823 E.01155
G3 X130.731 Y122.906 I-.2 J-2.789 E.05268
G1 X130.127 Y122.022 E.02221
G1 X127.255 Y122.022 E.05958
G1 X127.09 Y122.169 E.00459
G1 X126.179 Y123.502 E.03347
G1 X125.724 Y123.823 E.01155
G3 X123.448 Y122.906 I-.2 J-2.789 E.05268
G1 X122.844 Y122.022 E.02221
G1 X121.578 Y122.022 E.02626
G1 X121.342 Y121.318 E.0154
G2 X119.807 Y122.169 I.55 J2.804 E.03702
G1 X118.896 Y123.502 E.03347
G1 X118.441 Y123.823 E.01155
G1 X118.172 Y123.834 E.00559
G1 X118.742 Y125.441 E.03538
G3 X119.351 Y124.895 I1.036 J.543 E.01734
G3 X121.627 Y125.811 I.2 J2.789 E.05268
G1 X122.538 Y127.143 E.03347
G1 X122.993 Y127.464 E.01155
G1 X123.409 Y127.481 E.00864
G1 X122.643 Y125.178 E.05035
G1 X126.233 Y125.178 E.07445
G3 X127.09 Y124.876 I.662 J.513 E.01992
G1 X128.06 Y125.178 E.02107
G1 X129.757 Y125.178 E.0352
; WIPE_START
G1 X128.06 Y125.178 E-.64486
G1 X127.77 Y125.088 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.3 Y127.744 Z6.6 F60000
G1 Z6.2
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X132.835 Y126.133 E.0352
G1 X133.462 Y125.216 E.02306
G1 X133.918 Y124.895 E.01155
G1 X134.373 Y124.876 E.00945
G3 X136.72 Y126.582 I-.398 J3.017 E.06274
G1 X136.035 Y128.564 E.04351
G2 X134.373 Y129.452 I.505 J2.945 E.03978
G1 X133.462 Y130.785 E.03347
G1 X133.007 Y131.106 E.01155
G1 X132.552 Y131.124 E.00945
G1 X131.642 Y130.857 E.01968
G1 X131.325 Y130.675 E.00757
G1 X131.861 Y129.064 E.0352
M204 S10000
G1 X134.2 Y133.875 F60000
G1 F9000
M204 S4000
G1 X134.754 Y132.271 E.0352
G2 X133.918 Y132.178 I-.556 J1.187 E.01778
G1 X133.462 Y132.499 E.01155
G1 X132.552 Y133.831 E.03347
G3 X130.731 Y134.766 I-2.28 J-2.2 E.04323
G3 X130.029 Y134.573 I-.202 J-.641 E.01597
G1 X129.567 Y135.961 E.03035
G1 X129.821 Y136.14 E.00644
G1 X130.731 Y137.473 E.03347
G2 X132.552 Y138.407 I2.28 J-2.2 E.04323
G1 X132.635 Y138.404 E.00173
G1 X133.189 Y136.8 E.0352
M204 S10000
G1 X125.468 Y143.951 F60000
G1 F9000
M204 S4000
G1 X127.165 Y143.951 E.0352
G3 X128.91 Y143.084 I2.178 J2.193 E.04113
G1 X129.366 Y143.102 E.00945
G3 X130.312 Y143.951 I-1.541 J2.669 E.02655
G1 X130.718 Y143.951 E.00844
G1 X131.449 Y141.838 E.04638
G3 X130.276 Y142.03 I-.87 J-1.632 E.02509
G1 X129.821 Y141.709 E.01155
G1 X128.91 Y140.377 E.03347
G2 X127.09 Y139.442 I-2.28 J2.2 E.04323
G1 X126.634 Y139.461 E.00945
G1 X126.179 Y139.782 E.01155
G1 X125.269 Y141.114 E.03347
G3 X124.511 Y141.694 I-1.766 J-1.525 E.01994
G1 X123.943 Y140.095 E.0352
M204 S10000
G1 X127.362 Y138.742 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.0043
G1 X126.684 Y137.329 E.0309
G1 X126.179 Y138.068 E.01857
G1 X125.724 Y138.389 E.01155
G1 X125.269 Y138.407 E.00945
G3 X123.448 Y137.473 I.459 J-3.135 E.04323
G1 X122.541 Y136.145 E.03334
G1 X121.974 Y134.546 E.0352
M204 S10000
G1 X120.813 Y131.274 F60000
G1 F9000
M204 S4000
G1 X121.38 Y132.874 E.0352
G1 X121.627 Y133.094 E.00687
G1 X122.538 Y134.426 E.03347
G1 X122.993 Y134.747 E.01155
G2 X125.439 Y133.583 I.182 J-2.769 E.0587
G1 X124.551 Y130.913 E.05836
G3 X123.448 Y130.189 I.889 J-2.557 E.02763
G1 X122.538 Y128.857 E.03347
G1 X122.083 Y128.536 E.01155
G1 X121.627 Y128.518 E.00945
G2 X120.08 Y129.209 I.411 J2.997 E.03564
G1 X119.512 Y127.61 E.0352
M204 S10000
G1 X116.247 Y118.409 F60000
G1 F9000
M204 S4000
G1 X116.814 Y120.009 E.0352
G2 X117.986 Y119.265 I-.79 J-2.538 E.02912
G1 X118.896 Y117.932 E.03347
G1 X119.351 Y117.611 E.01155
G3 X120.127 Y117.687 I.276 J1.18 E.01645
G1 X119.392 Y115.493 E.04799
G1 X118.896 Y116.218 E.01823
G1 X118.441 Y116.539 E.01155
G1 X117.986 Y116.558 E.00945
G3 X116.165 Y115.623 I.459 J-3.135 E.04323
G1 X115.255 Y114.291 E.03347
G1 X114.799 Y113.97 E.01155
G1 X114.704 Y113.966 E.00198
G1 X114.704 Y112.049 E.03977
G1 X114.894 Y112.049 E.00393
G2 X115.71 Y112.898 I1.545 J-.669 E.02496
G1 X116.165 Y112.916 E.00945
G2 X117.911 Y112.049 I-.433 J-3.061 E.04114
G1 X122.177 Y112.049 E.08849
G2 X122.993 Y112.898 I1.545 J-.669 E.02496
G1 X123.448 Y112.916 E.00945
G2 X125.194 Y112.049 I-.433 J-3.061 E.04114
G1 X129.46 Y112.049 E.08849
G2 X130.276 Y112.898 I1.545 J-.669 E.02496
G1 X130.731 Y112.916 E.00945
G2 X132.477 Y112.049 I-.433 J-3.061 E.04114
G1 X136.743 Y112.049 E.08849
G2 X137.559 Y112.898 I1.545 J-.669 E.02496
G1 X138.014 Y112.916 E.00945
G2 X139.76 Y112.049 I-.433 J-3.061 E.04114
G1 X141.296 Y112.049 E.03186
G1 X141.296 Y114.084 E.04223
G1 X141.039 Y114.084 E.00534
G1 X140.189 Y116.544 E.05397
G1 X139.835 Y116.558 E.00734
G3 X138.014 Y115.623 I.459 J-3.135 E.04323
G1 X137.104 Y114.291 E.03347
G1 X136.649 Y113.97 E.01155
G2 X135.741 Y114.084 I-.285 J1.396 E.01933
G1 X129.528 Y114.084 E.12886
G1 X129.366 Y113.97 E.00412
G2 X128.457 Y114.084 I-.285 J1.396 E.01933
G1 X122.245 Y114.084 E.12886
G1 X122.083 Y113.97 E.00412
G2 X121.174 Y114.084 I-.285 J1.396 E.01933
G1 X119.477 Y114.084 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X121.174 Y114.084 E-.64486
G1 X121.465 Y113.999 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L52
M991 S0 P51 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.6 I-1.203 J.185 P1  F60000
G1 X123.325 Y126.079 Z6.6
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.72 F60000
G1 X119.605 Y114.987 Z6.72
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.72 F60000
G1 X141.28 Y114.497 Z6.72
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P62 R8
G1 X136.332 Y118.394 Z6.72 F60000
G1 X134.985 Y119.577 Z6.72
G1 Z6.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.514 Y117.965 E.0352
G1 X135.738 Y118.112 E.00557
G3 X137.104 Y120.23 I-4.672 J4.512 E.0526
G1 X137.559 Y120.431 E.01033
G2 X138.925 Y119.98 I-.492 J-3.776 E.03002
G1 X139.024 Y119.914 E.00247
G1 X138.009 Y122.852 E.06447
G3 X137.104 Y121.204 I9.788 J-6.449 E.03903
G1 X136.649 Y121.003 E.01033
G2 X134.828 Y121.754 I.959 J4.907 E.04112
G2 X133.462 Y123.871 I4.672 J4.512 E.0526
G1 X133.007 Y124.073 E.01033
G3 X130.231 Y122.022 I.368 J-3.402 E.07503
G1 X127.28 Y122.022 E.06122
G2 X126.179 Y123.871 I5.784 J4.695 E.04479
G1 X125.724 Y124.073 E.01033
G3 X122.948 Y122.022 I.368 J-3.402 E.07503
G1 X121.578 Y122.022 E.02842
G1 X121.309 Y121.218 E.01759
G2 X120.262 Y121.754 I.791 J2.835 E.02456
G2 X118.896 Y123.871 I4.672 J4.512 E.0526
G1 X118.441 Y124.073 E.01033
G1 X118.243 Y124.035 E.00418
G1 X118.682 Y125.272 E.02723
G1 X118.896 Y124.846 E.00989
G1 X119.351 Y124.644 E.01033
G3 X121.172 Y125.395 I-.959 J4.908 E.04112
G3 X122.538 Y127.513 I-4.672 J4.512 E.0526
G2 X123.457 Y127.623 I.559 J-.776 E.02004
G1 X122.643 Y125.178 E.05346
G1 X126.013 Y125.178 E.06989
G1 X126.179 Y124.846 E.0077
G1 X126.634 Y124.644 E.01033
G3 X128 Y125.096 I-.492 J3.776 E.03002
G1 X128.125 Y125.178 E.0031
G1 X129.822 Y125.178 E.0352
; WIPE_START
G1 X128.125 Y125.178 E-.64486
G1 X128 Y125.096 E-.05671
G1 X127.857 Y125.039 E-.05843
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.372 Y127.528 Z6.72 F60000
G1 Z6.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X132.907 Y125.917 E.0352
G2 X133.462 Y124.846 I-6.382 J-3.987 E.02506
G3 X134.373 Y124.732 I.537 J.598 E.02025
G3 X136.686 Y126.681 I-.808 J3.306 E.06501
G1 X136.086 Y128.416 E.03809
G2 X133.918 Y130.248 I.786 J3.131 E.06096
G1 X133.462 Y131.154 E.02104
G3 X132.552 Y131.268 I-.537 J-.598 E.02025
G3 X131.319 Y130.692 I.796 J-3.311 E.02842
G1 X131.855 Y129.082 E.0352
M204 S10000
G1 X134.232 Y133.784 F60000
G1 F9000
M204 S4000
G1 X134.786 Y132.18 E.0352
G1 X134.373 Y132.015 E.00923
G2 X133.462 Y132.129 I-.373 J.712 E.02025
G1 X133.007 Y133.036 E.02104
G3 X130.731 Y134.91 I-3.052 J-1.387 E.06332
G3 X129.937 Y134.847 I-.352 J-.602 E.01758
G1 X129.655 Y135.697 E.01857
G1 X129.821 Y135.771 E.00377
G1 X130.276 Y136.677 E.02104
G2 X132.552 Y138.551 I3.052 J-1.387 E.06332
G1 X133.136 Y136.953 E.0353
M204 S10000
G1 X125.504 Y143.951 F60000
G1 F9000
M204 S4000
G1 X127.201 Y143.951 E.0352
G3 X128.91 Y142.94 I2.532 J2.328 E.04179
G3 X129.821 Y143.054 I.373 J.712 E.02025
G1 X130.272 Y143.951 E.02083
G1 X130.718 Y143.951 E.00927
G1 X131.421 Y141.917 E.04464
G1 X130.731 Y142.193 E.01541
G3 X129.821 Y142.079 I-.373 J-.712 E.02025
G1 X129.366 Y141.172 E.02104
G2 X127.09 Y139.298 I-3.052 J1.387 E.06332
G2 X126.179 Y139.412 I-.373 J.712 E.02025
G1 X125.724 Y140.319 E.02104
G3 X124.521 Y141.722 I-3.044 J-1.392 E.03886
G1 X123.953 Y140.123 E.0352
M204 S10000
G1 X127.443 Y138.742 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.00599
G1 X126.71 Y137.406 E.02921
G2 X126.179 Y138.437 I6.146 J3.817 E.02408
G3 X125.269 Y138.551 I-.537 J-.598 E.02025
G3 X122.993 Y136.677 I.776 J-3.262 E.06332
G1 X122.538 Y135.771 E.02104
G1 X122.384 Y135.703 E.00349
G1 X121.832 Y134.146 E.03425
M204 S10000
G1 X120.821 Y131.298 F60000
G1 F9000
M204 S4000
G1 X121.389 Y132.898 E.0352
G3 X122.538 Y134.796 I-5.39 J4.56 E.04622
G1 X122.993 Y134.998 E.01033
G2 X125.422 Y133.533 I-.431 J-3.462 E.06059
G1 X124.577 Y130.992 E.05556
G3 X123.903 Y130.605 I.611 J-1.845 E.01622
G3 X122.538 Y128.488 I4.672 J-4.512 E.0526
G1 X122.083 Y128.286 E.01033
G2 X120.083 Y129.218 I.455 J3.587 E.04651
G1 X119.515 Y127.619 E.0352
M204 S10000
G1 X116.27 Y118.475 F60000
G1 F9000
M204 S4000
G1 X116.838 Y120.075 E.0352
G2 X118.441 Y118.469 I-1.18 J-2.782 E.04824
G1 X118.896 Y117.563 E.02104
G3 X119.807 Y117.449 I.537 J.598 E.02025
G1 X120.084 Y117.56 E.0062
G1 X119.418 Y115.571 E.04349
G2 X118.896 Y116.588 I6.057 J3.752 E.02373
G3 X117.986 Y116.702 I-.537 J-.598 E.02025
G3 X115.71 Y114.828 I.776 J-3.262 E.06332
G1 X115.255 Y113.921 E.02104
G1 X114.799 Y113.719 E.01033
G1 X114.704 Y113.738 E.00201
G1 X114.704 Y112.049 E.03504
G1 X114.804 Y112.049 E.00207
G1 X115.255 Y112.946 E.02084
G2 X116.165 Y113.061 I.537 J-.598 E.02025
G2 X117.875 Y112.049 I-.823 J-3.34 E.0418
G1 X122.087 Y112.049 E.08738
G1 X122.538 Y112.946 E.02084
G2 X123.448 Y113.061 I.537 J-.598 E.02026
G2 X125.158 Y112.049 I-.823 J-3.34 E.0418
G1 X129.37 Y112.049 E.08737
G1 X129.821 Y112.946 E.02084
G2 X130.731 Y113.061 I.537 J-.598 E.02025
G2 X132.441 Y112.049 I-.823 J-3.34 E.0418
G1 X136.653 Y112.049 E.08738
G1 X137.104 Y112.946 E.02084
G2 X138.014 Y113.061 I.537 J-.598 E.02025
G2 X139.724 Y112.049 I-.823 J-3.34 E.0418
G1 X141.296 Y112.049 E.0326
G1 X141.296 Y114.084 E.04223
G1 X141.039 Y114.084 E.00534
G1 X140.115 Y116.756 E.05863
G3 X137.559 Y114.828 I.514 J-3.34 E.06919
G1 X137.104 Y113.921 E.02104
G2 X136.194 Y113.807 I-.537 J.598 E.02025
G1 X135.5 Y114.084 E.01549
G1 X129.903 Y114.084 E.1161
G1 X129.821 Y113.921 E.00379
G2 X128.91 Y113.807 I-.537 J.598 E.02025
G1 X128.217 Y114.084 E.01549
G1 X122.62 Y114.084 E.1161
G1 X122.538 Y113.921 E.00379
G2 X121.627 Y113.807 I-.537 J.598 E.02025
G1 X120.934 Y114.084 E.01549
G1 X119.237 Y114.084 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.934 Y114.084 E-.64486
G1 X121.215 Y113.972 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L53
M991 S0 P52 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.72 I-1.199 J.209 P1  F60000
G1 X123.325 Y126.079 Z6.72
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.84 F60000
G1 X119.605 Y114.987 Z6.84
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.84 F60000
G1 X141.28 Y114.497 Z6.84
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.537 Y112.115 Z6.84 F60000
G1 X134.134 Y112.049 Z6.84
G1 Z6.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.424 Y112.068 E.03546
G3 X130.369 Y113.434 I-4.588 J-4.676 E.05149
G1 X130.141 Y113.889 E.01056
G1 X130.172 Y114.084 E.0041
G1 X128.089 Y114.084 E.0432
G3 X129.273 Y113.434 I4.958 J7.617 E.02804
G1 X129.501 Y112.979 E.01056
G2 X129.246 Y112.049 I-2.284 J.127 E.02015
G1 X125.141 Y112.068 E.08514
G3 X123.086 Y113.434 I-4.588 J-4.676 E.05149
G1 X122.858 Y113.889 E.01056
G1 X122.889 Y114.084 E.0041
G1 X120.806 Y114.084 E.0432
G3 X121.989 Y113.434 I4.958 J7.617 E.02804
G1 X122.218 Y112.979 E.01056
G2 X121.962 Y112.049 I-2.283 J.127 E.02015
G1 X120.265 Y112.049 E.0352
M204 S10000
G1 X118.925 Y114.1 F60000
G1 F9000
M204 S4000
G1 X119.464 Y115.709 E.0352
G2 X119.216 Y116.62 I1.989 J1.031 E.01974
G1 X119.444 Y117.075 E.01056
G1 X120.023 Y117.378 E.01355
G1 X120.562 Y118.988 E.0352
M204 S10000
G1 X115.059 Y115.065 F60000
G1 F9000
M204 S4000
G1 X114.704 Y114.084 E.02162
G1 X114.704 Y113.435 E.01347
G1 X114.935 Y112.979 E.0106
G2 X114.704 Y112.049 I-7.7 J1.414 E.01989
G1 X117.858 Y112.068 E.06542
G3 X115.803 Y113.434 I-4.588 J-4.676 E.05149
G1 X115.575 Y113.889 E.01056
G2 X116.293 Y115.71 I4.6 J-.762 E.0409
G2 X118.348 Y117.075 I4.588 J-4.676 E.05149
G1 X118.576 Y117.531 E.01056
G3 X116.862 Y120.144 I-3.259 J-.269 E.06758
G1 X118.383 Y124.428 E.09429
G1 X118.576 Y124.814 E.00896
G1 X118.559 Y124.924 E.00232
G1 X119.126 Y126.523 E.0352
M204 S10000
G1 X122.973 Y126.169 F60000
G1 F9000
M204 S4000
G1 X123.508 Y127.779 E.0352
G1 X123.086 Y128 E.00989
G1 X122.858 Y128.455 E.01056
G2 X124.61 Y131.092 I3.272 J-.274 E.06853
G1 X125.411 Y133.5 E.05264
G3 X123.955 Y134.828 I-2.912 J-1.731 E.04147
G1 X123.086 Y135.283 E.02036
G1 X122.858 Y135.738 E.01056
G2 X124.762 Y138.47 I3.337 J-.297 E.07227
G1 X125.631 Y138.925 E.02036
G1 X125.859 Y139.38 E.01056
G3 X124.531 Y141.753 I-3.274 J-.274 E.05815
G1 X122.133 Y134.996 E.14871
G1 X122.218 Y134.828 E.0039
G2 X121.388 Y132.895 I-3.353 J.295 E.04437
G1 X120.082 Y129.217 E.08095
G3 X121.989 Y128 I4.564 J5.048 E.04715
G1 X122.218 Y127.545 E.01056
G2 X120.314 Y124.814 I-3.337 J.297 E.07227
G1 X119.444 Y124.359 E.02036
G1 X119.216 Y123.903 E.01056
G3 X121.268 Y121.095 I3.352 J.295 E.07581
G1 X121.578 Y122.022 E.02028
G1 X123.082 Y122.022 E.0312
G2 X124.762 Y123.903 I2.905 J-.903 E.05394
G1 X125.631 Y124.359 E.02036
G1 X125.859 Y124.814 E.01056
G1 X125.802 Y125.178 E.00765
G1 X128.182 Y125.178 E.04937
G2 X126.728 Y124.359 I-6.225 J9.351 E.03466
G1 X126.499 Y123.903 E.01056
G3 X127.278 Y122.022 I3.39 J.301 E.04289
G1 X130.365 Y122.022 E.06404
G2 X132.045 Y123.903 I2.905 J-.903 E.05394
G1 X132.914 Y124.359 E.02036
G1 X133.142 Y124.814 E.01056
G1 X133.085 Y125.178 E.00765
G1 X133.153 Y125.178 E.00141
G1 X131.313 Y130.731 E.12135
G2 X132.914 Y131.642 I6.909 J-10.286 E.03823
G1 X133.142 Y132.097 E.01056
G3 X131.239 Y134.828 I-3.337 J-.297 E.07227
G1 X130.369 Y135.283 E.02036
G1 X130.141 Y135.738 E.01056
G2 X132.045 Y138.47 I3.337 J-.297 E.07227
G1 X132.526 Y138.721 E.01126
G1 X131.386 Y142.02 E.07238
G3 X130.369 Y142.566 I-4.178 J-6.55 E.02397
G1 X130.141 Y143.022 E.01056
G2 X130.396 Y143.951 I2.283 J-.127 E.02015
G1 X127.205 Y143.951 E.06619
M73 P63 R8
G3 X128.403 Y143.022 I3.132 J2.8 E.03163
G1 X129.273 Y142.566 E.02036
G1 X129.501 Y142.111 E.01056
G2 X127.597 Y139.38 I-3.337 J.297 E.07227
G1 X126.728 Y138.925 E.02036
G1 X126.499 Y138.47 E.01056
G3 X126.755 Y137.54 I2.284 J.127 E.02015
G1 X127.155 Y138.742 E.02629
G1 X127.584 Y138.742 E.00891
; WIPE_START
G1 X127.155 Y138.742 E-.1632
G1 X126.755 Y137.54 E-.48166
G1 X126.645 Y137.822 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.349 Y134.173 Z6.84 F60000
G1 X134.27 Y133.672 Z6.84
G1 Z6.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.825 Y132.068 E.0352
G1 X134.011 Y131.642 E.01906
G1 X133.782 Y131.186 E.01056
G3 X135.686 Y128.455 I3.337 J.297 E.07227
G1 X136.158 Y128.208 E.01105
G1 X136.624 Y126.861 E.02957
G2 X134.88 Y124.814 I-3.003 J.791 E.05769
G1 X134.011 Y124.359 E.02036
G1 X133.782 Y123.903 E.01056
G3 X135.686 Y121.172 I3.337 J.297 E.07227
G1 X136.556 Y120.717 E.02036
G1 X136.784 Y120.262 E.01056
G2 X135.525 Y117.932 I-3.33 J.294 E.05648
G1 X136.787 Y114.084 E.08399
G1 X135.372 Y114.084 E.02935
G3 X136.556 Y113.434 I4.958 J7.617 E.02804
G1 X136.784 Y112.979 E.01056
G2 X136.529 Y112.049 I-2.284 J.127 E.02015
G1 X139.72 Y112.049 E.06619
G3 X138.522 Y112.979 I-3.13 J-2.796 E.03164
G1 X137.652 Y113.434 E.02036
G1 X137.424 Y113.889 E.01056
G2 X139.328 Y116.62 I3.337 J-.297 E.07227
G1 X140.035 Y116.99 E.01655
G1 X139.009 Y119.959 E.06514
G3 X137.652 Y120.717 I-5.765 J-8.72 E.03227
G1 X137.424 Y121.172 E.01056
G2 X138.024 Y122.81 I4.671 J-.782 E.03638
G1 X137.469 Y124.414 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.024 Y122.81 E-.64486
G1 X137.859 Y122.555 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L54
M991 S0 P53 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.84 I-.287 J-1.183 P1  F60000
G1 X123.325 Y126.079 Z6.84
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z6.96 F60000
G1 X119.605 Y114.987 Z6.96
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z6.96 F60000
G1 X141.28 Y114.497 Z6.96
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.537 Y112.117 Z6.96 F60000
G1 X134.123 Y112.049 Z6.96
G1 Z6.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.426 Y112.049 E.0352
G3 X132.016 Y112.523 I-1.343 J-.746 E.01311
G1 X130.71 Y113.434 E.03301
G1 X130.383 Y113.889 E.01163
G1 X130.371 Y114.084 E.00406
G1 X127.998 Y114.084 E.04921
G1 X128.931 Y113.434 E.02359
G2 X129.153 Y112.049 I-.834 J-.844 E.03113
G1 X125.143 Y112.049 E.08319
G3 X124.733 Y112.523 I-1.343 J-.746 E.01311
G1 X123.427 Y113.434 E.03301
G1 X123.1 Y113.889 E.01163
G1 X123.088 Y114.084 E.00406
G1 X120.715 Y114.084 E.04921
G1 X121.648 Y113.434 E.02359
G2 X121.87 Y112.049 I-.833 J-.844 E.03113
G1 X117.86 Y112.049 E.08319
G3 X117.45 Y112.523 I-1.343 J-.746 E.01311
G1 X116.144 Y113.434 E.03301
G1 X115.817 Y113.889 E.01163
G2 X116.701 Y116.165 I2.743 J.244 E.05248
G1 X118.007 Y117.075 E.03301
G1 X118.334 Y117.531 E.01163
G3 X116.883 Y120.202 I-2.797 J.21 E.06664
G1 X116.315 Y118.603 E.0352
M204 S10000
G1 X120.502 Y118.808 F60000
G1 F9000
M204 S4000
G1 X119.963 Y117.199 E.0352
G3 X119.515 Y115.861 I.505 J-.913 E.03214
G1 X118.977 Y114.252 E.0352
M204 S10000
G1 X123.017 Y126.302 F60000
G1 F9000
M204 S4000
G1 X123.553 Y127.913 E.0352
G2 X123.071 Y128.911 I.506 J.859 E.02437
G2 X124.643 Y131.191 I2.923 J-.333 E.05981
G1 X125.393 Y133.447 E.04932
G3 X124.733 Y134.373 I-3.243 J-1.615 E.02369
G1 X123.427 Y135.283 E.03301
G1 X123.1 Y135.738 E.01163
G1 X123.071 Y136.194 E.00946
G2 X123.984 Y138.014 I3.102 J-.416 E.04303
G1 X125.29 Y138.925 E.03301
G1 X125.617 Y139.38 E.01163
G1 X125.646 Y139.835 E.00946
G3 X124.544 Y141.788 I-2.819 J-.304 E.04781
G1 X121.99 Y134.593 E.15835
G1 X122.004 Y134.373 E.00458
G2 X121.385 Y132.887 I-3.04 J.395 E.03379
G1 X120.08 Y129.21 E.08093
G1 X120.343 Y128.911 E.00827
G1 X121.648 Y128 E.03301
G1 X121.976 Y127.545 E.01163
G1 X122.004 Y127.09 E.00946
G2 X121.091 Y125.269 I-3.102 J.416 E.04303
G1 X119.786 Y124.359 E.03301
G1 X119.458 Y123.903 E.01163
G1 X119.43 Y123.448 E.00946
G3 X120.343 Y121.627 I3.102 J.416 E.04303
G1 X121.237 Y121.004 E.02262
G1 X121.578 Y122.022 E.02228
G1 X123.183 Y122.022 E.03328
G2 X123.984 Y123.448 I2.667 J-.561 E.03447
G1 X125.29 Y124.359 E.03301
G1 X125.617 Y124.814 E.01163
G1 X125.64 Y125.178 E.00757
G1 X128.244 Y125.178 E.05401
G1 X127.069 Y124.359 E.02971
G1 X126.741 Y123.903 E.01163
G1 X126.713 Y123.448 E.00946
G3 X127.28 Y122.022 I3.249 J.466 E.03213
G1 X130.466 Y122.022 E.06608
G2 X131.267 Y123.448 I2.668 J-.561 E.03447
G1 X132.573 Y124.359 E.03301
G1 X132.9 Y124.814 E.01163
G1 X132.923 Y125.178 E.00757
G1 X133.153 Y125.178 E.00477
G1 X131.299 Y130.753 E.12187
G1 X132.573 Y131.642 E.03222
G1 X132.9 Y132.097 E.01163
G1 X132.929 Y132.552 E.00946
G3 X132.016 Y134.373 I-3.102 J-.416 E.04303
G1 X130.71 Y135.283 E.03301
G1 X130.383 Y135.738 E.01163
G1 X130.354 Y136.194 E.00946
G2 X131.267 Y138.014 I3.102 J-.416 E.04303
G1 X132.478 Y138.859 E.03062
G1 X131.351 Y142.119 E.07156
G2 X130.383 Y143.022 I.798 J1.828 E.02798
G2 X130.488 Y143.951 I1.377 J.315 E.01978
G1 X127.216 Y143.951 E.06788
G3 X127.626 Y143.477 I1.342 J.745 E.0131
G1 X128.931 Y142.566 E.03301
G1 X129.259 Y142.111 E.01163
G1 X129.287 Y141.656 E.00946
G2 X128.374 Y139.835 I-3.102 J.416 E.04303
G1 X127.069 Y138.925 E.03301
G1 X126.741 Y138.47 E.01163
G3 X126.804 Y137.69 I1.143 J-.3 E.01655
G1 X126.269 Y136.079 E.0352
; WIPE_START
G1 X126.804 Y137.69 E-.64486
G1 X126.722 Y137.981 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.327 Y134.156 Z6.96 F60000
G1 X134.297 Y133.594 Z6.96
G1 Z6.56
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.851 Y131.99 E.0352
G3 X134.024 Y131.186 I.729 J-1.577 E.02438
G1 X133.996 Y130.731 E.00946
G3 X134.909 Y128.911 I3.102 J.416 E.04303
G1 X136.215 Y128 E.03301
G1 X136.559 Y127.049 E.02099
G2 X135.657 Y125.269 I-3.052 J.428 E.04214
G1 X134.352 Y124.359 E.03301
G1 X134.024 Y123.903 E.01163
G1 X133.996 Y123.448 E.00946
G3 X134.909 Y121.627 I3.102 J.416 E.04303
G1 X136.215 Y120.717 E.03301
G1 X136.542 Y120.262 E.01163
G1 X136.57 Y119.807 E.00946
G2 X135.535 Y117.901 I-2.845 J.311 E.04615
G1 X136.787 Y114.084 E.08331
G1 X135.281 Y114.084 E.03124
G1 X136.215 Y113.434 E.02359
G1 X136.542 Y112.979 E.01163
G2 X136.437 Y112.049 I-1.378 J-.315 E.01979
G1 X139.709 Y112.049 E.06788
G3 X139.299 Y112.523 I-1.343 J-.746 E.01311
G1 X137.993 Y113.434 E.03301
G1 X137.666 Y113.889 E.01163
G1 X137.638 Y114.344 E.00946
G2 X138.551 Y116.165 I3.102 J-.416 E.04303
G1 X139.856 Y117.075 E.03301
G1 X139.957 Y117.215 E.00358
G1 X138.986 Y120.025 E.06166
G1 X137.993 Y120.717 E.0251
G1 X137.666 Y121.172 E.01163
G1 X137.638 Y121.627 E.00946
G1 X137.894 Y122.538 E.01962
G1 X138.033 Y122.783 E.00584
G1 X137.479 Y124.387 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.033 Y122.783 E-.64486
G1 X137.894 Y122.538 E-.10706
G1 X137.889 Y122.517 E-.00808
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L55
M991 S0 P54 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z6.96 I-.289 J-1.182 P1  F60000
G1 X123.325 Y126.079 Z6.96
G1 Z6.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.08 F60000
G1 X119.605 Y114.987 Z7.08
G1 Z6.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.08 F60000
G1 X141.28 Y114.497 Z7.08
G1 Z6.68
M73 P64 R8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.537 Y112.117 Z7.08 F60000
G1 X134.12 Y112.049 Z7.08
G1 Z6.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.423 Y112.049 E.0352
G3 X132.064 Y112.523 I-1.325 J-.63 E.01244
G1 X130.934 Y113.434 E.03009
G1 X130.574 Y113.889 E.01204
G1 X130.533 Y114.084 E.00414
G1 X127.9 Y114.084 E.05462
G1 X128.707 Y113.434 E.02151
G2 X129.074 Y112.049 I-.835 J-.962 E.03157
G1 X125.14 Y112.049 E.0816
G3 X124.781 Y112.523 I-1.325 J-.63 E.01244
G1 X123.651 Y113.434 E.03009
G1 X123.291 Y113.889 E.01204
G1 X123.25 Y114.084 E.00414
G1 X120.617 Y114.084 E.05462
G1 X121.424 Y113.434 E.02151
G2 X121.791 Y112.049 I-.835 J-.962 E.03157
G1 X117.857 Y112.049 E.0816
G3 X117.498 Y112.523 I-1.325 J-.63 E.01244
G1 X116.368 Y113.434 E.03009
G1 X116.008 Y113.889 E.01204
G2 X116.653 Y116.165 I2.434 J.539 E.05113
G1 X117.783 Y117.075 E.03009
G3 X118.238 Y117.986 I-.684 J.911 E.02189
G3 X116.91 Y120.28 I-2.734 J-.051 E.0574
G1 X116.343 Y118.681 E.0352
M204 S10000
G1 X120.396 Y118.492 F60000
G1 F9000
M204 S4000
G1 X119.857 Y116.883 E.0352
G3 X119.577 Y116.044 I.828 J-.743 E.01887
G1 X119.038 Y114.435 E.0352
M204 S10000
G1 X123.067 Y126.452 F60000
G1 F9000
M204 S4000
G1 X123.602 Y128.062 E.0352
G2 X123.196 Y128.911 I.646 J.832 E.02024
G2 X123.936 Y130.731 I2.857 J-.101 E.04162
G1 X124.693 Y131.341 E.02017
G1 X125.368 Y133.371 E.04436
G3 X124.781 Y134.373 I-2.606 J-.854 E.02428
G1 X123.651 Y135.283 E.03009
G2 X123.196 Y136.194 I.684 J.912 E.02189
G2 X123.936 Y138.014 I2.857 J-.101 E.04162
G1 X125.066 Y138.925 E.03009
G3 X125.521 Y139.835 I-.684 J.911 E.02189
G3 X124.781 Y141.656 I-2.857 J-.101 E.04162
G1 X124.56 Y141.834 E.00588
G1 X121.844 Y134.18 E.16846
G2 X121.375 Y132.859 I-2.494 J.141 E.02949
G1 X120.075 Y129.196 E.0806
G1 X120.295 Y128.911 E.00748
G1 X121.424 Y128 E.03009
G2 X121.88 Y127.09 I-.684 J-.911 E.02189
G2 X121.139 Y125.269 I-2.857 J.101 E.04162
G1 X120.01 Y124.359 E.03009
G3 X119.554 Y123.448 I.684 J-.911 E.02189
G3 X120.295 Y121.627 I2.857 J.101 E.04162
G1 X121.201 Y120.897 E.02415
G1 X121.578 Y122.022 E.02462
G1 X123.27 Y122.022 E.03509
G2 X123.936 Y123.448 I2.474 J-.288 E.03322
G1 X125.066 Y124.359 E.03009
G1 X125.426 Y124.814 E.01204
G1 X125.502 Y125.178 E.00772
G1 X128.309 Y125.178 E.05822
G1 X127.293 Y124.359 E.02708
G3 X126.837 Y123.448 I.684 J-.912 E.02189
G3 X127.274 Y122.022 I2.941 J.122 E.03128
G1 X130.553 Y122.022 E.068
G2 X131.219 Y123.448 I2.474 J-.288 E.03322
G1 X132.349 Y124.359 E.03009
G1 X132.709 Y124.814 E.01204
G1 X132.786 Y125.178 E.00772
G1 X133.153 Y125.178 E.00762
G1 X131.288 Y130.787 E.1226
G1 X132.349 Y131.642 E.02827
G3 X132.805 Y132.552 I-.684 J.911 E.02189
G3 X132.064 Y134.373 I-2.857 J-.101 E.04162
G1 X130.934 Y135.283 E.03009
G2 X130.479 Y136.194 I.684 J.911 E.02189
G2 X131.219 Y138.014 I2.857 J-.101 E.04162
G1 X132.423 Y139.018 E.03251
G1 X131.298 Y142.273 E.07143
G2 X130.574 Y143.022 I1.29 J1.972 E.02178
G2 X130.568 Y143.951 I1.122 J.473 E.01979
G1 X127.219 Y143.951 E.06947
G3 X127.578 Y143.477 I1.324 J.629 E.01243
G1 X128.707 Y142.566 E.03009
G2 X129.163 Y141.656 I-.684 J-.912 E.02189
G2 X128.422 Y139.835 I-2.857 J.101 E.04162
G1 X127.293 Y138.925 E.03009
G3 X126.864 Y137.869 I.79 J-.936 E.02457
G1 X126.329 Y136.259 E.0352
; WIPE_START
G1 X126.864 Y137.869 E-.64486
G1 X126.837 Y138.014 E-.05604
G1 X126.869 Y138.167 E-.0591
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.338 Y134.117 Z7.08 F60000
G1 X134.331 Y133.495 Z7.08
G1 Z6.68
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.886 Y131.891 E.0352
G3 X134.216 Y131.186 I1.22 J-1.831 E.02034
G1 X134.12 Y130.731 E.00965
G3 X134.861 Y128.911 I2.857 J.101 E.04162
G1 X135.99 Y128 E.03009
G2 X136.446 Y127.09 I-.684 J-.911 E.02189
G2 X135.706 Y125.269 I-2.857 J.101 E.04162
G1 X134.576 Y124.359 E.03009
G3 X134.12 Y123.448 I.684 J-.911 E.02189
G3 X134.861 Y121.627 I2.857 J.101 E.04162
G1 X135.99 Y120.717 E.03009
G2 X136.446 Y119.807 I-.684 J-.911 E.02189
G2 X135.706 Y117.986 I-2.857 J.101 E.04162
G1 X135.549 Y117.859 E.00418
G1 X136.787 Y114.084 E.08241
G1 X135.183 Y114.084 E.03327
G2 X136.351 Y112.979 I-1.856 J-3.13 E.03363
G2 X136.357 Y112.049 I-1.123 J-.473 E.01979
G1 X139.706 Y112.049 E.06947
G3 X139.347 Y112.523 I-1.325 J-.63 E.01244
G1 X138.218 Y113.434 E.03009
G2 X137.762 Y114.344 I.684 J.912 E.02189
G2 X138.502 Y116.165 I2.857 J-.101 E.04162
G1 X139.632 Y117.075 E.03009
G1 X139.892 Y117.403 E.00868
G1 X138.951 Y120.126 E.05974
G2 X137.857 Y121.172 I1.762 J2.937 E.03166
G1 X137.762 Y121.627 E.00965
G1 X137.932 Y122.538 E.01921
G1 X138.04 Y122.761 E.00515
G1 X137.486 Y124.365 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.04 Y122.761 E-.64486
G1 X137.932 Y122.538 E-.09427
G1 X137.922 Y122.484 E-.02087
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L56
M991 S0 P55 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.08 I-.291 J-1.182 P1  F60000
G1 X123.325 Y126.079 Z7.08
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.2 F60000
G1 X119.605 Y114.987 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.2 F60000
G1 X141.28 Y114.497 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.537 Y112.117 Z7.2 F60000
G1 X134.124 Y112.049 Z7.2
M73 P64 R7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.427 Y112.049 E.0352
G3 X132.115 Y112.523 I-1.295 J-.513 E.01188
G2 X130.734 Y113.889 I4.026 J5.452 E.04042
G1 X130.671 Y114.084 E.00426
G1 X127.814 Y114.084 E.05927
G1 X128.532 Y113.434 E.0201
G2 X129.051 Y112.049 I-.9 J-1.127 E.03222
G1 X125.144 Y112.049 E.08103
G3 X124.831 Y112.523 I-1.295 J-.513 E.01188
G2 X123.451 Y113.889 I4.026 J5.452 E.04042
G1 X123.388 Y114.084 E.00426
G1 X120.531 Y114.084 E.05927
G1 X121.249 Y113.434 E.0201
G2 X121.768 Y112.049 I-.9 J-1.127 E.03222
G1 X117.861 Y112.049 E.08103
G3 X117.548 Y112.523 I-1.295 J-.513 E.01188
G2 X116.167 Y113.889 I4.026 J5.452 E.04042
G2 X116.602 Y116.165 I2.168 J.765 E.05037
G1 X117.607 Y117.075 E.02812
G3 X118.128 Y117.986 I-.872 J1.104 E.0223
G3 X116.939 Y120.359 I-2.647 J.158 E.05768
G1 X116.371 Y118.76 E.0352
M204 S10000
G1 X123.117 Y126.601 F60000
G1 F9000
M204 S4000
G1 X123.652 Y128.211 E.0352
G2 X123.304 Y129.366 I1.124 J.969 E.02575
G2 X123.886 Y130.731 I2.833 J-.4 E.03115
G1 X124.751 Y131.516 E.02423
G1 X125.35 Y133.317 E.03938
G3 X124.831 Y134.373 I-2.721 J-.682 E.02458
G2 X123.451 Y135.738 I4.026 J5.452 E.04042
G2 X123.886 Y138.014 I2.168 J.765 E.05037
G3 X125.266 Y139.38 I-4.026 J5.452 E.04042
G3 X124.578 Y141.885 I-2.126 J.763 E.05741
G1 X121.772 Y133.977 E.17407
G2 X121.352 Y132.794 I-2.043 J.059 E.02647
G1 X120.067 Y129.174 E.07966
G1 X120.244 Y128.911 E.00659
G2 X121.625 Y127.545 I-4.026 J-5.452 E.04042
G2 X121.19 Y125.269 I-2.168 J-.765 E.05037
M73 P65 R7
G3 X119.809 Y123.903 I4.026 J-5.452 E.04042
G3 X120.244 Y121.627 I2.168 J-.765 E.05037
G1 X121.166 Y120.792 E.02581
G1 X121.578 Y122.022 E.02691
G1 X123.304 Y122.022 E.0358
G2 X123.886 Y123.448 I2.497 J-.187 E.03247
G3 X125.266 Y124.814 I-4.026 J5.452 E.04042
G1 X125.383 Y125.178 E.00793
G1 X128.373 Y125.178 E.06202
G3 X127.092 Y123.903 I3.762 J-5.06 E.0376
G3 X127.263 Y122.022 I2.094 J-.759 E.04046
G1 X130.587 Y122.022 E.06895
G2 X131.169 Y123.448 I2.497 J-.187 E.03247
G3 X132.55 Y124.814 I-4.026 J5.452 E.04042
G1 X132.666 Y125.178 E.00793
G1 X133.153 Y125.178 E.01011
G1 X131.274 Y130.827 E.12349
G3 X132.55 Y132.097 I-3.748 J5.04 E.03746
G3 X132.115 Y134.373 I-2.168 J.765 E.05037
G2 X130.734 Y135.738 I4.026 J5.452 E.04042
G2 X131.169 Y138.014 I2.168 J.765 E.05037
G3 X132.372 Y139.165 I-3.373 J4.732 E.03466
G1 X131.237 Y142.452 E.07212
G2 X130.591 Y143.951 I.971 J1.307 E.03548
G1 X127.214 Y143.951 E.07003
G3 X127.527 Y143.477 I1.294 J.512 E.01187
G2 X128.908 Y142.111 I-4.026 J-5.452 E.04042
G2 X128.473 Y139.835 I-2.168 J-.765 E.05037
G1 X127.318 Y138.742 E.03299
G1 X128.642 Y138.742 E.02747
G1 X128.76 Y138.389 E.00773
M204 S10000
G1 X134.365 Y133.398 F60000
G1 F9000
M204 S4000
G1 X134.919 Y131.794 E.0352
G3 X134.23 Y130.731 I1.379 J-1.649 E.02666
G3 X134.81 Y128.911 I2.496 J-.208 E.04067
G2 X136.191 Y127.545 I-4.026 J-5.452 E.04042
G2 X135.756 Y125.269 I-2.168 J-.765 E.05037
G3 X134.375 Y123.903 I4.026 J-5.452 E.04042
G3 X134.81 Y121.627 I2.168 J-.765 E.05037
G2 X136.191 Y120.262 I-4.026 J-5.452 E.04042
G2 X135.564 Y117.812 I-2.115 J-.764 E.05571
G1 X136.787 Y114.084 E.08137
G1 X135.097 Y114.084 E.03506
G2 X136.191 Y112.979 I-3.272 J-4.332 E.03238
G2 X136.334 Y112.049 I-1.976 J-.78 E.01968
G1 X139.711 Y112.049 E.07004
G3 X139.398 Y112.523 I-1.295 J-.513 E.01188
G2 X138.017 Y113.889 I4.026 J5.452 E.04042
G2 X138.452 Y116.165 I2.168 J.765 E.05037
G3 X139.84 Y117.553 I-4.024 J5.412 E.04087
G1 X138.908 Y120.25 E.05919
G2 X138.017 Y121.172 I2.738 J3.539 E.02669
G2 X138.046 Y122.744 I1.754 J.754 E.03362
G1 X137.492 Y124.348 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.046 Y122.744 E-.64486
G1 X137.968 Y122.452 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L57
M991 S0 P56 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.2 I-.293 J-1.181 P1  F60000
G1 X123.325 Y126.079 Z7.2
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.32 F60000
G1 X119.605 Y114.987 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.32 F60000
G1 X141.28 Y114.497 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.537 Y112.115 Z7.32 F60000
G1 X134.135 Y112.049 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.438 Y112.049 E.0352
G3 X131.759 Y112.979 I-3.214 J-1.635 E.02399
G2 X130.792 Y114.084 I1.997 J2.721 E.03071
G1 X127.707 Y114.084 E.064
G3 X128.382 Y113.434 I3.601 J3.062 E.01948
G2 X128.994 Y112.049 I-1.066 J-1.298 E.03258
G1 X125.155 Y112.049 E.07963
G3 X124.476 Y112.979 I-3.214 J-1.635 E.02399
G2 X123.509 Y114.084 I1.997 J2.721 E.03071
G1 X120.424 Y114.084 E.064
G3 X121.099 Y113.434 I3.601 J3.062 E.01948
G2 X121.711 Y112.049 I-1.066 J-1.298 E.03258
G1 X117.872 Y112.049 E.07963
G3 X117.602 Y112.523 I-1.257 J-.401 E.01141
G2 X116.306 Y113.889 I38.996 J38.308 E.03905
G2 X116.958 Y116.62 I2.13 J.935 E.06253
G3 X118.031 Y117.986 I-1.787 J2.507 E.03651
G3 X116.975 Y120.46 I-2.623 J.343 E.05855
G1 X116.407 Y118.861 E.0352
M204 S10000
G1 X123.157 Y126.723 F60000
G1 F9000
M204 S4000
G1 X123.693 Y128.333 E.0352
G2 X123.568 Y130.276 I1.597 J1.078 E.04233
G2 X124.741 Y131.642 I3.96 J-2.214 E.03758
G1 X124.827 Y131.742 E.00274
G1 X125.325 Y133.243 E.0328
G3 X124.476 Y134.828 I-2.525 J-.333 E.03813
G2 X123.403 Y136.194 I1.787 J2.507 E.03651
G2 X124.241 Y138.47 I2.493 J.374 E.05248
G3 X125.314 Y139.835 I-1.787 J2.507 E.03651
G3 X124.607 Y141.965 I-2.416 J.38 E.04836
G1 X121.693 Y133.756 E.18069
G2 X121.301 Y132.652 I-2.477 J.258 E.02452
G1 X120.056 Y129.143 E.07724
G3 X121.099 Y128 I3.946 J2.556 E.03224
G2 X121.507 Y125.724 I-1.316 J-1.41 E.05143
G2 X120.335 Y124.359 I-3.96 J2.214 E.03758
G3 X119.927 Y122.083 I1.316 J-1.41 E.05143
G3 X121.129 Y120.682 I3.267 J1.588 E.03872
G1 X121.578 Y122.022 E.02932
G1 X123.367 Y122.022 E.03712
G2 X124.241 Y123.903 I2.585 J-.057 E.04427
G3 X125.277 Y125.178 I-1.797 J2.517 E.03447
G1 X128.445 Y125.178 E.06572
G3 X127.231 Y123.903 I27.777 J-27.677 E.03652
G3 X127.245 Y122.022 I1.947 J-.926 E.04038
G1 X130.65 Y122.022 E.07064
G2 X131.524 Y123.903 I2.585 J-.057 E.04427
G3 X132.56 Y125.178 I-1.797 J2.517 E.03447
G1 X133.153 Y125.178 E.01231
G1 X131.255 Y130.886 E.12479
G3 X132.411 Y132.097 I-21.692 J21.883 E.03473
G3 X131.759 Y134.828 I-2.13 J.935 E.06253
G2 X130.686 Y136.194 I1.787 J2.507 E.03651
G2 X131.524 Y138.47 I2.493 J.374 E.05248
G3 X132.331 Y139.285 I-2.787 J3.56 E.02385
G1 X131.154 Y142.69 E.07471
G2 X130.647 Y143.951 I.996 J1.133 E.02925
G1 X127.204 Y143.951 E.07143
G3 X128.382 Y142.566 I3.991 J2.203 E.03798
G2 X128.79 Y140.29 I-1.316 J-1.41 E.05143
G2 X127.618 Y138.925 I-3.96 J2.214 E.03758
G1 X127.463 Y138.742 E.00497
G1 X128.642 Y138.742 E.02446
G1 X128.805 Y138.251 E.01074
M204 S10000
G1 X134.401 Y133.295 F60000
G1 F9000
M204 S4000
G1 X134.955 Y131.691 E.0352
G3 X134.757 Y128.911 I1.322 J-1.492 E.06403
G2 X136.053 Y127.545 I-38.994 J-38.307 E.03905
G2 X135.4 Y124.814 I-2.13 J-.935 E.06253
G3 X134.328 Y123.448 I1.787 J-2.507 E.03651
G3 X135.166 Y121.172 I2.493 J-.374 E.05248
G2 X136.238 Y119.807 I-1.787 J-2.507 E.03651
G2 X135.588 Y117.739 I-2.396 J-.382 E.0466
G1 X136.787 Y114.084 E.07979
G1 X134.99 Y114.084 E.03728
G2 X136.053 Y112.979 I-14.09 J-14.6 E.03182
G2 X136.277 Y112.049 I-1.967 J-.967 E.02001
G1 X139.721 Y112.049 E.07144
G3 X138.542 Y113.434 I-3.991 J-2.202 E.03799
G2 X138.135 Y115.71 I1.316 J1.41 E.05143
G2 X139.307 Y117.075 I3.959 J-2.214 E.03758
G3 X139.777 Y117.734 I-.768 J1.046 E.01708
G1 X138.841 Y120.445 E.05949
G2 X137.97 Y121.627 I1.694 J2.161 E.03084
G2 X138.05 Y122.734 I2.356 J.385 E.02323
G1 X137.496 Y124.338 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.05 Y122.734 E-.64486
G1 X137.994 Y122.436 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L58
M991 S0 P57 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.32 I-.293 J-1.181 P1  F60000
G1 X123.325 Y126.079 Z7.32
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.44 F60000
G1 X119.605 Y114.987 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.44 F60000
G1 X141.28 Y114.497 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
M73 P66 R7
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.538 Y112.112 Z7.44 F60000
G1 X134.152 Y112.049 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.455 Y112.049 E.0352
G3 X131.86 Y112.979 I-3.057 J-1.3 E.023
G2 X130.901 Y114.084 I2.818 J3.415 E.03051
G1 X127.625 Y114.084 E.06796
G3 X128.249 Y113.434 I2.949 J2.204 E.01875
G2 X128.945 Y112.049 I-1.263 J-1.502 E.03306
G1 X125.172 Y112.049 E.07826
G3 X124.577 Y112.979 I-3.056 J-1.299 E.023
G2 X123.618 Y114.084 I2.818 J3.415 E.03051
G1 X120.341 Y114.084 E.06796
G3 X120.966 Y113.434 I2.949 J2.204 E.01875
G2 X121.662 Y112.049 I-1.263 J-1.502 E.03306
G1 X117.889 Y112.049 E.07826
G3 X116.827 Y113.434 I-3.494 J-1.58 E.03653
G2 X116.857 Y116.62 I1.475 J1.579 E.07432
G3 X117.943 Y117.986 I-2.49 J3.095 E.03649
G3 X117.004 Y120.544 I-2.457 J.55 E.05972
G1 X116.437 Y118.945 E.0352
M204 S10000
G1 X123.192 Y126.828 F60000
G1 F9000
M204 S4000
G1 X123.728 Y128.438 E.0352
G2 X124.14 Y131.186 I1.907 J1.119 E.06233
G3 X124.908 Y131.986 I-4.523 J5.112 E.02302
G1 X125.297 Y133.157 E.0256
G3 X124.11 Y135.283 I-2.78 J-.158 E.05228
G2 X124.14 Y138.47 I1.475 J1.579 E.07432
G3 X125.226 Y139.835 I-2.49 J3.096 E.03649
G3 X124.634 Y142.041 I-2.295 J.566 E.04944
G1 X121.649 Y133.63 E.18512
G2 X121.238 Y132.474 I-1.86 J.009 E.02593
G1 X120.04 Y129.099 E.0743
G3 X120.966 Y128 I3.558 J2.059 E.02994
G2 X120.936 Y124.814 I-1.475 J-1.579 E.07432
G3 X119.85 Y123.448 I2.49 J-3.095 E.03649
G3 X120.498 Y121.172 I2.331 J-.566 E.05134
G2 X121.092 Y120.572 I-3.389 J-3.948 E.01754
G1 X121.578 Y122.022 E.03173
G1 X123.423 Y122.022 E.03827
G2 X124.607 Y124.359 I2.736 J.081 E.05666
G3 X125.182 Y125.178 I-1.226 J1.47 E.021
G1 X128.511 Y125.178 E.06906
G2 X127.354 Y123.903 I-33.257 J29.019 E.0357
G3 X127.221 Y122.022 I1.855 J-1.076 E.0405
G1 X130.706 Y122.022 E.07228
G2 X131.89 Y124.359 I2.736 J.082 E.05666
G3 X132.465 Y125.178 I-1.225 J1.47 E.021
G1 X133.153 Y125.178 E.01428
G1 X131.233 Y130.95 E.12618
G2 X132.287 Y132.097 I91.369 J-82.935 E.03231
G3 X131.86 Y134.828 I-1.958 J1.093 E.06178
G2 X130.774 Y136.194 I2.49 J3.095 E.03649
G2 X131.423 Y138.47 I2.331 J.566 E.05134
G3 X132.294 Y139.393 I-6.425 J6.933 E.02634
G1 X131.068 Y142.938 E.07782
G2 X130.697 Y143.951 I.992 J.939 E.02301
G1 X127.187 Y143.951 E.07281
G3 X128.249 Y142.566 I3.494 J1.58 E.03652
G2 X128.219 Y139.38 I-1.475 J-1.579 E.07432
G3 X127.592 Y138.742 I3.601 J-4.165 E.01856
G1 X128.642 Y138.742 E.02177
G1 X128.846 Y138.128 E.01343
M204 S10000
G1 X135.544 Y129.986 F60000
G1 F9000
M204 S4000
G1 X134.99 Y131.59 E.0352
G3 X135.064 Y128.455 I1.511 J-1.532 E.07287
G2 X136.151 Y127.09 I-2.49 J-3.095 E.03649
G2 X135.502 Y124.814 I-2.331 J-.566 E.05134
G3 X134.416 Y123.448 I2.49 J-3.095 E.03649
G3 X135.064 Y121.172 I2.331 J-.566 E.05134
G2 X136.151 Y119.807 I-2.49 J-3.095 E.03649
G2 X135.612 Y117.667 I-2.268 J-.566 E.04765
G1 X136.787 Y114.084 E.07822
G1 X134.908 Y114.084 E.03899
G3 X135.929 Y112.979 I1068.182 J985.525 E.03122
G2 X136.228 Y112.049 I-2.022 J-1.164 E.02042
G1 X139.738 Y112.049 E.07281
G3 X138.676 Y113.434 I-3.494 J-1.58 E.03653
G2 X138.706 Y116.62 I1.475 J1.579 E.07432
G3 X139.733 Y117.864 I-2.533 J3.137 E.03368
G1 X138.783 Y120.613 E.06034
G2 X138.05 Y122.732 I1.223 J1.609 E.04929
G1 X137.496 Y124.336 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.05 Y122.732 E-.64486
G1 X138.017 Y122.431 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L59
M991 S0 P58 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.44 I-.293 J-1.181 P1  F60000
G1 X123.325 Y126.079 Z7.44
G1 Z7.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.56 F60000
G1 X119.605 Y114.987 Z7.56
G1 Z7.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.56 F60000
G1 X141.28 Y114.497 Z7.56
G1 Z7.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.538 Y112.109 Z7.56 F60000
G1 X134.175 Y112.049 Z7.56
G1 Z7.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.478 Y112.049 E.0352
G3 X132.287 Y112.523 I-1.175 J-.197 E.0107
G2 X130.999 Y114.084 I428.019 J354.304 E.04197
G1 X127.541 Y114.084 E.07174
G3 X128.124 Y113.434 I2.443 J1.603 E.01819
G2 X128.903 Y112.049 I-1.492 J-1.751 E.03366
G1 X125.195 Y112.049 E.07691
G3 X125.004 Y112.523 I-1.175 J-.197 E.0107
G2 X123.716 Y114.084 I430.187 J356.095 E.04197
G1 X120.258 Y114.084 E.07174
G3 X120.841 Y113.434 I2.443 J1.602 E.01819
G2 X121.62 Y112.049 I-1.492 J-1.751 E.03366
G1 X117.912 Y112.049 E.07691
G3 X116.952 Y113.434 I-3.043 J-1.084 E.03537
G2 X116.43 Y116.165 I1.382 J1.679 E.06257
G2 X117.608 Y117.531 I10.411 J-7.789 E.03744
G3 X117.035 Y120.631 I-1.932 J1.246 E.07207
G1 X116.468 Y119.032 E.0352
M204 S10000
G1 X123.232 Y126.949 F60000
G1 F9000
M204 S4000
G1 X123.768 Y128.559 E.0352
G2 X124.039 Y131.186 I1.849 J1.137 E.0589
G3 X125.022 Y132.331 I-3.881 J4.328 E.03137
G3 X124.235 Y135.283 I-2.174 J1.002 E.06875
G2 X124.039 Y138.47 I1.414 J1.686 E.07408
G3 X125.146 Y139.835 I-3.515 J3.98 E.03663
G3 X124.664 Y142.126 I-2.114 J.75 E.05107
G1 X121.628 Y133.572 E.18827
G2 X121.172 Y132.286 I-1.902 J-.049 E.02895
G1 X120.019 Y129.038 E.07148
G3 X120.841 Y128 I3.261 J1.737 E.02762
G2 X121.036 Y124.814 I-1.414 J-1.686 E.07409
G3 X119.929 Y123.448 I3.514 J-3.98 E.03663
G3 X120.841 Y120.717 I2.355 J-.732 E.06377
G1 X121.06 Y120.473 E.00679
G1 X121.578 Y122.022 E.03388
G1 X123.471 Y122.022 E.03927
G2 X124.482 Y124.359 I2.484 J.312 E.0554
G3 X125.095 Y125.178 I-1.52 J1.776 E.0214
G1 X128.58 Y125.178 E.07228
G2 X127.468 Y123.903 I-10.914 J8.405 E.03511
G3 X127.192 Y122.022 I1.798 J-1.224 E.04082
G1 X130.754 Y122.022 E.0739
G2 X131.765 Y124.359 I2.484 J.312 E.0554
G3 X132.378 Y125.178 I-1.52 J1.776 E.0214
G1 X133.153 Y125.178 E.01607
G1 X131.208 Y131.027 E.12785
G2 X132.174 Y132.097 I17.755 J-15.058 E.02991
G3 X131.961 Y134.828 I-1.804 J1.233 E.06142
G2 X130.854 Y136.194 I3.514 J3.98 E.03663
G2 X131.765 Y138.925 I2.355 J.732 E.06377
G3 X132.251 Y139.517 I-1.077 J1.378 E.016
M73 P67 R7
G1 X130.928 Y143.344 E.08401
G2 X130.718 Y143.951 I3.497 J1.548 E.01334
G1 X127.163 Y143.951 E.07374
G3 X128.124 Y142.566 I3.043 J1.085 E.03537
G2 X128.319 Y139.38 I-1.414 J-1.686 E.07408
G3 X127.712 Y138.742 I7.642 J-7.879 E.01826
G1 X128.642 Y138.742 E.01928
G1 X128.884 Y138.014 E.01592
M204 S10000
G1 X135.578 Y129.887 F60000
G1 F9000
M204 S4000
G1 X135.024 Y131.491 E.0352
G3 X134.964 Y128.455 I1.514 J-1.548 E.06979
G2 X136.071 Y127.09 I-3.514 J-3.98 E.03663
G2 X135.159 Y124.359 I-2.355 J-.732 E.06377
G3 X134.964 Y121.172 I1.414 J-1.686 E.07409
G2 X136.071 Y119.807 I-3.514 J-3.98 E.03663
G2 X135.64 Y117.582 I-2.16 J-.735 E.04918
G1 X136.787 Y114.084 E.07636
G1 X134.824 Y114.084 E.04072
G3 X135.816 Y112.979 I14.942 J12.402 E.03082
G2 X136.186 Y112.049 I-2.114 J-1.381 E.0209
G1 X139.761 Y112.049 E.07416
G3 X138.801 Y113.434 I-3.043 J-1.084 E.03537
G2 X138.606 Y116.62 I1.414 J1.686 E.07409
G3 X139.699 Y117.961 I-3.52 J3.986 E.03605
G1 X138.713 Y120.815 E.06262
G2 X138.047 Y122.742 I1.388 J1.558 E.04417
G1 X137.493 Y124.346 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.047 Y122.742 E-.64486
G1 X138.036 Y122.439 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L60
M991 S0 P59 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.56 I-.292 J-1.181 P1  F60000
G1 X123.325 Y126.079 Z7.56
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.68 F60000
G1 X119.605 Y114.987 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.68 F60000
G1 X141.28 Y114.497 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.539 Y112.104 Z7.68 F60000
G1 X134.204 Y112.049 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.507 Y112.049 E.0352
G3 X132.063 Y112.979 I-2.679 J-.71 E.02151
G2 X131.091 Y114.084 I6.5 J6.689 E.03056
G1 X127.454 Y114.084 E.07544
G3 X128.003 Y113.434 I2.045 J1.168 E.01775
G2 X128.867 Y112.049 I-1.758 J-2.059 E.0344
G1 X125.224 Y112.049 E.07557
G3 X124.779 Y112.979 I-2.679 J-.71 E.02151
G2 X123.808 Y114.084 I6.501 J6.69 E.03056
G1 X120.171 Y114.084 E.07544
G3 X120.72 Y113.434 I2.045 J1.168 E.01775
G2 X121.584 Y112.049 I-1.759 J-2.059 E.0344
G1 X117.941 Y112.049 E.07557
G3 X117.072 Y113.434 I-2.642 J-.692 E.03444
G2 X117.079 Y117.075 I1.391 J1.818 E.08733
G3 X117.072 Y120.717 I-1.391 J1.818 E.08733
G1 X116.5 Y119.123 E.03513
M204 S10000
G1 X123.266 Y127.051 F60000
G1 F9000
M204 S4000
G1 X123.802 Y128.661 E.0352
G2 X124.362 Y131.642 I1.902 J1.186 E.0691
G3 X124.355 Y135.283 I-1.391 J1.818 E.08733
G2 X124.362 Y138.925 I1.391 J1.818 E.08733
G3 X124.692 Y142.205 I-1.354 J1.793 E.07677
G1 X125.312 Y143.951 E.03843
G1 X127.134 Y143.951 E.03781
G3 X128.003 Y142.566 I2.642 J.693 E.03444
G2 X128.712 Y139.835 I-1.384 J-1.817 E.06308
G2 X127.827 Y138.742 I-5.176 J3.284 E.02922
G1 X128.642 Y138.742 E.0169
G1 X128.92 Y137.905 E.0183
; WIPE_START
G1 X128.642 Y138.742 E-.33529
G1 X127.827 Y138.742 E-.30957
G1 X128.034 Y138.964 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.187 Y135.146 Z7.68 F60000
G1 Z7.28
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X121.619 Y133.547 E.0352
G2 X121.084 Y132.039 I-2.22 J-.061 E.03395
G1 X119.99 Y128.957 E.06784
G3 X120.72 Y128 I3.253 J1.726 E.02507
G2 X120.714 Y124.359 I-1.391 J-1.818 E.08733
G3 X120.005 Y121.627 I1.384 J-1.817 E.06308
G3 X121.03 Y120.384 I5.904 J3.82 E.03349
G1 X121.578 Y122.022 E.03583
G1 X123.513 Y122.022 E.04014
G2 X123.938 Y123.903 I2.187 J.495 E.04135
G3 X125.016 Y125.178 I-5.372 J5.639 E.0347
G1 X128.654 Y125.178 E.07545
G2 X127.997 Y124.359 I-2.558 J1.377 E.0219
G3 X127.157 Y122.022 I1.386 J-1.818 E.05445
G1 X130.796 Y122.022 E.07549
G2 X131.221 Y123.903 I2.187 J.495 E.04135
G3 X132.299 Y125.178 I-5.373 J5.639 E.0347
G1 X133.153 Y125.178 E.01771
G1 X131.177 Y131.119 E.12986
G2 X131.645 Y131.642 I1.656 J-1.01 E.01463
G3 X131.639 Y135.283 I-1.391 J1.818 E.08733
G2 X131.221 Y138.47 I1.363 J1.799 E.07418
G3 X132.217 Y139.615 I-6.045 J6.265 E.03152
G1 X135.055 Y131.4 E.18028
G3 X135.286 Y128 I1.586 J-1.6 E.08015
G2 X135.28 Y124.359 I-1.391 J-1.818 E.08733
G3 X135.286 Y120.717 I1.391 J-1.818 E.08733
G2 X135.669 Y117.493 I-1.358 J-1.796 E.07522
G1 X136.787 Y114.084 E.07441
G1 X134.737 Y114.084 E.04252
G3 X135.286 Y113.434 I2.045 J1.168 E.01775
G2 X136.151 Y112.049 I-1.758 J-2.059 E.0344
G1 X139.79 Y112.049 E.0755
G3 X138.922 Y113.434 I-2.642 J-.692 E.03444
G2 X138.928 Y117.075 I1.391 J1.818 E.08733
G3 X139.665 Y118.061 I-2.284 J2.476 E.02566
G1 X138.643 Y121.016 E.06487
G2 X138.038 Y122.768 I1.557 J1.518 E.03972
G1 X137.484 Y124.372 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X138.038 Y122.768 E-.64486
G1 X138.047 Y122.465 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L61
M991 S0 P60 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.68 I-.29 J-1.182 P1  F60000
G1 X123.325 Y126.079 Z7.68
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.8 F60000
G1 X119.605 Y114.987 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.8 F60000
G1 X141.28 Y114.497 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
M73 P68 R7
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.227 Y115.793 Z7.8 F60000
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.698 Y117.406 E.0352
G3 X135.608 Y120.262 I-1.666 J1.377 E.06476
G2 X134.499 Y121.627 I3.582 J4.039 E.03664
G2 X135.401 Y124.359 I2.342 J.741 E.06373
G3 X135.608 Y127.545 I-1.412 J1.692 E.07408
G2 X134.499 Y128.911 I3.582 J4.039 E.03664
G2 X135.084 Y131.316 I2.164 J.748 E.05425
G1 X132.19 Y139.694 E.18386
G2 X131.115 Y138.47 I-11.058 J8.624 E.03381
G3 X131.317 Y135.738 I1.796 J-1.24 E.06141
G2 X132.425 Y134.373 I-3.582 J-4.04 E.03664
G2 X131.524 Y131.642 I-2.342 J-.741 E.06373
G1 X131.144 Y131.219 E.01179
G1 X128.642 Y138.742 E.16446
G1 X127.94 Y138.742 E.01455
G3 X128.784 Y139.835 I-3.071 J3.242 E.02875
G3 X127.883 Y142.566 I-2.342 J.741 E.06373
G2 X127.099 Y143.951 I1.505 J1.766 E.03369
G1 X125.312 Y143.951 E.03708
G1 X124.723 Y142.292 E.03652
G2 X124.683 Y139.38 I-1.612 J-1.434 E.06631
G3 X123.575 Y138.014 I3.582 J-4.04 E.03664
G3 X124.476 Y135.283 I2.342 J-.741 E.06373
G2 X124.683 Y132.097 I-1.412 J-1.692 E.07408
G3 X123.575 Y130.731 I3.582 J-4.039 E.03664
G3 X123.829 Y128.743 I2.113 J-.74 E.0431
G1 X122.643 Y125.178 E.07794
G1 X124.942 Y125.178 E.04769
G2 X123.832 Y123.903 I-10.549 J8.072 E.03509
G3 X123.549 Y122.022 I1.796 J-1.232 E.04084
G1 X127.115 Y122.022 E.07398
G2 X128.118 Y124.359 I2.471 J.323 E.05534
G3 X128.733 Y125.178 I-1.537 J1.794 E.02142
G1 X132.225 Y125.178 E.07245
G2 X131.115 Y123.903 I-10.551 J8.073 E.03509
G3 X130.832 Y122.022 I1.796 J-1.232 E.04084
G1 X129.135 Y122.022 E.0352
M204 S10000
G1 X137.465 Y124.426 F60000
G1 F9000
M204 S4000
G1 X138.02 Y122.822 E.0352
G3 X138.579 Y121.202 I2.158 J-.161 E.03655
G1 X139.637 Y118.141 E.06717
G2 X139.249 Y117.531 I-1.492 J.519 E.01514
G3 X138.141 Y116.165 I3.582 J-4.039 E.03664
G3 X139.042 Y113.434 I2.342 J-.741 E.06373
G2 X139.826 Y112.049 I-1.505 J-1.766 E.03369
G1 X136.121 Y112.049 E.07684
G3 X135.608 Y112.979 I-2.862 J-.974 E.02215
G2 X134.646 Y114.084 I4.181 J4.607 E.03047
G1 X131.178 Y114.084 E.07193
G3 X131.759 Y113.434 I2.42 J1.576 E.01816
G2 X132.543 Y112.049 I-1.505 J-1.766 E.03369
G1 X128.838 Y112.049 E.07684
G3 X128.324 Y112.979 I-2.862 J-.974 E.02215
G2 X127.363 Y114.084 I4.182 J4.607 E.03047
G1 X123.895 Y114.084 E.07193
G3 X124.476 Y113.434 I2.42 J1.576 E.01816
G2 X125.259 Y112.049 I-1.505 J-1.766 E.03369
G1 X123.562 Y112.049 E.0352
; WIPE_START
G1 X125.259 Y112.049 E-.64486
G1 X125.187 Y112.343 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.209 Y117.088 Z7.8 F60000
G1 X116.532 Y119.214 Z7.8
G1 Z7.4
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.1 Y120.813 E.0352
G2 X117.859 Y119.807 I-2.96 J-3.024 E.02625
G2 X116.958 Y117.075 I-2.342 J-.741 E.06373
G3 X116.751 Y113.889 I1.412 J-1.692 E.07408
G2 X117.859 Y112.523 I-3.582 J-4.039 E.03664
G2 X117.976 Y112.049 I-.993 J-.497 E.01023
G1 X121.555 Y112.049 E.07423
G3 X120.599 Y113.434 I-3.021 J-1.061 E.03532
G2 X120.08 Y114.084 I1.205 J1.495 E.01741
G1 X118.92 Y114.084 E.02405
G1 X121.002 Y120.302 E.13601
G2 X119.933 Y121.627 I3.499 J3.917 E.03547
G2 X120.834 Y124.359 I2.342 J.741 E.06373
G3 X121.041 Y127.545 I-1.412 J1.692 E.07408
G2 X119.958 Y128.867 I3.597 J4.053 E.0356
G1 X121.014 Y131.841 E.06547
G3 X121.617 Y133.541 I-1.455 J1.473 E.03871
G1 X122.184 Y135.14 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X121.617 Y133.541 E-.64486
G1 X121.617 Y133.238 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L62
M991 S0 P61 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.8 I1.184 J.282 P1  F60000
G1 X123.325 Y126.079 Z7.8
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z7.92 F60000
G1 X119.605 Y114.987 Z7.92
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z7.92 F60000
G1 X141.28 Y114.497 Z7.92
G1 Z7.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.258 Y115.697 Z7.92 F60000
G1 Z7.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.729 Y117.309 E.0352
G3 X136.227 Y118.441 I-1.446 J1.311 E.0261
G3 X135.041 Y120.717 I-2.788 J-.005 E.05532
G2 X134.34 Y122.083 I1.428 J1.597 E.03257
G2 X135.525 Y124.359 I2.788 J-.005 E.05532
G3 X135.87 Y127.09 I-1.413 J1.566 E.06221
G3 X134.644 Y128.455 I-24.796 J-21.039 E.03808
G2 X135.111 Y131.238 I1.99 J1.096 E.06314
G1 X137.984 Y122.923 E.18246
G3 X138.504 Y121.419 I2.168 J-.093 E.03381
G1 X139.617 Y118.2 E.07064
G2 X138.683 Y117.075 I-3.492 J1.95 E.03049
G3 X137.981 Y115.71 I1.428 J-1.597 E.03257
G3 X139.167 Y113.434 I2.788 J.005 E.05532
G2 X139.867 Y112.049 I-1.274 J-1.514 E.03309
G1 X136.098 Y112.049 E.07819
G3 X135.507 Y112.979 I-3.047 J-1.283 E.02296
G2 X134.548 Y114.084 I2.87 J3.46 E.03051
G1 X131.262 Y114.084 E.06816
G3 X131.884 Y113.434 I2.919 J2.168 E.01872
G2 X132.584 Y112.049 I-1.274 J-1.514 E.03309
G1 X128.815 Y112.049 E.07819
G3 X128.224 Y112.979 I-3.047 J-1.282 E.02296
G2 X127.265 Y114.084 I2.87 J3.46 E.03051
G1 X123.979 Y114.084 E.06816
G3 X124.6 Y113.434 I2.919 J2.167 E.01872
G2 X125.301 Y112.049 I-1.274 J-1.514 E.03309
G1 X123.604 Y112.049 E.0352
; WIPE_START
G1 X125.301 Y112.049 E-.64486
G1 X125.251 Y112.348 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.292 Y117.116 Z7.92 F60000
G1 X116.563 Y119.3 Z7.92
G1 Z7.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.13 Y120.9 E.0352
G2 X117.938 Y119.807 I-2.278 J-2.529 E.02838
G2 X117.299 Y117.531 I-2.323 J-.576 E.05129
G3 X116.212 Y116.165 I2.534 J-3.133 E.03649
G3 X116.851 Y113.889 I2.323 J-.576 E.05129
G2 X117.938 Y112.523 I-2.534 J-3.133 E.03649
G2 X118.018 Y112.049 I-1.016 J-.415 E.01007
G1 X121.532 Y112.049 E.07288
G3 X120.475 Y113.434 I-3.469 J-1.551 E.03646
G2 X119.981 Y114.084 I.966 J1.246 E.01714
G1 X118.92 Y114.084 E.02201
G1 X120.975 Y120.22 E.1342
G2 X120.077 Y121.172 I13.647 J13.755 E.02715
G2 X120.493 Y123.903 I1.95 J1.101 E.06175
G3 X121.58 Y125.269 I-2.534 J3.133 E.03649
G3 X120.941 Y127.545 I-2.323 J.576 E.05129
G2 X119.923 Y128.769 I2.597 J3.194 E.03323
G1 X120.934 Y131.618 E.0627
G3 X121.619 Y133.546 I-1.254 J1.531 E.04461
G1 X122.186 Y135.145 E.0352
; WIPE_START
G1 X121.619 Y133.546 E-.64486
G1 X121.642 Y133.244 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.62 Y136.337 Z7.92 F60000
G1 X132.721 Y138.154 Z7.92
G1 Z7.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X132.167 Y139.758 E.0352
G2 X131.4 Y138.925 I-3.725 J2.66 E.02356
G3 X130.698 Y137.559 I1.428 J-1.597 E.03257
G3 X131.884 Y135.283 I2.788 J.005 E.05532
G2 X132.229 Y132.552 I-1.413 J-1.566 E.06221
G2 X131.113 Y131.313 I-18.59 J15.623 E.03459
G1 X128.642 Y138.742 E.1624
G1 X128.055 Y138.742 E.01217
G1 X128.242 Y138.925 E.00541
G3 X128.944 Y140.29 I-1.428 J1.597 E.03257
G3 X127.758 Y142.566 I-2.788 J-.005 E.05532
G2 X127.057 Y143.951 I1.274 J1.514 E.03308
G1 X125.312 Y143.951 E.03621
G1 X124.757 Y142.388 E.03442
G2 X125.302 Y141.201 I-1.423 J-1.373 E.02761
G2 X124.117 Y138.925 I-2.788 J.005 E.05532
G3 X123.415 Y137.559 I1.428 J-1.597 E.03257
M73 P69 R7
G3 X124.6 Y135.283 I2.788 J.005 E.05532
G2 X125.302 Y133.918 I-1.428 J-1.597 E.03257
G2 X124.117 Y131.642 I-2.788 J.005 E.05532
G3 X123.851 Y128.81 I1.416 J-1.561 E.06474
G1 X122.643 Y125.178 E.07941
G1 X124.873 Y125.178 E.04625
G2 X124.117 Y124.359 I-3.663 J2.622 E.02319
G3 X123.578 Y122.022 I1.343 J-1.54 E.05315
G1 X127.067 Y122.022 E.07237
G2 X127.776 Y123.903 I2.437 J.156 E.04298
G3 X128.818 Y125.178 I-2.556 J3.154 E.03439
G1 X132.156 Y125.178 E.06923
G2 X131.4 Y124.359 I-3.663 J2.622 E.02319
G3 X130.861 Y122.022 I1.343 J-1.54 E.05315
G1 X129.164 Y122.022 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.861 Y122.022 E-.64486
G1 X130.781 Y122.314 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L63
M991 S0 P62 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z7.92 I-.549 J-1.086 P1  F60000
G1 X123.325 Y126.079 Z7.92
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.04 F60000
G1 X119.605 Y114.987 Z8.04
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.04 F60000
G1 X141.28 Y114.497 Z8.04
G1 Z7.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
M73 P69 R6
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.294 Y115.588 Z8.04 F60000
G1 Z7.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.765 Y117.201 E.0352
G1 X136.046 Y117.531 E.00899
G3 X135.813 Y119.807 I-2.002 J.945 E.04987
G2 X134.521 Y121.172 I45.037 J43.91 E.039
G2 X134.754 Y123.448 I2.001 J.945 E.04987
G3 X136.046 Y124.814 I-45.085 J43.955 E.039
G3 X135.813 Y127.09 I-2.002 J.945 E.04987
G2 X134.521 Y128.455 I45.015 J43.889 E.039
G2 X135.138 Y131.161 I2.103 J.943 E.06177
G1 X137.937 Y123.06 E.17779
G3 X138.455 Y121.56 I2.502 J.025 E.03349
G1 X139.602 Y118.243 E.07281
G2 X138.55 Y117.075 I-3.893 J2.452 E.03275
G3 X137.986 Y115.255 I1.214 J-1.373 E.04157
G3 X139.3 Y113.434 I3.691 J1.278 E.04723
G2 X139.916 Y112.049 I-1.075 J-1.308 E.03261
G1 X136.081 Y112.049 E.07956
G3 X135.406 Y112.979 I-3.207 J-1.617 E.02394
G2 X134.44 Y114.084 I2.033 J2.751 E.03069
G1 X131.344 Y114.084 E.06421
G3 X132.017 Y113.434 I3.563 J3.009 E.01944
G2 X132.633 Y112.049 I-1.075 J-1.308 E.03261
G1 X128.797 Y112.049 E.07956
G3 X128.123 Y112.979 I-3.207 J-1.617 E.02394
G2 X127.157 Y114.084 I2.034 J2.751 E.03069
G1 X124.061 Y114.084 E.06421
G3 X124.734 Y113.434 I3.563 J3.009 E.01944
G2 X125.35 Y112.049 I-1.075 J-1.308 E.03261
G1 X123.653 Y112.049 E.0352
; WIPE_START
G1 X125.35 Y112.049 E-.64486
G1 X125.324 Y112.351 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.38 Y117.138 Z8.04 F60000
G1 X116.592 Y119.384 Z8.04
G1 Z7.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.16 Y120.983 E.0352
G2 X118.026 Y119.807 I-1.72 J-2.173 E.03066
G2 X117.198 Y117.531 I-2.484 J-.385 E.05241
G3 X116.125 Y116.165 I1.819 J-2.534 E.03651
G3 X116.953 Y113.889 I2.484 J-.385 E.05241
G2 X118.026 Y112.523 I-1.819 J-2.534 E.03651
G2 X118.067 Y112.049 I-1.059 J-.331 E.00996
G1 X121.514 Y112.049 E.07151
G3 X120.342 Y113.434 I-3.964 J-2.166 E.0379
G2 X119.874 Y114.084 I.767 J1.046 E.0169
G1 X118.92 Y114.084 E.01977
G1 X120.948 Y120.14 E.13247
G2 X119.954 Y121.172 I10.478 J11.086 E.02972
G2 X120.594 Y123.903 I2.121 J.944 E.06248
G3 X121.667 Y125.269 I-1.819 J2.533 E.03651
G3 X120.84 Y127.545 I-2.484 J.385 E.05241
G2 X119.878 Y128.641 I2.061 J2.779 E.03047
G1 X120.871 Y131.44 E.0616
G3 X121.667 Y132.552 I-1.708 J2.064 E.02869
G3 X121.624 Y133.56 I-2.465 J.398 E.02107
G1 X122.191 Y135.159 E.0352
; WIPE_START
G1 X121.624 Y133.56 E-.64486
G1 X121.671 Y133.261 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.255 Y137.12 Z8.04 F60000
G1 X129.03 Y137.575 Z8.04
G1 Z7.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.642 Y138.742 E.02553
G1 X128.176 Y138.742 E.00967
G3 X128.938 Y140.746 I-1.099 J1.565 E.0472
G3 X127.625 Y142.566 I-3.691 J-1.278 E.04723
G2 X127.009 Y143.951 I1.075 J1.308 E.0326
G1 X125.312 Y143.951 E.0352
G1 X124.795 Y142.495 E.03206
G1 X125.121 Y142.111 E.01045
G2 X124.888 Y139.835 I-2.001 J-.945 E.04987
G3 X123.596 Y138.47 I45.04 J-43.912 E.039
G3 X123.829 Y136.194 I2.001 J-.945 E.04987
G2 X125.121 Y134.828 I-45.061 J-43.932 E.039
G2 X124.888 Y132.552 I-2.001 J-.945 E.04987
G3 X123.596 Y131.186 I45.085 J-43.955 E.039
G3 X123.87 Y128.865 I1.994 J-.942 E.0511
G1 X122.643 Y125.178 E.0806
G1 X124.807 Y125.178 E.04487
G2 X123.983 Y124.359 I-4.476 J3.673 E.02413
G3 X123.602 Y122.022 I1.381 J-1.425 E.05262
G1 X127.012 Y122.022 E.07073
G2 X127.878 Y123.903 I2.577 J-.046 E.0442
G3 X128.913 Y125.178 I-1.829 J2.544 E.03446
G1 X127.216 Y125.178 E.0352
M204 S10000
G1 X129.188 Y122.022 F60000
G1 F9000
M204 S4000
G1 X130.885 Y122.022 E.0352
G2 X130.879 Y123.903 I1.934 J.947 E.04038
G2 X132.09 Y125.178 I32.073 J-29.256 E.03647
G1 X133.153 Y125.178 E.02206
G1 X132.622 Y126.774 E.0349
G3 X132.341 Y127.619 I-1.759 J-.116 E.01866
G1 X131.077 Y131.419 E.08308
G2 X131.764 Y132.097 I3.047 J-2.403 E.02006
G3 X132.592 Y134.373 I-1.656 J1.891 E.05241
G3 X131.519 Y135.738 I-2.892 J-1.168 E.03651
G2 X130.879 Y138.47 I1.48 J1.788 E.06248
G2 X132.149 Y139.811 I41.909 J-38.424 E.03831
G1 X132.703 Y138.207 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.149 Y139.811 E-.64486
G1 X131.941 Y139.591 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L64
M991 S0 P63 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.04 I1.026 J-.654 P1  F60000
G1 X123.325 Y126.079 Z8.04
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.16 F60000
G1 X119.605 Y114.987 Z8.16
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.16 F60000
G1 X141.28 Y114.497 Z8.16
G1 Z7.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
M73 P70 R6
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.335 Y115.463 Z8.16 F60000
G1 Z7.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.806 Y117.075 E.0352
G1 X136.183 Y117.531 E.01227
G3 X135.759 Y119.807 I-2.158 J.775 E.05034
G2 X134.513 Y121.015 I3.66 J5.019 E.03612
G2 X134.808 Y123.448 I1.864 J1.009 E.05421
G3 X136.183 Y124.814 I-4.151 J5.559 E.04034
G3 X135.759 Y127.09 I-2.158 J.775 E.05034
G2 X134.383 Y128.455 I4.152 J5.559 E.04034
G2 X135.172 Y131.063 I2.119 J.782 E.06066
G1 X137.875 Y123.239 E.17171
G3 X138.414 Y121.68 I2.361 J-.056 E.03494
G1 X139.591 Y118.273 E.07478
G1 X139.4 Y117.986 E.00715
G3 X138.025 Y116.62 I4.152 J-5.559 E.04034
G3 X138.449 Y114.344 I2.158 J-.775 E.05034
G1 X139.448 Y113.434 E.02804
G2 X139.972 Y112.049 I-.908 J-1.136 E.03223
G1 X136.069 Y112.049 E.08096
G3 X135.759 Y112.523 I-1.294 J-.507 E.01185
G2 X134.383 Y113.889 I4.152 J5.559 E.04034
G1 X134.32 Y114.084 E.00426
G1 X131.451 Y114.084 E.0595
G1 X132.165 Y113.434 E.02004
G2 X132.689 Y112.049 I-.908 J-1.136 E.03223
G1 X128.786 Y112.049 E.08096
G3 X128.476 Y112.523 I-1.294 J-.507 E.01185
G2 X127.1 Y113.889 I4.151 J5.558 E.04034
G1 X127.037 Y114.084 E.00426
G1 X124.168 Y114.084 E.0595
G1 X124.882 Y113.434 E.02004
G2 X125.406 Y112.049 I-.908 J-1.136 E.03223
G1 X123.709 Y112.049 E.0352
; WIPE_START
G1 X125.406 Y112.049 E-.64486
G1 X125.406 Y112.352 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.483 Y117.165 Z8.16 F60000
G1 X116.628 Y119.485 Z8.16
G1 Z7.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.196 Y121.084 E.0352
G2 X117.976 Y120.262 I-2.525 J-3.175 E.02358
G2 X117.551 Y117.986 I-2.158 J-.775 E.05034
G3 X116.175 Y116.62 I4.151 J-5.559 E.04034
G3 X116.6 Y114.344 I2.158 J-.775 E.05034
G2 X117.976 Y112.979 I-4.152 J-5.559 E.04034
G2 X118.123 Y112.049 I-1.973 J-.79 E.01969
G1 X121.503 Y112.049 E.07011
G3 X121.193 Y112.523 I-1.294 J-.507 E.01185
G2 X119.817 Y113.889 I4.152 J5.559 E.04034
G1 X119.753 Y114.084 E.00426
G1 X118.92 Y114.084 E.01728
G1 X120.92 Y120.055 E.13061
G2 X119.817 Y121.172 I3.406 J4.467 E.03266
G2 X120.241 Y123.448 I2.158 J.775 E.05034
G3 X121.617 Y124.814 I-4.152 J5.559 E.04034
G3 X121.193 Y127.09 I-2.158 J.775 E.05034
G2 X119.814 Y128.462 I4.817 J6.214 E.04045
G1 X120.801 Y131.241 E.06116
G3 X121.617 Y132.097 I-2.625 J3.322 E.02462
G3 X121.631 Y133.58 I-1.629 J.756 E.03171
G1 X122.198 Y135.179 E.0352
; WIPE_START
G1 X121.631 Y133.58 E-.64486
G1 X121.702 Y133.285 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.354 Y137.028 Z8.16 F60000
G1 X129.077 Y137.435 Z8.16
G1 Z7.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.642 Y138.742 E.02859
G1 X128.323 Y138.742 E.00661
G3 X128.9 Y139.38 I-1.971 J2.364 E.0179
G3 X128.476 Y141.656 I-2.158 J.775 E.05034
G1 X127.477 Y142.566 E.02804
G2 X126.952 Y143.951 I.908 J1.136 E.03223
G1 X125.312 Y143.951 E.03403
G1 X124.835 Y142.609 E.02955
G2 X125.259 Y142.111 I-1.551 J-1.749 E.0136
G2 X124.834 Y139.835 I-2.158 J-.775 E.05034
G3 X123.458 Y138.47 I4.152 J-5.559 E.04034
G3 X123.883 Y136.194 I2.158 J-.775 E.05034
G2 X125.259 Y134.828 I-4.152 J-5.559 E.04034
G2 X124.834 Y132.552 I-2.158 J-.775 E.05034
G3 X123.458 Y131.186 I4.152 J-5.559 E.04034
G3 X123.884 Y128.909 I2.198 J-.767 E.0503
G1 X122.643 Y125.178 E.08157
G1 X124.734 Y125.178 E.04337
G1 X123.835 Y124.359 E.02523
G3 X123.62 Y122.022 I1.284 J-1.296 E.05286
G1 X126.949 Y122.022 E.06904
G2 X127.524 Y123.448 I2.491 J-.176 E.03242
G1 X128.523 Y124.359 E.02804
G3 X129.018 Y125.178 I-.783 J1.032 E.02034
G1 X127.321 Y125.178 E.0352
M204 S10000
G1 X129.206 Y122.022 F60000
G1 F9000
M204 S4000
G1 X130.903 Y122.022 E.0352
G2 X130.741 Y123.903 I1.922 J1.113 E.04045
G2 X132.017 Y125.178 I5.155 J-3.885 E.03753
G1 X133.153 Y125.178 E.02356
G1 X132.684 Y126.588 E.03083
G3 X132.248 Y127.9 I-1.324 J.288 E.03009
G1 X131.036 Y131.543 E.07962
G1 X132.117 Y132.552 E.03068
G3 X132.542 Y134.828 I-1.734 J1.501 E.05034
G3 X131.166 Y136.194 I-5.528 J-4.194 E.04034
G2 X130.741 Y138.47 I1.734 J1.501 E.05034
G2 X132.117 Y139.835 I5.527 J-4.193 E.04034
G1 X132.687 Y138.254 E.03485
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.117 Y139.835 E-.63852
G1 X131.881 Y139.62 E-.12148
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L65
M991 S0 P64 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.16 I1.029 J-.65 P1  F60000
G1 X123.325 Y126.079 Z8.16
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.28 F60000
G1 X119.605 Y114.987 Z8.28
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.28 F60000
G1 X141.28 Y114.497 Z8.28
G1 Z7.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.372 Y115.351 Z8.28 F60000
G1 Z7.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.843 Y116.964 E.0352
G3 X136.342 Y117.531 I-1.03 J1.41 E.01579
G3 X135.708 Y119.807 I-2.394 J.56 E.05112
G1 X134.62 Y120.69 E.02907
G1 X134.16 Y122.022 E.02924
G2 X134.858 Y123.448 I2.612 J-.395 E.03345
G1 X135.98 Y124.359 E.02997
G1 X136.342 Y124.814 E.01206
G3 X135.708 Y127.09 I-2.394 J.56 E.05112
G1 X134.586 Y128 E.02997
G1 X134.225 Y128.455 E.01206
G2 X135.193 Y131.003 I2.355 J.563 E.06003
G1 X137.781 Y123.511 E.16441
G3 X138.376 Y121.79 I2.591 J-.068 E.0386
G1 X139.584 Y118.293 E.07673
G1 X139.35 Y117.986 E.00802
G1 X138.228 Y117.075 E.02997
G1 X137.866 Y116.62 E.01206
G3 X138.5 Y114.344 I2.394 J-.56 E.05112
G1 X139.622 Y113.434 E.02997
G2 X140.037 Y112.049 I-.87 J-1.016 E.03169
G1 X136.065 Y112.049 E.08239
G3 X135.708 Y112.523 I-1.322 J-.622 E.0124
G1 X134.586 Y113.434 E.02997
G1 X134.225 Y113.889 E.01206
G1 X134.182 Y114.084 E.00415
G1 X131.537 Y114.084 E.05487
G1 X132.339 Y113.434 E.02142
G2 X132.754 Y112.049 I-.87 J-1.016 E.03169
G1 X128.782 Y112.049 E.08239
G3 X128.425 Y112.523 I-1.322 J-.622 E.0124
G1 X127.303 Y113.434 E.02997
G1 X126.941 Y113.889 E.01206
G1 X126.899 Y114.084 E.00415
G1 X124.254 Y114.084 E.05487
G1 X125.056 Y113.434 E.02142
G2 X125.471 Y112.049 I-.87 J-1.016 E.03169
G1 X123.774 Y112.049 E.0352
; WIPE_START
G1 X125.471 Y112.049 E-.64486
G1 X125.499 Y112.35 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.585 Y117.175 Z8.28 F60000
G1 X116.656 Y119.563 Z8.28
G1 Z7.88
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.224 Y121.162 E.0352
G2 X118.134 Y120.262 I-1.577 J-2.504 E.02677
G2 X117.5 Y117.986 I-2.394 J-.56 E.05112
G1 X116.378 Y117.075 E.02997
G3 X115.958 Y115.71 I.964 J-1.044 E.03105
G3 X116.651 Y114.344 I2.953 J.64 E.03211
G1 X117.773 Y113.434 E.02997
G2 X118.188 Y112.049 I-.87 J-1.016 E.03169
G1 X121.499 Y112.049 E.06868
G3 X121.142 Y112.523 I-1.322 J-.622 E.0124
G1 X120.02 Y113.434 E.02997
G1 X119.658 Y113.889 E.01206
G1 X119.616 Y114.084 E.00415
G1 X118.92 Y114.084 E.01443
G1 X120.902 Y120.002 E.12943
G1 X120.02 Y120.717 E.02355
G2 X119.599 Y122.083 I.964 J1.044 E.03105
G2 X120.292 Y123.448 I2.953 J-.64 E.03211
G1 X121.414 Y124.359 E.02997
G3 X121.835 Y125.724 I-.964 J1.044 E.03106
G3 X121.142 Y127.09 I-2.953 J-.64 E.03211
G1 X120.02 Y128 E.02997
G1 X119.765 Y128.322 E.00851
G1 X120.752 Y131.105 E.06126
G3 X121.776 Y132.097 I-1.727 J2.805 E.0298
G3 X121.639 Y133.604 I-1.863 J.592 E.03224
G1 X122.207 Y135.204 E.0352
; WIPE_START
G1 X121.639 Y133.604 E-.64486
G1 X121.734 Y133.316 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.455 Y136.933 Z8.28 F60000
G1 X129.124 Y137.293 Z8.28
G1 Z7.88
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.642 Y138.742 E.03168
M73 P71 R6
G1 X128.472 Y138.742 E.00352
G3 X129.059 Y139.38 I-1.145 J1.641 E.01811
G3 X128.425 Y141.656 I-2.394 J.56 E.05112
G1 X127.303 Y142.566 E.02997
G2 X126.888 Y143.951 I.871 J1.016 E.03168
G1 X125.312 Y143.951 E.03269
G1 X124.873 Y142.715 E.02722
G2 X125.417 Y142.111 I-1.09 J-1.53 E.01699
G2 X124.783 Y139.835 I-2.394 J-.56 E.05112
G1 X123.661 Y138.925 E.02997
G3 X123.202 Y138.008 I1.109 J-1.129 E.02167
G3 X123.934 Y136.194 I2.661 J.018 E.04154
G1 X125.056 Y135.283 E.02997
G1 X125.417 Y134.828 E.01206
G2 X124.783 Y132.552 I-2.394 J-.56 E.05112
G1 X123.661 Y131.642 E.02997
G1 X123.3 Y131.186 E.01206
G3 X123.9 Y128.955 I2.368 J-.56 E.04994
G1 X122.643 Y125.178 E.08257
G1 X124.671 Y125.178 E.04206
G1 X123.661 Y124.359 E.02697
G1 X123.3 Y123.903 E.01206
G3 X123.632 Y122.022 I2.32 J-.56 E.04077
G1 X126.877 Y122.022 E.0673
G2 X127.575 Y123.448 I2.612 J-.395 E.03345
G1 X128.697 Y124.359 E.02997
G1 X129.059 Y124.814 E.01206
G1 X129.137 Y125.178 E.00773
G1 X127.44 Y125.178 E.0352
M204 S10000
G1 X129.219 Y122.022 F60000
G1 F9000
M204 S4000
G1 X130.916 Y122.022 E.0352
G2 X130.524 Y122.993 I2.786 J1.688 E.02181
G2 X130.944 Y124.359 I1.384 J.321 E.03106
G1 X131.954 Y125.178 E.02697
G1 X133.153 Y125.178 E.02487
G1 X132.718 Y126.486 E.0286
G3 X132.169 Y128.138 I-1.353 J.467 E.03882
G1 X130.991 Y131.679 E.07741
G1 X132.067 Y132.552 E.02873
G3 X132.759 Y133.918 I-2.26 J2.005 E.03211
G3 X132.339 Y135.283 I-1.384 J.321 E.03105
G1 X131.217 Y136.194 E.02997
G2 X130.524 Y137.559 I2.26 J2.005 E.03211
G2 X130.944 Y138.925 I1.384 J.321 E.03106
G1 X132.118 Y139.902 E.03167
G1 X132.672 Y138.298 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.118 Y139.902 E-.64486
G1 X131.885 Y139.708 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L66
M991 S0 P65 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.28 I1.031 J-.647 P1  F60000
G1 X123.325 Y126.079 Z8.28
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.4 F60000
G1 X119.605 Y114.987 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.4 F60000
G1 X141.28 Y114.497 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.409 Y115.237 Z8.4 F60000
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X135.88 Y116.85 E.0352
G3 X136.531 Y117.531 I-.667 J1.289 E.0199
G3 X135.66 Y119.807 I-2.724 J.262 E.05239
G1 X134.685 Y120.493 E.02473
G1 X134.183 Y122.022 E.03339
G1 X134.112 Y122.022 E.00146
G2 X134.907 Y123.448 I2.656 J-.545 E.03439
G1 X136.201 Y124.359 E.03282
G1 X136.531 Y124.814 E.01166
G3 X135.66 Y127.09 I-2.724 J.262 E.05239
G1 X134.365 Y128 E.03282
G1 X134.036 Y128.455 E.01166
G2 X135.212 Y130.946 I2.707 J.245 E.05992
G1 X137.672 Y123.828 E.15621
G1 X137.644 Y123.448 E.00791
G3 X138.356 Y121.848 I2.935 J.347 E.03688
G1 X139.58 Y118.306 E.07774
G1 X139.301 Y117.986 E.0088
G1 X138.007 Y117.075 E.03282
G1 X137.677 Y116.62 E.01166
G3 X138.548 Y114.344 I2.724 J-.262 E.05239
G1 X139.842 Y113.434 E.03282
G2 X140.074 Y112.049 I-.831 J-.85 E.03116
G1 X136.067 Y112.049 E.0831
G3 X135.66 Y112.523 I-1.343 J-.74 E.01307
G1 X134.365 Y113.434 E.03282
G1 X134.036 Y113.889 E.01166
G1 X134.021 Y114.084 E.00406
G1 X131.634 Y114.084 E.04952
G1 X132.559 Y113.434 E.02346
G2 X132.791 Y112.049 I-.831 J-.85 E.03116
G1 X128.784 Y112.049 E.0831
G3 X128.377 Y112.523 I-1.343 J-.74 E.01307
G1 X127.082 Y113.434 E.03282
G1 X126.752 Y113.889 E.01166
G1 X126.738 Y114.084 E.00406
G1 X124.351 Y114.084 E.04952
G1 X125.276 Y113.434 E.02346
G2 X125.507 Y112.049 I-.831 J-.85 E.03116
G1 X123.81 Y112.049 E.0352
; WIPE_START
G1 X125.507 Y112.049 E-.64486
G1 X125.588 Y112.341 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.048 Y118.476 Z8.4 F60000
G1 X117.818 Y122.838 Z8.4
G1 Z8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.251 Y121.239 E.0352
G1 X117.993 Y120.717 E.01882
G1 X118.323 Y120.262 E.01166
G1 X118.356 Y119.807 E.00947
G2 X117.452 Y117.986 I-3.088 J.398 E.04295
G1 X116.158 Y117.075 E.03282
G1 X115.828 Y116.62 E.01166
G1 X115.795 Y116.165 E.00947
G3 X116.699 Y114.344 I3.088 J.398 E.04295
G1 X117.993 Y113.434 E.03282
G1 X118.323 Y112.979 E.01166
G2 X118.224 Y112.049 I-1.357 J-.326 E.01978
G1 X121.501 Y112.049 E.06797
G3 X121.094 Y112.523 I-1.343 J-.74 E.01307
G1 X119.799 Y113.434 E.03282
G1 X119.469 Y113.889 E.01166
G1 X119.455 Y114.084 E.00406
G1 X118.92 Y114.084 E.01109
G1 X120.885 Y119.953 E.12837
G1 X119.799 Y120.717 E.02754
G1 X119.469 Y121.172 E.01166
G1 X119.437 Y121.627 E.00947
G2 X120.34 Y123.448 I3.087 J-.398 E.04295
G1 X121.635 Y124.359 E.03282
G1 X121.965 Y124.814 E.01166
G1 X121.997 Y125.269 E.00947
G3 X121.094 Y127.09 I-3.087 J-.398 E.04295
G1 X119.799 Y128 E.03282
G1 X119.699 Y128.138 E.00353
G1 X120.713 Y130.993 E.06285
G1 X121.635 Y131.642 E.02338
G1 X121.965 Y132.097 E.01166
G1 X121.997 Y132.552 E.00947
G1 X121.65 Y133.633 E.02355
G1 X122.217 Y135.232 E.0352
; WIPE_START
G1 X121.65 Y133.633 E-.64486
G1 X121.742 Y133.345 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.547 Y136.801 Z8.4 F60000
G1 X129.181 Y137.123 Z8.4
G1 Z8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.645 Y138.733 E.0352
G3 X129.248 Y139.38 I-.641 J1.202 E.01868
G3 X128.377 Y141.656 I-2.724 J.262 E.05239
G1 X127.082 Y142.566 E.03282
G2 X126.851 Y143.951 I.83 J.85 E.03116
G1 X125.312 Y143.951 E.03193
G1 X124.911 Y142.823 E.02483
G2 X125.606 Y142.111 I-.69 J-1.368 E.02102
G2 X124.735 Y139.835 I-2.724 J-.262 E.05239
G1 X123.557 Y139.006 E.02989
G1 X123.134 Y137.814 E.02624
G3 X123.982 Y136.194 I2.855 J.462 E.0386
G1 X125.276 Y135.283 E.03282
G1 X125.606 Y134.828 E.01166
G2 X124.735 Y132.552 I-2.724 J-.262 E.05239
G1 X123.441 Y131.642 E.03282
G1 X123.111 Y131.186 E.01166
G3 X123.912 Y128.991 I2.607 J-.293 E.05023
G1 X122.643 Y125.178 E.08336
G1 X124.606 Y125.178 E.04071
G1 X123.441 Y124.359 E.02954
G1 X123.111 Y123.903 E.01166
G1 X123.078 Y123.448 E.00947
G3 X123.638 Y122.022 I3.23 J.445 E.03208
G1 X126.829 Y122.022 E.06619
G2 X127.623 Y123.448 I2.656 J-.545 E.03439
G1 X128.918 Y124.359 E.03282
G1 X129.248 Y124.814 E.01166
G1 X129.274 Y125.178 E.00757
G1 X127.577 Y125.178 E.0352
M204 S10000
G1 X129.224 Y122.022 F60000
G1 F9000
M204 S4000
G1 X130.921 Y122.022 E.0352
G2 X130.361 Y123.448 I2.67 J1.871 E.03208
G1 X130.394 Y123.903 E.00947
G1 X130.724 Y124.359 E.01166
G1 X131.889 Y125.178 E.02954
G1 X133.153 Y125.178 E.02622
G1 X132.738 Y126.426 E.02727
G3 X132.889 Y127.545 I-1.498 J.772 E.02389
G3 X132.109 Y128.317 I-1.515 J-.751 E.02318
G1 X130.95 Y131.801 E.07616
G1 X132.018 Y132.552 E.02708
G3 X132.922 Y134.373 I-2.184 J2.218 E.04295
G1 X132.889 Y134.828 E.00947
G1 X132.559 Y135.283 E.01166
G1 X131.265 Y136.194 E.03282
G2 X130.361 Y138.014 I2.184 J2.218 E.04295
G1 X130.394 Y138.47 E.00947
G1 X130.724 Y138.925 E.01166
G1 X132.106 Y139.936 E.03552
G1 X132.66 Y138.332 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.106 Y139.936 E-.64486
G1 X131.861 Y139.757 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L67
M991 S0 P66 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.4 I1.032 J-.644 P1  F60000
G1 X123.325 Y126.079 Z8.4
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.52 F60000
G1 X119.605 Y114.987 Z8.52
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.52 F60000
G1 X141.28 Y114.497 Z8.52
G1 Z8.12
M73 P72 R6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.507 Y115.623 Z8.52 F60000
G1 Z8.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.039 Y114.084 E.03376
G1 X141.108 Y114.084 E.00144
G1 X141.08 Y113.889 E.0041
G1 X141.296 Y113.476 E.00966
G1 X141.296 Y112.049 E.02961
G1 X140.165 Y112.049 E.02345
G3 X140.411 Y112.979 I-1.942 J1.011 E.02012
G1 X140.173 Y113.434 E.01065
G2 X138.143 Y114.799 I2.587 J6.038 E.05105
G2 X137.439 Y116.62 I3.779 J2.509 E.04081
G1 X137.676 Y117.075 E.01065
G3 X139.578 Y118.311 I-2.683 J6.21 E.04727
G1 X138.346 Y121.878 E.07828
G2 X137.439 Y123.903 I2.321 J2.255 E.04698
G1 X137.563 Y124.142 E.00559
G1 X135.227 Y130.904 E.14839
G3 X133.797 Y128.455 I1.769 J-2.675 E.06092
G1 X134.035 Y128 E.01065
G2 X136.065 Y126.635 I-2.586 J-6.037 E.05105
G2 X136.769 Y124.814 I-3.78 J-2.509 E.04081
G1 X136.532 Y124.359 E.01065
G3 X134.501 Y122.993 I2.586 J-6.037 E.05105
G3 X134.012 Y122.022 I2.059 J-1.646 E.02271
G1 X134.183 Y122.022 E.00353
G1 X134.733 Y120.346 E.0366
G2 X136.065 Y119.351 I-2.445 J-4.666 E.03462
G2 X136.769 Y117.531 I-3.78 J-2.509 E.04082
G1 X136.532 Y117.075 E.01065
G1 X135.914 Y116.747 E.01452
G1 X136.443 Y115.134 E.0352
M204 S10000
G1 X137.775 Y112.049 F60000
G1 F9000
M204 S4000
G1 X136.065 Y112.068 E.03546
G3 X134.035 Y113.434 I-4.617 J-4.671 E.05105
G1 X133.797 Y113.889 E.01065
G1 X133.825 Y114.084 E.0041
G1 X131.724 Y114.084 E.04358
G3 X132.89 Y113.434 I5.073 J7.722 E.02772
G1 X133.128 Y112.979 E.01065
G2 X132.882 Y112.049 I-2.187 J.081 E.02012
G1 X128.782 Y112.068 E.08505
G3 X126.752 Y113.434 I-4.617 J-4.672 E.05105
G1 X126.514 Y113.889 E.01065
G1 X126.542 Y114.084 E.0041
G1 X124.441 Y114.084 E.04358
G3 X125.607 Y113.434 I5.073 J7.722 E.02772
G1 X125.845 Y112.979 E.01065
G2 X125.599 Y112.049 I-2.188 J.081 E.02012
G1 X123.902 Y112.049 E.0352
; WIPE_START
G1 X125.599 Y112.049 E-.64486
G1 X125.707 Y112.332 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.31 Y119.507 Z8.52 F60000
G1 X129.223 Y122.022 Z8.52
G1 Z8.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.92 Y122.022 E.0352
G2 X130.155 Y123.903 I2.518 J2.119 E.04282
G1 X130.393 Y124.359 E.01065
G3 X131.828 Y125.178 I-4.937 J10.309 E.03429
G1 X129.434 Y125.178 E.04964
G1 X129.486 Y124.814 E.00763
G1 X129.249 Y124.359 E.01065
G3 X127.218 Y122.993 I2.586 J-6.037 E.05105
G3 X126.729 Y122.022 I2.059 J-1.646 E.02271
G1 X123.637 Y122.022 E.06415
G2 X122.872 Y123.903 I2.518 J2.119 E.04282
G1 X123.11 Y124.359 E.01065
G3 X124.544 Y125.178 I-4.938 J10.31 E.03429
G1 X122.643 Y125.178 E.03943
G1 X123.921 Y129.019 E.08396
G2 X122.872 Y131.186 I2.198 J2.4 E.05116
G1 X123.11 Y131.642 E.01065
G3 X125.14 Y133.007 I-2.586 J6.037 E.05105
G1 X125.362 Y133.352 E.00849
G1 X125.839 Y134.786 E.03135
G1 X125.607 Y135.283 E.01138
G2 X123.577 Y136.649 I2.587 J6.038 E.05105
G2 X123.076 Y137.651 I2.128 J1.69 E.02341
G1 X123.625 Y139.199 E.03406
G3 X125.14 Y140.29 I-2.394 J4.921 E.03893
G3 X125.845 Y142.111 I-3.78 J2.509 E.04081
G1 X125.607 Y142.566 E.01065
G1 X124.945 Y142.919 E.01555
G1 X125.312 Y143.951 E.02273
G1 X126.76 Y143.951 E.03003
G3 X126.514 Y143.022 I1.941 J-1.011 E.02011
G1 X126.752 Y142.566 E.01065
G2 X128.782 Y141.201 I-2.587 J-6.038 E.05105
G2 X129.486 Y139.38 I-3.78 J-2.509 E.04081
G1 X129.249 Y138.925 E.01065
G1 X128.682 Y138.623 E.01332
G1 X129.217 Y137.013 E.0352
M204 S10000
G1 X132.651 Y138.357 F60000
G1 F9000
M204 S4000
G1 X132.097 Y139.961 E.0352
G1 X131.972 Y139.835 E.00368
G2 X130.393 Y138.925 I-7.073 J10.443 E.03784
G1 X130.155 Y138.47 E.01065
G3 X132.035 Y135.738 I3.309 J.265 E.072
G1 X132.89 Y135.283 E.0201
G1 X133.128 Y134.828 E.01065
G2 X131.249 Y132.097 I-3.309 J.265 E.072
G1 X130.912 Y131.918 E.00792
G1 X132.069 Y128.437 E.07609
G1 X132.89 Y128 E.01929
G1 X133.128 Y127.545 E.01065
G2 X132.772 Y126.325 I-2.886 J.181 E.02658
G1 X133.153 Y125.178 E.02507
G1 X132.665 Y125.178 E.01013
; WIPE_START
G1 X133.153 Y125.178 E-.18549
G1 X132.772 Y126.325 E-.45937
G1 X132.879 Y126.608 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.956 Y131.422 Z8.52 F60000
G1 X122.229 Y135.265 Z8.52
G1 Z8.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X121.661 Y133.665 E.0352
G2 X122.203 Y132.097 I-4.133 J-2.307 E.0346
G1 X121.965 Y131.642 E.01065
G3 X120.687 Y130.92 I4.339 J-9.183 E.03048
G1 X119.622 Y127.919 E.06607
G1 X120.324 Y127.545 E.0165
G2 X122.203 Y124.814 I-1.43 J-2.996 E.072
G1 X121.965 Y124.359 E.01065
G1 X121.11 Y123.903 E.0201
G3 X119.231 Y121.172 I1.43 J-2.996 E.072
G1 X119.469 Y120.717 E.01065
G2 X120.873 Y119.916 I-4.822 J-10.092 E.03356
G1 X118.92 Y114.084 E.12757
G1 X119.259 Y114.084 E.00702
G1 X119.231 Y113.889 E.0041
G1 X119.469 Y113.434 E.01065
G1 X120.324 Y112.979 E.0201
G2 X121.511 Y112.049 I-1.954 J-3.718 E.03146
G1 X118.316 Y112.049 E.06629
G3 X118.562 Y112.979 I-1.942 J1.011 E.02012
G1 X118.324 Y113.434 E.01065
G1 X117.468 Y113.889 E.0201
G2 X115.654 Y116.165 I1.403 J2.98 E.06253
G2 X115.827 Y117.075 I.907 J.299 E.02007
G1 X116.682 Y117.531 E.0201
G3 X118.562 Y120.262 I-1.43 J2.996 E.072
G1 X118.324 Y120.717 E.01065
G2 X117.271 Y121.296 I3.471 J7.553 E.02494
G1 X117.839 Y122.896 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X117.271 Y121.296 E-.64486
G1 X117.537 Y121.15 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L68
M991 S0 P67 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.52 I-.789 J.927 P1  F60000
G1 X123.325 Y126.079 Z8.52
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.64 F60000
G1 X119.605 Y114.987 Z8.64
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.64 F60000
G1 X141.28 Y114.497 Z8.64
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.132 Y116.709 Z8.64 F60000
G1 Z8.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.578 Y118.313 E.0352
G2 X138.014 Y117.441 I-2.4 J2.465 E.03756
G2 X137.104 Y117.534 I-.387 J.716 E.02016
G1 X136.649 Y118.459 E.02138
G3 X134.786 Y120.184 I-2.823 J-1.179 E.05432
G1 X134.183 Y122.022 E.04012
G1 X133.879 Y122.022 E.00629
M73 P73 R6
G2 X136.194 Y123.993 I3.139 J-1.341 E.06536
G2 X137.104 Y123.9 I.387 J-.716 E.02016
G3 X138.345 Y121.88 I6.183 J2.407 E.04945
G1 X138.899 Y120.276 E.0352
M204 S10000
G1 X137.922 Y123.104 F60000
G1 F9000
M204 S4000
G1 X137.368 Y124.708 E.0352
G1 X137.104 Y124.817 E.00592
G1 X136.649 Y125.742 E.02138
G3 X134.373 Y127.635 I-3.075 J-1.382 E.06357
G3 X133.462 Y127.542 I-.387 J-.716 E.02016
G2 X132.793 Y126.26 I-7.995 J3.36 E.03003
G1 X132.021 Y128.581 E.05072
G1 X132.552 Y128.365 E.01188
G3 X133.462 Y128.458 I.387 J.716 E.02016
G1 X133.918 Y129.383 E.02138
G2 X135.236 Y130.876 I3.085 J-1.396 E.04193
G1 X135.791 Y129.272 E.0352
M204 S10000
G1 X133.054 Y125.475 F60000
G1 F9000
M204 S4000
G1 X133.153 Y125.178 E.0065
G1 X131.77 Y125.178 E.02869
G1 X131.642 Y125.093 E.00318
G2 X130.276 Y124.629 I-1.96 J3.525 E.03008
G1 X129.821 Y124.817 E.01022
G1 X129.643 Y125.178 E.00835
G1 X124.487 Y125.178 E.10696
G1 X124.359 Y125.093 E.00318
G2 X122.993 Y124.629 I-1.96 J3.525 E.03008
G1 X122.538 Y124.817 E.01022
G3 X121.172 Y126.964 I-6.029 J-2.326 E.05313
G3 X119.541 Y127.69 I-2.946 J-4.424 E.03722
G1 X117.295 Y121.363 E.13928
G3 X118.441 Y120.987 I1.606 J2.966 E.02515
G1 X118.896 Y121.175 E.01022
G2 X120.262 Y123.323 I6.029 J-2.326 E.05313
G2 X122.083 Y124.088 I2.877 J-4.295 E.04122
G1 X122.538 Y123.9 E.01022
G3 X123.639 Y122.022 I6.853 J2.758 E.04533
G1 X126.596 Y122.022 E.06133
G2 X129.366 Y124.088 I3.277 J-1.503 E.07475
G1 X129.821 Y123.9 E.01022
G3 X130.922 Y122.022 I6.853 J2.757 E.04533
G1 X129.225 Y122.022 E.0352
; WIPE_START
G1 X130.922 Y122.022 E-.64486
G1 X130.731 Y122.217 E-.10381
G1 X130.716 Y122.243 E-.01133
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.479 Y126.642 Z8.64 F60000
G1 X123.387 Y127.413 Z8.64
G1 Z8.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.922 Y129.023 E.0352
G2 X122.993 Y130.258 I2.827 J3.094 E.03224
G1 X122.538 Y131.183 E.02138
G3 X121.627 Y131.276 I-.524 J-.623 E.02016
G1 X120.671 Y130.877 E.02149
G1 X121.675 Y133.704 E.06222
G2 X122.538 Y132.1 I-9.156 J-5.96 E.03783
G3 X123.448 Y132.007 I.524 J.623 E.02016
G3 X125.321 Y133.228 I-.794 J3.264 E.04727
G1 X126.153 Y135.731 E.05471
G2 X125.269 Y135.649 I-.502 J.609 E.01956
G2 X123.02 Y137.496 I.79 J3.254 E.06244
G1 X123.693 Y139.389 E.04168
G3 X125.724 Y141.183 I-.847 J3.007 E.05815
G1 X126.179 Y142.108 E.02138
G2 X127.09 Y142.201 I.524 J-.623 E.02016
G2 X129.366 Y140.308 I-.799 J-3.275 E.06357
G1 X129.821 Y139.383 E.02138
G3 X130.731 Y139.29 I.524 J.623 E.02016
G3 X132.097 Y139.961 I-1.445 J4.668 E.0317
G1 X130.718 Y143.951 E.08757
G1 X126.636 Y143.951 E.08468
G1 X126.179 Y143.025 E.02143
G2 X125.269 Y142.932 I-.524 J.623 E.02016
G1 X124.99 Y143.045 E.00624
G1 X124.422 Y141.446 E.0352
; WIPE_START
G1 X124.99 Y143.045 E-.64486
G1 X125.269 Y142.932 E-.11439
G1 X125.271 Y142.931 E-.00075
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.263 Y136.875 Z8.64 F60000
G1 Z8.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.727 Y138.485 E.0352
G1 X128.91 Y138.56 E.0041
G2 X129.821 Y138.467 I.387 J-.716 E.02016
G1 X130.276 Y137.542 E.02138
G3 X132.552 Y135.649 I3.075 J1.382 E.06357
G3 X133.462 Y135.742 I.387 J.716 E.02016
G1 X133.517 Y135.852 E.00256
G1 X133.821 Y134.973 E.0193
G1 X133.462 Y134.825 E.00804
G1 X133.007 Y133.9 E.02138
G2 X130.864 Y132.061 I-2.953 J1.273 E.06065
G1 X130.329 Y133.671 E.0352
; WIPE_START
G1 X130.864 Y132.061 E-.64486
G1 X131.145 Y132.175 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.456 Y126.152 Z8.64 F60000
G1 X120.324 Y118.277 Z8.64
G1 Z8.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.863 Y119.886 E.0352
G1 X119.807 Y120.352 E.02395
G3 X118.896 Y120.259 I-.387 J-.716 E.02016
G1 X118.441 Y119.334 E.02138
G2 X115.882 Y117.382 I-3.101 J1.412 E.06953
G1 X115.461 Y116.197 E.02607
G1 X115.71 Y115.692 E.01167
G3 X117.986 Y113.799 I3.074 J1.382 E.06357
G3 X118.896 Y113.892 I.387 J.716 E.02016
G1 X118.991 Y114.084 E.00445
G1 X124.565 Y114.084 E.11563
G1 X125.269 Y113.799 E.01575
G3 X126.179 Y113.892 I.387 J.716 E.02016
G1 X126.274 Y114.084 E.00445
G1 X131.849 Y114.084 E.11563
G1 X132.552 Y113.799 E.01575
G3 X133.462 Y113.892 I.387 J.716 E.02016
G1 X133.557 Y114.084 E.00445
G1 X136.787 Y114.084 E.067
G1 X135.957 Y116.614 E.05523
G1 X136.194 Y116.71 E.00529
G2 X137.104 Y116.617 I.387 J-.716 E.02016
G1 X137.559 Y115.692 E.02138
G3 X139.835 Y113.799 I3.074 J1.382 E.06357
G3 X140.746 Y113.892 I.387 J.716 E.02016
G1 X140.957 Y114.321 E.00992
G1 X141.039 Y114.084 E.0052
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y113.144 E.01951
G1 X141.201 Y113.164 E.00201
G1 X140.746 Y112.976 E.01022
G2 X140.289 Y112.049 I-5.844 J2.301 E.02145
G1 X136.081 Y112.049 E.08729
G3 X134.373 Y113.069 I-2.554 J-2.337 E.04185
G3 X133.462 Y112.976 I-.387 J-.716 E.02016
G2 X133.006 Y112.049 I-5.844 J2.301 E.02145
G1 X128.798 Y112.049 E.08729
G3 X127.09 Y113.069 I-2.554 J-2.337 E.04185
G3 X126.179 Y112.976 I-.387 J-.716 E.02016
G2 X125.723 Y112.049 I-5.844 J2.301 E.02145
G1 X121.515 Y112.049 E.08729
G3 X119.807 Y113.069 I-2.554 J-2.337 E.04185
G3 X118.896 Y112.976 I-.387 J-.716 E.02016
G2 X118.44 Y112.049 I-5.844 J2.301 E.02145
G1 X116.743 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X118.44 Y112.049 E-.64486
G1 X118.574 Y112.321 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L69
M991 S0 P68 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.64 I-1.15 J.397 P1  F60000
G1 X123.325 Y126.079 Z8.64
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.76 F60000
G1 X119.605 Y114.987 Z8.76
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.76 F60000
G1 X141.28 Y114.497 Z8.76
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P73 R5
G1 X140.135 Y116.698 Z8.76 F60000
G1 Z8.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.581 Y118.302 E.0352
G2 X138.014 Y117.586 I-1.993 J2.287 E.03623
G1 X137.559 Y117.6 E.00945
G1 X137.104 Y117.918 E.01152
G1 X136.194 Y119.262 E.03368
G3 X134.823 Y120.072 I-2.014 J-1.845 E.03351
G1 X134.183 Y122.022 E.04257
G1 X133.776 Y122.022 E.00844
G1 X134.373 Y122.904 E.02209
G2 X136.194 Y123.848 I2.299 J-2.205 E.04332
G1 X136.649 Y123.834 E.00945
G1 X137.104 Y123.516 E.01152
G1 X138.014 Y122.172 E.03368
G1 X138.347 Y121.873 E.00928
G1 X138.902 Y120.269 E.0352
M204 S10000
G1 X137.781 Y123.511 F60000
G1 F9000
M204 S4000
G1 X137.227 Y125.115 E.0352
G1 X137.104 Y125.201 E.00311
G1 X136.194 Y126.545 E.03368
G3 X133.918 Y127.476 I-2.096 J-1.879 E.05278
G1 X133.462 Y127.158 E.01152
G1 X132.813 Y126.199 E.02401
G1 X133.153 Y125.178 E.02233
G1 X131.705 Y125.178 E.03004
G1 X130.731 Y124.869 E.02118
G2 X129.854 Y125.178 I-.202 J.827 E.02041
G1 X124.422 Y125.178 E.11268
G1 X123.448 Y124.869 E.02118
G1 X122.993 Y124.883 E.00945
G1 X122.538 Y125.201 E.01152
G1 X121.627 Y126.545 E.03368
G3 X119.466 Y127.479 I-2.092 J-1.875 E.0504
G1 X117.318 Y121.427 E.1332
G3 X118.441 Y121.242 I.84 J1.59 E.02403
G1 X118.896 Y121.559 E.01152
G1 X119.807 Y122.904 E.03368
G2 X122.083 Y123.834 I2.096 J-1.879 E.05278
G1 X122.538 Y123.516 E.01152
G1 X123.448 Y122.172 E.03368
G1 X123.615 Y122.022 E.00465
G1 X126.493 Y122.022 E.05969
G1 X127.09 Y122.904 E.02209
G2 X129.366 Y123.834 I2.096 J-1.879 E.05278
G1 X129.821 Y123.516 E.01152
G1 X130.731 Y122.172 E.03368
G1 X130.898 Y122.022 E.00465
G1 X129.201 Y122.022 E.0352
; WIPE_START
G1 X130.898 Y122.022 E-.64486
G1 X130.731 Y122.172 E-.08512
G1 X130.687 Y122.237 E-.03002
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.466 Y126.659 Z8.76 F60000
G1 X123.39 Y127.423 Z8.76
G1 Z8.36
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.926 Y129.034 E.0352
G2 X123.448 Y129.455 I.767 J1.351 E.0133
G1 X122.538 Y130.799 E.03368
G1 X122.083 Y131.117 E.01152
G1 X121.627 Y131.131 E.00945
G1 X120.652 Y130.821 E.02124
G1 X121.687 Y133.74 E.06424
G1 X122.538 Y132.484 E.03145
G1 X122.993 Y132.166 E.01152
G3 X125.284 Y133.119 I.129 J2.921 E.05317
G1 X124.749 Y131.509 E.0352
M204 S10000
G1 X124.459 Y141.55 F60000
G1 F9000
M204 S4000
G1 X125.027 Y143.149 E.0352
G3 X125.724 Y143.091 I.436 J1.015 E.01476
G3 X126.676 Y143.951 I-1.452 J2.564 E.02683
G1 X130.718 Y143.951 E.08384
G1 X132.094 Y139.97 E.08738
G2 X130.731 Y139.435 I-1.803 J2.591 E.03065
G1 X130.276 Y139.449 E.00945
G1 X129.821 Y139.767 E.01152
G1 X128.91 Y141.112 E.03368
G3 X127.09 Y142.056 I-2.299 J-2.205 E.04332
G1 X126.634 Y142.042 E.00945
G1 X126.179 Y141.724 E.01152
G1 X125.269 Y140.379 E.03368
G2 X123.74 Y139.522 I-2.099 J1.952 E.03695
G1 X122.991 Y137.413 E.04643
G3 X125.269 Y135.794 I2.668 J1.342 E.06032
G3 X126.386 Y136.431 I.118 J1.091 E.02849
G1 X127.155 Y138.742 E.05054
G1 X128.642 Y138.742 E.03085
G1 X128.765 Y138.371 E.00812
G2 X129.366 Y138.4 I.344 J-.885 E.01268
G1 X129.821 Y138.082 E.01152
G1 X130.731 Y136.738 E.03368
G3 X132.552 Y135.794 I2.299 J2.205 E.04332
G3 X133.43 Y136.103 I.202 J.828 E.02043
G1 X133.899 Y134.746 E.02979
G1 X133.462 Y134.441 E.01105
G1 X132.552 Y133.096 E.03368
G2 X130.824 Y132.18 I-2.231 J2.119 E.04128
G1 X131.989 Y128.679 E.07653
G3 X133.007 Y128.525 I.741 J1.449 E.02174
G1 X133.462 Y128.843 E.01152
G1 X134.373 Y130.187 E.03368
G2 X135.249 Y130.839 I1.997 J-1.769 E.02282
G1 X135.803 Y129.235 E.0352
; WIPE_START
G1 X135.249 Y130.839 E-.64486
G1 X134.987 Y130.687 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.165 Y125.751 Z8.76 F60000
G1 X120.314 Y118.246 Z8.76
G1 Z8.36
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.853 Y119.856 E.0352
G1 X119.807 Y120.207 E.02289
G1 X119.351 Y120.192 E.00945
G1 X118.896 Y119.875 E.01152
G1 X117.986 Y118.53 E.03368
G2 X116.165 Y117.586 I-2.299 J2.205 E.04332
G1 X115.957 Y117.592 E.00433
G1 X115.399 Y116.02 E.0346
G1 X116.165 Y114.889 E.02835
G3 X117.986 Y113.944 I2.299 J2.205 E.04332
G3 X119.071 Y114.535 I.134 J1.046 E.02738
G1 X118.92 Y114.084 E.00985
G1 X124.8 Y114.084 E.12196
G3 X125.724 Y113.958 I.651 J1.321 E.01968
G1 X125.905 Y114.084 E.00457
G1 X132.083 Y114.084 E.12816
G3 X133.007 Y113.958 I.651 J1.321 E.01968
G1 X133.188 Y114.084 E.00457
G1 X136.787 Y114.084 E.07467
G1 X135.993 Y116.505 E.05284
G2 X136.649 Y116.551 I.396 J-.959 E.01387
M73 P74 R5
G1 X137.104 Y116.233 E.01152
G1 X138.014 Y114.889 E.03368
G3 X139.835 Y113.944 I2.299 J2.205 E.04332
G3 X140.896 Y114.498 I.147 J1.011 E.02651
G1 X141.039 Y114.084 E.00907
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.912 E.02432
G3 X140.378 Y112.049 I.556 J-1.51 E.02686
G1 X136.116 Y112.049 E.0884
G3 X134.373 Y112.924 I-2.194 J-2.198 E.04115
G1 X133.918 Y112.909 E.00945
G3 X133.095 Y112.049 I.711 J-1.504 E.02526
G1 X128.833 Y112.049 E.0884
G3 X127.09 Y112.924 I-2.194 J-2.198 E.04115
G1 X126.634 Y112.909 E.00945
G3 X125.812 Y112.049 I.711 J-1.504 E.02526
G1 X121.55 Y112.049 E.0884
G3 X119.807 Y112.924 I-2.194 J-2.198 E.04115
G1 X119.351 Y112.909 E.00945
G3 X118.529 Y112.049 I.711 J-1.504 E.02526
G1 X116.832 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X118.529 Y112.049 E-.64486
G1 X118.699 Y112.3 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L70
M991 S0 P69 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.76 I-1.154 J.387 P1  F60000
G1 X123.325 Y126.079 Z8.76
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z8.88 F60000
G1 X119.605 Y114.987 Z8.88
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z8.88 F60000
G1 X141.28 Y114.497 Z8.88
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.141 Y116.683 Z8.88 F60000
G1 Z8.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X139.586 Y118.287 E.0352
G2 X138.014 Y117.713 I-1.683 J2.171 E.03528
G2 X137.104 Y118.155 I-.03 J1.097 E.02181
G1 X136.194 Y119.31 E.03051
G3 X134.852 Y119.982 I-1.727 J-1.771 E.03162
G1 X134.183 Y122.022 E.04453
G1 X133.64 Y122.022 E.01125
G1 X134.373 Y122.952 E.02455
G2 X136.194 Y123.721 I1.972 J-2.126 E.04184
G2 X137.104 Y123.279 I.03 J-1.097 E.02181
G1 X138.014 Y122.124 E.03051
G1 X138.352 Y121.858 E.00892
G1 X138.907 Y120.254 E.0352
M204 S10000
G1 X137.674 Y123.821 F60000
G1 F9000
M204 S4000
G1 X137.12 Y125.425 E.0352
G1 X136.194 Y126.593 E.03092
G3 X133.918 Y127.277 I-1.781 J-1.796 E.05132
G3 X132.837 Y126.128 I1.817 J-2.79 E.03304
G1 X133.153 Y125.178 E.02076
G1 X131.627 Y125.178 E.03166
G1 X130.731 Y124.996 E.01895
G1 X130.276 Y125.081 E.00961
G1 X130.153 Y125.178 E.00325
G1 X124.344 Y125.178 E.1205
G1 X123.448 Y124.996 E.01895
G1 X122.993 Y125.081 E.00961
G3 X122.643 Y125.178 I-.237 J-.175 E.00811
G1 X122.69 Y125.318 E.00307
G1 X122.538 Y125.438 E.00401
G1 X121.627 Y126.593 E.03051
G3 X119.397 Y127.286 I-1.781 J-1.796 E.05036
G1 X117.338 Y121.486 E.12766
G3 X118.896 Y121.796 I.566 J1.223 E.03523
G1 X119.807 Y122.952 E.03051
G2 X122.083 Y123.636 I1.781 J-1.796 E.05132
G1 X122.538 Y123.279 E.01199
G1 X123.578 Y122.022 E.03385
G1 X126.357 Y122.022 E.05766
G1 X127.09 Y122.952 E.02455
G2 X129.366 Y123.636 I1.781 J-1.796 E.05132
G1 X129.821 Y123.279 E.01199
G1 X130.861 Y122.022 E.03385
G1 X129.164 Y122.022 E.0352
; WIPE_START
G1 X130.861 Y122.022 E-.64486
G1 X130.668 Y122.256 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.446 Y126.677 Z8.88 F60000
G1 X123.391 Y127.427 Z8.88
G1 Z8.48
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.927 Y129.037 E.0352
G2 X123.448 Y129.407 I.651 J1.338 E.01264
G1 X122.538 Y130.563 E.03051
G3 X121.627 Y131.004 I-.88 J-.656 E.02181
G1 X120.637 Y130.779 E.02107
G1 X121.702 Y133.781 E.06607
G1 X122.538 Y132.721 E.028
G1 X122.993 Y132.364 E.01199
G3 X125.258 Y133.04 I.498 J2.466 E.05104
G1 X124.723 Y131.43 E.0352
M204 S10000
G1 X124.494 Y141.647 F60000
G1 F9000
M204 S4000
G1 X125.061 Y143.246 E.0352
G3 X125.724 Y143.289 I.278 J.838 E.01412
G3 X126.547 Y143.951 I-10.84 J14.314 E.02191
G1 X130.718 Y143.951 E.08652
G1 X132.093 Y139.972 E.08733
G2 X130.731 Y139.562 I-1.447 J2.34 E.02984
G2 X129.821 Y140.004 I-.03 J1.097 E.02181
G1 X128.91 Y141.159 E.03051
G3 X127.09 Y141.929 I-1.972 J-2.126 E.04184
G3 X126.179 Y141.487 I-.03 J-1.097 E.02181
G1 X125.269 Y140.332 E.03051
G2 X123.778 Y139.629 I-1.787 J1.858 E.0348
G1 X122.956 Y137.315 E.05095
G3 X125.269 Y135.921 I2.421 J1.402 E.05845
G1 X125.724 Y136.006 E.00961
G3 X126.497 Y136.766 I-1.172 J1.965 E.0227
G1 X127.155 Y138.742 E.04321
G1 X128.642 Y138.742 E.03085
G1 X128.801 Y138.265 E.01043
G2 X129.821 Y137.846 I.096 J-1.217 E.02374
G1 X130.731 Y136.69 E.03051
G3 X132.552 Y135.921 I1.972 J2.126 E.04184
G3 X133.367 Y136.287 I.054 J.967 E.01926
G1 X133.96 Y134.569 E.03772
G1 X133.462 Y134.204 E.0128
G1 X132.552 Y133.049 E.03051
G2 X130.788 Y132.291 I-1.937 J2.076 E.04063
G1 X131.963 Y128.757 E.07724
G3 X133.462 Y129.079 I.526 J1.205 E.03397
G1 X134.373 Y130.235 E.03051
G2 X135.26 Y130.808 I1.825 J-1.852 E.02206
G1 X135.814 Y129.204 E.0352
M204 S10000
G1 X136.555 Y114.792 F60000
G1 F9000
M204 S4000
G1 X136.026 Y116.404 E.0352
G2 X137.104 Y115.996 I.172 J-1.174 E.02496
G1 X138.014 Y114.841 E.03051
G3 X139.835 Y114.071 I1.972 J2.126 E.04184
G3 X140.846 Y114.641 I-.081 J1.327 E.02491
G1 X141.039 Y114.084 E.01221
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.729 E.02812
G3 X140.504 Y112.049 I.905 J-1.853 E.02188
G1 X136.166 Y112.049 E.08999
G3 X134.373 Y112.796 I-1.937 J-2.12 E.04111
G3 X133.221 Y112.049 I.195 J-1.561 E.02947
G1 X128.883 Y112.049 E.08999
G3 X127.09 Y112.796 I-1.937 J-2.12 E.04111
G3 X125.938 Y112.049 I.195 J-1.561 E.02947
G1 X121.6 Y112.049 E.08999
G3 X119.807 Y112.796 I-1.937 J-2.12 E.04111
G3 X118.655 Y112.049 I.195 J-1.561 E.02947
G1 X116.958 Y112.049 E.0352
M204 S10000
G1 X119.727 Y116.492 F60000
G1 F9000
M204 S4000
G1 X119.188 Y114.883 E.0352
G2 X118.441 Y114.157 I-1.863 J1.168 E.02182
G2 X116.165 Y114.841 I-.495 J2.48 E.05132
G1 X115.348 Y115.878 E.02738
G1 X116.01 Y117.742 E.04103
G3 X117.986 Y118.482 I.159 J2.582 E.04509
G1 X118.896 Y119.638 E.03051
G2 X119.807 Y120.08 I.88 J-.656 E.02181
G1 X120.844 Y119.831 E.02214
G1 X120.306 Y118.222 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F9000
G1 X120.844 Y119.831 E-.64486
G1 X120.55 Y119.902 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L71
M991 S0 P70 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z8.88 I-1.11 J.499 P1  F60000
G1 X123.325 Y126.079 Z8.88
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9 F60000
G1 X119.605 Y114.987 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9 F60000
G1 X141.28 Y114.497 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
M73 P75 R5
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.125 Y120.401 Z9 F60000
G1 X137.574 Y124.11 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.02 Y125.714 E.0352
G1 X136.194 Y126.643 E.0258
G3 X133.918 Y127.113 I-1.544 J-1.733 E.05049
G3 X132.859 Y126.061 I2.815 J-3.89 E.03108
G1 X133.153 Y125.178 E.0193
G1 X131.483 Y125.178 E.03465
G2 X130.5 Y125.178 I-.491 J1.758 E.02063
G1 X124.199 Y125.178 E.13069
G2 X123.217 Y125.178 I-.491 J1.758 E.02063
G1 X122.643 Y125.178 E.0119
G1 X122.736 Y125.457 E.00609
G1 X121.627 Y126.643 E.03369
G3 X119.329 Y127.095 I-1.524 J-1.684 E.05104
G1 X117.348 Y121.512 E.12289
G3 X118.896 Y121.978 I.41 J1.444 E.03542
G1 X119.807 Y123.002 E.02842
G2 X122.083 Y123.472 I1.544 J-1.733 E.05049
G2 X123.448 Y122.074 I-3.76 J-5.04 E.0407
G1 X123.523 Y122.022 E.0019
G1 X126.218 Y122.022 E.0559
G1 X127.09 Y123.002 E.02719
G2 X129.366 Y123.472 I1.544 J-1.733 E.05049
G2 X130.731 Y122.074 I-3.76 J-5.039 E.0407
G1 X130.807 Y122.022 E.0019
G1 X133.502 Y122.022 E.0559
G1 X134.373 Y123.002 E.02719
G2 X136.649 Y123.472 I1.544 J-1.733 E.05049
G2 X138.014 Y122.074 I-3.76 J-5.039 E.0407
G1 X138.36 Y121.837 E.00869
G1 X139.594 Y118.266 E.07835
G2 X137.559 Y117.962 I-1.31 J1.804 E.04435
G2 X136.194 Y119.36 I3.759 J5.039 E.0407
G3 X134.861 Y119.955 I-1.792 J-2.226 E.03061
G1 X136.052 Y116.324 E.07926
G2 X137.104 Y115.814 I-.085 J-1.514 E.02488
G1 X138.014 Y114.791 E.02842
G3 X140.29 Y114.321 I1.544 J1.733 E.05049
G3 X140.805 Y114.761 I-1.143 J1.855 E.0141
G1 X141.039 Y114.084 E.01485
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.576 E.0313
G1 X141.201 Y112.547 E.00206
G3 X140.635 Y112.049 I1.301 J-2.047 E.0157
G1 X136.219 Y112.049 E.09161
G3 X133.918 Y112.547 I-1.575 J-1.711 E.05121
G3 X133.352 Y112.049 I1.301 J-2.047 E.0157
G1 X128.936 Y112.049 E.09161
G3 X126.634 Y112.547 I-1.575 J-1.711 E.05121
G3 X126.069 Y112.049 I1.301 J-2.047 E.0157
G1 X121.653 Y112.049 E.09161
G3 X119.351 Y112.547 I-1.575 J-1.711 E.05121
G3 X118.786 Y112.049 I1.301 J-2.047 E.0157
G1 X117.089 Y112.049 E.0352
M204 S10000
G1 X119.802 Y116.716 F60000
G1 F9000
M204 S4000
G1 X119.263 Y115.107 E.0352
G2 X118.441 Y114.321 I-2.91 J2.219 E.02369
G2 X116.165 Y114.791 I-.732 J2.203 E.05049
G1 X115.305 Y115.757 E.02683
G1 X116.051 Y117.859 E.04626
G3 X117.986 Y118.432 I.336 J2.417 E.04314
G1 X118.896 Y119.456 E.02842
G2 X120.838 Y119.812 I1.223 J-1.193 E.04367
G1 X120.299 Y118.203 E.0352
M204 S10000
G1 X123.391 Y127.425 F60000
G1 F9000
M204 S4000
G1 X123.926 Y129.035 E.0352
G2 X123.448 Y129.357 I.534 J1.308 E.01204
G1 X122.538 Y130.381 E.02842
G3 X120.626 Y130.75 I-1.216 J-1.165 E.04305
G1 X121.718 Y133.825 E.06768
G3 X122.993 Y132.529 I4.757 J3.405 E.03787
G3 X125.237 Y132.977 I.73 J2.186 E.04967
G1 X124.701 Y131.366 E.0352
M204 S10000
G1 X124.519 Y141.719 F60000
G1 F9000
M204 S4000
G1 X125.087 Y143.318 E.0352
G3 X125.724 Y143.453 I.104 J1.08 E.01372
G2 X126.375 Y143.951 I2.317 J-2.355 E.01705
G1 X130.718 Y143.951 E.09008
G1 X132.095 Y139.968 E.08741
G2 X130.276 Y139.812 I-1.084 J1.955 E.039
G2 X128.91 Y141.21 I3.76 J5.039 E.0407
G3 X126.634 Y141.679 I-1.544 J-1.733 E.05049
G3 X125.269 Y140.282 I3.76 J-5.039 E.0407
G2 X123.795 Y139.679 I-1.636 J1.896 E.03361
G1 X122.925 Y137.228 E.05394
G1 X123.448 Y136.64 E.01631
G3 X125.724 Y136.17 I1.544 J1.733 E.05049
G3 X126.569 Y136.983 I-2.161 J3.093 E.02442
G1 X127.155 Y138.742 E.03846
G1 X128.642 Y138.742 E.03085
G1 X128.831 Y138.174 E.01242
G2 X129.366 Y138.038 I.051 J-.917 E.01163
G2 X130.731 Y136.64 I-3.76 J-5.039 E.0407
G3 X132.097 Y136.038 I1.808 J2.253 E.03131
G3 X133.319 Y136.426 I.209 J1.46 E.02751
G1 X134.01 Y134.424 E.04393
G1 X133.918 Y134.396 E.00201
G3 X132.552 Y132.999 I3.76 J-5.039 E.0407
G2 X130.754 Y132.392 I-1.647 J1.911 E.04035
G1 X131.953 Y128.786 E.07881
G3 X133.007 Y128.887 I.356 J1.844 E.02227
G3 X134.373 Y130.285 I-3.76 J5.039 E.0407
G2 X135.269 Y130.782 I1.642 J-1.904 E.02141
G1 X135.823 Y129.178 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X135.269 Y130.782 E-.64486
G1 X134.989 Y130.665 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L72
M991 S0 P71 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9 I.445 J-1.133 P1  F60000
G1 X123.325 Y126.079 Z9
G1 Z8.72
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.12 F60000
G1 X119.605 Y114.987 Z9.12
G1 Z8.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.12 F60000
G1 X141.28 Y114.497 Z9.12
G1 Z8.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.134 Y120.405 Z9.12 F60000
G1 X137.489 Y124.356 Z9.12
G1 Z8.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.935 Y125.96 E.0352
G3 X136.194 Y126.696 I-4.204 J-3.493 E.0217
G3 X133.918 Y126.972 I-1.367 J-1.757 E.04995
G3 X132.889 Y125.972 I8.422 J-9.692 E.02977
G1 X131.936 Y128.837 E.06264
G3 X132.552 Y128.849 I.28 J1.419 E.01288
G3 X133.918 Y129.92 I-1.058 J2.756 E.03653
G2 X135.276 Y130.761 I2.153 J-1.96 E.03357
G1 X135.83 Y129.157 E.0352
; WIPE_START
G1 X135.276 Y130.761 E-.64486
G1 X134.989 Y130.663 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.771 Y136.233 Z9.12 F60000
G1 X124.55 Y141.805 Z9.12
G1 Z8.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.118 Y143.404 E.0352
G3 X126.145 Y143.951 I-.256 J1.719 E.02462
G1 X130.718 Y143.951 E.09486
G1 X132.098 Y139.959 E.08762
G2 X130.731 Y139.774 I-.969 J2.025 E.02908
G2 X129.366 Y140.845 I1.058 J2.756 E.03653
G3 X127.09 Y141.717 I-1.937 J-1.65 E.05272
G3 X125.724 Y140.646 I1.058 J-2.756 E.03653
G2 X123.819 Y139.746 I-1.964 J1.69 E.04501
G1 X122.888 Y137.122 E.05776
G3 X123.448 Y136.587 I3.064 J2.65 E.01609
G3 X125.724 Y136.312 I1.367 J1.757 E.04995
G3 X126.646 Y137.214 I-5.013 J6.046 E.02679
G1 X127.155 Y138.742 E.03341
G1 X128.642 Y138.742 E.03085
G1 X128.863 Y138.079 E.0145
G2 X129.821 Y137.511 I-.504 J-1.942 E.02342
G3 X131.186 Y136.316 I3.687 J2.837 E.03788
G3 X133.279 Y136.542 I.88 J1.658 E.04634
G1 X134.051 Y134.307 E.04904
G3 X133.007 Y133.363 I1.803 J-3.043 E.02938
G2 X130.719 Y132.496 I-1.934 J1.65 E.05295
G1 X130.184 Y134.106 E.0352
; WIPE_START
G1 X130.719 Y132.496 E-.64485
G1 X131.021 Y132.47 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.681 Y131.304 Z9.12 F60000
G1 Z8.72
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.216 Y132.914 E.0352
G2 X122.993 Y132.67 I-1.318 J1.763 E.04866
G2 X121.737 Y133.879 I18.82 J20.814 E.03616
G1 X120.619 Y130.73 E.0693
G2 X122.538 Y130.228 I.57 J-1.735 E.04348
G3 X123.923 Y129.026 I3.709 J2.878 E.03828
G1 X122.774 Y125.572 E.07551
G2 X121.627 Y126.696 I184.793 J189.679 E.03332
G3 X119.351 Y126.972 I-1.367 J-1.757 E.04995
G1 X119.257 Y126.892 E.00256
G1 X117.363 Y121.555 E.11746
G3 X118.896 Y122.131 I.272 J1.604 E.0356
G2 X120.262 Y123.325 I3.687 J-2.837 E.03788
M73 P76 R5
G2 X122.538 Y122.945 I.886 J-1.695 E.05138
G3 X123.447 Y122.022 I5.259 J4.272 E.0269
G1 X126.051 Y122.022 E.05402
G2 X127.09 Y123.055 I31.268 J-30.415 E.03039
G2 X129.366 Y123.33 I1.367 J-1.757 E.04995
G2 X130.73 Y122.022 I-25.604 J-28.069 E.0392
G1 X133.334 Y122.022 E.05402
G2 X134.373 Y123.055 I31.229 J-30.376 E.03039
G2 X136.649 Y123.33 I1.367 J-1.757 E.04995
G2 X138.014 Y122.021 I-25.698 J-28.169 E.03925
G1 X138.369 Y121.81 E.00856
G1 X139.602 Y118.241 E.07833
G2 X137.104 Y118.489 I-1.102 J1.601 E.05662
G3 X135.738 Y119.684 I-3.687 J-2.837 E.03788
G3 X134.881 Y119.895 I-.978 J-2.124 E.01843
G1 X136.082 Y116.235 E.07991
G2 X137.104 Y115.662 I-.336 J-1.797 E.02474
G3 X138.47 Y114.467 I3.687 J2.837 E.03788
G3 X140.767 Y114.871 I.887 J1.689 E.05205
G1 X141.039 Y114.084 E.01727
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.443 E.03405
G3 X140.779 Y112.049 I.322 J-.957 E.01372
G1 X136.282 Y112.049 E.09328
G3 X133.496 Y112.049 I-1.393 J-1.428 E.06397
G1 X128.999 Y112.049 E.09328
G3 X126.213 Y112.049 I-1.393 J-1.428 E.06397
G1 X121.716 Y112.049 E.09328
G3 X118.93 Y112.049 I-1.393 J-1.428 E.06397
G1 X117.233 Y112.049 E.0352
M204 S10000
G1 X119.881 Y116.952 F60000
G1 F9000
M204 S4000
G1 X119.342 Y115.343 E.0352
G1 X118.896 Y114.848 E.01382
G2 X117.075 Y114.312 I-1.346 J1.211 E.04144
G2 X115.267 Y115.648 I1.376 J3.755 E.04728
G1 X116.086 Y117.956 E.0508
G3 X117.531 Y118.109 I.5 J2.178 E.0307
G3 X118.896 Y119.303 I-2.322 J4.032 E.03788
G2 X120.834 Y119.799 I1.348 J-1.232 E.0439
G1 X120.295 Y118.19 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.834 Y119.799 E-.64485
G1 X120.536 Y119.853 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L73
M991 S0 P72 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.12 I-1.111 J.498 P1  F60000
G1 X123.325 Y126.079 Z9.12
G1 Z8.84
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.24 F60000
G1 X119.605 Y114.987 Z9.24
G1 Z8.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.24 F60000
G1 X141.28 Y114.497 Z9.24
G1 Z8.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.142 Y120.408 Z9.24 F60000
G1 X137.423 Y124.549 Z9.24
G1 Z8.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.869 Y126.153 E.0352
G3 X133.918 Y126.846 I-1.882 J-1.386 E.06841
G3 X132.913 Y125.901 I18.087 J-20.24 E.02862
G1 X131.923 Y128.878 E.06507
G3 X133.462 Y129.55 I.1 J1.87 E.03614
G2 X135.281 Y130.746 I2.738 J-2.183 E.04592
G1 X135.836 Y129.142 E.0352
; WIPE_START
G1 X135.281 Y130.746 E-.64486
G1 X134.988 Y130.668 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.797 Y136.263 Z9.24 F60000
G1 X124.579 Y141.887 Z9.24
G1 Z8.84
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.146 Y143.486 E.0352
G3 X125.99 Y143.951 I-.48 J1.865 E.02019
G1 X130.718 Y143.951 E.09809
G1 X132.103 Y139.944 E.08795
G2 X130.276 Y140.079 I-.767 J2.041 E.03922
G3 X128.91 Y141.319 I-34.158 J-36.245 E.03826
G3 X126.179 Y141.017 I-1.191 J-1.727 E.06214
G2 X123.839 Y139.802 I-2.297 J1.563 E.05699
G1 X122.859 Y137.041 E.06075
G3 X125.724 Y136.438 I1.8 J1.443 E.06579
G3 X126.692 Y137.353 I-12.386 J14.076 E.02764
G1 X127.155 Y138.742 E.03038
G1 X128.642 Y138.742 E.03085
G1 X128.893 Y137.989 E.01647
G2 X129.366 Y137.77 I-.137 J-.918 E.01095
G3 X130.731 Y136.53 I34.131 J36.215 E.03826
G3 X133.244 Y136.643 I1.182 J1.705 E.05604
G1 X134.085 Y134.208 E.05344
G3 X133.007 Y133.261 I2.313 J-3.72 E.02989
G2 X130.684 Y132.603 I-1.719 J1.637 E.05255
G1 X130.148 Y134.213 E.0352
; WIPE_START
G1 X130.684 Y132.603 E-.64486
G1 X130.981 Y132.547 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.66 Y131.241 Z9.24 F60000
G1 Z8.84
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.195 Y132.851 E.0352
G2 X122.538 Y133.191 I-1.129 J1.733 E.06045
G3 X121.755 Y133.931 I-3.5 J-2.917 E.02239
G1 X120.616 Y130.72 E.07069
G2 X122.538 Y130.092 I.44 J-1.911 E.04407
G3 X123.918 Y129.012 I3.072 J2.505 E.03666
G1 X122.808 Y125.673 E.07298
G3 X121.627 Y126.753 I-18.755 J-19.329 E.03319
G3 X119.191 Y126.707 I-1.186 J-1.714 E.05397
G1 X117.377 Y121.593 E.11255
G3 X118.896 Y122.267 I.079 J1.872 E.03572
G2 X121.172 Y123.492 I2.338 J-1.615 E.05566
G2 X122.538 Y122.809 I-.18 J-2.066 E.03244
G3 X123.377 Y122.022 I3.725 J3.134 E.02392
G1 X125.898 Y122.022 E.05228
G2 X127.09 Y123.111 I19.517 J-20.162 E.0335
G2 X129.821 Y122.809 I1.191 J-1.727 E.06214
G3 X130.66 Y122.022 I3.725 J3.134 E.02392
G1 X133.181 Y122.022 E.05228
G2 X134.373 Y123.111 I19.506 J-20.149 E.0335
G2 X137.104 Y122.809 I1.191 J-1.727 E.06214
G3 X138.38 Y121.778 I3.089 J2.52 E.03427
G1 X139.613 Y118.21 E.07831
G2 X137.104 Y118.625 I-.997 J1.761 E.05704
G3 X134.897 Y119.846 I-2.33 J-1.607 E.05423
G1 X136.11 Y116.15 E.08069
G2 X137.104 Y115.526 I-.656 J-2.149 E.02464
G3 X139.38 Y114.3 I2.338 J1.616 E.05566
G3 X140.732 Y114.972 I-.176 J2.051 E.03206
G1 X141.039 Y114.084 E.01947
G1 X141.296 Y114.084 E.00534
G1 X141.296 Y112.324 E.03651
G3 X140.935 Y112.049 I.312 J-.782 E.00954
G1 X136.362 Y112.049 E.09485
G3 X133.652 Y112.049 I-1.355 J-1.566 E.06129
G1 X129.079 Y112.049 E.09485
G3 X126.369 Y112.049 I-1.355 J-1.566 E.06129
G1 X121.796 Y112.049 E.09485
G3 X119.086 Y112.049 I-1.355 J-1.566 E.06129
G1 X117.389 Y112.049 E.0352
M204 S10000
G1 X119.929 Y117.097 F60000
G1 F9000
M204 S4000
G1 X119.39 Y115.488 E.0352
G3 X118.896 Y114.984 I1.872 J-2.329 E.01468
G2 X117.075 Y114.329 I-1.473 J1.237 E.04205
G2 X115.231 Y115.547 I.89 J3.356 E.04666
G1 X116.115 Y118.038 E.05484
G3 X116.62 Y117.942 I.417 J.816 E.01082
G3 X118.896 Y119.167 I-.062 J2.841 E.05566
G2 X120.831 Y119.792 I1.482 J-1.281 E.04434
G1 X120.292 Y118.182 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 8.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.831 Y119.792 E-.64485
G1 X120.53 Y119.823 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L74
M991 S0 P73 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.24 I-1.111 J.496 P1  F60000
G1 X123.325 Y126.079 Z9.24
G1 Z8.96
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.36 F60000
G1 X119.605 Y114.987 Z9.36
G1 Z8.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.36 F60000
G1 X141.28 Y114.497 Z9.36
G1 Z8.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
M73 P77 R5
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.163 Y112.049 Z9.36 F60000
G1 Z8.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.466 Y112.049 E.0352
G3 X133.788 Y112.049 I-1.339 J-1.637 E.06015
G1 X129.182 Y112.049 E.09553
G3 X126.505 Y112.049 I-1.339 J-1.637 E.06015
G1 X121.899 Y112.049 E.09553
G3 X119.221 Y112.049 I-1.339 J-1.637 E.06015
G1 X117.525 Y112.049 E.0352
M204 S10000
G1 X119.002 Y114.084 F60000
G1 F9000
M204 S4000
G1 X118.92 Y114.084 E.0017
G1 X119.433 Y115.616 E.0335
G3 X118.896 Y115.11 I1.465 J-2.091 E.01537
G2 X117.075 Y114.34 I-1.67 J1.412 E.04255
G2 X115.197 Y115.451 I.55 J3.072 E.04626
G1 X116.14 Y118.109 E.05849
G3 X118.896 Y119.041 I.732 J2.375 E.06447
G2 X120.831 Y119.79 I1.636 J-1.354 E.04495
G1 X120.292 Y118.18 E.0352
; WIPE_START
G1 X120.831 Y119.79 E-.64485
G1 X120.528 Y119.798 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.774 Y117.4 Z9.36 F60000
G1 X136.665 Y114.457 Z9.36
G1 Z8.96
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.136 Y116.069 E.0352
G2 X137.104 Y115.4 I-1.093 J-2.613 E.02459
G3 X139.835 Y114.454 I2.033 J1.453 E.06393
G3 X140.699 Y115.068 I-.894 J2.171 E.02217
G1 X139.626 Y118.173 E.06814
G2 X137.104 Y118.751 I-.877 J1.962 E.05759
G3 X134.91 Y119.807 I-2.091 J-1.538 E.05257
G1 X135.439 Y118.194 E.0352
M204 S10000
G1 X135.839 Y129.132 F60000
G1 F9000
M204 S4000
G1 X135.285 Y130.736 E.0352
G3 X133.462 Y129.676 I.362 J-2.719 E.04488
G2 X131.912 Y128.909 I-1.654 J1.394 E.03691
G1 X132.937 Y125.827 E.06738
G3 X133.462 Y126.324 I-1.441 J2.046 E.01506
G2 X136.81 Y126.323 I1.673 J-1.44 E.0788
G1 X138.393 Y121.742 E.10054
G2 X137.104 Y122.683 I1.313 J3.151 E.0334
G3 X134.373 Y123.172 I-1.659 J-1.393 E.06246
G3 X133.047 Y122.022 I8.479 J-11.111 E.03642
G1 X130.569 Y122.022 E.05141
G2 X129.821 Y122.683 I1.887 J2.89 E.02078
G3 X127.09 Y123.172 I-1.659 J-1.393 E.06246
G3 X125.764 Y122.022 I8.481 J-11.114 E.03642
G1 X123.286 Y122.022 E.05141
G1 X122.993 Y122.236 E.00752
G3 X121.627 Y123.339 I-3.795 J-3.302 E.0366
G3 X118.896 Y122.393 I-.698 J-2.399 E.06393
G2 X117.388 Y121.627 I-1.66 J1.401 E.03603
G1 X119.13 Y126.533 E.10799
G2 X121.627 Y126.814 I1.438 J-1.541 E.05586
G2 X122.839 Y125.765 I-7.273 J-9.63 E.03325
G1 X123.911 Y128.991 E.07051
G2 X122.538 Y129.966 I1.191 J3.133 E.03532
G3 X120.614 Y130.716 I-1.637 J-1.357 E.04471
G1 X121.776 Y133.988 E.07202
G2 X122.538 Y133.317 I-1.915 J-2.943 E.02113
G3 X125.174 Y132.788 I1.651 J1.39 E.06022
G1 X125.71 Y134.398 E.0352
; WIPE_START
G1 X125.174 Y132.788 E-.64486
G1 X124.895 Y132.669 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.114 Y134.317 Z9.36 F60000
G1 Z8.96
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.649 Y132.706 E.0352
G3 X133.462 Y133.608 I.806 J2.324 E.06572
G2 X134.115 Y134.122 I1.436 J-1.15 E.01738
G1 X133.212 Y136.735 E.05735
G2 X130.276 Y136.802 I-1.432 J1.608 E.06703
G3 X128.923 Y137.898 I-3.797 J-3.305 E.03631
G1 X128.642 Y138.742 E.01845
G1 X127.155 Y138.742 E.03085
G1 X126.734 Y137.479 E.02762
G3 X125.724 Y136.552 I47.889 J-53.245 E.02843
G2 X122.831 Y136.961 I-1.208 J1.89 E.06601
G1 X123.855 Y139.848 E.06352
G3 X126.179 Y140.891 I.258 J2.535 E.05533
G2 X129.366 Y141.047 I1.667 J-1.424 E.0741
G3 X130.731 Y139.945 I3.795 J3.302 E.0366
G3 X132.11 Y139.923 I.721 J2.017 E.02913
G1 X130.797 Y143.725 E.08344
G2 X130.46 Y143.951 I.32 J.84 E.00849
G1 X125.854 Y143.951 E.09554
G2 X125.174 Y143.564 I-1.512 J1.86 E.0163
G1 X124.606 Y141.964 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.174 Y143.564 E-.64486
G1 X125.437 Y143.714 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L75
M991 S0 P74 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.36 I1.208 J-.145 P1  F60000
G1 X123.325 Y126.079 Z9.36
G1 Z9.08
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.48 F60000
G1 X119.605 Y114.987 Z9.48
G1 Z9.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.48 F60000
G1 X141.28 Y114.497 Z9.48
G1 Z9.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.296 Y112.049 Z9.48 F60000
G1 Z9.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.599 Y112.049 E.0352
G3 X133.908 Y112.049 I-1.345 J-1.717 E.06015
G1 X129.316 Y112.049 E.09526
G3 X126.625 Y112.049 I-1.345 J-1.717 E.06015
G1 X122.033 Y112.049 E.09526
G3 X119.342 Y112.049 I-1.345 J-1.717 E.06015
G1 X117.645 Y112.049 E.0352
M204 S10000
G1 X118.935 Y114.128 F60000
G1 F9000
M204 S4000
G1 X119.474 Y115.738 E.0352
G3 X118.896 Y115.231 I1.137 J-1.878 E.01602
G2 X116.165 Y114.555 I-1.789 J1.375 E.06301
G2 X115.165 Y115.361 I3.164 J4.947 E.0267
G1 X116.162 Y118.171 E.06183
G3 X118.896 Y118.92 I.881 J2.15 E.06325
G2 X120.832 Y119.793 I1.815 J-1.44 E.04576
G1 X120.293 Y118.184 E.0352
; WIPE_START
G1 X120.832 Y119.793 E-.64486
G1 X120.529 Y119.78 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.768 Y117.361 Z9.48 F60000
G1 X136.69 Y114.38 Z9.48
G1 Z9.08
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.161 Y115.992 E.0352
G2 X137.104 Y115.279 I-1.737 J-3.274 E.02463
G3 X140.667 Y115.159 I1.83 J1.367 E.08485
G1 X139.641 Y118.129 E.06519
G2 X137.104 Y118.872 I-.762 J2.099 E.05868
G3 X134.92 Y119.775 I-1.883 J-1.462 E.05129
G1 X135.449 Y118.163 E.0352
M204 S10000
G1 X135.841 Y129.127 F60000
G1 F9000
M204 S4000
G1 X135.286 Y130.731 E.0352
G3 X133.462 Y129.797 I.12 J-2.482 E.04382
G2 X131.904 Y128.933 I-1.915 J1.617 E.03778
G1 X132.964 Y125.748 E.06963
G3 X133.462 Y126.203 I-1.032 J1.632 E.01408
G2 X136.754 Y126.484 I1.773 J-1.354 E.07716
G1 X138.407 Y121.702 E.10494
G2 X137.104 Y122.562 I.904 J2.786 E.03277
G3 X133.918 Y122.941 I-1.779 J-1.372 E.07414
M73 P78 R5
G2 X132.893 Y122.022 I-7.839 J7.715 E.02857
G1 X130.449 Y122.022 E.05069
G2 X129.821 Y122.562 I1.204 J2.036 E.01726
G3 X126.634 Y122.941 I-1.779 J-1.372 E.07414
G2 X125.609 Y122.022 I-7.84 J7.716 E.02857
G1 X123.166 Y122.022 E.05069
G2 X122.538 Y122.562 I1.204 J2.036 E.01726
G3 X118.896 Y122.514 I-1.802 J-1.427 E.08719
G2 X117.398 Y121.655 I-1.934 J1.637 E.03654
G1 X119.07 Y126.363 E.10363
G2 X121.627 Y126.879 I1.63 J-1.481 E.05793
G2 X122.867 Y125.851 I-4.154 J-6.272 E.03347
G1 X123.902 Y128.963 E.06803
G2 X122.538 Y129.845 I.862 J2.831 E.03413
G3 X120.616 Y130.72 I-1.818 J-1.445 E.04547
G1 X120.048 Y129.12 E.0352
M204 S10000
G1 X125.688 Y134.333 F60000
G1 F9000
M204 S4000
G1 X125.152 Y132.722 E.0352
G2 X122.538 Y133.439 I-.836 J2.077 E.0604
G3 X121.798 Y134.051 I-2.093 J-1.774 E.02002
G1 X122.802 Y136.88 E.06227
G3 X126.179 Y137.08 I1.602 J1.556 E.07962
G2 X126.774 Y137.598 I1.754 J-1.414 E.01644
G1 X127.155 Y138.742 E.02502
G1 X128.642 Y138.742 E.03085
G1 X128.954 Y137.804 E.02051
G2 X130.276 Y136.701 I-3.882 J-5.995 E.03581
G3 X133.182 Y136.821 I1.386 J1.681 E.06606
G1 X134.141 Y134.046 E.06091
G3 X133.007 Y133.059 I4.766 J-6.624 E.03122
M73 P78 R4
G2 X130.616 Y132.807 I-1.381 J1.625 E.05299
G1 X130.08 Y134.417 E.0352
M204 S10000
G1 X128.629 Y143.951 F60000
G1 F9000
M204 S4000
G1 X130.326 Y143.951 E.0352
G3 X130.82 Y143.657 I.842 J.849 E.01205
G1 X132.12 Y139.896 E.08254
G2 X129.821 Y140.722 I-.505 J2.207 E.05352
G3 X126.179 Y140.77 I-1.839 J-1.379 E.08719
G2 X123.869 Y139.885 I-1.865 J1.411 E.05408
G1 X125.201 Y143.638 E.0826
G3 X125.733 Y143.951 I-2.3 J4.524 E.01283
G1 X127.43 Y143.951 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.733 Y143.951 E-.64486
G1 X125.472 Y143.798 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L76
M991 S0 P75 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.48 I1.208 J-.146 P1  F60000
G1 X123.325 Y126.079 Z9.48
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.6 F60000
G1 X119.605 Y114.987 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.6 F60000
G1 X141.28 Y114.497 Z9.6
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.426 Y112.049 Z9.6 F60000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.729 Y112.049 E.0352
G3 X134.052 Y112.049 I-1.339 J-1.668 E.06
G1 X129.446 Y112.049 E.09554
G3 X126.769 Y112.049 I-1.339 J-1.668 E.06
G1 X122.163 Y112.049 E.09554
G3 X119.486 Y112.049 I-1.339 J-1.668 E.06
G1 X117.789 Y112.049 E.0352
M204 S10000
G1 X118.975 Y114.247 F60000
G1 F9000
M204 S4000
G1 X119.514 Y115.856 E.0352
G3 X118.896 Y115.351 I.867 J-1.689 E.01668
G2 X116.165 Y114.484 I-1.958 J1.431 E.06359
G2 X115.134 Y115.274 I2.196 J3.931 E.02704
G1 X116.183 Y118.229 E.06504
G3 X118.896 Y118.8 I1.011 J1.93 E.06234
G2 X120.835 Y119.804 I2.023 J-1.532 E.04682
G1 X120.296 Y118.195 E.0352
; WIPE_START
G1 X120.835 Y119.804 E-.64485
G1 X120.534 Y119.768 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.766 Y117.327 Z9.6 F60000
G1 X136.715 Y114.305 Z9.6
G1 Z9.2
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.186 Y115.917 E.0352
G2 X137.559 Y114.747 I-12.515 J-16.069 E.03745
G3 X140.637 Y115.247 I1.274 J1.883 E.07128
G1 X139.659 Y118.078 E.06213
G2 X137.104 Y118.993 I-.604 J2.337 E.05977
G3 X134.928 Y119.752 I-1.705 J-1.389 E.05032
G1 X135.457 Y118.139 E.0352
M204 S10000
G1 X135.84 Y129.129 F60000
G1 F9000
M204 S4000
G1 X135.286 Y130.733 E.0352
G3 X133.462 Y129.917 I-.085 J-2.257 E.04292
G2 X131.899 Y128.95 I-2.237 J1.868 E.03881
G1 X132.992 Y125.662 E.07186
G3 X133.918 Y126.521 I-12.77 J14.692 E.0262
G2 X136.7 Y126.641 I1.463 J-1.612 E.06267
G1 X138.422 Y121.657 E.10939
G2 X137.104 Y122.441 I.57 J2.457 E.03232
G3 X133.918 Y123.046 I-1.911 J-1.375 E.07421
G2 X132.758 Y122.022 I-9.669 J9.78 E.0321
G1 X130.289 Y122.022 E.05122
G2 X129.821 Y122.441 I.742 J1.3 E.01314
G3 X126.634 Y123.046 I-1.911 J-1.375 E.07421
G2 X125.475 Y122.022 I-9.672 J9.783 E.0321
G1 X123.006 Y122.022 E.05122
G2 X122.083 Y122.88 I13.413 J15.37 E.02615
G3 X118.896 Y122.634 I-1.476 J-1.648 E.07408
G2 X117.407 Y121.678 I-2.276 J1.908 E.03727
G1 X119.008 Y126.191 E.09932
G2 X121.627 Y126.95 I1.84 J-1.45 E.06037
G2 X122.894 Y125.932 I-2.665 J-4.615 E.03384
G1 X123.891 Y128.931 E.06554
G2 X122.538 Y129.724 I.545 J2.481 E.03309
G3 X120.619 Y130.729 I-2.03 J-1.542 E.0464
G1 X120.051 Y129.13 E.0352
M204 S10000
G1 X125.665 Y134.264 F60000
G1 F9000
M204 S4000
G1 X125.13 Y132.654 E.0352
G2 X122.538 Y133.559 I-.642 J2.327 E.06057
G3 X121.823 Y134.121 I-1.664 J-1.382 E.019
G1 X122.772 Y136.796 E.05888
G3 X125.724 Y136.762 I1.494 J1.564 E.0674
G2 X126.813 Y137.715 I5.024 J-4.642 E.03007
G1 X127.155 Y138.742 E.02246
G1 X128.642 Y138.742 E.03085
G1 X128.985 Y137.712 E.02253
G2 X130.276 Y136.596 I-7.006 J-9.412 E.03543
G3 X133.154 Y136.903 I1.26 J1.825 E.0654
G1 X134.165 Y133.977 E.06422
G3 X133.007 Y132.954 I8.541 J-10.836 E.03206
G2 X130.583 Y132.906 I-1.246 J1.678 E.05366
G1 X130.047 Y134.517 E.0352
M204 S10000
G1 X128.499 Y143.951 F60000
G1 F9000
M204 S4000
G1 X130.196 Y143.951 E.0352
G3 X130.845 Y143.586 I1.607 J2.092 E.01549
G1 X132.132 Y139.861 E.08173
G2 X130.731 Y140.086 I-.371 J2.164 E.02995
G2 X129.366 Y141.254 I6.655 J9.164 E.03731
G3 X126.179 Y140.649 I-1.275 J-1.98 E.07421
G2 X123.879 Y139.916 I-1.732 J1.457 E.05282
G1 X125.226 Y143.711 E.08353
G3 X125.589 Y143.951 I-.324 J.884 E.00912
G1 X127.286 Y143.951 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X125.589 Y143.951 E-.64486
G1 X125.337 Y143.784 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L77
M991 S0 P76 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.6 I1.209 J-.137 P1  F60000
G1 X123.325 Y126.079 Z9.6
G1 Z9.32
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.72 F60000
G1 X119.605 Y114.987 Z9.72
G1 Z9.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.72 F60000
G1 X141.28 Y114.497 Z9.72
G1 Z9.32
M73 P79 R4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.555 Y112.049 Z9.72 F60000
G1 Z9.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X136.858 Y112.049 E.0352
G3 X134.166 Y112.049 I-1.346 J-1.594 E.0607
G1 X129.575 Y112.049 E.09523
G3 X126.883 Y112.049 I-1.346 J-1.594 E.0607
G1 X122.292 Y112.049 E.09523
G3 X119.6 Y112.049 I-1.346 J-1.594 E.0607
G1 X115.009 Y112.049 E.09523
G3 X114.704 Y112.281 I-.599 J-.471 E.00803
G1 X114.704 Y114.084 E.03742
G1 X115.103 Y115.188 E.02434
G3 X116.165 Y114.406 I2.573 J2.381 E.02752
G3 X118.441 Y115.013 I.606 J2.297 E.05112
G2 X119.554 Y115.976 I3.589 J-3.023 E.03065
G1 X120.841 Y119.821 E.0841
G3 X118.896 Y118.676 I.318 J-2.764 E.0482
G2 X116.201 Y118.282 I-1.58 J1.389 E.06145
G1 X117.413 Y121.697 E.07516
G3 X118.896 Y122.758 I-1.223 J3.275 E.03827
G2 X122.083 Y122.779 I1.603 J-1.46 E.07424
G3 X122.875 Y122.022 I5.665 J5.134 E.02275
G1 X125.373 Y122.022 E.05183
G3 X126.634 Y123.157 I-19.846 J23.317 E.0352
G2 X129.366 Y122.779 I1.126 J-1.922 E.06167
G3 X130.158 Y122.022 I5.667 J5.136 E.02275
G1 X132.656 Y122.022 E.05183
G3 X133.918 Y123.157 I-19.84 J23.311 E.0352
G2 X136.649 Y122.779 I1.126 J-1.922 E.06167
G3 X138.014 Y121.689 I3.262 J2.685 E.03651
G1 X138.439 Y121.608 E.00896
G1 X136.644 Y126.801 E.11397
G3 X133.918 Y126.421 I-1.122 J-1.924 E.06157
G2 X133.022 Y125.573 I-6.351 J5.811 E.02561
G1 X131.895 Y128.96 E.07404
G3 X133.462 Y130.041 I-1.07 J3.227 E.04002
G2 X135.283 Y130.741 I1.546 J-1.302 E.04222
G1 X134.187 Y133.914 E.06963
G3 X133.007 Y132.843 I27.224 J-31.158 E.03305
G2 X130.549 Y133.007 I-1.114 J1.808 E.05451
G1 X130.014 Y134.618 E.0352
; WIPE_START
G1 X130.549 Y133.007 E-.64486
G1 X130.813 Y132.859 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.642 Y134.193 Z9.72 F60000
G1 Z9.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.106 Y132.583 E.0352
G2 X122.993 Y133.221 I-.458 J2.302 E.04767
G3 X121.85 Y134.199 I-3.488 J-2.919 E.03134
G1 X122.74 Y136.706 E.05519
G3 X125.724 Y136.863 I1.411 J1.613 E.06857
G2 X126.852 Y137.833 I3.533 J-2.965 E.031
G1 X127.155 Y138.742 E.01988
G1 X128.642 Y138.742 E.03085
G1 X129.016 Y137.619 E.02455
G2 X130.276 Y136.485 I-19.888 J-23.362 E.03518
G3 X133.126 Y136.983 I1.123 J1.976 E.06506
G1 X132.146 Y139.819 E.06224
G2 X129.821 Y140.966 I-.121 J2.686 E.05611
G3 X128.455 Y141.681 I-1.638 J-1.465 E.03268
G3 X126.179 Y140.526 I-.037 J-2.747 E.05506
G2 X123.888 Y139.939 I-1.569 J1.362 E.05219
G1 X125.312 Y143.951 E.0883
G1 X130.067 Y143.951 E.09863
G3 X130.87 Y143.512 I1.333 J1.484 E.01916
G1 X131.424 Y141.908 E.0352
; WIPE_START
G1 X130.87 Y143.512 E-.64486
G1 X130.592 Y143.632 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.103 Y137.459 Z9.72 F60000
G1 X120.057 Y129.145 Z9.72
G1 Z9.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.624 Y130.744 E.0352
G2 X122.538 Y129.601 I-.364 J-2.782 E.04755
G3 X123.878 Y128.89 I1.63 J1.454 E.03214
G1 X122.92 Y126.011 E.06293
G3 X121.627 Y127.028 I-3.085 J-2.593 E.03436
G3 X118.943 Y126.007 I-.581 J-2.512 E.06318
G1 X118.375 Y124.408 E.0352
; WIPE_START
G1 X118.943 Y126.007 E-.64485
G1 X119.169 Y126.209 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.006 Y122.815 Z9.72 F60000
G1 X135.462 Y118.122 Z9.72
G1 Z9.32
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.933 Y119.735 E.0352
G2 X136.194 Y119.745 I.649 J-2.274 E.02646
G2 X137.559 Y118.655 I-1.896 J-3.775 E.03651
G3 X139.679 Y118.018 I1.656 J1.664 E.04782
G1 X140.607 Y115.334 E.0589
G1 X140.29 Y115.013 E.00935
G2 X137.559 Y114.635 I-1.605 J1.544 E.06167
G3 X136.212 Y115.837 I-18.116 J-18.942 E.03746
G1 X136.741 Y114.225 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.212 Y115.837 E-.64486
G1 X136.438 Y115.636 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L78
M991 S0 P77 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.72 I-.758 J-.952 P1  F60000
G1 X123.325 Y126.079 Z9.72
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.84 F60000
G1 X119.605 Y114.987 Z9.84
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.84 F60000
G1 X141.28 Y114.497 Z9.84
G1 Z9.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.702 Y112.049 Z9.84 F60000
G1 Z9.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.005 Y112.049 E.0352
G3 X134.828 Y112.407 I-1.344 J-1.373 E.04875
G3 X134.255 Y112.049 I.556 J-1.528 E.01413
G1 X129.722 Y112.049 E.09402
G3 X127.545 Y112.407 I-1.344 J-1.373 E.04875
G3 X126.971 Y112.049 I.556 J-1.528 E.01413
G1 X122.439 Y112.049 E.09402
G3 X120.262 Y112.407 I-1.344 J-1.373 E.04875
G3 X119.688 Y112.049 I.556 J-1.528 E.01413
G1 X115.156 Y112.049 E.09402
G3 X114.704 Y112.394 I-.776 J-.546 E.01198
G1 X114.704 Y114.084 E.03506
G1 X115.072 Y115.1 E.02241
G3 X116.165 Y114.32 I2.108 J1.797 E.02813
G3 X118.441 Y115.114 I.42 J2.455 E.05219
G2 X119.595 Y116.099 I2.747 J-2.051 E.03173
G1 X120.849 Y119.846 E.08196
G3 X118.896 Y118.545 I.581 J-2.989 E.04997
G2 X116.62 Y118.102 I-1.438 J1.321 E.05149
G1 X116.218 Y118.328 E.00957
G1 X117.418 Y121.709 E.07442
G3 X118.896 Y122.889 I-1.764 J3.726 E.03959
G2 X121.172 Y123.332 I1.438 J-1.321 E.05149
G2 X122.538 Y122.187 I-2.078 J-3.865 E.03722
G1 X122.73 Y122.022 E.00525
G1 X125.296 Y122.022 E.05322
G2 X126.634 Y123.278 I71.267 J-74.613 E.03808
G2 X129.366 Y122.678 I.972 J-2.089 E.06232
G3 X130.013 Y122.022 I3.133 J2.445 E.01916
G1 X132.579 Y122.022 E.05322
G2 X133.918 Y123.278 I71.385 J-74.739 E.03808
G2 X136.649 Y122.678 I.972 J-2.089 E.06232
G3 X138.014 Y121.603 I2.623 J1.927 E.03649
G1 X138.457 Y121.555 E.00924
G1 X136.596 Y126.943 E.11824
M73 P80 R4
G3 X133.918 Y126.32 I-.921 J-2.11 E.06112
G2 X133.053 Y125.478 I-4.035 J3.28 E.02508
G1 X131.894 Y128.964 E.0762
G3 X133.462 Y130.172 I-1.562 J3.651 E.0415
G2 X135.278 Y130.757 I1.392 J-1.213 E.04157
G1 X134.207 Y133.856 E.06802
G2 X133.007 Y132.722 I-30.7 J31.268 E.03424
G2 X130.514 Y133.114 I-.969 J1.965 E.05579
G1 X131.049 Y131.503 E.0352
; WIPE_START
G1 X130.514 Y133.114 E-.64486
G1 X130.767 Y132.947 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.616 Y134.117 Z9.84 F60000
G1 Z9.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.081 Y132.507 E.0352
G2 X122.993 Y133.322 I-.245 J2.456 E.04826
G3 X121.882 Y134.288 I-2.841 J-2.144 E.03076
G1 X122.706 Y136.609 E.05108
G1 X122.993 Y136.364 E.00784
G3 X125.724 Y136.964 I.972 J2.089 E.06232
G2 X126.893 Y137.955 I2.724 J-2.028 E.03205
G1 X127.155 Y138.742 E.01722
G1 X128.642 Y138.742 E.03085
G1 X129.047 Y137.523 E.02665
G3 X130.276 Y136.364 I36.07 J36.985 E.03504
G3 X133.099 Y137.062 I.973 J2.119 E.06513
G1 X132.164 Y139.768 E.05938
G2 X131.642 Y139.811 I-.166 J1.201 E.01095
G2 X129.821 Y141.097 I1.193 J3.621 E.04693
G3 X128 Y141.681 I-1.395 J-1.218 E.04168
G3 X126.179 Y140.394 I1.193 J-3.621 E.04693
G2 X123.894 Y139.957 I-1.452 J1.396 E.05145
G1 X125.312 Y143.951 E.08792
G1 X129.92 Y143.951 E.09559
G3 X130.897 Y143.434 I1.275 J1.228 E.02332
G1 X131.451 Y141.83 E.0352
; WIPE_START
G1 X130.897 Y143.434 E-.64486
G1 X130.61 Y143.532 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.094 Y137.38 Z9.84 F60000
G1 X120.064 Y129.166 Z9.84
G1 Z9.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.632 Y130.765 E.0352
G2 X122.538 Y129.47 I-.657 J-3.017 E.04899
G3 X123.862 Y128.841 I1.405 J1.25 E.03123
G1 X122.946 Y126.089 E.06015
G1 X122.538 Y126.531 E.01248
G3 X120.717 Y127.114 I-1.395 J-1.218 E.04168
G3 X118.872 Y125.808 I1.14 J-3.565 E.04763
G1 X118.305 Y124.209 E.0352
; WIPE_START
G1 X118.872 Y125.808 E-.64485
G1 X119.089 Y126.019 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.962 Y122.7 Z9.84 F60000
G1 X135.466 Y118.111 Z9.84
G1 Z9.44
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X134.937 Y119.724 E.0352
G2 X136.194 Y119.831 I.827 J-2.277 E.02647
G2 X137.559 Y118.756 I-1.257 J-3.002 E.03649
G3 X139.704 Y117.947 I1.844 J1.641 E.04944
G1 X140.576 Y115.423 E.0554
G1 X140.29 Y115.114 E.00872
G2 X137.559 Y114.514 I-1.759 J1.489 E.06232
G2 X136.24 Y115.753 I61.255 J66.544 E.03755
G1 X136.769 Y114.141 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.56
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F9000
G1 X136.24 Y115.753 E-.64486
G1 X136.461 Y115.546 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L79
M991 S0 P78 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.84 I-.761 J-.949 P1  F60000
G1 X123.325 Y126.079 Z9.84
G1 Z9.56
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z9.96 F60000
G1 X119.605 Y114.987 Z9.96
G1 Z9.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z9.96 F60000
G1 X141.28 Y114.497 Z9.96
G1 Z9.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.857 Y112.049 Z9.96 F60000
G1 Z9.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.16 Y112.049 E.0352
G3 X134.828 Y112.393 I-1.371 J-1.216 E.05312
G3 X134.327 Y112.049 I.433 J-1.165 E.01274
G1 X129.877 Y112.049 E.09231
G3 X127.545 Y112.393 I-1.371 J-1.216 E.05312
G3 X127.044 Y112.049 I.433 J-1.165 E.01274
G1 X122.594 Y112.049 E.09231
G3 X120.262 Y112.393 I-1.371 J-1.216 E.05312
G3 X119.761 Y112.049 I.433 J-1.165 E.01274
G1 X115.311 Y112.049 E.09231
G3 X114.704 Y112.521 I-2.259 J-2.278 E.01598
G1 X114.704 Y114.084 E.03244
G1 X115.035 Y114.995 E.0201
G3 X116.165 Y114.225 I1.837 J1.48 E.02879
G3 X117.986 Y114.77 I.256 J2.459 E.04047
G2 X119.351 Y116.13 I5.948 J-4.607 E.04008
G1 X119.638 Y116.227 E.00628
G1 X120.861 Y119.879 E.07989
G3 X119.807 Y119.381 I.632 J-2.7 E.02437
G2 X118.441 Y118.021 I-5.947 J4.606 E.04008
G2 X116.232 Y118.368 I-.803 J2.093 E.04856
G1 X117.42 Y121.715 E.07366
G3 X117.986 Y122.053 I-.526 J1.523 E.01378
G2 X119.351 Y123.413 I5.948 J-4.607 E.04009
G2 X121.627 Y123.023 I.807 J-2.127 E.05024
G1 X122.561 Y122.022 E.02839
G1 X125.269 Y122.053 E.05617
G2 X126.634 Y123.413 I5.947 J-4.606 E.04009
G2 X128.91 Y123.023 I.807 J-2.127 E.05024
G1 X129.844 Y122.022 E.02839
G1 X132.552 Y122.053 E.05617
G2 X133.918 Y123.413 I5.948 J-4.607 E.04009
G2 X136.194 Y123.023 I.807 J-2.127 E.05024
G3 X137.559 Y121.663 I5.947 J4.606 E.04008
G3 X138.477 Y121.498 I.839 J2.037 E.01949
G1 X136.545 Y127.09 E.12272
G3 X134.373 Y126.664 I-.705 J-2.158 E.04795
G2 X133.089 Y125.372 I-5.645 J4.326 E.03789
G1 X133.153 Y125.178 E.00424
G2 X131.884 Y125.178 I-.635 J9.581 E.02635
G1 X125.353 Y125.178 E.13547
G2 X122.904 Y125.178 I-1.225 J29.669 E.05082
M204 S10000
G1 X118.232 Y124.003 F60000
G1 F9000
M204 S4000
G1 X118.8 Y125.603 E.0352
G3 X119.807 Y126.664 I-3.605 J4.429 E.03043
G2 X122.083 Y127.054 I1.469 J-1.736 E.05024
G2 X122.982 Y126.197 I-2.872 J-3.912 E.02585
G1 X123.842 Y128.781 E.0565
G2 X122.538 Y129.325 I-.09 J1.621 E.03032
G1 X121.627 Y130.306 E.02776
G3 X120.641 Y130.791 I-1.778 J-2.367 E.02294
G1 X120.074 Y129.192 E.0352
; WIPE_START
G1 X120.641 Y130.791 E-.64486
G1 X120.926 Y130.689 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.195 Y136.211 Z9.96 F60000
G1 X131.48 Y141.748 Z9.96
G1 Z9.56
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.925 Y143.352 E.0352
G2 X129.821 Y143.891 I.09 J1.587 E.02617
G1 X129.714 Y143.951 E.00255
G1 X125.312 Y143.951 E.09131
G1 X123.898 Y139.969 E.08766
G3 X125.724 Y139.87 I1.023 J1.994 E.03907
G3 X127.09 Y141.23 I-4.582 J5.967 E.04009
G2 X129.366 Y141.621 I1.469 J-1.736 E.05024
G2 X130.731 Y140.261 I-4.581 J-5.966 E.04008
G3 X132.185 Y139.707 I1.557 J1.902 E.03284
G1 X133.062 Y137.169 E.0557
G2 X130.731 Y136.074 I-2.116 J1.476 E.05592
G2 X129.821 Y136.608 I.241 J1.454 E.02239
G1 X129.09 Y137.395 E.02229
G1 X128.642 Y138.742 E.02945
G1 X127.155 Y138.742 E.03085
G1 X126.935 Y138.081 E.01445
G3 X126.179 Y137.6 I.25 J-1.226 E.019
G1 X125.269 Y136.619 E.02776
G2 X122.993 Y136.229 I-1.469 J1.736 E.05024
G1 X122.667 Y136.5 E.00879
G1 X121.919 Y134.393 E.04637
G1 X122.083 Y134.338 E.00357
G2 X123.448 Y132.978 I-4.582 J-5.967 E.04008
G3 X125.054 Y132.427 I1.54 J1.875 E.03598
G1 X125.59 Y134.038 E.0352
; WIPE_START
G1 X125.054 Y132.427 E-.64486
G1 X124.753 Y132.461 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.999 Y131.656 Z9.96 F60000
G1 Z9.56
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.463 Y133.267 E.0352
G3 X133.007 Y132.587 I1.741 J1.415 E.05838
G3 X134.229 Y133.792 I-4.053 J5.331 E.03569
G1 X135.27 Y130.78 E.06611
G3 X133.918 Y130.696 I-.559 J-1.925 E.02866
G3 X132.552 Y129.336 I4.582 J-5.967 E.04008
G2 X131.894 Y128.962 I-1.223 J1.386 E.0158
G1 X132.43 Y127.352 E.0352
M204 S10000
G1 X135.467 Y118.107 F60000
G1 F9000
M204 S4000
G1 X134.938 Y119.719 E.0352
G2 X136.649 Y119.771 I.912 J-1.844 E.03661
G2 X138.014 Y118.411 I-4.582 J-5.967 E.04008
G3 X139.733 Y117.864 I1.548 J1.887 E.03832
G1 X140.54 Y115.529 E.05124
G1 X139.835 Y114.77 E.02148
G2 X137.559 Y114.38 I-1.469 J1.736 E.05024
G2 X136.272 Y115.655 I4.294 J5.621 E.03769
G1 X135.743 Y117.267 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.272 Y115.655 E-.64486
G1 X136.478 Y115.433 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L80
M991 S0 P79 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z9.96 I-.766 J-.946 P1  F60000
G1 X123.325 Y126.079 Z9.96
G1 Z9.68
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.08 F60000
G1 X119.605 Y114.987 Z10.08
G1 Z9.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
M73 P81 R4
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.08 F60000
G1 X141.28 Y114.497 Z10.08
G1 Z9.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.991 Y112.049 Z10.08 F60000
G1 Z9.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.294 Y112.049 E.0352
G3 X135.283 Y112.598 I-1.316 J-.861 E.04726
G3 X134.376 Y112.049 I.87 J-2.462 E.02216
G1 X130.011 Y112.049 E.09054
G3 X128 Y112.598 I-1.316 J-.861 E.04726
G3 X127.093 Y112.049 I.87 J-2.462 E.02216
G1 X122.728 Y112.049 E.09054
G3 X120.717 Y112.598 I-1.316 J-.861 E.04726
G3 X119.809 Y112.049 I.87 J-2.462 E.02216
G1 X115.444 Y112.049 E.09054
G3 X114.704 Y112.665 I-1.799 J-1.408 E.02013
G1 X114.704 Y114.084 E.02945
G1 X115 Y114.897 E.01794
G3 X115.71 Y114.225 I1.987 J1.389 E.02041
G3 X117.986 Y114.821 I.602 J2.345 E.05096
G1 X118.896 Y115.919 E.02959
G1 X119.351 Y116.284 E.0121
G1 X119.683 Y116.362 E.00707
G1 X120.875 Y119.923 E.07789
G3 X119.807 Y119.33 I.846 J-2.783 E.02555
G1 X118.896 Y118.232 E.02959
G2 X117.531 Y117.791 I-1.071 J.98 E.03114
G2 X116.244 Y118.403 I.564 J2.839 E.02986
G1 X117.419 Y121.713 E.07284
G3 X117.986 Y122.104 I-.66 J1.561 E.01438
G1 X118.896 Y123.202 E.02959
G2 X120.262 Y123.643 I1.071 J-.98 E.03114
G2 X121.627 Y122.971 I-.594 J-2.93 E.03192
G1 X122.414 Y122.022 E.02557
G1 X125.159 Y122.022 E.05692
G1 X126.179 Y123.202 E.03237
G2 X127.545 Y123.643 I1.071 J-.98 E.03114
G2 X128.91 Y122.971 I-.594 J-2.93 E.03192
G1 X129.697 Y122.022 E.02557
G1 X132.442 Y122.022 E.05692
G1 X133.462 Y123.202 E.03237
G2 X134.828 Y123.643 I1.071 J-.98 E.03114
G2 X136.194 Y122.971 I-.594 J-2.93 E.03192
G1 X137.104 Y121.873 E.02959
G3 X138.497 Y121.439 I1.034 J.866 E.03198
G1 X136.491 Y127.246 E.12743
G3 X134.373 Y126.613 I-.438 J-2.394 E.0476
G1 X133.462 Y125.515 E.02959
G1 X133.13 Y125.248 E.00884
G1 X133.153 Y125.178 E.00154
G2 X131.704 Y125.178 I-.725 J2.417 E.03049
G1 X125.724 Y125.15 E.12404
G2 X124.421 Y125.178 I-.61 J1.949 E.02752
G1 X122.724 Y125.178 E.0352
M204 S10000
G1 X118.15 Y123.772 F60000
G1 F9000
M204 S4000
G1 X118.718 Y125.372 E.0352
G1 X119.807 Y126.613 E.03425
G2 X122.083 Y127.209 I1.674 J-1.749 E.05096
G2 X123.009 Y126.276 I-1.803 J-2.716 E.02745
G1 X123.818 Y128.709 E.05319
G2 X122.538 Y129.156 I-.233 J1.388 E.02934
G1 X121.627 Y130.254 E.02959
G3 X120.652 Y130.823 I-2.059 J-2.41 E.02354
G1 X120.085 Y129.224 E.0352
; WIPE_START
G1 X120.652 Y130.823 E-.64486
G1 X120.93 Y130.701 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.561 Y130.602 Z10.08 F60000
G1 X131.361 Y130.565 Z10.08
G1 Z9.68
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X131.897 Y128.955 E.0352
G3 X132.552 Y129.387 I-.715 J1.795 E.0164
G1 X133.462 Y130.485 E.02959
G2 X134.828 Y130.927 I1.071 J-.98 E.03114
G1 X135.258 Y130.812 E.00924
G1 X134.246 Y133.743 E.06431
G1 X133.462 Y132.798 E.02546
G2 X132.097 Y132.357 I-1.071 J.98 E.03114
G2 X130.415 Y133.41 I.437 J2.567 E.04222
G1 X129.88 Y135.02 E.0352
; WIPE_START
G1 X130.415 Y133.41 E-.64485
G1 X130.609 Y133.177 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.562 Y133.952 Z10.08 F60000
G1 Z9.68
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.026 Y132.342 E.0352
G2 X123.448 Y133.029 I.18 J2.57 E.03639
G1 X122.538 Y134.127 E.02959
G1 X122.083 Y134.492 E.0121
G1 X121.964 Y134.52 E.00252
G1 X122.622 Y136.372 E.04077
G1 X122.993 Y136.075 E.00987
G3 X125.269 Y136.671 I.602 J2.345 E.05096
G1 X126.179 Y137.769 E.02959
G1 X126.634 Y138.133 E.0121
G1 X126.979 Y138.215 E.00735
G1 X127.155 Y138.742 E.01153
G1 X128.642 Y138.742 E.03085
G1 X129.131 Y137.271 E.03216
G1 X129.821 Y136.44 E.02241
G3 X130.731 Y135.967 I.953 J.723 E.02199
G3 X133.034 Y137.251 I-.026 J2.753 E.05702
G1 X132.211 Y139.632 E.05225
G2 X130.731 Y140.312 I.288 J2.576 E.03436
G1 X129.821 Y141.41 E.02959
G1 X129.366 Y141.775 E.0121
G3 X127.09 Y141.179 I-.602 J-2.345 E.05096
G1 X126.179 Y140.081 E.02959
G1 X125.724 Y139.716 E.0121
G2 X123.9 Y139.975 I-.602 J2.317 E.03922
G1 X125.312 Y143.951 E.08752
G1 X129.515 Y143.951 E.08718
G1 X129.821 Y143.723 E.00793
G3 X130.955 Y143.266 I1.022 J.901 E.02631
G1 X131.51 Y141.662 E.0352
M204 S10000
G1 X135.467 Y118.108 F60000
G1 F9000
M204 S4000
G1 X134.938 Y119.72 E.0352
G2 X135.738 Y120.002 I1.188 J-2.099 E.01769
G2 X137.104 Y119.561 I.295 J-1.421 E.03114
G1 X138.014 Y118.463 E.02959
G3 X139.767 Y117.764 I1.776 J1.908 E.04005
G1 X140.505 Y115.629 E.04685
G1 X139.835 Y114.821 E.02176
G2 X138.47 Y114.149 I-1.96 J2.258 E.03192
G2 X137.104 Y114.59 I-.295 J1.421 E.03114
G1 X136.305 Y115.553 E.02595
G1 X135.776 Y117.166 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X136.305 Y115.553 E-.64486
G1 X136.499 Y115.32 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L81
M991 S0 P80 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.08 I-.77 J-.943 P1  F60000
G1 X123.325 Y126.079 Z10.08
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.2 F60000
G1 X119.605 Y114.987 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.2 F60000
G1 X141.28 Y114.497 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.118 Y112.049 Z10.2 F60000
G1 Z9.8
M73 P82 R4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.421 Y112.049 E.0352
G3 X136.649 Y112.825 I-1.612 J-.831 E.02308
G1 X136.194 Y112.871 E.00949
G3 X134.432 Y112.049 I.32 J-2.983 E.04106
G1 X130.138 Y112.049 E.08907
G3 X129.366 Y112.825 I-1.612 J-.831 E.02308
G1 X128.91 Y112.871 E.00949
G3 X127.149 Y112.049 I.32 J-2.983 E.04106
G1 X122.855 Y112.049 E.08907
G3 X122.083 Y112.825 I-1.612 J-.831 E.02308
G1 X121.627 Y112.871 E.00949
G3 X119.866 Y112.049 I.32 J-2.983 E.04106
G1 X115.572 Y112.049 E.08907
G3 X114.704 Y112.835 I-1.562 J-.853 E.02475
G1 X114.704 Y114.084 E.02592
G1 X114.961 Y114.787 E.0155
G3 X115.71 Y114.043 I1.549 J.81 E.02225
G1 X116.165 Y113.997 E.00949
G3 X117.986 Y114.87 I-.339 J3.042 E.04268
G1 X118.896 Y116.129 E.03223
G1 X119.351 Y116.467 E.01176
G1 X119.731 Y116.505 E.00791
G1 X120.888 Y119.962 E.07562
G3 X119.807 Y119.281 I.833 J-2.524 E.02677
G1 X118.896 Y118.022 E.03223
G1 X118.441 Y117.684 E.01176
G1 X117.986 Y117.638 E.00949
G2 X116.255 Y118.434 I.312 J2.956 E.04022
G1 X117.415 Y121.702 E.07193
G3 X117.986 Y122.153 I-.797 J1.596 E.01519
G1 X118.896 Y123.412 E.03223
G1 X119.351 Y123.75 E.01176
G1 X119.807 Y123.796 E.00949
G2 X121.627 Y122.923 I-.339 J-3.042 E.04268
G1 X122.278 Y122.022 E.02305
G1 X125.115 Y122.022 E.05884
G1 X125.269 Y122.153 E.00419
G1 X126.179 Y123.412 E.03223
G1 X126.634 Y123.75 E.01176
G1 X127.09 Y123.796 E.00949
G2 X128.91 Y122.923 I-.339 J-3.042 E.04268
G1 X129.561 Y122.022 E.02305
G1 X132.398 Y122.022 E.05884
G1 X132.552 Y122.153 E.00419
G1 X133.462 Y123.412 E.03223
G1 X133.918 Y123.75 E.01176
G1 X134.373 Y123.796 E.00949
G2 X136.194 Y122.923 I-.339 J-3.042 E.04268
G1 X137.104 Y121.663 E.03223
G1 X137.559 Y121.326 E.01176
G3 X138.508 Y121.408 I.363 J1.323 E.02017
G1 X136.433 Y127.413 E.13178
G1 X136.194 Y127.437 E.00499
G3 X134.373 Y126.564 I.339 J-3.042 E.04268
G1 X133.462 Y125.305 E.03223
G1 X133.007 Y124.967 E.01176
G1 X132.552 Y124.922 E.00949
G1 X131.606 Y125.178 E.02034
G1 X126.008 Y125.178 E.1161
G2 X125.269 Y124.922 I-.584 J.491 E.01704
G1 X124.322 Y125.178 E.02034
G1 X122.649 Y125.195 E.03471
M204 S10000
G1 X120.096 Y129.257 F60000
G1 F9000
M204 S4000
G1 X120.664 Y130.856 E.0352
G2 X121.627 Y130.206 I-1.247 J-2.887 E.02425
G1 X122.538 Y128.946 E.03223
G3 X123.8 Y128.654 I.843 J.769 E.02857
G1 X123.037 Y126.363 E.0501
G3 X122.083 Y127.391 I-2.101 J-.993 E.02957
G3 X119.807 Y126.564 I-.32 J-2.663 E.05212
G1 X118.896 Y125.305 E.03223
G1 X118.622 Y125.101 E.00709
G1 X118.054 Y123.502 E.0352
; WIPE_START
G1 X118.622 Y125.101 E-.64485
G1 X118.865 Y125.282 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.448 Y117.815 Z10.2 F60000
G1 X121.239 Y114.084 Z10.2
G1 Z9.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X122.936 Y114.084 E.0352
G3 X123.785 Y114.084 I.425 J1.206 E.01795
G1 X130.219 Y114.084 E.13346
G3 X131.069 Y114.084 I.425 J1.206 E.01795
G1 X132.766 Y114.084 E.0352
; WIPE_START
G1 X131.069 Y114.084 E-.64486
G1 X130.775 Y114.008 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.817 Y117.04 Z10.2 F60000
G1 Z9.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.347 Y115.428 E.0352
G1 X137.104 Y114.38 E.02682
G1 X137.559 Y114.043 E.01176
G1 X138.014 Y113.997 E.00949
G3 X139.835 Y114.87 I-.339 J3.042 E.04268
G1 X140.466 Y115.742 E.02233
G1 X139.808 Y117.645 E.04177
G2 X138.014 Y118.511 I.347 J3.01 E.0421
G1 X137.104 Y119.771 E.03223
G1 X136.649 Y120.108 E.01176
G1 X136.194 Y120.154 E.00949
G1 X135.283 Y119.917 E.01951
G1 X134.936 Y119.727 E.00822
G1 X135.465 Y118.115 E.0352
M204 S10000
G1 X131.366 Y130.552 F60000
G1 F9000
M204 S4000
G1 X131.901 Y128.942 E.0352
G3 X132.552 Y129.436 I-.862 J1.81 E.01707
G1 X133.462 Y130.695 E.03223
G1 X133.918 Y131.033 E.01176
G1 X134.373 Y131.079 E.00949
G1 X135.245 Y130.852 E.01869
G1 X134.262 Y133.695 E.06238
G1 X133.462 Y132.588 E.02833
G1 X133.007 Y132.25 E.01176
G1 X132.552 Y132.205 E.00949
G2 X130.351 Y133.604 I.247 J2.82 E.05622
G1 X129.815 Y135.214 E.0352
; WIPE_START
G1 X130.351 Y133.604 E-.64486
G1 X130.528 Y133.358 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.539 Y133.884 Z10.2 F60000
G1 Z9.8
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.003 Y132.274 E.0352
G2 X123.448 Y133.078 I.434 J2.745 E.03694
G1 X122.538 Y134.337 E.03223
G1 X122.021 Y134.681 E.01287
G1 X122.564 Y136.21 E.03366
G1 X122.993 Y135.892 E.01107
G3 X125.269 Y136.719 I.32 J2.663 E.05212
G1 X126.179 Y137.979 E.03223
G1 X126.634 Y138.316 E.01176
G1 X127.026 Y138.355 E.00816
G1 X127.155 Y138.742 E.00846
G1 X128.642 Y138.742 E.03085
G1 X129.185 Y137.109 E.03571
G1 X129.821 Y136.23 E.0225
G1 X130.276 Y135.892 E.01176
G3 X133.002 Y137.342 I.282 J2.757 E.06793
G1 X132.232 Y139.571 E.04892
G2 X130.731 Y140.361 I.458 J2.69 E.03577
G1 X129.821 Y141.62 E.03223
G1 X129.366 Y141.958 E.01176
G3 X127.09 Y141.13 I-.32 J-2.663 E.05212
G1 X126.179 Y139.871 E.03223
G1 X125.724 Y139.533 E.01176
G1 X125.269 Y139.488 E.00949
G2 X123.901 Y139.975 I.546 J3.695 E.03032
G1 X125.312 Y143.951 E.08751
G1 X129.372 Y143.951 E.08422
G1 X129.821 Y143.513 E.01302
G3 X130.98 Y143.194 I.826 J.738 E.02636
G1 X131.534 Y141.59 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 9.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.98 Y143.194 E-.64486
G1 X130.731 Y143.129 E-.09768
G1 X130.686 Y143.134 E-.01746
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L82
M991 S0 P81 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.2 I1.117 J-.482 P1  F60000
G1 X123.325 Y126.079 Z10.2
G1 Z9.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.32 F60000
G1 X119.605 Y114.987 Z10.32
G1 Z9.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P82 R3
G1 X128.259 Y115.926 Z10.32 F60000
G1 X141.28 Y114.497 Z10.32
G1 Z9.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.215 Y112.049 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X137.518 Y112.049 E.0352
G1 X137.104 Y112.789 E.01759
G1 X136.649 Y113.053 E.01092
G1 X136.194 Y113.008 E.00949
G3 X134.473 Y112.049 I.676 J-3.233 E.0415
G1 X130.235 Y112.049 E.08792
G1 X129.821 Y112.789 E.01759
G1 X129.366 Y113.053 E.01092
G1 X128.91 Y113.008 E.00949
G3 X127.19 Y112.049 I.676 J-3.233 E.0415
G1 X122.951 Y112.049 E.08792
G1 X122.538 Y112.789 E.01759
G1 X122.083 Y113.053 E.01092
G1 X121.627 Y113.008 E.00949
G3 X119.907 Y112.049 I.676 J-3.233 E.0415
G1 X115.668 Y112.049 E.08792
G1 X115.255 Y112.789 E.01759
G1 X114.799 Y113.053 E.01092
G1 X114.704 Y113.044 E.00198
G1 X114.704 Y114.084 E.02159
G1 X114.921 Y114.675 E.01305
G1 X115.255 Y114.079 E.01417
G1 X115.71 Y113.815 E.01092
G3 X117.531 Y114.475 I-.476 J4.154 E.04054
G3 X118.896 Y116.431 I-4.639 J4.694 E.04975
G1 X119.351 Y116.695 E.01092
G1 X119.78 Y116.653 E.00894
G1 X118.92 Y114.084 E.05617
G1 X122.534 Y114.084 E.07497
G1 X122.993 Y113.815 E.01103
G3 X124.07 Y114.084 I.009 J2.251 E.02328
G1 X129.818 Y114.084 E.11921
G1 X130.276 Y113.815 E.01103
G3 X131.353 Y114.084 I.009 J2.251 E.02328
G1 X133.05 Y114.084 E.0352
; WIPE_START
G1 X131.353 Y114.084 E-.64486
G1 X131.069 Y113.981 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.864 Y116.899 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X136.393 Y115.287 E.0352
G2 X137.104 Y114.079 I-8.634 J-5.896 E.0291
G1 X137.559 Y113.815 E.01092
G1 X138.014 Y113.859 E.00949
G3 X140.426 Y115.858 I-.741 J3.348 E.06747
G1 X139.835 Y117.501 E.03621
G2 X137.559 Y119.258 I.634 J3.174 E.06179
G1 X137.104 Y120.072 E.01936
G1 X136.649 Y120.336 E.01092
G1 X136.194 Y120.292 E.00949
G3 X134.931 Y119.741 I.636 J-3.18 E.02879
G1 X135.46 Y118.128 E.0352
; WIPE_START
G1 X134.931 Y119.741 E-.64486
G1 X135.188 Y119.902 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.787 Y121.769 Z10.32 F60000
G1 X126.783 Y122.022 Z10.32
G1 Z9.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X125.086 Y122.022 E.0352
G3 X126.179 Y123.714 I-5.861 J4.987 E.0419
G1 X126.634 Y123.978 E.01092
G1 X127.09 Y123.933 E.00949
G2 X129.452 Y122.022 I-.717 J-3.302 E.06537
G1 X132.369 Y122.022 E.06051
G3 X133.462 Y123.714 I-5.862 J4.987 E.0419
G1 X133.918 Y123.978 E.01092
G1 X134.373 Y123.933 E.00949
G2 X136.649 Y122.176 I-.634 J-3.174 E.06179
G1 X137.104 Y121.362 E.01936
G1 X137.559 Y121.098 E.01092
G3 X138.535 Y121.331 I.03 J2.032 E.02102
G1 X136.371 Y127.592 E.13741
G1 X136.194 Y127.575 E.0037
G3 X133.918 Y125.818 I.634 J-3.174 E.06179
G1 X133.462 Y125.003 E.01936
G1 X133.007 Y124.739 E.01092
G1 X132.552 Y124.784 E.00949
G1 X131.539 Y125.178 E.02254
G1 X126.277 Y125.178 E.10916
G1 X126.179 Y125.003 E.00415
G1 X125.724 Y124.739 E.01092
G1 X125.269 Y124.784 E.00949
G1 X124.256 Y125.178 E.02254
G1 X122.643 Y125.178 E.03345
G1 X122.67 Y125.258 E.00175
M204 S10000
G1 X120.112 Y129.301 F60000
G1 F9000
M204 S4000
G1 X120.68 Y130.9 E.0352
G2 X122.083 Y129.46 I-1.397 J-2.764 E.04248
G1 X122.538 Y128.645 E.01936
G1 X122.993 Y128.381 E.01092
G3 X123.761 Y128.539 I.074 J1.587 E.01644
G1 X123.061 Y126.435 E.04598
G2 X122.538 Y127.355 I6.587 J4.359 E.02198
G1 X122.083 Y127.619 E.01092
G1 X121.627 Y127.575 E.00949
G3 X119.351 Y125.818 I.634 J-3.174 E.06179
G1 X118.896 Y125.003 E.01936
G1 X118.507 Y124.777 E.00934
G1 X117.408 Y121.681 E.06816
G3 X118.441 Y122.899 I-2.106 J2.834 E.03343
G1 X118.896 Y123.714 E.01936
G1 X119.351 Y123.978 E.01092
G1 X119.807 Y123.933 E.00949
G2 X122.169 Y122.022 I-.717 J-3.302 E.06537
G1 X121.578 Y122.022 E.01225
G1 X120.912 Y120.033 E.04352
G3 X119.351 Y118.535 I1.157 J-2.767 E.0459
G1 X118.896 Y117.72 E.01936
G1 X118.441 Y117.456 E.01092
G1 X117.986 Y117.501 E.00949
G2 X116.265 Y118.461 I.676 J3.234 E.04151
G1 X115.697 Y116.862 E.0352
; WIPE_START
G1 X116.265 Y118.461 E-.64486
G1 X116.482 Y118.25 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.37 Y123.107 Z10.32 F60000
G1 X131.372 Y130.533 Z10.32
G1 Z9.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X131.908 Y128.922 E.0352
G3 X133.007 Y130.182 I-1.928 J2.792 E.03505
G1 X133.462 Y130.997 E.01936
G1 X133.918 Y131.261 E.01092
G2 X135.225 Y130.908 I-.04 J-2.745 E.02839
G1 X134.277 Y133.653 E.06026
M73 P83 R3
G3 X133.462 Y132.287 I9.764 J-6.743 E.03303
G1 X133.007 Y132.022 E.01092
G1 X132.552 Y132.067 E.00949
G2 X130.28 Y133.819 I.633 J3.171 E.06166
G1 X129.744 Y135.429 E.0352
; WIPE_START
G1 X130.28 Y133.819 E-.64485
G1 X130.445 Y133.564 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.506 Y133.785 Z10.32 F60000
G1 Z9.92
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X124.97 Y132.175 E.0352
G2 X123.903 Y132.683 I.635 J2.709 E.0247
G2 X122.538 Y134.638 I4.638 J4.694 E.04975
G1 X122.097 Y134.894 E.01057
G1 X122.493 Y136.009 E.02453
G1 X122.538 Y135.928 E.00191
G1 X122.993 Y135.664 E.01092
G3 X124.814 Y136.324 I-.476 J4.154 E.04054
G3 X126.179 Y138.28 I-4.638 J4.693 E.04975
G1 X126.634 Y138.544 E.01092
G1 X127.074 Y138.501 E.00917
G1 X127.155 Y138.742 E.00528
G1 X128.642 Y138.742 E.03085
G3 X129.821 Y135.928 I9.18 J2.191 E.06357
G1 X130.276 Y135.664 E.01092
G3 X132.976 Y137.417 I-.158 J3.199 E.06997
G1 X132.273 Y139.451 E.04463
G2 X131.186 Y139.966 I.641 J2.759 E.02514
G2 X129.821 Y141.922 I4.638 J4.693 E.04975
G1 X129.366 Y142.186 E.01092
G3 X127.545 Y141.525 I.476 J-4.154 E.04054
G3 X126.179 Y139.57 I4.639 J-4.694 E.04975
G1 X125.724 Y139.306 E.01092
G1 X125.269 Y139.35 E.00949
G2 X123.899 Y139.97 I1.096 J4.245 E.03135
G1 X125.312 Y143.951 E.08762
G1 X129.407 Y143.951 E.08495
G1 X129.821 Y143.211 E.01759
G1 X130.276 Y142.947 E.01092
G3 X131.014 Y143.094 I.08 J1.524 E.01578
G1 X131.569 Y141.49 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X131.014 Y143.094 E-.64486
G1 X130.731 Y142.992 E-.11446
G1 X130.729 Y142.992 E-.00069
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L83
M991 S0 P82 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.32 I1.115 J-.488 P1  F60000
G1 X123.325 Y126.079 Z10.32
G1 Z10.04
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.44 F60000
G1 X119.605 Y114.987 Z10.44
G1 Z10.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.44 F60000
G1 X141.28 Y114.497 Z10.44
G1 Z10.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.461 Y113.981 Z10.44 F60000
G1 X133.202 Y114.084 Z10.44
G1 Z10.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X131.505 Y114.084 E.0352
G2 X130.164 Y113.434 I-3.966 J6.469 E.03098
G3 X130.159 Y112.523 I.778 J-.459 E.01979
G1 X130.361 Y112.049 E.0107
G1 X127.199 Y112.049 E.06558
G2 X128.475 Y112.979 I3.046 J-2.838 E.03294
G1 X129.478 Y113.434 E.02286
G1 X129.604 Y113.889 E.00979
G1 X129.552 Y114.084 E.00419
G1 X124.222 Y114.084 E.11055
G2 X122.88 Y113.434 I-3.966 J6.469 E.03098
G3 X122.876 Y112.523 I.778 J-.459 E.01979
G1 X123.078 Y112.049 E.0107
G1 X119.916 Y112.049 E.06558
G2 X121.191 Y112.979 I3.046 J-2.838 E.03294
G1 X122.195 Y113.434 E.02286
G1 X122.32 Y113.889 E.00979
G1 X122.269 Y114.084 E.00419
G1 X118.92 Y114.084 E.06945
G1 X119.832 Y116.807 E.05954
G1 X119.239 Y117.075 E.01351
G2 X119.234 Y117.986 I.778 J.459 E.01979
G2 X120.94 Y120.116 I3.227 J-.835 E.05833
G1 X121.578 Y122.022 E.04168
G1 X122.032 Y122.022 E.00941
G3 X120.243 Y123.903 I-2.923 J-.989 E.05558
G1 X119.239 Y124.359 E.02286
G2 X119.234 Y125.269 I.778 J.459 E.01979
G2 X121.191 Y127.545 I3.318 J-.874 E.06444
G1 X122.195 Y128 E.02286
G3 X122.2 Y128.911 I-.778 J.459 E.01979
G3 X120.69 Y130.928 I-3.208 J-.827 E.05362
G1 X118.385 Y124.435 E.14291
G1 X118.554 Y124.359 E.00384
G2 X118.558 Y123.448 I-.778 J-.459 E.01979
G2 X117.389 Y121.628 I-3.524 J.978 E.04556
G1 X116.268 Y118.47 E.06951
G3 X117.55 Y117.531 I2.996 J2.744 E.03318
G1 X118.554 Y117.075 E.02286
G2 X118.558 Y116.165 I-.778 J-.459 E.01979
G2 X116.601 Y113.889 I-3.318 J.874 E.06444
G1 X115.597 Y113.434 E.02286
G3 X115.593 Y112.523 I.778 J-.459 E.01979
G1 X115.795 Y112.049 E.0107
G1 X114.704 Y112.049 E.02262
G1 X114.704 Y113.34 E.02678
G1 X114.912 Y113.434 E.00473
G3 X114.917 Y114.344 I-.778 J.459 E.01979
G1 X114.855 Y114.489 E.00326
G1 X115.423 Y116.088 E.0352
M204 S10000
G1 X122.886 Y125.178 F60000
G1 F9000
M204 S4000
G1 X122.643 Y125.178 E.00504
G1 X123.102 Y126.558 E.03016
G2 X122.755 Y127.545 I3.259 J1.7 E.02178
G1 X122.88 Y128 E.00979
G1 X123.707 Y128.375 E.01882
G1 X124.93 Y132.053 E.0804
G2 X122.755 Y134.828 I1.485 J3.404 E.0762
G1 X122.88 Y135.283 E.00979
G3 X124.671 Y136.194 I-3.714 J9.525 E.04174
G3 X125.962 Y138.47 I-2.886 J3.141 E.05516
G1 X125.837 Y138.925 E.00979
G2 X123.9 Y139.975 I2.672 J7.24 E.04584
G1 X123.333 Y138.375 E.0352
M204 S10000
G1 X126.589 Y137.041 F60000
G1 F9000
M204 S4000
G1 X127.124 Y138.652 E.0352
G1 X126.522 Y138.925 E.01372
G2 X126.517 Y139.835 I.778 J.459 E.01979
G2 X128.475 Y142.111 I3.318 J-.874 E.06444
G1 X129.478 Y142.566 E.02286
G3 X129.483 Y143.477 I-.778 J.459 E.01979
G1 X129.281 Y143.951 E.0107
G1 X130.718 Y143.951 E.02982
G1 X131.057 Y142.972 E.0215
G1 X130.164 Y142.566 E.02035
G3 X130.159 Y141.656 I.778 J-.459 E.01979
G3 X132.332 Y139.282 I3.369 J.902 E.06938
G1 X132.929 Y137.554 E.03792
G2 X131.167 Y135.738 I-2.885 J1.036 E.05409
G1 X130.164 Y135.283 E.02286
G3 X130.159 Y134.373 I.778 J-.459 E.01979
G3 X132.116 Y132.097 I3.318 J.874 E.06444
G1 X133.12 Y131.642 E.02286
G2 X133.124 Y130.731 I-.778 J-.459 E.01979
G2 X131.919 Y128.89 I-3.392 J.905 E.04644
G1 X133.153 Y125.178 E.08114
G1 X131.486 Y125.178 E.03457
G3 X133.12 Y124.359 I4.966 J7.862 E.03797
G2 X133.124 Y123.448 I-.778 J-.459 E.01979
G2 X132.366 Y122.022 I-3.867 J1.141 E.03373
G1 X129.315 Y122.022 E.06329
G3 X127.526 Y123.903 I-2.923 J-.989 E.05558
G1 X126.522 Y124.359 E.02286
G2 X126.493 Y125.178 I.688 J.434 E.01782
G1 X124.203 Y125.178 E.0475
G3 X125.837 Y124.359 I4.966 J7.863 E.03797
G2 X125.841 Y123.448 I-.778 J-.459 E.01979
G2 X125.083 Y122.022 I-3.867 J1.141 E.03373
G1 X126.78 Y122.022 E.0352
M204 S10000
G1 X138.012 Y122.843 F60000
G1 F9000
M204 S4000
G1 X138.566 Y121.239 E.0352
G2 X137.447 Y120.717 I-3.205 J5.41 E.02567
G1 X137.321 Y120.262 E.00979
G3 X138.137 Y118.441 I5.683 J1.453 E.04159
G3 X139.931 Y117.289 I3.776 J3.909 E.04451
G1 X140.359 Y116.051 E.02718
G2 X139.238 Y114.344 I-3.362 J.987 E.04298
G2 X137.447 Y113.434 I-5.506 J8.615 E.04174
G1 X137.321 Y112.979 E.00979
G3 X137.644 Y112.049 I3.394 J.657 E.02049
G1 X134.482 Y112.049 E.06558
G2 X134.97 Y112.523 I1.348 J-.897 E.01423
G2 X136.761 Y113.434 I5.506 J-8.615 E.04174
G1 X136.887 Y113.889 E.00979
G3 X136.487 Y115 I-4.063 J-.834 E.02458
G1 X134.924 Y119.762 E.10396
G2 X136.761 Y120.717 I5.72 J-8.763 E.04302
G1 X136.887 Y121.172 E.00979
G3 X135.596 Y123.448 I-4.177 J-.865 E.05516
G3 X133.805 Y124.359 I-5.505 J-8.613 E.04174
G1 X133.68 Y124.814 E.00979
G2 X134.496 Y126.635 I5.683 J-1.453 E.04159
G2 X136.302 Y127.792 I3.787 J-3.924 E.0448
G1 X135.209 Y130.955 E.06942
G3 X133.805 Y131.642 I-4.179 J-6.766 E.03247
G1 X133.68 Y132.097 E.00979
G2 X134.188 Y133.462 I5.001 J-1.083 E.03033
G1 X134.29 Y133.614 E.0038
G1 X133.736 Y135.218 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X134.29 Y133.614 E-.64485
G1 X134.188 Y133.462 E-.06957
G1 X134.141 Y133.352 E-.04558
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L84
M991 S0 P83 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.44 I.679 J-1.01 P1  F60000
G1 X123.325 Y126.079 Z10.44
G1 Z10.16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.56 F60000
G1 X119.605 Y114.987 Z10.56
G1 Z10.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.56 F60000
G1 X141.28 Y114.497 Z10.56
G1 Z10.16
M73 P84 R3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.062 Y120.374 Z10.56 F60000
G1 X138.043 Y122.753 Z10.56
G1 Z10.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.597 Y121.149 E.0352
G1 X137.896 Y120.717 E.01709
G1 X137.589 Y120.262 E.01138
G3 X138.149 Y118.441 I2.969 J-.084 E.04022
G3 X139.954 Y117.075 I4.8 J4.468 E.04718
G2 X140.259 Y116.339 I-1.233 J-.943 E.01672
G2 X139.7 Y114.799 I-4.055 J.601 E.03421
G2 X137.896 Y113.434 I-4.801 J4.469 E.04718
G1 X137.589 Y112.979 E.01138
G3 X137.741 Y112.049 I1.555 J-.224 E.01985
G1 X134.508 Y112.068 E.06707
G2 X136.312 Y113.434 I4.8 J-4.468 E.04718
G1 X136.619 Y113.889 E.01138
G1 X136.618 Y114.084 E.00405
G1 X136.787 Y114.084 E.00351
G1 X134.914 Y119.794 E.12465
G2 X136.312 Y120.717 I9.846 J-13.401 E.03477
G1 X136.619 Y121.172 E.01138
G3 X136.059 Y122.993 I-2.969 J.084 E.04022
G3 X134.254 Y124.359 I-4.8 J-4.468 E.04718
G1 X133.948 Y124.814 E.01138
G2 X134.508 Y126.635 I2.969 J.084 E.04022
G2 X136.245 Y127.958 I4.676 J-4.333 E.04553
G1 X135.173 Y131.061 E.06808
G3 X134.254 Y131.642 I-5.247 J-7.277 E.02256
G1 X133.948 Y132.097 E.01138
G1 X133.949 Y132.552 E.00944
G1 X134.304 Y133.574 E.02245
G1 X133.75 Y135.178 E.0352
; WIPE_START
G1 X134.304 Y133.574 E-.64485
G1 X134.205 Y133.288 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.973 Y128.881 Z10.56 F60000
G1 X122.739 Y125.178 Z10.56
G1 Z10.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X122.643 Y125.178 E.00198
G1 X123.149 Y126.697 E.03322
G2 X123.647 Y128.196 I.867 J.544 E.0374
G1 X124.894 Y131.946 E.08197
G2 X123.583 Y133.007 I2.691 J4.663 E.03514
G2 X123.023 Y134.828 I2.409 J1.737 E.04022
G1 X123.33 Y135.283 E.01138
G3 X125.134 Y136.649 I-2.996 J5.834 E.04718
G3 X125.694 Y138.47 I-2.409 J1.737 E.04022
G1 X125.388 Y138.925 E.01138
G2 X123.893 Y139.953 I4.197 J7.705 E.0377
G1 X123.325 Y138.354 E.0352
M204 S10000
G1 X126.655 Y137.239 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.03286
G1 X127.267 Y138.742 E.00234
G2 X126.666 Y139.835 I.354 J.907 E.02808
G2 X128.29 Y142.111 I3.073 J-.476 E.06015
G1 X129.029 Y142.566 E.01801
G1 X129.335 Y143.022 E.01138
G3 X129.184 Y143.951 I-1.555 J.224 E.01984
G1 X130.718 Y143.951 E.03183
G1 X131.094 Y142.863 E.02388
G3 X130.307 Y141.656 I.33 J-1.075 E.03244
G3 X131.931 Y139.38 I3.073 J.476 E.06015
G1 X132.397 Y139.093 E.01134
G1 X132.877 Y137.703 E.0305
G2 X131.352 Y135.738 I-2.895 J.673 E.05324
G1 X130.613 Y135.283 E.01801
G1 X130.306 Y134.828 E.01138
G1 X130.307 Y134.373 E.00944
G3 X131.931 Y132.097 I3.074 J.476 E.06015
G1 X132.671 Y131.642 E.01801
G1 X132.977 Y131.186 E.01138
G1 X132.976 Y130.731 E.00944
G2 X131.928 Y128.86 I-2.996 J.449 E.04546
G1 X133.153 Y125.178 E.0805
G1 X131.413 Y125.178 E.03609
G3 X132.671 Y124.359 I7.38 J9.953 E.03115
G1 X132.977 Y123.903 E.01138
G1 X132.976 Y123.448 E.00944
G2 X132.362 Y122.022 I-3.381 J.611 E.03249
G1 X129.209 Y122.022 E.06539
G3 X127.71 Y123.903 I-2.854 J-.736 E.05139
G1 X126.971 Y124.359 E.01801
G1 X126.665 Y124.814 E.01138
G1 X126.666 Y125.178 E.00755
G1 X124.13 Y125.178 E.0526
G3 X125.388 Y124.359 I7.38 J9.953 E.03115
G1 X125.694 Y123.903 E.01138
G1 X125.693 Y123.448 E.00944
G2 X125.079 Y122.022 I-3.381 J.611 E.03249
G1 X126.776 Y122.022 E.0352
; WIPE_START
G1 X125.079 Y122.022 E-.64486
G1 X125.24 Y122.278 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.515 Y115.955 Z10.56 F60000
G1 X132.155 Y112.049 Z10.56
G1 Z10.16
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.458 Y112.049 E.0352
G2 X130.306 Y112.979 I1.403 J.706 E.01985
G1 X130.613 Y113.434 E.01138
G3 X131.63 Y114.084 I-4.853 J8.71 E.02507
G1 X129.335 Y114.084 E.04761
G1 X129.335 Y113.889 E.00405
G1 X129.029 Y113.434 E.01138
G1 X128.29 Y112.979 E.01801
G3 X127.213 Y112.049 I2.175 J-3.607 E.02966
G1 X123.175 Y112.049 E.08376
G2 X123.023 Y112.979 I1.404 J.706 E.01985
G1 X123.33 Y113.434 E.01138
G3 X124.347 Y114.084 I-4.853 J8.71 E.02507
G1 X122.052 Y114.084 E.04761
G1 X122.052 Y113.889 E.00405
G1 X121.746 Y113.434 E.01138
G1 X121.007 Y112.979 E.01801
G3 X119.93 Y112.049 I2.175 J-3.607 E.02966
G1 X118.233 Y112.049 E.0352
M204 S10000
G1 X119.343 Y115.347 F60000
G1 F9000
M204 S4000
G1 X119.882 Y116.956 E.0352
G1 X119.688 Y117.075 E.00472
G1 X119.382 Y117.531 E.01138
G1 X119.383 Y117.986 E.00944
G2 X120.983 Y120.245 I3.055 J-.467 E.05955
G1 X121.578 Y122.022 E.03887
G1 X121.926 Y122.022 E.00722
G3 X120.427 Y123.903 I-2.854 J-.736 E.05139
G1 X119.688 Y124.359 E.01801
G1 X119.382 Y124.814 E.01138
G1 X119.383 Y125.269 E.00944
G2 X121.007 Y127.545 I3.073 J-.476 E.06015
G1 X121.746 Y128 E.01801
G1 X122.052 Y128.455 E.01138
G1 X122.051 Y128.911 E.00944
G3 X120.711 Y130.987 I-2.953 J-.435 E.05286
G1 X118.27 Y124.112 E.15133
G1 X118.411 Y123.903 E.00521
G1 X118.41 Y123.448 E.00944
G2 X117.374 Y121.585 I-3.005 J.451 E.04517
G1 X116.274 Y118.485 E.06823
G3 X117.365 Y117.531 I3.096 J2.439 E.03025
G1 X118.104 Y117.075 E.01801
G1 X118.411 Y116.62 E.01138
G1 X118.41 Y116.165 E.00944
G2 X116.786 Y113.889 I-3.073 J.476 E.06015
G1 X116.046 Y113.434 E.01801
G1 X115.74 Y112.979 E.01138
G3 X115.892 Y112.049 I1.555 J-.224 E.01985
G1 X114.704 Y112.049 E.02463
G1 X114.704 Y113.793 E.03617
G1 X114.769 Y113.889 E.00241
G1 X114.768 Y114.244 E.00736
G1 X115.336 Y115.843 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X114.768 Y114.244 E-.64486
G1 X114.769 Y113.941 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L85
M991 S0 P84 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.56 I-.995 J.701 P1  F60000
G1 X123.325 Y126.079 Z10.56
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.68 F60000
G1 X119.605 Y114.987 Z10.68
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.68 F60000
G1 X141.28 Y114.497 Z10.68
G1 Z10.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.059 Y120.373 Z10.68 F60000
G1 X138.067 Y122.685 Z10.68
G1 Z10.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.621 Y121.081 E.0352
G3 X137.795 Y120.262 I1.148 J-1.982 E.0244
G3 X138.519 Y117.986 I2.529 J-.449 E.05153
G1 X139.702 Y117.075 E.03096
G1 X140.054 Y116.62 E.01193
G2 X139.33 Y114.344 I-2.529 J-.449 E.05153
G1 X138.147 Y113.434 E.03096
G3 X137.825 Y112.049 I.824 J-.922 E.03143
G1 X134.501 Y112.049 E.06893
M73 P85 R3
G2 X134.878 Y112.523 I1.332 J-.669 E.01266
G1 X136.061 Y113.434 E.03096
G1 X136.413 Y113.889 E.01193
G1 X136.445 Y114.084 E.00411
G1 X136.787 Y114.084 E.00711
G1 X134.903 Y119.826 E.12534
G1 X136.061 Y120.717 E.0303
G1 X136.413 Y121.172 E.01193
G3 X135.689 Y123.448 I-2.529 J.449 E.05153
G1 X134.506 Y124.359 E.03096
G1 X134.154 Y124.814 E.01193
G2 X134.878 Y127.09 I2.529 J.449 E.05153
G1 X136.061 Y128 E.03096
G1 X136.178 Y128.151 E.00397
G1 X135.141 Y131.153 E.06587
G1 X134.506 Y131.642 E.01662
G2 X134.079 Y132.552 I.629 J.85 E.02173
G1 X134.317 Y133.537 E.02102
G1 X133.763 Y135.141 E.0352
; WIPE_START
G1 X134.317 Y133.537 E-.64485
G1 X134.246 Y133.243 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.964 Y128.908 Z10.68 F60000
G1 X122.668 Y125.253 Z10.68
G1 Z10.28
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.204 Y126.863 E.0352
G2 X123.582 Y128.001 I1.029 J.289 E.0264
G1 X124.863 Y131.852 E.08418
G1 X123.953 Y132.552 E.02381
G2 X123.229 Y134.828 I1.805 J1.827 E.05153
G1 X123.581 Y135.283 E.01193
G1 X124.764 Y136.194 E.03096
G3 X125.488 Y138.47 I-1.805 J1.827 E.05153
G1 X125.136 Y138.925 E.01193
G1 X123.882 Y139.923 E.03325
G1 X123.315 Y138.324 E.0352
M204 S10000
G1 X126.715 Y137.421 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.02888
G1 X127.46 Y138.742 E.00632
G2 X126.796 Y139.835 I.726 J1.189 E.02755
G2 X127.595 Y141.656 I2.936 J-.203 E.04207
G1 X128.778 Y142.566 E.03096
G3 X129.1 Y143.951 I-.823 J.922 E.03143
G1 X130.718 Y143.951 E.03356
G1 X131.127 Y142.769 E.02595
G3 X130.437 Y141.656 I.733 J-1.224 E.02821
G3 X131.236 Y139.835 I2.936 J.203 E.04207
G1 X132.419 Y138.925 E.03096
G1 X132.816 Y137.88 E.02319
G2 X132.047 Y136.194 I-2.788 J.254 E.03918
G1 X130.864 Y135.283 E.03096
G3 X130.437 Y134.373 I.629 J-.85 E.02173
G3 X131.236 Y132.552 I2.936 J.203 E.04207
G1 X132.419 Y131.642 E.03096
G2 X132.846 Y130.731 I-.629 J-.85 E.02173
G2 X132.047 Y128.911 I-2.936 J.203 E.04207
G1 X131.939 Y128.828 E.00282
G1 X133.153 Y125.178 E.07978
G1 X131.355 Y125.178 E.03731
G1 X132.419 Y124.359 E.02787
G2 X132.846 Y123.448 I-.629 J-.85 E.02173
G2 X132.365 Y122.022 I-3.037 J.231 E.03155
G1 X129.118 Y122.022 E.06735
G3 X128.405 Y123.448 I-2.537 J-.376 E.03362
G1 X127.222 Y124.359 E.03096
G1 X126.871 Y124.814 E.01193
G1 X126.811 Y125.178 E.00765
G1 X124.071 Y125.178 E.05682
G1 X125.136 Y124.359 E.02787
G2 X125.563 Y123.448 I-.629 J-.85 E.02173
G2 X125.082 Y122.022 I-3.037 J.231 E.03155
G1 X126.779 Y122.022 E.0352
; WIPE_START
G1 X125.082 Y122.022 E-.64486
G1 X125.227 Y122.288 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.257 Y116.495 Z10.68 F60000
G1 X119.388 Y115.482 Z10.68
G1 Z10.28
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X119.927 Y117.091 E.0352
G2 X119.513 Y117.986 I.62 J.831 E.02131
G2 X121.018 Y120.351 I2.91 J-.191 E.06066
G1 X121.578 Y122.022 E.03656
G1 X121.835 Y122.022 E.00532
G3 X121.122 Y123.448 I-2.537 J-.376 E.03362
G1 X119.939 Y124.359 E.03096
G2 X119.513 Y125.269 I.629 J.85 E.02173
G2 X120.312 Y127.09 I2.936 J-.203 E.04207
G1 X121.495 Y128 E.03096
G3 X121.921 Y128.911 I-.629 J.85 E.02173
G3 X121.122 Y130.731 I-2.936 J-.203 E.04207
G1 X120.728 Y131.035 E.01033
G1 X118.199 Y123.911 E.1568
G1 X118.28 Y123.448 E.00974
G2 X117.481 Y121.627 I-2.936 J.203 E.04207
G1 X117.354 Y121.53 E.00332
G1 X116.277 Y118.494 E.06682
G3 X116.67 Y117.986 I1.421 J.694 E.01342
G1 X117.853 Y117.075 E.03096
G2 X118.28 Y116.165 I-.629 J-.85 E.02173
G2 X117.481 Y114.344 I-2.936 J.203 E.04207
G1 X116.298 Y113.434 E.03096
G3 X115.975 Y112.049 I.824 J-.922 E.03143
G1 X119.935 Y112.049 E.08214
G2 X120.312 Y112.523 I1.332 J-.669 E.01266
G1 X121.495 Y113.434 E.03096
G1 X121.846 Y113.889 E.01193
G1 X121.879 Y114.084 E.00411
G1 X124.426 Y114.084 E.05285
G1 X123.581 Y113.434 E.02213
G3 X123.258 Y112.049 I.824 J-.922 E.03143
G1 X127.218 Y112.049 E.08214
G2 X127.595 Y112.523 I1.332 J-.669 E.01265
G1 X128.778 Y113.434 E.03096
G1 X129.13 Y113.889 E.01193
G1 X129.162 Y114.084 E.00411
G1 X131.709 Y114.084 E.05285
G1 X130.864 Y113.434 E.02213
G3 X130.541 Y112.049 I.824 J-.922 E.03143
G1 X132.238 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.541 Y112.049 E-.64486
G1 X130.477 Y112.345 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L86
M991 S0 P85 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.68 I-1.079 J-.562 P1  F60000
G1 X123.325 Y126.079 Z10.68
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.8 F60000
G1 X119.605 Y114.987 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.8 F60000
G1 X141.28 Y114.497 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.054 Y120.371 Z10.8 F60000
G1 X138.097 Y122.596 Z10.8
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.652 Y120.992 E.0352
G3 X137.964 Y120.262 I1.8 J-2.382 E.0209
G3 X138.47 Y117.986 I2.24 J-.697 E.05061
G1 X139.514 Y117.075 E.02873
G1 X139.885 Y116.62 E.01219
G2 X139.38 Y114.344 I-2.24 J-.697 E.05061
G1 X138.336 Y113.434 E.02873
G3 X137.852 Y112.049 I.851 J-1.074 E.03211
G1 X134.5 Y112.049 E.06954
G2 X134.828 Y112.523 I1.306 J-.553 E.01206
G1 X135.872 Y113.434 E.02873
G1 X136.244 Y113.889 E.01219
G1 X136.299 Y114.084 E.00421
G1 X136.787 Y114.084 E.01013
G1 X134.892 Y119.862 E.12612
G3 X136.244 Y121.172 I-3.168 J4.622 E.03924
G3 X135.738 Y123.448 I-2.24 J.697 E.05061
G1 X134.694 Y124.359 E.02873
G1 X134.323 Y124.814 E.01219
G2 X134.828 Y127.09 I2.24 J.697 E.05061
G1 X135.872 Y128 E.02873
G1 X136.124 Y128.308 E.00825
G1 X135.091 Y131.295 E.06555
G2 X134.329 Y133.503 I.878 J1.539 E.05289
G1 X133.775 Y135.107 E.0352
; WIPE_START
G1 X134.329 Y133.503 E-.64485
G1 X134.256 Y133.209 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.925 Y128.946 Z10.8 F60000
G1 X122.734 Y125.451 Z10.8
G1 Z10.4
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.27 Y127.061 E.0352
G2 X124.828 Y131.746 I137.644 J-43.177 E.10241
G1 X123.903 Y132.552 E.02544
G2 X123.398 Y134.828 I1.735 J1.579 E.05061
G1 X123.77 Y135.283 E.01219
G1 X124.814 Y136.194 E.02873
G3 X125.319 Y138.47 I-1.735 J1.579 E.05061
G1 X124.947 Y138.925 E.01219
G1 X123.868 Y139.885 E.02996
G1 X123.301 Y138.286 E.0352
M204 S10000
G1 X126.766 Y137.574 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.02554
G1 X127.62 Y138.742 E.00966
G2 X126.91 Y139.835 I1.218 J1.568 E.02754
G2 X127.545 Y141.656 I2.555 J.131 E.04101
G1 X128.589 Y142.566 E.02873
G3 X129.073 Y143.951 I-.851 J1.074 E.03211
G1 X130.718 Y143.951 E.03414
G1 X131.164 Y142.663 E.02828
G3 X130.67 Y140.746 I.992 J-1.278 E.04419
G3 X131.187 Y139.835 I2.448 J.788 E.02187
G1 X132.23 Y138.925 E.02873
G2 X132.719 Y137.559 I-1.027 J-1.137 E.03133
G2 X132.097 Y136.194 I-2.876 J.485 E.03148
G1 X131.053 Y135.283 E.02873
G3 X130.565 Y133.918 I1.027 J-1.137 E.03133
G3 X131.187 Y132.552 I2.876 J.485 E.03148
G1 X132.23 Y131.642 E.02873
G2 X132.719 Y130.276 I-1.027 J-1.137 E.03133
G2 X131.953 Y128.785 I-2.486 J.334 E.03544
G1 X133.153 Y125.178 E.07886
G1 X131.291 Y125.178 E.03862
G2 X132.602 Y123.903 I-3.084 J-4.484 E.03811
G2 X132.374 Y122.022 I-2.164 J-.692 E.04055
G1 X129.079 Y122.022 E.06836
G3 X128.455 Y123.448 I-2.539 J-.261 E.03281
G1 X127.411 Y124.359 E.02873
G2 X126.936 Y125.178 I.71 J.959 E.0202
G1 X124.008 Y125.178 E.06074
G2 X125.319 Y123.903 I-3.084 J-4.484 E.03811
G2 X125.091 Y122.022 I-2.164 J-.692 E.04055
G1 X126.788 Y122.022 E.0352
; WIPE_START
G1 X125.091 Y122.022 E-.64486
G1 X125.219 Y122.297 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.214 Y116.534 Z10.8 F60000
G1 X119.443 Y115.646 Z10.8
G1 Z10.4
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X119.982 Y117.255 E.0352
G2 X119.64 Y118.441 I1.068 J.95 E.02648
G2 X120.262 Y119.807 I2.876 J-.485 E.03148
G1 X121.073 Y120.514 E.02233
G1 X121.578 Y122.022 E.03298
G1 X121.796 Y122.022 E.00451
G3 X121.172 Y123.448 I-2.539 J-.261 E.03281
G1 X120.128 Y124.359 E.02873
G2 X119.64 Y125.724 I1.027 J1.137 E.03133
G2 X120.262 Y127.09 I2.876 J-.485 E.03148
G1 X121.306 Y128 E.02873
G3 X121.794 Y129.366 I-1.027 J1.137 E.03133
G3 X120.75 Y131.099 I-2.536 J-.346 E.04315
G1 X118.107 Y123.652 E.16391
G2 X117.325 Y121.448 I-2.273 J-.434 E.05085
G1 X116.277 Y118.495 E.065
G3 X116.62 Y117.986 I1.396 J.571 E.01283
G1 X117.664 Y117.075 E.02873
G2 X118.152 Y115.71 I-1.027 J-1.137 E.03133
G2 X117.53 Y114.344 I-2.876 J.485 E.03148
G1 X116.487 Y113.434 E.02873
G3 X116.003 Y112.049 I.851 J-1.074 E.03211
G1 X119.933 Y112.049 E.08153
G2 X120.262 Y112.523 I1.306 J-.553 E.01206
G1 X121.306 Y113.434 E.02873
G1 X121.677 Y113.889 E.01219
G1 X121.733 Y114.084 E.00421
G1 X124.516 Y114.084 E.05772
G3 X123.398 Y112.979 I2.685 J-3.832 E.03277
G3 X123.286 Y112.049 I2.003 J-.713 E.01959
G1 X127.216 Y112.049 E.08153
G2 X127.545 Y112.523 I1.306 J-.553 E.01206
G1 X128.589 Y113.434 E.02873
G1 X128.961 Y113.889 E.01219
G1 X129.016 Y114.084 E.00421
G1 X131.799 Y114.084 E.05772
G3 X130.681 Y112.979 I2.685 J-3.832 E.03277
G3 X130.569 Y112.049 I2.003 J-.713 E.01959
G1 X132.266 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F9000
G1 X130.569 Y112.049 E-.64486
G1 X130.558 Y112.351 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L87
M991 S0 P86 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.8 I-1.077 J-.567 P1  F60000
G1 X123.325 Y126.079 Z10.8
G1 Z10.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z10.92 F60000
G1 X119.605 Y114.987 Z10.92
M73 P86 R3
G1 Z10.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z10.92 F60000
G1 X141.28 Y114.497 Z10.92
G1 Z10.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.237 Y119.297 Z10.92 F60000
G1 Z10.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.683 Y120.901 E.0352
G3 X138.109 Y120.262 I2.87 J-3.152 E.01785
G3 X138.417 Y117.986 I2.057 J-.881 E.05003
G2 X139.74 Y116.62 I-6.078 J-7.213 E.03951
G2 X139.432 Y114.344 I-2.057 J-.881 E.05003
G1 X138.493 Y113.434 E.02714
G3 X137.912 Y112.049 I1.005 J-1.236 E.03244
G1 X134.491 Y112.049 E.07096
G2 X134.776 Y112.523 I1.27 J-.439 E.01156
G1 X135.715 Y113.434 E.02714
G3 X136.173 Y114.084 I-.697 J.976 E.01682
G1 X136.787 Y114.084 E.01275
G1 X134.877 Y119.905 E.12707
G3 X136.099 Y121.172 I-5.643 J6.661 E.03657
G3 X135.791 Y123.448 I-2.057 J.881 E.05003
G2 X134.468 Y124.814 I6.078 J7.213 E.03951
G2 X134.776 Y127.09 I2.057 J.881 E.05003
G3 X136.08 Y128.434 I-5.981 J7.113 E.03892
G1 X135.033 Y131.466 E.06655
G2 X134.34 Y133.471 I1.07 J1.492 E.04691
G1 X133.786 Y135.075 E.0352
; WIPE_START
G1 X134.34 Y133.471 E-.64485
G1 X134.293 Y133.172 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.359 Y136.361 Z10.92 F60000
G1 X123.283 Y138.236 Z10.92
G1 Z10.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.851 Y139.835 E.0352
G2 X125.174 Y138.47 I-6.078 J-7.213 E.03951
G2 X124.866 Y136.194 I-2.057 J-.881 E.05003
G3 X123.543 Y134.828 I6.079 J-7.214 E.03951
G3 X123.851 Y132.552 I2.057 J-.881 E.05003
G2 X124.792 Y131.639 I-4.008 J-5.076 E.02724
G1 X127.155 Y138.742 E.15527
G1 X127.756 Y138.742 E.01248
G2 X127.012 Y139.835 I1.703 J1.96 E.02773
G2 X127.492 Y141.656 I2.392 J.343 E.04012
G3 X128.816 Y143.022 I-6.079 J7.213 E.03951
G3 X129.013 Y143.951 I-1.963 J.903 E.01988
G1 X130.718 Y143.951 E.03537
G1 X131.201 Y142.556 E.03063
G3 X130.856 Y140.29 I1.318 J-1.359 E.05104
G1 X131.134 Y139.835 E.01106
G2 X132.457 Y138.47 I-6.078 J-7.213 E.03951
G2 X132.149 Y136.194 I-2.057 J-.881 E.05003
G3 X130.826 Y134.828 I6.08 J-7.214 E.03951
G3 X131.134 Y132.552 I2.057 J-.881 E.05003
G2 X132.457 Y131.186 I-6.078 J-7.213 E.03951
G2 X131.97 Y128.736 I-1.99 J-.878 E.0552
G1 X133.153 Y125.178 E.07779
G1 X131.228 Y125.178 E.03993
G2 X132.457 Y123.903 I-5.676 J-6.704 E.03679
G2 X132.39 Y122.022 I-1.99 J-.871 E.04039
G1 X129.012 Y122.022 E.07006
G3 X128.508 Y123.448 I-2.419 J-.053 E.03191
G2 X127.185 Y124.814 I6.078 J7.213 E.03951
G1 X127.047 Y125.178 E.00808
G1 X123.945 Y125.178 E.06434
G2 X125.174 Y123.903 I-5.677 J-6.705 E.03679
G2 X125.107 Y122.022 I-1.99 J-.871 E.04039
G1 X126.804 Y122.022 E.0352
; WIPE_START
G1 X125.107 Y122.022 E-.64486
G1 X125.216 Y122.305 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.182 Y116.568 Z10.92 F60000
G1 X119.486 Y115.775 Z10.92
G1 Z10.52
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.025 Y117.384 E.0352
G2 X119.932 Y119.351 I1.573 J1.061 E.04296
G1 X120.209 Y119.807 E.01106
G1 X121.137 Y120.706 E.0268
G1 X121.578 Y122.022 E.02879
G1 X121.729 Y122.022 E.00313
G3 X121.225 Y123.448 I-2.419 J-.053 E.03191
G2 X119.901 Y124.814 I6.078 J7.213 E.03951
G2 X120.209 Y127.09 I2.057 J.881 E.05003
G3 X121.532 Y128.455 I-6.08 J7.215 E.03951
G3 X120.775 Y131.167 I-2.097 J.876 E.06299
G1 X118.049 Y123.487 E.16905
G2 X117.287 Y121.34 I-2.234 J-.416 E.04949
G1 X116.274 Y118.487 E.06281
G3 X116.568 Y117.986 I1.338 J.448 E.01213
G2 X117.891 Y116.62 I-6.078 J-7.213 E.03951
G2 X117.583 Y114.344 I-2.057 J-.881 E.05003
G3 X116.26 Y112.979 I6.078 J-7.213 E.03951
G3 X116.062 Y112.049 I1.961 J-.902 E.01988
G1 X119.925 Y112.049 E.08011
G2 X120.209 Y112.523 I1.27 J-.439 E.01156
G3 X121.532 Y113.889 I-6.079 J7.214 E.03951
G1 X121.606 Y114.084 E.00433
G1 X124.598 Y114.084 E.06205
G3 X123.543 Y112.979 I4.93 J-5.76 E.03176
G3 X123.346 Y112.049 I1.961 J-.902 E.01988
G1 X127.208 Y112.049 E.08011
G2 X127.492 Y112.523 I1.27 J-.439 E.01156
G3 X128.816 Y113.889 I-6.078 J7.213 E.03951
G1 X128.89 Y114.084 E.00433
G1 X131.881 Y114.084 E.06205
G3 X130.826 Y112.979 I4.931 J-5.76 E.03176
G3 X130.629 Y112.049 I1.961 J-.902 E.01988
G1 X132.326 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.629 Y112.049 E-.64486
G1 X130.645 Y112.351 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L88
M991 S0 P87 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z10.92 I-1.074 J-.573 P1  F60000
G1 X123.325 Y126.079 Z10.92
G1 Z10.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.04 F60000
G1 X119.605 Y114.987 Z11.04
G1 Z10.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.04 F60000
G1 X141.28 Y114.497 Z11.04
G1 Z10.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
M73 P86 R2
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.272 Y119.196 Z11.04 F60000
G1 Z10.64
M73 P87 R2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.718 Y120.8 E.0352
G3 X137.962 Y119.351 I1.072 J-1.481 E.03514
G3 X139.218 Y117.075 I2.881 J.106 E.05594
G2 X139.888 Y115.71 I-1.348 J-1.507 E.03234
G2 X138.631 Y113.434 I-2.882 J.106 E.05594
G3 X137.964 Y112.049 I1.191 J-1.427 E.03288
G1 X134.476 Y112.049 E.07234
G2 X135.099 Y112.979 I3.115 J-1.414 E.02332
G3 X136.06 Y114.084 I-2.499 J3.142 E.03056
G1 X136.787 Y114.084 E.01508
G1 X134.856 Y119.97 E.12849
G2 X135.577 Y120.717 I3.616 J-2.768 E.02158
G3 X136.246 Y122.083 I-1.348 J1.507 E.03234
G3 X134.99 Y124.359 I-2.882 J-.106 E.05594
G2 X134.72 Y127.09 I1.434 J1.521 E.0621
G3 X136.029 Y128.582 I-27.3 J25.267 E.04119
G1 X134.96 Y131.676 E.06789
G2 X134.353 Y133.433 I1.217 J1.404 E.04039
G1 X133.799 Y135.037 E.0352
; WIPE_START
G1 X134.353 Y133.433 E-.64485
G1 X134.33 Y133.131 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.389 Y136.304 Z11.04 F60000
G1 X123.267 Y138.189 Z11.04
G1 Z10.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.834 Y139.788 E.0352
G3 X125.046 Y138.47 I81.434 J73.612 E.03714
G2 X124.542 Y135.738 I-2.015 J-1.041 E.06199
G3 X123.462 Y134.373 I2.221 J-2.868 E.03648
G3 X124.175 Y132.097 I2.385 J-.502 E.05169
G2 X124.754 Y131.524 I-2.668 J-3.278 E.01692
G1 X127.155 Y138.742 E.15779
G1 X127.898 Y138.742 E.01541
G2 X127.103 Y139.835 I2.032 J2.312 E.02825
G2 X127.816 Y142.111 I2.385 J.502 E.05169
G3 X128.897 Y143.477 I-2.221 J2.868 E.03648
G3 X128.961 Y143.951 I-1.029 J.382 E.01001
G1 X130.718 Y143.951 E.03644
G1 X131.24 Y142.442 E.03313
G3 X130.84 Y140.29 I1.397 J-1.373 E.04816
G3 X131.935 Y138.925 I3.686 J1.834 E.03659
G2 X132.205 Y136.194 I-1.434 J-1.521 E.0621
G2 X130.954 Y134.828 I-62.306 J55.814 E.03841
G3 X131.458 Y132.097 I2.015 J-1.041 E.06199
G2 X132.538 Y130.731 I-2.221 J-2.868 E.03648
G2 X131.995 Y128.659 I-2.299 J-.505 E.04613
G1 X133.153 Y125.178 E.07609
G1 X131.154 Y125.178 E.04147
G3 X132.329 Y123.903 I126.829 J115.735 E.03596
G2 X132.412 Y122.022 I-1.882 J-1.025 E.04044
G1 X128.954 Y122.022 E.07172
G3 X128.184 Y123.903 I-2.492 J.078 E.04343
G2 X127.145 Y125.178 I2.236 J2.883 E.0344
G1 X123.871 Y125.178 E.06792
G3 X125.046 Y123.903 I127.257 J116.129 E.03596
G2 X125.128 Y122.022 I-1.882 J-1.025 E.04044
G1 X126.825 Y122.022 E.0352
; WIPE_START
G1 X125.128 Y122.022 E-.64486
G1 X125.217 Y122.312 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.156 Y116.599 Z11.04 F60000
G1 X119.523 Y115.884 Z11.04
G1 Z10.64
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.062 Y117.493 E.0352
G2 X120.533 Y120.262 I1.92 J1.097 E.06311
G3 X121.223 Y120.963 I-3.278 J3.918 E.02045
G1 X121.578 Y122.022 E.02316
G1 X121.671 Y122.022 E.00193
G3 X120.901 Y123.903 I-2.492 J.078 E.04343
G2 X119.82 Y125.269 I2.221 J2.868 E.03648
G2 X120.533 Y127.545 I2.385 J.502 E.05169
G3 X121.614 Y128.911 I-2.22 J2.868 E.03648
G3 X120.812 Y131.272 I-2.398 J.502 E.05427
G1 X117.99 Y123.323 E.17496
G2 X117.211 Y121.126 I-2.389 J-.389 E.05045
G1 X116.267 Y118.466 E.05854
G3 X117.369 Y117.075 I3.651 J1.761 E.03711
G2 X117.639 Y114.344 I-1.434 J-1.521 E.0621
G2 X116.388 Y112.979 I-62.298 J55.807 E.03841
G3 X116.114 Y112.049 I1.998 J-1.094 E.02026
G1 X119.91 Y112.049 E.07873
G2 X121.011 Y113.434 I3.661 J-1.78 E.03699
G3 X121.494 Y114.084 I-.883 J1.161 E.01704
G1 X124.705 Y114.084 E.06661
G3 X123.671 Y112.979 I43.456 J-41.676 E.03141
G3 X123.397 Y112.049 I1.998 J-1.094 E.02026
G1 X127.193 Y112.049 E.07873
G2 X128.294 Y113.434 I3.662 J-1.78 E.03699
G3 X128.777 Y114.084 I-.883 J1.161 E.01704
G1 X131.989 Y114.084 E.06661
G3 X130.954 Y112.979 I43.357 J-41.584 E.03141
G3 X130.68 Y112.049 I1.997 J-1.094 E.02026
G1 X132.377 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.68 Y112.049 E-.64486
G1 X130.721 Y112.349 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L89
M991 S0 P88 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.04 I-1.071 J-.577 P1  F60000
G1 X123.325 Y126.079 Z11.04
G1 Z10.76
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.16 F60000
G1 X119.605 Y114.987 Z11.16
G1 Z10.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.16 F60000
G1 X141.28 Y114.497 Z11.16
G1 Z10.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.304 Y119.104 Z11.16 F60000
G1 Z10.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.75 Y120.708 E.0352
G3 X138.64 Y117.531 I1.44 J-1.64 E.07386
G2 X139.739 Y116.165 I-3.108 J-3.626 E.03656
G2 X138.758 Y113.434 I-2.444 J-.664 E.0641
G3 X138.008 Y112.049 I1.409 J-1.659 E.03344
G1 X134.455 Y112.049 E.07369
G2 X134.999 Y112.979 I2.937 J-1.093 E.02246
G3 X135.959 Y114.084 I-3.575 J4.072 E.03047
G1 X136.787 Y114.084 E.01719
G1 X134.833 Y120.039 E.13
G1 X134.999 Y120.262 E.00575
G3 X136.098 Y121.627 I-3.108 J3.626 E.03656
G3 X135.117 Y124.359 I-2.444 J.664 E.0641
G2 X134.999 Y127.545 I1.434 J1.648 E.07413
G3 X135.987 Y128.704 I-3.351 J3.858 E.03171
G1 X134.88 Y131.909 E.07034
G2 X134.367 Y133.393 I1.327 J1.289 E.03363
G1 X133.813 Y134.996 E.0352
; WIPE_START
G1 X134.367 Y133.393 E-.64485
G1 X134.367 Y133.089 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.415 Y136.241 Z11.16 F60000
G1 X123.246 Y138.131 Z11.16
G1 Z10.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X123.813 Y139.73 E.0352
G3 X124.929 Y138.47 I14.419 J11.642 E.03493
G2 X124.643 Y135.738 I-1.855 J-1.186 E.0615
G3 X123.544 Y134.373 I3.108 J-3.626 E.03656
G3 X124.525 Y131.642 I2.444 J-.664 E.0641
G1 X124.72 Y131.422 E.00609
G1 X127.155 Y138.742 E.16002
G1 X128.014 Y138.742 E.01783
G2 X127.186 Y139.835 I2.719 J2.923 E.02859
G2 X128.166 Y142.566 I2.444 J.664 E.0641
G3 X128.917 Y143.951 I-1.409 J1.659 E.03343
G1 X130.718 Y143.951 E.03737
G1 X131.275 Y142.341 E.03534
G3 X131.357 Y139.38 I1.599 J-1.437 E.06778
G2 X132.456 Y138.014 I-3.108 J-3.626 E.03656
G2 X131.475 Y135.283 I-2.444 J-.664 E.0641
G3 X131.357 Y132.097 I1.434 J-1.648 E.07413
G2 X132.456 Y130.731 I-3.108 J-3.626 E.03656
G2 X132.021 Y128.583 I-2.179 J-.677 E.04744
G1 X133.153 Y125.178 E.07442
G1 X131.086 Y125.178 E.04288
G3 X132.212 Y123.903 I14.166 J11.385 E.0353
G2 X132.439 Y122.022 I-1.815 J-1.173 E.04069
G1 X128.903 Y122.022 E.07334
G3 X127.834 Y124.359 I-2.571 J.236 E.05579
G2 X127.234 Y125.178 I1.412 J1.661 E.02125
G1 X123.803 Y125.178 E.07118
G3 X124.929 Y123.903 I14.171 J11.39 E.0353
G2 X125.156 Y122.022 I-1.815 J-1.173 E.04069
G1 X126.853 Y122.022 E.0352
; WIPE_START
G1 X125.156 Y122.022 E-.64486
G1 X125.224 Y122.317 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.129 Y116.635 Z11.16 F60000
G1 X119.563 Y116.004 Z11.16
G1 Z10.76
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X120.102 Y117.613 E.0352
G2 X120.433 Y120.262 I1.89 J1.109 E.05953
G3 X121.303 Y121.2 I-7.527 J7.852 E.02657
G1 X121.62 Y122.022 E.01827
G3 X120.551 Y124.359 I-2.571 J.236 E.05579
G2 X120.433 Y127.545 I1.434 J1.648 E.07413
G3 X121.531 Y128.911 I-3.108 J3.625 E.03656
G3 X120.839 Y131.35 I-2.223 J.687 E.05563
G1 X117.946 Y123.198 E.17943
G2 X117.153 Y120.963 I-2.295 J-.443 E.05158
G1 X116.255 Y118.433 E.0557
G3 X117.242 Y117.075 I3.269 J1.339 E.03515
G2 X117.36 Y113.889 I-1.434 J-1.648 E.07413
G3 X116.261 Y112.523 I3.108 J-3.626 E.03656
G3 X116.159 Y112.049 I1 J-.464 E.01016
G1 X119.889 Y112.049 E.07738
G2 X120.883 Y113.434 I3.193 J-1.243 E.03574
G3 X121.392 Y114.084 I-1.104 J1.388 E.01729
G1 X124.788 Y114.084 E.07044
G2 X123.788 Y112.979 I-22.474 J19.333 E.03094
G3 X123.442 Y112.049 I2.08 J-1.303 E.02072
G1 X127.172 Y112.049 E.07738
G2 X128.166 Y113.434 I3.193 J-1.243 E.03574
G3 X128.676 Y114.084 I-1.104 J1.388 E.01729
G1 X132.072 Y114.084 E.07044
G2 X131.071 Y112.979 I-22.492 J19.35 E.03094
G3 X130.725 Y112.049 I2.079 J-1.303 E.02072
G1 X132.422 Y112.049 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 10.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X130.725 Y112.049 E-.64486
G1 X130.789 Y112.345 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L90
M991 S0 P89 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.16 I-1.069 J-.581 P1  F60000
G1 X123.325 Y126.079 Z11.16
G1 Z10.88
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P88 R2
G1 X121.732 Y120.698 Z11.28 F60000
G1 X119.605 Y114.987 Z11.28
G1 Z10.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.28 F60000
G1 X141.28 Y114.497 Z11.28
G1 Z10.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.337 Y119.008 Z11.28 F60000
G1 Z10.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.783 Y120.612 E.0352
G3 X138.97 Y117.075 I1.546 J-1.691 E.08394
G2 X138.88 Y113.434 I-1.463 J-1.786 E.08706
G3 X138.046 Y112.049 I1.662 J-1.945 E.03413
G1 X134.428 Y112.049 E.07504
G2 X134.898 Y112.979 I2.746 J-.803 E.02173
G3 X135.865 Y114.084 I-5.451 J5.742 E.03051
G1 X136.787 Y114.084 E.01914
G1 X134.806 Y120.123 E.13183
G2 X135.328 Y120.717 I1.988 J-1.222 E.01648
G3 X135.238 Y124.359 I-1.463 J1.786 E.08706
G2 X134.898 Y127.545 I1.38 J1.759 E.07411
G3 X135.954 Y128.798 I-4.654 J4.996 E.03408
G1 X134.807 Y132.12 E.0729
G2 X134.38 Y133.353 I1.756 J1.297 E.02749
G1 X133.826 Y134.957 E.0352
; WIPE_START
G1 X134.38 Y133.353 E-.64485
G1 X134.402 Y133.051 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.699 Y125.451 Z11.28 F60000
G1 X132.46 Y112.049 Z11.28
G1 Z10.88
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X130.763 Y112.049 E.0352
G2 X131.179 Y112.979 I2.604 J-.608 E.02127
G3 X132.157 Y114.084 I-8.23 J8.263 E.03064
G1 X128.582 Y114.084 E.07416
G2 X128.045 Y113.434 I-1.909 J1.028 E.01761
G3 X127.145 Y112.049 I1.876 J-2.203 E.03474
G1 X123.48 Y112.049 E.07603
G2 X123.896 Y112.979 I2.604 J-.608 E.02127
G3 X124.874 Y114.084 I-8.23 J8.263 E.03064
G1 X121.298 Y114.084 E.07416
G2 X120.762 Y113.434 I-1.909 J1.028 E.01761
G3 X119.862 Y112.049 I1.876 J-2.203 E.03474
G1 X116.196 Y112.049 E.07603
G2 X117.031 Y113.434 I2.496 J-.56 E.03413
G3 X117.12 Y117.075 I-1.374 J1.856 E.08706
G2 X116.241 Y118.392 I1.978 J2.273 E.03324
G1 X117.087 Y120.776 E.05247
G3 X117.916 Y123.114 I-1.412 J1.817 E.05434
G1 X118.484 Y124.713 E.0352
M204 S10000
G1 X123.492 Y122.022 F60000
G1 F9000
M204 S4000
G1 X125.189 Y122.022 E.0352
G3 X124.821 Y123.903 I-2.142 J.558 E.04112
G2 X123.731 Y125.178 I6.544 J6.7 E.03483
G1 X127.316 Y125.178 E.07436
G3 X127.955 Y124.359 I2.386 J1.203 E.0217
G2 X128.859 Y122.022 I-1.419 J-1.892 E.05477
G1 X132.472 Y122.022 E.07494
G3 X132.104 Y123.903 I-2.142 J.558 E.04112
G2 X131.014 Y125.178 I6.544 J6.7 E.03483
G1 X133.153 Y125.178 E.04437
G1 X132.051 Y128.492 E.07243
G3 X131.686 Y131.642 I-1.738 J1.395 E.07319
G2 X131.597 Y135.283 I1.374 J1.856 E.08706
G3 X131.686 Y138.925 I-1.374 J1.856 E.08706
G2 X131.306 Y142.25 I1.353 J1.839 E.07791
G1 X130.718 Y143.951 E.03734
G1 X128.879 Y143.951 E.03815
G2 X128.045 Y142.566 I-2.496 J.56 E.03412
G3 X127.26 Y139.835 I1.407 J-1.882 E.0633
G3 X128.128 Y138.742 I4.599 J2.759 E.02902
G1 X127.155 Y138.742 E.02018
G1 X124.689 Y131.33 E.16203
G1 X124.403 Y131.642 E.00878
G2 X124.314 Y135.283 I1.374 J1.856 E.08706
G3 X124.821 Y138.47 I-1.344 J1.848 E.07431
G2 X123.788 Y139.658 I7.058 J7.176 E.0327
G1 X120.869 Y131.433 E.18103
G2 X120.762 Y128 I-1.47 J-1.672 E.08137
G3 X120.672 Y124.359 I1.374 J-1.856 E.08706
G2 X120.762 Y120.717 I-1.343 J-1.855 E.08736
G3 X120.138 Y117.722 I1.331 J-1.84 E.06964
G1 X119.599 Y116.112 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X120.138 Y117.722 E-.64485
G1 X119.981 Y117.98 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L91
M991 S0 P90 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.28 I-1.125 J.465 P1  F60000
G1 X123.325 Y126.079 Z11.28
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.4 F60000
G1 X119.605 Y114.987 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.4 F60000
G1 X141.28 Y114.497 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.368 Y118.918 Z11.4 F60000
G1 Z11
M73 P89 R2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.814 Y120.522 E.0352
G3 X138.849 Y117.075 I1.445 J-1.709 E.08161
G2 X139 Y113.434 I-1.365 J-1.88 E.0869
G3 X138.077 Y112.049 I1.954 J-2.302 E.03498
G1 X134.395 Y112.049 E.07638
G2 X134.794 Y112.979 I2.556 J-.545 E.02112
G3 X135.776 Y114.084 I-9.844 J9.738 E.0307
G1 X132.246 Y114.084 E.07322
G2 X131.717 Y113.434 I-1.828 J.947 E.01752
G3 X130.794 Y112.049 I1.954 J-2.302 E.03498
G1 X127.112 Y112.049 E.07638
G2 X127.511 Y112.979 I2.556 J-.545 E.02112
G3 X128.493 Y114.084 I-9.842 J9.736 E.0307
G1 X124.963 Y114.084 E.07322
G2 X124.434 Y113.434 I-1.828 J.947 E.01752
G3 X123.511 Y112.049 I1.954 J-2.302 E.03498
G1 X121.814 Y112.049 E.0352
; WIPE_START
G1 X123.511 Y112.049 E-.64486
G1 X123.617 Y112.333 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.672 Y119.374 Z11.4 F60000
G1 X118.463 Y124.656 Z11.4
G1 Z11
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.896 Y123.056 E.0352
G2 X117.833 Y121.627 I-2.025 J-.627 E.03026
G2 X117.015 Y120.575 I-4.163 J2.393 E.02774
G1 X116.219 Y118.332 E.04936
G3 X117 Y117.075 I2.481 J.67 E.03113
G2 X117.151 Y113.434 I-1.365 J-1.88 E.0869
G3 X116.228 Y112.049 I1.954 J-2.302 E.03498
G1 X119.829 Y112.049 E.07469
G2 X120.227 Y112.979 I2.557 J-.545 E.02112
G3 X121.21 Y114.084 I-9.839 J9.734 E.0307
G1 X118.92 Y114.084 E.0475
G1 X120.167 Y117.809 E.08146
G2 X120.641 Y120.717 I1.839 J1.193 E.06703
G3 X120.792 Y124.359 I-1.365 J1.88 E.0869
G2 X119.959 Y127.09 I1.421 J1.926 E.06346
G2 X121.076 Y128.455 I5.198 J-3.114 E.03673
G3 X120.901 Y131.523 I-1.642 J1.445 E.07066
G1 X123.757 Y139.57 E.17713
G3 X124.283 Y138.925 I1.814 J.942 E.0174
G2 X124.434 Y135.283 I-1.365 J-1.88 E.0869
G3 X123.6 Y132.552 I1.421 J-1.926 E.06346
G3 X124.661 Y131.246 I4.992 J2.97 E.03503
G1 X122.643 Y125.178 E.13264
G1 X123.654 Y125.178 E.02097
G3 X124.283 Y124.359 I2.283 J1.101 E.02158
G2 X125.228 Y122.022 I-1.44 J-1.942 E.055
G1 X128.822 Y122.022 E.07453
G3 X128.49 Y123.903 I-2.114 J.597 E.04099
G2 X127.391 Y125.178 I7.549 J7.616 E.03493
G1 X130.937 Y125.178 E.07355
G3 X131.566 Y124.359 I2.283 J1.102 E.02158
G2 X132.511 Y122.022 I-1.44 J-1.942 E.055
G1 X134.183 Y122.022 E.03466
G1 X134.772 Y120.225 E.03922
G2 X135.208 Y120.717 I1.399 J-.801 E.01372
G3 X135.359 Y124.359 I-1.365 J1.88 E.0869
G2 X134.794 Y127.545 I1.372 J1.887 E.07418
G3 X135.929 Y128.873 I-7.331 J7.414 E.03628
G1 X134.703 Y132.419 E.07782
G2 X134.393 Y133.317 I1.884 J1.154 E.01986
G1 X133.839 Y134.921 E.0352
; WIPE_START
G1 X134.393 Y133.317 E-.64485
G1 X134.437 Y133.017 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.151 Y137.345 Z11.4 F60000
G1 X126.962 Y138.163 Z11.4
G1 Z11
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.01266
G1 X128.241 Y138.742 E.02254
G1 X128.076 Y138.925 E.00512
G2 X127.925 Y142.566 I1.365 J1.88 E.0869
G3 X128.848 Y143.951 I-1.954 J2.302 E.03497
G1 X130.718 Y143.951 E.03881
G1 X131.335 Y142.167 E.03917
G3 X131.566 Y138.925 I1.585 J-1.516 E.07591
G2 X131.717 Y135.283 I-1.365 J-1.88 E.0869
G3 X131.566 Y131.642 I1.365 J-1.88 E.0869
G2 X132.081 Y128.401 I-1.362 J-1.878 E.07562
G1 X132.617 Y126.79 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 11.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.081 Y128.401 E-.64486
G1 X132.242 Y128.658 E-.11514
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L92
M991 S0 P91 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.4 I.338 J-1.169 P1  F60000
G1 X123.325 Y126.079 Z11.4
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.52 F60000
G1 X119.605 Y114.987 Z11.52
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.52 F60000
G1 X141.28 Y114.497 Z11.52
G1 Z11.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.397 Y118.834 Z11.52 F60000
G1 Z11.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.843 Y120.438 E.0352
G3 X138.09 Y117.986 I1.534 J-1.813 E.05621
G3 X139.184 Y116.62 I3.941 J2.035 E.03653
G2 X139.123 Y113.434 I-1.51 J-1.565 E.07419
G3 X138.103 Y112.049 I2.288 J-2.753 E.03604
G1 X134.356 Y112.049 E.07772
G2 X134.684 Y112.979 I2.383 J-.317 E.0206
G3 X135.692 Y114.084 I-35.082 J32.998 E.03104
G1 X132.342 Y114.084 E.06948
G2 X131.84 Y113.434 I-1.546 J.675 E.01722
G3 X130.82 Y112.049 I2.288 J-2.753 E.03604
G1 X127.073 Y112.049 E.07772
G2 X127.4 Y112.979 I2.383 J-.317 E.0206
G3 X128.409 Y114.084 I-35.112 J33.026 E.03104
G1 X125.059 Y114.084 E.06948
G2 X124.557 Y113.434 I-1.546 J.675 E.01722
G3 X123.536 Y112.049 I2.288 J-2.753 E.03604
G1 X121.839 Y112.049 E.0352
; WIPE_START
G1 X123.536 Y112.049 E-.64486
G1 X123.661 Y112.325 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.682 Y119.352 Z11.52 F60000
G1 X118.45 Y124.616 Z11.52
G1 Z11.12
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.882 Y123.017 E.0352
G2 X117.274 Y120.717 I-1.962 J-.712 E.05251
G1 X116.952 Y120.397 E.00942
G1 X116.188 Y118.244 E.04738
G3 X116.877 Y117.075 I2.152 J.482 E.0286
G2 X117.91 Y114.344 I-1.477 J-2.12 E.06437
G2 X116.817 Y112.979 I-3.941 J2.035 E.03653
G3 X116.253 Y112.049 I2.421 J-2.102 E.02266
G1 X119.789 Y112.049 E.07335
G2 X120.519 Y113.434 I2.079 J-.21 E.03328
G3 X121.126 Y114.084 I-2.125 J2.59 E.01851
G1 X118.92 Y114.084 E.04574
G1 X120.191 Y117.879 E.08301
G2 X120.519 Y120.717 I1.73 J1.238 E.06496
G3 X121.552 Y123.448 I-1.477 J2.119 E.06437
G3 X120.458 Y124.814 I-3.94 J-2.035 E.03653
G2 X120.519 Y128 I1.51 J1.565 E.07419
G3 X121.552 Y130.731 I-1.477 J2.119 E.06437
G3 X120.935 Y131.619 I-2.076 J-.784 E.02265
G1 X120.367 Y130.02 E.0352
M204 S10000
G1 X126.999 Y138.275 F60000
G1 F9000
M204 S4000
G1 X127.155 Y138.742 E.01022
G1 X128.359 Y138.742 E.02498
G2 X127.392 Y139.835 I9.002 J8.938 E.03028
G2 X127.802 Y142.566 I1.807 J1.125 E.06233
G3 X128.822 Y143.951 I-2.288 J2.753 E.03603
G1 X125.312 Y143.951 E.07281
G2 X125.033 Y143.167 I-3.4 J.766 E.01729
G1 X123.718 Y139.46 E.0816
G2 X124.966 Y138.014 I-51.184 J-45.477 E.03962
G2 X124.557 Y135.283 I-1.807 J-1.125 E.06233
G3 X123.524 Y132.552 I1.477 J-2.119 E.06437
G3 X124.617 Y131.186 I3.941 J2.035 E.03653
G1 X122.643 Y125.178 E.13119
G1 X123.571 Y125.178 E.01924
G3 X124.617 Y123.903 I3.923 J2.154 E.0344
G2 X125.274 Y122.022 I-1.733 J-1.66 E.04262
G1 X128.79 Y122.022 E.07293
G3 X128.198 Y124.359 I-1.927 J.755 E.05337
G2 X127.462 Y125.178 I2.69 J3.157 E.02291
G1 X130.854 Y125.178 E.07036
G3 X131.9 Y123.903 I3.922 J2.154 E.0344
G2 X132.557 Y122.022 I-1.733 J-1.66 E.04262
G1 X134.183 Y122.022 E.03372
G1 X134.739 Y120.325 E.03705
G3 X135.891 Y121.627 I-13.755 J13.323 E.03607
G3 X135.481 Y124.359 I-1.807 J1.125 E.06233
G2 X134.449 Y127.09 I1.477 J2.119 E.06437
G2 X135.542 Y128.455 I3.94 J-2.035 E.03653
G3 X135.905 Y128.941 I-.894 J1.047 E.01268
G1 X134.603 Y132.709 E.0827
G2 X134.404 Y133.286 I1.228 J.747 E.01275
G1 X131.363 Y142.085 E.19311
G3 X131.444 Y138.925 I1.523 J-1.543 E.07349
G2 X132.476 Y136.194 I-1.477 J-2.119 E.06437
G2 X131.383 Y134.828 I-3.94 J2.035 E.03653
G3 X131.444 Y131.642 I1.51 J-1.565 E.07419
G2 X132.476 Y128.911 I-1.477 J-2.119 E.06437
G2 X132.112 Y128.309 I-1.38 J.425 E.01474
G1 X132.647 Y126.698 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 11.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.112 Y128.309 E-.64485
G1 X132.269 Y128.568 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L93
M991 S0 P92 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.52 I.326 J-1.172 P1  F60000
G1 X123.325 Y126.079 Z11.52
G1 Z11.24
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.64 F60000
G1 X119.605 Y114.987 Z11.64
G1 Z11.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P90 R2
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.64 F60000
G1 X141.28 Y114.497 Z11.64
G1 Z11.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.819 Y112.049 Z11.64 F60000
G1 Z11.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X138.122 Y112.049 E.0352
G2 X138.767 Y112.979 I3.156 J-1.499 E.02357
G3 X139.643 Y113.889 I-3.756 J4.495 E.02627
G3 X139.083 Y116.62 I-2.059 J1 E.06218
G2 X138.206 Y117.531 I3.757 J4.495 E.02627
G2 X138.87 Y120.359 I2.111 J.996 E.06505
G1 X139.425 Y118.755 E.0352
M204 S10000
G1 X135.397 Y118.32 F60000
G1 F9000
M204 S4000
G1 X135.926 Y116.708 E.0352
G2 X136.258 Y115.699 I-.974 J-.879 E.02269
G1 X136.787 Y114.084 E.03524
G1 X135.609 Y114.084 E.02444
G2 X134.956 Y113.434 I-3.322 J2.683 E.01917
G3 X134.309 Y112.049 I1.14 J-1.375 E.03276
G1 X130.839 Y112.049 E.07199
G2 X131.484 Y112.979 I3.155 J-1.499 E.02357
G3 X132.446 Y114.084 I-2.289 J2.965 E.03061
G1 X130.749 Y114.084 E.0352
M204 S10000
G1 X128.723 Y112.049 F60000
G1 F9000
M204 S4000
G1 X127.026 Y112.049 E.0352
G2 X127.672 Y113.434 I1.787 J.01 E.03276
G3 X128.326 Y114.084 I-2.668 J3.333 E.01917
G1 X125.163 Y114.084 E.0656
G2 X124.2 Y112.979 I-3.252 J1.859 E.03061
G3 X123.556 Y112.049 I2.512 J-2.429 E.02357
G1 X121.859 Y112.049 E.0352
; WIPE_START
G1 X123.556 Y112.049 E-.64486
G1 X123.699 Y112.316 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.693 Y119.332 Z11.64 F60000
G1 X118.44 Y124.591 Z11.64
G1 Z11.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X117.873 Y122.991 E.0352
G2 X117.403 Y120.717 I-1.795 J-.815 E.05151
G3 X116.895 Y120.235 I1.961 J-2.579 E.01456
G1 X116.141 Y118.111 E.04675
G3 X116.748 Y117.075 I1.939 J.441 E.0253
G2 X118.051 Y114.799 I-1.638 J-2.449 E.05638
G2 X117.403 Y113.434 I-1.948 J.088 E.0322
G3 X116.273 Y112.049 I2.658 J-3.323 E.03736
G1 X119.743 Y112.049 E.07199
G2 X120.389 Y113.434 I1.787 J.01 E.03276
G3 X121.043 Y114.084 I-2.668 J3.334 E.01917
G1 X118.92 Y114.084 E.04402
G1 X120.21 Y117.937 E.08426
G2 X119.998 Y120.262 I1.728 J1.33 E.0511
G2 X120.875 Y121.172 I4.633 J-3.584 E.02627
G3 X121.436 Y123.903 I-1.498 J1.731 E.06218
G3 X120.559 Y124.814 I-4.633 J-3.584 E.02627
G2 X119.998 Y127.545 I1.498 J1.731 E.06218
G2 X120.875 Y128.455 I4.632 J-3.583 E.02627
G3 X121.436 Y131.186 I-1.498 J1.731 E.06218
G3 X120.968 Y131.713 I-2.659 J-1.889 E.01464
G1 X120.401 Y130.114 E.0352
; WIPE_START
G1 X120.968 Y131.713 E-.64486
G1 X121.169 Y131.487 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.795 Y135.275 Z11.64 F60000
G1 X129.476 Y136.236 Z11.64
G1 Z11.24
G1 E.8 F1800
G1 F9000
M204 S4000
G1 X128.94 Y137.846 E.0352
G3 X128.642 Y138.742 I-6.028 J-1.507 E.01961
G2 X128.328 Y138.925 I-.079 J.226 E.00856
G2 X127.024 Y141.201 I1.638 J2.449 E.05638
G2 X127.672 Y142.566 I1.948 J-.088 E.0322
G3 X128.803 Y143.951 I-2.658 J3.323 E.03736
G1 X125.332 Y143.951 E.07198
G2 X124.914 Y142.832 I-1.392 J-.118 E.0256
G1 X123.675 Y139.339 E.07688
G2 X124.907 Y138.014 I-271.525 J-253.861 E.03754
G2 X125.077 Y135.738 I-1.79 J-1.278 E.04977
G2 X124.2 Y134.828 I-4.633 J3.584 E.02627
G3 X123.64 Y132.097 I1.498 J-1.731 E.06218
G3 X124.607 Y131.081 I13.925 J12.291 E.02909
G1 X122.643 Y125.178 E.12905
G1 X123.48 Y125.178 E.01735
G3 X124.517 Y123.903 I3.091 J1.456 E.03442
G2 X125.327 Y122.022 I-1.718 J-1.855 E.04374
G1 X128.764 Y122.022 E.0713
G3 X128.328 Y124.359 I-1.801 J.873 E.05279
G2 X127.529 Y125.178 I3.372 J4.085 E.02378
G1 X130.763 Y125.178 E.06707
G3 X131.8 Y123.903 I3.091 J1.456 E.03442
G2 X132.61 Y122.022 I-1.718 J-1.855 E.04374
G1 X134.183 Y122.022 E.03263
G1 X134.706 Y120.427 E.03483
G3 X135.832 Y121.627 I-50.369 J48.362 E.03414
G3 X136.002 Y123.903 I-1.79 J1.278 E.04977
G3 X135.125 Y124.814 I-4.633 J-3.584 E.02627
G2 X134.565 Y127.545 I1.498 J1.731 E.06218
G2 X135.441 Y128.455 I4.632 J-3.583 E.02627
G3 X135.883 Y129.004 I-1.061 J1.307 E.01473
G1 X134.524 Y132.939 E.08635
G2 X134.403 Y133.288 I.76 J.458 E.00773
G1 X131.391 Y142.004 E.19126
G3 X130.923 Y139.38 I1.526 J-1.626 E.05925
G3 X131.8 Y138.47 I4.633 J3.584 E.02627
G2 X132.36 Y135.738 I-1.498 J-1.731 E.06218
G2 X131.484 Y134.828 I-4.632 J3.583 E.02627
G3 X130.923 Y132.097 I1.498 J-1.731 E.06218
G3 X131.8 Y131.186 I4.633 J3.584 E.02627
G2 X132.36 Y128.455 I-1.498 J-1.731 E.06218
G1 X132.146 Y128.206 E.00682
G1 X132.682 Y126.596 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 11.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X132.146 Y128.206 E-.64485
G1 X132.344 Y128.436 E-.11515
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L94
M991 S0 P93 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.64 I.308 J-1.177 P1  F60000
G1 X123.325 Y126.079 Z11.64
G1 Z11.36
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.76 F60000
G1 X119.605 Y114.987 Z11.76
G1 Z11.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.76 F60000
G1 X141.28 Y114.497 Z11.76
G1 Z11.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.745 Y114.259 Z11.76 F60000
G1 Z11.36
M73 P91 R2
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365961
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X134.232 Y121.923 E.13416
G1 X134.181 Y122.02 E.00182
G1 X134.073 Y122.038 E.00182
G1 X121.687 Y122.038 E.20604
G1 X121.579 Y122.021 E.00181
G1 X121.529 Y121.924 E.00181
G1 X118.972 Y114.288 E.13395
G1 X118.959 Y114.112 E.00293
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.446252
;_EXTRUDE_SET_SPEED
G1 X119.13 Y114.069 E.00362
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.365949
;_EXTRUDE_SET_SPEED
G1 X136.579 Y114.069 E.29024
G1 X136.749 Y114.112 E.00292
G1 X136.747 Y114.199 E.00145
; Slow Down End
M204 S10000
G1 X133.018 Y126.833 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X132.492 Y128.455 E.03537
G3 X132.136 Y130.731 I-2.097 J.837 E.05015
G1 X131.532 Y131.301 E.01722
G1 X130.755 Y133.638 E.05108
G2 X131.148 Y134.373 I1.95 J-.57 E.0174
G3 X132.492 Y135.738 I-5.132 J6.397 E.03984
G3 X132.136 Y138.014 I-2.097 J.837 E.05015
G2 X130.791 Y139.38 I5.132 J6.397 E.03984
G2 X131.113 Y141.601 I2.07 J.834 E.04879
G1 X130.437 Y143.557 E.04292
G1 X128.545 Y143.557 E.03926
G1 X128.494 Y143.477 E.00197
G3 X127.149 Y142.111 I5.133 J-6.398 E.03984
G3 X127.506 Y139.835 I2.097 J-.837 E.05015
G1 X128.245 Y139.137 E.0211
G1 X126.87 Y139.137 E.02853
G1 X126.769 Y138.831 E.00667
M204 S10000
G1 X125.44 Y143.936 F60000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365797
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X125.335 Y143.919 E.00178
G1 X125.283 Y143.825 E.00178
G1 X114.72 Y114.032 E.52553
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378302
;_EXTRUDE_SET_SPEED
G1 X114.72 Y113.132 E.01552
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.39742
;_EXTRUDE_SET_SPEED
G1 X114.72 Y112.231 E.01637
G1 X114.749 Y112.093 E.00256
G1 X114.886 Y112.064 E.00256
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.378302
;_EXTRUDE_SET_SPEED
G1 X128 Y112.064 E.22604
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.403269
;_EXTRUDE_SET_SPEED
M73 P91 R1
G1 X141.113 Y112.064 E.24204
G1 X141.251 Y112.093 E.0026
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.403402
;_EXTRUDE_SET_SPEED
G1 X141.266 Y112.162 E.0013
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.389519
;_EXTRUDE_SET_SPEED
G1 X141.28 Y112.231 E.00125
G1 X141.28 Y113.902 E.02972
G1 X141.251 Y114.04 E.00251
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.403402
;_EXTRUDE_SET_SPEED
G1 X141.145 Y114.063 E.002
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.37739
;_EXTRUDE_SET_SPEED
G2 X140.989 Y114.181 I-.028 J.125 E.00384
G1 X130.746 Y143.823 E.53919
G1 X130.695 Y143.918 E.00185
G1 X130.588 Y143.936 E.00185
G1 X125.5 Y143.936 E.08748
; Slow Down End
M204 S10000
G1 X122.694 Y125.381 F60000
; Slow Down Start
; LINE_WIDTH: 0.365752
G1 F1500;_EXTRUDE_SET_SPEED
M204 S4000
G1 X122.682 Y125.206 E.00292
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.446012
;_EXTRUDE_SET_SPEED
G1 X122.852 Y125.162 E.00361
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.366321
;_EXTRUDE_SET_SPEED
G1 X132.944 Y125.162 E.16804
G1 X133.115 Y125.206 E.00293
G1 X133.11 Y125.353 E.00246
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.365956
;_EXTRUDE_SET_SPEED
G1 X128.691 Y138.644 E.23297
G1 X128.641 Y138.741 E.00181
G1 X128.533 Y138.758 E.00181
G1 X127.263 Y138.758 E.02112
G1 X127.156 Y138.741 E.00181
G1 X127.105 Y138.644 E.00181
G1 X122.713 Y125.438 E.23149
; Slow Down End
M204 S10000
G1 X118.629 Y123.942 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X118.061 Y122.343 E.0352
G2 X117.453 Y120.63 I-1.651 J-.379 E.0398
G1 X116.315 Y117.423 E.07059
G3 X117.569 Y116.165 I5.975 J4.704 E.03693
G2 X117.926 Y113.889 I-1.74 J-1.439 E.05015
G2 X116.581 Y112.523 I-6.477 J5.032 E.03984
G1 X116.531 Y112.443 E.00197
G1 X119.701 Y112.443 E.06576
G1 X119.704 Y112.523 E.00167
G2 X120.519 Y113.69 I2.396 J-.805 E.02992
G1 X118.372 Y113.69 E.04451
G1 X119.953 Y118.412 E.10328
G2 X119.866 Y120.262 I1.958 J1.019 E.03964
G2 X120.946 Y121.377 I5.283 J-4.033 E.03228
G1 X121.294 Y122.416 E.02273
G1 X121.624 Y122.416 E.00684
G3 X121.568 Y123.903 I-1.64 J.682 E.03185
G3 X120.223 Y125.269 I-6.477 J-5.032 E.03984
G2 X119.937 Y127.63 I1.644 J1.397 E.05225
G2 X121.211 Y128.911 I6.079 J-4.772 E.03755
G1 X121.499 Y129.366 E.01117
G3 X121.309 Y131.495 I-1.598 J.931 E.04728
G1 X123.932 Y138.884 E.16263
G1 X124.852 Y138.014 E.02627
G2 X125.209 Y135.738 I-1.74 J-1.439 E.05015
G2 X123.865 Y134.373 I-6.477 J5.032 E.03984
G3 X123.346 Y132.552 I1.912 J-1.529 E.04032
G3 X124.261 Y131.29 I2.54 J.879 E.0328
G1 X122.097 Y124.784 E.14224
G1 X123.533 Y124.784 E.0298
G3 X124.852 Y123.448 I6.336 J4.94 E.03903
G2 X125.332 Y122.416 I-2.238 J-1.667 E.02376
G1 X128.907 Y122.416 E.07416
G3 X128.851 Y123.903 I-1.64 J.682 E.03185
G3 X128.02 Y124.784 I-4.157 J-3.091 E.02516
G1 X130.816 Y124.784 E.058
G3 X132.136 Y123.448 I6.335 J4.939 E.03903
G2 X132.615 Y122.416 I-2.238 J-1.667 E.02376
G1 X134.468 Y122.416 E.03845
G1 X134.976 Y120.87 E.03376
G1 X135.777 Y121.627 E.02287
G3 X136.134 Y123.903 I-1.741 J1.439 E.05015
G3 X134.789 Y125.269 I-6.477 J-5.032 E.03984
G2 X134.433 Y127.545 I1.74 J1.439 E.05015
G2 X135.567 Y128.712 I5.527 J-4.238 E.03384
G1 X138.592 Y119.958 E.1921
G3 X138.074 Y117.531 I1.519 J-1.593 E.05471
G3 X139.419 Y116.165 I6.477 J5.033 E.03984
G2 X139.775 Y113.889 I-1.741 J-1.439 E.05015
G2 X138.431 Y112.523 I-6.477 J5.032 E.03984
G1 X138.38 Y112.443 E.00197
G1 X134.267 Y112.443 E.08531
G1 X134.27 Y112.523 E.00167
G2 X135.085 Y113.69 I2.396 J-.805 E.02992
G1 X132.326 Y113.69 E.05723
G2 X131.148 Y112.523 I-5.547 J4.423 E.03447
G1 X131.097 Y112.443 E.00197
G1 X126.984 Y112.443 E.08531
G1 X126.987 Y112.523 E.00167
G2 X127.802 Y113.69 I2.396 J-.805 E.02992
G1 X125.043 Y113.69 E.05723
G2 X123.865 Y112.523 I-5.549 J4.425 E.03447
G1 X123.814 Y112.443 E.00197
G1 X122.117 Y112.443 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 11.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F9000
G1 X123.814 Y112.443 E-.64486
G1 X123.865 Y112.523 E-.03617
G1 X124.012 Y112.67 E-.07897
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L95
M991 S0 P94 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.76 I-1.215 J-.062 P1  F60000
G1 X123.325 Y126.079 Z11.76
G1 Z11.48
G1 E.8 F1800
; FEATURE: Inner wall
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z11.88 F60000
G1 X119.605 Y114.987 Z11.88
G1 Z11.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z11.88 F60000
G1 X141.28 Y114.497 Z11.88
G1 Z11.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
M73 P92 R1
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.691 Y118.775 Z11.88 F60000
G1 X134.245 Y121.239 Z11.88
G1 Z11.48
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.49818
; LAYER_HEIGHT: 0.489898
G1 F1500
M204 S4000
G1 X140.033 Y116.819 E.57834
G1 X140.356 Y115.882 E.07873
G1 X134.888 Y120.058 E.54642
G1 X135.19 Y119.137 E.07693
G1 X140.68 Y114.945 E.54859
G1 X140.997 Y114.027 E.07716
G1 X141.238 Y114.027 E.01911
G1 X141.238 Y113.829 E.01568
G1 X135.492 Y118.217 E.57416
G1 X135.794 Y117.297 E.07693
G1 X141.238 Y113.139 E.54398
G1 X141.238 Y112.45 E.05478
G1 X136.096 Y116.376 E.5138
G1 X136.398 Y115.456 E.07693
G1 X140.784 Y112.106 E.43828
G1 X139.881 Y112.106 E.07173
G1 X136.7 Y114.535 E.31785
G1 X136.867 Y114.027 E.04253
G1 X136.463 Y114.027 E.03208
G1 X138.978 Y112.107 E.25127
G1 X138.075 Y112.106 E.07173
G1 X135.56 Y114.027 E.25127
G1 X134.657 Y114.027 E.07173
G1 X137.171 Y112.106 E.25127
G1 X136.268 Y112.107 E.07173
G1 X133.754 Y114.027 E.25127
G1 X132.85 Y114.027 E.07173
G1 X135.365 Y112.107 E.25127
G1 X134.462 Y112.106 E.07173
G1 X131.947 Y114.027 E.25127
G1 X131.044 Y114.027 E.07173
G1 X133.558 Y112.107 E.25127
G1 X132.655 Y112.107 E.07173
G1 X130.141 Y114.027 E.25127
G1 X129.237 Y114.027 E.07173
G1 X131.752 Y112.106 E.25127
G1 X130.849 Y112.107 E.07173
G1 X128.334 Y114.027 E.25127
G1 X127.431 Y114.027 E.07173
G1 X129.946 Y112.107 E.25127
G1 X129.042 Y112.106 E.07173
G1 X126.528 Y114.027 E.25127
G1 X125.625 Y114.027 E.07173
G1 X128.139 Y112.107 E.25127
G1 X127.236 Y112.107 E.07173
G1 X124.721 Y114.027 E.25127
G1 X123.818 Y114.027 E.07173
G1 X126.333 Y112.107 E.25127
G1 X125.429 Y112.107 E.07173
G1 X122.915 Y114.027 E.25127
G1 X122.012 Y114.027 E.07173
G1 X124.526 Y112.107 E.25127
G1 X123.623 Y112.107 E.07173
G1 X121.108 Y114.027 E.25127
G1 X120.205 Y114.027 E.07173
G1 X122.72 Y112.107 E.25127
G1 X121.816 Y112.107 E.07173
G1 X115.723 Y116.76 E.60895
G1 X115.53 Y116.217 E.04573
G1 X120.913 Y112.107 E.53794
G1 X120.01 Y112.107 E.07173
G1 X115.337 Y115.675 E.46693
G1 X115.145 Y115.132 E.04573
G1 X119.107 Y112.107 E.39591
G1 X118.204 Y112.107 E.07173
G1 X114.952 Y114.589 E.3249
G1 X114.762 Y114.045 E.04581
G1 X117.3 Y112.107 E.25365
G1 X116.397 Y112.107 E.07173
G1 X114.762 Y113.355 E.16339
G1 X114.762 Y112.665 E.05478
G1 X115.812 Y111.864 E.10493
M204 S10000
G1 X119.322 Y114.701 F60000
G1 F1500
M204 S4000
G1 X115.915 Y117.303 E.34044
G1 X116.108 Y117.845 E.04573
G1 X119.302 Y115.406 E.31918
G1 X119.486 Y115.955 E.046
G1 X116.3 Y118.388 E.31832
G1 X116.493 Y118.931 E.04573
G1 X119.67 Y116.505 E.31745
G1 X119.854 Y117.054 E.046
G1 X116.686 Y119.473 E.31658
G1 X116.878 Y120.016 E.04573
G1 X120.038 Y117.603 E.31571
G1 X120.222 Y118.153 E.046
G1 X117.071 Y120.559 E.31485
G1 X117.263 Y121.101 E.04573
G1 X120.405 Y118.702 E.31398
G1 X120.589 Y119.251 E.046
G1 X117.456 Y121.644 E.31311
G1 X117.649 Y122.187 E.04573
G1 X120.773 Y119.801 E.31224
G1 X120.957 Y120.35 E.046
G1 X117.841 Y122.729 E.31137
G1 X118.034 Y123.272 E.04573
G1 X121.141 Y120.899 E.31051
G1 X121.325 Y121.448 E.046
G1 X118.226 Y123.815 E.30964
G1 X118.419 Y124.357 E.04573
G1 X121.509 Y121.998 E.30877
G1 X121.536 Y122.08 E.00689
G1 X122.304 Y122.08 E.061
G1 X118.612 Y124.9 E.36903
G1 X118.804 Y125.443 E.04573
G1 X123.208 Y122.08 E.44004
G1 X124.111 Y122.08 E.07173
G1 X118.997 Y125.985 E.51105
G1 X119.189 Y126.528 E.04573
G1 X125.014 Y122.08 E.58206
G1 X125.917 Y122.08 E.07173
G1 X119.382 Y127.071 E.65307
G1 X119.574 Y127.613 E.04573
M73 P93 R1
G1 X126.821 Y122.08 E.72408
G1 X127.724 Y122.08 E.07173
G1 X123.743 Y125.12 E.39783
G1 X124.646 Y125.12 E.07173
G1 X128.627 Y122.08 E.39783
G1 X129.53 Y122.08 E.07173
G1 X125.549 Y125.12 E.39783
G1 X126.452 Y125.12 E.07173
G1 X130.434 Y122.08 E.39783
G1 X131.337 Y122.08 E.07173
G1 X127.356 Y125.12 E.39783
G1 X128.259 Y125.12 E.07173
G1 X132.24 Y122.08 E.39783
G1 X133.143 Y122.08 E.07173
G1 X129.162 Y125.12 E.39783
G1 X130.065 Y125.12 E.07173
G1 X139.709 Y117.756 E.96365
G1 X139.385 Y118.693 E.07873
G1 X130.968 Y125.12 E.84104
G1 X131.872 Y125.12 E.07173
G1 X139.061 Y119.63 E.71843
G1 X138.737 Y120.567 E.07873
G1 X132.775 Y125.12 E.59582
G1 X133.233 Y125.12 E.0364
G1 X133.082 Y125.575 E.03811
G1 X138.414 Y121.504 E.5328
G1 X138.09 Y122.441 E.07873
G1 X132.774 Y126.5 E.53117
G1 X132.467 Y127.425 E.07738
G1 X137.766 Y123.378 E.52954
G1 X137.442 Y124.315 E.07873
G1 X132.159 Y128.349 E.52792
G1 X131.852 Y129.274 E.07738
G1 X137.119 Y125.252 E.52629
G1 X136.795 Y126.189 E.07873
G1 X131.544 Y130.198 E.52466
G1 X131.237 Y131.123 E.07738
G1 X136.471 Y127.126 E.52303
G1 X136.147 Y128.063 E.07873
G1 X130.93 Y132.047 E.5214
G1 X130.622 Y132.972 E.07738
G1 X135.824 Y129 E.51977
G1 X135.5 Y129.937 E.07873
G1 X130.315 Y133.896 E.51815
G1 X130.007 Y134.821 E.07738
G1 X135.176 Y130.874 E.51652
G1 X134.852 Y131.811 E.07873
G1 X129.7 Y135.745 E.51489
G1 X129.392 Y136.67 E.07738
G1 X134.529 Y132.747 E.51326
G1 X134.205 Y133.684 E.07873
G1 X128.742 Y137.856 E.54593
M204 S10000
G1 X129.55 Y144.136 F60000
G1 F1500
M204 S4000
G1 X130.967 Y143.054 E.14162
G1 X131.291 Y142.117 E.07873
G1 X128.965 Y143.893 E.23244
G1 X128.062 Y143.893 E.07173
G1 X131.615 Y141.18 E.35505
G1 X131.938 Y140.243 E.07873
G1 X127.158 Y143.893 E.47766
G1 X126.255 Y143.893 E.07173
G1 X132.262 Y139.306 E.60027
G1 X132.586 Y138.369 E.07873
G1 X125.352 Y143.893 E.72283
G1 X125.16 Y143.35 E.04573
G1 X132.91 Y137.432 E.77443
G1 X133.234 Y136.495 E.07873
G1 X124.967 Y142.808 E.82603
G1 X124.775 Y142.265 E.04573
G1 X133.557 Y135.558 E.87763
G1 X133.881 Y134.621 E.07873
G1 X124.582 Y141.722 E.92922
G1 X124.389 Y141.18 E.04573
G1 X127.506 Y138.8 E.31139
G1 X127.113 Y138.8 E.03118
G1 X127.009 Y138.489 E.02602
G1 X124.197 Y140.637 E.28106
G1 X124.004 Y140.095 E.04573
G1 X126.827 Y137.939 E.28203
G1 X126.644 Y137.389 E.04604
G1 X123.812 Y139.552 E.28299
G1 X123.619 Y139.009 E.04573
G1 X126.461 Y136.839 E.28396
G1 X126.278 Y136.289 E.04604
G1 X123.426 Y138.467 E.28492
G1 X123.234 Y137.924 E.04573
G1 X126.095 Y135.739 E.28589
G1 X125.912 Y135.189 E.04604
G1 X123.041 Y137.381 E.28685
G1 X122.849 Y136.839 E.04573
G1 X125.729 Y134.639 E.28782
G1 X125.546 Y134.089 E.04604
G1 X122.656 Y136.296 E.28879
G1 X122.463 Y135.753 E.04573
G1 X125.363 Y133.539 E.28975
G1 X125.18 Y132.989 E.04604
M73 P94 R1
G1 X122.271 Y135.211 E.29072
G1 X122.078 Y134.668 E.04573
G1 X124.997 Y132.439 E.29168
G1 X124.814 Y131.889 E.04604
G1 X121.886 Y134.125 E.29265
G1 X121.693 Y133.583 E.04573
G1 X124.631 Y131.339 E.29361
G1 X124.448 Y130.789 E.04604
G1 X121.5 Y133.04 E.29458
G1 X121.308 Y132.497 E.04573
G1 X124.265 Y130.239 E.29555
G1 X124.083 Y129.689 E.04604
G1 X121.115 Y131.955 E.29651
G1 X120.923 Y131.412 E.04573
G1 X123.9 Y129.139 E.29748
G1 X123.717 Y128.589 E.04604
G1 X120.73 Y130.869 E.29844
G1 X120.537 Y130.327 E.04573
G1 X123.534 Y128.039 E.29941
G1 X123.351 Y127.488 E.04604
G1 X120.345 Y129.784 E.30037
G1 X120.152 Y129.241 E.04573
G1 X123.168 Y126.938 E.30134
G1 X122.985 Y126.388 E.04604
G1 X119.96 Y128.699 E.30231
G1 X119.767 Y128.156 E.04573
G1 X123.006 Y125.682 E.32367
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F1500
G1 X121.417 Y126.896 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L96
M991 S0 P95 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z11.88 I.479 J1.119 P1  F60000
G1 X123.325 Y126.079 Z11.88
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z12 F60000
G1 X119.605 Y114.987 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z12 F60000
G1 X141.28 Y114.497 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z12 F60000
G1 X117.069 Y114.752 Z12
G1 Z11.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506702
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.84 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.45 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.493067
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451817
G1 X130.222 Y139.153 E.14558
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421211
G1 X129.846 Y139.785 E.00796
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363551
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410067
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455631
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434955
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.46488
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456584
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410067
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366152
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420582
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-254.477 J-89.1 E.06213
; LINE_WIDTH: 0.452397
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.493067
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.214 J-13.881 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
M73 P95 R1
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.57 J-201.139 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 11.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L97
M991 S0 P96 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z12.12 F60000
G1 X119.605 Y114.987 Z12.12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z12.12 F60000
G1 X141.28 Y114.497 Z12.12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P95 R0
G1 X134.447 Y113.783 Z12.12 F60000
G1 X117.069 Y114.752 Z12.12
G1 Z11.72
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506702
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.84 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.45 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.493067
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451817
G1 X130.222 Y139.153 E.14558
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421211
G1 X129.846 Y139.785 E.00796
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363551
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410067
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455631
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434955
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.46488
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456584
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410067
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366152
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420582
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-254.477 J-89.1 E.06213
; LINE_WIDTH: 0.452397
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.493067
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.214 J-13.881 E.01024
G1 X121.141 Y123.139 E.00474
M73 P96 R0
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.57 J-201.139 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 11.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L98
M991 S0 P97 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.12 I1.213 J-.102 P1  F60000
G1 X123.325 Y126.079 Z12.12
G1 Z11.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X127.416 Y138.38 E.26888
G1 X128.38 Y138.38 E.01999
G1 X132.65 Y125.541 E.28065
G1 X123.146 Y125.541 E.19713
G1 X123.307 Y126.022 E.01052
; COOLING_NODE: 0
M204 S250
G1 X123.714 Y125.95 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 0
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.732 Y120.698 Z12.24 F60000
G1 X119.605 Y114.987 Z12.24
G1 Z11.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X121.839 Y121.659 E.14596
G1 X133.92 Y121.659 E.25058
G1 X136.286 Y114.447 E.15744
G1 X119.425 Y114.447 E.34976
G1 X119.586 Y114.93 E.01055
; COOLING_NODE: 1
M204 S250
G1 X119.993 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.259 Y115.926 Z12.24 F60000
G1 X141.28 Y114.497 Z12.24
G1 Z11.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9000
M204 S4000
G1 X141.297 Y114.447 E.00109
G1 X141.659 Y114.447 E.0075
G1 X141.659 Y111.686 E.05728
G1 X114.341 Y111.686 E.56663
G1 X114.341 Y114.447 E.05728
G1 X114.455 Y114.447 E.00237
G1 X125.055 Y144.314 E.65737
G1 X130.977 Y144.314 E.12283
G1 X141.26 Y114.554 E.65312
; COOLING_NODE: 2
M204 S250
G1 X141.589 Y114.857 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.447 Y113.783 Z12.24 F60000
G1 X117.069 Y114.752 Z12.24
G1 Z11.84
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.355345
G1 F10800
M204 S4000
G1 X117.034 Y114.608 E.0024
; LINE_WIDTH: 0.40189
G1 X117 Y114.463 E.00274
; LINE_WIDTH: 0.448435
G1 X116.965 Y114.318 E.00307
; LINE_WIDTH: 0.49498
G1 X116.93 Y114.174 E.00341
M204 S10000
G1 X120.724 Y124.863 F60000
; LINE_WIDTH: 0.506712
G1 F10800
M204 S4000
G1 X120.926 Y124.242 E.01536
G1 X121.095 Y123.996 E.00702
G1 X120.812 Y123.903 E.00702
G1 X120.243 Y123.507 E.0163
G1 X120.704 Y124.806 E.03242
M204 S10000
G1 X135.102 Y124.915 F60000
; LINE_WIDTH: 0.532112
G1 F10800
M204 S4000
G1 X135.607 Y123.453 E.0383
G1 X135.002 Y123.892 E.0185
G1 X134.714 Y123.994 E.00757
G1 X134.887 Y124.246 E.00757
G1 X135.084 Y124.858 E.01593
M204 S10000
G1 X132.944 Y125.132 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.095 Y125.202 E.00322
G1 X133.139 Y125.36 E.00315
G1 X133.131 Y125.391 E.00061
G1 X128.72 Y138.656 E.26946
G1 X128.619 Y138.769 E.00292
G1 X128.533 Y138.789 E.00169
G1 X127.263 Y138.789 E.02448
G1 X127.122 Y138.729 E.00296
G1 X127.076 Y138.654 E.0017
G1 X122.665 Y125.391 E.26942
G1 X122.681 Y125.232 E.00308
G1 X122.818 Y125.134 E.00325
G1 X122.852 Y125.132 E.00066
G1 X132.884 Y125.132 E.19337
M204 S10000
G1 X132.944 Y124.737 F60000
G1 F10800
M204 S4000
G1 X133.293 Y124.851 E.00708
G1 X133.461 Y125.041 E.00487
G1 X133.532 Y125.262 E.00448
G1 X133.505 Y125.515 E.00491
G1 X129.092 Y138.785 E.26955
G1 X128.971 Y138.989 E.00459
G1 X128.79 Y139.124 E.00435
G1 X128.533 Y139.183 E.00507
G1 X127.263 Y139.183 E.02448
G1 X127.039 Y139.139 E.0044
G1 X126.839 Y139.004 E.00465
G1 X126.702 Y138.778 E.00509
G1 X122.291 Y125.515 E.26942
G1 X122.265 Y125.26 E.00495
G1 X122.397 Y124.951 E.00647
G1 X122.494 Y124.858 E.00259
G1 X122.852 Y124.737 E.00728
G1 X132.884 Y124.737 E.19337
M204 S10000
G1 X132.944 Y124.343 F60000
G1 F10800
M204 S4000
G1 X133.526 Y124.533 E.0118
G1 X133.805 Y124.849 E.00812
G1 X133.923 Y125.218 E.00747
G1 X133.879 Y125.64 E.00818
G1 X129.465 Y138.914 E.26964
G1 X129.263 Y139.255 E.00764
G1 X128.961 Y139.48 E.00726
G1 X128.533 Y139.577 E.00845
G1 X127.263 Y139.577 E.02448
G1 X126.89 Y139.504 E.00733
G1 X126.557 Y139.279 E.00775
G1 X126.328 Y138.903 E.00849
G1 X121.917 Y125.64 E.26942
G1 X121.873 Y125.214 E.00824
G1 X121.994 Y124.844 E.0075
G1 X122.255 Y124.544 E.00767
G1 X122.682 Y124.358 E.00897
G1 X122.852 Y124.343 E.00329
G1 X132.884 Y124.343 E.19337
M204 S10000
G1 X132.944 Y123.873 F60000
; LINE_WIDTH: 0.552721
G1 F10800
M204 S4000
G1 X133.148 Y123.958 E.00569
; LINE_WIDTH: 0.514798
G1 X133.351 Y124.044 E.00528
; LINE_WIDTH: 0.476876
G1 X133.555 Y124.129 E.00487
; LINE_WIDTH: 0.420108
G1 X133.759 Y124.215 E.00426
G3 X134.149 Y124.657 I-.814 J1.114 E.01146
G1 X134.315 Y125.173 E.01046
G1 X134.307 Y125.547 E.00721
G1 X134.253 Y125.764 E.00431
G1 X129.837 Y139.042 E.2698
G3 X129.554 Y139.52 I-1.304 J-.451 E.01078
G1 X129.132 Y139.835 E.01016
G1 X128.694 Y139.962 E.00879
G1 X128.533 Y139.972 E.00311
G1 X127.263 Y139.972 E.02449
G1 X126.741 Y139.869 E.01026
G1 X126.274 Y139.554 E.01085
G3 X125.954 Y139.027 I.989 J-.962 E.01199
G1 X121.543 Y125.764 E.2695
G1 X121.482 Y125.169 E.01154
G1 X121.651 Y124.651 E.01051
G3 X122.017 Y124.231 I1.202 J.678 E.01082
; LINE_WIDTH: 0.440591
G1 X122.162 Y124.145 E.00343
; LINE_WIDTH: 0.481788
G1 X122.308 Y124.059 E.00377
; LINE_WIDTH: 0.522986
G1 X122.454 Y123.974 E.00411
; LINE_WIDTH: 0.57172
G1 X122.6 Y123.888 E.00451
G1 X122.852 Y123.873 E.00676
G1 X132.884 Y123.873 E.26779
M204 S10000
G1 X133.222 Y123.645 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X133.991 Y123.897 E.0156
G1 X134.306 Y124.191 E.00831
G1 X134.494 Y124.465 E.0064
G1 X134.707 Y125.129 E.01344
; LINE_WIDTH: 0.438157
G1 X134.721 Y125.292 E.0033
; LINE_WIDTH: 0.474487
G1 X134.735 Y125.455 E.00359
; LINE_WIDTH: 0.517492
G1 X134.75 Y125.618 E.00394
G1 X134.672 Y125.903 E.0071
; LINE_WIDTH: 0.49307
G1 X132.447 Y132.528 E.15968
; LINE_WIDTH: 0.451825
G1 X130.222 Y139.153 E.14559
G1 X130.097 Y139.459 E.00688
; LINE_WIDTH: 0.421212
G1 X129.846 Y139.785 E.00795
G1 X129.303 Y140.19 E.0131
G1 X128.74 Y140.354 E.01133
G1 X127.263 Y140.366 E.02856
G1 X126.592 Y140.234 E.01323
G1 X125.992 Y139.829 E.01399
; LINE_WIDTH: 0.403602
G1 X125.87 Y139.639 E.00417
; LINE_WIDTH: 0.356794
G3 X125.618 Y139.139 I1.293 J-.966 E.00911
; LINE_WIDTH: 0.363552
G1 X124.125 Y134.725 E.07695
; LINE_WIDTH: 0.410072
G1 X122.633 Y130.312 E.08755
; LINE_WIDTH: 0.455639
G1 X121.14 Y125.898 E.09793
G1 X121.09 Y125.123 E.01633
; LINE_WIDTH: 0.419992
G1 X121.307 Y124.457 E.0135
G3 X121.778 Y123.917 I1.545 J.872 E.01391
G1 X122.399 Y123.645 E.01306
G1 X121.687 Y123.645 E.01373
M73 P97 R0
G3 X120.985 Y123.501 I0 J-1.774 E.01391
G1 X120.403 Y123.096 E.01365
; LINE_WIDTH: 0.437349
G1 X120.301 Y122.988 E.003
; LINE_WIDTH: 0.472062
G1 X120.199 Y122.879 E.00325
; LINE_WIDTH: 0.513525
G1 X120.097 Y122.77 E.00356
G1 X119.962 Y122.449 E.00832
; LINE_WIDTH: 0.52624
G1 X118.705 Y118.748 E.09565
; LINE_WIDTH: 0.561335
G1 X117.447 Y115.047 E.10235
; LINE_WIDTH: 0.559021
G1 X117.425 Y114.82 E.00594
; LINE_WIDTH: 0.519298
G1 X117.403 Y114.593 E.0055
; LINE_WIDTH: 0.479576
G1 X117.381 Y114.366 E.00506
; LINE_WIDTH: 0.421438
G1 X117.358 Y114.139 E.00441
G1 X117.477 Y113.672 E.00933
G1 X116.328 Y113.672 E.02224
G1 X116.333 Y113.799 E.00247
G1 X116.735 Y114.871 E.02214
; LINE_WIDTH: 0.439853
G1 X116.783 Y114.96 E.00204
; LINE_WIDTH: 0.479576
G1 X116.83 Y115.049 E.00224
; LINE_WIDTH: 0.519298
G1 X116.877 Y115.138 E.00243
; LINE_WIDTH: 0.543981
G1 X116.924 Y115.227 E.00255
G1 X119.506 Y122.606 E.19807
; LINE_WIDTH: 0.516412
G1 X119.645 Y122.976 E.00949
; LINE_WIDTH: 0.506776
G1 X119.687 Y123.146 E.00411
; LINE_WIDTH: 0.472062
G1 X119.729 Y123.316 E.00382
; LINE_WIDTH: 0.421512
G1 X119.771 Y123.486 E.00338
G1 X120.38 Y125.203 E.03526
; LINE_WIDTH: 0.434957
G1 X120.546 Y125.624 E.00906
; LINE_WIDTH: 0.464887
G1 X120.711 Y126.046 E.00972
; LINE_WIDTH: 0.456592
G1 X122.247 Y130.444 E.09814
; LINE_WIDTH: 0.410072
G1 X123.784 Y134.843 E.08755
; LINE_WIDTH: 0.366153
G1 X125.32 Y139.241 E.07754
G1 X125.647 Y140.043 E.01442
; LINE_WIDTH: 0.420583
G1 X126.458 Y142.328 E.0468
G1 X129.562 Y142.328 E.05991
G2 X130.607 Y139.284 I-255.938 J-89.602 E.06213
; LINE_WIDTH: 0.452405
G1 X132.87 Y132.672 E.14578
; LINE_WIDTH: 0.49307
G1 X135.134 Y126.06 E.15968
; LINE_WIDTH: 0.49005
G1 X135.305 Y125.637 E.01036
; LINE_WIDTH: 0.424668
G1 X135.475 Y125.214 E.0089
G1 X136.071 Y123.491 E.03555
; LINE_WIDTH: 0.440692
G1 X136.147 Y123.207 E.00596
; LINE_WIDTH: 0.482092
G1 X136.223 Y122.924 E.00655
; LINE_WIDTH: 0.525575
G3 X136.31 Y122.609 I2.328 J.473 E.00798
; LINE_WIDTH: 0.561642
G1 X137.743 Y118.409 E.11628
; LINE_WIDTH: 0.559091
G1 X137.794 Y118.321 E.00266
; LINE_WIDTH: 0.519348
G1 X137.845 Y118.233 E.00246
; LINE_WIDTH: 0.479606
G1 X137.897 Y118.145 E.00226
; LINE_WIDTH: 0.420189
G1 X137.948 Y118.057 E.00197
G1 X139.464 Y113.672 E.08947
G1 X138.233 Y113.672 E.02373
G1 X138.352 Y114.156 E.0096
G3 X138.265 Y114.788 I-1.772 J.08 E.01238
G1 X137.268 Y117.828 E.06169
; LINE_WIDTH: 0.439863
G1 X137.255 Y117.929 E.00206
; LINE_WIDTH: 0.479606
G1 X137.243 Y118.03 E.00226
; LINE_WIDTH: 0.519348
G1 X137.231 Y118.131 E.00246
; LINE_WIDTH: 0.561585
G1 X137.218 Y118.233 E.00267
G1 X135.818 Y122.444 E.11627
; LINE_WIDTH: 0.523601
G1 X135.671 Y122.654 E.00625
; LINE_WIDTH: 0.482157
G1 X135.524 Y122.865 E.00573
; LINE_WIDTH: 0.422117
G1 X135.376 Y123.075 E.00498
G1 X134.814 Y123.483 E.01346
G1 X134.501 Y123.593 E.00643
G1 X134.073 Y123.645 E.00835
G1 X133.282 Y123.645 E.01533
M204 S10000
G1 X132.944 Y123.327 F60000
; LINE_WIDTH: 0.571872
G1 F10800
M204 S4000
G1 X122.551 Y123.334 E.2775
; LINE_WIDTH: 0.564183
G1 X122.335 Y123.313 E.00572
; LINE_WIDTH: 0.522986
G1 X122.119 Y123.292 E.00528
; LINE_WIDTH: 0.481788
G1 X121.903 Y123.272 E.00484
; LINE_WIDTH: 0.42004
G3 X121.374 Y123.215 I1.213 J-13.875 E.01024
G1 X121.141 Y123.139 E.00474
G1 X120.688 Y122.824 E.01062
G3 X120.378 Y122.309 I.998 J-.953 E.01168
G1 X117.821 Y114.673 E.15524
G1 X117.752 Y114.161 E.00997
G1 X117.884 Y113.642 E.01031
G1 X118.192 Y113.278 E.0092
G1 X115.933 Y113.278 E.04354
G1 X115.933 Y113.852 E.01107
G3 X116.478 Y115.386 I-37.732 J14.255 E.03138
G1 X126.18 Y142.722 E.55919
G1 X129.843 Y142.722 E.07061
G1 X139.842 Y113.785 E.59021
G1 X140.067 Y113.35 E.00943
G1 X140.067 Y113.278 E.0014
G1 X137.518 Y113.278 E.04914
G1 X137.83 Y113.653 E.00941
G1 X137.958 Y114.173 E.01033
G1 X137.89 Y114.665 E.00958
G1 X135.385 Y122.302 E.15493
G1 X135.087 Y122.808 E.01132
G1 X134.65 Y123.125 E.01041
G3 X134.073 Y123.251 I-.576 J-1.254 E.01146
; LINE_WIDTH: 0.438953
G1 X133.806 Y123.269 E.00541
; LINE_WIDTH: 0.476876
G1 X133.539 Y123.287 E.00591
; LINE_WIDTH: 0.514798
G1 X133.271 Y123.305 E.00641
; LINE_WIDTH: 0.552721
G1 X133.004 Y123.323 E.0069
M204 S10000
G1 X134.073 Y122.857 F60000
; LINE_WIDTH: 0.415138
G1 F10800
M204 S4000
G1 X121.687 Y122.857 E.23582
G1 X121.297 Y122.777 E.00758
G1 X120.974 Y122.552 E.00749
G1 X120.752 Y122.184 E.00817
G1 X118.195 Y114.548 E.15331
G3 X118.146 Y114.182 I.934 J-.313 E.00708
G1 X118.24 Y113.812 E.00727
G1 X118.564 Y113.428 E.00955
G1 X118.96 Y113.267 E.00814
G1 X119.13 Y113.257 E.00324
G1 X136.579 Y113.257 E.3322
G1 X137.15 Y113.431 E.01136
G1 X137.473 Y113.819 E.00961
G1 X137.564 Y114.191 E.00729
G1 X137.516 Y114.543 E.00676
G1 X135.01 Y122.179 E.153
G1 X134.797 Y122.54 E.00799
G1 X134.485 Y122.767 E.00734
G1 X134.132 Y122.844 E.00688
M204 S10000
G1 X134.073 Y122.463 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X121.687 Y122.463 E.23876
G1 X121.453 Y122.414 E.0046
G1 X121.259 Y122.28 E.00455
G1 X121.126 Y122.059 E.00497
G1 X118.569 Y114.423 E.15522
G3 X118.596 Y113.981 I.694 J-.18 E.00867
G1 X118.79 Y113.751 E.0058
G1 X119.13 Y113.644 E.00686
G1 X136.579 Y113.644 E.33634
G1 X136.921 Y113.753 E.00692
G1 X137.115 Y113.986 E.00584
G1 X137.163 Y114.329 E.00668
G1 X137.141 Y114.42 E.0018
G1 X134.632 Y122.064 E.15509
G1 X134.508 Y122.273 E.00468
G1 X134.216 Y122.445 E.00653
G1 X134.133 Y122.455 E.00161
M204 S10000
G1 X134.073 Y122.068 F60000
G1 F10800
M204 S4000
G1 X121.687 Y122.068 E.23876
G1 X121.544 Y122.007 E.00299
G1 X121.5 Y121.934 E.00165
G1 X118.943 Y114.298 E.15522
G3 X118.952 Y114.151 I.187 J-.063 E.00292
G1 X119.096 Y114.041 E.00349
G1 X119.13 Y114.038 E.00066
G1 X136.579 Y114.038 E.33634
G1 X136.693 Y114.074 E.00231
G1 X136.776 Y114.226 E.00334
G1 X136.767 Y114.297 E.00137
G1 X134.26 Y121.936 E.15497
G1 X134.156 Y122.05 E.00298
G1 X134.132 Y122.056 E.00047
M204 S10000
G1 X138.814 Y114.135 F60000
; LINE_WIDTH: 0.53753
G1 F10800
M204 S4000
G1 X138.768 Y114.328 E.00497
; LINE_WIDTH: 0.498205
G1 X138.722 Y114.522 E.00459
; LINE_WIDTH: 0.45888
G1 X138.676 Y114.715 E.00421
; LINE_WIDTH: 0.419555
G1 X138.63 Y114.908 E.00383
; LINE_WIDTH: 0.374922
G1 X137.628 Y117.883 E.05359
M204 S10000
G1 X129.86 Y140.257 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X129.474 Y140.545 E.00929
G1 X128.786 Y140.745 E.0138
G1 X128.533 Y140.76 E.00489
G1 X127.263 Y140.76 E.02448
G1 X126.443 Y140.599 E.01612
G1 X126.206 Y140.439 E.0055
G1 X126.736 Y141.934 E.03057
G1 X129.281 Y141.934 E.04904
G1 X129.841 Y140.314 E.03303
M204 S10000
G1 X129.17 Y141.041 F60000
; LINE_WIDTH: 0.41782
G1 F10800
M204 S4000
G3 X128.533 Y141.152 I-.544 J-1.244 E.0125
G1 X127.263 Y141.152 E.02434
G1 X126.851 Y141.083 E.00801
G1 X127.014 Y141.541 E.00931
G2 X128.998 Y141.537 I.572 J-200.681 E.03804
G1 X129.15 Y141.098 E.0089
M204 S10000
G1 X125.901 Y143.116 F60000
; LINE_WIDTH: 0.417244
G1 F10800
M204 S4000
G1 X130.124 Y143.116 E.08082
G1 X140.214 Y113.913 E.59141
G1 X140.364 Y113.635 E.00605
G1 X140.461 Y113.587 E.00206
G1 X140.461 Y112.884 E.01347
G3 X136.579 Y112.877 I-1.568 J-205.722 E.0743
G1 X119.13 Y112.877 E.334
G3 X115.539 Y112.884 I-2.165 J-188.294 E.06873
G1 X115.539 Y113.92 E.01983
G3 X116.106 Y115.518 I-56.967 J21.118 E.03245
G1 X125.881 Y143.06 E.5594
M204 S10000
G1 X125.623 Y143.511 F60000
; LINE_WIDTH: 0.419992
G1 F10800
M204 S4000
G1 X130.404 Y143.511 E.09217
G1 X140.587 Y114.042 E.60097
G1 X140.677 Y113.875 E.00366
G1 X140.855 Y113.787 E.00383
G1 X140.855 Y112.489 E.02502
G1 X115.145 Y112.489 E.49558
G1 X115.145 Y114.025 E.0296
G3 X115.735 Y115.649 I-38.915 J15.048 E.03331
G1 X125.603 Y143.454 E.5687
M204 S10000
G1 X125.344 Y143.905 F60000
G1 F10800
M204 S4000
G1 X130.685 Y143.905 E.10295
G1 X140.96 Y114.171 E.60639
G1 X140.99 Y114.115 E.00122
G1 X141.146 Y114.038 E.00336
G1 X141.249 Y114.038 E.00199
G1 X141.249 Y112.095 E.03745
G1 X114.751 Y112.095 E.51077
G1 X114.751 Y114.141 E.03943
G1 X114.847 Y114.327 E.00404
G3 X115.363 Y115.781 I-92.763 J33.741 E.02975
G1 X125.324 Y143.848 E.57406
; CHANGE_LAYER
; Z_HEIGHT: 11.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F10800
G1 X124.655 Y141.964 E-.76
; WIPE_END
G1 E-.04 F1800
;======== X2D layer_change gcode ==========
;===== 2026/07/01 =====






; update layer progress
M73 L99
M991 S0 P98 ;notify layer change

; OBJECT_ID: 218
; COOLING_NODE: 0
M204 S10000
G17
G3 Z12.24 I1.215 J-.071 P1  F60000
G1 X123.714 Y125.95 Z12.24
G1 Z11.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X127.711 Y137.97 E.24418
G1 X128.085 Y137.97 E.0072
G1 X132.083 Y125.95 E.24418
G1 X123.774 Y125.95 E.16016
; COOLING_NODE: 1
; WIPE_START
M204 S4000
G1 X124.396 Y127.851 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.947 Y120.622 Z12.36 F60000
G1 X119.993 Y114.857 Z12.36
G1 Z11.96
G1 E.8 F1800
G1 F3600
M204 S2000
G1 X122.134 Y121.25 E.12996
G1 X133.623 Y121.25 E.22147
G1 X135.721 Y114.857 E.1297
G1 X120.053 Y114.857 E.30202
; COOLING_NODE: 2
; WIPE_START
M204 S4000
G1 X120.672 Y116.758 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.273 Y116.067 Z12.36 F60000
G1 X141.589 Y114.857 Z12.36
G1 Z11.96
G1 E.8 F1800
G1 F3600
M204 S2000
G1 X142.068 Y114.857 E.00924
G1 X142.068 Y111.277 E.06901
G1 X113.932 Y111.277 E.54234
G1 X113.932 Y114.857 E.06901
G1 X114.166 Y114.857 E.00452
G1 X124.766 Y144.723 E.61089
G1 X131.268 Y144.723 E.12533
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

G1 X141.569 Y114.913 E.60795
; WIPE_START
M204 S4000
G1 X142.068 Y114.857 E-.19078
G1 X142.068 Y113.359 E-.56922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.322 Y111.493 Z12.36 F60000
G1 Z11.96
G1 E.8 F1800
; FEATURE: Top surface
G1 F9000
M204 S2000
G1 X141.851 Y112.023 E.01443
G1 X141.985 Y112.156
G1 X141.985 Y112.714
G1 X141.851 Y112.58
G1 X140.764 Y111.493 E.02963
G1 X140.631 Y111.36
G1 X140.073 Y111.36
G1 X140.207 Y111.493
G1 X141.851 Y113.138 E.04483
G1 X141.985 Y113.272
G1 X141.985 Y113.829
G1 X141.851 Y113.695
G1 X139.649 Y111.493 E.06003
G1 X139.515 Y111.36
G1 X138.958 Y111.36
G1 X139.092 Y111.493
G1 X141.851 Y114.253 E.07522
G1 X141.985 Y114.387
G1 X141.814 Y114.773
G1 X141.68 Y114.64
G1 X138.534 Y111.493 E.08577
G1 X138.4 Y111.36
G1 X137.843 Y111.36
G1 X137.976 Y111.493
G1 X141.354 Y114.871 E.09208
G1 X141.488 Y115.005
G1 X141.345 Y115.419
G1 X141.211 Y115.286
G1 X137.419 Y111.493 E.10337
G1 X137.285 Y111.36
G1 X136.728 Y111.36
G1 X136.861 Y111.493
G1 X141.068 Y115.7 E.11467
G1 X141.202 Y115.834
G1 X141.058 Y116.248
G1 X140.925 Y116.114
G1 X136.304 Y111.493 E.12596
G1 X136.17 Y111.36
G1 X135.613 Y111.36
G1 X135.746 Y111.493
G1 X140.782 Y116.529 E.13726
G1 X140.915 Y116.662
G1 X140.772 Y117.077
G1 X140.638 Y116.943
G1 X135.189 Y111.493 E.14855
G1 X135.055 Y111.36
G1 X134.498 Y111.36
G1 X134.631 Y111.493
G1 X140.495 Y117.357 E.15985
G1 X140.629 Y117.491
G1 X140.486 Y117.905
G1 X140.352 Y117.772
G1 X134.074 Y111.493 E.17115
G1 X133.94 Y111.36
G1 X133.383 Y111.36
G1 X133.516 Y111.493
G1 X140.209 Y118.186 E.18244
G1 X140.342 Y118.32
G1 X140.199 Y118.734
G1 X140.066 Y118.6
G1 X132.959 Y111.493 E.19374
G1 X132.825 Y111.36
G1 X132.267 Y111.36
G1 X132.401 Y111.493
G1 X135.547 Y114.64 E.08577
G1 X135.681 Y114.773
G1 X135.124 Y114.773
G1 X134.99 Y114.64
G1 X131.844 Y111.493 E.08577
G1 X131.71 Y111.36
G1 X131.152 Y111.36
G1 X131.286 Y111.493
G1 X134.432 Y114.64 E.08577
G1 X134.566 Y114.773
G1 X134.008 Y114.773
G1 X133.875 Y114.64
G1 X130.728 Y111.493 E.08577
G1 X130.595 Y111.36
G1 X130.037 Y111.36
G1 X130.171 Y111.493
G1 X133.317 Y114.64 E.08577
G1 X133.451 Y114.773
G1 X132.893 Y114.773
G1 X132.76 Y114.64
G1 X129.613 Y111.493 E.08577
G1 X129.48 Y111.36
G1 X128.922 Y111.36
G1 X129.056 Y111.493
G1 X132.202 Y114.64 E.08577
G1 X132.336 Y114.773
G1 X131.778 Y114.773
G1 X131.645 Y114.64
G1 X128.498 Y111.493 E.08577
G1 X128.365 Y111.36
G1 X127.807 Y111.36
G1 X127.941 Y111.493
G1 X131.087 Y114.64 E.08577
G1 X131.221 Y114.773
G1 X130.663 Y114.773
G1 X130.53 Y114.64
G1 X127.383 Y111.493 E.08577
G1 X127.25 Y111.36
G1 X126.692 Y111.36
G1 X126.826 Y111.493
G1 X129.972 Y114.64 E.08577
G1 X130.106 Y114.773
G1 X129.548 Y114.773
G1 X129.414 Y114.64
G1 X126.268 Y111.493 E.08577
G1 X126.135 Y111.36
G1 X125.577 Y111.36
G1 X125.711 Y111.493
G1 X128.857 Y114.64 E.08577
G1 X128.991 Y114.773
G1 X128.433 Y114.773
G1 X128.299 Y114.64
G1 X125.153 Y111.493 E.08577
G1 X125.019 Y111.36
G1 X124.462 Y111.36
G1 X124.596 Y111.493
G1 X127.742 Y114.64 E.08577
G1 X127.876 Y114.773
G1 X127.318 Y114.773
G1 X127.184 Y114.64
G1 X124.038 Y111.493 E.08577
G1 X123.904 Y111.36
G1 X123.347 Y111.36
G1 X123.48 Y111.493
G1 X126.627 Y114.64 E.08577
G1 X126.76 Y114.773
G1 X126.203 Y114.773
G1 X126.069 Y114.64
G1 X122.923 Y111.493 E.08577
G1 X122.789 Y111.36
G1 X122.232 Y111.36
G1 X122.365 Y111.493
G1 X125.512 Y114.64 E.08577
G1 X125.645 Y114.773
M73 P98 R0
G1 X125.088 Y114.773
G1 X124.954 Y114.64
G1 X121.808 Y111.493 E.08577
G1 X121.674 Y111.36
G1 X121.117 Y111.36
G1 X121.25 Y111.493
G1 X124.397 Y114.64 E.08577
G1 X124.53 Y114.773
G1 X123.973 Y114.773
G1 X123.839 Y114.64
G1 X120.693 Y111.493 E.08577
G1 X120.559 Y111.36
G1 X120.002 Y111.36
G1 X120.135 Y111.493
G1 X123.282 Y114.64 E.08577
G1 X123.415 Y114.773
G1 X122.858 Y114.773
G1 X122.724 Y114.64
G1 X119.578 Y111.493 E.08577
G1 X119.444 Y111.36
G1 X118.886 Y111.36
G1 X119.02 Y111.493
G1 X122.166 Y114.64 E.08577
G1 X122.3 Y114.773
G1 X121.743 Y114.773
G1 X121.609 Y114.64
G1 X118.463 Y111.493 E.08577
G1 X118.329 Y111.36
G1 X117.771 Y111.36
G1 X117.905 Y111.493
G1 X121.051 Y114.64 E.08577
G1 X121.185 Y114.773
G1 X120.627 Y114.773
G1 X120.494 Y114.64
G1 X117.348 Y111.493 E.08577
G1 X117.214 Y111.36
G1 X116.656 Y111.36
G1 X116.79 Y111.493
G1 X119.936 Y114.64 E.08577
G1 X120.07 Y114.773
G1 X119.983 Y115.244
G1 X119.849 Y115.11
G1 X116.232 Y111.493 E.0986
G1 X116.099 Y111.36
G1 X115.541 Y111.36
G1 X115.675 Y111.493
G1 X120.13 Y115.949 E.12145
G1 X120.264 Y116.082
G1 X120.544 Y116.92
G1 X120.411 Y116.787
G1 X115.117 Y111.493 E.1443
G1 X114.984 Y111.36
G1 X114.426 Y111.36
G1 X114.56 Y111.493
G1 X120.691 Y117.625 E.16715
G1 X120.825 Y117.759
G1 X121.106 Y118.597
G1 X120.972 Y118.463
G1 X114.149 Y111.64 E.186
G1 X114.015 Y111.506
G1 X114.015 Y112.064
G1 X114.149 Y112.198
G1 X121.253 Y119.301 E.19365
G1 X121.386 Y119.435
G1 X121.667 Y120.273
G1 X121.533 Y120.14
G1 X114.149 Y112.755 E.2013
G1 X114.015 Y112.621
G1 X114.015 Y113.179
G1 X114.149 Y113.313
G1 X121.814 Y120.978 E.20895
; WIPE_START
M204 S4000
G1 X120.4 Y119.563 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.721 Y117.407 Z12.36 F60000
G1 X135.904 Y114.996 Z12.36
G1 Z11.96
G1 E.8 F1800
G1 F9000
M204 S2000
G1 X139.922 Y119.015 E.10955
G1 X140.056 Y119.148
G1 X139.913 Y119.563
G1 X139.779 Y119.429
G1 X135.766 Y115.416 E.1094
G1 X135.632 Y115.282
G1 X135.495 Y115.702
G1 X135.628 Y115.836
G1 X139.636 Y119.844 E.10925
G1 X139.77 Y119.977
G1 X139.627 Y120.392
G1 X139.493 Y120.258
G1 X135.491 Y116.256 E.1091
G1 X135.357 Y116.122
G1 X135.219 Y116.542
G1 X135.353 Y116.675
G1 X139.35 Y120.672 E.10896
G1 X139.483 Y120.806
G1 X139.34 Y121.22
G1 X139.207 Y121.087
G1 X135.215 Y117.095 E.10881
G1 X135.081 Y116.961
G1 X134.944 Y117.381
G1 X135.077 Y117.515
G1 X139.063 Y121.501 E.10866
G1 X139.197 Y121.635
G1 X139.054 Y122.049
G1 X138.92 Y121.915
G1 X134.94 Y117.935 E.10851
G1 X134.806 Y117.801
G1 X134.668 Y118.221
G1 X134.802 Y118.354
G1 X138.777 Y122.33 E.10836
G1 X138.911 Y122.463
G1 X138.767 Y122.878
G1 X138.634 Y122.744
G1 X134.664 Y118.774 E.10822
G1 X134.53 Y118.641
G1 X134.393 Y119.06
G1 X134.526 Y119.194
G1 X138.491 Y123.158 E.10807
G1 X138.624 Y123.292
G1 X138.481 Y123.706
G1 X138.347 Y123.573
G1 X134.389 Y119.614 E.10792
G1 X134.255 Y119.48
G1 X134.117 Y119.9
G1 X134.251 Y120.034
G1 X138.204 Y123.987 E.10777
G1 X138.338 Y124.121
G1 X138.195 Y124.535
G1 X138.061 Y124.401
G1 X134.113 Y120.453 E.10763
G1 X133.979 Y120.32
G1 X133.842 Y120.74
G1 X133.975 Y120.873
G1 X137.918 Y124.816 E.10748
G1 X138.052 Y124.949
G1 X137.908 Y125.364
G1 X137.775 Y125.23
G1 X133.838 Y121.293 E.10733
G1 X133.704 Y121.159
G1 X133.32 Y121.333
G1 X133.454 Y121.467
G1 X137.632 Y125.645 E.11389
G1 X137.765 Y125.778
G1 X137.622 Y126.193
G1 X137.488 Y126.059
G1 X132.896 Y121.467 E.12518
G1 X132.763 Y121.333
G1 X132.205 Y121.333
G1 X132.339 Y121.467
G1 X137.345 Y126.473 E.13648
G1 X137.479 Y126.607
G1 X137.336 Y127.021
G1 X137.202 Y126.888
G1 X131.781 Y121.467 E.14777
G1 X131.648 Y121.333
G1 X131.09 Y121.333
G1 X131.224 Y121.467
G1 X137.059 Y127.302 E.15907
G1 X137.193 Y127.436
G1 X137.049 Y127.85
G1 X136.916 Y127.716
G1 X130.666 Y121.467 E.17036
G1 X130.533 Y121.333
G1 X129.975 Y121.333
G1 X130.109 Y121.467
G1 X136.773 Y128.131 E.18166
G1 X136.906 Y128.264
G1 X136.763 Y128.679
G1 X136.629 Y128.545
G1 X129.551 Y121.467 E.19295
G1 X129.417 Y121.333
G1 X128.86 Y121.333
G1 X128.994 Y121.467
G1 X136.486 Y128.959 E.20425
G1 X136.62 Y129.093
G1 X136.477 Y129.507
G1 X136.343 Y129.374
G1 X128.436 Y121.467 E.21554
G1 X128.302 Y121.333
G1 X127.745 Y121.333
G1 X127.878 Y121.467
G1 X132.145 Y125.733 E.1163
G1 X132.278 Y125.867
G1 X131.721 Y125.867
G1 X131.587 Y125.733
G1 X127.321 Y121.467 E.1163
G1 X127.187 Y121.333
G1 X126.63 Y121.333
G1 X126.763 Y121.467
G1 X131.03 Y125.733 E.1163
G1 X131.163 Y125.867
G1 X130.606 Y125.867
G1 X130.472 Y125.733
G1 X126.206 Y121.467 E.1163
G1 X126.072 Y121.333
G1 X125.515 Y121.333
G1 X125.648 Y121.467
G1 X129.915 Y125.733 E.1163
G1 X130.048 Y125.867
G1 X129.491 Y125.867
G1 X129.357 Y125.733
G1 X125.091 Y121.467 E.1163
G1 X124.957 Y121.333
G1 X124.4 Y121.333
G1 X124.533 Y121.467
G1 X128.8 Y125.733 E.1163
G1 X128.933 Y125.867
G1 X128.376 Y125.867
G1 X128.242 Y125.733
G1 X123.976 Y121.467 E.1163
G1 X123.842 Y121.333
G1 X123.284 Y121.333
G1 X123.418 Y121.467
G1 X127.684 Y125.733 E.1163
G1 X127.818 Y125.867
G1 X127.261 Y125.867
G1 X127.127 Y125.733
G1 X122.861 Y121.467 E.1163
G1 X122.727 Y121.333
G1 X122.169 Y121.333
G1 X122.303 Y121.467
G1 X126.569 Y125.733 E.1163
G1 X126.703 Y125.867
G1 X126.146 Y125.867
G1 X126.012 Y125.733
G1 X114.149 Y113.87 E.32338
G1 X114.015 Y113.737
G1 X114.015 Y114.294
G1 X114.149 Y114.428
G1 X125.454 Y125.733 E.30819
G1 X125.588 Y125.867
G1 X125.03 Y125.867
G1 X124.897 Y125.733
G1 X114.603 Y115.44 E.2806
G1 X114.47 Y115.306
G1 X114.777 Y116.17
G1 X114.91 Y116.304
G1 X124.339 Y125.733 E.25704
G1 X124.473 Y125.867
G1 X123.915 Y125.867
G1 X123.782 Y125.733
G1 X115.217 Y117.168 E.23348
G1 X115.083 Y117.035
G1 X115.39 Y117.899
G1 X115.524 Y118.033
G1 X123.507 Y126.016 E.21763
G1 X123.641 Y126.15
G1 X123.919 Y126.985
G1 X123.785 Y126.852
G1 X115.83 Y118.897 E.21684
G1 X115.697 Y118.763
G1 X116.004 Y119.628
G1 X116.137 Y119.761
G1 X124.063 Y127.687 E.21606
G1 X124.197 Y127.821
G1 X124.474 Y128.656
G1 X124.341 Y128.522
G1 X116.444 Y120.626 E.21527
G1 X116.31 Y120.492
G1 X116.617 Y121.356
G1 X116.751 Y121.49
G1 X124.619 Y129.358 E.21448
G1 X124.752 Y129.491
G1 X125.03 Y130.327
G1 X124.896 Y130.193
G1 X117.057 Y122.354 E.21369
G1 X116.924 Y122.22
G1 X117.23 Y123.085
G1 X117.364 Y123.218
G1 X125.174 Y131.028 E.2129
G1 X125.308 Y131.162
G1 X125.586 Y131.997
G1 X125.452 Y131.864
G1 X117.671 Y124.083 E.21212
G1 X117.537 Y123.949
G1 X117.844 Y124.813
G1 X117.978 Y124.947
G1 X125.73 Y132.699 E.21133
G1 X125.864 Y132.833
G1 X126.141 Y133.668
G1 X126.008 Y133.535
G1 X118.284 Y125.811 E.21054
G1 X118.151 Y125.678
G1 X118.457 Y126.542
G1 X118.591 Y126.675
G1 X126.286 Y134.37 E.20975
G1 X126.419 Y134.504
G1 X126.697 Y135.339
G1 X126.563 Y135.205
G1 X118.898 Y127.54 E.20896
G1 X118.764 Y127.406
G1 X119.071 Y128.27
G1 X119.205 Y128.404
G1 X126.841 Y136.041 E.20818
G1 X126.975 Y136.174
G1 X127.253 Y137.01
G1 X127.119 Y136.876
G1 X119.511 Y129.268 E.20739
G1 X119.378 Y129.135
G1 X119.684 Y129.999
G1 X119.818 Y130.133
G1 X127.397 Y137.711 E.2066
; WIPE_START
M204 S4000
G1 X125.983 Y136.297 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.96 Y129.783 Z12.36 F60000
G1 X132.324 Y125.912 Z12.36
G1 Z11.96
G1 E.8 F1800
G1 F9000
M204 S2000
G1 X136.2 Y129.788 E.10566
G1 X136.333 Y129.922
G1 X136.19 Y130.336
G1 X136.057 Y130.203
G1 X132.185 Y126.33 E.10555
G1 X132.051 Y126.197
G1 X131.912 Y126.615
G1 X132.045 Y126.749
G1 X135.913 Y130.617 E.10544
G1 X136.047 Y130.751
G1 X135.904 Y131.165
G1 X135.77 Y131.031
G1 X131.906 Y127.167 E.10533
G1 X131.773 Y127.034
G1 X131.634 Y127.452
G1 X131.767 Y127.586
G1 X135.627 Y131.446 E.10522
G1 X135.761 Y131.579
G1 X135.618 Y131.994
G1 X135.484 Y131.86
G1 X131.628 Y128.004 E.10511
G1 X131.494 Y127.87
G1 X131.355 Y128.289
G1 X131.489 Y128.422
G1 X135.341 Y132.274 E.105
G1 X135.474 Y132.408
G1 X135.331 Y132.822
G1 X135.198 Y132.689
G1 X131.35 Y128.841 E.10489
G1 X131.216 Y128.707
G1 X131.077 Y129.126
G1 X131.211 Y129.259
G1 X135.054 Y133.103 E.10478
G1 X135.188 Y133.237
G1 X135.045 Y133.651
G1 X134.911 Y133.517
G1 X131.071 Y129.678 E.10467
G1 X130.938 Y129.544
G1 X130.799 Y129.962
G1 X130.932 Y130.096
G1 X134.768 Y133.932 E.10456
G1 X134.902 Y134.065
G1 X134.758 Y134.48
G1 X134.625 Y134.346
G1 X130.793 Y130.514 E.10445
G1 X130.66 Y130.381
G1 X130.52 Y130.799
G1 X130.654 Y130.933
G1 X134.482 Y134.761 E.10434
G1 X134.615 Y134.894
G1 X134.472 Y135.309
G1 X134.338 Y135.175
G1 X130.515 Y131.351 E.10423
G1 X130.381 Y131.218
G1 X130.242 Y131.636
G1 X130.376 Y131.77
G1 X134.195 Y135.589 E.10412
G1 X134.329 Y135.723
G1 X134.186 Y136.137
G1 X134.052 Y136.004
G1 X130.237 Y132.188 E.10401
G1 X130.103 Y132.054
G1 X129.964 Y132.473
G1 X130.097 Y132.606
G1 X133.909 Y136.418 E.1039
G1 X134.043 Y136.552
G1 X133.899 Y136.966
G1 X133.766 Y136.832
G1 X129.958 Y133.025 E.10379
G1 X129.825 Y132.891
G1 X129.686 Y133.31
G1 X129.819 Y133.443
G1 X133.623 Y137.247 E.10368
G1 X133.756 Y137.38
G1 X133.613 Y137.795
G1 X133.479 Y137.661
G1 X129.68 Y133.862 E.10357
G1 X129.546 Y133.728
G1 X129.407 Y134.146
G1 X129.541 Y134.28
G1 X133.336 Y138.075 E.10346
G1 X133.47 Y138.209
G1 X133.327 Y138.623
G1 X133.193 Y138.49
G1 X129.402 Y134.698 E.10335
G1 X129.268 Y134.565
G1 X129.129 Y134.983
G1 X129.263 Y135.117
G1 X133.05 Y138.904 E.10324
G1 X133.184 Y139.038
G1 X133.04 Y139.452
G1 X132.907 Y139.318
G1 X129.123 Y135.535 E.10313
G1 X128.99 Y135.402
G1 X128.851 Y135.82
G1 X128.984 Y135.954
G1 X132.764 Y139.733 E.10302
G1 X132.897 Y139.866
G1 X132.754 Y140.281
G1 X132.62 Y140.147
G1 X128.845 Y136.372 E.10291
G1 X128.712 Y136.238
G1 X128.572 Y136.657
G1 X128.706 Y136.79
G1 X132.477 Y140.562 E.1028
G1 X132.611 Y140.695
G1 X132.468 Y141.11
G1 X132.334 Y140.976
G1 X128.567 Y137.209 E.10269
G1 X128.433 Y137.075
G1 X128.294 Y137.494
G1 X128.428 Y137.627
G1 X132.191 Y141.39 E.10258
G1 X132.324 Y141.524
G1 X132.181 Y141.938
G1 X132.048 Y141.805
G1 X128.289 Y138.046 E.10247
G1 X128.155 Y137.912
G1 X127.739 Y138.053
G1 X127.873 Y138.187
M73 P99 R0
G1 X131.904 Y142.219 E.10991
G1 X132.038 Y142.353
G1 X131.895 Y142.767
G1 X131.761 Y142.633
G1 X120.125 Y130.997 E.31721
G1 X119.991 Y130.863
G1 X120.298 Y131.728
G1 X120.432 Y131.861
G1 X131.618 Y143.048 E.30495
G1 X131.752 Y143.181
G1 X131.609 Y143.596
G1 X131.475 Y143.462
G1 X120.738 Y132.725 E.29268
G1 X120.605 Y132.592
G1 X120.911 Y133.456
G1 X121.045 Y133.59
G1 X131.332 Y143.876 E.28042
G1 X131.465 Y144.01
G1 X131.322 Y144.424
G1 X131.189 Y144.291
G1 X121.352 Y134.454 E.26815
G1 X121.218 Y134.32
G1 X121.525 Y135.185
G1 X121.659 Y135.318
G1 X130.847 Y144.507 E.25047
G1 X130.98 Y144.64
G1 X130.423 Y144.64
G1 X130.289 Y144.507
G1 X121.965 Y136.183 E.22691
G1 X121.832 Y136.049
G1 X122.138 Y136.913
G1 X122.272 Y137.047
G1 X129.732 Y144.507 E.20335
G1 X129.865 Y144.64
G1 X129.308 Y144.64
G1 X129.174 Y144.507
G1 X122.579 Y137.911 E.17979
G1 X122.445 Y137.777
G1 X122.752 Y138.642
G1 X122.885 Y138.775
G1 X128.617 Y144.507 E.15623
G1 X128.75 Y144.64
G1 X128.193 Y144.64
G1 X128.059 Y144.507
G1 X123.192 Y139.64 E.13267
G1 X123.059 Y139.506
G1 X123.365 Y140.37
G1 X123.499 Y140.504
G1 X127.502 Y144.507 E.10911
G1 X127.635 Y144.64
G1 X127.078 Y144.64
G1 X126.944 Y144.507
G1 X123.806 Y141.368 E.08555
G1 X123.672 Y141.235
G1 X123.979 Y142.099
G1 X124.112 Y142.233
G1 X126.386 Y144.507 E.06199
G1 X126.52 Y144.64
G1 X125.963 Y144.64
G1 X125.829 Y144.507
G1 X124.419 Y143.097 E.03843
G1 X124.286 Y142.963
G1 X124.592 Y143.827
G1 X124.726 Y143.961
G1 X125.271 Y144.507 E.01487
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9000
M204 S4000
G1 X124.726 Y143.961 E-.29313
G1 X124.592 Y143.827 E-.07182
G1 X124.286 Y142.963 E-.34849
G1 X124.372 Y143.05 E-.04656
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z12.36 I1.217 J0 P1  F60000
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
G1 Z12.36 F900 ; lower z a little
M1002 judge_flag timelapse_record_flag
M622 J1
    G150.3
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S5 ;wait for last picture to be taken
M623  ;end of "timelapse_record_flag"

G90
G1 Z21.96 F900 ; lower z a little

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

    
        G1 Z85.98 F600
        G1 Z83.98
    

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

