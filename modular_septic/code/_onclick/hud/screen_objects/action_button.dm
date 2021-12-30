#define AB_MAX_ROWS 12

/atom/movable/screen/movable/action_button
	layer = 3 //above rack and alerts

/atom/movable/screen/movable/action_button/hide_toggle
	hide_icon = 'modular_septic/icons/hud/quake/actions.dmi'

/datum/hud/ButtonNumberToScreenCoords(number)
	number -= 1
	var/col = -(1 + FLOOR(number/AB_MAX_ROWS, 1))
	var/row = 4+(number%AB_MAX_ROWS)
	var/coord_col = "[col >= 0 ? "+[abs(col)]" : "-[abs(col)]"]" //"Default" is EAST-1
	var/coord_row = "+[abs(row)]" //"Default" is SOUTH+4
	return "EAST[coord_col],SOUTH[coord_row]"
