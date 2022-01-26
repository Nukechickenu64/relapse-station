/area
	var/room_name
	var/room_desc
	var/droning_sound = DRONING_DEFAULT
	var/droning_vary = 0
	var/droning_repeat = TRUE
	var/droning_wait = 0
	var/droning_volume = 25
	var/droning_channel = CHANNEL_BUZZ
	var/droning_frequency = 0

/area/Entered(atom/movable/arrived, area/old_area)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_AREA_ENTERED, arrived, old_area)
	var/mob/living/living_arrived = arrived
	if(istype(living_arrived) && living_arrived.client && !living_arrived.combat_mode)
		//Ambience if combat mode is off
		SSdroning.area_entered(src, living_arrived.client)
	if(!LAZYACCESS(arrived.important_recursive_contents, RECURSIVE_CONTENTS_AREA_SENSITIVE))
		return
	for(var/atom/movable/recipient as anything in arrived.important_recursive_contents[RECURSIVE_CONTENTS_AREA_SENSITIVE])
		SEND_SIGNAL(recipient, COMSIG_ENTER_AREA, src)

/area/maintenance/liminal/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	var/mob/living/living_arrived = arrived
	 if(istype(living_arrived))
		//When a human enters the hallway, what happens?
		ADD_TRAIT(recipient, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a soyjack

/area/maintenance/liminal/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/living_arrived = arrived
	 if(istype(living_arrived))
		//When a human exits the hallway, what happens?
		REMOVE_TRAIT(recipient, TRAIT_PACIFISM, AREA_TRAIT)
		//They become a chad
