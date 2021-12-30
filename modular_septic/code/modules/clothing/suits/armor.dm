/obj/item/clothing/suit/armor
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest
	name = "slim type 1 armor vest"
	desc = "A slim version of the type I armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_slim"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_slim"
	//A decent kevlar vest weighs almost 3kg
	carry_weight = 3
	//But does not cover the groin
	body_parts_covered = CHEST

/obj/item/clothing/suit/armor/vest/alt
	name = "type 1 armor vest"
	desc = "A type I armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest"
	//Bulkier vest
	carry_weight = 6
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest/heavy
	name = "type 3 armor vest"
	desc = "A type 3 armored vest that provides intermediate protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_heavy"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_heavy"
	//Bulkierer vest
	carry_weight = 8
	body_parts_covered = CHEST|GROIN
