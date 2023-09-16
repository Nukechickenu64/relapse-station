/turf/open/metal
	name = "metal tile"
	icon = 'modular_web/icons/turf/open/floors.dmi'
	icon_state = "black_newluna"
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT //TODO change to something more appropriate
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	turf_flags = CAN_BE_DIRTY_1
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_OPEN_FLOOR)
	canSmoothWith = list(SMOOTH_GROUP_OPEN_FLOOR, SMOOTH_GROUP_TURF_OPEN)

/turf/open/metal/rust
	name = "metal tile"
	icon = 'modular_web/icons/turf/open/floors.dmi'
	icon_state = "white"
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT //TODO change to something more appropriate
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	turf_flags = CAN_BE_DIRTY_1
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_OPEN_FLOOR)
	canSmoothWith = list(SMOOTH_GROUP_OPEN_FLOOR, SMOOTH_GROUP_TURF_OPEN)
