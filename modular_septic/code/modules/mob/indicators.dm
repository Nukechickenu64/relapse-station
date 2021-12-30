/mob/Initialize(mapload)
	. = ..()
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_TYPINGINDICATOR), .proc/update_typing_indicator)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_TYPINGINDICATOR), .proc/update_typing_indicator)
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_SSDINDICATOR), .proc/update_ssd_indicator)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_SSDINDICATOR), .proc/update_ssd_indicator)

/mob/proc/update_typing_indicator()
	if(HAS_TRAIT(src, TRAIT_TYPINGINDICATOR))
		add_overlay(GLOB.typing_indicator_overlay)
	else
		cut_overlay(GLOB.typing_indicator_overlay)

/mob/proc/update_ssd_indicator()
	if(HAS_TRAIT(src, TRAIT_SSDINDICATOR))
		add_overlay(GLOB.ssd_indicator_overlay)
	else
		cut_overlay(GLOB.ssd_indicator_overlay)

/mob/proc/set_typing_indicator(state = FALSE)
	if(state)
		ADD_TRAIT(src, TRAIT_TYPINGINDICATOR, COMMUNICATION_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_TYPINGINDICATOR, COMMUNICATION_TRAIT)

/mob/proc/set_ssd_indicator(state = FALSE)
	if(state)
		ADD_TRAIT(src, TRAIT_SSDINDICATOR, COMMUNICATION_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_SSDINDICATOR, COMMUNICATION_TRAIT)

/mob/Login()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_SSDINDICATOR, COMMUNICATION_TRAIT)

/mob/Logout()
	. = ..()
	if(mind)
		ADD_TRAIT(src, TRAIT_SSDINDICATOR, COMMUNICATION_TRAIT)

/mob/say_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/whisper_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/me_verb(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/say_dead(message as text)
	. = ..()
	set_typing_indicator(FALSE)

/mob/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	. = ..()
	set_typing_indicator(FALSE)

/mob/emote(act, m_type, message, intentional, force_silence)
	. = ..()
	set_typing_indicator(FALSE)

/proc/animate_speechbubble(image/speechbubble_image, list/show_to, extraduration)
	var/matrix/old_matrix = matrix(speechbubble_image.transform)
	var/matrix/small_matrix = matrix(speechbubble_image.transform)
	small_matrix = small_matrix.Scale(0,0)
	speechbubble_image.transform = small_matrix
	speechbubble_image.alpha = 0
	for(var/client/client as anything in show_to)
		client.images += speechbubble_image
	animate(speechbubble_image, transform = old_matrix, alpha = 255, time = 5, easing = ELASTIC_EASING)
	sleep(extraduration+5)
	animate(speechbubble_image, alpha = 0, time = 5, easing = ELASTIC_EASING|EASE_IN)
	sleep(5)
	for(var/client/client as anything in show_to)
		client?.images -= speechbubble_image
