-- GeeSkid v1.03

function _G_save_do(parent)



local _G_save_stuff = {}

_G_save_stuff.name={
"_G_auto_flip_veh",
"_G_auto_re_kick",
"_G_auto_veh_rpr",
"_G_Boost_display",
"_G_ff_auto_kick",
"_G_GE_main.feat", 
"_G_GE_main.trcr.feat",
"_G_GE_main.trcr.fade",
"_G_GE_main.trcr.r",
"_G_GE_main.trcr.g",
"_G_GE_main.trcr.b",
"_G_GE_main.trcr.a",
"_G_GE_main.aim.fire_pos",
"_G_GE_main.aim.frwd_foot_offst",
"_G_GE_main.aim.frwd_cam_offst",
"_G_GE_main.aim.veh_pos",
"_G_GE_main.aim.frwd_veh_offst_type",
"_G_GE_main.aim.frwd_veh_smrt",
"_G_GE_main.aim.frwd_veh_offst", 
"_G_GE_main.aim.vert_veh_offst", 
"_G_GE_main.aim.smrt_veh_offst",
"_G_GE_main.aim.mnl_veh_offst",
"_G_GE_main.delay", 
"_G_GE_main.spread",
"_G_GE_main.spread_type", 
"_G_GE_main.blame",
"_G_GE_main.vis", 
"_G_GE_main.aud", 
"_G_GE_main.slct_key1",
"_G_GE_main.flare_feat",
"_G_GE_main.flare_key_slct",
"_G_gee_watch_destroy",
"_G_gee_watch_passenger",
"_G_gee_watch_passenger_npc",
"_G_gee_watch_player_info",
"_G_GeeBoost",
"_G_geeboost_set_keys",
"_G_GeeBoostSelect1",
"_G_GeeBoostSelect2",
"_G_GeeBoostSelect3",
"_G_GeeDrive_boost_tog",
"_G_GeeDrive_insta",
"_G_GeeLook",
"_G_GeeLookFall",
"_G_GeeParaAuto",
"_G_GeeSlowFall",
"_G_GeeSniperStrafe",
"_G_GeeSniperZoom",
"_G_GeeSteer_custom",
"_G_GeeSteer_LC",
"_G_geesteer_set_keys",
"_G_GeeSteerSelect1",
"_G_GeeSteerSelect2",
"_G_GeeSteerSelect3",
"_G_geestop_set_keys",
"_G_GeeStopRvrs",
"_G_GeeStopSelect1",
"_G_GeeStopSelect2",
"_G_GeeStopSelect3",
"_G_GeeSwim",
"_G_GeeWatchAccel_key",
"_G_GeeWatchBoard_key",
"_G_GeeWatchBurn_key",
"_G_GeeWatchDamDes_key",
"_G_GeeWatchDeEleRag_key",
"_G_GeeWatchElev_key",
"_G_GeeWatchExplode_key",
"_G_GeeWatchGod_key",
"_G_GeeWatchKick_key",
"_G_GeeWatchNtr_key",
"_G_GeeWatchRepair_key",
"_G_GeeWatchRvrs_key",
"_G_GeeWatchUpgrade_key",
"_G_incl_npc_veh",
"_G_incl_owned_veh",
"_G_incl_prsnl_veh",
"_G_invncbl_wndows",
"_G_ldrbrd.back_a",
"_G_ldrbrd.feat",
"_G_ldrbrd.show_last",
"_G_ldrbrd.size",
"_G_ldrbrd.sort_by",
"_G_ldrbrd.sort_drctn",
"_G_ldrbrd.text_a",
"_G_ldrbrd.x",
"_G_ldrbrd.y",
"_G_LOS_.back_a",
"_G_LOS_.dist_type",
"_G_LOS_.feat",
"_G_LOS_.size",
"_G_LOS_.sort_by",
"_G_LOS_.sort_drctn",
"_G_LOS_.text_a",
"_G_LOS_.x",
"_G_LOS_.y",
"_G_max_tint",
"_G_mk2_invrtd.boost",
"_G_mk2_invrtd.brakes",
"_G_mk2_invrtd.feat",
"_G_mk2_invrtd.pitch",
"_G_mk2_invrtd.pitch_speed",
"_G_mk2_invrtd.roll",
"_G_mk2_invrtd.roll_speed",
"_G_mk2_invrtd.yaw",
"_G_mk2_invrtd.yaw_speed",
"_G_mods_detex_god_shoot_tog",
"_G_mods_detex_kd_neg_tog",
"_G_mods_detex_kd_tog",
"_G_mods_detex_money_tog",
"_G_mods_detex_otr_tog",
"_G_mods_detex_rank_tog",
"_G_mods_detex_undead_tog",
"_G_never_ped_fire",
"_G_on_plyrs_veh_pos_enforce",
"_G_ped_veh_accel",
"_G_ped_veh_down",
"_G_ped_veh_revers",
"_G_ped_veh_up",
"_G_plyr_excl_friends",
"_G_plyr_excl_modders",
"_G_plyr_excl_orgmc",
"_G_plyr_JL_notif",
"_G_plyr_only_none",
"_G_plyr_only_plyrs",
"_G_plyr_veh_auto_repair",
"_G_plyrs_overlay_main.plyr_list_feat",
"_G_plyrs_overlay_main.plyr_sort_asc_desc",
"_G_plyrs_overlay_main.plyr_sort_column_space",
"_G_plyrs_overlay_main.plyr_sort_column_type",
"_G_plyrs_overlay_main.plyr_sort_font",
"_G_plyrs_overlay_main.plyr_sort_kd",
"_G_plyrs_overlay_main.plyr_sort_max",
"_G_plyrs_overlay_main.plyr_sort_money",
"_G_plyrs_overlay_main.plyr_sort_rank",
"_G_plyrs_overlay_main.plyr_sort_scale",
"_G_plyrs_overlay_main.plyr_sort_self",
"_G_plyrs_overlay_main.plyr_sort_space_hor",
"_G_plyrs_overlay_main.plyr_sort_space_ver",
"_G_plyrs_overlay_main.plyr_sort_speed_above",
"_G_plyrs_overlay_main.plyr_sort_speed_ped",
"_G_plyrs_overlay_main.plyr_sort_speed_type",
"_G_plyrs_overlay_main.plyr_sort_speed_veh",
"_G_plyrs_overlay_main.plyr_sort_tis",
"_G_plyrs_overlay_main.plyr_sort_top",
"_G_plyrs_overlay_main.plyr_sort_veh",
"_G_plyrs_overlay_main.plyr_sort_wanted",
"_G_plyrs_overlay_main.plyr_sort_x",
"_G_plyrs_overlay_main.plyr_sort_y",
"_G_punish_veh.bubl",
"_G_punish_veh.cllsn",
"_G_punish_veh.feat",
"_G_punish_veh.frnds",
"_G_punish_veh.mddrs",
"_G_punish_veh.orgmc",
"_G_punish_veh.plyrs",
"_G_punish_veh.safe",
"_G_rmv_trblnc",
"_G_self_veh_accel",
"_G_self_veh_auto_force",
"_G_self_veh_auto_repair",
"_G_self_veh_auto_setting",
"_G_self_veh_auto_tp",
"_G_self_veh_auto_upgrade",
"_G_self_veh_down",
"_G_self_veh_revers",
"_G_self_veh_tp_into_f",
"_G_self_veh_tp_into_f_delay",
"_G_self_veh_tp_into_f_key",
"_G_self_veh_tp_out_f",
"_G_self_veh_tp_out_f_delay",
"_G_self_veh_tp_out_f_key",
"_G_self_veh_up",
"_G_show_otr_blips",
"_G_show_undead_blips",
"_G_silent_start",
"_G_veh_gun_main.delay",
"_G_veh_gun_main.feat",
"_G_veh_gun_main.safe_zone",
"_G_veh_gun_main.select",
"_G_veh_gun_main.spwn_rng",
"_G_veh_gun_main.type",
"_G_veh_gun_main.veh_speed",
"_G_veh_rapid_fire",
"_G_veh_rapid_fire_khan",
"_G_veh_xtra_jmp",
"_G_vehicle_flier",
"_G_W_B_a",
"_G_W_B_cb",
"_G_W_B_cg",
"_G_W_B_cr",
"_G_W_B_f",
"_G_W_B_god_s",
"_G_W_B_god_x",
"_G_W_B_god_y",
"_G_W_B_s",
"_G_W_B_x",
"_G_W_B_y",
"_G_Watch_display",
"_G_watch_dog",
"_G_waypoint_esp",
"_G_waypoint_esp_dist",
"_GF_veh_spawn_quick_x",
"_GF_veh_spawn_quick_y",
"_GT_aim_protex_main._G_aim_notif",
"_GT_aim_protex_main._G_plyr_aim_a",
"_GT_aim_protex_main._G_plyr_aim_cb",
"_GT_aim_protex_main._G_plyr_aim_cg",
"_GT_aim_protex_main._G_plyr_aim_cr",
"_GT_aim_protex_main._G_plyr_aim_f",
"_GT_aim_protex_main._G_plyr_aim_s",
"_GT_aim_protex_main._G_plyr_aim_spc",
"_GT_aim_protex_main._G_plyr_aim_x",
"_GT_aim_protex_main._G_plyr_aim_y",
"_GT_aim_protex_main._G_plyr_time",
"_GT_clear_stuff.frnds",
"_GT_clear_stuff.obj",
"_GT_clear_stuff.orgmc",
"_GT_clear_stuff.peds",
"_GT_clear_stuff.prsnl",
"_GT_clear_stuff.prvs",
"_GT_clear_stuff.range_feat",
"_GT_clear_stuff.veh",
"_GT_drift_main.cntr_notif_feat",
"_GT_drift_main.feat",
"_GT_drift_main.ovrly_ca",
"_GT_drift_main.ovrly_cb",
"_GT_drift_main.ovrly_cg",
"_GT_drift_main.ovrly_cr",
"_GT_drift_main.ovrly_f",
"_GT_drift_main.ovrly_s",
"_GT_drift_main.ovrly_x",
"_GT_drift_main.ovrly_y",
"_GT_gta_map.all_math_x",
"_GT_gta_map.all_math_y",
"_GT_gta_map.cntr_math_x",
"_GT_gta_map.cntr_math_y",
"_GT_gta_map.cp_cmpnd_math_x",
"_GT_gta_map.cp_cmpnd_math_y",
"_GT_gta_map.cp_math_x",
"_GT_gta_map.cp_math_y",
"_GT_gta_map.cp_mini_math_x",
"_GT_gta_map.cp_mini_math_y",
"_GT_gta_map.full_math_x",
"_GT_gta_map.full_math_y",
"_GT_gta_map.head1_alpha_feat",
"_GT_gta_map.head1_size",
"_GT_gta_map.head2_alpha_feat",
"_GT_gta_map.head2_size",
"_GT_gta_map.hotkey_set_feat",
"_GT_gta_map.hotkey1_select",
"_GT_gta_map.hotkey2_select",
"_GT_gta_map.hotkey3_select",
"_GT_gta_map.map_feat",
"_GT_gta_map.map1_alpha_feat",
"_GT_gta_map.map1_size",
"_GT_gta_map.map1_zoom",
"_GT_gta_map.map2_alpha_feat",
"_GT_gta_map.map2_size",
"_GT_gta_map.map2_zoom",
"_GT_gta_map.othr_math_x",
"_GT_gta_map.othr_math_y",
"_GT_gta_map.plyr1_alpha_feat",
"_GT_gta_map.plyr1_name",
"_GT_gta_map.plyr1_name_size",
"_GT_gta_map.plyr1_size",
"_GT_gta_map.plyr2_alpha_feat",
"_GT_gta_map.plyr2_name",
"_GT_gta_map.plyr2_name_size",
"_GT_gta_map.plyr2_size",
"_GT_gta_map.pos1_x",
"_GT_gta_map.pos1_y",
"_GT_gta_map.pos2_x",
"_GT_gta_map.pos2_y",
"_GT_gta_map.qrtr_math_x",
"_GT_gta_map.qrtr_math_y",
"_GT_gta_map.type1_feat",
"_GT_gta_map.type2_feat",
"_GT_gta_map.z1",
"_GT_gta_map.z2",
"_GT_gw_ntr.ped_hlth",
"_GT_gw_ntr.ped_speed",
"_GT_gw_ntr.ped_weap",
"_GT_gw_ntr.veh_hlth",
"_GT_gw_ntr.veh_speed",
"_GT_gw_ntr.veh_weap",
"_GT_plate.style_tog",
"_GT_plate.tog",
"_GT_plate_anim.delay",
"_GT_plate_anim.plyr.blank",
"_GT_plate_anim.plyr.delay",
"_GT_plate_anim.plyr.dist_type",
"_GT_plate_anim.plyr.show_dist",
"_GT_plate_anim.plyr.space",
"_GT_plate_anim.spdo.dick_lngth",
"_GT_plate_anim.spdo.type",
"_GT_plate_anim.str_scrl.space",
"_GT_plate_anim.str_scrl.spd",
"_GT_plate_anim.str_scrl.update",
"_GT_plate_anim.style_tog",
"_GT_plate_anim.tog",
"_GT_plate_anim.wp.blnk_spd",
"_GT_plate_anim.wp.dist_mtrc",
"_GT_plate_anim.wp.select",
"_GT_sssn_stf.hold.dstry",
"_GT_sssn_stf.hold.dstry_key",
"_GT_sssn_stf.hold.rpr",
"_GT_sssn_stf.hold.rpr_key",
"_GT_sssn_stf.hold.show_in_use",
"_GT_sssn_stf.hold.time",
"_GT_sssn_stf.hold.upgrd",
"_GT_sssn_stf.hold.upgrd_key",
"_GT_sssn_stf.hrn_bst_feat",
"_GT_veh_esp_table.blip_size",
"_GT_veh_esp_table.blip_size_dist",
"_GT_veh_esp_table.dist",
"_GT_veh_esp_table.dist_type",
"_GT_veh_esp_table.feat",
"_GT_veh_esp_table.god_x",
"_GT_veh_esp_table.god_y",
"_GT_veh_esp_table.line_far_a",
"_GT_veh_esp_table.line_far_b",
"_GT_veh_esp_table.line_far_g",
"_GT_veh_esp_table.line_far_r",
"_GT_veh_esp_table.line_feat",
"_GT_veh_esp_table.line_frnd_a",
"_GT_veh_esp_table.line_frnd_b",
"_GT_veh_esp_table.line_frnd_g",
"_GT_veh_esp_table.line_frnd_r",
"_GT_veh_esp_table.line_near_a",
"_GT_veh_esp_table.line_near_b",
"_GT_veh_esp_table.line_near_dist",
"_GT_veh_esp_table.line_near_g",
"_GT_veh_esp_table.line_near_r",
"_GT_veh_esp_table.line_self_a",
"_GT_veh_esp_table.line_self_b",
"_GT_veh_esp_table.line_self_g",
"_GT_veh_esp_table.line_self_r",
"_GT_veh_esp_table.line_show_for",
"_GT_veh_esp_table.show_plyr_name",
"_GT_veh_esp_table.show_veh_crrnt",
"_GT_veh_esp_table.show_veh_dist",
"_GT_veh_esp_table.show_veh_god",
"_GT_veh_esp_table.show_veh_name",
"_GT_veh_esp_table.show_veh_prsnl",
"_GT_veh_esp_table.show_veh_pssngr",
"_GT_veh_esp_table.text_b",
"_GT_veh_esp_table.text_from_top",
"_GT_veh_esp_table.text_g",
"_GT_veh_esp_table.text_jstfctn",
"_GT_veh_esp_table.text_r",
"_GT_veh_esp_table.text_size",
"_GT_veh_esp_table.text_space",
"_GT_veh_esp_table.text_vis",
"_GT_veh_esp_table.text_x",
"_GT_veh_esp_table.text_y",
"_GT_veh_esp_table.vis",
"_GT_veh_info_entry.dmnsns",
"_GT_veh_info_entry.feat",
"_GT_veh_info_entry.god",
"_GT_veh_info_entry.gtaid",
"_GT_veh_info_entry.hash",
"_GT_veh_info_entry.hlth",
"_GT_veh_info_entry.occpnts",
"_GT_veh_info_entry.scnds",
"_GT_veh_info_entry.speed",
"_GT_veh_info_entry.weap",
"_GT_spwn_veh.spwn_in_veh",
"_GT_spwn_veh.spwn_upg",
"_GT_spwn_veh.spwn_f1",
"_GT_spwn_veh.remove_old",
"_GT_spwn_veh.spwn_spd_tq",
"_GT_spwn_veh.spwn_rand_paint",
"_GT_spwn_veh.spwn_cust_paint",
"_GT_spwn_veh.spwn_cust_paint_r",
"_GT_spwn_veh.spwn_cust_paint_g",
"_GT_spwn_veh.spwn_cust_paint_b",
"_GT_spwn_veh.paint_list.pnt_Purewhite",
"_GT_spwn_veh.paint_list.pnt_White",
"_GT_spwn_veh.paint_list.pnt_Cream",
"_GT_spwn_veh.paint_list.pnt_Grey",
"_GT_spwn_veh.paint_list.pnt_Black",
"_GT_spwn_veh.paint_list.pnt_PastelPink",
"_GT_spwn_veh.paint_list.pnt_Pink",
"_GT_spwn_veh.paint_list.pnt_PinkRed",
"_GT_spwn_veh.paint_list.pnt_WineRed",
"_GT_spwn_veh.paint_list.pnt_Red",
"_GT_spwn_veh.paint_list.pnt_BrightRed",
"_GT_spwn_veh.paint_list.pnt_Salmon",
"_GT_spwn_veh.paint_list.pnt_BrightBlue",
"_GT_spwn_veh.paint_list.pnt_LightBlue",
"_GT_spwn_veh.paint_list.pnt_Teal",
"_GT_spwn_veh.paint_list.pnt_RoyalBlue",
"_GT_spwn_veh.paint_list.pnt_CreamYellow",
"_GT_spwn_veh.paint_list.pnt_Yellow",
"_GT_spwn_veh.paint_list.pnt_Mustard",
"_GT_spwn_veh.paint_list.pnt_Brightyellow",
"_GT_spwn_veh.paint_list.pnt_Schoolbus",
"_GT_spwn_veh.paint_list.pnt_DarkOrange",
"_GT_spwn_veh.paint_list.pnt_CreamGreen",
"_GT_spwn_veh.paint_list.pnt_LightGreen",
"_GT_spwn_veh.paint_list.pnt_BrightGreen",
"_GT_spwn_veh.paint_list.pnt_DarkGreen",
"_GT_spwn_veh.paint_list.pnt_CreamPurple",
"_GT_spwn_veh.paint_list.pnt_BrightPurple",
"_GT_spwn_veh.paint_list.pnt_DarkPurple",
"_GT_spwn_veh.neon.choose",
"_GT_spwn_veh.neon.list.White",
"_GT_spwn_veh.neon.list.Blue",
"_GT_spwn_veh.neon.list.ElectricBlue",
"_GT_spwn_veh.neon.list.MintGreen",
"_GT_spwn_veh.neon.list.LimeGreen",
"_GT_spwn_veh.neon.list.Yellow",
"_GT_spwn_veh.neon.list.GoldenShower",
"_GT_spwn_veh.neon.list.Orange",
"_GT_spwn_veh.neon.list.Red",
"_GT_spwn_veh.neon.list.PonyPink",
"_GT_spwn_veh.neon.list.HotPink",
"_GT_spwn_veh.neon.list.Purple",
"_GT_spwn_veh.neon.list.BlackLight",
"_GT_spwn_veh.h_light.choose",
"_GT_spwn_veh.h_light.list.White",
"_GT_spwn_veh.h_light.list.Blue",
"_GT_spwn_veh.h_light.list.ElectricBlue",
"_GT_spwn_veh.h_light.list.MintGreen",
"_GT_spwn_veh.h_light.list.LimeGreen",
"_GT_spwn_veh.h_light.list.Yellow",
"_GT_spwn_veh.h_light.list.GoldenShower",
"_GT_spwn_veh.h_light.list.Orange",
"_GT_spwn_veh.h_light.list.Red",
"_GT_spwn_veh.h_light.list.PonyPink",
"_GT_spwn_veh.h_light.list.HotPink",
"_GT_spwn_veh.h_light.list.Purple",
"_GT_spwn_veh.h_light.list.BlackLight",
"_GT_sssn_stf.new.quick_x",
"_GT_sssn_stf.new.quick_y",
"_GT_sssn_stf.new.spwn_upg",
"_GT_sssn_stf.new.spwn_f1",
"_GT_sssn_stf.new.spwn_spd_tq",
"_GT_sssn_stf.new.spwn_rand_paint",
"_GT_sssn_stf.new.spwn_cust_paint",
"_GT_sssn_stf.new.spwn_cust_paint_r",
"_GT_sssn_stf.new.spwn_cust_paint_g",
"_GT_sssn_stf.new.spwn_cust_paint_b",
"_GT_sssn_stf.new.paint_list.pnt_Purewhite",
"_GT_sssn_stf.new.paint_list.pnt_White",
"_GT_sssn_stf.new.paint_list.pnt_Cream",
"_GT_sssn_stf.new.paint_list.pnt_Grey",
"_GT_sssn_stf.new.paint_list.pnt_Black",
"_GT_sssn_stf.new.paint_list.pnt_PastelPink",
"_GT_sssn_stf.new.paint_list.pnt_Pink",
"_GT_sssn_stf.new.paint_list.pnt_PinkRed",
"_GT_sssn_stf.new.paint_list.pnt_WineRed",
"_GT_sssn_stf.new.paint_list.pnt_Red",
"_GT_sssn_stf.new.paint_list.pnt_BrightRed",
"_GT_sssn_stf.new.paint_list.pnt_Salmon",
"_GT_sssn_stf.new.paint_list.pnt_BrightBlue",
"_GT_sssn_stf.new.paint_list.pnt_LightBlue",
"_GT_sssn_stf.new.paint_list.pnt_Teal",
"_GT_sssn_stf.new.paint_list.pnt_RoyalBlue",
"_GT_sssn_stf.new.paint_list.pnt_CreamYellow",
"_GT_sssn_stf.new.paint_list.pnt_Yellow",
"_GT_sssn_stf.new.paint_list.pnt_Mustard",
"_GT_sssn_stf.new.paint_list.pnt_Brightyellow",
"_GT_sssn_stf.new.paint_list.pnt_Schoolbus",
"_GT_sssn_stf.new.paint_list.pnt_DarkOrange",
"_GT_sssn_stf.new.paint_list.pnt_CreamGreen",
"_GT_sssn_stf.new.paint_list.pnt_LightGreen",
"_GT_sssn_stf.new.paint_list.pnt_BrightGreen",
"_GT_sssn_stf.new.paint_list.pnt_DarkGreen",
"_GT_sssn_stf.new.paint_list.pnt_CreamPurple",
"_GT_sssn_stf.new.paint_list.pnt_BrightPurple",
"_GT_sssn_stf.new.paint_list.pnt_DarkPurple",
"_GT_sssn_stf.new.neon.choose",
"_GT_sssn_stf.new.neon.list.White",
"_GT_sssn_stf.new.neon.list.Blue",
"_GT_sssn_stf.new.neon.list.ElectricBlue",
"_GT_sssn_stf.new.neon.list.MintGreen",
"_GT_sssn_stf.new.neon.list.LimeGreen",
"_GT_sssn_stf.new.neon.list.Yellow",
"_GT_sssn_stf.new.neon.list.GoldenShower",
"_GT_sssn_stf.new.neon.list.Orange",
"_GT_sssn_stf.new.neon.list.Red",
"_GT_sssn_stf.new.neon.list.PonyPink",
"_GT_sssn_stf.new.neon.list.HotPink",
"_GT_sssn_stf.new.neon.list.Purple",
"_GT_sssn_stf.new.neon.list.BlackLight",
"_GT_sssn_stf.new.h_light.choose",
"_GT_sssn_stf.new.h_light.list.White",
"_GT_sssn_stf.new.h_light.list.Blue",
"_GT_sssn_stf.new.h_light.list.ElectricBlue",
"_GT_sssn_stf.new.h_light.list.MintGreen",
"_GT_sssn_stf.new.h_light.list.LimeGreen",
"_GT_sssn_stf.new.h_light.list.Yellow",
"_GT_sssn_stf.new.h_light.list.GoldenShower",
"_GT_sssn_stf.new.h_light.list.Orange",
"_GT_sssn_stf.new.h_light.list.Red",
"_GT_sssn_stf.new.h_light.list.PonyPink",
"_GT_sssn_stf.new.h_light.list.HotPink",
"_GT_sssn_stf.new.h_light.list.Purple",
"_GT_sssn_stf.new.h_light.list.BlackLight",
"_GT_spwn_veh.spwn_god",
"_GT_sssn_stf.new.spwn_god",
"_GT_sssn_stf.new.max_tint",
"_GT_spwn_veh.spwn_max_tint",
"_GT_spwn_veh.spwn_invcn_wind",
"_GT_sssn_stf.new.invcn_wind",
"_GT_spwn_veh.spwn_plate_i",
"_GT_spwn_veh.spwn_plate",
"_GT_sssn_stf.new.plate_i",
"_GT_sssn_stf.new.plate",
"_GT_spwn_veh.spwn_front",
"_GT_rtcl.feat", 
"_GT_rtcl.slct", 
"_GT_rtcl.size", 
"_GT_rtcl.rtcl_slct", 
"_GT_rtcl.rtcl_react", 
"_GT_rtcl.no_ent_r", 
"_GT_rtcl.no_ent_g", 
"_GT_rtcl.no_ent_b", 
"_GT_rtcl.no_ent_a", 
"_GT_rtcl.ent_r", 
"_GT_rtcl.ent_g", 
"_GT_rtcl.ent_b", 
"_GT_rtcl.ent_a", 
"_GT_RADAR.feat",
"_GT_RADAR.range", 
"_GT_RADAR.r_size", 
"_GT_RADAR.x", 
"_GT_RADAR.y", 
"_GT_RADAR.rings_show", 
"_GT_RADAR.rings_opp_color", 
"_GT_RADAR.r_r", 
"_GT_RADAR.r_g",
"_GT_RADAR.r_b",
"_GT_RADAR.r_a",
"_GT_RADAR.r", 
"_GT_RADAR.g",
"_GT_RADAR.b",
"_GT_RADAR.a",
"_GT_RADAR.p_size",
"_GT_RADAR.self",
"_GT_RADAR.s_a",
"_GT_RADAR.f_a",
"_GT_RADAR.o_a",
"_GT_RADAR.csa_show",
"_GT_RADAR.csa_r",
"_GT_RADAR.csa_g",
"_GT_RADAR.csa_b",
"_GT_RADAR.csa_a",
"_GT_RADAR.nice_show",
"_GT_RADAR.nice_r",
"_GT_RADAR.nice_g",
"_GT_RADAR.nice_b",
"_GT_RADAR.nice_a",
"_GT_RADAR.mssn_show",
"_GT_RADAR.mssn_r",
"_GT_RADAR.mssn_g",
"_GT_RADAR.mssn_b",
"_GT_RADAR.mssn_a",
"_GT_RADAR.anml_show",
"_GT_RADAR.anml_r",
"_GT_RADAR.anml_g",
"_GT_RADAR.anml_b",
"_GT_RADAR.anml_a",
"_GT_RADAR.xT",
"_GT_RADAR.yT",
"_GT_RADAR.name",
"_GT_RADAR.name_s",
"_GT_RADAR.name_x",
"_GT_RADAR.name_y",
"_GT_RADAR.wp_size",
"_GT_RADAR.wp_a",
"_GT_RADAR.name_j",
"_G_gee_eye_bypass",
}

