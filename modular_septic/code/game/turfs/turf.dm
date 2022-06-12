/turf/Initialize(mapload)
	. = ..()
	initialize_clinging()

/turf/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	if(user.z != src.z)
		return SCREENTIP_OPENSPACE("OPEN SPACE")
	else
		return SCREENTIP_TURF(uppertext(name))

/turf/handle_fall(mob/faller)
	if(!faller.mob_has_gravity())
		return
	playsound(src, "modular_septic/sound/effects/collapse[rand(1,5)].wav", 50, TRUE)
	sound_hint()
	SEND_SIGNAL(src, COMSIG_TURF_MOB_FALL, faller)

/turf/air_update_turf(update = FALSE, remove = FALSE)
	. = ..()
	liquid_update_turf()

/turf/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_ground[rand(1,5)].wav"

/turf/proc/initialize_clinging()
	if(clingable)
		AddElement(/datum/element/clingable, SKILL_ACROBATICS, 10, clinging_sound)
		return TRUE
	return FALSE
