/obj/machinery/button/Initialize(mapload, ndir, built)
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/machinery/button/door/outpost_entrance
	normaldoorcontrol = TRUE
	specialfunctions = OPEN | BOLTS

/obj/machinery/button/door/outpost_entrance/directional/north
	dir = SOUTH
	pixel_y = 24

/obj/machinery/button/door/outpost_entrance/directional/south
	dir = NORTH
	pixel_y = -24

/obj/machinery/button/door/outpost_entrance/directional/east
	dir = WEST
	pixel_x = 24

/obj/machinery/button/door/outpost_entrance/directional/west
	dir = EAST
	pixel_x = -24
