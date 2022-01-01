/obj/item/ammo_box/magazine/m45vector
	name = "Kektor magazine (.45)"
	icon = 'modular_septic/icons/obj/items/ammo/smg.dmi'
	icon_state = "smg_l"
	base_icon_state = "smg_l"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = CALIBER_45
	max_ammo = 40
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/m45vector/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 30 : 0]"

/obj/item/ammo_box/magazine/ppsh9mm
	name = "Mamasha magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/smg.dmi'
	icon_state = "550"
	base_icon_state = "550"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 32
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/ppsh9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 30 : 0]"

/obj/item/ammo_box/magazine/hksmg9mm
	name = "Mamasha magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/smg.dmi'
	icon_state = "hk550"
	base_icon_state = "hk550"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 40
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/hksmg9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 40 : 0]"
