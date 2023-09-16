/turf/closed/metal
	name = "metal wall"
	desc = ""
	icon = 'modular_web/icons/turf/closed/walls.dmi'
	icon_state = "metallic-1"
	base_icon_state = "metallic"
	explosion_block = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 62500 //a little over 5 cm thick , 62500 for 1 m by 2.5 m by 0.25 m iron wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)

	baseturfs = /turf/open/stone
	top_turf = /turf/open/metal

	flags_ricochet = RICOCHET_HARD

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

	rcd_memory = RCD_MEMORY_WALL

/turf/closed/metal/rust
	name = "metal wall"
	desc = ""
	icon = 'modular_web/icons/turf/closed/walls.dmi'
	icon_state = "metal-1"
	base_icon_state = "metal"
	explosion_block = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 62500 //a little over 5 cm thick , 62500 for 1 m by 2.5 m by 0.25 m iron wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)

	baseturfs = /turf/open/stone
	top_turf = /turf/open/metal/rust

	flags_ricochet = RICOCHET_HARD

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

	rcd_memory = RCD_MEMORY_WALL
