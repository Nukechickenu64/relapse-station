/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	plane = GAME_PLANE_UPPER_BLOOM
	layer = WALL_OBJ_LAYER

/obj/machinery/light/process(delta_time)
	. = ..()
	if(machine_stat & BROKEN | NOPOWER)
		return PROCESS_KILL
	if(!on)
		return

	if(DT_PROB(20, delta_time))
		playsound(src, 'modular_septic/sound/machinery/broken_bulb_sound.wav', 35, FALSE, 2)

/obj/machinery/light/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount/light_mount)

/obj/machinery/light/floor/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/wall_mount/light_mount)
