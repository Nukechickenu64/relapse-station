/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	plane = GAME_PLANE_UPPER_BLOOM
	layer = WALL_OBJ_LAYER

/obj/machinery/light/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, .proc/glitch_if_possible), rand(80 SECONDS, 160 SECONDS))

/obj/machinery/light/proc/glitch_if_possible()
	if(on)
		playsound(src, 'modular_septic/sound/machinery/broken_bulb_sound.wav', 50, FALSE, 2)
	addtimer(CALLBACK(src, .proc/glitch_if_possible), rand(80 SECONDS, 80 SECONDS))

/obj/machinery/light/process(delta_time)
	if (!cell)
		return
	if(has_power())
		if(cell.charge == cell.maxcharge)
			return
		cell.charge = min(cell.maxcharge, cell.charge + LIGHT_EMERGENCY_POWER_USE) //Recharge emergency power automatically while not using it
	if(emergency_mode && !use_emergency_power(LIGHT_EMERGENCY_POWER_USE))
		update(FALSE) //Disables emergency mode and sets the color to normal

/obj/machinery/light/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount/light_mount)

/obj/machinery/light/floor/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/wall_mount/light_mount)