_G_save_stuff.feat={
["_G_auto_flip_veh"]=_G_auto_flip_veh,
["_G_auto_re_kick"]=_G_auto_re_kick,
["_G_auto_veh_rpr"]=_G_auto_veh_rpr,
["_G_Boost_display"]=_G_Boost_display,
["_G_ff_auto_kick"]=_G_ff_auto_kick,
["_G_GE_main.feat"]=_G_GE_main.feat,
["_G_GE_main.trcr.feat"]=_G_GE_main.trcr.feat,
["_G_GE_main.trcr.fade"]=_G_GE_main.trcr.fade,
["_G_GE_main.trcr.r"]=_G_GE_main.trcr.r,
["_G_GE_main.trcr.g"]=_G_GE_main.trcr.g,
["_G_GE_main.trcr.b"]=_G_GE_main.trcr.b,
["_G_GE_main.trcr.a"]=_G_GE_main.trcr.a,
["_G_GE_main.aim.fire_pos"]=_G_GE_main.aim.fire_pos,
["_G_GE_main.aim.frwd_foot_offst"]=_G_GE_main.aim.frwd_foot_offst,
["_G_GE_main.aim.frwd_cam_offst"]=_G_GE_main.aim.frwd_cam_offst,
["_G_GE_main.aim.veh_pos"]=_G_GE_main.aim.veh_pos,
["_G_GE_main.aim.frwd_veh_offst_type"]=_G_GE_main.aim.frwd_veh_offst_type,
["_G_GE_main.aim.frwd_veh_smrt"]=_G_GE_main.aim.frwd_veh_smrt,
["_G_GE_main.aim.frwd_veh_offst"]=_G_GE_main.aim.frwd_veh_offst,
["_G_GE_main.aim.vert_veh_offst"]=_G_GE_main.aim.vert_veh_offst,
["_G_GE_main.aim.smrt_veh_offst"]=_G_GE_main.aim.smrt_veh_offst,
["_G_GE_main.aim.mnl_veh_offst"]=_G_GE_main.aim.mnl_veh_offst,
["_G_GE_main.delay"]=_G_GE_main.delay,
["_G_GE_main.spread"]=_G_GE_main.spread,
["_G_GE_main.spread_type"]=_G_GE_main.spread_type,
["_G_GE_main.blame"]=_G_GE_main.blame,
["_G_GE_main.vis"]=_G_GE_main.vis,
["_G_GE_main.aud"]=_G_GE_main.aud,
["_G_GE_main.slct_key1"]=_G_GE_main.slct_key1,
["_G_GE_main.flare_feat"]=_G_GE_main.flare_feat,
["_G_GE_main.flare_key_slct"]=_G_GE_main.flare_key_slct,
["_G_gee_watch_destroy"]=_G_gee_watch_destroy,
["_G_gee_watch_passenger"]=_G_gee_watch_passenger,
["_G_gee_watch_passenger_npc"]=_G_gee_watch_passenger_npc,
["_G_gee_watch_player_info"]=_G_gee_watch_player_info,
["_G_GeeBoost"]=_G_GeeBoost,
["_G_geeboost_set_keys"]=_G_geeboost_set_keys,
["_G_GeeBoostSelect1"]=_G_GeeBoostSelect1,
["_G_GeeBoostSelect2"]=_G_GeeBoostSelect2,
["_G_GeeBoostSelect3"]=_G_GeeBoostSelect3,
["_G_GeeDrive_boost_tog"]=_G_GeeDrive_boost_tog,
["_G_GeeDrive_insta"]=_G_GeeDrive_insta,
["_G_GeeLook"]=_G_GeeLook,
["_G_GeeLookFall"]=_G_GeeLookFall,
["_G_GeeParaAuto"]=_G_GeeParaAuto,
["_G_GeeSlowFall"]=_G_GeeSlowFall,
["_G_GeeSniperStrafe"]=_G_GeeSniperStrafe,
["_G_GeeSniperZoom"]= _G_GeeSniperZoom,
["_G_GeeSteer_custom"]=_G_GeeSteer_custom,
["_G_GeeSteer_LC"]=_G_GeeSteer_LC,
["_G_geesteer_set_keys"]=_G_geesteer_set_keys,
["_G_GeeSteerSelect1"]=_G_GeeSteerSelect1,
["_G_GeeSteerSelect2"]=_G_GeeSteerSelect2,
["_G_GeeSteerSelect3"]=_G_GeeSteerSelect3,
["_G_geestop_set_keys"]=_G_geestop_set_keys,
["_G_GeeStopRvrs"]=_G_GeeStopRvrs,
["_G_GeeStopSelect1"]=_G_GeeStopSelect1,
["_G_GeeStopSelect2"]=_G_GeeStopSelect2,
["_G_GeeStopSelect3"]=_G_GeeStopSelect3,
["_G_GeeSwim"]=_G_GeeSwim,
["_G_GeeWatchAccel_key"]=_G_GeeWatchAccel_key,
["_G_GeeWatchBoard_key"]=_G_GeeWatchBoard_key,
["_G_GeeWatchBurn_key"]=_G_GeeWatchBurn_key,
["_G_GeeWatchDamDes_key"]=_G_GeeWatchDamDes_key,
["_G_GeeWatchDeEleRag_key"]=_G_GeeWatchDeEleRag_key,
["_G_GeeWatchElev_key"]=_G_GeeWatchElev_key,
["_G_GeeWatchExplode_key"]=_G_GeeWatchExplode_key,
["_G_GeeWatchGod_key"]=_G_GeeWatchGod_key,
["_G_GeeWatchKick_key"]=_G_GeeWatchKick_key,
["_G_GeeWatchNtr_key"]=_G_GeeWatchNtr_key,
["_G_GeeWatchRepair_key"]=_G_GeeWatchRepair_key,
["_G_GeeWatchRvrs_key"]=_G_GeeWatchRvrs_key,
["_G_GeeWatchUpgrade_key"]=_G_GeeWatchUpgrade_key,
["_G_incl_npc_veh"]=_G_incl_npc_veh,
["_G_incl_owned_veh"]=_G_incl_owned_veh,
["_G_incl_prsnl_veh"]=_G_incl_prsnl_veh,
["_G_invncbl_wndows"]=_G_invncbl_wndows,
["_G_ldrbrd.back_a"]=_G_ldrbrd.back_a,
["_G_ldrbrd.feat"]=_G_ldrbrd.feat,
["_G_ldrbrd.show_last"]=_G_ldrbrd.show_last,
["_G_ldrbrd.size"]=_G_ldrbrd.size,
["_G_ldrbrd.sort_by"]=_G_ldrbrd.sort_by,
["_G_ldrbrd.sort_drctn"]=_G_ldrbrd.sort_drctn,
["_G_ldrbrd.text_a"]=_G_ldrbrd.text_a,
["_G_ldrbrd.x"]=_G_ldrbrd.x,
["_G_ldrbrd.y"]=_G_ldrbrd.y,
["_G_LOS_.back_a"]=_G_LOS_.back_a,
["_G_LOS_.dist_type"]=_G_LOS_.dist_type,
["_G_LOS_.feat"]=_G_LOS_.feat,
["_G_LOS_.size"]=_G_LOS_.size,
["_G_LOS_.sort_by"]=_G_LOS_.sort_by,
["_G_LOS_.sort_drctn"]=_G_LOS_.sort_drctn,
["_G_LOS_.text_a"]=_G_LOS_.text_a,
["_G_LOS_.x"]=_G_LOS_.x,
["_G_LOS_.y"]=_G_LOS_.y,
["_G_max_tint"]=_G_max_tint,
["_G_mk2_invrtd.boost"]=_G_mk2_invrtd.boost,
["_G_mk2_invrtd.brakes"]=_G_mk2_invrtd.brakes,
["_G_mk2_invrtd.feat"]=_G_mk2_invrtd.feat,
["_G_mk2_invrtd.pitch"]=_G_mk2_invrtd.pitch,
["_G_mk2_invrtd.pitch_speed"]=_G_mk2_invrtd.pitch_speed,
["_G_mk2_invrtd.roll"]=_G_mk2_invrtd.roll,
["_G_mk2_invrtd.roll_speed"]=_G_mk2_invrtd.roll_speed,
["_G_mk2_invrtd.yaw"]=_G_mk2_invrtd.yaw,
["_G_mk2_invrtd.yaw_speed"]=_G_mk2_invrtd.yaw_speed,
["_G_mods_detex_god_shoot_tog"]= _G_mods_detex_god_shoot_tog,
["_G_mods_detex_kd_neg_tog"]= _G_mods_detex_kd_neg_tog,
["_G_mods_detex_kd_tog"]= _G_mods_detex_kd_tog,
["_G_mods_detex_money_tog"]= _G_mods_detex_money_tog,
["_G_mods_detex_otr_tog"]= _G_mods_detex_otr_tog,
["_G_mods_detex_rank_tog"]= _G_mods_detex_rank_tog,
["_G_mods_detex_undead_tog"]= _G_mods_detex_undead_tog,
["_G_never_ped_fire"]=_G_never_ped_fire,
["_G_on_plyrs_veh_pos_enforce"]=_G_on_plyrs_veh_pos_enforce,
["_G_ped_veh_accel"]=_G_ped_veh_accel,
["_G_ped_veh_down"]=_G_ped_veh_down,
["_G_ped_veh_revers"]=_G_ped_veh_revers,
["_G_ped_veh_up"]=_G_ped_veh_up,
["_G_plyr_excl_friends"]=_G_plyr_excl_friends,
["_G_plyr_excl_modders"]=_G_plyr_excl_modders,
["_G_plyr_excl_orgmc"]=_G_plyr_excl_orgmc,
["_G_plyr_JL_notif"]= _G_plyr_JL_notif,
["_G_plyr_only_none"]=_G_plyr_only_none,
["_G_plyr_only_plyrs"]=_G_plyr_only_plyrs,
["_G_plyr_veh_auto_repair"]=_G_plyr_veh_auto_repair,
["_G_plyrs_overlay_main.plyr_list_feat"]=_G_plyrs_overlay_main.plyr_list_feat,
["_G_plyrs_overlay_main.plyr_sort_asc_desc"]=_G_plyrs_overlay_main.plyr_sort_asc_desc,
["_G_plyrs_overlay_main.plyr_sort_column_space"]= _G_plyrs_overlay_main.plyr_sort_column_space,
["_G_plyrs_overlay_main.plyr_sort_column_type"]= _G_plyrs_overlay_main.plyr_sort_column_type,
["_G_plyrs_overlay_main.plyr_sort_font"]=_G_plyrs_overlay_main.plyr_sort_font,
["_G_plyrs_overlay_main.plyr_sort_kd"]=_G_plyrs_overlay_main.plyr_sort_kd,
["_G_plyrs_overlay_main.plyr_sort_max"]=_G_plyrs_overlay_main.plyr_sort_max,
["_G_plyrs_overlay_main.plyr_sort_money"]=_G_plyrs_overlay_main.plyr_sort_money,
["_G_plyrs_overlay_main.plyr_sort_rank"]=_G_plyrs_overlay_main.plyr_sort_rank,
["_G_plyrs_overlay_main.plyr_sort_scale"]=_G_plyrs_overlay_main.plyr_sort_scale,
["_G_plyrs_overlay_main.plyr_sort_self"]=_G_plyrs_overlay_main.plyr_sort_self,
["_G_plyrs_overlay_main.plyr_sort_space_hor"]=_G_plyrs_overlay_main.plyr_sort_space_hor,
["_G_plyrs_overlay_main.plyr_sort_space_ver"]=_G_plyrs_overlay_main.plyr_sort_space_ver,
["_G_plyrs_overlay_main.plyr_sort_speed_above"]=_G_plyrs_overlay_main.plyr_sort_speed_above,
["_G_plyrs_overlay_main.plyr_sort_speed_ped"]=_G_plyrs_overlay_main.plyr_sort_speed_ped,
["_G_plyrs_overlay_main.plyr_sort_speed_type"]=_G_plyrs_overlay_main.plyr_sort_speed_type,
["_G_plyrs_overlay_main.plyr_sort_speed_veh"]=_G_plyrs_overlay_main.plyr_sort_speed_veh,
["_G_plyrs_overlay_main.plyr_sort_tis"]=  _G_plyrs_overlay_main.plyr_sort_tis,
["_G_plyrs_overlay_main.plyr_sort_top"]=_G_plyrs_overlay_main.plyr_sort_top,
["_G_plyrs_overlay_main.plyr_sort_veh"]=_G_plyrs_overlay_main.plyr_sort_veh,
["_G_plyrs_overlay_main.plyr_sort_wanted"]=_G_plyrs_overlay_main.plyr_sort_wanted,
["_G_plyrs_overlay_main.plyr_sort_x"]=_G_plyrs_overlay_main.plyr_sort_x,
["_G_plyrs_overlay_main.plyr_sort_y"]=_G_plyrs_overlay_main.plyr_sort_y,
["_G_punish_veh.bubl"]=_G_punish_veh.bubl,
["_G_punish_veh.cllsn"]=_G_punish_veh.cllsn,
["_G_punish_veh.feat"]=_G_punish_veh.feat,
["_G_punish_veh.frnds"]=_G_punish_veh.frnds,
["_G_punish_veh.mddrs"]=_G_punish_veh.mddrs,
["_G_punish_veh.orgmc"]=_G_punish_veh.orgmc,
["_G_punish_veh.plyrs"]=_G_punish_veh.plyrs,
["_G_punish_veh.safe"]=_G_punish_veh.safe,
["_G_rmv_trblnc"]=_G_rmv_trblnc,
["_G_self_veh_accel"]=_G_self_veh_accel,
["_G_self_veh_auto_force"]=_G_self_veh_auto_force,
["_G_self_veh_auto_repair"]=_G_self_veh_auto_repair,
["_G_self_veh_auto_setting"]=_G_self_veh_auto_setting,
["_G_self_veh_auto_tp"]=_G_self_veh_auto_tp,
["_G_self_veh_auto_upgrade"]=_G_self_veh_auto_upgrade,
["_G_self_veh_down"]=_G_self_veh_down,
["_G_self_veh_revers"]=_G_self_veh_revers,
["_G_self_veh_tp_into_f"]=_G_self_veh_tp_into_f,
["_G_self_veh_tp_into_f_delay"]=_G_self_veh_tp_into_f_delay,
["_G_self_veh_tp_into_f_key"]=_G_self_veh_tp_into_f_key,
["_G_self_veh_tp_out_f"]=_G_self_veh_tp_out_f,
["_G_self_veh_tp_out_f_delay"]=_G_self_veh_tp_out_f_delay,
["_G_self_veh_tp_out_f_key"]=_G_self_veh_tp_out_f_key,
["_G_self_veh_up"]=_G_self_veh_up,
["_G_show_otr_blips"]=_G_show_otr_blips,
["_G_show_undead_blips"]=_G_show_undead_blips,
["_G_silent_start"]=_G_silent_start,
["_G_veh_gun_main.delay"]=_G_veh_gun_main.delay,
["_G_veh_gun_main.feat"]=_G_veh_gun_main.feat,
["_G_veh_gun_main.safe_zone"]=_G_veh_gun_main.safe_zone,
["_G_veh_gun_main.select"]=_G_veh_gun_main.select,
["_G_veh_gun_main.spwn_rng"]=_G_veh_gun_main.spwn_rng,
["_G_veh_gun_main.type"]=_G_veh_gun_main.type,
["_G_veh_gun_main.veh_speed"]=_G_veh_gun_main.veh_speed,
["_G_veh_rapid_fire"]=_G_veh_rapid_fire,
["_G_veh_rapid_fire_khan"]=_G_veh_rapid_fire,
["_G_veh_xtra_jmp"]=_G_veh_xtra_jmp,
["_G_vehicle_flier"]=_G_vehicle_flier,
["_G_W_B_a"]=_G_W_B_a,
["_G_W_B_cb"]=_G_W_B_cb,
["_G_W_B_cg"]=_G_W_B_cg,
["_G_W_B_cr"]=_G_W_B_cr,
["_G_W_B_f"]=_G_W_B_f,
["_G_W_B_god_s"]=_G_W_B_god_s,
["_G_W_B_god_x"]=_G_W_B_god_x,
["_G_W_B_god_y"]=_G_W_B_god_y,
["_G_W_B_s"]=_G_W_B_s,
["_G_W_B_x"]=_G_W_B_x,
["_G_W_B_y"]=_G_W_B_y,
["_G_Watch_display"]=_G_Watch_display,
["_G_watch_dog"]=_G_watch_dog,
["_G_waypoint_esp"]= _G_waypoint_esp,
["_G_waypoint_esp_dist"]=  _G_waypoint_esp_dist,
["_GF_veh_spawn_quick_x"]= _GF_veh_spawn_quick_x,
["_GF_veh_spawn_quick_y"]= _GF_veh_spawn_quick_y,
["_GT_aim_protex_main._G_aim_notif"]=_GT_aim_protex_main._G_aim_notif,
["_GT_aim_protex_main._G_plyr_aim_a"]=_GT_aim_protex_main._G_plyr_aim_a,
["_GT_aim_protex_main._G_plyr_aim_cb"]=_GT_aim_protex_main._G_plyr_aim_cb,
["_GT_aim_protex_main._G_plyr_aim_cg"]=_GT_aim_protex_main._G_plyr_aim_cg,
["_GT_aim_protex_main._G_plyr_aim_cr"]=_GT_aim_protex_main._G_plyr_aim_cr,
["_GT_aim_protex_main._G_plyr_aim_f"]=_GT_aim_protex_main._G_plyr_aim_f,
["_GT_aim_protex_main._G_plyr_aim_s"]=_GT_aim_protex_main._G_plyr_aim_s,
["_GT_aim_protex_main._G_plyr_aim_spc"]=_GT_aim_protex_main._G_plyr_aim_spc,
["_GT_aim_protex_main._G_plyr_aim_x"]=_GT_aim_protex_main._G_plyr_aim_x,
["_GT_aim_protex_main._G_plyr_aim_y"]=_GT_aim_protex_main._G_plyr_aim_y,
["_GT_aim_protex_main._G_plyr_time"]=_GT_aim_protex_main._G_plyr_time,
["_GT_clear_stuff.frnds"]=_GT_clear_stuff.frnds,
["_GT_clear_stuff.obj"]=_GT_clear_stuff.obj,
["_GT_clear_stuff.orgmc"]=_GT_clear_stuff.orgmc,
["_GT_clear_stuff.peds"]=_GT_clear_stuff.peds,
["_GT_clear_stuff.prsnl"]=_GT_clear_stuff.prsnl,
["_GT_clear_stuff.prvs"]=_GT_clear_stuff.prvs,
["_GT_clear_stuff.range_feat"]=_GT_clear_stuff.range_feat,
["_GT_clear_stuff.veh"]=_GT_clear_stuff.veh,
["_GT_drift_main.cntr_notif_feat"]=_GT_drift_main.cntr_notif_feat,
["_GT_drift_main.feat"]=_GT_drift_main.feat,
["_GT_drift_main.ovrly_ca"]=_GT_drift_main.ovrly_ca,
["_GT_drift_main.ovrly_cb"]=_GT_drift_main.ovrly_cb,
["_GT_drift_main.ovrly_cg"]=_GT_drift_main.ovrly_cg,
["_GT_drift_main.ovrly_cr"]=_GT_drift_main.ovrly_cr,
["_GT_drift_main.ovrly_f"]=_GT_drift_main.ovrly_f,
["_GT_drift_main.ovrly_s"]=_GT_drift_main.ovrly_s,
["_GT_drift_main.ovrly_x"]=_GT_drift_main.ovrly_x,
["_GT_drift_main.ovrly_y"]=_GT_drift_main.ovrly_y,
["_GT_gta_map.all_math_x"]=_GT_gta_map.all_math_x,
["_GT_gta_map.all_math_y"]=_GT_gta_map.all_math_y,
["_GT_gta_map.cntr_math_x"]=_GT_gta_map.cntr_math_x,
["_GT_gta_map.cntr_math_y"]=_GT_gta_map.cntr_math_y,
["_GT_gta_map.cp_cmpnd_math_x"]=_GT_gta_map.cp_cmpnd_math_x,
["_GT_gta_map.cp_cmpnd_math_y"]=_GT_gta_map.cp_cmpnd_math_y,
["_GT_gta_map.cp_math_x"]=_GT_gta_map.cp_math_x,
["_GT_gta_map.cp_math_y"]=_GT_gta_map.cp_math_y,
["_GT_gta_map.cp_mini_math_x"]=_GT_gta_map.cp_mini_math_x,
["_GT_gta_map.cp_mini_math_y"]=_GT_gta_map.cp_mini_math_y,
["_GT_gta_map.full_math_x"]=_GT_gta_map.full_math_x,
["_GT_gta_map.full_math_y"]=_GT_gta_map.full_math_y,
["_GT_gta_map.head1_alpha_feat"]=_GT_gta_map.head1_alpha_feat,
["_GT_gta_map.head1_size"]=_GT_gta_map.head1_size,
["_GT_gta_map.head2_alpha_feat"]=_GT_gta_map.head2_alpha_feat,
["_GT_gta_map.head2_size"]=_GT_gta_map.head2_size,
["_GT_gta_map.hotkey_set_feat"]= _GT_gta_map.hotkey_set_feat,
["_GT_gta_map.hotkey1_select"]= _GT_gta_map.hotkey1_select,
["_GT_gta_map.hotkey2_select"]= _GT_gta_map.hotkey2_select,
["_GT_gta_map.hotkey3_select"]= _GT_gta_map.hotkey3_select,
["_GT_gta_map.map_feat"]= _GT_gta_map.map_feat,
["_GT_gta_map.map1_alpha_feat"]= _GT_gta_map.map1_alpha_feat,
["_GT_gta_map.map1_size"]= _GT_gta_map.map1_size,
["_GT_gta_map.map1_zoom"]=_GT_gta_map.map1_zoom,
["_GT_gta_map.map2_alpha_feat"]= _GT_gta_map.map2_alpha_feat,
["_GT_gta_map.map2_size"]= _GT_gta_map.map2_size,
["_GT_gta_map.map2_zoom"]=_GT_gta_map.map2_zoom,
["_GT_gta_map.othr_math_x"]=_GT_gta_map.othr_math_x,
["_GT_gta_map.othr_math_y"]=_GT_gta_map.othr_math_y,
["_GT_gta_map.plyr1_alpha_feat"]= _GT_gta_map.plyr1_alpha_feat,
["_GT_gta_map.plyr1_name"]= _GT_gta_map.plyr1_name,
["_GT_gta_map.plyr1_name_size"]= _GT_gta_map.plyr1_name_size,
["_GT_gta_map.plyr1_size"]= _GT_gta_map.plyr1_size,
["_GT_gta_map.plyr2_alpha_feat"]= _GT_gta_map.plyr2_alpha_feat,
["_GT_gta_map.plyr2_name"]= _GT_gta_map.plyr2_name,
["_GT_gta_map.plyr2_name_size"]= _GT_gta_map.plyr2_name_size,
["_GT_gta_map.plyr2_size"]= _GT_gta_map.plyr2_size,
["_GT_gta_map.pos1_x"]= _GT_gta_map.pos1_x,
["_GT_gta_map.pos1_y"]= _GT_gta_map.pos1_y,
["_GT_gta_map.pos2_x"]= _GT_gta_map.pos2_x,
["_GT_gta_map.pos2_y"]= _GT_gta_map.pos2_y,
["_GT_gta_map.qrtr_math_x"]=_GT_gta_map.qrtr_math_x,
["_GT_gta_map.qrtr_math_y"]=_GT_gta_map.qrtr_math_y,
["_GT_gta_map.type1_feat"]= _GT_gta_map.type1_feat,
["_GT_gta_map.type2_feat"]= _GT_gta_map.type2_feat,
["_GT_gta_map.z1"]=_GT_gta_map.z1,
["_GT_gta_map.z2"]=_GT_gta_map.z2,
["_GT_gw_ntr.ped_hlth"]=_GT_gw_ntr.ped_hlth,
["_GT_gw_ntr.ped_speed"]=_GT_gw_ntr.ped_speed,
["_GT_gw_ntr.ped_weap"]=_GT_gw_ntr.ped_weap,
["_GT_gw_ntr.veh_hlth"]=_GT_gw_ntr.veh_hlth,
["_GT_gw_ntr.veh_speed"]=_GT_gw_ntr.veh_speed,
["_GT_gw_ntr.veh_weap"]=_GT_gw_ntr.veh_weap,
["_GT_plate.style_tog"]=_GT_plate.style_tog,
["_GT_plate.tog"]=_GT_plate.tog,
["_GT_plate_anim.delay"]=_GT_plate_anim.delay,
["_GT_plate_anim.plyr.blank"]=_GT_plate_anim.plyr.blank,
["_GT_plate_anim.plyr.delay"]=_GT_plate_anim.plyr.delay,
["_GT_plate_anim.plyr.dist_type"]=_GT_plate_anim.plyr.dist_type,
["_GT_plate_anim.plyr.show_dist"]=_GT_plate_anim.plyr.show_dist,
["_GT_plate_anim.plyr.space"]=_GT_plate_anim.plyr.space,
["_GT_plate_anim.spdo.dick_lngth"]=_GT_plate_anim.spdo.dick_lngth,
["_GT_plate_anim.spdo.type"]=_GT_plate_anim.spdo.type,
["_GT_plate_anim.str_scrl.space"]=_GT_plate_anim.str_scrl.space,
["_GT_plate_anim.str_scrl.spd"]=_GT_plate_anim.str_scrl.spd,
["_GT_plate_anim.str_scrl.update"]=_GT_plate_anim.str_scrl.update,
["_GT_plate_anim.style_tog"]=_GT_plate_anim.style_tog,
["_GT_plate_anim.tog"]=_GT_plate_anim.tog,
["_GT_plate_anim.wp.blnk_spd"]=_GT_plate_anim.wp.blnk_spd,
["_GT_plate_anim.wp.dist_mtrc"]=_GT_plate_anim.wp.dist_mtrc,
["_GT_plate_anim.wp.select"]=_GT_plate_anim.wp.select,
["_GT_sssn_stf.hold.dstry"]=_GT_sssn_stf.hold.dstry,
["_GT_sssn_stf.hold.dstry_key"]=_GT_sssn_stf.hold.dstry_key,
["_GT_sssn_stf.hold.rpr"]=_GT_sssn_stf.hold.rpr,
["_GT_sssn_stf.hold.rpr_key"]=_GT_sssn_stf.hold.rpr_key,
["_GT_sssn_stf.hold.show_in_use"]=_GT_sssn_stf.hold.show_in_use,
["_GT_sssn_stf.hold.time"]=_GT_sssn_stf.hold.time,
["_GT_sssn_stf.hold.upgrd"]=_GT_sssn_stf.hold.upgrd,
["_GT_sssn_stf.hold.upgrd_key"]=_GT_sssn_stf.hold.upgrd_key,
["_GT_sssn_stf.hrn_bst_feat"]=_GT_sssn_stf.hrn_bst_feat,
["_GT_veh_esp_table.blip_size"]=_GT_veh_esp_table.blip_size,
["_GT_veh_esp_table.blip_size_dist"]=_GT_veh_esp_table.blip_size_dist,
["_GT_veh_esp_table.dist"]=_GT_veh_esp_table.dist,
["_GT_veh_esp_table.dist_type"]=_GT_veh_esp_table.dist_type,
["_GT_veh_esp_table.feat"]=_GT_veh_esp_table.feat,
["_GT_veh_esp_table.god_x"]=_GT_veh_esp_table.god_x,
["_GT_veh_esp_table.god_y"]=_GT_veh_esp_table.god_y,
["_GT_veh_esp_table.line_far_a"]=_GT_veh_esp_table.line_far_a,
["_GT_veh_esp_table.line_far_b"]=_GT_veh_esp_table.line_far_b,
["_GT_veh_esp_table.line_far_g"]=_GT_veh_esp_table.line_far_g,
["_GT_veh_esp_table.line_far_r"]=_GT_veh_esp_table.line_far_r,
["_GT_veh_esp_table.line_feat"]=_GT_veh_esp_table.line_feat,
["_GT_veh_esp_table.line_frnd_a"]=_GT_veh_esp_table.line_frnd_a,
["_GT_veh_esp_table.line_frnd_b"]=_GT_veh_esp_table.line_frnd_b,
["_GT_veh_esp_table.line_frnd_g"]=_GT_veh_esp_table.line_frnd_g,
["_GT_veh_esp_table.line_frnd_r"]=_GT_veh_esp_table.line_frnd_r,
["_GT_veh_esp_table.line_near_a"]=_GT_veh_esp_table.line_near_a,
["_GT_veh_esp_table.line_near_b"]=_GT_veh_esp_table.line_near_b,
["_GT_veh_esp_table.line_near_dist"]=_GT_veh_esp_table.line_near_dist,
["_GT_veh_esp_table.line_near_g"]=_GT_veh_esp_table.line_near_g,
["_GT_veh_esp_table.line_near_r"]=_GT_veh_esp_table.line_near_r,
["_GT_veh_esp_table.line_self_a"]=_GT_veh_esp_table.line_self_a,
["_GT_veh_esp_table.line_self_b"]=_GT_veh_esp_table.line_self_b,
["_GT_veh_esp_table.line_self_g"]=_GT_veh_esp_table.line_self_g,
["_GT_veh_esp_table.line_self_r"]=_GT_veh_esp_table.line_self_r,
["_GT_veh_esp_table.line_show_for"]=_GT_veh_esp_table.line_show_for,
["_GT_veh_esp_table.show_plyr_name"]=_GT_veh_esp_table.show_plyr_name,
["_GT_veh_esp_table.show_veh_crrnt"]=_GT_veh_esp_table.show_veh_crrnt,
["_GT_veh_esp_table.show_veh_dist"]=_GT_veh_esp_table.show_veh_dist,
["_GT_veh_esp_table.show_veh_god"]=_GT_veh_esp_table.show_veh_god,
["_GT_veh_esp_table.show_veh_name"]=_GT_veh_esp_table.show_veh_name,
["_GT_veh_esp_table.show_veh_prsnl"]=_GT_veh_esp_table.show_veh_prsnl,
["_GT_veh_esp_table.show_veh_pssngr"]=_GT_veh_esp_table.show_veh_pssngr,
["_GT_veh_esp_table.text_b"]=_GT_veh_esp_table.text_b,
["_GT_veh_esp_table.text_b"]=_GT_veh_esp_table.text_b,
["_GT_veh_esp_table.text_from_top"]=_GT_veh_esp_table.text_from_top,
["_GT_veh_esp_table.text_g"]=_GT_veh_esp_table.text_g,
["_GT_veh_esp_table.text_g"]=_GT_veh_esp_table.text_g,
["_GT_veh_esp_table.text_jstfctn"]=_GT_veh_esp_table.text_jstfctn,
["_GT_veh_esp_table.text_r"]=_GT_veh_esp_table.text_r,
["_GT_veh_esp_table.text_r"]=_GT_veh_esp_table.text_r,
["_GT_veh_esp_table.text_size"]=_GT_veh_esp_table.text_size,
["_GT_veh_esp_table.text_space"]=_GT_veh_esp_table.text_space,
["_GT_veh_esp_table.text_vis"]=_GT_veh_esp_table.text_vis,
["_GT_veh_esp_table.text_x"]=_GT_veh_esp_table.text_x,
["_GT_veh_esp_table.text_y"]=_GT_veh_esp_table.text_y,
["_GT_veh_esp_table.vis"]=_GT_veh_esp_table.vis,
["_GT_veh_info_entry.dmnsns"]=_GT_veh_info_entry.dmnsns,
["_GT_veh_info_entry.feat"]=_GT_veh_info_entry.feat,
["_GT_veh_info_entry.god"]=_GT_veh_info_entry.god,
["_GT_veh_info_entry.gtaid"]=_GT_veh_info_entry.gtaid,
["_GT_veh_info_entry.hash"]=_GT_veh_info_entry.hash,
["_GT_veh_info_entry.hlth"]=_GT_veh_info_entry.hlth,
["_GT_veh_info_entry.occpnts"]=_GT_veh_info_entry.occpnts,
["_GT_veh_info_entry.scnds"]=_GT_veh_info_entry.scnds,
["_GT_veh_info_entry.speed"]=_GT_veh_info_entry.speed,
["_GT_veh_info_entry.weap"]=_GT_veh_info_entry.weap,
["_GT_spwn_veh.spwn_in_veh"]=_GT_spwn_veh.spwn_in_veh,
["_GT_spwn_veh.spwn_upg"]=_GT_spwn_veh.spwn_upg,
["_GT_spwn_veh.spwn_f1"]=_GT_spwn_veh.spwn_f1,
["_GT_spwn_veh.remove_old"]=_GT_spwn_veh.remove_old,
["_GT_spwn_veh.spwn_spd_tq"]=_GT_spwn_veh.spwn_spd_tq,
["_GT_spwn_veh.spwn_rand_paint"]=_GT_spwn_veh.spwn_rand_paint,
["_GT_spwn_veh.spwn_cust_paint"]=_GT_spwn_veh.spwn_cust_paint,
["_GT_spwn_veh.spwn_cust_paint_r"]=_GT_spwn_veh.spwn_cust_paint_r,
["_GT_spwn_veh.spwn_cust_paint_g"]=_GT_spwn_veh.spwn_cust_paint_g,
["_GT_spwn_veh.spwn_cust_paint_b"]=_GT_spwn_veh.spwn_cust_paint_b,
["_GT_spwn_veh.paint_list.pnt_Purewhite"]=_GT_spwn_veh.paint_list.pnt_Purewhite,
["_GT_spwn_veh.paint_list.pnt_White"]=_GT_spwn_veh.paint_list.pnt_White,
["_GT_spwn_veh.paint_list.pnt_Cream"]=_GT_spwn_veh.paint_list.pnt_Cream,
["_GT_spwn_veh.paint_list.pnt_Grey"]=_GT_spwn_veh.paint_list.pnt_Grey,
["_GT_spwn_veh.paint_list.pnt_Black"]=_GT_spwn_veh.paint_list.pnt_Black,
["_GT_spwn_veh.paint_list.pnt_PastelPink"]=_GT_spwn_veh.paint_list.pnt_PastelPink,
["_GT_spwn_veh.paint_list.pnt_Pink"]=_GT_spwn_veh.paint_list.pnt_Pink,
["_GT_spwn_veh.paint_list.pnt_PinkRed"]=_GT_spwn_veh.paint_list.pnt_PinkRed,
["_GT_spwn_veh.paint_list.pnt_WineRed"]=_GT_spwn_veh.paint_list.pnt_WineRed,
["_GT_spwn_veh.paint_list.pnt_Red"]=_GT_spwn_veh.paint_list.pnt_Red,
["_GT_spwn_veh.paint_list.pnt_BrightRed"]=_GT_spwn_veh.paint_list.pnt_BrightRed,
["_GT_spwn_veh.paint_list.pnt_Salmon"]=_GT_spwn_veh.paint_list.pnt_Salmon,
["_GT_spwn_veh.paint_list.pnt_BrightBlue"]=_GT_spwn_veh.paint_list.pnt_BrightBlue,
["_GT_spwn_veh.paint_list.pnt_LightBlue"]=_GT_spwn_veh.paint_list.pnt_LightBlue,
["_GT_spwn_veh.paint_list.pnt_Teal"]=_GT_spwn_veh.paint_list.pnt_Teal,
["_GT_spwn_veh.paint_list.pnt_RoyalBlue"]=_GT_spwn_veh.paint_list.pnt_RoyalBlue,
["_GT_spwn_veh.paint_list.pnt_CreamYellow"]=_GT_spwn_veh.paint_list.pnt_CreamYellow,
["_GT_spwn_veh.paint_list.pnt_Yellow"]=_GT_spwn_veh.paint_list.pnt_Yellow,
["_GT_spwn_veh.paint_list.pnt_Mustard"]=_GT_spwn_veh.paint_list.pnt_Mustard,
["_GT_spwn_veh.paint_list.pnt_Brightyellow"]=_GT_spwn_veh.paint_list.pnt_Brightyellow,
["_GT_spwn_veh.paint_list.pnt_Schoolbus"]=_GT_spwn_veh.paint_list.pnt_Schoolbus,
["_GT_spwn_veh.paint_list.pnt_DarkOrange"]=_GT_spwn_veh.paint_list.pnt_DarkOrange,
["_GT_spwn_veh.paint_list.pnt_CreamGreen"]=_GT_spwn_veh.paint_list.pnt_CreamGreen,
["_GT_spwn_veh.paint_list.pnt_LightGreen"]=_GT_spwn_veh.paint_list.pnt_LightGreen,
["_GT_spwn_veh.paint_list.pnt_BrightGreen"]=_GT_spwn_veh.paint_list.pnt_BrightGreen,
["_GT_spwn_veh.paint_list.pnt_DarkGreen"]=_GT_spwn_veh.paint_list.pnt_DarkGreen,
["_GT_spwn_veh.paint_list.pnt_CreamPurple"]=_GT_spwn_veh.paint_list.pnt_CreamPurple,
["_GT_spwn_veh.paint_list.pnt_BrightPurple"]=_GT_spwn_veh.paint_list.pnt_BrightPurple,
["_GT_spwn_veh.paint_list.pnt_DarkPurple"]=_GT_spwn_veh.paint_list.pnt_DarkPurple,
["_GT_spwn_veh.neon.choose"]=_GT_spwn_veh.neon.choose,
["_GT_spwn_veh.neon.list.White"]=_GT_spwn_veh.neon.list.White,
["_GT_spwn_veh.neon.list.Blue"]=_GT_spwn_veh.neon.list.Blue,
["_GT_spwn_veh.neon.list.ElectricBlue"]=_GT_spwn_veh.neon.list.ElectricBlue,
["_GT_spwn_veh.neon.list.MintGreen"]=_GT_spwn_veh.neon.list.MintGreen,
["_GT_spwn_veh.neon.list.LimeGreen"]=_GT_spwn_veh.neon.list.LimeGreen,
["_GT_spwn_veh.neon.list.Yellow"]=_GT_spwn_veh.neon.list.Yellow,
["_GT_spwn_veh.neon.list.GoldenShower"]=_GT_spwn_veh.neon.list.GoldenShower,
["_GT_spwn_veh.neon.list.Orange"]=_GT_spwn_veh.neon.list.Orange,
["_GT_spwn_veh.neon.list.Red"]=_GT_spwn_veh.neon.list.Red,
["_GT_spwn_veh.neon.list.PonyPink"]=_GT_spwn_veh.neon.list.PonyPink,
["_GT_spwn_veh.neon.list.HotPink"]=_GT_spwn_veh.neon.list.HotPink,
["_GT_spwn_veh.neon.list.Purple"]=_GT_spwn_veh.neon.list.Purple,
["_GT_spwn_veh.neon.list.BlackLight"]=_GT_spwn_veh.neon.list.BlackLight,
["_GT_spwn_veh.h_light.choose"]=_GT_spwn_veh.h_light.choose,
["_GT_spwn_veh.h_light.list.White"]=_GT_spwn_veh.h_light.list.White,
["_GT_spwn_veh.h_light.list.Blue"]=_GT_spwn_veh.h_light.list.Blue,
["_GT_spwn_veh.h_light.list.ElectricBlue"]=_GT_spwn_veh.h_light.list.ElectricBlue,
["_GT_spwn_veh.h_light.list.MintGreen"]=_GT_spwn_veh.h_light.list.MintGreen,
["_GT_spwn_veh.h_light.list.LimeGreen"]=_GT_spwn_veh.h_light.list.LimeGreen,
["_GT_spwn_veh.h_light.list.Yellow"]=_GT_spwn_veh.h_light.list.Yellow,
["_GT_spwn_veh.h_light.list.GoldenShower"]=_GT_spwn_veh.h_light.list.GoldenShower,
["_GT_spwn_veh.h_light.list.Orange"]=_GT_spwn_veh.h_light.list.Orange,
["_GT_spwn_veh.h_light.list.Red"]=_GT_spwn_veh.h_light.list.Red,
["_GT_spwn_veh.h_light.list.PonyPink"]=_GT_spwn_veh.h_light.list.PonyPink,
["_GT_spwn_veh.h_light.list.HotPink"]=_GT_spwn_veh.h_light.list.HotPink,
["_GT_spwn_veh.h_light.list.Purple"]=_GT_spwn_veh.h_light.list.Purple,
["_GT_spwn_veh.h_light.list.BlackLight"]=_GT_spwn_veh.h_light.list.BlackLight,
["_GT_sssn_stf.new.quick_x"]=_GT_sssn_stf.new.quick_x,
["_GT_sssn_stf.new.quick_y"]=_GT_sssn_stf.new.quick_y,
["_GT_sssn_stf.new.spwn_upg"]=_GT_sssn_stf.new.spwn_upg,
["_GT_sssn_stf.new.spwn_f1"]=_GT_sssn_stf.new.spwn_f1,
["_GT_sssn_stf.new.spwn_spd_tq"]=_GT_sssn_stf.new.spwn_spd_tq,
["_GT_sssn_stf.new.spwn_rand_paint"]=_GT_sssn_stf.new.spwn_rand_paint,
["_GT_sssn_stf.new.spwn_cust_paint"]=_GT_sssn_stf.new.spwn_cust_paint,
["_GT_sssn_stf.new.spwn_cust_paint_r"]=_GT_sssn_stf.new.spwn_cust_paint_r,
["_GT_sssn_stf.new.spwn_cust_paint_g"]=_GT_sssn_stf.new.spwn_cust_paint_g,
["_GT_sssn_stf.new.spwn_cust_paint_b"]=_GT_sssn_stf.new.spwn_cust_paint_b,
["_GT_sssn_stf.new.paint_list.pnt_Purewhite"]=_GT_sssn_stf.new.paint_list.pnt_Purewhite,
["_GT_sssn_stf.new.paint_list.pnt_White"]=_GT_sssn_stf.new.paint_list.pnt_White,
["_GT_sssn_stf.new.paint_list.pnt_Cream"]=_GT_sssn_stf.new.paint_list.pnt_Cream,
["_GT_sssn_stf.new.paint_list.pnt_Grey"]=_GT_sssn_stf.new.paint_list.pnt_Grey,
["_GT_sssn_stf.new.paint_list.pnt_Black"]=_GT_sssn_stf.new.paint_list.pnt_Black,
["_GT_sssn_stf.new.paint_list.pnt_PastelPink"]=_GT_sssn_stf.new.paint_list.pnt_PastelPink,
["_GT_sssn_stf.new.paint_list.pnt_Pink"]=_GT_sssn_stf.new.paint_list.pnt_Pink,
["_GT_sssn_stf.new.paint_list.pnt_PinkRed"]=_GT_sssn_stf.new.paint_list.pnt_PinkRed,
["_GT_sssn_stf.new.paint_list.pnt_WineRed"]=_GT_sssn_stf.new.paint_list.pnt_WineRed,
["_GT_sssn_stf.new.paint_list.pnt_Red"]=_GT_sssn_stf.new.paint_list.pnt_Red,
["_GT_sssn_stf.new.paint_list.pnt_BrightRed"]=_GT_sssn_stf.new.paint_list.pnt_BrightRed,
["_GT_sssn_stf.new.paint_list.pnt_Salmon"]=_GT_sssn_stf.new.paint_list.pnt_Salmon,
["_GT_sssn_stf.new.paint_list.pnt_BrightBlue"]=_GT_sssn_stf.new.paint_list.pnt_BrightBlue,
["_GT_sssn_stf.new.paint_list.pnt_LightBlue"]=_GT_sssn_stf.new.paint_list.pnt_LightBlue,
["_GT_sssn_stf.new.paint_list.pnt_Teal"]=_GT_sssn_stf.new.paint_list.pnt_Teal,
["_GT_sssn_stf.new.paint_list.pnt_RoyalBlue"]=_GT_sssn_stf.new.paint_list.pnt_RoyalBlue,
["_GT_sssn_stf.new.paint_list.pnt_CreamYellow"]=_GT_sssn_stf.new.paint_list.pnt_CreamYellow,
["_GT_sssn_stf.new.paint_list.pnt_Yellow"]=_GT_sssn_stf.new.paint_list.pnt_Yellow,
["_GT_sssn_stf.new.paint_list.pnt_Mustard"]=_GT_sssn_stf.new.paint_list.pnt_Mustard,
["_GT_sssn_stf.new.paint_list.pnt_Brightyellow"]=_GT_sssn_stf.new.paint_list.pnt_Brightyellow,
["_GT_sssn_stf.new.paint_list.pnt_Schoolbus"]=_GT_sssn_stf.new.paint_list.pnt_Schoolbus,
["_GT_sssn_stf.new.paint_list.pnt_DarkOrange"]=_GT_sssn_stf.new.paint_list.pnt_DarkOrange,
["_GT_sssn_stf.new.paint_list.pnt_CreamGreen"]=_GT_sssn_stf.new.paint_list.pnt_CreamGreen,
["_GT_sssn_stf.new.paint_list.pnt_LightGreen"]=_GT_sssn_stf.new.paint_list.pnt_LightGreen,
["_GT_sssn_stf.new.paint_list.pnt_BrightGreen"]=_GT_sssn_stf.new.paint_list.pnt_BrightGreen,
["_GT_sssn_stf.new.paint_list.pnt_DarkGreen"]=_GT_sssn_stf.new.paint_list.pnt_DarkGreen,
["_GT_sssn_stf.new.paint_list.pnt_CreamPurple"]=_GT_sssn_stf.new.paint_list.pnt_CreamPurple,
["_GT_sssn_stf.new.paint_list.pnt_BrightPurple"]=_GT_sssn_stf.new.paint_list.pnt_BrightPurple,
["_GT_sssn_stf.new.paint_list.pnt_DarkPurple"]=_GT_sssn_stf.new.paint_list.pnt_DarkPurple,
["_GT_sssn_stf.new.neon.choose"]=_GT_sssn_stf.new.neon.choose,
["_GT_sssn_stf.new.neon.list.White"]=_GT_sssn_stf.new.neon.list.White,
["_GT_sssn_stf.new.neon.list.Blue"]=_GT_sssn_stf.new.neon.list.Blue,
["_GT_sssn_stf.new.neon.list.ElectricBlue"]=_GT_sssn_stf.new.neon.list.ElectricBlue,
["_GT_sssn_stf.new.neon.list.MintGreen"]=_GT_sssn_stf.new.neon.list.MintGreen,
["_GT_sssn_stf.new.neon.list.LimeGreen"]=_GT_sssn_stf.new.neon.list.LimeGreen,
["_GT_sssn_stf.new.neon.list.Yellow"]=_GT_sssn_stf.new.neon.list.Yellow,
["_GT_sssn_stf.new.neon.list.GoldenShower"]=_GT_sssn_stf.new.neon.list.GoldenShower,
["_GT_sssn_stf.new.neon.list.Orange"]=_GT_sssn_stf.new.neon.list.Orange,
["_GT_sssn_stf.new.neon.list.Red"]=_GT_sssn_stf.new.neon.list.Red,
["_GT_sssn_stf.new.neon.list.PonyPink"]=_GT_sssn_stf.new.neon.list.PonyPink,
["_GT_sssn_stf.new.neon.list.HotPink"]=_GT_sssn_stf.new.neon.list.HotPink,
["_GT_sssn_stf.new.neon.list.Purple"]=_GT_sssn_stf.new.neon.list.Purple,
["_GT_sssn_stf.new.neon.list.BlackLight"]=_GT_sssn_stf.new.neon.list.BlackLight,
["_GT_sssn_stf.new.h_light.choose"]=_GT_sssn_stf.new.h_light.choose,
["_GT_sssn_stf.new.h_light.list.White"]=_GT_sssn_stf.new.h_light.list.White,
["_GT_sssn_stf.new.h_light.list.Blue"]=_GT_sssn_stf.new.h_light.list.Blue,
["_GT_sssn_stf.new.h_light.list.ElectricBlue"]=_GT_sssn_stf.new.h_light.list.ElectricBlue,
["_GT_sssn_stf.new.h_light.list.MintGreen"]=_GT_sssn_stf.new.h_light.list.MintGreen,
["_GT_sssn_stf.new.h_light.list.LimeGreen"]=_GT_sssn_stf.new.h_light.list.LimeGreen,
["_GT_sssn_stf.new.h_light.list.Yellow"]=_GT_sssn_stf.new.h_light.list.Yellow,
["_GT_sssn_stf.new.h_light.list.GoldenShower"]=_GT_sssn_stf.new.h_light.list.GoldenShower,
["_GT_sssn_stf.new.h_light.list.Orange"]=_GT_sssn_stf.new.h_light.list.Orange,
["_GT_sssn_stf.new.h_light.list.Red"]=_GT_sssn_stf.new.h_light.list.Red,
["_GT_sssn_stf.new.h_light.list.PonyPink"]=_GT_sssn_stf.new.h_light.list.PonyPink,
["_GT_sssn_stf.new.h_light.list.HotPink"]=_GT_sssn_stf.new.h_light.list.HotPink,
["_GT_sssn_stf.new.h_light.list.Purple"]=_GT_sssn_stf.new.h_light.list.Purple,
["_GT_sssn_stf.new.h_light.list.BlackLight"]=_GT_sssn_stf.new.h_light.list.BlackLight,
["_GT_spwn_veh.spwn_god"]=_GT_spwn_veh.spwn_god,
["_GT_sssn_stf.new.spwn_god"]=_GT_sssn_stf.new.spwn_god,
["_GT_sssn_stf.new.max_tint"]=_GT_sssn_stf.new.max_tint,
["_GT_spwn_veh.spwn_max_tint"]=_GT_spwn_veh.spwn_max_tint,
["_GT_spwn_veh.spwn_invcn_wind"]=_GT_spwn_veh.spwn_invcn_wind,
["_GT_sssn_stf.new.invcn_wind"]=_GT_sssn_stf.new.invcn_wind,
["_GT_spwn_veh.spwn_plate_i"]=_GT_spwn_veh.spwn_plate_i,
["_GT_spwn_veh.spwn_plate"]=_GT_spwn_veh.spwn_plate,
["_GT_sssn_stf.new.plate_i"]=_GT_sssn_stf.new.plate_i,
["_GT_sssn_stf.new.plate"]=_GT_sssn_stf.new.plate,
["_GT_spwn_veh.spwn_front"]=_GT_spwn_veh.spwn_front,
["_GT_rtcl.feat"]=_GT_rtcl.feat,
["_GT_rtcl.slct"]=_GT_rtcl.slct,
["_GT_rtcl.size"]=_GT_rtcl.size,
["_GT_rtcl.rtcl_slct"]=_GT_rtcl.rtcl_slct,
["_GT_rtcl.rtcl_react"]=_GT_rtcl.rtcl_react,
["_GT_rtcl.no_ent_r"]=_GT_rtcl.no_ent_r,
["_GT_rtcl.no_ent_g"]=_GT_rtcl.no_ent_g,
["_GT_rtcl.no_ent_b"]=_GT_rtcl.no_ent_b,
["_GT_rtcl.no_ent_a"]=_GT_rtcl.no_ent_a,
["_GT_rtcl.ent_r"]=_GT_rtcl.ent_r,
["_GT_rtcl.ent_g"]=_GT_rtcl.ent_g,
["_GT_rtcl.ent_b"]=_GT_rtcl.ent_b,
["_GT_rtcl.ent_a"]=_GT_rtcl.ent_a,
["_GT_RADAR.feat"]=_GT_RADAR.feat,
["_GT_RADAR.range"]=_GT_RADAR.range,
["_GT_RADAR.r_size"]=_GT_RADAR.r_size,
["_GT_RADAR.x"]=_GT_RADAR.x,
["_GT_RADAR.y"]=_GT_RADAR.y,
["_GT_RADAR.rings_show"]=_GT_RADAR.rings_show,
["_GT_RADAR.rings_opp_color"]=_GT_RADAR.rings_opp_color,
["_GT_RADAR.r_r"]=_GT_RADAR.r_r,
["_GT_RADAR.r_g"]=_GT_RADAR.r_g,
["_GT_RADAR.r_b"]=_GT_RADAR.r_b,
["_GT_RADAR.r_a"]=_GT_RADAR.r_a,
["_GT_RADAR.r"]=_GT_RADAR.r,
["_GT_RADAR.g"]=_GT_RADAR.g,
["_GT_RADAR.b"]=_GT_RADAR.b,
["_GT_RADAR.a"]=_GT_RADAR.a,
["_GT_RADAR.p_size"]=_GT_RADAR.p_size,
["_GT_RADAR.self"]=_GT_RADAR.self,
["_GT_RADAR.s_a"]=_GT_RADAR.s_a,
["_GT_RADAR.f_a"]=_GT_RADAR.f_a,
["_GT_RADAR.o_a"]=_GT_RADAR.o_a,
["_GT_RADAR.csa_show"]=_GT_RADAR.csa_show,
["_GT_RADAR.csa_r"]=_GT_RADAR.csa_r,
["_GT_RADAR.csa_g"]=_GT_RADAR.csa_g,
["_GT_RADAR.csa_b"]=_GT_RADAR.csa_b,
["_GT_RADAR.csa_a"]=_GT_RADAR.csa_a,
["_GT_RADAR.nice_show"]=_GT_RADAR.nice_show,
["_GT_RADAR.nice_r"]=_GT_RADAR.nice_r,
["_GT_RADAR.nice_g"]=_GT_RADAR.nice_g,
["_GT_RADAR.nice_b"]=_GT_RADAR.nice_b,
["_GT_RADAR.nice_a"]=_GT_RADAR.nice_a,
["_GT_RADAR.mssn_show"]=_GT_RADAR.mssn_show,
["_GT_RADAR.mssn_r"]=_GT_RADAR.mssn_r,
["_GT_RADAR.mssn_g"]=_GT_RADAR.mssn_g,
["_GT_RADAR.mssn_b"]=_GT_RADAR.mssn_b,
["_GT_RADAR.mssn_a"]=_GT_RADAR.mssn_a,
["_GT_RADAR.anml_show"]=_GT_RADAR.anml_show,
["_GT_RADAR.anml_r"]=_GT_RADAR.anml_r,
["_GT_RADAR.anml_g"]=_GT_RADAR.anml_g,
["_GT_RADAR.anml_b"]=_GT_RADAR.anml_b,
["_GT_RADAR.anml_a"]=_GT_RADAR.anml_a,
["_GT_RADAR.xT"]=_GT_RADAR.xT,
["_GT_RADAR.yT"]=_GT_RADAR.yT,
["_GT_RADAR.name"]=_GT_RADAR.name,
["_GT_RADAR.name_s"]=_GT_RADAR.name_s,
["_GT_RADAR.name_x"]=_GT_RADAR.name_x,
["_GT_RADAR.name_y"]=_GT_RADAR.name_y,
["_GT_RADAR.wp_size"]=_GT_RADAR.wp_size,
["_GT_RADAR.wp_a"]=_GT_RADAR.wp_a,
["_GT_RADAR.name_j"]=_GT_RADAR.name_j,
["_G_gee_eye_bypass"]=_G_gee_eye_bypass,
}

