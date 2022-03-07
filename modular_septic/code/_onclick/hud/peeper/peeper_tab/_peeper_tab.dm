/datum/peeper_tab
	/// The peeper datum that owns us
	var/datum/peeper/mypeeper

/datum/peeper_tab/New(datum/peeper/owner)
	. = ..()
	if(owner)
		mypeeper = owner

/datum/peeper_tab/proc/show_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/visible_atoms = get_visible_screen_atoms()
	if(visible_atoms)
		mypeeper.myhud.mymob.client.screen |= visible_atoms

/datum/peeper_tab/proc/hide_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/screen_atoms = get_all_screen_atoms()
	if(screen_atoms)
		mypeeper.myhud.mymob.client.screen -= screen_atoms

/datum/peeper_tab/proc/get_all_screen_atoms()

/datum/peeper_tab/proc/get_visible_screen_atoms()
