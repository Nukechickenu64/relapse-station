/datum/attribute_holder/sheet/traitor
	raw_attribute_list = list(SKILL_MELEE = 6, \
							SKILL_RANGED = 6, \
							SKILL_ELECTRONICS = 4, \
							SKILL_LOCKPICKING = 4)
	attribute_default = 0
	skill_default = 0

/datum/attribute_holder/sheet/traitor/on_add(datum/attribute_holder/plagiarist)
	. = ..()
	var/static/list/magic_attribute_variations = list(SKILL_MELEE, \
													SKILL_RANGED, \
													SKILL_ELECTRONICS, \
													SKILL_LOCKPICKING)
	for(var/attribute_type in magic_attribute_variations)
		if(ispath(attribute_type, SKILL))
			plagiarist.raw_attribute_list[attribute_type] = clamp(plagiarist.raw_attribute_list[attribute_type] + rand(-2, 2), plagiarist.skill_min, plagiarist.skill_max)
