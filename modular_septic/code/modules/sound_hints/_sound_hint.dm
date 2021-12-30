//Do a little sound hint
/atom/proc/sound_hint(duration = 5, use_icon = 'modular_septic/icons/effects/sound.dmi', use_states = "sound2")
	//this is HORRIBLE but it prevents runtimes
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return
	var/hint_icon = pick(use_icon)
	var/hint_state = pick(use_states)
	var/image/hint = image(hint_icon, get_turf(src), hint_state)
	hint.appearance_flags = RESET_COLOR | RESET_TRANSFORM | RESET_ALPHA
	hint.plane = SOUND_HINT_PLANE
	hint.layer = 1000
	var/list/clients = list()
	for(var/mob/viewer in get_hearers_in_view(world.view, src))
		if(viewer.client && viewer.can_hear())
			clients |= viewer.client
	flick_overlay(hint, clients, duration)
