/obj/item/clothing/accessory
	name = "Accessory"
	desc = "Something has gone wrong!"
	icon = 'icons/obj/clothing/accessories.dmi'
	worn_icon = 'icons/mob/clothing/accessories.dmi'
	icon_state = "plasma"
	inhand_icon_state = "" //no inhands
	slot_flags = 0
	w_class = WEIGHT_CLASS_SMALL
	/// Whether or not the accessory displays through suits and the like.
	var/above_suit = FALSE
	/// TRUE if shown as a small icon in corner, FALSE if overlayed
	var/minimize_when_attached = TRUE
	/// Whether the accessory has any storage to apply to the clothing it's attached to.
	var/datum/component/storage/detached_pockets
	/// What equipment slot the accessory attaches to.
	var/attachment_slot = CHEST
