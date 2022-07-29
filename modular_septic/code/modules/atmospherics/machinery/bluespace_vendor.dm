/obj/machinery/bluespace_vendor
	icon = 'modular_septic/icons/obj/atmospherics/components/bluespace_gas_vendor.dmi'
	plane = ABOVE_FRILL_PLANE

/obj/machinery/bluespace_vendor/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
