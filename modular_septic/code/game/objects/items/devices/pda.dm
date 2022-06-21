//add whatsapp
/obj/item/pda
	carry_weight = 500 GRAMS
	ttone = "zap"

/obj/item/pda/receive_message(datum/signal/subspace/messaging/pda/signal)
	tnote += "<i><b>&larr; From <a href='byond://?src=[REF(src)];choice=Message;target=[REF(signal.source)]'>[signal.data["name"]]</a> ([signal.data["job"]]):</b></i><br>[signal.format_message()]<br>"

	if (!silent)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_PDA_GLITCHED))
			playsound(src, pick('sound/machines/twobeep_voice1.ogg', 'sound/machines/twobeep_voice2.ogg'), 50, TRUE)
		else if(ttone != "zap")
			playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
		else
			playsound(src, 'modular_septic/sound/effects/Mobile_sms.ogg', 40, FALSE)
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
