/area/maintenance/liminal
	name = "Liminal Space"
	icon_state = "liminal"
	icon = 'modular_septic/icons/turf/areas.dmi'
	requires_power = FALSE

/area/maintenance/liminal/red
	name = "Liminal Red"
	icon_state = "red"

/area/maintenance/liminal/purple
	name = "Liminal Purple"
	icon_state = "purple"

/area/maintenance/liminal/green
	name = "Liminal Green"
	icon_state = "green"

/area/maintenance/liminal/darkgreen
	name = "Liminal Dark Green"
	icon_state = "darkgreen"

/area/maintenance/liminal/hallways
	name = "Liminal Hallways"
	icon_state = "engine"
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -1

/area/maintenance/liminal/deep
	name = "Liminal Deep"
	icon_state = "engine_sm"
	mood_message = "<span class='bloody'>This area is pretty nice!</span>\n"
	mood_bonus = -1

/area/maintenance/liminal/bunker
	name = "Liminal Bunker"
	icon_state = "engine_sm"
	mood_message = "<span class='swarmer'>THIS AREA FUCKS!</span>\n"
	mood_bonus = 3

/area/maintenance/liminal/derelict
	name = "Liminal Derelict"
	icon_state = "engine_sm"
	mood_message = "<span class='swarmer'>SO POOPDARK AND UKRANIANCORE!</span>\n"
	mood_bonus = 1

/area/maintenance/liminal/darkclub
	name = "Liminal Club"
	icon_state = "darkgreen"

/area/maintenance/liminal/observitory
	name = "Liminal Observitory"
	icon_state = "engine_sm"

/area/maintenance/liminal/solar
	name = "Liminal Solars"
	icon_state = "engine_sm"

/area/maintenance/liminal/chromosome
	name = "Liminal Chromosome"
	icon_state = "engine_sm"

/area/maintenance/liminal/train
	name = "Liminal Train"
	icon_state = "engine_sm"

/area/maintenance/liminal/intro
	name = "Liminal Introduction"

/area/maintenance/liminal/intro/elevators
	name = "Liminal Intro Elevators"

/area/maintenance/liminal/elevators
	name = "Liminal Elevators"

/area/maintenance/liminal/waitroom
	name = "Liminal Waitroom"

/area/maintenance/liminal/windowclub
	name = "Liminal Window Club"

/area/maintenance/liminal/boltduel
	name = "Liminal Boltie Tunnels"

/area/maintenance/liminal/boltduel/mechanism
	name = "Liminal Mechanists Room"

/area/maintenance/liminal/tensity
	name = "Liminal Tense Rooms"

/area/maintenance/liminal/divine
	name = "Liminal Divine"

/area/maintenance/liminal/beattheboss
	name = "Liminal Beat The Boss"

/area/maintenance/liminal/denominator
	name = "Denominator's Hideout"

/area/maintenance/liminal/denominator/barracks
	name = "Denominator's Barracks"

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
