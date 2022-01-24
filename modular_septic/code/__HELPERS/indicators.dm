/proc/get_typing_indicator()
	var/image/indicator = image(icon = 'modular_septic/icons/mob/indicators.dmi', icon_state = "typing", layer = FLOAT_LAYER)
	indicator.plane = FLOAT_PLANE
	return indicator

/proc/get_ssd_indicator()
	var/image/indicator = image(icon = 'modular_septic/icons/mob/indicators.dmi', icon_state = "ssd", layer = FLOAT_LAYER)
	indicator.plane = FLOAT_PLANE
	return indicator
