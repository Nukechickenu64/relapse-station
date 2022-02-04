//proc for switching combat styles
/mob/living/proc/switch_combat_style(new_style, silent = FALSE)
	if(new_style == combat_style)
		return
	combat_style = new_style
	switch(combat_style)
		if(CS_NONE, CS_FEINT, CS_GUARD, CS_DEFEND, CS_STRONG, CS_FURY, CS_AIMED, CS_DUAL, CS_WEAK)
			attributes?.remove_attribute_modifier(/datum/attribute_modifier/combat_style)
	if(!silent)
		print_combat_style(combat_style)
	return TRUE

//proc for printing info about a combat style
/mob/living/proc/print_combat_style(print_style = combat_style)
	var/message = "<span class='infoplain'><div class='infobox'>"
	switch(print_style)
		if(CS_NONE)
			message += span_largeinfo("None")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click will perform no special attacks - Useful to perform miscellaneous item interactions.")
		if(CS_FEINT)
			message += span_largeinfo("Feint")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to perform a feint attack. If successful, target will parry prematurely, leaving them open for a real attack.\nPrice: A bad idea if the enemy is not planning to parry.")
		if(CS_DUAL)
			message += span_largeinfo("Dual")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to attack with the item in your offhand.\nPrice: You will be less accurate with either hand.")
		if(CS_GUARD)
			message += span_largeinfo("Guard")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click in combat mode to automatically attack anyone who approaches. A shooting weapon allows targetting any tile in vision. Switching to another combat style will reset your guard.")
		if(CS_DEFEND)
			message += span_largeinfo("Defend")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Dodge and parry abilities are greatly heightened.\nPrice: Reduced damage output, reduced movement speed and vulnerability to feint attacks.")
		if(CS_STRONG)
			message += span_largeinfo("Strong")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to perform a strong attack. You will hit for maximum damage.\nPrice: Attack is slow, and quickly fatigues.")
		if(CS_FURY)
			message += span_largeinfo("Fury")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click to attack quickly and recklessly. Parrying furious attacks will greatly hinder the target's dodge and parry.\nPrice: -2 ST.")
		if(CS_AIMED)
			message += span_largeinfo("Aimed")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Right click for an aimed attack. Far less likely to miss attack attempts.\nPrice: Attacks are very slow")
		if(CS_WEAK)
			message += span_largeinfo("Weak")
			message += "\n<br><hr class='infohr'>\n"
			message += span_info("Significantly reduces damage in melee combat - Useful for a friendly brawl or to non-lethally subdue someone.")
	message += "</div></span>"
	to_chat(src, message)
