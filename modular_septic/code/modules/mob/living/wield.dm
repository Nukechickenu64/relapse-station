// Wielding procs
/mob/living/proc/wield_active_hand()
	var/obj/item/active = get_active_held_item()
	if(istype(active))
		active.wield_act(src)
	else
		to_chat(src, span_warning("You have nothing to wield!"))

/mob/living/proc/wield_ui_on()
	if(hud_used?.wield)
		hud_used.wield.active = TRUE
		hud_used.wield.update_appearance()
		return TRUE

/mob/living/proc/wield_ui_off()
	if(hud_used?.wield)
		hud_used.wield.active = FALSE
		hud_used.wield.update_appearance()
		return TRUE
