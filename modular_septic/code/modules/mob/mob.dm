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

/mob/update_action_buttons(reload_screen = TRUE)
	if(!client || !hud_used.peeper)
		return

	var/datum/peeper_tab/actions/peeper_actions = hud_used.peeper.peeper_tabs[/datum/peeper_tab/actions]
	var/atom/movable/screen/movable/action_button/action_button
	var/list/actions_list = list()
	for(var/datum/action/action as anything in actions)
		action.UpdateButtonIcon()
		action_button = action.button
		actions_list[action] = action_button

	var/should_reload_screen = FALSE
	if(hud_used.peeper_active && istype(hud_used.peeper.current_tab, /datum/peeper_tab/action))
		should_reload_screen = TRUE
		hud_used.peeper.current_tab.hide_tab()
	peeper_actions?.action_buttons = actions_list
	if(should_reload_screen && reload_screen)
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
