//Skin tone type
/datum/preference/choiced/skin_tone
	priority = PREFERENCE_PRIORITY_SKINTONES

/datum/preference/choiced/skin_tone/apply_to_human(mob/living/carbon/human/target, value)
	target.skin_tone = value
