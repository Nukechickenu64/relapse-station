/obj/item/ammo_casing/l40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_40MM
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	bounce_sound = list('modular_septic/sound/weapons/guns/launcher/heavy_shell1.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell2.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell3.wav')
	bounce_volume = 65
	icon_state = "40mmHE"
	projectile_type = /obj/projectile/bullet/l40mm
	stack_type = null

/obj/item/ammo_casing/l40mm/poop
	name = "40mm IG shell"
	desc = "An incredibly gassy grenade."
	caliber = CALIBER_40MM
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	bounce_sound = list('modular_septic/sound/weapons/guns/launcher/heavy_shell1.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell2.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell3.wav')
	bounce_volume = 65
	icon_state = "40mmPOOP"
	projectile_type = /obj/projectile/bullet/gas40mm
	stack_type = null

/obj/item/ammo_casing/l40mm/smoke
	name = "40mm SMK shell"
	desc = "A cased grenade that deploys smoke in an area, can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_40MM
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	bounce_sound = list('modular_septic/sound/weapons/guns/launcher/heavy_shell1.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell2.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell3.wav')
	bounce_volume = 65
	icon_state = "40mmGAS"
	projectile_type = /obj/projectile/bullet/smoke40mm
	stack_type = null
