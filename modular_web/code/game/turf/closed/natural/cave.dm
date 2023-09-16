/turf/closed/cave
	name = "cave wall"
	desc = ""
	icon = 'modular_web/icons/turf/closed/cave3.dmi'
	icon_state = "cave-1"
	base_icon_state = "cave"
	explosion_block = 1
	top_turf = /turf/open/dirt
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 62500 //a little over 5 cm thick , 62500 for 1 m by 2.5 m by 0.25 m iron wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)

	baseturfs = /turf/open/dirt

	flags_ricochet = RICOCHET_HARD

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

	rcd_memory = RCD_MEMORY_WALL
	///bool on whether this wall can be pushed
	var/hits = 0
	///bool on whether this wall can be chiselled into
	var/max_hits = 8
	///lower numbers are harder. Used to determine the probability of a hulk smashing through.
	var/hardness = 40 //default time taken to slice the wall
	var/ore_type = /obj/item/stack/sheet/iron
	var/ore_amount = 1
	/// A turf that will replace this turf when this turf is destroyed
	var/decon_type

	var/list/ore_decals

//TODO add random ore on init(mapload) using overlays
