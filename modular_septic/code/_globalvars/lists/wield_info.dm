GLOBAL_LIST_INIT(path_to_wield_info, world.setup_wield_info())

/world/proc/setup_wield_info()
	. = list()
	for(var/thing in init_subtypes(/datum/wield_info))
		var/datum/wield_info/wield_info = thing
		.[wield_info.type] = wield_info
