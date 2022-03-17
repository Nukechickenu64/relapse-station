//Like capitalize, but you capitalize EVERYTHING
/proc/capitalize_like_old_man(t)
	. = t
	if(!length(t))
		return
	var/list/binguslist = splittext(t, " ")
	for(var/bingus in binguslist)
		binguslist -= bingus
		if(!length(bingus))
			binguslist += bingus
			continue
		var/chonker = uppertext(bingus[1])
		bingus = chonker + copytext(bingus, 1 + length(chonker))
		binguslist += bingus
	return jointext(binguslist, " ")

//Sometimes, \an does not work like you'd expect
/proc/prefix_a_or_an(text)
	if(!length(text))
		return "a"
	var/start = lowertext(text[1])
	if(start == "a" || start == "e" || start == "i" || start == "o" || start == "u")
		return "an"
	else
		return "a"

//Get only the initials of t joined together
/proc/get_name_initials(t)
	. = t
	if(!length(t))
		return
	var/list/binguslist = splittext(t, " ")
	for(var/bingus in binguslist)
		binguslist -= bingus
		if(!length(bingus))
			binguslist += bingus
			continue
		binguslist += uppertext(bingus[1])
	return jointext(binguslist, "")

/proc/fail_string(capitalize = FALSE)
	var/string = pick("crap", "dang", "damn", "damn it", "shit", "piss", "ugh", "unf", "agh", "fuck", "hell on earth", "misery", "tarnation", "curse", "agony", "failure", "no")
	return (capitalize ? capitalize(string) : string)

/proc/fail_msg()
	return "[fail_string(TRUE)]!"

/proc/click_fail_msg()
	return span_alert(pick("I'm not ready!", "No!", "I did all i could!", "I can't!", "Not yet!"))

/proc/get_signs_from_number(num, index = 0)
	var/signs = num
	var/symbol = span_green("<b>+</b>")
	if(!signs)
		symbol = ""
	else if(signs < 0)
		symbol = span_red("<b>-</b>")
	signs = abs(signs)
	var/total_symbols = ""
	if(signs && symbol)
		if(index)
			signs = CEILING(signs/2, 1)
		else
			signs = FLOOR(signs/2, 1)
		var/bingus = 0
		while(bingus < signs)
			bingus++
			total_symbols += symbol
	return total_symbols

/proc/nonsensify_string(text)
	var/malbolge = ""
	var/text_len = length(text)
	if(text_len >= 1)
		for(var/i in 1 to length(text))
			if(!(lowertext(text) in GLOB.alphabet))
				malbolge += text[i]
			else
				malbolge += pick(GLOB.alphabet_upper)
	return malbolge
