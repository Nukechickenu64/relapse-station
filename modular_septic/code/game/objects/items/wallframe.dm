/obj/item/wallframe
	plane = ABOVE_FRILL_PLANE

/obj/item/wallframe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
