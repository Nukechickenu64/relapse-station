/datum/peeper_tab/emotes
	name = "Emote"
	desc = "Tab that contains shortcuts to emotes."
	icon_state = "emote_tab"
	/// Emote buttons currently being exhibited
	var/list/current_emote_buttons = list()
	/// Emote screen atoms indexed by emote datum
	var/list/emote_buttons_by_emote_type = list()
	/// Emote screen atoms, not indexed by type
	var/list/emote_buttons = list()
	/// Help button that always appears on this tab
	var/atom/movable/screen/emote/help
	/// In case we have too many emotes, which ones are we exhibiting?
	var/current_emote_loadout = 0

/datum/peeper_tab/emotes/initialize_screen_atoms()
	. = ..()
	var/datum/emote/help/help_emote = GLOB.emote_list["help"][1]
	help = new /atom/movable/screen/emote(help_emote)
	help.screen_loc = "statmap:5,1:16"

/datum/peeper_tab/emotes/Destroy()
	. = ..()
	current_emote_buttons = null
	emote_buttons_by_emote_type = null
	QDEL_NULL(help)
	QDEL_LIST(emote_buttons)

/datum/peeper_tab/emotes/show_tab()
	update_emote_buttons()
	return ..()

/datum/peeper_tab/emotes/get_all_screen_atoms()
	. = ..()
	. |= help
	. |= emote_buttons

/datum/peeper_tab/emotes/get_visible_screen_atoms()
	. = ..()
	. |= help
	. |= current_emote_buttons

/datum/peeper_tab/emotes/proc/update_emote_buttons()
	current_emote_buttons = list()
	var/width = 0
	var/height = 8
	var/counter = 0
	var/fucked = FALSE
	var/list/emotes_counted = list()
	var/datum/emote/emote_datum
	var/list/emote_list
	for(var/act as anything in (GLOB.emote_list-"help"))
		emote_list = GLOB.emote_list[act]
		for(var/emote in emote_list)
			emote_datum = emote
			//this emote has already been dealt with
			if(act in emotes_counted)
				continue
			if(mypeeper?.myhud?.mymob && emote_datum.can_run_emote(mypeeper.myhud.mymob, FALSE, TRUE))
				counter++
				emotes_counted |= act
			//only display emotes that match the current tab
			if(counter <= (current_emote_loadout * 16))
				continue
			height--
			if(height < 0)
				width++
				if(width > 1)
					fucked = TRUE
					break
				height = 8
				height--
			var/atom/movable/screen/emote/emote_button = emote_buttons_by_emote_type[emote_datum.type]
			if(!emote_button)
				emote_button = new(emote_datum)
				emote_button.hud = mypeeper?.myhud
				emote_buttons |= emote_button
				emote_buttons_by_emote_type[emote_datum.type] = emote_button
			current_emote_buttons |= emote_button
			emote_button.screen_loc = "statmap:1:[width*64],0:[height*16]"
		if(fucked)
			break
