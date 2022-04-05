/datum/dynamic_ruleset/roundstart/efn
	name = "Escape from Nevado"
	antag_flag = null
	antag_datum = null
	restricted_roles = list("Begger", "Innkeeper", "Seeder", "Doge", \
							"Freighter", "Pharmacist", "Foreman", "Hippocrite", "Jester", "Gatekeeper", \
							"Coordinator", "Humorist", "Sanitar", "Merchant", "Technocrat", "Technologist", "Pioneer", "Mechanist")
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/efn/pre_execute()
	. = ..()
	message_admins("Starting a round of Escape from Nevado!")
	log_game("Starting a round of Escape from Nevado.")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: Escape from Nevado ruleset set threat to 0."
	SSdeathmatch.flags &= ~SS_NO_FIRE
	if(!SSdeathmatch.initialized)
		SSdeathmatch.Initialize(REALTIMEOFDAY)
	return TRUE
