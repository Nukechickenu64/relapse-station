/proc/setup_wield_info()
	. = list()
	for(var/thing in init_subtypes(/datum/wield_info))
		var/datum/wield_info/wield_info = thing
		.[wield_info.type] = wield_info
