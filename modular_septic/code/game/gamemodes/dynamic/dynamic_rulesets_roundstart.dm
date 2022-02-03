/datum/dynamic_ruleset/roundstart/deathmatch
	name = "Deathmatch"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/deathmatch/pre_execute()
	. = ..()
	message_admins("Starting a round of DEATHMATCH!")
	log_game("Starting a round of DEATHMATCH!")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: Deathmatch ruleset set threat to 0."
	SSdeathmatch.flags &= ~SS_NO_FIRE
	if(!SSdeathmatch.initialized)
		SSdeathmatch.Initialize(REALTIMEOFDAY)
	return TRUE
