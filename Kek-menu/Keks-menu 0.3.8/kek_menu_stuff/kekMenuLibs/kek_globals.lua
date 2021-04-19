-- Lib kek_globals version: 1.1.2
-- A simple library for reading useful globals
-- Copyright (c) 2020, Sainan.de
-- Updated by kektram#8996
-- Huge thanks to QuickNET#9999 for the offsets and help in understanding how it works!

local globals = {}

local offsets = {
	["_PLAYER_INFO_MAIN"] = 1590682,
	["_PLAYER_INFO_OFFSET_PER_PLAYER"] = 883,
	["_PLAYER_INFO_OFFSET_TO_INFO"] = 211
}

local stats = {
	["_PLAYER_INFO_WALLET"] = 3,
	["_PLAYER_INFO_RANK"] = 6,
	["_PLAYER_INFO_KD"] = 26,
	["_PLAYER_INFO_KILLS"] = 28,
	["_PLAYER_INFO_DEATHS"] = 29,
	["_PLAYER_INFO_TOTALMONEY"] = 56,                                                            
	["_PLAYER_INFO_TOTAL_RACES_WON"] = 15,                              
	["_PLAYER_INFO_TOTAL_RACES_LOST"] = 16,                             
	["_PLAYER_INFO_TIMES_FINISH_RACE_TOP_3"] = 17,                      
	["_PLAYER_INFO_TIMES_FINISH_RACE_LAST"] = 18,                       
	["_PLAYER_INFO_TIMES_RACE_BEST_LAP"] = 19,                          
	["_PLAYER_INFO_TOTAL_DEATHMATCH_WON"] = 20,                         
	["_PLAYER_INFO_TOTAL_DEATHMATCH_LOST"] = 21,                        
	["_PLAYER_INFO_TOTAL_TDEATHMATCH_WON"] = 22,                        
	["_PLAYER_INFO_TOTAL_TDEATHMATCH_LOST"] = 23,                       
	["_PLAYER_INFO_TIMES_FINISH_DM_TOP_3"] = 30,                        
	["_PLAYER_INFO_TIMES_FINISH_DM_LAST"] = 31,                         
	["_PLAYER_INFO_DARTS_TOTAL_WINS"] = 32,                             
	["_PLAYER_INFO_DARTS_TOTAL_MATCHES"] = 33,                          
	["_PLAYER_INFO_ARMWRESTLING_TOTAL_WINS"] = 34,                      
	["_PLAYER_INFO_ARMWRESTLING_TOTAL_MATCH"] = 35,                     
	["_PLAYER_INFO_TENNIS_MATCHES_WON"] = 36,                           
	["_PLAYER_INFO_TENNIS_MATCHES_LOST"] = 37,                          
	["_PLAYER_INFO_BJ_WINS"] = 38,                                      
	["_PLAYER_INFO_BJ_LOST"] = 39,                                      
	["_PLAYER_INFO_GOLF_WINS"] = 40,                                    
	["_PLAYER_INFO_GOLF_LOSSES"] = 41,                                  
	["_PLAYER_INFO_SHOOTINGRANGE_WINS"] = 42,                           
	["_PLAYER_INFO_SHOOTINGRANGE_LOSSES"] = 43,                         
	["_PLAYER_INFO_Unknown_stat"] = 44,                                       
	["_PLAYER_INFO_HORDEWINS"] = 47,                                    
	["_PLAYER_INFO_CRHORDE"] = 48,                                      
	["_PLAYER_INFO_MCMWIN"] = 45,                                       
	["_PLAYER_INFO_CRMISSION"] = 46,                                    
	["_PLAYER_INFO_MISSIONS_CREATED"] = 50,                             
	["_PLAYER_INFO_DROPOUTRATE"] = 27,                                  
	["_PLAYER_INFO_MOST_FAVORITE_STATION"] = 53
}
function globals.get_player_info_offset(pid, info_offset)
	return offsets._PLAYER_INFO_MAIN + (1 + (pid * offsets._PLAYER_INFO_OFFSET_PER_PLAYER)) + offsets._PLAYER_INFO_OFFSET_TO_INFO + info_offset
end
function globals.get_player_info_i(pid, info_offset)
	return script.get_global_i(globals.get_player_info_offset(pid, info_offset))
end
function globals.get_player_info_f(pid, info_offset)
	return script.get_global_f(globals.get_player_info_offset(pid, info_offset))
end

