var/list/faunaspawnable
var/list/floraspawnable

/turf/open/dirt
	name = "dirt"
	icon = 'modular_web/icons/turf/open/dirt.dmi'
	icon_state = "1"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_HARD_BAREFOOT //TODO change to something more appropriate
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	turf_flags = CAN_BE_DIRTY_1
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_OPEN_FLOOR)
	canSmoothWith = list(SMOOTH_GROUP_OPEN_FLOOR, SMOOTH_GROUP_TURF_OPEN)

/turf/open/dirt/Initialize(mapload)
	. = ..()
	icon_state = "[rand(1,16)]"
