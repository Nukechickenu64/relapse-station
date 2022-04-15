/proc/setup_surgery_steps()
	. = list()
	for(var/datum/surgery_step/surgery_step as anything in init_subtypes(/datum/surgery_step))
		if(!surgery_step.name)
			qdel(surgery_step)
			continue
		qdel(surgery_step)
