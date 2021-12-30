/datum/controller/subsystem/job
	chain_of_command = list(
		"Doge" = 1,
		"Gatekeeper" = 2,
		"Coordinator" = 3
	)

/datum/controller/subsystem/job/setup_officer_positions()
	return

/datum/controller/subsystem/job/EquipRank(mob/living/equipping, datum/job/job, client/player_client)
	equipping.job = job.title

	SEND_SIGNAL(equipping, COMSIG_JOB_RECEIVED, job)

	equipping.mind?.set_assigned_role(job)

	if(player_client)
		var/introduction = span_infoplain("<b>I am the [job.title].</b>")
		var/YYYY = GLOB.current_station_year // current year (numeric)
		var/DD = text2num(time2text(world.realtime, "DD")) //  current day (numeric)
		var/month = lowertext(time2text(world.realtime, "Month")) // current month (text)
		var/day = lowertext(time2text(world.realtime, "Day")) // current weekday (text)
		introduction += span_infoplain("\nToday is the [DD][st_nd_rd_th(DD)] of [month] of [YYYY]. It is [prefix_a_or_an(day)] [day].")
		to_chat(player_client, introduction)

	equipping.on_job_equipping(job)

	job.announce_job(equipping)

	if(player_client?.holder)
		if(CONFIG_GET(flag/auto_deadmin_players) || (player_client.prefs?.toggles & DEADMIN_ALWAYS))
			player_client.holder.auto_deadmin()
		else
			handle_auto_deadmin_roles(player_client, job.title)

	job.radio_help_message(equipping)

	if(ishuman(equipping))
		var/mob/living/carbon/human/wageslave = equipping
		wageslave.mind.add_memory(MEMORY_ACCOUNT, list(DETAIL_ACCOUNT_ID = wageslave.account_id), story_value = STORY_VALUE_SHIT, memory_flags = MEMORY_FLAG_NOLOCATION)

	job.after_spawn(equipping, player_client)

/atom/JoinPlayerHere(mob/M, buckle)
	. = ..()
	if(M.attributes)
		//update the hud please
		M.attributes.update_attributes()
