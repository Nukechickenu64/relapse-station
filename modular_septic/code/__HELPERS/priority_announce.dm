/minor_announce(message, title = "Attention:", alert, html_encode = TRUE)
	if(!message)
		return

	if (html_encode)
		title = html_encode(title)
		message = html_encode(message)

	for(var/mob/M in GLOB.player_list)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, "[span_minorannounce("<font color = red>[title]</font color><BR>[message]")]<BR>")
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				if(alert)
					SEND_SOUND(M, sound('modular_septic/sound/misc/notice1.wav'))
				else
					SEND_SOUND(M, sound('sound/misc/notice2.ogg'))

	SSstation.station_announcements += list(
		list("title" = title, \
			"text" = message)
	)
