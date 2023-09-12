/obj/structure/closet
	door_anim_time = 0

/obj/structure/closet/Initialize(mapload)
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)
