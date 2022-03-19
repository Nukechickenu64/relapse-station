/turf/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	if(user.z != src.z)
		return SCREENTIP_OPENSPACE("OPEN SPACE")
	else
		return SCREENTIP_TURF(uppertext(name))

/turf/handle_fall(mob/faller)
	if(faller.mob_has_gravity())
		playsound(src, "modular_septic/sound/effects/collapse[rand(1,5)].wav", 50, TRUE)
	SEND_SIGNAL(src, COMSIG_TURF_MOB_FALL, faller)

/turf/handle_atom_del(atom/deleting_atom)
	. = ..()
	if(deleting_atom.opacity && shadowcasting_overlays)
		update_shadowcasting_overlays()

/turf/air_update_turf(update = FALSE, remove = FALSE)
	. = ..()
	liquid_update_turf()

/turf/proc/initialize_clinging()
	if(clingable)
		AddElement(/datum/element/clingable, SKILL_ACROBATICS, 6, clinging_sound)
		return TRUE
	return FALSE
