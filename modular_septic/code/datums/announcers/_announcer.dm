/datum/centcom_announcer
	welcome_sounds = list('modular_septic/sound/round/roundstart.ogg')
	///Roundshift end audio
	var/goodbye_sounds = list('modular_septic/sound/round/roundend.ogg')

/datum/centcom_announcer/proc/get_rand_goodbye_sound()
	if(SSmapping.config?.combat_map)
		return list('modular_septic/sound/valario/roundend.ogg')
	return

/datum/centcom_announcer/get_rand_welcome_sound()
	if(SSmapping.config?.combat_map)
		return null
	return
