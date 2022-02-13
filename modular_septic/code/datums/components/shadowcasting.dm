/datum/component/shadowcasting
	var/static/list/shadowcasting_connections = list(
		COMSIG_TURF_SHADOWCASTING_UPDATED = .proc/on_shadowcasting_update,
	)

/datum/component/shadowcasting/Initialize()
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/shadowcasting/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/source_moved)
	RegisterSignal(parent, COMSIG_MOB_CLIENT_LOGIN, .proc/mob_client_logged_in)
	create_hud_element(parent)
	AddComponent(/datum/component/connect_loc_behalf, parent, shadowcasting_connections)

/datum/component/shadowcasting/UnregisterFromParent()
	. = ..()
	var/mob/source = parent
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(source, COMSIG_MOB_CLIENT_LOGIN)
	source.client?.images -= source.hud_used.shadowcasting_holder
	source.hud_used.shadowcasting_holder = null
	var/datum/component/connect_loc_behalf/connect_loc_behalf = GetComponent(/datum/component/connect_loc_behalf)
	if(connect_loc_behalf)
		qdel(connect_loc_behalf)

/datum/component/shadowcasting/proc/source_moved(mob/source, atom/oldloc, direction)
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

/datum/component/shadowcasting/proc/mob_client_logged_in(mob/source, client/logged_client)
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

/datum/component/shadowcasting/proc/create_hud_element(mob/source)
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

/datum/component/shadowcasting/proc/on_shadowcasting_update(turf/source)
	SIGNAL_HANDLER

	var/mob/update_mob = parent
	if(!update_mob.client)
		return
	update_mob.hud_used.shadowcasting_holder.vis_contents = source.shadowcasting_overlays
	update_mob.hud_used.shadowcasting_holder.loc = source
