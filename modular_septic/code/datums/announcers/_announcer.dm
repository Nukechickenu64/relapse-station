/datum/centcom_announcer
	welcome_sounds = list('modular_septic/sound/round/roundstart.ogg')
	///Roundshift end audio
	var/goodbye_sounds = list('modular_septic/sound/round/roundend.ogg')

/datum/centcom_announcer/proc/get_rand_roundend_sound()
	return pick(goodbye_sounds)
