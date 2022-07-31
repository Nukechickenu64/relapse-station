/mob/living/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	var/list/filter_result
	var/list/soft_filter_result

	//real gamers can always say funny shit
	if(GET_MOB_SKILL_VALUE(src, SKILL_GAMING) >= SKILL_MASTER)
		filterproof = TRUE

	if(client && !forced && !filterproof)
		//The filter doesn't act on the sanitized message, but the raw message.
		filter_result = is_ic_filtered(message)
		if(!filter_result)
			soft_filter_result = is_soft_ic_filtered(message)

	if(sanitize)
		message = replacetext(message, "​", "") //replacing a zero width space with... nothing
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	if(!message || message == "")
		return

	if(LAZYACCESS(filter_result, 1) && !filterproof)
		//The filter warning message shows the sanitized message though.
		var/warning_message = "<span class='warning'>A splitting headache prevents me from uttering vile words i planned to! The following terms repulse me:\n\""
		warning_message += config.ic_filter_regex.Replace(message, "<b>$0</b>")
		warning_message += "\"</span>"
		to_chat(src, warning_message)
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))

		return FALSE
	else if(LAZYACCESS(soft_filter_result, 1) && !filterproof)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to say it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			SSblackbox.record_feedback("tally", "soft_ic_blocked_words", 1, lowertext(config.soft_ic_filter_regex.match))
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[message]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[message]\"")
		SSblackbox.record_feedback("tally", "passed_soft_ic_blocked_words", 1, lowertext(config.soft_ic_filter_regex.match))
		. = ..()
	else
		bad_ic_count = max(bad_ic_count - 1, 0)
		. = ..()
	if(.)
		sound_hint()

/mob/living/treat_message(message)
	. = ..()
	if(length(.) && PUNCTUATION_FILTER_CHECK(.))
		. = trim(., MAX_MESSAGE_LEN - 1)
		. = "[.]."
