/obj/machinery/door/metal_door
	name = "Metal Door"
	desc = "A broad metal door with a lock for keys, usually not locked, If It is, a nice firm kick from a friendly orange-suited protagonist would do the trick."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal"
	icon_state = "metal"
	var/doorOpen = 'modular_septic/sound/effects/doors/door_metal_open.ogg'
	var/doorClose = 'modular_septic/sound/effects/doors/door_metal_close.ogg'
	var/doorDeni = list('modular_septic/sound/effects/doors/door_metal_try1.ogg', 'modular_septic/sound/effects/doors/door_metal_try2.ogg')
	var/kickfailure = 'modular_septic/sound/effects/doors/door_metal_freeman_impersonator.ogg'
	var/kicksuccess = 'modular_septic/sound/effects/doors/smod_freeman.ogg'
	var/kickcriticalsuccess = 'modular_septic/sound/effects/doors/smod_freeman_extreme.ogg'

/obj/machinery/door/metal_door/open()
	. = ..()
	playsound(src, doorOpen, 65, FALSE)

/obj/machinery/door/metal_door/close()
	. = ..()
	playsound(src, doorClose, 65, FALSE)

/obj/structure/metal_door_frame
	name = "Metal Door Frame"
	desc = "Someone broke down this fucking door, now where is it?"
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_broken"
	icon_state = "metal_broken"
	density = FALSE
	opacity = TRUE
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = OPEN_DOOR_LAYER
	move_resist = MOVE_FORCE_VERY_STRONG

/obj/structure/metal_door
	name = "Metal Door"
	desc = "A door lying on the floor, the hinges are broken and It's broken and useless, just like you."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_freeman_evidence"
	icon_state = "metal_freeman_evidence"
	density = FALSE
	anchored = FALSE
	var/state_variation = 2

/obj/structure/metal_door/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, 2)]"

/obj/machinery/door/metal_door/

/obj/machinery/door/metal_door/proc/imbatublow(mob/living/user, atom/source)
	var/turf/doorturf = get_turf(src)
	var/flying_dir = get_dir(user, source.loc)
	var/turf/freeman = get_ranged_target_turf(user, flying_dir, 3)
	if(istype(doorturf))
		doorturf.pollute_turf(/datum/pollutant/dust, 20)
	var/obj/structure/metal_door_frame/door_frame = new /obj/structure/metal_door_frame(doorturf)
	var/obj/structure/metal_door/thrown_door = new /obj/structure/metal_door(doorturf)
	thrown_door.throw_at(freeman, range = 4, speed = 2)
	sound_hint(door_frame)
	sound_hint(thrown_door)
	playsound(src, kickcriticalsuccess, 100, FALSE, 5)
	qdel(src)

/obj/machinery/door/metal_door/proc/gordan_freeman_speedrunner(mob/living/user)
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(!(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) < 12))
		playsound(src, kickfailure, 75, FALSE, 2)
		visible_message(span_danger("[user] kicks the [src]!"), \
			span_danger("I kick the [src], but It's too hard!"))
		sound_hint()
		return
	if(user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)-2) <= DICE_FAILURE)
		playsound(src, kickfailure, 75, FALSE, 2)
		visible_message(span_danger("[user] kicks the [src]!"), \
			span_danger("I kick the [src]!"))
		sound_hint()
		return
	else if(!(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 18))
		playsound(src, kicksuccess, 100, FALSE, 5)
		visible_message(span_bigdanger("[user] kicks the [src] straight off it's hinges!"), \
			span_bolddanger("I kick the [src] straight off it's hinges!"))
		sound_hint()
		locked = FALSE
		imbatublow()
		return
	else
		playsound(src, kicksuccess, 90, FALSE, 2)
		sound_hint()
		visible_message(span_danger("[user] kicks the [src] open!"), \
			span_danger("I kick the [src] down."))
		locked = FALSE
		open()

/obj/machinery/door/metal_door/try_door_unlock(user)
	if(allowed(user))
		if(locked)
			unlock()
		else
			lock()
	else if(density)
		playsound(src, doorDeni, 70, FALSE, 2)
	return TRUE
