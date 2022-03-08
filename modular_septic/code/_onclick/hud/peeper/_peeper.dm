/**
 * THE PEEPER
 * This datum controls a separate section of the hud, that can be accessed by the stat panel.
 * This should be composed of hud elements that don't really need to be constantly shown to the player.
 */
/datum/peeper
	/// Hud that owns us
	var/datum/hud/myhud
	/// Background, necessary so the peeper renders properly
	var/atom/movable/screen/peeper_background/background
	/// Button the user clicks on to hide us
	var/atom/movable/screen/peeper_close/closer
	/// Tab we are currently on
	var/datum/peeper_tab/current_tab
	/// All peeper tabs available to us
	var/list/datum/peeper_tab/peeper_tabs = list()
	/// All peeper tab switch objects available to us
	var/list/atom/movable/screen/peeper_tab_switch/peeper_tab_switches = list()
	/// In case we have too many tab switches, which switch "loadout" are we using?
	var/current_switch_loadout = 0

/datum/peeper/New(datum/hud/owner)
	. = ..()
	closer = new(myhud)
	background = new(myhud)
	if(owner)
		myhud = owner
		closer.hud = myhud
		background.hud = myhud
	add_default_peeper_tabs()

/datum/peeper/Destroy()
	. = ..()
	for(var/peeper_tab in peeper_tabs)
		remove_peeper_tab(peeper_tab)
		qdel(peeper_tab)
	current_tab = null
	peeper_tabs = null
	QDEL_NULL(closer)

/datum/peeper/proc/show_peeper(mob/shown_to)
	if(!shown_to?.client)
		return
	winset(shown_to.client, "statbrowser", "is-visible=false")
	winset(shown_to.client, "statmap", "is-visible=true")
	current_tab?.show_tab()
	shown_to.client.screen |= closer
	shown_to.client.screen |= background
	shown_to.client.screen |= peeper_tab_switches

/datum/peeper/proc/hide_peeper(mob/hidden_from)
	if(!hidden_from?.client)
		return
	winset(hidden_from.client, "statbrowser", "is-visible=true")
	winset(hidden_from.client, "statmap", "is-visible=false")
	current_tab?.hide_tab()
	hidden_from.client.screen -= closer
	hidden_from.client.screen -= background
	hidden_from.client.screen -= peeper_tab_switches

/datum/peeper/proc/add_default_peeper_tabs()
	var/datum/peeper_tab/main/main_peeper_tab = add_peeper_tab(/datum/peeper_tab/main)
	change_tab(main_peeper_tab)

/datum/peeper/proc/add_peeper_tab(datum/peeper_tab/tab_type)
	var/datum/peeper_tab/new_tab
	if(istype(tab_type))
		new_tab = tab_type
	else
		new_tab = new tab_type(src)
	peeper_tabs |= new_tab
	if(new_tab.switch_button)
		peeper_tab_switches |= new_tab.switch_button
	update_tab_switches()
	return new_tab

/datum/peeper/proc/remove_peeper_tab(datum/peeper_tab/removed_tab)
	if(!istype(removed_tab))
		for(var/peeper_tab in peeper_tabs)
			if(istype(peeper_tab, removed_tab))
				removed_tab = peeper_tab
				break
		if(!istype(removed_tab))
			return FALSE
	peeper_tabs -= removed_tab
	if(removed_tab.switch_button)
		peeper_tab_switches -= removed_tab.switch_button
	removed_tab.hide_tab()
	if(length(peeper_tabs))
		change_tab(peeper_tabs[1])
	update_tab_switches()
	return TRUE

/datum/peeper/proc/change_tab(datum/peeper_tab/new_tab)
	current_tab?.hide_tab()
	current_tab = new_tab
	current_tab?.show_tab()

/datum/peeper/proc/update_tab_switches()
	var/height = 4
	var/counter = 0
	for(var/atom/movable/screen/peeper_tab_switch/tab_switch as anything in peeper_tab_switches)
		counter++
		//only display switches that match the current tab
		if(counter < (current_switch_loadout * 4))
			tab_switch.screen_loc = null
			continue
		height--
		if(height < 0)
			break
		tab_switch.screen_loc = "statmap:0,[height]"
	return TRUE
