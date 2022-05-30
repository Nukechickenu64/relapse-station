/obj/item/money/stack
	name = "stack of money"
	desc = "Money for nothing, chicks for free."
	drop_sound = 'modular_septic/sound/items/money_drop.wav'
	icon = 'modular_septic/icons/obj/items/money.dmi'
	icon_state = ""
	base_icon_state = ""
	item_flags = NO_PIXEL_RANDOM_DROP
	w_class = WEIGHT_CLASS_SMALL
	carry_weight = 0
	is_stack = TRUE
	pences_worth = 0

/obj/item/money/stack/get_item_credit_value()
	. = ..()
	for(var/obj/item/money/money in src)
		. += money.get_item_credit_value()

/obj/item/money/stack/update_overlays()
	. = ..()
	var/note_pixel_y = 0
	for(var/obj/item/money/money in src)
		if(money.is_coin)
			continue
		var/mutable_appearance/overlay = mutable_appearance(icon, money.base_icon_state)
		overlay.pixel_y = note_pixel_y
		note_pixel_y += 2
		. += overlay
	for(var/obj/item/money/coin in src)
		if(!coin.is_coin)
			continue
		var/mutable_appearance/overlay = mutable_appearance(world_icon, coin.base_icon_state)
		overlay.pixel_x = rand(4, 11)
		overlay.pixel_y = rand(-11, -4)
		. += overlay

/obj/item/money/stack/update_icon_world()
	. = ..()
	cut_overlays()
	for(var/obj/item/money/money in src)
		var/mutable_appearance/overlay = mutable_appearance(icon, money.base_icon_state)
		overlay.transform = overlay.transform.Turn(rand(0, 360))
		overlay.pixel_x = rand(-12, 12)
		overlay.pixel_y = rand(-12, 12)
		add_overlay(overlay)
