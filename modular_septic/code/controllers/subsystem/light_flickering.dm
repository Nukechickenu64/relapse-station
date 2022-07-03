SUBSYSTEM_DEF(light_flickering)
	name = "Light Flickering"
	wait = 1 MINUTES
	flags = SS_NO_INIT | SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	var/list/active_lights = list()

/datum/controller/subsystem/light_flickering/fire(resumed)
	. = ..()
	for(var/obj/machinery/light/light as anything in active_lights)
		if(!prob(20))
			continue
		light.flicker(10)