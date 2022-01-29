/obj/item/ammo_box
	carry_weight = 2

/obj/item/ammo_box/add_notes_box()
	var/list/readout = list()
	readout += span_notice("<b>Capacity:</b> [max_ammo]")
	var/obj/item/ammo_casing/mag_ammo = get_round(TRUE)
	if(istype(mag_ammo))
		readout += "[mag_ammo.add_notes_ammo()]"
	else
		readout += span_notice("<b>Caliber:</b> [caliber]")
	return readout.Join("\n")

/obj/item/ammo_box/get_carry_weight()
	. = ..()
	for(var/obj/item/ammo_casing/casing as anything in stored_ammo)
		. += casing?.get_carry_weight()

/obj/item/ammo_box/a762svd
	name = "ammo box (7.62x54R)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox"
	ammo_type = /obj/item/ammo_casing/a762x51
	max_ammo = 120


/obj/item/ammo_box/a762svd/ap
	name = "armor-piercing ammo box (7.62x54R)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox-AP"
	ammo_type = /obj/item/ammo_casing/a762x51/ap
	max_ammo = 120

/obj/item/ammo_box/a54539abyss
	name = "ammo box (5.4539)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox"
	ammo_type = /obj/item/ammo_casing/a54539abyss
	max_ammo = 120


/obj/item/ammo_box/a54539abyss/ap
	name = "armor-piercing ammo box (5.4539)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox-AP"
	ammo_type = /obj/item/ammo_casing/a54539abyss/ap
	max_ammo = 120


/obj/item/ammo_box/a54539abyss
	name = "ammo box (7.62x39)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 120


/obj/item/ammo_box/a54539abyss/ap
	name = "armor-piercing ammo box (7.62x39)"
	icon = 'modular_septic/icons/obj/items/ammo/boxes.dmi'
	icon_state = "riflebox-AP"
	ammo_type = /obj/item/ammo_casing/a762/ap
	max_ammo = 120
