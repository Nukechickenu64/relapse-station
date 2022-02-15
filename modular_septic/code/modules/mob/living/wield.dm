// Wielding procs
/mob/living/proc/wield_active_hand()
	var/obj/item/active = get_active_held_item()
	if(istype(active))
		active.wield_act(src)
	else
		to_chat(src, span_warning("You have nothing to wield!"))

/mob/living/proc/wield_ui_on()
	if(hud_used)
		if(hud_used.wield)
			hud_used.wield.active = TRUE
			hud_used.wield.update_appearance()
		var/atom/movable/screen/inventory/left_hand = hud_used.hand_slots["[LEFT_HANDS]"]
		var/atom/movable/screen/inventory/right_hand = hud_used.hand_slots["[RIGHT_HANDS]"]
		left_hand?.update_appearance()
		right_hand?.update_appearance()
		var/obj/item/active_item = hud_used.mymob?.get_active_held_item()
		if(active_item?.screen_loc)
			if(!(hud_used.mymob.active_hand_index % RIGHT_HANDS))
				active_item.screen_loc = ui_hand_position(hud_used.mymob.active_hand_index, -world.icon_size/2)
			else
				active_item.screen_loc = ui_hand_position(hud_used.mymob.active_hand_index, world.icon_size/2)
		return TRUE
	return FALSE

/mob/living/proc/wield_ui_off()
	if(hud_used)
		if(hud_used.wield)
			hud_used.wield.active = FALSE
			hud_used.wield.update_appearance()
		var/atom/movable/screen/inventory/left_hand = hud_used.hand_slots["[LEFT_HANDS]"]
		var/atom/movable/screen/inventory/right_hand = hud_used.hand_slots["[RIGHT_HANDS]"]
		left_hand?.update_appearance()
		right_hand?.update_appearance()
		var/obj/item/active_item = hud_used.mymob?.get_active_held_item()
		if(active_item?.screen_loc)
			active_item.screen_loc = ui_hand_position(hud_used.mymob.active_hand_index)
		return TRUE
	return FALSE
