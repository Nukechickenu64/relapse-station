/**
 * THE PEEPER
 * This datum controls a separate section of the hud, that can be accessed by the stat panel.
 * This should be composed of hud elements that don't really need to be constantly shown to the player.
 */
/datum/peeper
	/// Hud that owns us
	var/datum/hud/myhud
	/// Button the user clicks on to hide us
	var/atom/movable/screen/peeper_hide/closer
	/// Tab we are currently on
	var/datum/peeper_tab/current_tab
	/// All peeper tabs available to us
	var/list/datum/peeper_tab/peeper_tabs = list()

/datum/peeper/New(datum/hud/owner)
	. = ..()
	closer = new(myhud)
	if(owner)
		myhud = owner
	add_default_peeper_tabs()

/datum/peeper/proc/show_peeper(mob/shown_to)
	if(!shown_to?.client)
		return
	winset(shown_to.client, "statbrowser", "is-visible=false")
	winset(shown_to.client, "statmap", "is-visible=true")
	current_tab?.show_tab()
	shown_to.client.screen |= closer

/datum/peeper/proc/hide_peeper(mob/hidden_from)
	if(!hidden_from?.client)
		return
	winset(hidden_from.client, "statbrowser", "is-visible=true")
	winset(hidden_from.client, "statmap", "is-visible=false")
	current_tab?.hide_tab()
	hidden_from.client.screen -= closer

/datum/peeper/proc/add_default_peeper_tabs()
	var/datum/peeper_tab/main/main_peeper_tab = add_peeper_tab(/datum/peeper_tab/main)
	change_tab(main_peeper_tab)

/datum/peeper/proc/add_peeper_tab(datum/peeper_tab/tab_type)
	var/datum/peeper_tab/new_peeper
	if(istype(tab_type))
		new_peeper = tab_type
	else
		new_peeper = new tab_type(src)
	peeper_tabs |= new_peeper
	return new_peeper

/datum/peeper/proc/change_tab(datum/peeper_tab/new_tab)
	current_tab?.hide_tab()
	current_tab = new_tab
	current_tab?.show_tab()

