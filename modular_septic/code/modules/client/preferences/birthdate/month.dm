/datum/preference/choiced/month_born
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "month_born"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/month_born/init_possible_values()
	. = list()
	for(var/month_number in JANUARY to DECEMBER)
		. += month_text(month_number)

/datum/preference/choiced/month_born/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.month_born = month_numeric(value)
