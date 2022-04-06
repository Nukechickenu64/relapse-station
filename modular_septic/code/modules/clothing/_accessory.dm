/obj/item/clothing/accessory
    var/ATTACH_TYPE = obj/item/clothing/under/U

/obj/item/clothing/accessory/can_attach_accessory(ATTACH_TYPE, mob/user)
	if(!attachment_slot || (U && U.body_parts_covered & attachment_slot))
		return TRUE
	if(user)
		to_chat(user, span_warning("There doesn't seem to be anywhere to put [src]..."))

/obj/item/clothing/accessory/attach(obj/item/clothing/U, user)
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	if(storage)
		if(SEND_SIGNAL(U, COMSIG_CONTAINS_STORAGE))
			return FALSE
		U.TakeComponent(storage)
		set_detached_pockets(storage)
	U.attached_accessory = src
	forceMove(U)
	layer = FLOAT_LAYER
	plane = FLOAT_PLANE
	if(minimize_when_attached)
		transform *= 0.5 //halve the size so it doesn't overpower the under
		pixel_x += 8
		pixel_y -= 8
	U.add_overlay(src)

	if (islist(U.armor) || isnull(U.armor)) // This proc can run before /obj/Initialize has run for U and src,
		U.armor = getArmor(arglist(U.armor)) // we have to check that the armor list has been transformed into a datum before we try to call a proc on it
																					// This is safe to do as /obj/Initialize only handles setting up the datum if actually needed.
	if (islist(armor) || isnull(armor))
		armor = getArmor(arglist(armor))

	U.armor = U.armor.attachArmor(armor)

	if(isliving(user))
		on_uniform_equip(U, user)

	return TRUE

/obj/item/clothing/accessory/on_uniform_equip(obj/item/clothing/U, user)
	return

/obj/item/clothing/accessory/on_uniform_dropped(obj/item/clothing/U, user)
	return


/obj/item/clothing/accessory/examine(mob/user)
	. = ..()
	. += span_notice("\The [src] can be attached to an article of clothing. Alt-click to remove it once attached.")
