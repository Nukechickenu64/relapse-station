/obj/item/money
	name = "money"
	desc = "We don't live in a cashless society."
	icon = 'modular_septic/icons/obj/items/money.dmi'
	w_class = WEIGHT_CLASS_TINY
	carry_weight = 0.05
	/// If this is a coin, it shows at the bottom right when stacking
	var/is_coin = FALSE
	/// How many pence this is worth
	var/pences_worth = 1

/obj/item/money/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/world_icon, .proc/update_icon_world)

/obj/item/money/examine(mob/user)
	. = ..()
	var/value = get_item_credit_value()
	. += span_notice("[p_they(TRUE)] [p_are()] worth [value] pence.")

/obj/item/money/get_item_credit_value()
	return pences_worth

/obj/item/money/update_icon(updates)
	. = ..()
	icon = initial(icon)

/obj/item/money/proc/update_icon_world()
	icon = 'modular_septic/icons/obj/items/money_world.dmi'
	icon_state = base_icon_state
	return UPDATE_ICON_STATE | UPDATE_OVERLAYS
