/datum/element/dancing
	id_arg_index = 2
	element_flags = ELEMENT_DETACH
	/// The source of the dancing trait we give
	var/trait_source = EMOTE_TRAIT

/datum/element/dancing/Attach(datum/target, trait_source)
	. = ..()
	if(!isatom(target) || isarea(target) || HAS_TRAIT_FROM(target, TRAIT_DANCING, trait_source))
		return ELEMENT_INCOMPATIBLE
	src.trait_source = trait_source
	if(!HAS_TRAIT(source, TRAIT_DANCING))
		start_animation(target)
	ADD_TRAIT(target, TRAIT_DANCING, trait_source)

/datum/element/dancing/Detach(datum/source)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_DANCING, trait_source)
	if(!HAS_TRAIT(source, TRAIT_DANCING))
		stop_animation(target)

/datum/element/dancing/proc/start_animation(atom/target)
	animate(target, pixel_y = 2, time = 2, loop = -1, flags = ANIMATION_RELATIVE)
	animate(pixel_y = -2, time = 2, flags = ANIMATION_RELATIVE)

/datum/element/dancing/proc/stop_animation(atom/target)
	var/final_pixel_y = target.base_pixel_y
	// Living mobs also have a 'body_position_pixel_y_offset' variable that has to be taken into account here.
	if(isliving(target))
		var/mob/living/living_target = target
		final_pixel_y += living_target.body_position_pixel_y_offset
	animate(target, pixel_y = final_pixel_y, time = 1 SECONDS)
