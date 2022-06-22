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
	var/obj/item/pin/pin = /obj/item/pin
	/// Grenade type, checks If It's activated through pin, button, or fuse.
	var/grenade_flags = GRENADE_PINNED
	/// Checks if the grenade is spooned, aka, fucked.
	var/grenade_spooned = FALSE
	/// Grenade's default spoon overlay
	var/grenade_spoon_overlay = "spoon_overlay"
	/// Does this grenade have a sound cue when it spoons?
	var/spoon_loud = TRUE
	/// When does this grenade spoon specifically in desciseconds
	var/spoon_time = 0.8

/obj/item/pin
	name = "grenade pin"
	desc = "The detonation pin of a grenade, usually found on a grenade before It's armed."
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "pin"
	drop_sound = 'modular_septic/sound/items/coin_drop.wav'
	w_class = WEIGHT_CLASS_TINY

/obj/item/grenade/Initialize(mapload)
	. = ..()
	if(grenade_flags & GRENADE_VISIBLE_SPOON)
		add_overlay(grenade_spoon_overlay)
	if(grenade_flags & GRENADE_PINNED)
		add_overlay("[initial(icon_state)]_pin")
		pin = new pin(src)

/obj/item/grenade/Destroy()
	. = ..()
	if(!QDELETED(pin))
		qdel(pin)
	pin = null

/obj/item/grenade/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	log_grenade(user)
	if(user)
		add_fingerprint(user)
	if(shrapnel_type && shrapnel_radius)
		shrapnel_initialized = TRUE
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)
	playsound(src, pin_sound, volume, FALSE)
	sound_hint()
	if(istype(user))
		user.mind?.add_memory(MEMORY_BOMB_PRIMED, list(DETAIL_BOMB_TYPE = src), story_value = STORY_VALUE_OKAY)
	active = TRUE
	if(grenade_flags & GRENADE_BUTTONED)
		icon_state = "[initial(icon_state)]_active"
		to_chat(user, span_warning("I press the arming button on the [src]."))
	if(!(grenade_flags & GRENADE_PINNED))
		spoon_grenade()

/obj/item/grenade/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(grenade_flags & GRENADE_PINNED)
		if(istype(over, /atom/movable/screen/inventory/hand))
			if(!active && pin in src)
				user.transferItemToLoc(pin, user.loc)
				user.put_in_hands(pin)
				user.visible_message(span_red("[user] pulls the pin from the [src]!"), \
							span_warning("I pull the pin from the [src]."))
				arm_grenade(user)
				pin = null
				cut_overlay("[initial(icon_state)]_pin")
	else
		to_chat(user, span_warning("This grenade doesn't have a pin!"))

/obj/item/grenade/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_notice("I try prying [src] off your hand..."))
		if(do_after(user, 7 SECONDS, target=src))
			to_chat(user, span_notice("I manage to remove [src] from your hand."))
			REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		return

	if(!active && (grenade_flags & GRENADE_BUTTONED))
		arm_grenade(user)

	if(grenade_spooned)
		var/list/whoopsie_text = GLOB.whoopsie.Copy()
		var/message
		whoopsie_text |= "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		message = pick(whoopsie_text)
		to_chat(user, span_danger("[message]"))
		if(grenade_flags & GRENADE_BUTTONED)
			playsound(user, 'modular_septic/sound/weapons/bomb_toolate.wav', 25, FALSE)
			sound_hint()

/obj/item/grenade/proc/spoon_grenade()
	if(grenade_flags & GRENADE_VISIBLE_SPOON)
		cut_overlay(grenade_spoon_overlay)
	grenade_spooned = TRUE
	if(spoon_loud)
		sound_hint()
		playsound(src, spoon_sound, 60, FALSE)
	SEND_SIGNAL(src, COMSIG_GRENADE_ARMED, det_time)
	addtimer(CALLBACK(src, .proc/detonate), det_time)

/obj/item/grenade/attackby(obj/item/I, mob/user, params)
	if((grenade_flags & GRENADE_FUSED) && I.get_temperature() && !active)
		if(!botch_check(user)) // if they botch the prime, it'll be handled in botch_check
			arm_grenade(user)
			to_chat(user, span_info("I light the fuse on the [src]"))
			icon_state = "[initial(icon_state)]_lit"
			log_bomber(user, "seems to be committing an act of intellectual anprim genocide!")

	if(grenade_flags & GRENADE_PINNED && (I.type == initial(pin)) && active && !grenade_spooned)
		pin = I
		user.transferItemToLoc(I, src, TRUE)
		active = FALSE
		add_overlay("[initial(icon_state)]_pin")
		user.visible_message(span_warning("[user] puts the pin back into the [src]!"), \
					span_warning("I put the pin back into the [src]."))
		playsound(I, 'modular_septic/sound/weapons/grenade_safety.wav', 65, FALSE)
	else if(grenade_spooned && grenade_flags & GRENADE_PINNED)
		to_chat(user, span_colossus("I'm fucked."))
		user.client?.give_award(/datum/award/achievement/misc/imfucked, user)
	else if(!active)
		to_chat(user, span_warning("Oh. It already has a pin."))
	else if(I.type != initial(pin))
		var/obj/item/pin/other_pin = I.type
		to_chat(user, span_warning("This Isn't the right pin where'd I get [initial(other_pin.name)]?"))
	else
		return

/obj/item/grenade/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	. = ..()
	if(!(grenade_flags & GRENADE_IMPACT) && active && grenade_flags & GRENADE_PINNED && !grenade_spooned)
		addtimer(CALLBACK(src, .proc/spoon_grenade), spoon_time)

/obj/item/grenade/frag/after_throw(mob/user, silent = FALSE, volume = 60)
	. = ..()
	if(grenade_flags & GRENADE_PINNED && active && !grenade_spooned)
		spoon_grenade()
