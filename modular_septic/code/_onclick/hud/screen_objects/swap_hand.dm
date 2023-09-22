/atom/movable/screen/swap_hand
	name = "click delay"
	icon = 'modular_web/icons/hud/delaybeta.dmi'
	icon_state = "cooldown_8"
	base_icon_state = "cooldown"
	var/last_user_move = 0
	var/target_time = 0

/atom/movable/screen/swap_hand/process(delta_time)
	update_icon_state(UPDATE_ICON_STATE)
	if(world.time >= target_time)
		return PROCESS_KILL

/atom/movable/screen/swap_hand/update_icon_state()
	. = ..()
	var/completion = clamp(FLOOR(8-(((target_time - world.time)/(target_time - last_user_move))*8), 1), 0, 8)
	icon_state = "[base_icon_state]_[completion]"
