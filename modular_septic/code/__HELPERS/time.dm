/proc/random_time_in_year()
	// this should not handle the time of the day please
	return rand(0, 365) * 24 HOURS

/proc/st_nd_rd_th(number = 0)
	var/text = "[number]"
	switch(copytext(text, length(text)))
		if("1")
			return "st"
		if("2")
			return "nd"
		if("3")
			return "rd"
		else
			return "th"
