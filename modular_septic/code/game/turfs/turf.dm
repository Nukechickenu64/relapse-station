/turf/Initialize(mapload)
	. = ..()
	// god has forced me to not put this in /atom/proc/Initialize()
	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon, frill_uses_icon_state, upper_frill_plane, upper_frill_layer, lower_frill_plane, lower_frill_layer)
	initialize_clinging()

/turf/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	if(user.z != src.z)
		return SCREENTIP_OPENSPACE("OPEN SPACE")
	else
		return SCREENTIP_TURF(uppertext(name))

/turf/MouseDropReceive(atom/movable/dropping, mob/living/user)
	. = ..()
	if(density)
		return
	if(!isliving(dropping) || !isliving(user) || !dropping.has_gravity() || \
		!Adjacent(user) || !dropping.Adjacent(user) || user.incapacitated() || \
		(user.body_position == LYING_DOWN) || HAS_TRAIT_FROM(dropping, TRAIT_IMMOBILIZED, CLINGING_TRAIT))
		return
	var/turf/dropping_turf = get_turf(dropping)
	if(!dropping_turf || (dropping_turf == src))
		return
	//Climb down
	if((dropping_turf.turf_height - src.turf_height >= TURF_HEIGHT_BLOCK_THRESHOLD) || (dropping_turf.z > src.z))
		if(user == dropping)
			dropping.visible_message(span_notice("<b>[user]</b> starts descending down to [src]"), \
								span_notice("I start lowering myself to [src]."))
		else
			dropping.visible_message(span_warning("<b>[user]</b> starts lowering <b>[dropping]</b> down to [src]"), \
								span_notice("I start lowering <b>[dropping]</b> down to [src]."))
		if(do_mob(user, dropping, 2 SECONDS))
			dropping.forceMove(src)
		return
	//Climb up
	else if((src.turf_height - dropping_turf.turf_height >= TURF_HEIGHT_BLOCK_THRESHOLD) || isopenspaceturf(dropping_turf))
		if(user == dropping)
			dropping.visible_message(span_notice("<b>[user]</b> starts climbing onto [src]"), \
								span_notice("I start climbing onto [src]."))
		else
			dropping.visible_message(span_warning("<b>[user]</b> starts pulling <b>[dropping]</b> onto [src]"), \
								span_notice("I start pulling <b>[dropping]</b> onto <b>[src]</b>."))
		if(do_mob(user, dropping, 2 SECONDS))
			dropping.forceMove(src)
		return

/turf/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.client.Move(src, get_dir(living_user, src)))
			user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
								span_warning("I crawl on [src]."))

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
