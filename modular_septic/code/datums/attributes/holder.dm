/datum/attribute_holder
	/// Mob we are attached to
	var/mob/parent
	/// Default value for non-skill attributes
	var/attribute_default = ATTRIBUTE_DEFAULT
	/// Minimum value for non-skill attributes
	var/attribute_min = ATTRIBUTE_MIN
	/// Maximum value for non-skill attributes
	var/attribute_max = ATTRIBUTE_MAX
	/// Default value for non-specified skills
	var/skill_default = SKILL_DEFAULT
	/// Minimum value for skill attributes
	var/skill_min = SKILL_MIN
	/// Maximum value for skill attributes
	var/skill_max = SKILL_MAX
	/// Attribute list, counting modifiers
	var/list/attribute_list = list()
	/// Associative list, attribute path = value
	var/list/raw_attribute_list = list()
	/// List of attribute modifiers applying to this holder
	var/list/attribute_modification //Lazy list, see attribute_modifier.dm
	/// Attribute modifier immunities
	var/list/attribute_mod_immunities //Lazy list, see attribute_modifier.dm
	/// Diceroll modifier to be added on top of diceroll
	var/cached_diceroll_modifier = 0
	/// List of diceroll modifiers applying to this holder
	var/list/diceroll_modification //Lazy list, see attribute_modifier.dm
	/// Diceroll modifier immunities
	var/list/diceroll_mod_immunities //Lazy list, see attribute_modifier.dm

/datum/attribute_holder/New(mob/new_parent)
	. = ..()
	for(var/attribute in GLOB.all_attributes)
		if(!raw_attribute_list[attribute])
			if(ispath(attribute, /datum/attribute/skill))
				raw_attribute_list[attribute] = skill_default
			else
				raw_attribute_list[attribute] = attribute_default
		else
			if(ispath(attribute, /datum/attribute/skill))
				raw_attribute_list[attribute] = clamp(raw_attribute_list[attribute], skill_min, skill_max)
			else
				raw_attribute_list[attribute] = clamp(raw_attribute_list[attribute], attribute_min, attribute_max)
	if(new_parent)
		set_parent(new_parent)

/datum/attribute_holder/Destroy()
	. = ..()
	set_parent(null)
	attribute_list?.Cut()
	raw_attribute_list?.Cut()
	attribute_mod_immunities?.Cut()
	for(var/thing in attribute_modification)
		remove_attribute_modifier(thing, FALSE) //they lazyremove themselves
	closely_inspected_attribute = null

/**
 * Returns the raw value of a skill, taking into account the raw value of the related attribute
 */
/datum/attribute_holder/proc/return_raw_effective_skill(skill_type)
	var/skill_value = raw_attribute_list[skill_type]
	var/datum/attribute/skill/skill = GET_ATTRIBUTE_DATUM(skill_type)
	if(istype(skill) && LAZYLEN(skill.default_attributes))
		for(var/attribute_type in skill.default_attributes)
			var/default_value = raw_attribute_list[attribute_type]
			default_value += skill.default_attributes[attribute_type]
			// Rule of 20
			default_value = min(default_value, ATTRIBUTE_MASTER)
			// Only use the default if it's higher than our skill value
			skill_value = max(default_value, skill_value)
	return skill_value

/**
 * Returns the effective value of a skill, taking into account the raw value of the related attribute
 */
/datum/attribute_holder/proc/return_effective_skill(skill_type)
	var/skill_value = attribute_list[skill_type]
	var/datum/attribute/skill/skill = GET_ATTRIBUTE_DATUM(skill_type)
	if(istype(skill) && LAZYLEN(skill.default_attributes))
		for(var/attribute_type in skill.default_attributes)
			var/default_value = attribute_list[attribute_type]
			default_value += skill.default_attributes[attribute_type]
			// Rule of 20
			default_value = min(default_value, ATTRIBUTE_MASTER)
			// Only use the default if it's higher than our skill value
			skill_value = max(default_value, skill_value)
	return skill_value

/**
 * Sets a mob as our owner.
 */
/datum/attribute_holder/proc/set_parent(mob/new_parent)
	if(new_parent)
		parent = new_parent
		new_parent.attributes = src
	else
		parent.attributes = null
		parent = null
	update_attributes()

/**
 * Adds up attributes from a sheet
 */
/datum/attribute_holder/proc/add_sheet(datum/attribute_holder/sheet/to_add)
	if(ispath(to_add, /datum/attribute_holder/sheet))
		if(GLOB.attribute_sheets[to_add])
			to_add = GLOB.attribute_sheets[to_add]
		else
			to_add = GLOB.attribute_sheets[to_add] = new to_add()
	else if(!istype(to_add))
		return
	add_holder(to_add)

