#define ACTIONS_PER_LOADOUT 12

/datum/peeper_tab/actions
	name = "Action"
	desc = "Tab that contains actions for your character to perform."
	icon_state = "action_tab"
	/// Action buttons currently being exhibited
	var/list/atom/movable/screen/movable/action_button/current_action_buttons = list()
	/// This list is kept up to date with all the fucking action buttons our owner has
	var/list/atom/movable/screen/movable/action_button/action_buttons = list()
	/// In case we have too many actions, which ones are we exhibiting?
	var/current_action_loadout = 0

/datum/peeper_tab/actions/show_tab()
	update_action_buttons()
	return ..()

/datum/peeper_tab/actions/get_all_screen_atoms()
	. = ..()
	. |= flatten_list(action_buttons)

/datum/peeper_tab/actions/get_visible_screen_atoms()
	. = ..()
	. |= current_action_buttons

/datum/peeper_tab/actions/proc/update_action_buttons()
	current_action_buttons = list()
	var/counter = 0
	var/current_button = 0
	var/actions_per_row = ACTIONS_PER_LOADOUT/3
	var/atom/movable/screen/movable/action_button/action_button
	for(var/action in action_buttons)
		action_button = action_buttons[action]
		counter++
		//only display actions that match the current tab
		if(counter <= (current_action_loadout * ACTIONS_PER_LOADOUT))
			continue
		if(current_button >= ACTIONS_PER_LOADOUT)
			break
		var/width = 1 + (current_button % actions_per_row)
		var/height = 3 - FLOOR(current_button/actions_per_row, 1)
		current_action_buttons |= action_button
		action_button.screen_loc = "statmap:[width],[height]"
		current_button++
	/* SEPTIC EDIT REMOVAL
	current_loadout_switches = list()
	var/max_loadout = FLOOR((counter-1)/EMOTES_PER_LOADOUT, 1)
	if(current_emote_loadout > 0)
		current_loadout_switches |= loadout_up
	if(current_emote_loadout < max_loadout)
		current_loadout_switches |= loadout_down
	*/
	return TRUE

#undef ACTIONS_PER_LOADOUT
