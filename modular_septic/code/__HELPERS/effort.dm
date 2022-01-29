/proc/setup_efforts()
	. = list()
	for(var/thing in init_subtypes(/datum/effort))
		var/datum/effort/effort = thing
		.[effort.type] = effort
