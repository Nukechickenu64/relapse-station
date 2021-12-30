/proc/calculate_current_station_year()
	return GLOB.year_integer + YEAR_OFFSET

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
