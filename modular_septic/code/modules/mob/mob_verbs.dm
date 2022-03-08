/mob/proc/open_peeper()
	set name = "Open Peeper"
	set desc = "This opens the peeper panel."
	set category = "Peeper"

	hud_used?.peeper?.show_peeper(src)

/mob/proc/close_peeper()
	set name = "Close Peeper"
	set desc = "This closes the peeper panel."
	set category = "Peeper"

	hud_used?.peeper?.hide_peeper(src)
