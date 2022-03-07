/mob/proc/open_peeper()
	set name = "Open Peeper"
	set desc = "This opens the peeper panel."
	set category = "Status.Peeper"

	hud_used?.peeper?.show_peeper(src)
