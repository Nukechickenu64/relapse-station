/proc/priority_announce(text, title = "", sound, type , sender_override, has_important_message)
	if(!text)
		return

	var/announcement
	if(!sound)
		sound = SSstation.announcer.get_rand_alert_sound()
	else if(SSstation.announcer.event_sounds[sound])
		sound = SSstation.announcer.event_sounds[sound]

	if(type == "Priority")
		announcement += "<h1 class='alert'>Priority Announcement</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"
	else if(type == "Captain")
		announcement += "<h1 class='alert'>Captain Announces</h1>"
		GLOB.news_network.SubmitArticle(html_encode(text), "Captain's Announcement", "Station Announcements", null)

	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()]</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.SubmitArticle(text, "Central Command Update", "Station Announcements", null)
			else
				GLOB.news_network.SubmitArticle(title + "<br><br>" + text, "Central Command", "Station Announcements", null)

	var/parsed_title = (type == "Priority" ? "(Priority) " : "") + (title ?  html_encode(title) : html_encode(command_name()) )
	var/parsed_text = html_encode(text)
	SSstation.station_announcements += list(
		list("title" = parsed_title, \
			"text" = parsed_text)
	)

	/// If the announcer overrides alert messages, use that message.
	if(SSstation.announcer.custom_alert_message && !has_important_message)
		announcement += SSstation.announcer.custom_alert_message
	else
		announcement += "<br>[span_alert("[html_encode(text)]")]<br>"
	announcement += "<br>"

	var/sounding = sound(sound)
	for(var/mob/hearer in GLOB.player_list)
		if(!isnewplayer(hearer) && hearer.can_hear())
			to_chat(hearer, announcement)
			if(hearer.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				SEND_SOUND(hearer, sounding)

/proc/print_command_report(text = "", title = null, announce=TRUE)
	if(!title)
		title = "Classified [command_name()] Update"

	if(announce)
		priority_announce("A report has been downloaded and printed out at all communications consoles.", \
						"Incoming Classified Message", \
						SSstation.announcer.get_rand_report_sound(), \
						has_important_message = TRUE)

	var/datum/comm_message/comm_message = new
	comm_message.title = title
	comm_message.content = text

	SScommunications.send_message(comm_message)

/proc/minor_announce(message, title = "Attention:", alert, html_encode = TRUE)
	if(!message)
		return

	if(html_encode)
		title = html_encode(title)
		message = html_encode(message)

	for(var/mob/hearer in GLOB.player_list)
		if(!isnewplayer(hearer) && hearer.can_hear())
			to_chat(hearer, "[span_minorannounce("[span_red(title)]<BR>[message]")]<BR>")
			if(hearer.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				if(alert)
					SEND_SOUND(hearer, sound('modular_septic/sound/misc/notice1.wav'))
				else
					SEND_SOUND(hearer, sound('modular_septic/sound/misc/notice2.wav'))

	SSstation.station_announcements += list(
		list("title" = title, \
			"text" = message)
	)

/proc/call_emergency_meeting(mob/living/user, area/button_zone)
	if(!user.GetComponent(/datum/component/fraggot))
		user.AddComponent(/datum/component/fraggot)