/**
 * Adds up another holder's attributes
 */
/datum/attribute_holder/proc/add_holder(datum/attribute_holder/to_add)
	for(var/thing in to_add.raw_attribute_list)
		if(ispath(thing, /datum/attribute/skill))
			raw_attribute_list[thing] = clamp(raw_attribute_list[thing] + to_add.raw_attribute_list[thing], skill_min, skill_max)
		else
			raw_attribute_list[thing] = clamp(raw_attribute_list[thing] + to_add.raw_attribute_list[thing], attribute_min, attribute_max)
	to_add.on_add(src)
	update_attributes()

/**
 * Stuff we do when another holder adds us
 */
/datum/attribute_holder/proc/on_add(datum/attribute_holder/plagiarist)
	return

/**
 * Adds up attributes from a sheet
 */
/datum/attribute_holder/proc/subtract_sheet(datum/attribute_holder/sheet/to_remove)
	if(ispath(to_remove, /datum/attribute_holder/sheet))
		if(GLOB.attribute_sheets[to_remove])
			to_remove = GLOB.attribute_sheets[to_remove]
		else
			to_remove = GLOB.attribute_sheets[to_remove] = new to_remove()
	else if(!istype(to_remove))
		return
	subtract_holder(to_remove)

/**
 * Subtracts another holder's attributes
 */
/datum/attribute_holder/proc/subtract_holder(datum/attribute_holder/to_remove)
	for(var/thing in to_remove.raw_attribute_list)
		if(ispath(thing, /datum/attribute/skill))
			raw_attribute_list[thing] = clamp(raw_attribute_list[thing] - to_remove.raw_attribute_list[thing], skill_min, skill_max)
		else
			raw_attribute_list[thing] = clamp(raw_attribute_list[thing] - to_remove.raw_attribute_list[thing], attribute_min, attribute_max)
	to_remove.on_remove(src)
	update_attributes()

/**
 * Stuff we do when another holder removes us
 */
/datum/attribute_holder/proc/on_remove(datum/attribute_holder/plagiarist)
	return

/**
 * Copies attributes from a sheet
 */
/datum/attribute_holder/proc/copy_sheet(datum/attribute_holder/sheet/to_copy)
	if(ispath(to_copy, /datum/attribute_holder/sheet))
		if(GLOB.attribute_sheets[to_copy])
			to_copy = GLOB.attribute_sheets[to_copy]
		else
			to_copy = GLOB.attribute_sheets[to_copy] = new to_copy()
	else if(!istype(to_copy))
		return
	copy_holder(to_copy)

/**
 * Copies another holder's raw attributes
 */
/datum/attribute_holder/proc/copy_holder(datum/attribute_holder/to_copy)
	raw_attribute_list = to_copy.raw_attribute_list.Copy()
	to_copy.on_copy(src)
	update_attributes()

/**
 * Stuff we do when another holder copies us
 */
/datum/attribute_holder/proc/on_copy(datum/attribute_holder/plagiarist)
	return

/**
 * Returns a probability value from an attribute, to be used in prob()
 * You should use the diceroll proc instead, but yeah this works too.
 */
/datum/attribute_holder/proc/attribute_probability(modifier = ATTRIBUTE_MIDDLING, base_prob = 50, delta_value = ATTRIBUTE_MIDDLING, increment = 5)
	return (base_prob + (modifier - delta_value) * increment)

/**
 * DICE ROLL
 * Add this to the action and specify what will happen in each outcome.
 * Modifier should be the get_value() of an attribute.
 *
 * Important! you should not use more than one stat in proc but if you really want to,
 * you should multiply amount of dices and crit according to how many of them you added to the formula.
 *
 * If you don't care about crits, just count them as being the same as normal successes/failures.
 */
