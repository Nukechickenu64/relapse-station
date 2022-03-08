/atom/movable/screen/peeper_close
	name = "close peeper"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "close"
	plane = PEEPER_PLANE
	layer = PEEPER_CLOSER_LAYER
	screen_loc = ui_peeper_close

/atom/movable/screen/peeper_close/Click(location, control, params)
	. = ..()
	hud?.peeper?.hide_peeper(hud.mymob)