local old_save_list ={
["_G_gee_eye_aud"]=true,		--renamed in v1.02
["_G_gee_eye_blame"]=true,		--renamed in v1.02
["_G_gee_eye_delay"]=true,		--renamed in v1.02
["_G_gee_eye_flare"]=true,		--renamed in v1.02
["_G_gee_eye_main"]=true,		--renamed in v1.02
["_G_gee_eye_spread"]=true,		--renamed in v1.02
["_G_gee_eye_spread_type"]=true,--renamed in v1.02
["_G_gee_eye_vis"]=true,		--renamed in v1.02
["_G_gee_eyeSelect1"]=true,		--renamed in v1.02
}

_G_save_stuff.type_bool={}
_G_save_stuff.type_bool[1]=true 	-- toggle

_G_save_stuff.type_val = {}
_G_save_stuff.type_val[518]=true	--action_slider
_G_save_stuff.type_val[522]=true	--action_value_i
_G_save_stuff.type_val[546]=true	--action_value_str
_G_save_stuff.type_val[642]=true	--action_value_f
_G_save_stuff.type_val[1030]=true	--autoaction_slider
_G_save_stuff.type_val[1034]=true	--autoaction_value_i
_G_save_stuff.type_val[1058]=true	--autoaction_value_str
_G_save_stuff.type_val[1154]=true	--autoaction_value_f

