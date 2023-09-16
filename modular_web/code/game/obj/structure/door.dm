/obj/structure/door
	name = "wooden door"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	layer = CLOSED_DOOR_LAYER

	icon = 'modular_web/icons/obj/doors/mineral_doors.dmi'
	icon_state = "wood"
	max_integrity = 200
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 10, BIO = 100, FIRE = 50, ACID = 50)
	can_atmos_pass = ATMOS_PASS_DENSITY
	rad_insulation = RAD_MEDIUM_INSULATION

	var/door_opened = FALSE //if it's open or not.
	var/isSwitchingStates = FALSE //don't try to change stats if we're already opening

	var/close_delay = -1 //-1 if does not auto close.
	var/openSound = 'sound/effects/stonedoor_openclose.ogg'
	var/closeSound = 'sound/effects/stonedoor_openclose.ogg'

	var/sheetType = /obj/item/stack/sheet/wood //what we're made of
	var/sheetAmount = 7 //how much we drop when deconstructed

/obj/structure/mineral_door/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, TRUE)

/obj/structure/mineral_door/Destroy()
	if(!door_opened)
		air_update_turf(TRUE, FALSE)
	. = ..()

/obj/structure/mineral_door/Move()
	var/turf/T = loc
	. = ..()
	if(!door_opened)
		move_update_air(T)

/obj/structure/mineral_door/Bumped(atom/movable/AM)
	..()
	if(!door_opened)
		return TryToSwitchState(AM)

/obj/structure/mineral_door/attack_ai(mob/user) //those aren't machinery, they're just big fucking slabs of a mineral
	if(isAI(user)) //so the AI can't open it
		return
	else if(iscyborg(user)) //but cyborgs can
		if(get_dist(user,src) <= 1) //not remotely though
			return TryToSwitchState(user)

/obj/structure/mineral_door/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/mineral_door/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return TryToSwitchState(user)

/obj/structure/mineral_door/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(istype(mover, /obj/effect/beam))
		return !opacity

/obj/structure/mineral_door/proc/TryToSwitchState(atom/user)
	if(isSwitchingStates || !anchored)
		return
	if(isliving(user))
		var/mob/living/M = user
		if(world.time - M.last_bumped <= 60)
			return //NOTE do we really need that?
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState()
			else
				SwitchState()
	else if(ismecha(user))
		SwitchState()

/obj/structure/mineral_door/proc/SwitchState()
	if(door_opened)
		Close()
	else
		Open()

/obj/structure/mineral_door/proc/Open()
	isSwitchingStates = TRUE
	playsound(src, openSound, 100, TRUE)
	set_opacity(FALSE)
	flick("[initial(icon_state)]opening",src)
	sleep(10)
	set_density(FALSE)
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE, FALSE)
	update_appearance()
	isSwitchingStates = FALSE

	if(close_delay != -1)
		addtimer(CALLBACK(src, .proc/Close), close_delay)

/obj/structure/mineral_door/proc/Close()
	if(isSwitchingStates || !door_opened)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	isSwitchingStates = TRUE
	playsound(src, closeSound, 100, TRUE)
	flick("[initial(icon_state)]closing",src)
	sleep(10)
	set_density(TRUE)
	set_opacity(TRUE)
	door_opened = FALSE
	layer = initial(layer)
	air_update_turf(TRUE, TRUE)
	update_appearance()
	isSwitchingStates = FALSE

/obj/structure/mineral_door/update_icon_state()
	icon_state = "[initial(icon_state)][door_opened ? "open":""]"
	return ..()

/obj/structure/mineral_door/attackby(obj/item/I, mob/living/user)
	if(pickaxe_door(user, I))
		return
	//else if(!user.combat_mode) //SEPTIC EDIT REMOVAL
	//SEPTIC EDIT BEGIN
	else if(IS_HELP_INTENT(user, null))
	//SEPTIC EDIT END
		return attack_hand(user)
	else
		return ..()

/obj/structure/mineral_door/set_anchored(anchorvalue) //called in default_unfasten_wrench() chain
	. = ..()
	set_opacity(anchored ? !door_opened : FALSE)
	air_update_turf(TRUE, anchorvalue)

/obj/structure/mineral_door/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 40)
	return TRUE

