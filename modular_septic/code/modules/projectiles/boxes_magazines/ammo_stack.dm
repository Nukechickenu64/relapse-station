/obj/item/ammo_casing
	carry_weight = 0.02
	var/obj/item/ammo_box/magazine/stack_type = /obj/item/ammo_box/magazine/ammo_stack

/obj/item/ammo_casing/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/ammo_casing = attacking_item
		if(!ammo_casing.stack_type)
			to_chat(user, span_warning("[ammo_casing] can't be stacked."))
			return
		if(!stack_type)
			to_chat(user, span_warning("[src] can't be stacked."))
			return
		if(caliber != ammo_casing.caliber)
			to_chat(user, span_warning("I can't stack different calibers."))
			return
		if(stack_type != ammo_casing.stack_type)
			to_chat(user, span_warning("I can't [ammo_casing] with [src]."))
			return
		var/obj/item/ammo_box/magazine/ammo_stack/ammo_stack = new stack_type(drop_location())
		ammo_stack.name = "[capitalize(caliber)] rounds"
		ammo_stack.caliber = caliber
		user.transferItemToLoc(src, ammo_stack, silent = TRUE)
		ammo_stack.give_round(src)
		user.transferItemToLoc(ammo_casing, ammo_stack, silent = TRUE)
		ammo_stack.give_round(ammo_casing)
		ammo_stack.update_overlays()
		user.put_in_hands(ammo_stack)
		to_chat(user, span_notice("[src] has been stacked with [ammo_casing]."))

//The ammo stack itself
/obj/item/ammo_box/magazine/ammo_stack
	name = "ammo stack"
	desc = "A stack of ammo."
	icon = 'modular_septic/icons/obj/items/ammo/stacks.dmi'
	icon_state = "nothing"
	max_ammo = 12
	multiple_sprites = FALSE
	start_empty = TRUE
	multiload = FALSE
	carry_weight = 0

/obj/item/ammo_box/magazine/ammo_stack/update_overlays()
	. = ..()
	for(var/casing in stored_ammo)
		var/obj/item/ammo_casing/ammo_casing = casing
		var/image/comicao = image(ammo_casing.icon, src, ammo_casing.icon_state)
		comicao.pixel_x = rand(0, 8)
		comicao.pixel_y = rand(0, 8)
		comicao.transform = comicao.transform.Turn(rand(0, 360))
		. += comicao

/obj/item/ammo_box/magazine/ammo_stack/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
    . = ..()
    var/loc_before_del = loc
    while(length(stored_ammo))
        var/obj/item/ammo = get_round(FALSE)
        ammo.forceMove(loc_before_del)
        ammo.throw_at(loc_before_del)
    check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/get_round(keep)
	. = ..()
	update_overlays()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/give_round(obj/item/ammo_casing/R, replace_spent)
	. = ..()
	update_overlays()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/handle_atom_del(atom/A)
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/empty_magazine()
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/update_ammo_count()
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/proc/check_for_del()
	. = FALSE
	if(ammo_count() <= 0 && !QDELETED(src))
		qdel(src)
		return TRUE
