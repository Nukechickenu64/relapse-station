/obj/item/ammo_casing
	carry_weight = 0.02
	var/obj/item/ammo_box/magazine/stack_type = /obj/item/ammo_box/magazine/ammo_stack

/obj/item/ammo_casing/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/ammo_casing = I
		if(!ammo_casing.stack_type)
			to_chat(user, span_warning("[ammo_casing] can't be stacked."))
			return
		if(!stack_type)
			to_chat(user, span_warning("[src] can't be stacked."))
			return
		if(caliber != ammo_casing.caliber)
			to_chat(user, span_warning("I can't stack different calibers."))
			return
		var/obj/item/ammo_box/magazine/ammo_stack/ammo_stack = new(drop_location())
		ammo_stack.name = "[capitalize(caliber)] rounds"
		ammo_stack.caliber = caliber
		ammo_stack.give_round(src)
		ammo_stack.give_round(ammo_casing)
		ammo_stack.update_appearance(UPDATE_OVERLAYS)
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
	multiload = TRUE
	carry_weight = 0

/obj/item/ammo_box/magazine/ammo_stack/update_overlays()
	. = ..()
	for(var/casing in stored_ammo)
		var/obj/item/ammo_casing/AC = casing
		var/image/comicao = image(AC.icon, src, AC.icon_state)
		comicao.pixel_x = rand(0, 8)
		comicao.pixel_y = rand(0, 8)
		comicao.transform = comicao.transform.Turn(rand(0, 360))
		. += comicao

/obj/item/ammo_box/magazine/ammo_stack/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	while(length(stored_ammo))
		var/obj/item/ammo = get_round(FALSE)
		ammo.forceMove(loc)
		ammo.throw_at(loc)
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
