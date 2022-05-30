/obj/item/money
	name = "money"
	desc = "We don't live in a cashless society."
	icon = 'modular_septic/icons/obj/items/money.dmi'
	w_class = WEIGHT_CLASS_TINY
	carry_weight = 0.05
	/// World icon we should use
	var/world_icon = 'modular_septic/icons/obj/items/money_world.dmi'
	/// If this is a coin, it shows at the bottom right when stacking
	var/is_coin = FALSE
	/// Stack of money, we can't stack and create another stack that is stupid
	var/is_stack = FALSE
	/// How many pence this is worth
	var/pences_worth = 1

/obj/item/money/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/world_icon, .proc/update_icon_world)

/obj/item/money/examine(mob/user)
	. = ..()
	var/value = get_item_credit_value()
	. += "[p_they(TRUE)] [p_are()] worth [value] pence."
	if(!LAZYLEN(contents))
		return
	var/list/money_counter = list()
	for(var/obj/item/money/money in src)
		if(money_counter[money.name])
			money_counter[money.name] += 1
		else
			money_counter[money.name] = 1
	for(var/money_name in money_counter)
		var/amount = money_counter[money_name]
		. += span_info("- [money_name][amount > 1 ? " x[amount]" : ""]")

/obj/item/money/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(!ismoney(attacking_item))
		return
	var/obj/item/money/money = attacking_item
	var/obj/item/money/stack/real_stack
	if(!is_stack)
		if(!money.is_stack)
			real_stack = new(drop_location())
			user.transferItemToLoc(src, real_stack, silent = TRUE)
			user.transferItemToLoc(money, real_stack, silent = TRUE)
			user.put_in_hands(real_stack)
			var/stack_sound = 'modular_septic/sound/items/money_stack.wav'
			if(money.is_coin)
				stack_sound = 'modular_septic/sound/items/coin_stack.wav'
			playsound(real_stack, stack_sound, 60)
		else
			real_stack = money
			user.transferItemToLoc(real_stack, drop_location(), silent = TRUE)
			user.transferItemToLoc(src, real_stack, silent = TRUE)
			user.put_in_hands(real_stack)
			var/stack_sound = 'modular_septic/sound/items/money_stack.wav'
			if(money.drop_sound == 'modular_septic/sound/items/coin_drop.wav')
				stack_sound = 'modular_septic/sound/items/coin_stack.wav'
			else if(money.drop_sound == 'modular_septic/sound/items/money_and_coin_drop.wav')
				stack_sound = 'modular_septic/sound/items/money_and_coin_stack.wav'
			playsound(real_stack, stack_sound, 60)
	else
		if(!money.is_stack)
			real_stack = src
			user.transferItemToLoc(real_stack, drop_location(), silent = TRUE)
			user.transferItemToLoc(money, real_stack, silent = TRUE)
			user.put_in_hands(real_stack)
			var/stack_sound = 'modular_septic/sound/items/money_stack.wav'
			if(money.is_coin)
				stack_sound = 'modular_septic/sound/items/coin_stack.wav'
			playsound(real_stack, stack_sound, 60)
		else
			real_stack = src
			user.transferItemToLoc(money, drop_location(), silent = TRUE)
			user.transferItemToLoc(real_stack, drop_location(), silent = TRUE)
			for(var/obj/item/money/cash_money in money)
				user.transferItemToLoc(cash_money, real_stack, silent = TRUE)
			user.put_in_hands(real_stack)
			var/stack_sound = 'modular_septic/sound/items/money_stack.wav'
			if(money.drop_sound == 'modular_septic/sound/items/coin_drop.wav')
				stack_sound = 'modular_septic/sound/items/coin_stack.wav'
			else if(money.drop_sound == 'modular_septic/sound/items/money_and_coin_drop.wav')
				stack_sound = 'modular_septic/sound/items/money_and_coin_stack.wav'
			playsound(real_stack, stack_sound, 60)
			qdel(money)
	if(!real_stack)
		return
	var/has_coin = FALSE
	var/has_note = FALSE
	for(var/obj/item/money/cash in real_stack)
		if(cash.is_coin)
			has_coin = TRUE
		else
			has_note = TRUE
		if(has_coin && has_note)
			break
	if(has_coin && has_note)
		real_stack.drop_sound = 'modular_septic/sound/items/money_and_coin_drop.wav'
	else if(has_coin)
		real_stack.drop_sound = 'modular_septic/sound/items/coin_drop.wav'
	else
		real_stack.drop_sound = 'modular_septic/sound/items/money_drop.wav'
	real_stack.update_appearance()

/obj/item/money/attack_self(mob/user, modifiers)
	. = ..()
	if(!is_stack)
		return
	for(var/obj/item/money/money in src)
		if(user.transferItemToLoc(money, drop_location()))
			if(!(locate(/obj/item/money) in src))
				qdel(src)
			user.put_in_hands(money)
			break
	update_appearance()

/obj/item/money/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!is_stack)
		return
	for(var/obj/item/money/money in src)
		money.forceMove(loc)
		money.throw_at(loc)
	qdel(src)

/obj/item/money/get_item_credit_value()
	return pences_worth

/obj/item/money/update_icon(updates)
	icon = initial(icon)
	cut_overlays()
	return ..()

/obj/item/money/update_icon_state()
	. = ..()
	icon_state = base_icon_state

/obj/item/money/proc/update_icon_world()
	icon = world_icon
	icon_state = base_icon_state
	return UPDATE_ICON_STATE | UPDATE_OVERLAYS
