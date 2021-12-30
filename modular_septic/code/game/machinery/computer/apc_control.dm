/obj/machinery/computer/apc_control/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)
