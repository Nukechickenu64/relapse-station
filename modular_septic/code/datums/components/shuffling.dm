/datum/component/shuffling
	var/static/list/default_squeak_sounds = list('sound/items/toysqueak1.ogg'=1, 'sound/items/toysqueak2.ogg'=1, 'sound/items/toysqueak3.ogg'=1)
	var/list/override_squeak_sounds
	var/mob/holder

	var/squeak_chance = 140
	var/volume = 30

	// This is it does squeak every step
	var/steps = 0
	var/step_delay = 0

	// This is to stop squeak spam from inhand usage
	var/last_use = 0
	var/use_delay = 20

	///extra-range for this component's sound
	var/sound_extra_range = -1
	///when sounds start falling off for the squeak
	var/sound_falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE
	///sound exponent for squeak. Defaults to 10 as squeaking is loud and annoying enough.
	var/sound_falloff_exponent = 10

	///what we set connect_loc to if parent is a movable
	var/static/list/movable_connections = list(
		COMSIG_MOVABLE_MOVED = .proc/play_squeak_loc_moved,
	)

/datum/component/shuffling/Initialize(custom_sounds, volume_override, chance_override, step_delay_override, use_delay_override, extrarange, falloff_exponent, fallof_distance)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_BLOB_ACT, COMSIG_ATOM_HULK_ATTACK, COMSIG_PARENT_ATTACKBY), .proc/play_squeak)
	RegisterSignal(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT, COMSIG_PROJECTILE_BEFORE_FIRE), .proc/play_squeak)
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/step_squeak)
	if(isitem(parent))
		RegisterSignal(parent, list(COMSIG_ITEM_ATTACK, COMSIG_ITEM_ATTACK_OBJ, COMSIG_ITEM_HIT_REACT), .proc/play_squeak)
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)
		if(istype(parent, /obj/item/clothing/shoes))
			RegisterSignal(parent, COMSIG_SHOES_STEP_ACTION, .proc/step_squeak)
	AddComponent(/datum/component/connect_loc_behalf, parent, movable_connections)

	override_squeak_sounds = custom_sounds
	if(chance_override)
		squeak_chance = chance_override
	if(volume_override)
		volume = volume_override
	if(isnum(step_delay_override))
		step_delay = step_delay_override
	if(isnum(use_delay_override))
		use_delay = use_delay_override
	if(isnum(extrarange))
		sound_extra_range = extrarange
	if(isnum(falloff_exponent))
		sound_falloff_exponent = falloff_exponent
	if(isnum(fallof_distance))
		sound_falloff_distance = fallof_distance

/datum/component/shuffling/UnregisterFromParent()
	. = ..()
	qdel(GetComponent(/datum/component/connect_loc_behalf))

/datum/component/shuffling/proc/play_squeak()
	SIGNAL_HANDLER

	if(prob(squeak_chance))
		if(!override_squeak_sounds)
			playsound(parent, pick_weight(default_squeak_sounds), volume, TRUE, sound_extra_range, sound_falloff_exponent, falloff_distance = sound_falloff_distance)
		else
			playsound(parent, pick_weight(override_squeak_sounds), volume, TRUE, sound_extra_range, sound_falloff_exponent, falloff_distance = sound_falloff_distance)

/datum/component/shuffling/proc/step_squeak()
	SIGNAL_HANDLER

	if(steps > step_delay)
		play_squeak()
		steps = 0
	else
		steps++

/datum/component/shuffling/proc/play_squeak_loc_moved(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	if(mover.movement_type & (FLYING|FLOATING) || !mover.has_gravity())
		return
	step_squeak()

/datum/component/shuffling/proc/play_squeak_crossed(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(isitem(arrived))
		var/obj/item/I = arrived
		if(I.item_flags & ABSTRACT)
			return
	if(arrived.movement_type & (FLYING|FLOATING) || !arrived.has_gravity())
		return
	var/atom/current_parent = parent
	if(isturf(current_parent?.loc))
		play_squeak()

/datum/component/shuffling/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	holder = equipper
	RegisterSignal(holder, COMSIG_PARENT_PREQDELETED, .proc/holder_deleted, override=TRUE)
	//override for the preqdeleted is necessary because putting parent in hands sends the signal that this proc is registered towards,
	//so putting an object in hands and then equipping the item on a clothing slot (without dropping it first)
	//will always runtime without override = TRUE

/datum/component/shuffling/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_PARENT_PREQDELETED)
	holder = null

///just gets rid of the reference to holder in the case that theyre qdeleted
/datum/component/shuffling/proc/holder_deleted(datum/source, datum/possible_holder)
	SIGNAL_HANDLER
	if(possible_holder == holder)
		holder = null

/datum/component/shuffling/proc/on_comedy_metabolism_removal(datum/source, trait)
	SIGNAL_HANDLER

	qdel(src)
