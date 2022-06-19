/obj/machinery/door/poddoor/shutters
	gender = PLURAL
	name = "shutters"
	desc = "Heavy duty mechanical shutters with an atmospheric seal that keeps them airtight once closed."
	icon = 'icons/obj/doors/shutters.dmi'
	layer = SHUTTER_LAYER
	closingLayer = SHUTTER_LAYER
	damage_deflection = 20
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 75, BOMB = 25, BIO = 100, FIRE = 100, ACID = 70)
	max_integrity = 100
	recipe_type = /datum/crafting_recipe/shutters

/obj/machinery/door/poddoor
	icon = 'modular_septic/icons/obj/machinery/doors/tall/blastdoor.dmi'

/obj/machinery/door/poddoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, 'modular_septic/sound/machinery/shutter-open.wav', 65, FALSE, 2)
		if("closing")
			flick("closing", src)
			playsound(src, 'modular_septic/sound/machinery/shutter-close.wav', 65, FALSE, 2)
