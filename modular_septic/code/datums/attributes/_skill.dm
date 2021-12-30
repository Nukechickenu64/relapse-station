/datum/attribute/skill
	/// Skill category we fall under - DO NOT FORGET TO SET THIS, IT BREAKS SHIT
	var/category = SKILL_CATEGORY_GENERAL
	/*
	 * Most skills have a related attribute which gets used on dicerolls when you don't know the skill
	 * This is an associative list of all possible attributes to get a default in return_effective_skill()
	 * Attribute - Modifier to be added to attribute
	 * Remember - Double defaults are not possible!
	 */
	var/list/default_attributes
	/// Difficulty of a skill, used when applying stat sheets to a character, etc
	var/difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/description_from_level(level)
	switch(CEILING(level, 1))
		if(-INFINITY to 2)
			return "unsalvageable"
		if(3,4)
			return "worthless"
		if(5,6)
			return "incompetent"
		if(7,8)
			return "novice"
		if(9,10)
			return "unskilled"
		if(11,12)
			return "competent"
		if(13,14)
			return "adept"
		if(15,16)
			return "versed"
		if(17,18)
			return "expert"
		if(19,20)
			return "master"
		if(21,22)
			return "legendary"
		if(23 to INFINITY)
			return "mythic"
		else
			return "invalid"
