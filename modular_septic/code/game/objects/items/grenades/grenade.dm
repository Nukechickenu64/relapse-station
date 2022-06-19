/obj/item/grenade
	drop_sound = 'modular_septic/sound/weapons/grenade.wav'
	pickup_sound = 'modular_septic/sound/weapons/grenade_draw.wav'
	item_flags = NO_PIXEL_RANDOM_DROP
	tetris_width = 32
	tetris_height = 32
	det_time = 1.2 SECONDS
	/// Sound of the pin/activation sound
	var/pin_sound = 'modular_septic/sound/weapons/grenade_pin.wav'
	/// Sound for when the grenade is deployed
	var/spoon_sound = 'modular_septic/sound/weapons/grenade_spoon.wav'
	/// The pin contained inside of the grenade
	var/obj/item/pin/pin
	/// Determines if the grenade is activated via pin, DEFAULT = TRUE
	var/pinned_activation = TRUE
	/// Determines if the grenade is activated via button, DEFAULT = FALSE
	var/button_activation = FALSE

/obj/item/pin
	name = "grenade pin"
	desc = "The detonation pin of a grenade, usually found on a grenade before It's armed."
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "pin"
	drop_sound = 'modular_septic/sound/items/coin_drop.wav'
	w_class = WEIGHT_CLASS_TINY

/obj/item/grenade/Initialize(mapload)
	. = ..()
	if(pinned_activation)
		pin = new /obj/item/pin(src)

/obj/item/grenade/Destroy()
	. = ..()
	if(!QDELETED(pin))
		qdel(pin)
	pin = null

/obj/item/grenade/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	log_grenade(user)
	if(user)
		add_fingerprint(user)
		if(msg)
			to_chat(user, span_warning("I prime [src]! [capitalize(DisplayTimeText(det_time))]!"))
	if(shrapnel_type && shrapnel_radius)
		shrapnel_initialized = TRUE
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
	playsound(src, pin_sound, volume, FALSE)
	sound_hint()
	if(istype(user))
		user.mind?.add_memory(MEMORY_BOMB_PRIMED, list(DETAIL_BOMB_TYPE = src), story_value = STORY_VALUE_OKAY)
	active = TRUE
	if(!istype(src, /obj/item/grenade/syndieminibomb))
		icon_state = "[initial(icon_state)]_active"
	if(!pinned_activation)
		SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time)
		addtimer(CALLBACK(src, .proc/detonate), det_time)

/obj/item/grenade/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(pinned_activation)
		if(istype(over, /atom/movable/screen/inventory/hand))
			if(!active && pin in src)
				user.transferItemToLoc(pin, user.loc)
				user.put_in_hands(pin)
				arm_grenade(user)
				pin = null
	else
		to_chat(user, span_warning("This grenade doesn't have a pin!"))

/obj/item/grenade/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_notice("You try prying [src] off your hand..."))
		if(do_after(user, 7 SECONDS, target=src))
			to_chat(user, span_notice("You manage to remove [src] from your hand."))
			REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		return

	if(!active && button_activation)
		if(!botch_check(user)) // if they botch the prime, it'll be handled in botch_check
			arm_grenade(user)

/obj/item/grenade/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	. = ..()
	if(!istype(src, /obj/item/grenade/frag/impact) && active && pinned_activation)
		SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time)
		addtimer(CALLBACK(src, .proc/detonate), det_time)
		playsound(src, spoon_sound, 60, FALSE)
		sound_hint()

/obj/item/grenade/frag/impact/after_throw(mob/user, silent = FALSE, volume = 60)
	. = ..()
	if(active && pinned_activation)
		SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time)
		addtimer(CALLBACK(src, .proc/detonate), det_time)
		playsound(src, spoon_sound, volume, FALSE)
		sound_hint()