_G_save_stuff.type_both = {}
_G_save_stuff.type_both[7]=true	 	--slider 	toggle
_G_save_stuff.type_both[11]=true 	--value_i 	toggle
_G_save_stuff.type_both[35]=true 	--value_str toggle
_G_save_stuff.type_both[131]=true	--value_f 	toggle


function _G_save_stuff.get_feat_bool(_feat)
    return tostring(_feat.on)
end

function _G_save_stuff.should_count(_feat,_state)
	if _G_save_stuff.feat[_feat] ~= nil then
		if (tostring(_state)=="true" or tostring(_state)=="false") then
			return true
		elseif _G_save_stuff.feat[_feat].value ~= nil then
			return true
		end
    end
	return false
end


function _G_save_stuff.load_sett(_feat,_state)
	if _G_save_stuff.feat[_feat] == nil then
		menu.notify("Invalid entry in config file:\n"..tostring(_feat).." = "..tostring(_state).."\nError will be fixed after save.", _G_GeeVer, 10, 2)
	elseif tostring(_state)=="true" then
        _G_save_stuff.feat[_feat].on=true
	elseif tostring(_state)=="false" then
        _G_save_stuff.feat[_feat].on=false
    elseif _G_save_stuff.feat[_feat].value == nil then
		menu.notify("Invalid entry in config file:\n"..tostring(_feat).." = "..tostring(_state).."\nError will be fixed after save.", _G_GeeVer, 10, 2)
	else
		_G_save_stuff.feat[_feat].value=tonumber(_state)
    end
