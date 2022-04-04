/atom/movable/screen/plane_master/rendering_plate/game_world
	render_relay_plane = RENDER_PLANE_GAME_POST_PROCESSING

/atom/movable/screen/plane_master/rendering_plate/non_game
	render_relay_plane = RENDER_PLANE_NON_GAME_POST_PROCESSING

// ~these plates come in to apply post processing just before the master plate
/atom/movable/screen/plane_master/rendering_plate/game_world_post_processing
	name = "game post processing rendering plate"
	plane = RENDER_PLANE_GAME_POST_PROCESSING
	render_relay_plane = RENDER_PLANE_MASTER

/atom/movable/screen/plane_master/rendering_plate/non_game_post_processing
	name = "non-game post processing rendering plate"
	plane = RENDER_PLANE_NON_GAME_POST_PROCESSING
	render_relay_plane = RENDER_PLANE_MASTER
