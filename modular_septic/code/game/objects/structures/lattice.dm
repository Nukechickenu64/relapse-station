/obj/structure/lattice/Initialize(mapload)
	. = ..()
	var/static/list/bad_initialize = list(INITIALIZE_HINT_QDEL, INITIALIZE_HINT_QDEL_FORCE)
	if(!(. in bad_initialize))
		AddComponent(/datum/component/footstep_changer, FOOTSTEP_CATWALK)

/obj/structure/lattice/catwalk/Initialize(mapload)
	. = ..()
	var/static/list/bad_initialize = list(INITIALIZE_HINT_QDEL, INITIALIZE_HINT_QDEL_FORCE)
	if(!(. in bad_initialize))
		AddComponent(/datum/component/footstep_changer, FOOTSTEP_HARDCATWALK)

/obj/structure/lattice/atom_destruction(damage_flag)
	. = ..()
	playsound(src, 'modular_septic/sound/effects/lattice_grind.wav', 80, FALSE)

/obj/structure/lattice/catwalk/efn_safezone
	desc = "A catwalk for preventing the quick descent of creatures."
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "sexy-grill"
	base_icon_state = "sexy-grill"
	number_of_mats = 2
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
