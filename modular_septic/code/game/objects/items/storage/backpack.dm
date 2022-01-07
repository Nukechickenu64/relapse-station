/obj/item/storage/backpack
	slowdown = 0
	storage_flags = STORAGE_NO_WORN_ACCESS
	carry_weight = 3
	pickup_sound = 'modular_septic/sound/armor/equip/backpack_pickup.wav'
	drop_sound = 'modular_septic/sound/armor/equip/backpack_drop.wav'

/obj/item/storage/backpack/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.rustle_sound = 'modular_septic/sound/armor/equip/backpack_use.wav'

/obj/item/storage/backpack/satchel
	slowdown = 0
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	storage_flags = NONE
	carry_weight = 1.5

/obj/item/storage/backpack/satchel/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 12

/obj/item/storage/backpack/duffelbag
	slowdown = 0
	storage_flags = STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS
	carry_weight = 3

/obj/item/storage/backpack/duffelbag/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 32

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 10

/obj/item/storage/backpack/holding/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 38

/obj/item/storage/backpack/leather
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "leather_backpack"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "leather_backpack"

/obj/item/storage/backpack/satchel/leather
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "leather_satchel"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "leather_satchel"
