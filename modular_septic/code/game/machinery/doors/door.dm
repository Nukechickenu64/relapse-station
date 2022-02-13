/obj/machinery/door
	plane = GAME_PLANE
	/// Key inserted here, may or may not actually have access
	var/obj/item/key/inserted_key

/obj/machinery/door/examine(mob/user)
	. = ..()
	. += span_notice("[p_their(TRUE)] maintenance panel is <b>screwed</b> in place.")
	if(inserted_key)
		. += span_notice("[inserted_key] is inserted in [p_their()] keyhole.")

// Machinery always returns INITIALIZE_HINT_LATELOAD
/obj/machinery/door/LateInitialize()
	. = ..()
	if(LAZYLEN(req_access) || LAZYLEN(req_one_access) || LAZYLEN(text2access(req_access_txt)) || LAZYLEN(text2access(req_one_access_txt)))
		lock()

/obj/machinery/door/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if((usr == over) && isliving(usr))
		var/mob/living/user = usr
		add_fingerprint(user)
		if(inserted_key && user.put_in_hands(inserted_key))
			to_chat(user, span_notice("I pull [inserted_key] from [src]'s keyhole."))
			inserted_key = null

/obj/machinery/door/attackby(obj/item/I, mob/living/user, params)
	if(!inserted_key && istype(I, /obj/item/key) && user.transferItemToLoc(I, src))
		add_fingerprint(user)
		to_chat(user, span_notice("I insert [I] into [src]'s keyhole."))
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
