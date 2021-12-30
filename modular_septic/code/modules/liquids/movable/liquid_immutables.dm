/atom/movable/liquid/immutable
	immutable = TRUE

/atom/movable/liquid/immutable/ocean
	icon_state = "ocean"
	base_icon_state = "ocean"
	smoothing_flags = NONE
	plane = BLACKNESS_PLANE //Same as weather, etc.
	layer = ABOVE_MOB_LAYER
	temperature = T20C-150
	no_effects = TRUE
	vis_flags = NONE

/atom/movable/liquid/immutable/ocean/warm
	temperature = T20C

/atom/movable/liquid/immutable/ocean/warm/warmer
	temperature = T20C+20

/atom/movable/liquid/immutable/ocean/nevado
	temperature = T0C-10
