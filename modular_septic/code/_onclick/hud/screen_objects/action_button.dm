#define AB_MAX_ROWS 12

/atom/movable/screen/movable/action_button
	icon = 'modular_septic/icons/hud/quake/actions.dmi'
	icon_state = "blank"
	layer = ACTION_LAYER //above rack, above other screen objects and alerts
	locked = TRUE

/atom/movable/screen/movable/action_button/hide_toggle
	icon = 'modular_septic/icons/hud/quake/actions.dmi'
	hide_icon = 'modular_septic/icons/hud/quake/actions.dmi'
	icon_state = "blank"

/atom/movable/screen/movable/action_button/hide_toggle/InitialiseIcon(datum/hud/owner_hud)
	var/settings = owner_hud.get_action_buttons_icons()
	hide_icon = settings["toggle_icon"]
	hide_state = settings["toggle_hide"]
	show_state = settings["toggle_show"]
	update_appearance()

/datum/hud/ButtonNumberToScreenCoords(number)
	number -= 1
	var/col = -(1 + FLOOR(number/AB_MAX_ROWS, 1))
	var/row = 4+(number%AB_MAX_ROWS)
	var/coord_col = "[col >= 0 ? "+[abs(col)]" : "-[abs(col)]"]" //"Default" is EAST-1
	var/coord_row = "+[abs(row)]" //"Default" is SOUTH+4
	return "EAST[coord_col],SOUTH[coord_row]"
