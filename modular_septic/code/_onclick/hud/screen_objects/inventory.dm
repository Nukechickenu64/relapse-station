/atom/movable/screen/inventory
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_full = "occupied"

/atom/movable/screen/inventory/add_overlays()
	var/mob/user = hud?.mymob

	if(!user || !slot_id)
		return

	var/obj/item/our_item = user.get_item_by_slot(slot_id)
	if(our_item)
		our_item.apply_outline()
		return

	var/obj/item/holding = user.get_active_held_item()
	if(!holding)
		return

	var/image/item_overlay = image(holding)
	item_overlay.alpha = 92

	if(!user.can_equip(holding, slot_id, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		item_overlay.color = "#FF0000"
	else
		item_overlay.color = "#00ff00"

	cut_overlay(object_overlay)
	object_overlay = item_overlay
	add_overlay(object_overlay)

/atom/movable/screen/inventory/MouseExited()
	. = ..()
	var/mob/user = hud?.mymob
	if(slot_id)
		var/obj/item/our_item = user?.get_item_by_slot(slot_id)
		if(our_item)
			our_item.remove_filter("hover_outline")

/atom/movable/screen/inventory/hand
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_full = null
