/atom/movable/screen/peeper_tab_switch
	name = "Peeper Tab Switch"
	desc = "Switches to a tab that does something."
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "tab"
	plane = PEEPER_PLANE
	layer = PEEPER_SWITCH_LAYER
	/// Tooltip style we use
	var/tooltipstyle = ""
	/// Tab we are associated with
	var/datum/peeper_tab/mytab

/atom/movable/screen/peeper_tab_switch/MouseEntered(location,control,params)
	. = ..()
	if(!QDELETED(src))
		openToolTip(usr,src,params,title = name,content = desc,theme = tooltipstyle)

/atom/movable/screen/peeper_tab_switch/MouseExited()
	. = ..()
	closeToolTip(usr)

/atom/movable/screen/peeper_tab_switch/New(datum/peeper_tab/peeper_tab)
	. = ..()
	if(peeper_tab)
		mytab = peeper_tab
		name = "Switch to [peeper_tab.name] tab"
		desc = peeper_tab.desc
		icon = peeper_tab.icon
		icon_state = peeper_tab.icon_state

/atom/movable/screen/peeper_tab_switch/Destroy()
	. = ..()
	if(mytab?.switch_button == src)
		mytab.switch_button = null
		mytab.mypeeper?.update_tab_switches()
	mytab = null

/atom/movable/screen/peeper_tab_switch/Click(location, control, params)
	. = ..()
	mytab?.mypeeper?.change_tab(mytab)
