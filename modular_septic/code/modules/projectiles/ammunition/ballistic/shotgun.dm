// Rubbershot buff too
/obj/item/ammo_casing/shotgun/rubbershot
	pellets = 12
	variance = 4

// Buckshot buff i guess
/obj/item/ammo_casing/shotgun/buckshot
	pellets = 8
	variance = 4.5

/obj/item/ammo_casing/shotgun/flechette
	name = "shotgun flechette"
	desc = "A 12 gauge steel flechette. Contains 20 indevidual projectiles"
	icon = 'modular_septic/icons/obj/items/ammo/shotgun.dmi'
	icon_state = "fshell"
	worn_icon_state = "shell"
	pellets = 20
	variance = 18.5
	projectile_type = /obj/projectile/bullet/pellet/shotgun_flechette

/obj/item/ammo_casing/shotgun/ap
	name = "shotgun armor-piercing slug"
	desc = "A 12 gauge solid steel armor-piercing slug. \
	There's a label on the shell itself, AP-20"
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	icon_state = "apshell"
	worn_icon_state = "shell"
	projectile_type = /obj/projectile/bullet/shotgun_ap

