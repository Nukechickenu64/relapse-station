/turf/closed/stone
	name = "stone wall"
	desc = ""
	icon = 'modular_web/icons/turf/closed/stone_walls.dmi'
	icon_state = "rwall-1"
	base_icon_state = "rwall"
	explosion_block = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 62500 //a little over 5 cm thick , 62500 for 1 m by 2.5 m by 0.25 m iron wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)

	baseturfs = /turf/open/stone

	flags_ricochet = RICOCHET_HARD

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

	rcd_memory = RCD_MEMORY_WALL
