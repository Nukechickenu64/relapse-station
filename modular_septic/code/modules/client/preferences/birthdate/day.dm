/datum/preference/numeric/day_born
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "day_born"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 1
	maximum = 31

/datum/preference/numeric/day_born/deserialize(input, datum/preferences/preferences)
	var/month_born = preferences.read_preference(/datum/preference/choiced/month_born)
	var/maximum_day = days_in_month(month_numeric(month_born))
	return sanitize_float(input, minimum, maximum_day, step, create_default_value())

/datum/preference/numeric/day_born/create_informed_default_value(datum/preferences/preferences)
	var/month_born = preferences.read_preference(/datum/preference/choiced/month_born)
	var/maximum_day = days_in_month(month_born)
	return rand(1, maximum_day)

/datum/preference/numeric/day_born/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	. = ..()
	var/month_born = preferences.read_preference(/datum/preference/choiced/month_born)
	var/maximum_day = days_in_month(month_born)
	target.day_born = min(value, maximum_day)
