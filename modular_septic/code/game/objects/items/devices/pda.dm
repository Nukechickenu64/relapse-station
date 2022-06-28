#define PDA_SPAM_DELAY 2 MINUTES

//add whatsapp
/obj/item/pda
	icon = 'modular_septic/icons/obj/items/pda.dmi'
	desc = "A portable microcomputer by MOKIA Systems, LTD. Functionality determined by a preprogrammed ROM cartridge."
	carry_weight = 500 GRAMS
	ttone = "zap"

/obj/item/pda/send_message(mob/living/user, list/obj/item/pda/targets, everyone)
	var/message = msg_input(user)
	if(!message || !targets.len)
		return
	if((last_text && world.time < last_text + 10) || (everyone && last_everyone && world.time < last_everyone + PDA_SPAM_DELAY))
		return

	var/list/filter_result = is_ic_filtered_for_pdas(message)
	if (filter_result)
		REPORT_CHAT_FILTER_TO_USER(user, filter_result)
		return

	var/list/soft_filter_result = is_soft_ic_filtered_for_pdas(message)
	if (soft_filter_result)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to send it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term in PDA messages. Message: \"[html_encode(message)]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term in PDA messages. Message: \"[message]\"")

	if(prob(1))
		message += "\nSent from my PDA"
	// Send the signal
	var/list/string_targets = list()
	for (var/obj/item/pda/P in targets)
		if (P.owner && P.ownjob)  // != src is checked by the UI
			string_targets += "[P.owner] ([P.ownjob])"
	for (var/obj/machinery/computer/message_monitor/M in targets)
		// In case of "Reply" to a message from a console, this will make the
		// message be logged successfully. If the console is impersonating
		// someone by matching their name and job, the reply will reach the
		// impersonated PDA.
		string_targets += "[M.customsender] ([M.customjob])"
	if (!string_targets.len)
		return

	var/datum/signal/subspace/messaging/pda/signal = new(src, list(
		"name" = "[owner]",
		"job" = "[ownjob]",
		"message" = message,
		"targets" = string_targets,
		"emojis" = allow_emojis,
	))
	if (picture)
		signal.data["photo"] = picture
	signal.send_to_receivers()

	// If it didn't reach, note that fact
	if (!signal.data["done"])
		to_chat(user, span_notice("ERROR: Server isn't responding."))
		if(!silent)
			playsound(src, 'sound/machines/terminal_error.ogg', 15, TRUE)
		return

	var/target_text = signal.format_target()
	if(allow_emojis)
		message = emoji_parse(message)//already sent- this just shows the sent emoji as one to the sender in the to_chat
		signal.data["message"] = emoji_parse(signal.data["message"])

	// Log it in our logs
	tnote += "<i><b>&rarr; To [target_text]:</b></i><br>[signal.format_message()]<br>"
	// Show it to ghosts
	var/ghost_message = span_name("[owner] </span><span class='game say'>PDA Message</span> --> [span_name("[target_text]")]: <span class='message'>[signal.format_message()]")
	for(var/mob/M in GLOB.player_list)
		if(isobserver(M) && (M.client?.prefs.chat_toggles & CHAT_GHOSTPDA))
			to_chat(M, "[FOLLOW_LINK(M, user)] [ghost_message]")
	// Log in the talk log
	user.log_talk(message, LOG_PDA, tag="PDA: [initial(name)] to [target_text]")
	to_chat(user, span_info("PDA message sent to [target_text]: \"[message]\""))
	if(!silent)
		playsound(src, 'modular_septic/sound/effects/Mobile_sms_send.wav', 15, TRUE)
	// Reset the photo
	picture = null
	last_text = world.time
	if (everyone)
		last_everyone = world.time


/obj/item/pda/receive_message(datum/signal/subspace/messaging/pda/signal)
	tnote += "<i><b>&larr; From <a href='byond://?src=[REF(src)];choice=Message;target=[REF(signal.source)]'>[signal.data["name"]]</a> ([signal.data["job"]]):</b></i><br>[signal.format_message()]<br>"

	if (!silent)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_PDA_GLITCHED))
			playsound(src, pick('sound/machines/twobeep_voice1.ogg', 'sound/machines/twobeep_voice2.ogg'), 50, TRUE)
		else if(ttone != "zap")
			playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
		else
			playsound(src, 'modular_septic/sound/effects/Mobile_sms.ogg', 25, FALSE)
		audible_message(span_infoplain("[icon2html(src, hearers(src))] *[ttone]*"), null, 3)
	//Search for holder of the PDA.
	var/mob/living/L = null
	if(loc && isliving(loc))
		L = loc
	//Maybe they are a pAI!
	else
		L = get(src, /mob/living/silicon)

	if(L && (L.stat == CONSCIOUS || L.stat == SOFT_CRIT))
		var/reply = "(<a href='byond://?src=[REF(src)];choice=Message;skiprefresh=1;target=[REF(signal.source)]'>Reply</a>)"
		var/hrefstart
		var/hrefend
		if (isAI(L))
			hrefstart = "<a href='?src=[REF(L)];track=[html_encode(signal.data["name"])]'>"
			hrefend = "</a>"

		if(signal.data["automated"])
			reply = "\[Automated Message\]"

		var/inbound_message = signal.format_message()
		if(signal.data["emojis"] == TRUE)//so will not parse emojis as such from pdas that don't send emojis
			inbound_message = emoji_parse(inbound_message)

		to_chat(L, span_infoplain("[icon2html(src)] <b>PDA message from [hrefstart][signal.data["name"]] ([signal.data["job"]])[hrefend], </b>[inbound_message] [reply]"))

	update_appearance()
	if(istext(icon_alert))
		icon_alert = mutable_appearance(initial(icon), icon_alert)
		add_overlay(icon_alert)
