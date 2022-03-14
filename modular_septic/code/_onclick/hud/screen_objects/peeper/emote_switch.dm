/atom/movable/screen/emote_loadout
	name = "emote loadout"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "close"
	plane = PEEPER_PLANE
	layer = PEEPER_SWITCH_LAYER
	/// Emote tab we are associated with
	var/datum/peeper_tab/emotes/mytab
	/// Does this move the loadout index up or down?
	var/loadout_up = FALSE

/atom/movable/screen/emote_loadout/Click(location, control, params)
	. = ..()
	if(!mytab)
		return
	if(loadout_up)
		mytab.loadout_up()
	else
		mytab.loadout_down()

/atom/movable/screen/emote_loadout/up
	name = "peeper loadout up"
	icon_state = "emote_up"
	loadout_up = TRUE
	screen_loc = ui_peeper_emote_loadout_up

/atom/movable/screen/emote_loadout/down
	name = "peeper loadout down"
	icon_state = "emote_down"
	loadout_up = FALSE
	screen_loc = ui_peeper_emote_loadout_down
