/area/caves
	name = "Caves"
	icon = 'icons/turf/areas.dmi'
	icon_state = "cave"
	layer = AREA_LAYER
	//Keeping this on the default plane, GAME_PLANE, will make area overlays fail to render on FLOOR_PLANE.
	plane = AREA_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	invisibility = INVISIBILITY_LIGHTING

	area_flags = UNIQUE_AREA | CULT_PERMITTED | NO_ALERTS

	/// For space, the asteroid, lavaland, etc. Used with blueprints or with weather to determine if we are adding a new area (vs editing a station room)
	outdoors = TRUE

	///Will objects this area be needing power?
	requires_power = TRUE
	/// This gets overridden to 1 for space in area/.
	always_unpowered = FALSE

	has_gravity = TRUE

	ambience_index = AMBIENCE_SPOOKY
	flags_1 = CAN_BE_DIRTY_1
	///Used to decide what kind of reverb the area makes sound have
	sound_environment = SOUND_ENVIRONMENT_STONEROOM

	///Used to decide what the minimum time between ambience is
	min_ambience_cooldown = 30 SECONDS
	///Used to decide what the maximum time between ambience is
	max_ambience_cooldown = 90 SECONDS
