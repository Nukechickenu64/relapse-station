/atom/movable/screen/plane_master/rendering_plate/game_world
	render_relay_plane = RENDER_PLANE_PREMASTER

/atom/movable/screen/plane_master/rendering_plate/non_game
	render_relay_plane = RENDER_PLANE_PREMASTER

///this plate intercepts just before the final render
/atom/movable/screen/plane_master/rendering_plate/premaster
	name = "master rendering plate"
	plane = RENDER_PLANE_PREMASTER
	render_relay_plane = RENDER_PLANE_MASTER
