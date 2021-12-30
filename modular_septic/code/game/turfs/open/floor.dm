/turf/open/floor/crowbar_act(mob/living/user, obj/item/tool)
	return

/turf/open/floor/crowbar_act_secondary(mob/living/user, obj/item/tool)
	if(overfloor_placed && pry_tile(tool, user))
		return TRUE

/turf/open/floor/plating
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/iron
	icon = 'modular_septic/icons/turf/floors.dmi'

/turf/open/floor/mineral/plastitanium
	icon = 'modular_septic/icons/turf/floors.dmi'
