/obj/machinery/power/apc
	icon = 'modular_septic/icons/obj/machinery/apc.dmi'
	plane = ABOVE_FRILL_PLANE
	/// The crewmembers do get a bit quirky at night
	var/power_outage_sound = 'modular_septic/sound/effects/poweroutage.ogg'
	/// Volume of the power outage sound
	var/power_outage_volume = 100
	/// Extrarange of the power outage sound
	var/power_outage_extrarange = 3

/obj/machinery/power/apc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
