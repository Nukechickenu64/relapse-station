/obj/item/ammo_box/magazine/a762winter
	name = "Inverno Genocídio universal magazine (7.62)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "ingen"
	base_icon_state = "ingen"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = CALIBER_A762
	max_ammo = 35
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/a762winter/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 35 : 0]"

/obj/item/ammo_box/magazine/a54539abyss
	name = "Abyss-Platform universal magazine (5.4539)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "abrifle"
	base_icon_state = "abrifle"
	ammo_type = /obj/item/ammo_casing/a54539abyss
	caliber = CALIBER_ABYSS
	max_ammo = 30
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/a54539abyss/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 30 : 0]"

/obj/item/ammo_box/magazine/a49234g11
	name = "Unwieldly O Guloseim magazine (4.92x34mm)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "grifle"
	base_icon_state = "grifle"
	ammo_type = /obj/item/ammo_casing/a49234g11
	caliber = CALIBER_UNCONVENTIONAL
	max_ammo = 55
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/a49234/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 55 : 0]"

/obj/item/ammo_box/magazine/a556steyr
	name = "Advanced Combat Rifle annular-primed flechette magazine (5.56×45mm)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "urifle"
	base_icon_state = "urifle"
	ammo_type = /obj/item/ammo_casing/a556steyr
	caliber = CALIBER_FLECHETTE
	max_ammo = 24
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/a556f/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 24 : 0]"
