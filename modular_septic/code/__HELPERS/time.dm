/proc/calculate_station_time_offset()
	// 8766 = hours in a year
	. = ((STATION_YEAR_OFFSET * 8766) HOURS)
	// random element, adds up to one year to the time offset
	. += FLOOR(rand(0, 8766 HOURS), 24 HOURS)

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
