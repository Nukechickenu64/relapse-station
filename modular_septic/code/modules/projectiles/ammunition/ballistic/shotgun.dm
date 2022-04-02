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
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
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
	projectile_type = /obj/projectile/bullet/shotgun_slug/ap

/obj/item/ammo_casing/shotgun/bolas
	name =	"Consumidor de Buceta 4 guage slug"
	desc = "A 4 guage destructive slug designed with the purpose of destroying armored structures at a range. But It can destroy flesh, too."
	caliber = CALIBER_KS23
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	icon_state = "pussyshell"
	worn_icon_state = "shell"
	projectile_type = /obj/projectile/bullet/shotgun_bolas

/obj/item/ammo_casing/shotgun/bolas/buckshot
	name =	"Estuprador-3 4 guage buckshot"
	desc = "A 4 guage anti-personel buckshot shell for the sole purpose of completely fucking obliterating soft tissue from close range."
	caliber = CALIBER_KS23
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	icon_state = "asshell"
	worn_icon_state = "shell"
	pellets = 10
	variance = 10
	projectile_type = /obj/projectile/bullet/pellet/shotgun_bolas/buckshot

/obj/item/ammo_casing/shotgun/Initialize(mapload)
	. = ..()
	if(prob(1))
		playsound(src, 'modular_septic/sound/weapons/faggot.ogg', 50, FALSE)
		name = "reggie slug"
		desc = "Hi, my name is Reggie, I like penetrating IIIA body armor."
