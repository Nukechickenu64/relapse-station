/datum/centcom_announcer
	welcome_sounds = list('modular_septic/sound/round/roundstart.ogg')
	///Roundshift end audio
	var/goodbye_sounds = list('modular_septic/sound/round/roundend.ogg')

/datum/centcom_announcer/proc/valario_hello()
	if(SSmapping.config?.combat_map)
		welcome_sounds = list('modular_septic/sound/valario/roundend.ogg')
		goodbye_sounds = null
