/obj/machinery/door
	/// Key inserted here, may or may not actually have access
	var/obj/item/key/inserted_key
	/// Should we auto align on initialization?
	var/auto_align = TRUE

/obj/machinery/door/examine(mob/user)
	. = ..()
	. += span_notice("[p_their(TRUE)] maintenance panel is <b>screwed</b> in place.")
	if(inserted_key)
		. += span_notice("[inserted_key] is inserted in [p_their()] keyhole.")

// Machinery always returns INITIALIZE_HINT_LATELOAD
/obj/machinery/door/LateInitialize(mapload = FALSE)
	. = ..()
	if(LAZYLEN(req_access) || LAZYLEN(req_one_access) || LAZYLEN(text2access(req_access_txt)) || LAZYLEN(text2access(req_one_access_txt)))
		lock()
	if(auto_align && mapload)
		auto_align()

/obj/machinery/door/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	var/mob/living/living_user = usr
	if((over != usr) || !inserted_key || !istype(living_user) || !living_user.Adjacent(src))
		return
	add_fingerprint(living_user)
	if(inserted_key && living_user.put_in_hands(inserted_key))
		inserted_key = null
		to_chat(living_user, span_notice("I take [inserted_key] from [src]'s keyhole."))
		playsound(src, 'modular_septic/sound/effects/keys_remove.ogg', 75, FALSE)
		sound_hint(living_user)

/obj/machinery/door/attack_hand_secondary(mob/user, list/modifiers)
	add_fingerprint(user)
	try_door_unlock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/door/attackby(obj/item/I, mob/living/user, params)
	if(!inserted_key && istype(I, /obj/item/key) && user.transferItemToLoc(I, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [I] into [src]'s keyhole."))
		playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
		sound_hint()
		inserted_key = I
		return TRUE
	return ..()

/obj/machinery/door/allowed(mob/M)
	if(inserted_key?.door_allowed(src))
		return TRUE
	return ..()

/obj/machinery/door/proc/try_door_unlock(user)
	if(allowed(user))
		if(locked)
			unlock()
		else
			lock()
	else if(density)
		do_animate("deny")
	return TRUE
