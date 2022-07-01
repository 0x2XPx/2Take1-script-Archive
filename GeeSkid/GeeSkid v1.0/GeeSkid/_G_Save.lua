-- GeeSkid v1.0

function _G_save_do(parent)



local _funcs_name={
"_G_auto_flip_veh",
"_G_Boost_display",
"_GT_drift_main.ovrly_ca",
"_GT_drift_main.ovrly_cb",
"_GT_drift_main.ovrly_cg",
"_GT_drift_main.ovrly_cr",
"_GT_drift_main.ovrly_f",
"_GT_drift_main.ovrly_s",
"_GT_drift_main.ovrly_x",
"_GT_drift_main.ovrly_y",
"_GT_drift_main.feat",
"_GT_drift_main.cntr_notif_feat",
"_G_gee_eye_aud",
"_G_gee_eye_blame",
"_G_gee_eye_bypass",
"_G_gee_eye_delay",
"_G_gee_eye_flare",
"_G_gee_eye_main",
"_G_gee_eye_spread",
"_G_gee_eye_spread_type",
"_G_gee_eye_vis",
"_G_gee_eyeSelect1",
"_G_gee_watch_destroy",
"_G_gee_watch_passenger",
"_G_gee_watch_passenger_npc",
"_G_gee_watch_player_info",
"_G_geeboost_set_keys",
"_G_GeeStopRvrs",
"_G_GeeBoost",
"_G_GeeBoostSelect1",
"_G_GeeBoostSelect2",
"_G_GeeBoostSelect3",
"_G_GeeDrive_insta",
"_G_GeeDrive_boost_tog",
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
"_G_GeeWatchRepair_key",
"_G_GeeWatchRvrs_key",
"_G_GeeWatchUpgrade_key",
"_G_mods_detex_god_shoot_tog",
"_G_mods_detex_kd_neg_tog",
"_G_mods_detex_kd_tog",
"_G_mods_detex_money_tog",
"_G_mods_detex_otr_tog",
"_G_mods_detex_rank_tog",
"_G_mods_detex_undead_tog",
"_G_ped_veh_accel",
"_G_ped_veh_down",
"_G_ped_veh_revers",
"_G_ped_veh_up",
"_G_plyr_excl_friends",
"_G_plyr_excl_modders",
"_G_plyr_JL_notif",
"_G_incl_prsnl_veh",
"_G_incl_owned_veh",
"_G_incl_npc_veh",
"_G_plyr_excl_orgmc",
"_G_on_plyrs_veh_pos_enforce",
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
"_GT_veh_info_entry.feat",
"_GT_veh_info_entry.speed",
"_GT_veh_info_entry.dmnsns",
"_GT_veh_info_entry.god",
"_GT_veh_info_entry.weap",
"_GT_veh_info_entry.hlth",
"_GT_veh_info_entry.hash",
"_GT_veh_info_entry.gtaid",
"_GT_veh_info_entry.occpnts",
"_GT_veh_info_entry.scnds",
"_G_veh_rapid_fire",
"_G_veh_rapid_fire_khan",
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
"_GT_aim_protex_main._G_plyr_time",
"_GT_aim_protex_main._G_plyr_aim_a",
"_GT_aim_protex_main._G_plyr_aim_cb",
"_GT_aim_protex_main._G_plyr_aim_cg",
"_GT_aim_protex_main._G_plyr_aim_cr",
"_GT_aim_protex_main._G_plyr_aim_f",
"_GT_aim_protex_main._G_plyr_aim_s",
"_GT_aim_protex_main._G_plyr_aim_spc",
"_GT_aim_protex_main._G_plyr_aim_x",
"_GT_aim_protex_main._G_plyr_aim_y",
"_GT_gta_map.hotkey_set_feat",
"_GT_gta_map.hotkey1_select",
"_GT_gta_map.hotkey2_select",
"_GT_gta_map.hotkey3_select",
"_GT_gta_map.map_feat",
"_GT_gta_map.map1_alpha_feat",
"_GT_gta_map.map1_size",
"_GT_gta_map.map2_alpha_feat",
"_GT_gta_map.map2_size",
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
"_GT_gta_map.type1_feat",
"_GT_gta_map.type2_feat",
"_GT_veh_esp_table.feat",
"_GT_veh_esp_table.vis",
"_GT_veh_esp_table.dist",
"_GT_veh_esp_table.show_plyr_name",
"_GT_veh_esp_table.text_vis",
"_GT_veh_esp_table.text_size",
"_GT_veh_esp_table.dist_type",
"_GT_veh_esp_table.blip_size",
"_GT_veh_esp_table.blip_size_dist",
"_GT_veh_esp_table.show_veh_name",
"_GT_veh_esp_table.show_veh_pssngr",
"_GT_veh_esp_table.show_veh_dist",
"_GT_veh_esp_table.show_veh_prsnl",
"_GT_veh_esp_table.show_veh_god",
"_GT_veh_esp_table.show_veh_crrnt",
"_GT_veh_esp_table.text_space",
"_GT_veh_esp_table.text_r",
"_GT_veh_esp_table.text_g",
"_GT_veh_esp_table.text_b",
"_GT_veh_esp_table.line_feat",
"_GT_veh_esp_table.line_show_for",
"_GT_veh_esp_table.line_near_dist",
"_GT_veh_esp_table.line_near_r",
"_GT_veh_esp_table.line_near_g",
"_GT_veh_esp_table.line_near_b",
"_GT_veh_esp_table.line_near_a",
"_GT_veh_esp_table.line_far_r",
"_GT_veh_esp_table.line_far_g",
"_GT_veh_esp_table.line_far_b",
"_GT_veh_esp_table.line_far_a",
"_GT_veh_esp_table.line_frnd_r",
"_GT_veh_esp_table.line_frnd_g",
"_GT_veh_esp_table.line_frnd_b",
"_GT_veh_esp_table.line_frnd_a",
"_GT_veh_esp_table.line_self_r",
"_GT_veh_esp_table.line_self_g",
"_GT_veh_esp_table.line_self_b",
"_GT_veh_esp_table.line_self_a",
"_G_ff_auto_kick",
"_G_auto_re_kick",
"_GT_gta_map.map1_zoom",
"_GT_gta_map.map2_zoom",
"_G_mk2_invrtd.feat",
"_G_mk2_invrtd.brakes",
"_G_mk2_invrtd.boost",
"_G_mk2_invrtd.pitch",
"_G_mk2_invrtd.roll",
"_G_mk2_invrtd.yaw",
"_G_mk2_invrtd.pitch_speed",
"_G_mk2_invrtd.roll_speed",
"_G_mk2_invrtd.yaw_speed",
"_GT_gta_map.z1",
"_GT_gta_map.head1_alpha_feat",
"_GT_gta_map.head1_size",
"_GT_gta_map.z2",
"_GT_gta_map.head2_alpha_feat",
"_GT_gta_map.head2_size",
"_GT_gta_map.all_math_x",
"_GT_gta_map.all_math_y",
"_GT_gta_map.full_math_x",
"_GT_gta_map.full_math_y",
"_GT_gta_map.qrtr_math_x",
"_GT_gta_map.qrtr_math_y",
"_GT_gta_map.cntr_math_x",
"_GT_gta_map.cntr_math_y",
"_GT_gta_map.othr_math_x",
"_GT_gta_map.othr_math_y",
"_GT_gta_map.cp_math_x",
"_GT_gta_map.cp_math_y",
"_GT_gta_map.cp_cmpnd_math_x",
"_GT_gta_map.cp_cmpnd_math_y",
"_GT_veh_esp_table.god_x",
"_GT_veh_esp_table.god_y",
"_GT_veh_esp_table.text_jstfctn",
"_GT_veh_esp_table.text_from_top",
"_GT_veh_esp_table.text_x",
"_GT_veh_esp_table.text_y",
"_G_veh_xtra_jmp",
"_G_veh_gun_main.feat",
"_G_veh_gun_main.type",
"_G_veh_gun_main.spwn_rng",
"_G_veh_gun_main.safe_zone",
"_G_veh_gun_main.delay",
"_G_veh_gun_main.select",
"_G_veh_gun_main.veh_speed",
"_G_rmv_trblnc",
"_G_invncbl_wndows",
"_G_max_tint",
"_G_auto_veh_rpr",
"_G_LOS_.feat",
"_G_LOS_.sort_by",
"_G_LOS_.sort_drctn",
"_G_LOS_.dist_type",
"_G_LOS_.size",
"_G_LOS_.x",
"_G_LOS_.y",
"_G_LOS_.back_a",
"_G_LOS_.text_a",
"_G_plyr_veh_auto_repair",
"_GT_sssn_stf.hrn_bst_feat",
"_GT_sssn_stf.hold.rpr",
"_GT_sssn_stf.hold.upgrd",
"_GT_sssn_stf.hold.dstry",
"_GT_sssn_stf.hold.time",
"_GT_sssn_stf.hold.show_in_use",
"_GT_sssn_stf.hold.upgrd_key",
"_GT_sssn_stf.hold.rpr_key",
"_GT_sssn_stf.hold.dstry_key",
"_G_ldrbrd.feat",
"_G_ldrbrd.show_last",
"_G_ldrbrd.sort_by",
"_G_ldrbrd.sort_drctn",
"_G_ldrbrd.size",
"_G_ldrbrd.x",
"_G_ldrbrd.y",
"_G_ldrbrd.back_a",
"_G_ldrbrd.text_a",
"_G_never_ped_fire",
"_GT_clear_stuff.range_feat",
"_GT_clear_stuff.peds",
"_GT_clear_stuff.obj",
"_GT_clear_stuff.veh",
"_GT_clear_stuff.prsnl",
"_GT_clear_stuff.prvs",
"_GT_clear_stuff.frnds",
"_GT_clear_stuff.orgmc",
"_GT_gw_ntr.veh_hlth",
"_GT_gw_ntr.veh_speed",
"_GT_gw_ntr.veh_weap",
"_GT_gw_ntr.ped_hlth",
"_GT_gw_ntr.ped_speed",
"_GT_gw_ntr.ped_weap",
"_G_GeeWatchNtr_key"
}

