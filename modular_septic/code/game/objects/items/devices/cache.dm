#define CACHE_CLOSED 1
#define CACHE_CLOSING 2
#define CACHE_OPEN 3
#define CACHE_OPENING 4

/obj/machinery/cache
	name = "Wall-mounted Cache"
	desc = "A cache meant for securing goods in a nice, steel-reinforced package."
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "cache"
	base_icon_state = "cache"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	// Determines If people can reach inside and use the cache.
	var/locked = TRUE
	var/buttonsound = 'modular_septic/sound/efn/cache_button.ogg'
	var/cacheOpen = 'modular_septic/sound/efn/cache_open.ogg'
	var/cacheClose = 'modular_septic/sound/efn/cache_close.ogg'
	var/state = CACHE_CLOSED

/obj/machinery/cache/update_overlays()
	. = ..()
	switch(state)
		if(CACHE_CLOSED)
			. += "[base_icon_state]_closed"
		if(CACHE_CLOSING)
			. += "[base_icon_state]_closing"
		if(CACHE_OPEN)
			. += "[base_icon_state]_opened"
		if(CACHE_OPENING)
			. += "[base_icon_state]_opening"

/obj/machinery/cache/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)
	if(locked)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_HIDE_FROM, usr) //To be safe of course (I'm a extremely good coder and there is no furry lizard profile picture criticizing my code)

/obj/machinery/cache/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = 12

/obj/machinery/cache/attack_hand_secondary(mob/living/user, list/modifiers)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	playsound(src, buttonsound, 75, FALSE)
	if(locked)
		user.visible_message(span_notice("[user] presses the accessibility button, but It only buzzes!"), \
		span_notice("[fail_msg()] The damn thing is fucking locked!"))
		return
	else
		user.visible_message(span_notice("[user] presses the accessibility button"), \
		span_notice("[fail_msg()] I press the accessibility button on the [src]."))
		open_cache()

/obj/machinery/cache/proc/open_cache(mob/living/user)
	if(state == CACHE_OPENING || state == CACHE_CLOSING)
		to_chat(user, "[fail_msg()] I'm fucking retarded, It's doing It's thing!")
		return
	var/nice
	if(prob(20))
		nice = "nice"
	if(state == CACHE_CLOSED)
		visible_message(span_notice("[src] slides open with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
		playsound(src, cacheOpen, 85, FALSE)
		INVOKE_ASYNC(src, .proc/open)
	else
		visible_message(span_notice("[src] slides closed with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_HIDE_FROM, usr)
		playsound(src, cacheClose, 85, FALSE)
		INVOKE_ASYNC(src, .proc/close)

/obj/machinery/cache/proc/open()
	state = CACHE_OPENING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = CACHE_OPEN
	update_appearance(UPDATE_ICON)

/obj/machinery/cache/proc/close()
	state = CACHE_CLOSING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = CACHE_CLOSED
	update_appearance(UPDATE_ICON)

#undef CACHE_CLOSED
#undef CACHE_CLOSING
#undef CACHE_OPEN
#undef CACHE_OPENING
