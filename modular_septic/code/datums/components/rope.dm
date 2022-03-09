/datum/component/rope
	dupe_mode = COMPONENT_DUPE_SELECTIVE
	var/atom/roped
	var/maximum_rope_distance = 3
	var/connect_to_turf = FALSE
	var/datum/callback/rope_broken_callback
	var/datum/beam/rope_beam

/datum/component/rope/Initialize(atom/roped, \
								icon = 'icons/effects/beam.dmi', \
								icon_state = "r_beam", \
								maximum_rope_distance = 3, \
								connect_to_turf = FALSE,
								beam_type = /obj/effect/ebeam, \
								datum/callback/rope_broken_callback)
	if((!isatom(parent) || isarea(parent)) || (!isatom(roped) || isarea(roped)))
		return COMPONENT_INCOMPATIBLE
	src.roped = roped
	src.maximum_rope_distance = maximum_rope_distance
	src.connect_to_turf = connect_to_turf
	src.rope_broken_callback = rope_broken_callback
	var/atom/atom_parent = parent
	rope_beam = atom_parent.Beam(roped, icon_state, icon, INFINITY, maximum_rope_distance, beam_type, connect_to_turf)
	START_PROCESSING(SSdcs, src)

/datum/component/rope/Destroy(force, silent)
	. = ..()
	STOP_PROCESSING(SSdcs, src)
	roped = null
	rope_beam = null

/datum/component/rope/CheckDupeComponent(datum/component/rope/other_rope, \
										atom/roped, \
										icon = 'icons/effects/beam.dmi', \
										icon_state = "r_beam", \
										maximum_rope_distance = 3, \
										beam_type = /obj/effect/ebeam, \
										datum/callback/rope_broken_callback)
	if((src.roped == roped) && (src.rope_broken_callback?.arguments ~= rope_broken_callback.arguments))
		return TRUE
	return FALSE

/datum/component/rope/RegisterWithParent()
	. = ..()
	if(!QDELETED(rope_beam))
		RegisterSignal(rope_beam, COMSIG_PARENT_QDELETING, .proc/rope_beam_broken)
	RegisterSignal(roped, COMSIG_ROPE_CHECK_ROPED, .proc/is_roped)
	RegisterSignal(parent, COMSIG_ROPE_CHECK_ROPED, .proc/is_roped)

/datum/component/rope/UnregisterFromParent()
	. = ..()
	if(!QDELETED(rope_beam))
		UnregisterSignal(rope_beam)
	UnregisterSignal(roped, COMSIG_ROPE_CHECK_ROPED)
	UnregisterSignal(parent, COMSIG_ROPE_CHECK_ROPED)

// This ensures that when parent cannot reach roped, the beam is broken
/datum/component/rope/process(delta_time)
	if(!can_see(parent, roped, maximum_rope_distance))
		qdel(rope_beam)
		return PROCESS_KILL

/datum/component/rope/proc/rope_beam_broken(datum/beam/source)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_PARENT_QDELETING)
	if(rope_broken_callback)
		rope_broken_callback.Invoke()
	qdel(src)

/datum/component/rope/proc/is_roped(datum/source)
	SIGNAL_HANDLER

	return TRUE
