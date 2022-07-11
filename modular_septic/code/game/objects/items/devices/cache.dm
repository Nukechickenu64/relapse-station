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
	var/accessibility = FALSE
	var/locked = TRUE
	var/buttonsound = 'modular_septic/sound/efn/cache_button.ogg'
	var/cacheOpen = 'modular_septic/sound/efn/cache_open.ogg'
	var/cacheClose = 'modular_septic/sound/efn/cache_close.ogg'

/obj/machinery/cache/update_overlays()
	. = ..()
	if(!accessibility)
		. += "[icon_state]_closed"
	else
		. += "[icon_state]_opened"

/obj/machinery/cache/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)
	if(locked)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_HIDE_FROM, usr) //To be safe of course (I'm a extremely good coder and there is no furry lizard profile picture criticizing my code)

/obj/machinery/cache/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = 12

/obj/machinery/cache/attack_hand_secondary(mob/living/user, list/modifiers)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(locked)
		user.visible_message(span_notice("[user] presses the accessibility button, but It only buzzes!"), \
		span_notice("[fail_msg()] The damn thing is fucking locked!"))
		playsound(src, buttonsound, 75, FALSE)
		return
	else
		open_cache()

/obj/machinery/cache/proc/open_cache(mob/living/user)
	var/nice
	if(prob(20))
		nice = "nice"
	if(!accessibility)
		visible_message(span_notice("[src] slides open with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
		accessibility = TRUE
		have_open_sex()
		playsound(src, cacheOpen, 85, FALSE)
	else
		visible_message(span_notice("[src] slides closed with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_HIDE_FROM, usr)
		accessibility = FALSE
		have_closed_sex()
		playsound(src, cacheClose, 85, FALSE)


/obj/machinery/cache/proc/have_open_sex()
	cut_overlays()
	add_overlay("[base_icon_state]-opening")
	sleep(6)
	cut_overlay("[base_icon_state]-opening")
	update_overlays()

/obj/machinery/cache/proc/have_closed_sex()
	cut_overlays()
	add_overlay("[base_icon_state]-closing")
	sleep(6)
	cut_overlay("[base_icon_state]-closing")
	update_overlays()
