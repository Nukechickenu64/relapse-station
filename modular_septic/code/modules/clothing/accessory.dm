/obj/item/clothing/accessory
    var/attach_item = /obj/item/clothing/under

/obj/item/clothing/accessory/proc/can_attach_accessory(attach_item, mob/user)
	if(!attachment_slot || (attach_item && attach_item.body_parts_covered & attachment_slot))
		return TRUE
	if(user)
		to_chat(user, span_warning("There doesn't seem to be anywhere to put [src]..."))

/obj/item/clothing/accessory/proc/attach(attach_item, user)
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	if(storage)
		if(SEND_SIGNAL(attach_item, COMSIG_CONTAINS_STORAGE))
			return FALSE
		attach_item.TakeComponent(storage)
		set_detached_pockets(storage)
	attach_item.attached_accessory = src
	forceMove(attach_item)
	layer = FLOAT_LAYER
	plane = FLOAT_PLANE
	if(minimize_when_attached)
		transform *= 0.5 //halve the size so it doesn't overpower the under
		pixel_x += 8
		pixel_y -= 8
	attach_item.add_overlay(src)

	if (islist(attach_item.armor) || isnull(attach_item.armor)) // This proc can run before /obj/Initialize has run for U and src,
		attach_item.armor = getArmor(arglist(attach_item.armor)) // we have to check that the armor list has been transformed into a datum before we try to call a proc on it
																					// This is safe to do as /obj/Initialize only handles setting up the datum if actually needed.
	if (islist(armor) || isnull(armor))
		armor = getArmor(arglist(armor))

	attach_item.armor = attach_item.armor.attachArmor(armor)

	if(isliving(user))
		on_uniform_equip(attach_item, user)

	return TRUE

/obj/item/clothing/accessory/on_uniform_equip(attach_item, user)
	return

/obj/item/clothing/accessory/on_uniform_dropped(attach_item, user)
	return


/obj/item/clothing/accessory/examine(mob/user)
	. = ..()
	. += span_notice("\The [src] can be attached to an article of clothing. Alt-click to remove it once attached.")
