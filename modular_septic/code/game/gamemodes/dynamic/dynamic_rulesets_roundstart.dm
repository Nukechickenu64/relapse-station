/datum/dynamic_ruleset/roundstart/efn
	name = "Escape from Nevado"
	antag_flag = null
	antag_datum = null
	restricted_roles = list()
	required_candidates = 0
	weight = 0
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	flags = LONE_RULESET

/datum/dynamic_ruleset/roundstart/efn/acceptable(population, threat_level)
	return TRUE

/datum/dynamic_ruleset/roundstart/efn/ready(population, forced)
	return TRUE

/datum/dynamic_ruleset/roundstart/efn/pre_execute()
	. = ..()
	message_admins("Starting a round of Escape from Nevado!")
	log_game("DYNAMIC: Starting a round of Escape from Nevado.")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: Escape from Nevado ruleset set threat to 0."
	var/soundfile = "modular_septic/sound/voice/valario/valario[rand(1,11)].ogg"
	var/sound/valario = sound(soundfile, FALSE, 0, CHANNEL_ADMIN, 100)
	SEND_SOUND(world, valario)
	var/datum/job_department/gaksters/gakster_department
	var/datum/job_department/inborns/inborn_department
	var/datum/job_department/denominators/denominator_department
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		if(istype(department, /datum/job_department/gaksters))
			gakster_department = department
		else if(istype(department, /datum/job_department/inborns))
			inborn_department = department
		else if(istype(department, /datum/job_department/denominators))
			denominator_department = department
		else
			SSjob.joinable_departments -= department
	gakster_department = new /datum/job_department/gaksters()
	inborn_department = new /datum/job_department/inborns()
	denominator_department = new /datum/job_department/denominators()
	SSjob.joinable_departments += gakster_department
	SSjob.joinable_departments_by_type[gakster_department.type] = gakster_department
	SSjob.joinable_departments += inborn_department
	SSjob.joinable_departments_by_type[inborn_department.type] = inborn_department
	SSjob.joinable_departments += denominator_department
	SSjob.joinable_departments_by_type[denominator_department.type] = denominator_department
	for(var/datum/job/job as anything in SSjob.all_occupations)
		if(istype(job, /datum/job/gakster))
			SSjob.name_occupations[job.title] = job
			gakster_department.add_job(job)
			gakster_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 64
			job.spawn_positions = 64
			SSjob.joinable_occupations += job
			SSjob.set_overflow_role(job.title)
		else if(istype(job, /datum/job/denominator))
			SSjob.name_occupations[job.title] = job
			denominator_department.add_job(job)
			denominator_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 0
			job.spawn_positions = 0
			SSjob.joinable_occupations += job
		else if(istype(job, /datum/job/denominator_shotgunner))
			SSjob.name_occupations[job.title] = job
			denominator_department.add_job(job)
			denominator_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 0
			job.spawn_positions = 0
			SSjob.joinable_occupations += job
		else if(istype(job, /datum/job/inborn))
			SSjob.name_occupations[job.title] = job
			inborn_department.add_job(job)
			inborn_department.department_head = job.type
			job.job_flags |= JOB_NEW_PLAYER_JOINABLE
			job.total_positions = 0
			job.spawn_positions = 0
			SSjob.joinable_occupations += job
		else
			SSjob.joinable_occupations -= job