end

_G_save_stuff.save_it=menu.add_feature("Save Settings", "action", parent.id, function()
	local save_file_text=""
	local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg","w")
	local _type,_bool,_name
	table.sort(_G_save_stuff.name, function(a, b) return a:lower() <  b:lower() end)
	for i=1,#_G_save_stuff.name do
		if _G_save_stuff.feat[_G_save_stuff.name[i]] == nil or _G_save_stuff.feat[_G_save_stuff.name[i]].type == nil then
			menu.notify("Invalid entry in save table:\n"..tostring(_G_save_stuff.name[i]).."\nContact dev.", _G_GeeVer, 10, 2)
		else
			_type = _G_save_stuff.feat[_G_save_stuff.name[i]].type
			_bool = _G_save_stuff.get_feat_bool(_G_save_stuff.feat[_G_save_stuff.name[i]])
			_name = _G_save_stuff.name[i]
			_value = _G_save_stuff.feat[_name].value
			if _G_save_stuff.type_both[_type] then
				if save_file_text~="" then save_file_text=save_file_text.."\n" end
				save_file_text=save_file_text.._name.."=".._bool.."\n".._name.."=".._value
			elseif _G_save_stuff.type_val[_type] then
				if save_file_text~="" then save_file_text=save_file_text.."\n" end
				save_file_text=save_file_text.._name.."=".._value
			elseif _G_save_stuff.type_bool[_type] then
				if save_file_text~="" then save_file_text=save_file_text.."\n" end
				save_file_text=save_file_text.._name.."=".._bool
			else
				menu.notify("Invalid entry in save table\n".."type: "..tostring(_type).." bool: "..tostring(_bool).." name: "..tostring(_name).." value: "..tostring(_value).."", _G_GeeVer, 10, 2)
			end
		end
		if i % 50 == 0 then
			system.yield(0)
		end
	end
	file:write(save_file_text)
	file:close()
	menu.notify("Save completed",_G_GeeVer,4,6)
end)

