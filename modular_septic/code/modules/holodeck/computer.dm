/obj/machinery/computer/holodeck/Initialize()
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)
