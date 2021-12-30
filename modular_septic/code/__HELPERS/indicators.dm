/proc/get_typing_indicator()
	var/image/I = image(icon = 'modular_septic/icons/mob/indicators.dmi', icon_state = "typing", layer = FLOAT_LAYER)
	I.plane = FLOAT_PLANE
	return I

/proc/get_ssd_indicator()
	var/image/I = image(icon = 'modular_septic/icons/mob/indicators.dmi', icon_state = "ssd", layer = FLOAT_LAYER)
	I.plane = FLOAT_PLANE
	return I
