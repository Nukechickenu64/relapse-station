/mob/proc/open_peeper()
	set name = "Open Peeper"
	set desc = "This opens the peeper panel."
	set category = "Status"

	hud_used?.peeper?.show_peeper(src)
