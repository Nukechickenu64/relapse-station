/obj/item/clothing/mask/gas/ordinator
	name = "\proper ordinator's iron mask"
	desc = "Standard issue ordinator iron mask. Lightly armored, but very intimidating."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "ordinator_mask"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "ordinator_mask"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
	body_parts_covered = FACE
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 50, WOUND = 0)
	custom_materials = list(/datum/material/iron = 150, /datum/material/plastic = 250)
	w_class = WEIGHT_CLASS_SMALL
	carry_weight = 1

/obj/item/clothing/mask/gas/ordinator/coordinator
	name = "\proper coordinator's golden mask"
	desc = "An armored golden mask worn by the second greatest clown in town. Smells of bananas."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "coordinator_mask"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "coordinator_mask"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "coordinator_mask"
	custom_materials = list(/datum/material/gold = 100, /datum/material/iron = 150, /datum/material/plastic = 250)

/obj/item/clothing/mask/gas/ordinator/slaughter
	name = "\proper slaughter mask"
	desc = "Mask used by agents commonly known to dodge bullets, recover their guns quickly, and get their jaw punched off by Czech maniacs with dementia."
	icon = 'modular_septic/icons/obj/clothing/masks.dmi'
	icon_state = "agent_balaclava"
	worn_icon = 'modular_septic/icons/mob/clothing/mask.dmi'
	worn_icon_state = "agent_balaclava"
	armor = list(MELEE = 5, BULLET = 15, LASER = 0, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50, WOUND = 0)
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_mask"
