//Ghosts will be reworked, but for now this will do
/mob/dead/observer
	var/can_rest = FALSE

/mob/dead/observer/Initialize()
	. = ..()
	add_verb(src, /mob/dead/observer/proc/second_chance)

/mob/dead/observer/proc/second_chance()
	set name = "Reincarnation"
	set desc = "Live another life."
	set category = "Ghost"

	if(!can_rest)
		to_chat(src, span_warning("My body hasn't been buried or cremated."))
		return

	var/mob/dead/new_player/NP = new()
	NP.key = src.key
	qdel(src)

/mob/dead/observer/proc/combat_ressurection() //no observing for you nigga
	client.screen.Cut()
	client.screen += client.void
	var/mob/dead/new_player/M = new /mob/dead/new_player()
	M.key = key
