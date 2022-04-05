/atom/movable/screen/fullscreen/fog_blocker
	name = "fog blocker"
	icon = 'modular_septic/icons/effects/blockers.dmi'
	icon_state = ""
	screen_loc = ui_fullscreen

/atom/movable/screen/fullscreen/fog_blocker/Initialize(mapload)
	. = ..()
	vis_contents += GLOB.blocker_movables[/atom/movable/blocker/pollution]
