/datum/element/shadowcasting
	element_flags = ELEMENT_DETACH

/datum/element/shadowcasting/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, .proc/source_moved)
	RegisterSignal(target, COMSIG_MOB_CLIENT_LOGIN, .proc/mob_client_logged_in)
	create_hud_element(target)

/datum/element/shadowcasting/Detach(mob/source)
	. = ..()
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(source, COMSIG_MOB_CLIENT_LOGIN)
	source.client?.images -= source.hud_used.shadowcasting_holder
	source.hud_used.shadowcasting_holder = null

/datum/element/shadowcasting/proc/source_moved(mob/source, atom/oldloc, direction)
	SIGNAL_HANDLER

	if(!source.client || !source.hud_used?.shadowcasting_holder)
		return
	var/turf/source_turf = get_turf(source)
	if(!source_turf)
		source.hud_used.shadowcasting_holder.vis_contents = list()
		source.hud_used.shadowcasting_holder.loc = null
		return
	if(!source_turf.shadowcasting_overlays)
		source_turf.update_shadowcasting_overlays()
	source.hud_used.shadowcasting_holder.vis_contents = source_turf.shadowcasting_overlays
	source.hud_used.shadowcasting_holder.loc = source_turf

/datum/element/shadowcasting/proc/mob_client_logged_in(mob/source, client/logged_client)
	SIGNAL_HANDLER

	if(!source.hud_used?.shadowcasting_holder)
		return
	var/turf/source_turf = get_turf(source)
	if(!source_turf)
		source.hud_used.shadowcasting_holder.vis_contents = list()
		source.hud_used.shadowcasting_holder.loc = null
		logged_client.screen |= source.hud_used.shadowcasting_holder
		return
	if(!source_turf.shadowcasting_overlays)
		source_turf.update_shadowcasting_overlays()
	source.hud_used.shadowcasting_holder.vis_contents = source_turf.shadowcasting_overlays
	source.hud_used.shadowcasting_holder.loc = source_turf
	logged_client.images |= source.hud_used.shadowcasting_holder

/datum/element/shadowcasting/proc/create_hud_element(mob/source)
	if(!source.hud_used)
		return
	source.hud_used.shadowcasting_holder = image(icon = 'modular_septic/icons/hud/screen_gen.dmi', icon_state = "blank")
	source.hud_used.shadowcasting_holder.plane = SHADOWCASTING_PLANE
	var/turf/source_turf = get_turf(source)
	if(!source_turf)
		source.hud_used.shadowcasting_holder.vis_contents = list()
		source.hud_used.shadowcasting_holder.loc = null
		source.client?.screen |= source.hud_used.shadowcasting_holder
		return
	if(!source_turf.shadowcasting_overlays)
		source_turf.update_shadowcasting_overlays()
	source.hud_used.shadowcasting_holder.vis_contents = source_turf.shadowcasting_overlays
	source.hud_used.shadowcasting_holder.loc = source_turf
	source.client?.images |= source.hud_used.shadowcasting_holder
