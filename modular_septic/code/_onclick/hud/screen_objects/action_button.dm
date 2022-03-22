#undef AB_MAX_COLUMNS
#define AB_MAX_COLUMNS 6

/atom/movable/screen/movable/action_button
	icon = 'modular_septic/icons/hud/quake/actions.dmi'
	icon_state = "blank"
	plane = PEEPER_PLANE
	layer = PEEPER_ACTION_LAYER
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
	var/col = (number % AB_MAX_COLUMNS)
	var/row = FLOOR(number/AB_MAX_COLUMNS, 1)
	return "statmap:[1+col],[3-row]"
