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
		if(0 to 15)
			message = span_warning("What is this smell?!")
			victim.adjustToxLoss(1)
			if(prob(50))
				victim.vomit(10, prob(amount), vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(15 to 35)
			message = span_warning("This is vile!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma)
			victim.adjustToxLoss(2.5)
			if(prob(25))
				victim.vomit(20, prob(amount*3), TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(35 to INFINITY)
			message = span_bolddanger("This is INCREDIBLY disgusting!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma/harsh)
			victim.adjustToxLoss(5)
			victim.vomit(20, TRUE, TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
			if(prob(30))
				victim.take_bodypart_damage(0, 5)
	if(prob(20))
		to_chat(victim, message)
