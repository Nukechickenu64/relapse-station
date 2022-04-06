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

/datum/dynamic_ruleset/roundstart/efn/pre_execute()
	. = ..()
	message_admins("Starting a round of Escape from Nevado!")
	log_game("Starting a round of Escape from Nevado.")
	mode.spend_roundstart_budget(mode.round_start_budget)
	mode.spend_midround_budget(mode.mid_round_budget)
	mode.threat_log += "[worldtime2text()]: Escape from Nevado ruleset set threat to 0."
	to_chat(world, span_syndradio("<b>Prepare to Escape from Nevado</b>"))
	var/soundfiles = "modular_septic/sound/valario/valario[rand(1,11)].ogg"
	var/sound/valario = soundfiles()
	var/datum/job_department/gakster_department
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		if(istype(department, /datum/job_department/gaksters))
			gakster_department = department
		else
			SSjob.joinable_departments -= department
	if(!gakster_department)
		gakster_department = new
		SSjob.joinable_departments |= gakster_department
		SSjob.joinable_departments_by_type[gakster_department.type] = gakster_department
	gakster_department.department_head = SSjob.type_occupations[/datum/job/security_officer]
	gakster_department.department_jobs |= SSjob.type_occupations[/datum/job/security_officer]
	SSjob.joinable_departments |= gakster_department
	SSjob.joinable_departments_by_type[gakster_department.type] = gakster_department
	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		if(istype(job, /datum/job/security_officer))
			job.title = "Gakster Scavenger"
			job.departments_bitflags = NONE
			job.departments_bitflags |= gakster_department.department_bitflags
		else
			SSjob.joinable_occupations -= job
