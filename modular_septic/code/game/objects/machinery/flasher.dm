/obj/machinery/flasher
	icon = 'modular_septic/icons/obj/stationobjs.dmi'
	icon_state = "mflash1"
	base_icon_state = "mflash"
	var/wall_mounted = TRUE

/obj/machinery/flasher/Initialize(mapload, ndir, built)
	. = ..()
	if(wall_mounted)
		AddElement(/datum/element/wall_mount)

/obj/machinery/flasher/portable
	wall_mounted = FALSE
