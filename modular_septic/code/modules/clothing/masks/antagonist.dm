/obj/item/clothing/mask/denominator
	name = "denominators armored mask"
	desc = "A mask with some ceramic plating put underneath the metal surface; technically classified under type II ballistic protection."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "deno"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	worn_icon_state = "deno"
	max_integrity = 200
	limb_integrity = 190
	repairable_by = /obj/item/stack/ballistic/plate
	repairable_by_offhand = null
	integrity_failure = 0.1
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 35, \
                CRUSHING = 13, \
                CUTTING = 15, \
                PIERCING = 35, \
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
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy_helmet"
	armor_damaged_sound_local = "heavy_helmet"
	carry_weight = 2.5 KILOGRAMS
	equip_sound = 'modular_septic/sound/armor/equip/helmet_use.ogg'
	pickup_sound = 'modular_septic/sound/armor/equip/helmet_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/helmet_drop.ogg'
	body_parts_covered = HEAD|FACE|JAW|EYES|NECK
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEEYES
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT|HIDEEYES
	lowers_pitch = TRUE
