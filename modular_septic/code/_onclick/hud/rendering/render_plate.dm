/atom/movable/screen/plane_master/rendering_plate/game_world
	render_target = RENDER_PLANE_GAME_RENDER_TARGET
	render_relay_plane = RENDER_PLANE_GAME_PRE_PROCESSING

/atom/movable/screen/plane_master/rendering_plate/non_game
	render_target = RENDER_PLANE_NON_GAME_RENDER_TARGET
	render_relay_plane = RENDER_PLANE_NON_GAME_PRE_PROCESSING

// ~these are used to handle chromatic aberration and other complex effects
/atom/movable/screen/plane_master/rendering_plate/game_world_pre_processing
	name = "game pre-processing rendering plate"
	plane = RENDER_PLANE_GAME_PRE_PROCESSING
	render_relay_plane = RENDER_PLANE_GAME_POST_PROCESSING

/atom/movable/screen/plane_master/rendering_plate/game_world_pre_processing/backdrop(mob/mymob)
	. = ..()
	remove_filter("black")
	remove_filter("red")
	remove_filter("green")
	remove_filter("blue")
	if(istype(mymob) && mymob.client?.prefs.read_preference(/datum/preference/toggle/chromatic_aberration))
		add_filter("black", 1, layering_filter(render_source = RENDER_PLANE_GAME_RENDER_TARGET, color = "#000000"))
		add_filter("red", 2, layering_filter(render_source = RENDER_PLANE_GAME_RENDER_TARGET, color = "#FF000001", x = 1, y = 1))
		add_filter("green", 3, layering_filter(render_source = RENDER_PLANE_GAME_RENDER_TARGET, color = "#00FF0001", x = 0, y = 0))
		add_filter("blue", 4, layering_filter(render_source = RENDER_PLANE_GAME_RENDER_TARGET, color = "#0000FF01", x = -1, y = -1))

/atom/movable/screen/plane_master/rendering_plate/non_game_pre_processing
	name = "non-game pre-processing rendering plate"
	plane = RENDER_PLANE_NON_GAME_PRE_PROCESSING
	render_relay_plane = RENDER_PLANE_NON_GAME_POST_PROCESSING

// ~these plates come in to apply post processing just before the master plate
/atom/movable/screen/plane_master/rendering_plate/game_world_post_processing
	name = "game post-processing rendering plate"
	plane = RENDER_PLANE_GAME_POST_PROCESSING
	render_relay_plane = RENDER_PLANE_MASTER

/atom/movable/screen/plane_master/rendering_plate/non_game_post_processing
	name = "non-game post-processing rendering plate"
	plane = RENDER_PLANE_NON_GAME_POST_PROCESSING
	render_relay_plane = RENDER_PLANE_MASTER

// ~this plate is exclusively used to render the peeper
/atom/movable/screen/plane_master/rendering_plate/peeper
	name = "peeper rendering plate"
	plane = RENDER_PLANE_PEEPER
	render_relay_plane = RENDER_PLANE_MASTER
	generate_render_target = FALSE
