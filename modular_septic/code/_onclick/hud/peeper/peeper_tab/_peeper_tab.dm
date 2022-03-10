/datum/peeper_tab
	/// Name of this tab
	var/name = "something"
	/// Description of the tab, for the switch tooltip
	var/desc = "Tab that contains a bunch of stuff."
	/// Icon our switch uses
	var/icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	/// Icon state our switch uses
	var/icon_state = "tab"
	/// The peeper datum that owns us
	var/datum/peeper/mypeeper
	/// In case we have a switch button to switch to this tab
	var/atom/movable/screen/peeper_tab_switch/switch_button = /atom/movable/screen/peeper_tab_switch

/datum/peeper_tab/New(datum/peeper/owner)
	. = ..()
	if(switch_button)
		switch_button = new switch_button(src)
		switch_button.mytab = src
	set_peeper(owner)
	initialize_screen_atoms()

/datum/peeper_tab/Destroy()
	. = ..()
	if(mypeeper)
		mypeeper.remove_peeper_tab(src)
		mypeeper = null
	if(switch_button)
		QDEL_NULL(switch_button)

/datum/peeper_tab/proc/set_peeper(datum/peeper/new_peeper)
	mypeeper = new_peeper
	if(switch_button)
		if(istype(new_peeper))
			switch_button.hud = new_peeper?.myhud
		else
			switch_button.hud = null

/datum/peeper_tab/proc/show_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/screen_atoms = get_visible_screen_atoms()
	if(screen_atoms)
		mypeeper.myhud.mymob.client.screen |= screen_atoms

/datum/peeper_tab/proc/hide_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/screen_atoms = get_all_screen_atoms()
	if(screen_atoms)
		mypeeper.myhud.mymob.client.screen -= screen_atoms

/datum/peeper_tab/proc/initialize_screen_atoms()

/datum/peeper_tab/proc/add_screen_atom(atom/movable/screen/screen_atom)
	if((mypeeper?.current_tab == src) && (mypeeper.myhud?.peeper_active) && mypeeper.myhud.mymob.client)
		hide_tab()
		show_tab()

/datum/peeper_tab/proc/remove_screen_atom(atom/movable/screen/screen_atom)
	if((mypeeper?.current_tab == src) && (mypeeper.myhud?.peeper_active) && mypeeper.myhud.mymob.client)
		mypeeper.myhud.mymob.client.screen -= screen_atom

/datum/peeper_tab/proc/get_all_screen_atoms()
	. = list()

/datum/peeper_tab/proc/get_visible_screen_atoms()
	. = list()
