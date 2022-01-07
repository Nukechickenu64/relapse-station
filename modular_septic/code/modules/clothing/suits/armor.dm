/obj/item/clothing/suit/armor
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest
	name = "slim type II armor vest"
	desc = "A slim version of the type I armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_slim"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_slim"
	subarmor = list(ARMOR_FLAGS = ARMOR_FLEXIBLE, \
                EDGE_PROTECTION = 40, \
                CRUSHING = 13, \
                CUTTING = 15, \
                PIERCING = 34, \
                IMPALING = 5, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	//A decent kevlar vest weighs almost 3kg
	//But does not cover the groin
	carry_weight = 3
	body_parts_covered = CHEST
	equip_sound = 'modular_septic/sound/armor/equip/armor_use.wav'
	pickup_sound = 'modular_septic/sound/armor/equip/armor_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/armor_drop.wav'

/obj/item/clothing/suit/armor/vest/alt
	name = "type II armor vest"
	desc = "A type II armored vest that provides decent protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest"
	//Bulkier vest
	carry_weight = 6
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest/medium
	name = "\"Escapado\" type III+ armor vest"
	desc = "A type III+ armored vest that provides intermediate ballistic protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest"
	subarmor = list(ARMOR_FLAGS = ARMOR_FLEXIBLE, \
                EDGE_PROTECTION = 58, \
                CRUSHING = 19, \
                CUTTING = 18, \
                PIERCING = 42, \
                IMPALING = 6, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 8, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	carry_weight = 6.5
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest/heavy
	name = "\"Defesa Total\" type IV armor vest"
	desc = "A type IV armored vest that provides intermediate ballistic protection against most types of damage."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "armorvest_heavy"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "armorvest_heavy"
	subarmor = list(ARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 72, \
                CRUSHING = 22, \
                CUTTING = 24, \
                PIERCING = 50, \
                IMPALING = 14, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 13, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	//Bulkierer vest
	carry_weight = 8
	body_parts_covered = CHEST|GROIN
