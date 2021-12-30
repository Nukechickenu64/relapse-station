// General combat skills
/datum/attribute/skill/acrobatics
	name = "Acrobatics"
	desc = "Ability at acrobatic maneuvers and climbing obstacles."
	category = SKILL_CATEGORY_COMBAT
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Skulduggery skills
/datum/attribute/skill/pickpocket
	name = "Pickpocketing"
	desc = "Ability to steal without being noticed."
	category = SKILL_CATEGORY_SKULDUGGERY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/lockpicking
	name = "Lockpicking"
	desc = "Ability at breaking mechanical locks open."
	category = SKILL_CATEGORY_SKULDUGGERY
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/forensics
	name = "Forensics"
	desc = "Proficiency at analyzing the clues and tracks of your enemies."
	category = SKILL_CATEGORY_SKULDUGGERY
	default_attributes = list(
		STAT_PERCEPTION = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Medical skills
/datum/attribute/skill/medicine
	name = "Medicine"
	desc = "Proficiency at diagnosis and treatment of physical ailments, and handling of medical instruments."
	category = SKILL_CATEGORY_MEDICAL
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/surgery
	name = "Surgery"
	desc = "Knowledge in humanoid anatomy, as well as surgical procedures and tools."
	default_attributes = list(
		SKILL_MEDICINE = -8,
	)
	category = SKILL_CATEGORY_MEDICAL
	difficulty = SKILL_DIFFICULTY_HARD

// Engineering skills
/datum/attribute/skill/masonry
	name = "Masonry"
	desc = "Ability to create infrastructure, structure and furniture out of various materials."
	category = SKILL_CATEGORY_ENGINEERING
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/smithing
	name = "Smithing"
	desc = "Ability to create weapons, armor and other items out of metal."
	category = SKILL_CATEGORY_ENGINEERING
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/electronics
	name = "Electronics"
	desc = "Ability at handling, hacking and repairing electrical machinery and wiring."
	category = SKILL_CATEGORY_ENGINEERING
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

// Research skills
/datum/attribute/skill/science
	name = "Science"
	desc = "Comprehension, research, experimentation and creation of complex technology."
	category = SKILL_CATEGORY_RESEARCH
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/chemistry
	name = "Chemistry"
	desc = "Capability at handling chemicals and chemical reactions."
	category = SKILL_CATEGORY_RESEARCH
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Domestic skills
/datum/attribute/skill/culinary
	name = "Culinary"
	desc = "Ability at preparing and cooking food."
	category = SKILL_CATEGORY_DOMESTIC
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
		SKILL_CLEANING = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/agriculture
	name = "Agriculture"
	desc = "Ability at planting and harvesting produce."
	category = SKILL_CATEGORY_DOMESTIC
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/cleaning
	name = "Housekeeping"
	desc = "This is the ability to manage a household. It covers both home economics and domestic chores like cleaning."
	category = SKILL_CATEGORY_DOMESTIC
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Dumb meme skills
/datum/attribute/skill/gaming
	name = "Gaming"
	desc = "Ability at getting totally EPIC kill streaks in fortnight. \
		Applies as competence in both video games, board games and puzzles."
	category = SKILL_CATEGORY_DUMB
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
