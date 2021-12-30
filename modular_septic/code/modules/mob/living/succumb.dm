/mob/living/verb/succumb(whispered as null)
	set hidden = TRUE
	if(!CAN_SUCCUMB(src))
		to_chat(src, text="I am unable to succumb to death! This life continues.", type=MESSAGE_TYPE_INFO)
		return
	log_message("Has [whispered ? "whispered his final words" : "succumbed to death"] with [round(health, 0.1)] points of health!", LOG_ATTACK)
	adjustOxyLoss(src.maxHealth)
	ADJUSTBRAINLOSS(src, src.maxHealth)
	if(!whispered)
		to_chat(src, span_dead("I have given up life and succumbed to death."))
	death()
	updatehealth()
