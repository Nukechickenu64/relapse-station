/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	var/plane_on = GAME_PLANE_UPPER_BLOOM

/obj/machinery/light/Initialize(mapload)
	. = ..()
	if(!plane_on)
		plane_on = plane
	if(plane != FLOOR_PLANE)
		AddElement(/datum/element/wall_mount/light_mount)
	addtimer(CALLBACK(src, .proc/glitch_if_possible), rand(5.3 MINUTES, 15.6 MINUTES))

/obj/machinery/light/update_icon(updates)
	. = ..()
	switch(status)
		if(LIGHT_BROKEN,LIGHT_BURNED,LIGHT_EMPTY)
			plane = initial(plane)
		else
			plane = plane_on

/obj/machinery/light/process(delta_time)
	if (!cell)
		return
	if(has_power())
		if(cell.charge == cell.maxcharge)
			return
		cell.charge = min(cell.maxcharge, cell.charge + LIGHT_EMERGENCY_POWER_USE) //Recharge emergency power automatically while not using it
	if(emergency_mode && !use_emergency_power(LIGHT_EMERGENCY_POWER_USE))
		update(FALSE) //Disables emergency mode and sets the color to normal

/obj/machinery/light/proc/glitch_if_possible()
	if(on && prob(60))
		playsound(src, 'modular_septic/sound/machinery/broken_bulb_sound.wav', 50, FALSE, 2)
		flicker(10)
	addtimer(CALLBACK(src, .proc/glitch_if_possible), rand(5.3 MINUTES, 15.6 MINUTES))

/obj/machinery/light/floor
	plane = FLOOR_PLANE
	layer = LOW_OBJ_LAYER
	plane_on = null
