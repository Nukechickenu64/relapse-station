/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "ruger9mm"
	base_icon_state = "ruger9mm"

/obj/item/ammo_box/magazine/m9mm_aps
	name = "pernetta 69r magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "beretta9mm"
	base_icon_state = "beretta9mm"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m45
	name = "pistol magazine (.45)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "pistol45"
	base_icon_state = "pistol45"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(round(ammo_count(), 2), 8)]"

/obj/item/ammo_box/magazine/combatmaster9mm
	name = "frag master magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "combatmaster9mm"
	base_icon_state = "combatmaster9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/glock9mm
	name = "Gosma-17 magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "glock"
	base_icon_state = "glock"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 17
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/glock9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 17 : 0]"

/obj/item/ammo_box/magazine/ppk22lr
	name = "walter FT magazine (.22lr)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "ppk22lr"
	base_icon_state = "ppk22lr"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 9
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/ppk22lr/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(round(ammo_count()), 9)]"

/obj/item/ammo_box/magazine/shrimp9x21
	name = "Camarao 1 magazine (9x21mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "sr1"
	base_icon_state = "sr1"
	ammo_type = /obj/item/ammo_casing/c9x21
	caliber = CALIBER_9X21
	max_ammo = 18
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/shrimp9x21mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(round(ammo_count(), 4), 18)]"

/obj/item/ammo_box/magazine/five57
	name = "Cinquenta e Sete magazine (5.7)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "five7"
	base_icon_state = "five7"
	ammo_type = /obj/item/ammo_casing/five57
	caliber = CALIBER_C57
	max_ammo = 20
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/five57/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 20 : 0]"

/obj/item/ammo_box/magazine/aniquilador
	name = "Anaquilador Magazine (.50 LE)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "one"
	base_icon_state = "one"
	ammo_type = /obj/item/ammo_casing/aniquilador
	caliber = CALIBER_ANIQUILADOR
	max_ammo = 10
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/aniquilador/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 10 : 0]"
