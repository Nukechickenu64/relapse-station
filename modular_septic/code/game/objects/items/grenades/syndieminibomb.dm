/obj/item/grenade/frag
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "frag"

/obj/item/grenade/frag/impact
	name = "impact grenade"
	desc = "A concussive grenade that is designed to detonate on thrown impact. Will not explode when dropped, or placed."
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "impactgrenade"
	shrapnel_type = null
	det_time = 3
	ex_heavy = 0
	ex_light = 3
	ex_flame = 2

/obj/item/grenade/frag/impact/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	log_grenade(user)
	if(user)
		add_fingerprint(user)
		if(msg)
			to_chat(user, span_warning("I prime [src]! [capitalize(DisplayTimeText(det_time))]!"))
	if(shrapnel_type && shrapnel_radius)
		shrapnel_initialized = TRUE
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
	playsound(src, pin_sound, volume, TRUE)
	if(istype(user))
		user.mind?.add_memory(MEMORY_BOMB_PRIMED, list(DETAIL_BOMB_TYPE = src), story_value = STORY_VALUE_OKAY)
	active = TRUE
	icon_state = "[initial(icon_state)]_active"

/obj/item/grenade/frag/impact/after_throw(mob/user, silent = FALSE)
	. = ..()
	if(active)
		SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time)
		addtimer(CALLBACK(src, .proc/detonate), 3)


/obj/item/grenade/frag/pipebomb
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "ted"
	pin_sound = 'modular_septic/sound/effects/flare_start.wav'
	pickup_sound = null

/obj/item/grenade/frag/pipebomb/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_notice("You try prying [src] off your hand..."))
		if(do_after(user, 7 SECONDS, target=src))
			to_chat(user, span_notice("You manage to remove [src] from your hand."))
			REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		return

/obj/item/grenade/frag/pipebomb/attackby(obj/item/I, mob/user, params)
	if(I.get_temperature() && !active)
		if(!botch_check(user)) // if they botch the prime, it'll be handled in botch_check
			arm_grenade(user)
			to_chat(user, span_info("You light the fuse on the [src]"))
			icon_state = "ted_lit"
			log_bomber(user, "seems to be committing an act of intellectual anprim genocide!")
