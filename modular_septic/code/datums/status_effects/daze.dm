//DAZED
/datum/status_effect/incapacitating/dazed
	id = "dazed"

/datum/status_effect/incapacitating/dazed/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/dazed/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))

//STUMBLE
/datum/status_effect/incapacitating/dazed/stumble
	id = "stumble"
	var/didknockdown = FALSE

/datum/status_effect/incapacitating/dazed/stumble/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/shove)
	ADD_TRAIT(owner, TRAIT_STUMBLE, TRAIT_STATUS_EFFECT(id))
	if(!didknockdown && iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		switch(carbon_owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(carbon_owner, STAT_ENDURANCE)))
			if(DICE_FAILURE)
				carbon_owner.CombatKnockdown(50)
				didknockdown = TRUE
			if(DICE_CRIT_FAILURE)
				carbon_owner.CombatKnockdown(75)
				didknockdown = TRUE

/datum/status_effect/incapacitating/dazed/stumble/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/shove)
	REMOVE_TRAIT(owner, TRAIT_STUMBLE, TRAIT_STATUS_EFFECT(id))
	if(!didknockdown && iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		switch(carbon_owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(carbon_owner, STAT_ENDURANCE)))
			if(DICE_FAILURE)
				carbon_owner.CombatKnockdown(50)
				didknockdown = TRUE
			if(DICE_CRIT_FAILURE)
				carbon_owner.CombatKnockdown(75)
				didknockdown = TRUE