/datum/attribute_holder/proc/diceroll(requirement = 0, \
									crit = 10, \
									dice_num = 3, \
									dice_sides = 6, \
									count_modifiers = TRUE, \
									return_flags = RETURN_DICE_SUCCESS)
	//Get our dice result
	var/dice = roll(dice_num, dice_sides)

	//Get the necessary number to pass the roll
	var/requirement_sum = requirement
	if(count_modifiers)
		//diceroll modifiers assume you use 1d18, so we gotta account for that
		var/final_modifier = (cached_diceroll_modifier/18)*dice_num*dice_sides
		if(final_modifier >= 0)
			final_modifier = CEILING(final_modifier, 1)
		else
			final_modifier = FLOOR(final_modifier, 1)
		requirement_sum += final_modifier

	//Get the difference, might be necessary
	var/difference = (requirement_sum - dice)

	//Return whether it was a failure or a success
	var/success_result
	if(dice <= requirement_sum)
		var/bonus = 0
		//god forgive me for writing this
		if((dice_num == 3) && (dice_sides == 6))
			bonus = 1
			if(requirement_sum >= 15)
				bonus = 2
			if(requirement_sum >= 16)
				bonus = 3
		if(dice <= max(dice_num+bonus, requirement_sum - crit))
			success_result = DICE_CRIT_SUCCESS
		else
			success_result = DICE_SUCCESS
	else
		var/malus = 0
		//god forgive me for writing this, especially
		if((dice_num == 3) && (dice_sides == 6) && (requirement_sum <= 15))
			malus = 1
		if(dice >= min(dice_num*dice_sides-malus, requirement_sum + crit))
			success_result = DICE_CRIT_FAILURE
		else
			success_result = DICE_FAILURE
	if(CHECK_MULTIPLE_BITFIELDS(return_flags, RETURN_DICE_SUCCESS|RETURN_DICE_DIFFERENCE))
		return list(RETURN_DICE_INDEX_SUCCESS = success_result, \
					RETURN_DICE_INDEX_DIFFERENCE = difference)
	else if(return_flags & RETURN_DICE_DIFFERENCE)
		return difference
	return success_result

/datum/attribute_holder/proc/print_skills(mob/user, show_all = FALSE)
	var/list/output = list()
	output += "<span class='infoplain'><div class='infobox'>"
	var/list/skills_by_category = list()
	for(var/thing in attribute_list)
		if(ispath(thing,  /datum/attribute/skill))
			var/datum/attribute/skill/skill = GLOB.all_skills[thing]
			//Only gather the skills we actually have, unless we want to be shown regardless
			if(show_all || (attribute_list[thing] >= 1))
				if(skills_by_category[skill.category])
					skills_by_category[skill.category] += skill
				else
					skills_by_category[skill.category] = list(skill)

	for(var/category in skills_by_category)
		if(skills_by_category.Find(category) == 1)
			output += span_notice("<EM>[category]</EM>")
		else
			output += span_notice("\n<EM>[category]</EM>")
		for(var/thing in skills_by_category[category])
			var/datum/attribute/skill/skill = thing
			var/raw_skill = raw_attribute_list[skill.type]
			var/total_skill = attribute_list[skill.type]
			var/total_style = "class='info'"
			if(total_skill > raw_skill)
				total_style =  "class='green'"
			else if(total_skill < raw_skill)
				total_style = "class='red'"
			var/difficulty_string = " \[[capitalize_like_old_man(skill.difficulty)]\]"
			output += "\n<span class='info'>\
				• <b>[capitalize_like_old_man(skill.name)][difficulty_string]:</b> \
				[capitalize_like_old_man(skill.description_from_level(raw_skill))] \
				(<span [total_style]>[attribute_list[skill.type]]</span>/[raw_attribute_list[skill.type]]).\
				</span>"
	if(!LAZYLEN(skills_by_category))
		output += span_info("I am genuinely, absolutely and completely useless.")
	output += "</div></span>" //div infobox
	to_chat(user, jointext(output, ""))

/datum/attribute_holder/proc/print_stats(mob/user)
	var/list/output = list()
	output += "<span class='infoplain'><div class='infobox'>"
	var/list/stats = list()
	for(var/thing in attribute_list)
		if(ispath(thing, STAT))
			var/datum/attribute/attribute = GLOB.all_stats[thing]
			stats += attribute
	output += span_notice("<EM>Stats</EM>")
	for(var/thing in stats)
		var/datum/attribute/stat/stat = thing
		var/total_style = "class='info'"
		if(attribute_list[stat.type] > raw_attribute_list[stat.type])
			total_style =  "class='green'"
		else if(attribute_list[stat.type] < raw_attribute_list[stat.type])
			total_style = "class='red'"
		output += "\n<span class='info'>\
			• <b>[capitalize_like_old_man(stat.name)] ([stat.shorthand]):</b> \
			[capitalize(stat.description_from_level(attribute_list[stat.type]))] \
			(<span [total_style]>[attribute_list[stat.type]]</span>/[raw_attribute_list[stat.type]]).\
			</span>"
	output += "</div></span>" //div infobox
	to_chat(user, jointext(output, ""))