local _funcs={}
_funcs["_G_auto_flip_veh"]=_G_auto_flip_veh
_funcs["_G_Boost_display"]=_G_Boost_display
_funcs["_GT_drift_main.ovrly_ca"]=_GT_drift_main.ovrly_ca
_funcs["_GT_drift_main.ovrly_cb"]=_GT_drift_main.ovrly_cb
_funcs["_GT_drift_main.ovrly_cg"]=_GT_drift_main.ovrly_cg
_funcs["_GT_drift_main.ovrly_cr"]=_GT_drift_main.ovrly_cr
_funcs["_GT_drift_main.ovrly_f"]=_GT_drift_main.ovrly_f
_funcs["_GT_drift_main.ovrly_s"]=_GT_drift_main.ovrly_s
_funcs["_GT_drift_main.ovrly_x"]=_GT_drift_main.ovrly_x
_funcs["_GT_drift_main.ovrly_y"]=_GT_drift_main.ovrly_y
_funcs["_GT_drift_main.feat"]=_GT_drift_main.feat
_funcs["_GT_drift_main.cntr_notif_feat"]=_GT_drift_main.cntr_notif_feat
_funcs["_G_gee_eye_aud"]=_G_gee_eye_aud
_funcs["_G_gee_eye_blame"]=_G_gee_eye_blame
_funcs["_G_gee_eye_bypass"]=_G_gee_eye_bypass
_funcs["_G_gee_eye_delay"]=_G_gee_eye_delay
_funcs["_G_gee_eye_flare"]=_G_gee_eye_flare
_funcs["_G_gee_eye_main"]=_G_gee_eye_main
_funcs["_G_gee_eye_spread"]=_G_gee_eye_spread
_funcs["_G_gee_eye_spread_type"]=_G_gee_eye_spread_type
_funcs["_G_gee_eye_vis"]=_G_gee_eye_vis
_funcs["_G_gee_eyeSelect1"]=_G_gee_eyeSelect1
_funcs["_G_gee_watch_destroy"]=_G_gee_watch_destroy
_funcs["_G_gee_watch_passenger"]=_G_gee_watch_passenger
_funcs["_G_gee_watch_passenger_npc"]=_G_gee_watch_passenger_npc
_funcs["_G_gee_watch_player_info"]=_G_gee_watch_player_info
_funcs["_G_geeboost_set_keys"]=_G_geeboost_set_keys
_funcs["_G_GeeStopRvrs"]=_G_GeeStopRvrs
_funcs["_G_GeeBoost"]=_G_GeeBoost
_funcs["_G_GeeBoostSelect1"]=_G_GeeBoostSelect1
_funcs["_G_GeeBoostSelect2"]=_G_GeeBoostSelect2
_funcs["_G_GeeBoostSelect3"]=_G_GeeBoostSelect3
_funcs["_G_GeeDrive_insta"]=_G_GeeDrive_insta
_funcs["_G_GeeDrive_boost_tog"]=_G_GeeDrive_boost_tog
_funcs["_G_GeeLook"]=_G_GeeLook
_funcs["_G_GeeLookFall"]=_G_GeeLookFall
_funcs["_G_GeeParaAuto"]=_G_GeeParaAuto
_funcs["_G_GeeSlowFall"]=_G_GeeSlowFall
_funcs["_G_GeeSniperStrafe"]=_G_GeeSniperStrafe
_funcs["_G_GeeSniperZoom"]= _G_GeeSniperZoom
_funcs["_G_GeeSteer_custom"]=_G_GeeSteer_custom
_funcs["_G_GeeSteer_LC"]=_G_GeeSteer_LC
_funcs["_G_geesteer_set_keys"]=_G_geesteer_set_keys
_funcs["_G_GeeSteerSelect1"]=_G_GeeSteerSelect1
_funcs["_G_GeeSteerSelect2"]=_G_GeeSteerSelect2
_funcs["_G_GeeSteerSelect3"]=_G_GeeSteerSelect3
_funcs["_G_geestop_set_keys"]=_G_geestop_set_keys
_funcs["_G_GeeStopSelect1"]=_G_GeeStopSelect1
_funcs["_G_GeeStopSelect2"]=_G_GeeStopSelect2
_funcs["_G_GeeStopSelect3"]=_G_GeeStopSelect3
_funcs["_G_GeeSwim"]=_G_GeeSwim
_funcs["_G_GeeWatchAccel_key"]=_G_GeeWatchAccel_key
_funcs["_G_GeeWatchBoard_key"]=_G_GeeWatchBoard_key
_funcs["_G_GeeWatchBurn_key"]=_G_GeeWatchBurn_key
_funcs["_G_GeeWatchDamDes_key"]=_G_GeeWatchDamDes_key
_funcs["_G_GeeWatchDeEleRag_key"]=_G_GeeWatchDeEleRag_key
_funcs["_G_GeeWatchElev_key"]=_G_GeeWatchElev_key
_funcs["_G_GeeWatchExplode_key"]=_G_GeeWatchExplode_key
_funcs["_G_GeeWatchGod_key"]=_G_GeeWatchGod_key
_funcs["_G_GeeWatchKick_key"]=_G_GeeWatchKick_key
_funcs["_G_GeeWatchRepair_key"]=_G_GeeWatchRepair_key
_funcs["_G_GeeWatchRvrs_key"]=_G_GeeWatchRvrs_key
_funcs["_G_GeeWatchUpgrade_key"]=_G_GeeWatchUpgrade_key
_funcs["_G_mods_detex_god_shoot_tog"]= _G_mods_detex_god_shoot_tog
_funcs["_G_mods_detex_kd_neg_tog"]= _G_mods_detex_kd_neg_tog
_funcs["_G_mods_detex_kd_tog"]= _G_mods_detex_kd_tog
_funcs["_G_mods_detex_money_tog"]= _G_mods_detex_money_tog
_funcs["_G_mods_detex_otr_tog"]= _G_mods_detex_otr_tog
_funcs["_G_mods_detex_rank_tog"]= _G_mods_detex_rank_tog
_funcs["_G_mods_detex_undead_tog"]= _G_mods_detex_undead_tog
_funcs["_G_ped_veh_accel"]=_G_ped_veh_accel
_funcs["_G_ped_veh_down"]=_G_ped_veh_down
_funcs["_G_ped_veh_revers"]=_G_ped_veh_revers
_funcs["_G_ped_veh_up"]=_G_ped_veh_up
_funcs["_G_plyr_excl_friends"]=_G_plyr_excl_friends
_funcs["_G_plyr_excl_modders"]=_G_plyr_excl_modders
_funcs["_G_incl_prsnl_veh"]=_G_incl_prsnl_veh
_funcs["_G_incl_owned_veh"]=_G_incl_owned_veh
_funcs["_G_incl_npc_veh"]=_G_incl_npc_veh
_funcs["_G_plyr_excl_orgmc"]=_G_plyr_excl_orgmc
_funcs["_G_plyr_JL_notif"]= _G_plyr_JL_notif
_funcs["_G_on_plyrs_veh_pos_enforce"]=_G_on_plyrs_veh_pos_enforce
_funcs["_G_plyrs_overlay_main.plyr_list_feat"]=_G_plyrs_overlay_main.plyr_list_feat
_funcs["_G_plyrs_overlay_main.plyr_sort_asc_desc"]=_G_plyrs_overlay_main.plyr_sort_asc_desc
_funcs["_G_plyrs_overlay_main.plyr_sort_column_space"]= _G_plyrs_overlay_main.plyr_sort_column_space
_funcs["_G_plyrs_overlay_main.plyr_sort_column_type"]= _G_plyrs_overlay_main.plyr_sort_column_type
_funcs["_G_plyrs_overlay_main.plyr_sort_font"]=_G_plyrs_overlay_main.plyr_sort_font
_funcs["_G_plyrs_overlay_main.plyr_sort_kd"]=_G_plyrs_overlay_main.plyr_sort_kd
_funcs["_G_plyrs_overlay_main.plyr_sort_max"]=_G_plyrs_overlay_main.plyr_sort_max
_funcs["_G_plyrs_overlay_main.plyr_sort_money"]=_G_plyrs_overlay_main.plyr_sort_money
_funcs["_G_plyrs_overlay_main.plyr_sort_rank"]=_G_plyrs_overlay_main.plyr_sort_rank
_funcs["_G_plyrs_overlay_main.plyr_sort_scale"]=_G_plyrs_overlay_main.plyr_sort_scale
_funcs["_G_plyrs_overlay_main.plyr_sort_self"]=_G_plyrs_overlay_main.plyr_sort_self
_funcs["_G_plyrs_overlay_main.plyr_sort_space_hor"]=_G_plyrs_overlay_main.plyr_sort_space_hor
_funcs["_G_plyrs_overlay_main.plyr_sort_space_ver"]=_G_plyrs_overlay_main.plyr_sort_space_ver
_funcs["_G_plyrs_overlay_main.plyr_sort_speed_above"]=_G_plyrs_overlay_main.plyr_sort_speed_above
_funcs["_G_plyrs_overlay_main.plyr_sort_speed_ped"]=_G_plyrs_overlay_main.plyr_sort_speed_ped
_funcs["_G_plyrs_overlay_main.plyr_sort_speed_type"]=_G_plyrs_overlay_main.plyr_sort_speed_type
_funcs["_G_plyrs_overlay_main.plyr_sort_speed_veh"]=_G_plyrs_overlay_main.plyr_sort_speed_veh
_funcs["_G_plyrs_overlay_main.plyr_sort_tis"]=  _G_plyrs_overlay_main.plyr_sort_tis
_funcs["_G_plyrs_overlay_main.plyr_sort_top"]=_G_plyrs_overlay_main.plyr_sort_top
_funcs["_G_plyrs_overlay_main.plyr_sort_veh"]=_G_plyrs_overlay_main.plyr_sort_veh
_funcs["_G_plyrs_overlay_main.plyr_sort_wanted"]=_G_plyrs_overlay_main.plyr_sort_wanted
_funcs["_G_plyrs_overlay_main.plyr_sort_x"]=_G_plyrs_overlay_main.plyr_sort_x
_funcs["_G_plyrs_overlay_main.plyr_sort_y"]=_G_plyrs_overlay_main.plyr_sort_y
_funcs["_G_self_veh_accel"]=_G_self_veh_accel
_funcs["_G_self_veh_auto_force"]=_G_self_veh_auto_force
_funcs["_G_self_veh_auto_repair"]=_G_self_veh_auto_repair
_funcs["_G_self_veh_auto_setting"]=_G_self_veh_auto_setting
_funcs["_G_self_veh_auto_tp"]=_G_self_veh_auto_tp
_funcs["_G_self_veh_auto_upgrade"]=_G_self_veh_auto_upgrade
_funcs["_G_self_veh_down"]=_G_self_veh_down
_funcs["_G_self_veh_revers"]=_G_self_veh_revers
_funcs["_G_self_veh_tp_into_f"]=_G_self_veh_tp_into_f
_funcs["_G_self_veh_tp_into_f_delay"]=_G_self_veh_tp_into_f_delay
_funcs["_G_self_veh_tp_into_f_key"]=_G_self_veh_tp_into_f_key
_funcs["_G_self_veh_tp_out_f"]=_G_self_veh_tp_out_f
_funcs["_G_self_veh_tp_out_f_delay"]=_G_self_veh_tp_out_f_delay
_funcs["_G_self_veh_tp_out_f_key"]=_G_self_veh_tp_out_f_key
_funcs["_G_self_veh_up"]=_G_self_veh_up
_funcs["_G_show_otr_blips"]=_G_show_otr_blips
_funcs["_G_show_undead_blips"]=_G_show_undead_blips
_funcs["_G_silent_start"]=_G_silent_start
_funcs["_GT_veh_info_entry.feat"]=_GT_veh_info_entry.feat
_funcs["_GT_veh_info_entry.speed"]=_GT_veh_info_entry.speed
_funcs["_GT_veh_info_entry.dmnsns"]=_GT_veh_info_entry.dmnsns
_funcs["_GT_veh_info_entry.god"]=_GT_veh_info_entry.god
_funcs["_GT_veh_info_entry.weap"]=_GT_veh_info_entry.weap
_funcs["_GT_veh_info_entry.hlth"]=_GT_veh_info_entry.hlth
_funcs["_GT_veh_info_entry.hash"]=_GT_veh_info_entry.hash
_funcs["_GT_veh_info_entry.gtaid"]=_GT_veh_info_entry.gtaid
_funcs["_GT_veh_info_entry.occpnts"]=_GT_veh_info_entry.occpnts
_funcs["_GT_veh_info_entry.scnds"]=_GT_veh_info_entry.scnds
_funcs["_G_veh_rapid_fire"]=_G_veh_rapid_fire
_funcs["_G_veh_rapid_fire_khan"]=_G_veh_rapid_fire
_funcs["_G_vehicle_flier"]=_G_vehicle_flier
_funcs["_G_W_B_a"]=_G_W_B_a
_funcs["_G_W_B_cb"]=_G_W_B_cb
_funcs["_G_W_B_cg"]=_G_W_B_cg
_funcs["_G_W_B_cr"]=_G_W_B_cr
_funcs["_G_W_B_f"]=_G_W_B_f
_funcs["_G_W_B_god_s"]=_G_W_B_god_s
_funcs["_G_W_B_god_x"]=_G_W_B_god_x
_funcs["_G_W_B_god_y"]=_G_W_B_god_y
_funcs["_G_W_B_s"]=_G_W_B_s
_funcs["_G_W_B_x"]=_G_W_B_x
_funcs["_G_W_B_y"]=_G_W_B_y
_funcs["_G_Watch_display"]=_G_Watch_display
_funcs["_G_watch_dog"]=_G_watch_dog
_funcs["_G_waypoint_esp"]= _G_waypoint_esp
_funcs["_G_waypoint_esp_dist"]=  _G_waypoint_esp_dist
_funcs["_GF_veh_spawn_quick_x"]= _GF_veh_spawn_quick_x
_funcs["_GF_veh_spawn_quick_y"]= _GF_veh_spawn_quick_y
_funcs["_GT_aim_protex_main._G_aim_notif"]=_GT_aim_protex_main._G_aim_notif
_funcs["_GT_aim_protex_main._G_plyr_time"]=_GT_aim_protex_main._G_plyr_time
_funcs["_GT_aim_protex_main._G_plyr_aim_a"]=_GT_aim_protex_main._G_plyr_aim_a
_funcs["_GT_aim_protex_main._G_plyr_aim_cb"]=_GT_aim_protex_main._G_plyr_aim_cb
_funcs["_GT_aim_protex_main._G_plyr_aim_cg"]=_GT_aim_protex_main._G_plyr_aim_cg
_funcs["_GT_aim_protex_main._G_plyr_aim_cr"]=_GT_aim_protex_main._G_plyr_aim_cr
_funcs["_GT_aim_protex_main._G_plyr_aim_f"]=_GT_aim_protex_main._G_plyr_aim_f
_funcs["_GT_aim_protex_main._G_plyr_aim_s"]=_GT_aim_protex_main._G_plyr_aim_s
_funcs["_GT_aim_protex_main._G_plyr_aim_spc"]=_GT_aim_protex_main._G_plyr_aim_spc
_funcs["_GT_aim_protex_main._G_plyr_aim_x"]=_GT_aim_protex_main._G_plyr_aim_x
_funcs["_GT_aim_protex_main._G_plyr_aim_y"]=_GT_aim_protex_main._G_plyr_aim_y
_funcs["_GT_gta_map.hotkey_set_feat"]= _GT_gta_map.hotkey_set_feat
_funcs["_GT_gta_map.hotkey1_select"]= _GT_gta_map.hotkey1_select
_funcs["_GT_gta_map.hotkey2_select"]= _GT_gta_map.hotkey2_select
_funcs["_GT_gta_map.hotkey3_select"]= _GT_gta_map.hotkey3_select
_funcs["_GT_gta_map.map_feat"]= _GT_gta_map.map_feat
_funcs["_GT_gta_map.map1_alpha_feat"]= _GT_gta_map.map1_alpha_feat
_funcs["_GT_gta_map.map1_size"]= _GT_gta_map.map1_size
_funcs["_GT_gta_map.map2_alpha_feat"]= _GT_gta_map.map2_alpha_feat
_funcs["_GT_gta_map.map2_size"]= _GT_gta_map.map2_size
_funcs["_GT_gta_map.plyr1_alpha_feat"]= _GT_gta_map.plyr1_alpha_feat
_funcs["_GT_gta_map.plyr1_name"]= _GT_gta_map.plyr1_name
_funcs["_GT_gta_map.plyr1_name_size"]= _GT_gta_map.plyr1_name_size
_funcs["_GT_gta_map.plyr1_size"]= _GT_gta_map.plyr1_size
_funcs["_GT_gta_map.plyr2_alpha_feat"]= _GT_gta_map.plyr2_alpha_feat
_funcs["_GT_gta_map.plyr2_name"]= _GT_gta_map.plyr2_name
_funcs["_GT_gta_map.plyr2_name_size"]= _GT_gta_map.plyr2_name_size
_funcs["_GT_gta_map.plyr2_size"]= _GT_gta_map.plyr2_size
_funcs["_GT_gta_map.pos1_x"]= _GT_gta_map.pos1_x
_funcs["_GT_gta_map.pos1_y"]= _GT_gta_map.pos1_y
_funcs["_GT_gta_map.pos2_x"]= _GT_gta_map.pos2_x
_funcs["_GT_gta_map.pos2_y"]= _GT_gta_map.pos2_y
_funcs["_GT_gta_map.type1_feat"]= _GT_gta_map.type1_feat
_funcs["_GT_gta_map.type2_feat"]= _GT_gta_map.type2_feat
_funcs["_GT_veh_esp_table.feat"]=_GT_veh_esp_table.feat
_funcs["_GT_veh_esp_table.vis"]=_GT_veh_esp_table.vis
_funcs["_GT_veh_esp_table.dist"]=_GT_veh_esp_table.dist
_funcs["_GT_veh_esp_table.show_plyr_name"]=_GT_veh_esp_table.show_plyr_name
_funcs["_GT_veh_esp_table.text_vis"]=_GT_veh_esp_table.text_vis
_funcs["_GT_veh_esp_table.text_size"]=_GT_veh_esp_table.text_size
_funcs["_GT_veh_esp_table.dist_type"]=_GT_veh_esp_table.dist_type
_funcs["_GT_veh_esp_table.blip_size"]=_GT_veh_esp_table.blip_size
_funcs["_GT_veh_esp_table.blip_size_dist"]=_GT_veh_esp_table.blip_size_dist
_funcs["_GT_veh_esp_table.show_veh_name"]=_GT_veh_esp_table.show_veh_name
_funcs["_GT_veh_esp_table.show_veh_pssngr"]=_GT_veh_esp_table.show_veh_pssngr
_funcs["_GT_veh_esp_table.show_veh_dist"]=_GT_veh_esp_table.show_veh_dist
_funcs["_GT_veh_esp_table.show_veh_prsnl"]=_GT_veh_esp_table.show_veh_prsnl
_funcs["_GT_veh_esp_table.show_veh_god"]=_GT_veh_esp_table.show_veh_god
_funcs["_GT_veh_esp_table.show_veh_crrnt"]=_GT_veh_esp_table.show_veh_crrnt
_funcs["_GT_veh_esp_table.text_space"]=_GT_veh_esp_table.text_space
_funcs["_GT_veh_esp_table.text_r"]=_GT_veh_esp_table.text_r
_funcs["_GT_veh_esp_table.text_g"]=_GT_veh_esp_table.text_g
_funcs["_GT_veh_esp_table.text_b"]=_GT_veh_esp_table.text_b
_funcs["_GT_veh_esp_table.line_feat"]=_GT_veh_esp_table.line_feat
_funcs["_GT_veh_esp_table.line_show_for"]=_GT_veh_esp_table.line_show_for
_funcs["_GT_veh_esp_table.line_near_dist"]=_GT_veh_esp_table.line_near_dist
_funcs["_GT_veh_esp_table.line_near_r"]=_GT_veh_esp_table.line_near_r
_funcs["_GT_veh_esp_table.line_near_g"]=_GT_veh_esp_table.line_near_g
_funcs["_GT_veh_esp_table.line_near_b"]=_GT_veh_esp_table.line_near_b
_funcs["_GT_veh_esp_table.line_near_a"]=_GT_veh_esp_table.line_near_a
_funcs["_GT_veh_esp_table.line_far_r"]=_GT_veh_esp_table.line_far_r
_funcs["_GT_veh_esp_table.line_far_g"]=_GT_veh_esp_table.line_far_g
_funcs["_GT_veh_esp_table.line_far_b"]=_GT_veh_esp_table.line_far_b
_funcs["_GT_veh_esp_table.line_far_a"]=_GT_veh_esp_table.line_far_a
_funcs["_GT_veh_esp_table.line_frnd_r"]=_GT_veh_esp_table.line_frnd_r
_funcs["_GT_veh_esp_table.line_frnd_g"]=_GT_veh_esp_table.line_frnd_g
_funcs["_GT_veh_esp_table.line_frnd_b"]=_GT_veh_esp_table.line_frnd_b
_funcs["_GT_veh_esp_table.line_frnd_a"]=_GT_veh_esp_table.line_frnd_a
_funcs["_GT_veh_esp_table.line_self_r"]=_GT_veh_esp_table.line_self_r
_funcs["_GT_veh_esp_table.line_self_g"]=_GT_veh_esp_table.line_self_g
_funcs["_GT_veh_esp_table.line_self_b"]=_GT_veh_esp_table.line_self_b
_funcs["_GT_veh_esp_table.line_self_a"]=_GT_veh_esp_table.line_self_a
_funcs["_G_ff_auto_kick"]=_G_ff_auto_kick
_funcs["_G_auto_re_kick"]=_G_auto_re_kick
_funcs["_GT_gta_map.map1_zoom"]=_GT_gta_map.map1_zoom
_funcs["_GT_gta_map.map2_zoom"]=_GT_gta_map.map2_zoom
_funcs["_G_mk2_invrtd.feat"]=_G_mk2_invrtd.feat
_funcs["_G_mk2_invrtd.brakes"]=_G_mk2_invrtd.brakes
_funcs["_G_mk2_invrtd.boost"]=_G_mk2_invrtd.boost
_funcs["_G_mk2_invrtd.pitch"]=_G_mk2_invrtd.pitch
_funcs["_G_mk2_invrtd.roll"]=_G_mk2_invrtd.roll
_funcs["_G_mk2_invrtd.yaw"]=_G_mk2_invrtd.yaw
_funcs["_G_mk2_invrtd.pitch_speed"]=_G_mk2_invrtd.pitch_speed
_funcs["_G_mk2_invrtd.roll_speed"]=_G_mk2_invrtd.roll_speed
_funcs["_G_mk2_invrtd.yaw_speed"]=_G_mk2_invrtd.yaw_speed
_funcs["_GT_gta_map.z1"]=_GT_gta_map.z1
_funcs["_GT_gta_map.head1_alpha_feat"]=_GT_gta_map.head1_alpha_feat
_funcs["_GT_gta_map.head1_size"]=_GT_gta_map.head1_size
_funcs["_GT_gta_map.z2"]=_GT_gta_map.z2
_funcs["_GT_gta_map.head2_alpha_feat"]=_GT_gta_map.head2_alpha_feat
_funcs["_GT_gta_map.head2_size"]=_GT_gta_map.head2_size
_funcs["_GT_gta_map.full_math_x"]=_GT_gta_map.full_math_x
_funcs["_GT_gta_map.full_math_y"]=_GT_gta_map.full_math_y
_funcs["_GT_gta_map.qrtr_math_x"]=_GT_gta_map.qrtr_math_x
_funcs["_GT_gta_map.qrtr_math_y"]=_GT_gta_map.qrtr_math_y
_funcs["_GT_gta_map.cntr_math_x"]=_GT_gta_map.cntr_math_x
_funcs["_GT_gta_map.cntr_math_y"]=_GT_gta_map.cntr_math_y
_funcs["_GT_gta_map.othr_math_x"]=_GT_gta_map.othr_math_x
_funcs["_GT_gta_map.othr_math_y"]=_GT_gta_map.othr_math_y
_funcs["_GT_gta_map.cp_math_x"]=_GT_gta_map.cp_math_x
_funcs["_GT_gta_map.cp_math_y"]=_GT_gta_map.cp_math_y
_funcs["_GT_gta_map.cp_cmpnd_math_x"]=_GT_gta_map.cp_cmpnd_math_x
_funcs["_GT_gta_map.cp_cmpnd_math_y"]=_GT_gta_map.cp_cmpnd_math_y
_funcs["_GT_veh_esp_table.god_x"]=_GT_veh_esp_table.god_x
_funcs["_GT_veh_esp_table.god_y"]=_GT_veh_esp_table.god_y
_funcs["_GT_veh_esp_table.text_jstfctn"]=_GT_veh_esp_table.text_jstfctn
_funcs["_GT_veh_esp_table.text_from_top"]=_GT_veh_esp_table.text_from_top
_funcs["_GT_veh_esp_table.text_x"]=_GT_veh_esp_table.text_x
_funcs["_GT_veh_esp_table.text_y"]=_GT_veh_esp_table.text_y
_funcs["_GT_veh_esp_table.text_r"]=_GT_veh_esp_table.text_r
_funcs["_GT_veh_esp_table.text_g"]=_GT_veh_esp_table.text_g
_funcs["_GT_veh_esp_table.text_b"]=_GT_veh_esp_table.text_b
_funcs["_G_veh_xtra_jmp"]=_G_veh_xtra_jmp
_funcs["_G_veh_gun_main.feat"]=_G_veh_gun_main.feat
_funcs["_G_veh_gun_main.type"]=_G_veh_gun_main.type
_funcs["_G_veh_gun_main.spwn_rng"]=_G_veh_gun_main.spwn_rng
_funcs["_G_veh_gun_main.safe_zone"]=_G_veh_gun_main.safe_zone
_funcs["_G_veh_gun_main.delay"]=_G_veh_gun_main.delay
_funcs["_G_veh_gun_main.select"]=_G_veh_gun_main.select
_funcs["_G_veh_gun_main.veh_speed"]=_G_veh_gun_main.veh_speed
_funcs["_G_rmv_trblnc"]=_G_rmv_trblnc
_funcs["_G_invncbl_wndows"]=_G_invncbl_wndows
_funcs["_G_max_tint"]=_G_max_tint
_funcs["_G_auto_veh_rpr"]=_G_auto_veh_rpr
_funcs["_G_LOS_.feat"]=_G_LOS_.feat
_funcs["_G_LOS_.sort_by"]=_G_LOS_.sort_by
_funcs["_G_LOS_.sort_drctn"]=_G_LOS_.sort_drctn
_funcs["_G_LOS_.dist_type"]=_G_LOS_.dist_type
_funcs["_G_LOS_.size"]=_G_LOS_.size
_funcs["_G_LOS_.x"]=_G_LOS_.x
_funcs["_G_LOS_.y"]=_G_LOS_.y
_funcs["_G_LOS_.back_a"]=_G_LOS_.back_a
_funcs["_G_LOS_.text_a"]=_G_LOS_.text_a
_funcs["_G_plyr_veh_auto_repair"]=_G_plyr_veh_auto_repair
_funcs["_GT_sssn_stf.hrn_bst_feat"]=_GT_sssn_stf.hrn_bst_feat
_funcs["_GT_sssn_stf.hold.rpr"]=_GT_sssn_stf.hold.rpr
_funcs["_GT_sssn_stf.hold.upgrd"]=_GT_sssn_stf.hold.upgrd
_funcs["_GT_sssn_stf.hold.dstry"]=_GT_sssn_stf.hold.dstry
_funcs["_GT_sssn_stf.hold.time"]=_GT_sssn_stf.hold.time
_funcs["_GT_sssn_stf.hold.show_in_use"]=_GT_sssn_stf.hold.show_in_use
_funcs["_GT_sssn_stf.hold.upgrd_key"]=_GT_sssn_stf.hold.upgrd_key
_funcs["_GT_sssn_stf.hold.rpr_key"]=_GT_sssn_stf.hold.rpr_key
_funcs["_GT_sssn_stf.hold.dstry_key"]=_GT_sssn_stf.hold.dstry_key
_funcs["_G_ldrbrd.feat"]=_G_ldrbrd.feat
_funcs["_G_ldrbrd.show_last"]=_G_ldrbrd.show_last
_funcs["_G_ldrbrd.sort_by"]=_G_ldrbrd.sort_by
_funcs["_G_ldrbrd.sort_drctn"]=_G_ldrbrd.sort_drctn
_funcs["_G_ldrbrd.size"]=_G_ldrbrd.size
_funcs["_G_ldrbrd.x"]=_G_ldrbrd.x
_funcs["_G_ldrbrd.y"]=_G_ldrbrd.y
_funcs["_G_ldrbrd.back_a"]=_G_ldrbrd.back_a
_funcs["_G_ldrbrd.text_a"]=_G_ldrbrd.text_a
_funcs["_G_never_ped_fire"]=_G_never_ped_fire
_funcs["_GT_clear_stuff.range_feat"]=_GT_clear_stuff.range_feat
_funcs["_GT_clear_stuff.peds"]=_GT_clear_stuff.peds
_funcs["_GT_clear_stuff.obj"]=_GT_clear_stuff.obj
_funcs["_GT_clear_stuff.veh"]=_GT_clear_stuff.veh
_funcs["_GT_clear_stuff.prsnl"]=_GT_clear_stuff.prsnl
_funcs["_GT_clear_stuff.prvs"]=_GT_clear_stuff.prvs
_funcs["_GT_clear_stuff.frnds"]=_GT_clear_stuff.frnds
_funcs["_GT_clear_stuff.orgmc"]=_GT_clear_stuff.orgmc
_funcs["_GT_gta_map.all_math_x"]=_GT_gta_map.all_math_x
_funcs["_GT_gta_map.all_math_y"]=_GT_gta_map.all_math_y
_funcs["_GT_gw_ntr.veh_hlth"]=_GT_gw_ntr.veh_hlth
_funcs["_GT_gw_ntr.veh_speed"]=_GT_gw_ntr.veh_speed
_funcs["_GT_gw_ntr.veh_weap"]=_GT_gw_ntr.veh_weap
_funcs["_GT_gw_ntr.ped_hlth"]=_GT_gw_ntr.ped_hlth
_funcs["_GT_gw_ntr.ped_speed"]=_GT_gw_ntr.ped_speed
_funcs["_GT_gw_ntr.ped_weap"]=_GT_gw_ntr.ped_weap
_funcs["_G_GeeWatchNtr_key"]=_G_GeeWatchNtr_key
-- function _GF_add_to_save_load(_feat_str,_feat) --thought of this after i had hundreds on the list
	-- _funcs_name[#_funcs_name+1]=_feat_str
	-- _funcs[_feat_str]=_feat
-- end






--local failed_count = 0
local load_count = 0

local _type_bool={}
_type_bool[1]=true 		-- toggle

local _type_value = {}
_type_value[518]=true	--action_slider
_type_value[522]=true	--action_value_i
_type_value[546]=true	--action_value_str
_type_value[642]=true	--action_value_f
_type_value[1030]=true	--autoaction_slider
_type_value[1034]=true	--autoaction_value_i
_type_value[1058]=true	--autoaction_value_str
_type_value[1154]=true	--autoaction_value_f

local _type_both = {}
_type_both[7]=true	 	--slider 	toggle
_type_both[11]=true 	--value_i 	toggle
_type_both[35]=true 	--value_str toggle
_type_both[131]=true	--value_f 	toggle


function _G_wt_func_state(__func)
    return tostring(__func.on)
end

function string:_G_split(sep)
    local sep, fields = sep or "\t", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function _G_count_loaded_func(func,state)
	if _funcs[func] ~= nil then
		if (tostring(state)=='true' or tostring(state)=='false') then
			return true
			--if _funcs[func].value == nil then num_loaded=num_loaded+1 else num_loaded=num_loaded+.5	end
		elseif _funcs[func].value ~= nil then
			return true
			--num_loaded=num_loaded+1
		end
    end
	return false
end


function _G_run_func(func,state)
	--_G_count_loaded_func(func,state)
	if _funcs[func] == nil then
		print("Invalid entry in config file: "..tostring(func).." = "..tostring(state))
		menu.notify("Invalid entry in config file:\n"..tostring(func).." = "..tostring(state).."\nError will be fixed after save.", _G_GeeVer, 10, 2)
		--failed_count=failed_count+1
	elseif tostring(state)=='true' then
        _funcs[func].on=true
	elseif tostring(state)=='false' then
        _funcs[func].on=false
    elseif _funcs[func].value == nil then
		print("Invalid entry in config file: "..tostring(func).." = "..tostring(state))
		menu.notify("Invalid entry in config file:\n"..tostring(func).." = "..tostring(state).."\nError will be fixed after save.", _G_GeeVer, 10, 2)
		--failed_count=failed_count+1
	else
		_funcs[func].value=tonumber(state)
    end
end



_G_save_options=menu.add_feature("Save Settings", "action", parent.id, function(a)
	local need_write_msg=''
	local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg","w")
	local _type,_bool,_name
	table.sort(_funcs_name, function(a, b) return a:lower() <  b:lower() end)
	for i=1,#_funcs_name do
		if _funcs[_funcs_name[i]] == nil or _funcs[_funcs_name[i]].type == nil then
			print("Invalid entry in save table\n"..tostring(_funcs_name[i]))
			menu.notify("Invalid entry in save table:\n"..tostring(_funcs_name[i]).."\nContact dev.", _G_GeeVer, 10, 2)
		else
			_type = _funcs[_funcs_name[i]].type
			_bool = _G_wt_func_state(_funcs[_funcs_name[i]])
			_name = _funcs_name[i]
			_value = _funcs[_name].value
			print(_name.." type: ".._type)
			if _type_both[_type] then
				if need_write_msg~='' then need_write_msg=need_write_msg..'\n' end
				need_write_msg=need_write_msg.._name..'='.._bool..'\n'.._name..'='.._value
			elseif _type_value[_type] then
				if need_write_msg~='' then need_write_msg=need_write_msg..'\n' end
				need_write_msg=need_write_msg.._name..'='.._value
			elseif _type_bool[_type] then
				if need_write_msg~='' then need_write_msg=need_write_msg..'\n' end
				need_write_msg=need_write_msg.._name..'='.._bool
			else
				print("Invalid entry in save table  -  type: "..tostring(_type).." bool: "..tostring(_bool).." name: "..tostring(_name).." value: "..tostring(_value))
				menu.notify("Invalid entry in save table\n".."type: "..tostring(_type).." bool: "..tostring(_bool).." name: "..tostring(_name).." value: "..tostring(_value).."", _G_GeeVer, 10, 2)
			end
		end
	end
	file:write(need_write_msg)
	file:close()
	menu.notify("Save completed",_G_GeeVer,4,6)
end)

_G_run_options=menu.add_feature("Load Settings", "action", parent.id, function(a)
	local one_line = {}
	local temp = nil
	if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg") then
		local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\GeeSkid\\GeeSkid_Settings.cfg","r")
		for i in file:lines() do
			one_line = i:_G_split('=')
			--_G_run_func(i:_G_split('=')[1],i:_G_split('=')[2])
			_G_run_func(one_line[1],one_line[2])
			if _G_count_loaded_func(one_line[1],one_line[2]) then
				if temp ~= one_line[1] then
					temp = one_line[1]
					load_count=load_count+1
				-- else
					-- menu.notify(tostring(one_line[1]).." = "..tostring(one_line[2]),_G_GeeVer,4,6)
				end
			end
		end
		file:close()
		menu.notify(load_count.."/"..#_funcs_name.." Settings loaded",_G_GeeVer,4,6)
	else
		menu.notify("Config file not found",_G_GeeVer,4,6)
	end
	--failed_count = 0
	load_count = 0
	_G_on_start_splash.on=true
	system.yield(1000) 
	_GT_veh_esp_table.math_do()
	_G_GS_has_loaded=true
end)
_G_run_options.on=true


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
