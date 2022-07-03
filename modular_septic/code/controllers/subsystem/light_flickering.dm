SUBSYSTEM_DEF(light_flickering)
	name = "Light Flickering"
	wait = 60 SECONDS
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME
	var/list/active_lights = list()

/datum/controller/subsystem/light_flickering/fire(resumed)
	. = ..()
	for(var/obj/machinery/light/light as anything in active_lights)
		if(prob(60))
			light.flicker(10)
