///Dangerous fires release this from the waste they're burning
/datum/pollutant/carbon_air_pollution
	name = "Carbon Air Pollution"
	pollutant_flags = POLLUTANT_BREATHE_ACT

/datum/pollutant/carbon_air_pollution/breathe_act(mob/living/carbon/victim, amount)
	if(amount <= 10)
		return
	victim.adjustToxLoss(1)
	if(prob(amount))
		victim.losebreath += 3
		victim.agony_gasp()

///Dust from mining drills
/datum/pollutant/dust
	name = "Dust"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_BREATHE_ACT
	thickness = 2
	color = "#FFED9C"
	filter_wear = 0.25

/datum/pollutant/dust/breathe_act(mob/living/carbon/victim, amount)
	if(amount <= 10)
		return
	if(prob(amount))
		victim.losebreath += 3
		victim.emote("cough")

///Miasma coming from corpses
/datum/pollutant/miasma
	name = "Miasma"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "rotting carcasses"
	color = "#9500b3"
	filter_wear = 0.5

/datum/pollutant/miasma/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("What is this smell?!")
			if(prob(15))
				victim.emote("gag")
			if(prob(10))
				victim.vomit(rand(5, 10), prob(amount))
		if(10 to 30)
			message = span_warning("I'm gonna puke...")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma)
			if(prob(25))
				victim.vomit(rand(5, 10), prob(amount))
		if(30 to INFINITY)
			message = span_bolddanger("This stench is unbearable!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/miasma/harsh)
			victim.adjustToxLoss(2.5)
			if(prob(35))
				victim.vomit(rand(10, 15), prob(amount))
	if(message && prob(20))
		to_chat(victim, message)

///IG grenades
/datum/pollutant/incredible_gas
	name = "Incredible Gas"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 4
	thickness = 2
	descriptor = SCENT_DESC_ODOR
	scent = "rotten eggs and garbage"
	color = "#00DA00"
	filter_wear = 1

/datum/pollutant/incredible_gas/breathe_act(mob/living/carbon/victim, amount)
	var/message
	switch(amount)
		if(0 to 10)
			message = span_warning("What is this smell?!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 2)
			victim.adjustToxLoss(2)
			if(prob(50))
				victim.vomit(10, blood = prob(amount), stun = FALSE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(10 to 30)
			message = span_warning("This is vile!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 4)
			victim.adjustToxLoss(4)
			if(prob(50))
				victim.vomit(20, blood = prob(amount*3), stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		if(30 to INFINITY)
			message = span_bolddanger("This is INCREDIBLY disgusting!")
			SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "pollution", /datum/mood_event/incredible_gas/harsh)
			victim.apply_status_effect(/datum/status_effect/incredible_gas)
			victim.adjustOrganLoss(ORGAN_SLOT_LUNGS, 8)
			victim.adjustToxLoss(8)
			victim.vomit(25, blood = TRUE, stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
	if(message && prob(20))
		to_chat(victim, message)