_G_save_stuff.load_it=menu.add_feature("Load Settings", "action", parent.id, function()
	local temp,load_count,old_save = nil,0,false
	if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg") then
		local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg","r")
		for i in file:lines() do
			local fields = {}
			i:gsub(string.format("([^%s]+)", "="), function(c) fields[#fields+1] = c end)
			if old_save_list[fields[1]] then
				old_save=true
			else
				_G_save_stuff.load_sett(fields[1],fields[2])
				if _G_save_stuff.should_count(fields[1],fields[2]) then
					if temp ~= fields[1] then
						temp = fields[1]
						load_count=load_count+1
					end
				end
			end
			if load_count % 50 == 0 then
				system.yield(0)
			end
		end
		file:close()
		if old_save then
			menu.notify("Gee-Eye has been updated. Please update any settings in that feature and re-save.",_G_GeeVer,10,6)
		end
		menu.notify(load_count.."/"..#_G_save_stuff.name.." Settings loaded",_G_GeeVer,4,6)
	else
		menu.notify("Config file not found\n"..#_G_save_stuff.name.." settings not loaded",_G_GeeVer,4,6)
	end
	_G_on_start_splash.on=true
	system.yield(1000) 
	_GT_veh_esp_table.math_do()
	_G_GS_has_loaded=true
end)
_G_save_stuff.load_it.on=true


---------------------------------------------------------------------------------------------------------------------------------------------------
-- _GT_blip_table = {}
-- _G_save_pos_table = {}
-- _GT_temp_close_pos = {}
-- _GT_temp_popos = {}
-- local police_blip_max_do=false
-- --_GT_temp_new_pos = {}
-- _G_save_pos=menu.add_feature("Save pos ", "toggle", parent.id, function(f)--just used for tp pos
	-- local me=player.player_id()
	-- local my_pos = player.get_player_coords(me)
	-- local new_pos
	-- if _G_save_pos_table[1] == nil then
		-- _G_save_pos_table[1]=my_pos
	-- end
	-- if _GT_blip_table[1] == nil then
		-- _GT_blip_table[1]=ui.add_blip_for_coord(my_pos)
	-- end
	-- local time = utils.time_ms() + 1000
	-- while f.on do
		-- system.yield(100)
		-- my_pos = player.get_player_coords(me)
		-- if _G_save_pos_z.value == 0 then
			-- my_pos.z=my_pos.z+1
		-- else
			-- my_pos.z = 3
		-- end
		-- if _GF_key_active(252,1) or _GF_blip_not_close_to_pos(my_pos) then
			-- local file
			-- if my_pos.y >=0 then
				-- if my_pos.x >= 0 then
					-- file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\_GT_WP_TP_NE.cfg","a")
				-- else
					-- file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\_GT_WP_TP_NW.cfg","a")
				-- end
			-- else
				-- if my_pos.x >= 0 then
					-- file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\_GT_WP_TP_SE.cfg","a")
				-- else
					-- file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\_GT_WP_TP_SW.cfg","a")
				-- end
			-- end
			-- _GT_blip_table[#_GT_blip_table+1] = ui.add_blip_for_coord(my_pos)
			-- -- _GT_temp_new_pos[#_GT_temp_new_pos+1] = my_pos
			-- --local blip = ui.add_blip_for_coord(my_pos)
			-- local x = _GF_2_decimals(my_pos.x)
			-- local y = _GF_2_decimals(my_pos.y)
			-- local z = _GF_2_decimals(my_pos.z)
			-- --z = 3
			-- local record = ''
			-- record=record..'\nv3('..x..','..y..','..z..'),'
			-- _G_pos_write_msg=""
			-- _G_pos_write_msg=_G_pos_write_msg..record
			-- menu.notify('v3('..x..','..y..','..z..')',_G_GeeVer,7,6)
			-- _G_save_pos_table[#_G_save_pos_table+1]=my_pos
			-- file:write(_G_pos_write_msg)
			-- file:close()
			-- while _GF_key_active(252,1) do
				-- system.yield(100)
			-- end
		-- end
		-- if #_GT_blip_table > 50 then
			-- ui.remove_blip(_GT_blip_table[1])
			-- table.remove(_GT_blip_table,1)
		-- end
	-- end
	-- for i=1,#_GT_blip_table do
		-- ui.remove_blip(_GT_blip_table[i])
	-- end
	-- _GT_blip_table = {}
-- end)

-- _G_save_pos_z=menu.add_feature("Pos elevation:","autoaction_value_str",parent.id,function()
-- end) _G_save_pos_z.set_str_data(_G_save_pos_z,{"Actual", "3"})


-- function _GF_blip_not_close_to_pos(_pos) 
	-- --table.sort(_G_save_pos_table, function(a, b) return _GF_dist_xy_pospos(ui.get_blip_coord(a),_pos) < _GF_dist_xy_pospos(ui.get_blip_coord(b),_pos) end)
	-- local too_close = false
	-- for i=1, #_G_save_pos_table do
		-- if _GF_dist_xy_pospos(_pos,_G_save_pos_table[i]) < _G_save_pos_dist.value then
			-- too_close=true
			-- break
		-- end
	-- end
	-- if not too_close then
		-- for i=1, #_GT_temp_close_pos do
			-- if _GF_dist_xy_pospos(_pos,_GT_temp_close_pos[i]) < _G_save_pos_dist.value then
				-- too_close=true
				-- break
			-- end
		-- end
	-- end
	-- if not too_close then
		-- return true
	-- end
-- end

-- _G_save_pos_dist=menu.add_feature("Pos record range","action_value_i",parent.id,function()--just used for tp pos
-- end)_G_save_pos_dist.max,_G_save_pos_dist.min,_G_save_pos_dist.mod=500,25,5



-- _G_blip_count=menu.add_feature("Police blip do max","autoaction_value_i",parent.id,function()--just used for tp pos
-- police_blip_max_do=true
-- end)_G_blip_count.max,_G_blip_count.min,_G_blip_count.mod=5000,10,10

-- _G_add_remove_blips_tog=menu.add_feature("Police blip toggle", "toggle", parent.id, function(f)--just used for tp pos
	-- local wait_time = utils.time()
	-- police_blip_max_do=true
	-- while f.on do
		-- system.yield(1000)
		-- if police_blip_max_do or wait_time+15 < utils.time() then
			-- police_blip_max_do=false
			-- _GT_temp_close_pos = {}
			-- _GF_load_temp_pos_table()
			-- _GF_sort_temp_pos_table()
			-- _GF_spawn_temp_pos_popo()	
			-- wait_time = utils.time()
		-- end
	-- end
	-- _GF_delete_temp_pos_popo()
	-- _GT_temp_close_pos = {}
-- end)



-- function _GF_load_temp_pos_table()
	-- for i=1, #_G_save_pos_table do
		-- if _GF_dist_xy_pospos(_G_save_pos_table[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_G_save_pos_table[i]
		-- end
	-- end
	-- for i=1, #_GT_WP_TP_NE do
		-- if _GF_dist_xy_pospos(_GT_WP_TP_NE[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_GT_WP_TP_NE[i]
		-- end
	-- end
	-- for i=1, #_GT_WP_TP_NW do
		-- if _GF_dist_xy_pospos(_GT_WP_TP_NW[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_GT_WP_TP_NW[i]
		-- end
	-- end
	-- for i=1, #_GT_WP_TP_SE do
		-- if _GF_dist_xy_pospos(_GT_WP_TP_SE[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_GT_WP_TP_SE[i]
		-- end
	-- end
	-- for i=1, #_GT_WP_TP_SW do
		-- if _GF_dist_xy_pospos(_GT_WP_TP_SW[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_GT_WP_TP_SW[i]
		-- end
	-- end
	-- for i=1, #_GT_WP_TP_water do
		-- if _GF_dist_xy_pospos(_GT_WP_TP_water[i] ,player.get_player_coords(player.player_id())) < 750 then
			-- _GT_temp_close_pos[#_GT_temp_close_pos+1]=_GT_WP_TP_water[i]
		-- end
	-- end
-- end

-- function _GF_sort_temp_pos_table()
	-- if #_GT_temp_close_pos > 0 then
		-- _GF_sort_xy_pos(_GT_temp_close_pos,player.get_player_coords(player.player_id()))
	-- end
-- end

-- function _GF_spawn_temp_pos_popo()
	-- _GF_delete_temp_pos_popo()
	-- if #_GT_temp_close_pos > 0 then
		-- _GF_req_stream_hash(0x15F8700D)
		-- for i=1,_G_blip_count.value do
			-- if _GT_temp_close_pos[i] ~= nil then
				-- _GT_temp_popos[i] = ped.create_ped(2, 0x15F8700D, _GT_temp_close_pos[i], 0, false, false)
				-- entity.freeze_entity(_GT_temp_popos[i], true)
				-- --system.yield(0)
			-- end
		-- end
	-- end
-- end

-- function _GF_delete_temp_pos_popo()
	-- for i=1,#_GT_temp_popos do
		-- if _GF_is_ent(_GT_temp_popos[i]) then
			-- entity.delete_entity(_GT_temp_popos[i])
			-- --system.yield(0)
		-- end
	-- end
	-- gameplay.clear_area_of_cops(player.get_player_coords(player.player_id()),1000,false)
	-- _GT_temp_popos={}
-- end
---------------------------------------------------------------------------------------------------------------------------------------------------

end
