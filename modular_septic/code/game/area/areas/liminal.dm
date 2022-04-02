/area/maintenance/liminal
	name = "Liminal Space"
	icon_state = "liminal"
	icon = 'modular_septic/icons/turf/areas.dmi'
	droning_sound = DRONING_LIMINAL
	requires_power = FALSE

/area/maintenance/liminal/red
	name = "Liminal Red"
	icon_state = "red"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/purple
	name = "Liminal Purple"
	icon_state = "purple"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/green
	name = "Liminal Green"
	icon_state = "green"
	droning_sound = DRONING_LIMINAL

/area/maintenance/liminal/darkgreen
	name = "Liminal Dark Green"
	icon_state = "darkgreen"
	droning_sound = DRONING_DARKLIMINAL

/area/maintenance/liminal/hallways
	name = "Liminal Hallways"
	icon_state = "engine"
	droning_sound = DRONING_LIMINALHALL
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -10

/area/maintenance/liminal/deep
	name = "Liminal Deep"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALDEEP
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -5

/area/maintenance/liminal/darkclub
	name = "Liminal Club"
	icon_state = "darkgreen"
	droning_sound = DRONING_LIMINALCLUB

/area/maintenance/liminal/observitory
	name = "Liminal Observitory"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALOB

/area/maintenance/liminal/solar
	name = "Liminal Solars"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALSOLAR

/area/maintenance/liminal/chromosome
	name = "Liminal Chromosome"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALSOLAR

/area/maintenance/liminal/train
	name = "Liminal Train"
	icon_state = "engine_sm"
	droning_sound = DRONING_LIMINALTRAIN

/area/maintenance/liminal/intro
	name = "Liminal Introduction"
	droning_sound = DRONING_LIMINALINTRO

/area/maintenance/liminal/intro/Entered(atom/movable/arrived, area/old_area, volume = 70)
	. = ..()
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived))
		//When a human enters the hallway, what happens?
		to_chat(living_arrived, span_warning("<b>I feel woozy as the supression field makes me into a soyjack.</b>"))
		living_arrived.playsound_local(living_arrived, 'modular_septic/sound/effects/soyjack.wav', volume, TRUE)
		ADD_TRAIT(living_arrived, TRAIT_PACIFISM, AREA_TRAIT)
		living_arrived.flash_pain(60)
		//They become a soyjack

/area/maintenance/liminal/intro/Exited(atom/movable/gone, direction, volume = 70)
	. = ..()
	var/mob/living/living_gone = gone
	if(istype(living_gone))
		//When a human exits the hallway, what happens?
		to_chat(living_gone, span_yell("<b>I feel chad.</b>"))
		living_gone.playsound_local(living_gone, 'modular_septic/sound/effects/chadjack.wav', volume, TRUE)
		living_gone.flash_pain(60)
		REMOVE_TRAIT(living_gone, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a doomerjackxx
