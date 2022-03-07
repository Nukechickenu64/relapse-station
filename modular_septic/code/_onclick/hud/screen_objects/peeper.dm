/atom/movable/screen/peeper_hide
	name = "close peeper"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "close"
	screen_loc = ui_peeper_close

/atom/movable/screen/peeper_hide/Click(location, control, params)
	. = ..()
	hud?.peeper?.hide_peeper(hud.mymob)
