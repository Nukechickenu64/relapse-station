/mob
	plane = GAME_PLANE_FOV_HIDDEN
	var/cursor_icon = 'modular_septic/icons/effects/mouse_pointers/normal.dmi'
	var/combat_cursor_icon = 'modular_septic/icons/effects/mouse_pointers/combat.dmi'
	var/examine_cursor_icon_combat = 'modular_septic/icons/effects/mouse_pointers/combat_examine.dmi'

/mob/Initialize(mapload)
	. = ..()
	set_hydration(rand(HYDRATION_LEVEL_START_MIN, HYDRATION_LEVEL_START_MAX))
	attribute_initialize()

/mob/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	return SCREENTIP_MOB(uppertext(name))

/mob/update_action_buttons(reload_screen)
	if(!client || !hud_used?.peeper_active || !hud_used.peeper)
		return

	var/button_number = 0
	var/atom/movable/screen/movable/action_button/action_button
	for(var/datum/action/action in actions)
		action.UpdateButtonIcon()
		action_button = action.button
		button_number++
		action_button.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number)

	if(reload_screen && istype(hud_used.peeper.current_tab, /datum/peeper_tab/action))
		hud_used.peeper.current_tab.hide_tab()
		hud_used.peeper.current_tab.show_tab()

	hud_used.hide_actions_toggle.screen_loc = null

/// Attributes
/mob/proc/attribute_initialize()
	// If we have an attribute holder, lets get that W
	if(!ispath(attributes))
		return
	attributes = new attributes(src)

/// Adjust the hydration of a mob
/mob/proc/adjust_hydration(change)
	hydration = max(0, hydration + change)

/// Force set the mob hydration
/mob/proc/set_hydration(change)
	hydration = max(0, change)
