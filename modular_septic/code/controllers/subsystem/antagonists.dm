SUBSYSTEM_DEF(antagonists)
	name = "Antagonists"
	flags = SS_NO_FIRE

/datum/controller/subsystem/antagonists/Initialize(start_timeofday)
	. = ..()
	GLOB.syndicate_employers = list("Itobe Agent", "Itobe Hijacker")
	GLOB.normal_employers = list("Itobe Agent", "ZoomTech Psy Ops")
	GLOB.hijack_employers = list("Itobe Hijacker")
	GLOB.nanotrasen_employers = list("ZoomTech Psy Ops")
