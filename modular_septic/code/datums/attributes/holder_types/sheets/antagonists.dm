/datum/attribute_holder/sheet/traitor
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 6, \
							SKILL_PISTOL = 6, \
							SKILL_RIFLE = 6, \
							SKILL_SHOTGUN = 6, \
							SKILL_ELECTRONICS = 4, \
							SKILL_LOCKPICKING = 4)
	attribute_default = 0
	skill_default = null

/datum/attribute_holder/sheet/traitor/on_add(datum/attribute_holder/plagiarist)
	. = ..()
	//we will always have at least 0 in these skills, this is intentional
	var/static/list/magic_attribute_variations = list(SKILL_IMPACT_WEAPON, \
													SKILL_RIFLE, \
													SKILL_ELECTRONICS, \
													SKILL_LOCKPICKING)
	for(var/attribute_type in magic_attribute_variations)
		if(ispath(attribute_type, SKILL))
			plagiarist.raw_attribute_list[attribute_type] = clamp(plagiarist.raw_attribute_list[attribute_type] + rand(-2, 2), plagiarist.skill_min, plagiarist.skill_max)
