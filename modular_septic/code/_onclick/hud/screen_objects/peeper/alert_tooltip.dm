/atom/movable/screen/alert_tooltip
	name = "alert tooltip"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "alert_tooltip"
	maptext = "N/A"
	maptext_width = 158
	maptext_x = 2
	plane = PEEPER_PLANE
	layer = PEEPER_ABOVE_ACTION_TOOLTIP_LAYER
	screen_loc = ui_peeper_action_tooltip
	mouse_opacity = MOUSE_OPACITY_ICON

/atom/movable/screen/alert_tooltip/Initialize(mapload)
	. = ..()
	update_maptext(maptext)

/atom/movable/screen/alert_tooltip/proc/update_maptext(new_text = "N/A")
	if(!new_text)
		maptext = null
		return
	maptext = MAPTEXT_PEEPER_BRIGHT_CYAN("<span style='vertical-align: middle; text-align: center;'>[new_text]</span>")

/atom/movable/screen/alert_tooltip/description
	icon_state = "blank"
	maptext = "Everything is fine..."
	maptext_height = 80
	maptext_width = 158
	maptext_y = 16
	maptext_x = 2
	layer = PEEPER_ACTION_TOOLTIP_LAYER

/atom/movable/screen/alert_tooltip/description/update_maptext(new_text = "Everything is fine...")
	if(!new_text)
		maptext = null
		return
	maptext = MAPTEXT_PEEPER_CYAN("<span style='vertical-align: middle;'>[new_text]</span>")
