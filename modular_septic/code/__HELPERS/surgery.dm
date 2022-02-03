/proc/setup_surgery_steps()
	. = list()
	for(var/datum/surgery_step/surgery_step as anything in init_subtypes(/datum/surgery_step))
		if(surgery_step.name)
			. += surgery_step
		else
			qdel(surgery_step)
