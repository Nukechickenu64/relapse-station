/obj/machinery/light_switch
	icon = 'modular_septic/icons/obj/machinery/power.dmi'

/obj/machinery/light_switch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)
