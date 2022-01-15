#define GET_ATTRIBUTE_DATUM(path) GLOB.all_attributes[path]
#define GET_MOB_ATTRIBUTE_VALUE_RAW(mob, attribute_path) mob.attributes?.raw_attribute_list[attribute_path]
#define GET_MOB_ATTRIBUTE_VALUE(mob, attribute_path) mob.attributes?.attribute_list[attribute_path]
#define GET_MOB_SKILL_VALUE_RAW(mob, skill_path) mob.attributes?.return_raw_effective_skill(skill_path)
#define GET_MOB_SKILL_VALUE(mob, skill_path) mob.attributes?.return_effective_skill(skill_path)

// ~attribute/stat values
#define ATTRIBUTE_MIN 0
#define ATTRIBUTE_MAX 100

#define ATTRIBUTE_MIDDLING 10
#define ATTRIBUTE_MASTER 20

#define ATTRIBUTE_DEFAULT ATTRIBUTE_MIDDLING

// ~skill values
#define SKILL_MIN 0
#define SKILL_MAX 100

#define SKILL_MIDDLING 10
#define SKILL_MASTER 20

#define SKILL_DEFAULT SKILL_MIN

// ~diceroll results
#define DICE_CRIT_SUCCESS 2
#define DICE_SUCCESS 1
#define DICE_FAILURE 0
#define DICE_CRIT_FAILURE -1

// ~skill categories
#define SKILL_CATEGORY_GENERAL "General Skills"
#define SKILL_CATEGORY_MELEE "Melee Skills"
#define SKILL_CATEGORY_RANGED "Ranged Skills"
#define SKILL_CATEGORY_COMBAT "Combat Skills"
#define SKILL_CATEGORY_SKULDUGGERY "Skulduggery Skills"
#define SKILL_CATEGORY_MEDICAL "Medical Skills"
#define SKILL_CATEGORY_RESEARCH "Research Skills"
#define SKILL_CATEGORY_ENGINEERING "Engineering Skills"
#define SKILL_CATEGORY_DOMESTIC "Domestic Skills"
#define SKILL_CATEGORY_DUMB "Stupid Skills"

// ~skill difficulties
#define SKILL_DIFFICULTY_VERY_EASY "Very Easy"
#define SKILL_DIFFICULTY_EASY "Easy"
#define SKILL_DIFFICULTY_AVERAGE "Medium"
#define SKILL_DIFFICULTY_HARD "Hard"
#define SKILL_DIFFICULTY_VERY_HARD "Very Hard"

// ~path defines
#define STAT_STRENGTH /datum/attribute/stat/strength
#define STAT_DEXTERITY /datum/attribute/stat/dexterity
#define STAT_ENDURANCE /datum/attribute/stat/endurance
#define STAT_INTELLIGENCE /datum/attribute/stat/intelligence
#define STAT_PERCEPTION /datum/attribute/stat/perception
#define STAT_WILL /datum/attribute/stat/will

// ~melee combat skills
#define SKILL_MELEE /datum/attribute/skill/melee
#define SKILL_RAPIER /datum/attribute/skill/rapier
#define SKILL_SABER /datum/attribute/skill/saber
#define SKILL_SMALLSWORD /datum/attribute/skill/smallsword
#define SKILL_FLAIL /datum/attribute/skill/flail
#define SKILL_FLAIL_TWOHANDED /datum/attribute/skill/flail_twohanded
#define SKILL_IMPACT_WEAPON /datum/attribute/skill/impact_weapon
#define SKILL_IMPACT_WEAPON_TWOHANDED /datum/attribute/skill/impact_weapon_twohanded

// ~ranged combat skills
#define SKILL_RANGED /datum/attribute/skill/ranged
#define SKILL_THROWING /datum/attribute/skill/throwing

// ~general combat skills
#define SKILL_ACROBATICS /datum/attribute/skill/acrobatics

// ~skulduggery skills
#define SKILL_PICKPOCKET /datum/attribute/skill/pickpocket
#define SKILL_LOCKPICKING /datum/attribute/skill/lockpicking
#define SKILL_FORENSICS /datum/attribute/skill/forensics

// ~medical skills
#define SKILL_MEDICINE /datum/attribute/skill/medicine
#define SKILL_SURGERY /datum/attribute/skill/surgery

// ~engineering skills
#define SKILL_MASONRY /datum/attribute/skill/masonry
#define SKILL_SMITHING /datum/attribute/skill/smithing
#define SKILL_ELECTRONICS /datum/attribute/skill/electronics

// ~research skills
#define SKILL_SCIENCE /datum/attribute/skill/science
#define SKILL_CHEMISTRY /datum/attribute/skill/chemistry

// ~domestic skills
#define SKILL_COOKING /datum/attribute/skill/culinary
#define SKILL_BOTANY /datum/attribute/skill/agriculture
#define SKILL_CLEANING /datum/attribute/skill/cleaning

// ~dumb skills
#define SKILL_GAMING /datum/attribute/skill/gaming
