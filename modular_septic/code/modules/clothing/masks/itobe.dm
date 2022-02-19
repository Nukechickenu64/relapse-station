/obj/item/clothing/mask/gas/itobe
	name = "\proper ITOBE Solider balaclava"
	desc = "ITOBE Solider's, or more enthusiastically, Soldat, as they are called due to their specialized techniques wore this balaclava in combat to highlight their augmenting eyepiece, wearing it without an eyepiece would just make you look like a fool."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "soldat"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "soldat"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	armor = list(MELEE = 5, BULLET = 15, LASER = 0, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50, WOUND = 0)

/obj/item/clothing/head/welding/itobe
	name = "engineering mask and helmet"
	desc = "A dual-layered ballistic mask made of plasteel and titanium. Its uniquely shaped yellow visor provides engineering readouts and other useful data. Not entirely useless for ballistic protection."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "engineer"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "engineer"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "engineermask"
	tint = null
	body_parts_covered = FACE|JAW|HEAD|EYES
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 21, \
                CRUSHING = 10, \
                CUTTING = 10, \
                PIERCING = 25, \
                IMPALING = 5, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 30, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
