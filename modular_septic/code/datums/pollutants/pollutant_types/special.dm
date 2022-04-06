///IG grenades
/datum/pollutant/incredible_gas
	name = "Incredible Gas"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 3
	descriptor = SCENT_DESC_ODOR
	scent = "king ass ripper"
	color = "#00da00"

/datum/pollutant/incredible_gas/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("What is this smell?!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1)
			victim.adjustToxLoss(1)
			if(prob(50))
				victim.vomit(10, prob(amount), vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(10 to 30)
			message = span_warning("This is vile!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 2.5)
			victim.adjustToxLoss(2.5)
			if(prob(50))
				victim.vomit(20, prob(amount*3), TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(30 to INFINITY)
			message = span_bolddanger("This is INCREDIBLY disgusting!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 5)
			victim.adjustToxLoss(5)
			victim.vomit(25, TRUE, TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
	if(prob(20))
		to_chat(victim, message)