-- Stats
	function globals.get_all_stats(pid)
		local STATS = {}
		for i = 1, offsets._PLAYER_INFO_OFFSET_PER_PLAYER do
			STATS[i] =  globals.get_player_info_i(pid, i)
		end
		return STATS
	end

	function globals.get_player_deaths(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_DEATHS)
	end

	function globals.get_player_dart_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_DARTS_TOTAL_WINS)
	end

	function globals.get_player_dart_matches(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_DARTS_TOTAL_MATCHES)
	end

	function globals.get_player_arm_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_ARMWRESTLING_TOTAL_WINS)
	end

	function globals.get_player_arm_matches(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_ARMWRESTLING_TOTAL_MATCH)
	end

	function globals.get_player_tennis_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TENNIS_MATCHES_WON)
	end

	function globals.get_player_tennis_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TENNIS_MATCHES_LOST)
	end

	function globals.get_player_BJ_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_BJ_WINS)
	end

	function globals.get_player_bj_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_BJ_LOST)
	end

	function globals.get_player_golf_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_GOLF_WINS)
	end

	function globals.get_player_golf_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_GOLF_LOSSES)
	end

	function globals.get_player_golf_winrate(pid)
		return globals.get_player_golf_wins(pid) / globals.get_player_golf_losses(pid)
	end

	function globals.get_player_shoot_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_SHOOTINGRANGE_WINS)
	end

	function globals.get_player_shoot_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_SHOOTINGRANGE_LOSSES)
	end

	function globals.get_player_unknown_stat(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_Unknown_stat)
	end

	function globals.get_player_horde_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_HORDEWINS)
	end

	function globals.get_player_c_horde(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_CRHORDE)
	end

	function globals.get_player_mc_win(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_MCMWIN)
	end

	function globals.get_player_cr_mission(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_CRMISSION)
	end

	function globals.get_player_missions_created(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_MISSIONS_CREATED)
	end

	function globals.get_player_drop_out_rate(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_DROPOUTRATE)
	end

	function globals.get_player_favorite_radio_station(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_MOST_FAVORITE_STATION)
	end

	function globals.get_player_team_deathmatch_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_TDEATHMATCH_WON)
	end

	function globals.get_player_team_deathmatch_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_TDEATHMATCH_LOST)
	end

	function globals.get_player_team_deathmatch_winrate(pid)
		return globals.get_player_team_deathmatch_wins(pid) / globals.get_player_team_deathmatch_losses(pid)
	end

	function globals.get_player_deathmatch_top3(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TIMES_FINISH_DM_TOP_3)
	end

	function globals.get_player_deathmatch_last(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TIMES_FINISH_DM_LAST)
	end

	function globals.get_player_race_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_RACES_WON)
	end

	function globals.get_player_race_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_RACES_LOST)
	end

	function globals.get_player_race_winrate(pid)
		return globals.get_player_race_wins(pid) / globals.get_player_race_losses(pid)
	end

	function globals.get_player_race_top3(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TIMES_FINISH_RACE_TOP_3)
	end

	function globals.get_player_race_last(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TIMES_FINISH_RACE_LAST)
	end

	function globals.get_player_race_best_laps(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TIMES_RACE_BEST_LAP)
	end

	function globals.get_player_deathmatch_wins(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_DEATHMATCH_WON)
	end

	function globals.get_player_deathmatch_losses(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTAL_DEATHMATCH_LOST)
	end

	function globals.get_player_deathmatch_winrate(pid)
		return globals.get_player_deathmatch_wins(pid) / globals.get_player_deathmatch_losses(pid)
	end

	function globals.get_player_rank(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_RANK)
	end

	function globals.get_player_money(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_TOTALMONEY)
	end
	function globals.get_player_wallet(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_WALLET)
	end
	function globals.get_player_bank(pid)
		return globals.get_player_money(pid) - globals.get_player_wallet(pid)
	end

	function globals.get_player_kd(pid)
		return globals.get_player_info_f(pid, stats._PLAYER_INFO_KD)
	end
	function globals.get_player_kills(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_KILLS)
	end
	function globals.get_player_deaths(pid)
		return globals.get_player_info_i(pid, stats._PLAYER_INFO_DEATHS)
	end

	function globals.get_player_all_stats(pid)
		return stats
	end

	function globals.is_player_otr(pid)
		return script.get_global_i(2425869 + (1 + (pid * 443)) + 204) == 1
	end

return globals
