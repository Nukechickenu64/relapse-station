/obj/item/storage/secure/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	l_set = FALSE
	to_chat(user, span_notice("I corrupt [src]'s internal memory."))

/obj/item/storage/secure/safe
	icon = 'modular_septic/icons/obj/structures/safe.dmi'
	plane = GAME_PLANE_UPPER
	armor = list(MELEE = 70, BULLET = 70, LASER = 70, ENERGY = 70, BOMB = 70, BIO = 100, FIRE = 70, ACID = 70)
	var/wall_mounted = TRUE

/obj/item/storage/secure/safe/Initialize()
	. = ..()
	if(wall_mounted)
		AddElement(/datum/element/wall_mount, plane, plane)

/obj/item/storage/secure/safe/caps_spare
	name = "captain's spare ID safe"
	desc = "Stores the spare full-access ID."
	can_hack_open = TRUE
	armor = list(MELEE = 70, BULLET = 70, LASER = 70, ENERGY = 70, BOMB = 70, BIO = 100, FIRE = 70, ACID = 70)
	max_integrity = 600
	color = null
